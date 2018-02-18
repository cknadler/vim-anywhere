function Find-BinaryPath() {
  $VimBinaries = @(
    "${env:ProgramFiles(x86)}\vim\vim80\gvim.exe",
    "$env:ProgramFiles\vim\vim80\gvim.exe"
  )
  foreach($Path in $VimBinaries) {
    if (Test-Path -Path "$Path") {
      return "$Path"
    }
  }
}

$VimPath = Find-BinaryPath
$TempFile = "$env:LOCALAPPDATA\.vim-anywhere"

Start-Process "$VimPath" -Args "$TempFile", "--nofork" -Wait
Get-Content "$TempFile" | Set-Clipboard
Remove-Item -Force -Path "$TempFile"

