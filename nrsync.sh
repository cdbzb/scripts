#! /bin/bash


#/usr/local/bin/rsync -aNHAXx --fileflags --protect-decmpfs --force-change -v /Volumes/Zippy/puddle/$1/ /Volumes/Archive/$1/
/usr/local/bin/rsync -rlptoDNHAXx --fileflags --protect-decmpfs --force-change --delete -v  "$1" "$2"
