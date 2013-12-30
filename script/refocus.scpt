-- vim-anywhere - use Vim whenever, wherever
-- Author: Chris Knadler
-- Homepage: https://www.github.com/cknadler/vim-anywhere
--
-- refocus the previous active application

tell application "System Events"
  keystroke tab using {command down}
end tell
