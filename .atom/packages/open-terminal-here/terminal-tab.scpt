(*
 * OSX Automator AppleScript to open the input directory in a new Terminal tab
 *
 * Copyright 2015, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://opensource.org/licenses/MIT
 *)

on run {input}
	set dir to quoted form of POSIX path of (input as text)
	set inNewTab to (application "Terminal" is running)
	tell application "Terminal"
		activate
		if inNewTab then
			tell application "System Events"
				tell application process "Terminal"
					set frontmost to true
					keystroke "t" using command down
				end tell
			end tell
		end if
		do script "cd " & dir & ";clear" in front window
	end tell
end run
