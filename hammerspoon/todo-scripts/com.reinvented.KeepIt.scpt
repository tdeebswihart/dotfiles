tell application "Keep It"
	set theSelection to the selected items
	if length of theSelection = 1 then
		set theItem to the first item of theSelection
		set itemName to name of theItem
		set itemLink to "keepit://link?item=" & id of theItem
		tell application "Things3" to show quick entry panel with properties {name:itemName, notes:itemLink}
	else
		repeat with theItem in theSelection
			set itemName to name of theItem
			set itemLink to link URL of theItem
			tell application "Things3" to make new to do with properties {name:"Look at " & itemName, notes:itemLink}
		end repeat
	end if
end tell
