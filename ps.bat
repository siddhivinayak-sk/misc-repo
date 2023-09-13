@ECHO OFF
set todays=%date:~10,4%%date:~4,2%%date:~7,2%
set todays_dir=c:\sandeep\daily\%todays%\
if not exist %todays_dir% mkdir %todays_dir%
@ECHO ON
start powershell -noexit -command "cd $Env:todays_dir"
