﻿echo off
cls
set /p _username_=Enter Username:
cls
set "psCommand=powershell -Command "$pword = read-host 'Hi %_username_%, please enter Password' -AsSecureString ; ^
     SBSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR(Spword); ^
          [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set _password_=%%p
:begin 
cls
echo ==========================================
echo Dear %_username_%, please select a server:
echo ==========================================
echo[
echo 1)      Server1					Desc1
echo[
echo 2)      Server2					Desc2
echo[

set /p _option_=Type option (press ENTER to run previous host select): 
if "%_option_%"=="1" (
  set _server_=Server1
  goto cont
)
if "%_option_%"=="2" (
  set _server_=Server2
  goto cont
) else (
echo[
echo Invalid option, please try again!!
goto restart
)
:cont
goto open_session
:open_session
START "Pick your host" "C:\Program Files (x86)\Putty\putty.exe" -ssh %_username_%@%_server_% -pw %_password_%
:restart
timeout 1 > NUL
goto begin
:exit
@exit
