#! /bin/bash
in *.tif; do convert "$i" "{i/.tif}".png; done 

