#! /bin/bash


#/usr/local/bin/rsync -aNHAXx --fileflags --protect-decmpfs --force-change -v /Volumes/Zippy/puddle/$1/ /Volumes/Archive/$1/
osascript ~/scripts/MountPuddle_mirror.scpt
/usr/local/bin/rsync -rlptoDNHAXx --fileflags --protect-decmpfs --force-change --delete -v /Volumes/Zippy/puddle/"$1"/ /Volumes/puddle_mirror/"$1"/
