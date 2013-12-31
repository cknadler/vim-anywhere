-- vim-anywhere - use Vim whenever, wherever
-- Author: Chris Knadler
-- Homepage: https://www.github.com/cknadler/vim-anywhere
--
-- Get the current application's name

tell application "System Events"
  copy (name of application processes whose frontmost is true) to stdout
end tell
