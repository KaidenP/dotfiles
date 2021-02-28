
$PROJECT_DIR = Split-Path -Resolve ( #get fullpath
#  Split-Path -Path ( # dotfiles
    Split-Path -Path ( # windows
      Split-Path -Path $PSScriptRoot # HOME
))#)

echo "Copying Shared files..."
Copy-Item -Path "$PROJECT_DIR\shared\*" -Destination "$env:USERPROFILE" -Recurse -Force
echo "Copying Windows Home Dir files..."
Copy-Item -Path "$PROJECT_DIR\windows\home\*" -Destination "$env:USERPROFILE" -Recurse -Force

echo "Copying Windows Startup files..."
Copy-Item -Path "$PROJECT_DIR\windows\startup\*" -Destination "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Recurse -Force
