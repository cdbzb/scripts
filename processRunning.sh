#!/bin/bash
PROCESS=kwm
number=$(ps aux | grep $PROCESS | wc -l)

if [ $number -gt 1 ]
    then
	    echo $number
        echo Running;
fi

