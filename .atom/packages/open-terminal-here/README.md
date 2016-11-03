# Open Terminal Here

Open the Terminal (Mac OS X, Linux) or Command Prompt (Windows)
in the given directory via context menu or keyboard shortcut.

![Screenshot of the "Open Terminal Here" menu item displayed][1]

## Keyboard shortcuts

### Open the Terminal in the current directory

Platform | Keyboard shortcut
-------- | -----------------
Mac OS X | `ctrl-cmd-t`
Windows  | `ctrl-alt-t`
Linux    | `ctrl-alt-t`

### Open the Terminal in the project directory

Platform | Keyboard shortcut
-------- | -----------------
Mac OS X | `alt-cmd-t`
Windows  | `ctrl-alt-shift-t`
Linux    | `ctrl-alt-shift-t`

## FAQ

### How to open a new tab instead of a new window?

#### Mac OS X

1. Open [Automator][2] and select `Application` as new document.
2. From the Library, add `Run Applescript` as Automator action.
3. Replace the sample AppleScript code with the code from
   [terminal-tab.scpt][3].
4. Save the Automator app as `TerminalTab.app` to your Applications folder.
5. In the `open-terminal-here` settings, set `Command` to
   `open -a TerminalTab.app "$PWD"`.

#### Ubuntu Linux

1. Install [xdotool][4]:  
   `sudo apt-get install -y xdotool`
2. Download [terminal-tab.sh][5] and make it executable:  
   `chmod +x ./terminal-tab.sh`
3. Move the script to a directory in your path:  
   `sudo mv ./terminal-tab.sh /usr/local/bin/terminal-tab`
4. In the `open-terminal-here` settings, set `Command` to
   `terminal-tab`.

[1]: https://raw.githubusercontent.com/blueimp/atom-open-terminal-here/master/screenshot.png
[2]: https://en.wikipedia.org/wiki/Automator_(software)
[3]: https://github.com/blueimp/atom-open-terminal-here/blob/master/terminal-tab.scpt
[4]: http://www.semicomplete.com/projects/xdotool/
[5]: https://raw.githubusercontent.com/blueimp/atom-open-terminal-here/master/terminal-tab.sh
