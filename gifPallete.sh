#!/bin/sh

echo "in out start dur scale delay"
input=$1
output=$2
start_time=$3
duration=$4
scale=$5
delay=$6
fps=$7

palette="/tmp/palette.png"

filters="fps=$fps,scale=$scale:-1:flags=lanczos"
#filters="fps=15,scale=320:-1:flags=lanczos"

ffmpeg -v warning -ss $start_time -t $duration -i $input -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -ss $start_time -t $duration -i $input -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $output

gifsicle --batch -d$delay $output --optimize=3 --loopcount=8 


