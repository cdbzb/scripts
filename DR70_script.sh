#! /bin/bash

mount-home.sh
cd /Volumes/DR-70D/MUSIC/
read -p "name? " name

function getDate { 
	bwftool $1 | grep "Date" | sed  ' s/OriginationDate *: 20//' 
}

function getTime { 
bwftool $1 | grep "nTime" | sed -e ' s/OriginationTime *: //'  -e 's/\(.*\):\(.*\):.*/\1\2/'
}

function stripNum {
	echo $1 | sed 's/[A-Z]*_[0-9]*//'
}

for file in $(ls)
do

	a=$(basename `stripNum $file` .wav )
	b=$(getDate $file)
	c=$(getTime $file)

	mv $file /Volumes/home-1/DR70/"$name"\ "$b"_"$c"\ "$a".wav
done
