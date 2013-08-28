#!/bin/sh

# Applies a given command to all files matching a given pattern. There are other, more elegant ways to do this on *nix systems, but this has all the functionalities required
# while using no non-POSIX commands and as few external commands as possible in order to maximize cross-platform compatibility.
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
if test -z "$EX_USAGE"
then
	readonly EX_USAGE=64   # command line usage error
fi
if test -z "$EX_NOINPUT"
then
	readonly EX_NOINPUT=66 # cannot open input
fi

# The delimiter used for columns of the usage description.
readonly COLUMN_DELIMITER="\t\t"


# Scripting utility functions --------------------------------------------------

if ! test "$(command -v is_command_available)is_command_available" != "is_command_available"
then
	# Checks if a given command is available via the system path.
	#
	# Param $1: The command to check.
	is_command_available()
	{
		test "$(command -v $1)$1" != "$1"
	}
fi

if ! is_command_available "find_and_print_executable_path"
then
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
fi

if ! is_command_available "source_gracefully"
then
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
fi


# Sources ----------------------------------------------------------------------

source_gracefully ./print_table.sh


# Functions --------------------------------------------------------------------

# Executes a given command on the files contained in a given directory recursively.
#
# Param $1: The command to execute.
# Param $2: The directory of files to execute the command on.
do_on_directory_recursively()
{
	subdir_pattern="$2/*"
	do_on_paths_recursively "$1" $subdir_pattern
}

# Executes a given command on a given list of paths recursively, i.e. if a path points to a directory, all sub-paths of that subdirectory are also used as paths to execute the command on.
#
# Param $1: The command to execute.
# Params $2...n: The paths to execute the command on.
do_on_paths_recursively()
{
	# Set the command to execute
	cmd="$1"
	shift

	# Execute the command on each path supplied as an argument
	for path in "$@"
	do
		if test -d "$path"
		then
			do_on_directory_recursively "$cmd" "$path"
		else
			"$cmd" "$path"
		fi

		# If the function returned with something other than an OK status, break out of the loop early and quit
		if test $? -ne $TRUE
		then
			return $?
		fi	
	done
}


# Executes a given command on a given list of paths.
#
# Param $1: The command to execute.
# Params $2...n: The paths to execute the command on.
do_on_paths()
{
	# Set the command to execute
	cmd="$1"
	shift

	# Execute the command on each path supplied as an argument
	for path in "$@"
	do
		"$cmd" "$path"
		# If the function returned with something other than an OK status, break out of the loop early and quit
		if test $? -ne $TRUE
		then
			return $?
		fi	
	done
}

# Prints a given description of an option for a given list of option argument variants to the standard output stream.
#
# Param $1 A string representing a list of option argument variants, e.g. "r R" for option variants -r and -R.
# Param $2 The description of the option.
print_option()
{
	print_row "$(print_option_variants $1)" "$2"
}


# Prints a given list of option argument variants to the standard output stream.
#
# Params $1...n: A list of individual option variants, e.g. "r" "R" for option variants -r and -R.
print_option_variants()
{
	result="-$1"	# Create the string head starting with the first option variant
	shift	# Remove the first option variant from the argument list
	# Concatenate any following variants
	for opt_variant in "$@"
	do
		result="$result -$opt_variant"
	done

	printf "%b" "$result"
}

# Prints a description of all command-line options to the standard output stream.
print_options()
{
	print "Options:"
	print_rows \
		"$COLUMN_DELIMITER" \
		"$(print_option "h H" "display this help and exit")" \
		"$(print_option "r R" "operate on files and directories recursively")"
}

# Prints a given row of cell data to the standard output stream, each separated by a delimiter.
#
# Params $1...n: The row cells to print.
print_row()
{
	print_joined_args "$COLUMN_DELIMITER" "$@"
}

# Prints usage information to the standard output stream.
print_usage()
{
	printf "Usage: %s [%s] %s\n" \
		"$(basename $0)" \
		"-hHrR" \
		"COMMAND PATTERN"
	print_options
}

# Prints a usage message to the standard error output stream and exits with a given exit status.
#
# Param $1: The status to exit with (optional).
exit_usage()
{
	# If there was an exit status given and the exit status does not represent success, print to the standard error output stream
	if test $# -gt 1 && test $1 -ne $TRUE
	then
		print_usage >&2
		exit $1
	else
	# Else, print to the standard output stream
		print_usage
		exit
	fi
}

# Main procedure ---------------------------------------------------------------

# Functionality is non-recursive by default
is_recursive=$FALSE

# Parse optional command-line parameters
while getopts ":hHrR" opt;
	do
		case $opt in
			r | R	) is_recursive=$TRUE;;
			h | H	) exit_usage;;
			*	)
					printf "Invalid option: -%s\n" "$OPTARG" >&2;
					exit_usage $EX_USAGE;;
  		esac
	done

# Shift all parsed optional arguments away
shift $(($OPTIND - 1))

# Parse command-line parameters

# Check that the minimum number of arguments was specified
if test $# -lt 2
then
	exit_usage $EX_USAGE
else
	# Check that the first argument is a valid command
	if ! is_command_available $1
	then
		printf "\"%s\" is not a valid command.\n" "$1" >&2
		exit_usage $EX_NOINPUT
	else
		# Check that the second argument is a valid path
		if test ! -e $2
		then
			printf "\"%s\" is not a valid pattern matching any files or directories.\n" "$2" >&2
			exit_usage $EX_NOINPUT
		else
			# Check if the function is set to work recursively
			if test $is_recursive
			then
				do_on_paths_recursively "$@"
			else
				do_on_paths "$@"
			fi
			
		fi
	fi
fi
