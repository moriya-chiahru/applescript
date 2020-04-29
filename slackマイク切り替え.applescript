tell application "Slack"
	activate
end tell

set listIndex to 0
set callMatch to false
set menuWindowIndex to 7
tell application "System Events"
	tell process "Slack"
		# �E�B���h�E���j���[���X�g�擾
		set menuWindowList to name of every menu item of menu 1 of menu bar item menuWindowIndex of menu bar 1
		log menuWindowList
		# �E�B���h�E�̃��j���[���X�g����R�[���𐸍�
		repeat with l in menuWindowList
			set listName to l as string
			set listIndex to listIndex + 1
			# slack�R�[���̃E�B���h�E�̑��݊m�F
			if (count my findText(listName, "�R�[��")) > 0 then
				set callMatch to true
				exit repeat
			end if
		end repeat
		# slack�R�[���̃E�B���h�E�����݂����ꍇ
		if callMatch then
			# ���j���[����E�B���h�E��I��
			click menu bar 1's menu bar item menuWindowIndex
			click menu bar 1's menu bar item menuWindowIndex's menu 1's menu item listIndex
			# �}�C�NOFF
			tell application "System Events"
				delay 0.5
				keystroke "m"
			end tell
		end if
	end tell
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