### Variables
$dir='%APPDATA%\pentools'
### Welcome
echo "Welcome to Pentools, this may work, it may not. This exists to help me learn Powershell"
echo "Making a folder in appdata to put all this stuff"
mkdir \$dir
echo "Installing choco to make this easier"
###This line doesn't work but moving on for now
Start-Process powershell -Verb runAs Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
### Calling general dependencies to get this to work
choco install python ruby pip rake git
### make functions like the other platforms
