@echo off
title Y4hL/MinGitLoad

set tmpdir=%cd%

cd %~dp0

:: Turns on powershell scripts for current user ::
powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

:: Asks for Link to repo ::
set /p repo=Clone: 

:: Asks for destination ::
set /p dir=Download Path: 

:: Creates Temporary Directory ::
md tmp >nul

:: Copies Download file to tmp Folder
copy download.ps1 tmp\download.ps1 >nul

:: Adds Repo Link and Destination Path to tmp\Download.ps1 ::
echo download %cd%\tmp\master.zip %repo% >> tmp\download.ps1

:: Runs Downloader ::
powershell.exe -File tmp\download.ps1

:: Copies Downloaded file to Destination Path
copy %cd%\tmp\master.zip %dir% /Y >nul

:: Deleted Temporary Files
del /F /Q tmp\master.zip
del /F /Q tmp\download.ps1

:: Deletes tmp Folder ::
rd /s /q tmp

:: Goes back to directory used before MinGitLoad.cmd
cd %tmpdir%