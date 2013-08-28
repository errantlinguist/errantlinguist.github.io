#!/bin/sh

# Utility functions for formatting data into a human-readable tabular format and echoing it to an output stream (e.g. standard output).
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


# Prints a given list of parameter arguments to the standard output stream, joined by a given separator.
#
# Param $1: The separator to use when joining the arguments.
# Params $2...n: The arguments to join and print.
print_joined_args()
{
	# Get the separator
	separator="$1"
	shift

	# Get the first argument to join
	result="$1"
	shift

	# Join the rest of the arguments
	for arg in "$@"
	do
		result="$result$separator$arg"
	done

	printf "%b" "$result"
}

# Prints a given list of rows of data to the standard output stream, each on a separate line.
#
# Param $1: The separator to use when joining the row cells.
# Params $2...n: The rows to print.
print_rows()
{
	# Get the separator
	separator="$1"
	shift	

	for row in "$@"
	do
		printf "%b\n" "$(print_joined_args "$separator" "$row")"
	done
}
