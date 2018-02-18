# Add zip assembly
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Download from Github
Invoke-WebRequest -Uri "https://github.com/cknadler/vim-anywhere/archive/master.zip" -OutFile "$env:LOCALAPPDATA\vim-anywhere.zip"

# Extract
[System.IO.Compression.ZipFile]::ExtractToDirectory("$env:LOCALAPPDATA\vim-anywhere.zip", "$HOME")

# Setup
Move-Item "$HOME\vim-anywhere-master" "$HOME\.vim-anywhere"
Remove-Item -Force "$env:LOCALAPPDATA\vim-anywhere.zip"

