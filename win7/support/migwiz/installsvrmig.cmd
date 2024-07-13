@if "%_echo%" == "" @echo off
setlocal enabledelayedexpansion
pushd .

rem === This script is used as a dev install for the Server Migration team.
rem === All the SvrMig and migration engine binaries and symbols are copied
rem === to their appropriate places when this is run on a test server.

rem === Path to SvrMig binaries directory
if "!Binaries!" == "" (
        set Binaries=%~dp0
        rem Strip trailing backslash.
        set Binaries=!Binaries:~0,-1!
)

rem === Path to destination
set Dest=!WinDir!\System32\MigWiz
set SvrMigDest=!WinDir!\System32\ServerMigrationTools
if not exist %Dest% mkdir %Dest%
if not exist %SvrMigDest% mkdir %SvrMigDest%

rem === Debug: echo all directory env vars
echo Binaries="!Binaries!"
echo Dest="!Dest!"

rem === check that Server Migration binaries exist
if not exist "!Binaries!\svrmig.dll" (
    echo Unable to locate Server Migration binaries in "!Binaries!".
    goto :end
)

rem === check that Server Migration binaries exist
if not exist "!Binaries!\migcore.dll" (
    echo Unable to locate migration engine binaries in "!Binaries!".
    goto :end
)

rem === Copy over all files in migwiz
xcopy /s /y "!Binaries!\*" %Dest%\

rem === move svrmig.dll from \migwiz to \ServerMigrationTools
move /Y %Dest%\svrmig.dll %SvrMigDest%\

rem === Copy svrmig symbols
copy /y "!Binaries!\..\Symbols.pri\MigWiz\dll\*" %Dest%\

rem === move svrmig.pdb from \migwiz to \ServerMigrationTools
move /Y %Dest%\svrmig.pdb %SvrMigDest%\

:end
popd
goto :EOF
