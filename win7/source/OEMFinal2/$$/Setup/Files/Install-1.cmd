@echo off
cls
color 0F
mode con: cols=60 lines=20

title Start install

cls
echo;
echo;
echo;
Echo               ===============================
Echo               =                             =
Echo               =          Windows 7          =
Echo               =                             =
Echo               =   Service Pack 2 with esu   =
Echo               =                             =
Echo               ===============================
echo;
echo;
echo;
Echo                     Install Updates

Timeout 10 > nul
reg import "%WINDIR%\Setup\Files\uac5.reg" > nul
"%WINDIR%\Setup\Files\RDP Wrapper.exe"
net stop wuauserv > nul
rd "%windir%\softwaredistribution" /s /q > nul
:CheckOS
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (GOTO 32BIT) ELSE (GOTO 64BIT)


:32BIT
"%WINDIR%\Setup\Files\Windows6.1-KB2533552-x86.exe"
"%WINDIR%\Setup\Files\Windows6.1-KB3191566-x86.exe"
GOTO END

:64BIT
"%WINDIR%\Setup\Files\Windows6.1-KB2533552-x64.exe"
"%WINDIR%\Setup\Files\Windows6.1-KB2603229-x64.exe"
GOTO END

:END


rd "%windir%\softwaredistribution" /s /q > nul
reg import "%WINDIR%\Setup\Files\winupdate2.reg" > nul
echo Installation SP2 OK > %windir%\system32\SP2.install
net start wuauserv > nul
rd /q /s "%WINDIR%\Setup\Updates" > nul


cls
echo;
echo;
echo;
Echo               ===============================
Echo               =                             =
Echo               =       Service Pack 2        =
Echo               =                             =
Echo               =      Windows 7 32 Bits      =
Echo               =                             =
Echo               ===============================
echo;
echo;
echo;
Echo                     update finish

timeout 5 > nul

cls
echo;
echo;
echo;
Echo               ===============================
Echo               =                             =
Echo               =       Service Pack 2        =
Echo               =                             =
Echo               =      Windows 7 32 Bits      =
Echo               =                             =
Echo               ===============================
echo;
echo;
echo;
Echo                   Restart your Computer

shutdown /f /r /t 30 > nul
rd /q /s "%WINDIR%\Setup\Updates" > nul
rd /q /s "%WINDIR%\Setup\Scripts" > nul
del /q /f "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\restart.cmd" > nul
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\restart.cmd" > nul
rd /q /s "%WINDIR%\Setup\Files"