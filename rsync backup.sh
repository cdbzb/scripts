#!/bin/sh
# Usage: rsync-backup.sh <src> <dst> <label>
if [ "$#" -ne 3 ]; then
    echo "$0: Expected 3 arguments, received $#: $@" >&2
    exit 1
fi
if [ -d "$2/__prev/" ]; then
    /usr/local/bin/rsync -rlptoDNHAXx --fileflags --protect-decmpfs --force-change -v --delete --link-dest="$2/__prev/" "$1" "$2/$3"
else
    /usr/local/bin/rsync -rlptoDNHAXx --fileflags --protect-decmpfs --force-change -v --delete  "$1" "$2/$3"
fi
rm -f "$2/__prev"
ln -s "$3" "$2/__prev"
