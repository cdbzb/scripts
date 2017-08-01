#! /bin/bash

read -p "name? " name
a=$(GetFileInfo -d "$1" | cut -d " " -f 2)
timecode='00:'"$a"
base=$(basename "$1" ".mov")
echo ffmbc -i "$1" -timecode "$timecode" MOV/"$name"_"$base".mov  
