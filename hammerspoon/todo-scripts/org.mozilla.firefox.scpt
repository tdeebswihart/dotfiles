use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

set backupClipboard to the clipboard

tell application "Firefox" to activate
tell application "System Events"
  keystroke "l" using command down
  keystroke "c" using command down
  delay 0.5
end tell

tell application "Things3" to show quick entry panel with properties {notes:(the clipboard as string)}

set the clipboard to backupClipboard
