use AppleScript version "2.4" -- Yosemite (10.10) or lateruse scripting additions


set backupClipboard to the clipboardtell application "Firefox" to activate

tell application "System Events"	keystroke "lc" using command downend tellset newLink to (the clipboard as string)

set the clipboard to backupClipboard
tell application "Things3" to show quick entry panel with properties {notes: newLink}
