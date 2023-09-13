@ECHO OFF
set todays=%date:~10,4%%date:~4,2%%date:~7,2%
set todays_dir=c:\sandeep\daily\%todays%\
if not exist %todays_dir% mkdir %todays_dir%
@ECHO ON
start /d %todays_dir% "" "C:\Program Files\Git\git-bash.exe"
