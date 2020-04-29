
set tabCount to 0
tell application "Google Chrome"
	# 全ウィンドウループ
	repeat with w in windows
		# 全タブループ
		repeat with t in (tabs of w)
			# tabのIndex
			set tabCount to tabCount + 1
			# URLがマッチした場合
			if (count my findText(URL of t, "www.youtube.com")) > 0 then
				# タブをアクティブ化
				activate
				set active tab index of w to tabCount
				# タブにアクセスする
				tell t
					# 動画が再生中かを取得する
					set isPused to (execute javascript "document.querySelector('#movie_player video').paused")
					# 動画が停止していない場合
					if isPused = false then
						# 停止
						set pause to (execute javascript "document.querySelector('#movie_player .ytp-play-button').click();")
					end if
				end tell
			end if
		end repeat
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