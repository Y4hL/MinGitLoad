@echo off
title Y4hL/MinGitLoad

:: Assigns random number to a variable ::
set tmprandom=%random%

:: Turns on powershell scripts for current user ::
powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

IF [%1] == [] goto :ask
IF [%2] == [] goto :ask
IF [%3] == [] (

    :: Sets file name and type automatically, if no name or type is given ::
    set mingitload_file_type=%~x1
    set mingitload_file_name=%~n1

    goto :auto
)
IF [%4] == [] (

    :: Sets file type automatically, if no type is given ::
    set mingitload_file_type=%~x1

    goto :name
)

:: IF values are given already, skips asking for values ::
set mingitload_file_type=.%4
:name
set mingitload_file_name=%3
:auto
set mingitload_dir=%2
set mingitload_repo=%1


goto git
:ask

:: Asks for Link to Repo ::
set /p mingitload_repo=Clone: 

:: Asks for destination ::
set /p mingitload_dir=Download Path: 

:: Asks for file name ::
set /p mingitload_file_name=File Name: 

:: Asks for file type (example: txt, zip) ::
set /p mingitload_file_type=File Type (Example: txt, zip): 

:: Adds dot to file type ::
set mingitload_file_type=.%mingitload_file_type%

:git


:: Removed Double Quotes from Repo parameter ::
set mingitload_repo=%mingitload_repo:"=%
:: Removed Single Quotes from Repo parameter ::
set mingitload_repo=%mingitload_repo:'=%

:: Removed Double Quotes from mingitload_dir parameter ::
set mingitload_dir=%mingitload_dir:"=%
:: Removed Single Quotes from mingitload_dir parameter ::
set mingitload_dir=%mingitload_dir:'=%

:: Removes Double Quotes from mingitload_file_name parameter ::
set mingitload_file_name=%mingitload_file_name:"=%
:: Removes Single Quotes from mingitload_file_name paramter
set mingitload_file_name=%mingitload_file_name:'=%

:: Removes Double Quotes from mingitload_file_type paramter ::
set mingitload_file_type=%mingitload_file_type:"=%
:: Removes Single Quotes from mingitload_file_type parameter ::
set mingitload_file_type=%mingitload_file_type:'=%


If NOT exist "%mingitload_dir%" md "%mingitload_dir%"

:: Creates Temporary Directory ::
md "%~dp0\%tmprandom%" >nul

:: Copies Download file to %tmprandom% Folder ::
copy "%~dp0\download.ps1" "%~dp0\%tmprandom%\download.ps1" >nul

:: Adds Repo Link and Destination Path to %tmprandom%\Download.ps1 ::
echo download "%~dp0\%tmprandom%\%mingitload_file_name%%mingitload_file_type%" "%mingitload_repo%" >> "%~dp0\%tmprandom%\download.ps1"

:: Runs Downloader ::
powershell.exe -File "%~dp0\%tmprandom%\download.ps1"

:: Copies Downloaded file to Destination Path ::
copy "%~dp0\%tmprandom%\%mingitload_file_name%%mingitload_file_type%" "%mingitload_dir%" /Y >nul

:: Deleted Temporary Files ::
del /F /Q "%~dp0\%tmprandom%\%mingitload_file_name%%mingitload_file_type%"
del /F /Q "%~dp0\%tmprandom%\download.ps1"

:: Deletes %tmprandom% Folder ::
rd /s /q "%~dp0\%tmprandom%"
