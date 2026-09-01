@echo off
pushd "%~dp0"
powershell.exe -NoProfile -NoExit -ExecutionPolicy RemoteSigned -File ".\StartWiki.ps1"
popd
