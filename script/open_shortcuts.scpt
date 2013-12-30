-- vim-anywhere - use Vim whenever, wherever
-- Author: Chris Knadler
-- Homepage: https://www.github.com/cknadler/vim-anywhere
--
-- Open the keyboard shortcuts tab of keyboard system preferences

tell application "System Preferences"
  activate
  reveal anchor "shortcutsTab" of pane id "com.apple.preference.keyboard"
  keystroke tab
  keystroke key code 125
  keystroke key code 125
  keystroke key code 125
end tell
