# MinGitLoad  
  
Minimalistic File Downloader for Windows  
  
Basic ``git clone`` for Windows  
  
Only uses built in Windows file types  
Works on any type of file on any website

# Format:  
  
``MinGitLoad.cmd website save_directory file_name file_type``  
  
If file type is not given, it will be automatiacally be the same type as the websites download  
If file_type nor file_name is given they will both be automatically set by the website download  
  
Examples:  
  
``MinGitLoad.cmd github.com/y4hl/mingitload/archive/master.zip %userprofile%\desktop``  
>> Downloads File as master.zip  
  
``MinGitLoad.cmd github.com/y4hl/mingitload/archive/master.zip %userprofile%\desktop Package``  
>> Downloads File as Package.zip  
  
``MinGitLoad.cmd github.com/y4hl/mingitload/archive/master.zip %userprofile%\desktop Package txt``  
>> Donwloads File as Package.txt  
  
Can be entered manually by just opening MinGitLoad.cmd  
  
For downloading github repos, file_type should always be ``zip``  
