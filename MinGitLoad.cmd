@echo off
title Y4hL/MinGitLoad

:: Assigns random number to a variable ::
set tmprandom=%random%

:: Turns on powershell scripts for current user ::
powershell.exe Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force;

:: Checks if first parameter is the /? switch ::
IF [%~1] == [/?] goto :help

:: Checks if/which parameters are empty ::
IF [%~1] == [] goto :eof
IF [%~2] == [] goto :eof
IF [%~3] == [] (

    :: Sets file name and type automatically, if no name or type is given ::
    set mingitload_file_type=%~x1
    set mingitload_file_name=%~n1

    goto :auto
)
IF [%~4] == [] (

    :: Sets file type automatically, if no type is given ::
    set mingitload_file_type=%~x1

    goto :name
)

:: IF values are given already, skips asking for values ::
set mingitload_file_type=%~4
set mingitload_file_type=.%mingitload_file_type:.=%
:name
set mingitload_file_name=%~3
:auto
set mingitload_dir=%~2
set mingitload_repo=%~1


:: Removes Single/Double Quotes from Repo parameter ::
set mingitload_repo=%mingitload_repo:'=%
set mingitload_repo=%mingitload_repo:"=%

:: Removes Single/Double Quotes from mingitload_dir parameter ::
set mingitload_dir=%mingitload_dir:'=%
set mingitload_dir=%mingitload_dir:"=%

:: Removes Single/Double Quotes from mingitload_file_name parameter ::
set mingitload_file_name=%mingitload_file_name:'=%
set mingitload_file_name=%mingitload_file_name:"=%

:: Removes Single/Double Quotes from mingitload_file_type paramter ::
set mingitload_file_type=%mingitload_file_type:'=%
set mingitload_file_type=%mingitload_file_type:"=%

:: Creates Destination Directory ::
If NOT exist "%mingitload_dir%" md "%mingitload_dir%"

:: Creates Temporary Directory ::
md "%~dp0\%tmprandom%" >nul

:: Adds Repo Link and Destination Path to %tmprandom%\Download.ps1 ::
echo Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force; $c = New-Object System.Net.WebClient; $c.DownloadFile('%mingitload_repo%', '%mingitload_dir%\%mingitload_file_name%%mingitload_file_type%') >> "%~dp0\%tmprandom%\download.ps1"

:: Runs Downloader ::
powershell.exe -ExecutionPolicy bypass -File "%~dp0\%tmprandom%\download.ps1"

:: Deletes Temporary Files ::
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
echo [95m# Format[0m
echo.
echo [94m[] : Required Parameters[0m
echo [93m() : Optional Parameters[0m
echo.
echo "[96mpath\MinGitLoad.cmd[0m" "[94m[Link][0m" "[94m[Destination][0m" "[93m(File Name)[0m" "[93m(File Type)[0m"
echo.
echo [94m[Link][0m : Link to file download {example: github.com/Y4hL/MinGitLoad/archive/master.zip}
echo [94m[Destination][0m : File Download Destination {example: %userprofile%\Desktop}
echo [93m(File Name)[0m : Name that the file should be saved as {example: README}
echo [93m(File Type)[0m : File Extension {example: zip, txt}
echo.
echo If [93mFile Type[0m is not given, it will be automatiacally extracted from the download link
echo.
echo If [93mFile Type[0m nor [93mFile Name[0m is given they will both be automatically extracted from the download link
echo.
echo Single and Double Quotes around parameters are strongly recommended!
echo [1mNOTE:[0m Except when using the /? parameter!
echo.
echo You can replace "[Link]" with [91m/?[0m for this message
echo (example: "[96mpath\MinGitLoad.cmd[0m" [91m/?[0m)
echo When inputting /? as the first parameter, the other parameters can stay empty
pause
echo.
echo [95m# Examples:[0m
echo.
echo "[96mpath\MinGitLoad.cmd[0m" "[94mgithub.com/y4hl/mingitload/archive/master.zip[0m" "[94m%userprofile%\desktop[0m"
echo [92m^>^>[0m Downloads File as master.zip  
echo.
echo "[96mpath\MinGitLoad.cmd[0m" "[94mgithub.com/y4hl/mingitload/archive/master.zip[0m" "[94m%userprofile%\desktop[0m" "[93mPackage[0m"
echo [92m^>^>[0m Downloads File as Package.zip  
echo.  
echo "[96mpath\MinGitLoad.cmd[0m" "[94mgithub.com/y4hl/mingitload/archive/master.zip[0m" "[94m%userprofile%\desktop[0m" "[93mPackage[0m" "[93mtxt[0m"
echo [92m^>^>[0m Downloads File as Package.txt  
echo.

:: End of File ::
:eof
