set bound to {}
tell application "Slack"
	# 全ウィンドウループ
	repeat with w in windows
		# windowの名前が電話の場合
		# get properties of w
		if (count my findText(get name of w, "コール")) > 0 then
			activate
			# コールウィンドウを最前面に持ってくる
			set index of w to 1
			# マイクON,OFFキーを入力
			set bound to bounds of w
			delay 1
			tell application "System Events"
				delay 1
				click at {(item 1 of bound) + 100, (item 2 of bound) + 10}
				delay 1
				keystroke "m"
			end tell
		end if
	end repeat
end tell

# 文字列検索用関数
on findText(theText, serchStr)
	set tmp to AppleScript's text item delimiters
	set AppleScript's text item delimiters to serchStr
	set theText to every text item of theText
	set theList to {}
	set x to 0
	set delNum to number of serchStr
	repeat with curItem in theText
		set x to x + (number of curItem)
		set end of theList to x + 1
		set x to x + delNum
	end repeat
	set AppleScript's text item delimiters to tmp
	if (number of theList) = 1 then return {}
	return items 1 thru -2 of theList
end findText