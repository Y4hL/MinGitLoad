# MinGitLoad  
  
Minimalistic File Downloader for Windows  
  
Basic ``wget`` for Windows  
With no extra downloads!  
  
Only uses built in Windows file types  
Works on any type of file on any website

# Format:  
  
``"path\MinGitLoad.cmd" "website" "save_directory" "file_name" "file_type"``  
  
Using Single or Double Quotes around paramters is recommended  
**NOTE:** When there are spaces in a paramter, Single/Double Quotes are required!  
  
replace "website" with /? for help  
  
If file type is not given, it will be automatiacally be the same type as the websites download  
  
If file_type nor file_name is given they will both be automatically extracted from the download link  
  
# Examples:  
  
``"path\MinGitLoad.cmd" "github.com/y4hl/mingitload/archive/master.zip" "%userprofile%\desktop"``  
>> Downloads File as master.zip  
  
``"path\MinGitLoad.cmd" "github.com/y4hl/mingitload/archive/master.zip" "%userprofile%\desktop" "Package"``  
>> Downloads File as Package.zip  
  
``"path\MinGitLoad.cmd" "github.com/y4hl/mingitload/archive/master.zip" "%userprofile%\desktop" "Package" "txt"``  
>> Downloads File as Package.txt  
  
For downloading github repos, file_type should always be ``zip`` or set automatically  
  
# More Info  
  
If you want to unzip a file after downloading it (for example from github),  
you can use a Minimalistic Pure Windows unzipper at https://www.github.com/Y4hL/unzip  
