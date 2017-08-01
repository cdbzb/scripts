#! /bin/bash

ffmpeg -i $1 -pix_fmt yuv420p -vcodec mjpeg -qscale 1 $2
