### Variables
$dir='%APPDATA%\pentools'

### Welcome
echo "Welcome to Pentools, this may work, it may not. This exists to help me learn powershell"
echo "Making a folder in appdata to put all this stuff"
mkdir \$dir
echo "Installing choco to make this easier"
Start-Process powershell -Verb runAs Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))