Echo off
cls
color 0F
mode con: cols=60 lines=20

title Start installation

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
Echo                   Prepare Updates Install

Timeout 10 > nul


"%WINDIR%\Setup\Files\Windows Loader.exe" /silent /norestart /k=RDJXR-3M32B-FJT32-QMPGB-GCFF6 /c=Acer /s=Acer > nul
"%WINDIR%\Setup\Files\nircmd.exe" elevate %windir%\system32\cmd.exe /c "%WINDIR%\Setup\Files\install-1.cmd"