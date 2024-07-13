@echo off
powercfg /hibernate off
net accounts /maxpwage:unlimited
"reg" import %WINDIR%\Setup\Files\UAC0.reg
net stop wuauserv > nul
"reg" import "%WINDIR%\Setup\Files\winupdate1.reg" > nul
rd "%windir%\softwaredistribution" /s /q > nul
md "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" > nul
xcopy /y /r /c "%WINDIR%\Setup\Files\restart.cmd" "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" > nul
