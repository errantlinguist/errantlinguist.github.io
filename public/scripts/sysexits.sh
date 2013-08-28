#!/bin/sh

#
# Copyright (c) 1987, 1993
#	The Regents of the University of California.  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 4. Neither the name of the University nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
#	@(#)sysexits.h	8.1 (Berkeley) 6/2/93
#


readonly EX_OK=0	 # successful termination

readonly EX__BASE=64	 # base value for error messages

readonly EX_USAGE=64	 # command line usage error
readonly EX_DATAERR=65	 # data format error
readonly EX_NOINPUT=66	 # cannot open input
readonly EX_NOUSER=67	 # addressee unknown
readonly EX_NOHOST=68	 # host name unknown
readonly EX_UNAVAILABLE=69 # service unavailable
readonly EX_SOFTWARE=70    # internal software error
readonly EX_OSERR=71       # system error (e.g., can't fork)
readonly EX_OSFILE=72      # critical OS file missing
readonly EX_CANTCREAT=73   # can't create (user) output file
readonly EX_IOERR=74       # input/output error
readonly EX_TEMPFAIL=75    # temp failure; user is invited to retry
readonly EX_PROTOCOL=76    # remote error in protocol
readonly EX_NOPERM=77      # permission denied
readonly EX_CONFIG=78      # configuration error

readonly EX__MAX=78        # maximum listed value
