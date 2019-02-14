@echo off
title Y4hL/MinGitLoad

set file_dir=%~dp0

set notcalledaglobalvariable=%random%

:: Turns on powershell scripts for current user ::
powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

IF [%1] == [] goto :ask
IF [%2] == [] goto :ask
IF [%3] == [] (

    :: Sets file name and type automatically, if no name or type is given ::
    set file_type=%~x1
    set file_name=%~n1

    goto :auto
)
IF [%4] == [] (

    :: Sets file type automatically, if no type is given ::
    set file_type=%~x1

    goto :name
)

:: IF values are given already, skips asking for values ::
set file_type=.%4
:name
set file_name=%3
:auto
set dir=%2
set repo=%1


goto git
:ask

:: Asks for Link to repo ::
set /p repo=Clone: 

:: Asks for destination ::
set /p dir=Download Path: 

:: Asks for file name ::
set /p file_name=File Name: 

:: Asks for file type (example: txt, zip) ::
set /p file_type=File Type (Example: txt, zip): 



:: Removed Double Quotes from repo parameter ::
set repo=%repo:"=%
:: Removed Single Quotes from repo parameter ::
set repo=%repo:'=%

:: Removed Double Quotes from dir parameter ::
set dir=%dir:"=%
:: Removed Single Quotes from dir parameter ::
set dir=%dir:'=%

:: Removes Double Quotes from file_name parameter ::
set file_name=%file_name:"=%
:: Removes Single Quotes from file_name paramter
set file_name=%file_name:'=%

:: Adds dot and removes Double Quotes from file_type paramter ::
set file_type=.%file_type:"=%
:: Removes Single Quotes from file_type parameter ::
set file_type=%file_type:'=%




:git

If NOT exist "%dir%" md "%dir%"

:: Creates Temporary Directory ::
md "%file_dir%\%notcalledaglobalvariable%" >nul

:: Copies Download file to %notcalledaglobalvariable% Folder ::
copy "%file_dir%\download.ps1" "%file_dir%\%notcalledaglobalvariable%\download.ps1" >nul

:: Adds Repo Link and Destination Path to %notcalledaglobalvariable%\Download.ps1 ::
echo download "%file_dir%\%notcalledaglobalvariable%\%file_name%%file_type%" "%repo%" >> "%file_dir%\%notcalledaglobalvariable%\download.ps1"

:: Runs Downloader ::
powershell.exe -File "%file_dir%\%notcalledaglobalvariable%\download.ps1"

:: Copies Downloaded file to Destination Path ::
copy "%file_dir%\%notcalledaglobalvariable%\%file_name%%file_type%" "%dir%" /Y >nul

:: Deleted Temporary Files ::
del /F /Q "%file_dir%\%notcalledaglobalvariable%\%file_name%%file_type%"
del /F /Q "%file_dir%\%notcalledaglobalvariable%\download.ps1"

:: Deletes %notcalledaglobalvariable% Folder ::
rd /s /q "%file_dir%\%notcalledaglobalvariable%"
