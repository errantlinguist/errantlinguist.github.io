#!/bin/sh

# Utility functions for more easily creating, sourcing and using shell scripts.
#
# AUTHOR: Todd Shore
# VERSION: 2013-02-16
# WEBSITE: https://github.com/errantlinguist/scripts
#
# Copyright 2013 Todd Shore
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Constants --------------------------------------------------------------------

# Shell Boolean values, taken from the corresponding built-in commands.
if test -z "$FALSE"
then
	false
	readonly FALSE=$?
fi
if test -z "$TRUE"
then
	true
	readonly TRUE=$?
fi

# Exit status constants matching those in BSD's sysexits.h
if test -z "$EX_NOINPUT"
then
	readonly EX_NOINPUT=66	 # cannot open input
fi

# Scripting utility functions --------------------------------------------------

# Prints the full path of a given executable to the standard output stream, returning the actual executable path, e.g. if it was not at the given path but was found on the shell path instead.
#
# Param $1: The executable to find.
find_and_print_executable_path()
{
	result=""
	# Check if the executable is available as-is
	if is_command_available "$1"
	then
		result="$1"
	else
		# Check if the executable is in the working directory
		local_file="./$1"
		if is_command_available "$local_file"
		then
			result="$local_file"
		else
			# Check if the executable is available via the shell path
			file_basename=${1##*/}
			if is_command_available "$file_basename"
			then
				result="$file_basename"
			fi
		fi	
	fi

	printf "%b" "$result"
}

# Checks if a given command is available via the system path.
#
# Param $1: The command to check.
is_command_available()
{
	test "$(command -v $1)$1" != "$1"
}

# Tries to source a given shell script using a given path; if it cannot be sourced from the path as it is given,
# an attempt to source the file from the working directory is made, and then finally it is attempted via the shell
# path. If this then fails, it exits the script with an error message.
#
# Param $1: The path to try sourcing from.
source_gracefully()
{
	executable_path=$(find_and_print_executable_path "$1")
	# Check if the file is available as-is
	if test -n "$executable_path"
	then
		. "$executable_path"
	else
		printf "Could not source the file \"%b\";\nCheck that either it is available at the given path, it is on the shell path or it is in the working directory and that it is executable.\n" \
		"$1"
		exit $EX_NOINPUT
	fi	
}
