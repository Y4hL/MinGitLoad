@echo off
title Y4hL/MinGitLoad

set tmpdir=%cd%

cd %~dp0

:: Turns on powershell scripts for current user ::
powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

IF [%1] == [] goto :ask
IF [%2] == [] goto :ask
IF [%3] == [] goto :ask
IF [%4] == [] goto :ask

:: IF values are given already, skips asking for values ::
set repo=%1
set dir=%2
set file_name=%3
set file_type=%4

goto git
:ask

:: Asks for Link to repo ::
set /p repo=Clone: 

:: Asks for destination ::
set /p dir=Download Path: ´

:: Asks for file name ::
set /p file_name=File Name: 

:: Asks for file type (example: txt, zip) ::
set /p file_type=File Type (Example: txt, zip): 

:git

:: Creates Temporary Directory ::
md tmp >nul

:: Copies Download file to tmp Folder ::
copy download.ps1 tmp\download.ps1 >nul

:: Adds Repo Link and Destination Path to tmp\Download.ps1 ::
echo download %cd%\tmp\%file_name%.%file_type% %repo% >> tmp\download.ps1

:: Runs Downloader ::
powershell.exe -File tmp\download.ps1

:: Copies Downloaded file to Destination Path ::
copy %cd%\tmp\%file_name%.%file_type% %dir% /Y >nul

:: Deleted Temporary Files ::
del /F /Q tmp\%file_name%.%file_type%
del /F /Q tmp\download.ps1

:: Deletes tmp Folder ::
rd /s /q tmp

:: Goes back to directory used before MinGitLoad.cmd ::
cd %tmpdir%
