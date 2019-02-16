@echo off
title Y4hL/MinGitLoad

:: Assigns random number to a variable ::
set tmprandom=%random%

:: Turns on powershell scripts for current user ::
powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

:: Checks if first parameter is the /? switch ::
IF [%1] == [/?] goto :help

:: Checks if/which parameters are empty ::
IF [%1] == [] goto :eof
IF [%2] == [] goto :eof
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
set mingitload_file_type=%4
set mingitload_file_type=.%mingitload_file_type:.=%
:name
set mingitload_file_name=%3
:auto
set mingitload_dir=%2
set mingitload_repo=%1


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

:: Creates Destination Directory ::
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
del /F /Q "%~dp0\%tmprandom%\%mingitload_file_name%%mingitload_file_type%" >nul
del /F /Q "%~dp0\%tmprandom%\download.ps1" >nul

:: Deletes %tmprandom% Folder ::
rd /s /q "%~dp0\%tmprandom%" >nul

:: Goes to the End of File
goto :eof

:: Help Message ::
:help

echo.
echo Pure Windows Minimalistic File Downloader 
echo.
echo # Format
echo.
echo [] : Required Parameters
echo () : Optional Parameters
echo.
echo "path\MinGitLoad" "[Link]" "[Destination]" "(File Name)" "(File Type)"
echo.
echo [Link] : Link to file download {example: github.com/Y4hL/MinGitLoad/archive/master.zip}
echo [Destination] : File Download Destination {example: %userprofile%\Desktop}
echo (File Name) : Name that the file should be saved as {example: README}
echo (File Type) : File Extension {example: zip, txt}
echo.
echo If file type is not given, it will be automatiacally extracted from the download link
echo.
echo If file_type nor file_name is given they will both be automatically extracted from the download link
echo.
echo Single and Double Quotes around parameters are strongly recommended!
echo NOTE: Except when using the /? parameter!
echo.
echo You can replace "[Link]" with /? for this message
echo When inputting /? as the first parameter, the other parameters can stay empty
pause
echo.
echo # Examples:
echo.
echo "path\MinGitLoad.cmd" "github.com/y4hl/mingitload/archive/master.zip" "%userprofile%\desktop"
echo ^>^> Downloads File as master.zip  
echo.
echo "path\MinGitLoad.cmd" "github.com/y4hl/mingitload/archive/master.zip" "%userprofile%\desktop" "Package"
echo ^>^> Downloads File as Package.zip  
echo.  
echo "path\MinGitLoad.cmd" "github.com/y4hl/mingitload/archive/master.zip" "%userprofile%\desktop" "Package" "txt"
echo ^>^> Downloads File as Package.txt  
echo.

:: End of File ::
:eof
