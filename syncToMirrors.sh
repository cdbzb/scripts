#! /bin/bash


#/usr/local/bin/rsync -aNHAXx --fileflags --protect-decmpfs --force-change -v /Volumes/Zippy/puddle/$1/ /Volumes/Archive/$1/
osascript ~/scripts/mount-Mirrors.scpt
/usr/local/bin/rsync -rlptoDNHAXx --fileflags --protect-decmpfs --force-change --delete -v /Volumes/"$1"/ /Volumes/Mirrors/"$1"/
