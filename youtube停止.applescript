
set tabCount to 0
tell application "Google Chrome"
	# �S�E�B���h�E���[�v
	repeat with w in windows
		# �S�^�u���[�v
		repeat with t in (tabs of w)
			# tab��Index
			set tabCount to tabCount + 1
			# URL���}�b�`�����ꍇ
			if (count my findText(URL of t, "www.youtube.com")) > 0 then
				# �^�u���A�N�e�B�u��
				activate
				set active tab index of w to tabCount
				# �^�u�ɃA�N�Z�X����
				tell t
					# ���悪�Đ��������擾����
					set isPused to (execute javascript "document.querySelector('#movie_player video').paused")
					# ���悪��~���Ă��Ȃ��ꍇ
					if isPused = false then
						# ��~
						set pause to (execute javascript "document.querySelector('#movie_player .ytp-play-button').click();")
					end if
				end tell
			end if
		end repeat
	end repeat
end tell


# �����񌟍��p�֐�
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