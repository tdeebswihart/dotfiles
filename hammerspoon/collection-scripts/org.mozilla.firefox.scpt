use AppleScript version "2.4" -- Yosemite (10.10) or lateruse scripting additions


set backupClipboard to the clipboardtell application "Firefox" to activate

tell application "System Events"	keystroke "lc" using command downend tellset newLink to (the clipboard as string)

set the clipboard to backupClipboardtell application "Keep It"			repeat until top level folder is not missing value		delay 1	end repeat
	add link newLink
end tell
