#!/bin/bash

# script to half duration of lily input

# change x4 to x2 globally...

 sed -e 's/\([a-z]*\)4/\12/g' \
-e 's/\([a-z]*\)8/\14/g' \
-e 's/\([a-z]*\)16/\18/g'
