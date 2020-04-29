tell application "Slack"
	activate
end tell

set listIndex to 0
set callMatch to false
set menuWindowIndex to 7
tell application "System Events"
	tell process "Slack"
		# ウィンドウメニューリスト取得
		set menuWindowList to name of every menu item of menu 1 of menu bar item menuWindowIndex of menu bar 1
		log menuWindowList
		# ウィンドウのメニューリストからコールを精査
		repeat with l in menuWindowList
			set listName to l as string
			set listIndex to listIndex + 1
			# slackコールのウィンドウの存在確認
			if (count my findText(listName, "コール")) > 0 then
				set callMatch to true
				exit repeat
			end if
		end repeat
		# slackコールのウィンドウが存在した場合
		if callMatch then
			# メニューからウィンドウを選択
			click menu bar 1's menu bar item menuWindowIndex
			click menu bar 1's menu bar item menuWindowIndex's menu 1's menu item listIndex
			# マイクOFF
			tell application "System Events"
				delay 0.5
				keystroke "m"
			end tell
		end if
	end tell
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