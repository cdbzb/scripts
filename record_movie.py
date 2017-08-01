import os

#An example of the HEREDOC method
cmd = """osascript<<END
tell application "iTunes"
play playlist "Party Shuffle"
end tell
END"""

def play_iTunes():
     os.system(cmd)

play_iTunes()

