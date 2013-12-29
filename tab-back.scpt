-- tab back to the previous active application
tell application "System Events"
  tell process "finder"
    activate
    keystroke tab using {command down}
  end tell
end tell
