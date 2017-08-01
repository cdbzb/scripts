#! /bin/bash

read -p "name? " name

function getTime { 
	GetFileInfo -f $1 | cut -d " " 2
}


function stripNum {
	echo $1 | sed 's/[A-Z]*_[0-9]*//'
}

mkdir MOV

for file in *.mov
do
	a=$(GetFileInfo -d "$file" | cut -d " " -f 2)
	timecode='00:'"$a"
	base=$(basename $file ".mov")
	ffmbc -i "$file" -timecode "$timecode" MOV/$name_"$base".mov  
done
