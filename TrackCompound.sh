#! /bin/bash
/Users/michael/scripts/TrackUtility.js "$@"

InjectedAction=`cat '/Users/michael/Library/Application Support/REAPER/Data/Main_Actions_Cat' | grep Code | cut -f 2`
echo $InjectedAction | python3.4 "/Users/michael/scripts/python-osc-client.py"

