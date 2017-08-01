#! /bin/bash

osascript <<'END'
set x to "Again"
tell application "QuickTime Player"
	activate
	repeat while x = "Again"
		tell (new movie recording)
			start
			set returnedItems to display dialog "Good?" buttons {"Good", "Again"} default button "Again"
			set x to the button returned of returnedItems
			if x = "Again" then tell application "QuickTime Player"
				close front window
			end tell
			if x = "Good" then stop
			tell application "QuickTime Player"
				set myname to front window's name as text
			end tell
			tell application "TextEdit"
				activate
				set the text of the front document to myname
			end tell
		end tell
	end repeat
END
