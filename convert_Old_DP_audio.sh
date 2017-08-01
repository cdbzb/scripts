#!/bin/bash
sox  --ignore-length -b 24 -B -c1 -r 44100 -t raw -e signed-integer  "$1" "$1".aif



