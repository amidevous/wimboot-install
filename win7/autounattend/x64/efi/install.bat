@echo off
wpeinit
set giturl=https://github.com/amidevous/wimboot-install
set gitbcommit=main
set winversion=windows7
set winversionmin=w7
set isoversionmin=win7
set arch1=x86_64
set arch2=x86_64
set cygmirror=https://mirrors.kernel.org/sourceware/cygwin/
if exist x:\Windows\System32\e1d68x64.inf pnputil /i /a x:\Windows\System32\e1d68x64.inf
if exist x:\Windows\System32\balloon.inf pnputil /i /a x:\Windows\System32\balloon.inf
if exist x:\Windows\System32\netkvm.inf pnputil /i /a x:\Windows\System32\netkvm.inf
if exist x:\Windows\System32\viostor.inf pnputil /i /a x:\Windows\System32\viostor.inf
if exist x:\Windows\System32\VBoxGuest.inf pnputil /i /a x:\Windows\System32\VBoxGuest.inf
if exist x:\Windows\System32\VBoxGuestEarlyNT.inf pnputil /i /a x:\Windows\System32\VBoxGuestEarlyNT.inf
if exist x:\Windows\System32\VBoxMouse.inf pnputil /i /a x:\Windows\System32\VBoxMouse.inf
if exist x:\Windows\System32\VBoxVideo.inf pnputil /i /a x:\Windows\System32\VBoxVideo.inf
if exist x:\Windows\System32\VBoxVideoEarlyNT.inf pnputil /i /a x:\Windows\System32\VBoxVideoEarlyNT.inf
if exist x:\Windows\System32\VBoxWddm.inf pnputil /i /a x:\Windows\System32\VBoxWddm.inf
if exist x:\Windows\System32\fwcfg.inf pnputil /i /a x:\Windows\System32\fwcfg.inf
if exist x:\Windows\System32\pvpanic-pci.inf pnputil /i /a x:\Windows\System32\pvpanic-pci.inf
if exist x:\Windows\System32\pvpanic.inf pnputil /i /a x:\Windows\System32\pvpanic.inf
if exist x:\Windows\System32\qemupciserial.inf pnputil /i /a x:\Windows\System32\qemupciserial.inf
if exist x:\Windows\System32\qxldod.inf pnputil /i /a x:\Windows\System32\qxldod.inf
if exist x:\Windows\System32\viofs.inf pnputil /i /a x:\Windows\System32\vioprot.inf
if exist x:\Windows\System32\viofs.inf pnputil /i /a x:\Windows\System32\viofs.inf
if exist x:\Windows\System32\viogpudo.inf pnputil /i /a x:\Windows\System32\viogpudo.inf
if exist x:\Windows\System32\vioinput.inf pnputil /i /a x:\Windows\System32\vioinput.inf
if exist x:\Windows\System32\viorng.inf pnputil /i /a x:\Windows\System32\viorng.inf
if exist x:\Windows\System32\vioser.inf pnputil /i /a x:\Windows\System32\vioser.inf
setlocal enableDelayedExpansion
for /f "delims=" %%a in ('ipconfig /all') do (
    set line=%%a
    if not "!line:~0,1!"==" " if not "!line:adapter=!"=="!line!" (
        set name=!line:*adapter =!
        set name=!name::=!
    )
    for /f "tokens=1,2,*" %%b in ("%%a") do (
        if "%%b %%c"=="Physical Address." (
            set mac=%%d
            set mac=!mac:*: =!
            echo !name!: !mac!
            if "!mac!"=="52-54-00-01-13-9E" (
                netsh interface ipv4 set address name="Ethernet" static 163.172.118.206 mask=255.255.255.255 gateway=62.210.202.1 10
            )
            else (
                ipconfig /renew
            )
        )
    )
)
rem pause
net start dnscache
rem pause
netsh interface ipv4 set dns name="Ethernet" static 8.8.8.8 primary
rem pause
netsh interface ipv4 set winsservers name="Ethernet" static 8.8.8.8
rem pause
rem ipconfig /flushdns﻿
rem pause
wpeutil WaitForNetwork
rem pause
echo select disk 0 > config.txt
echo clean >> config.txt
echo exit >> config.txt
diskpart /s config.txt
echo "clean"
rem pause
echo select disk 0 > config.txt
echo Convert GPT >> config.txt
echo exit >> config.txt
diskpart /s config.txt
echo "Convert GPT"
rem pause
echo select disk 0 > config.txt
echo CREATE PARTITION PRIMARY SIZE=300 >> config.txt
echo format quick fs=ntfs label="Windows RE tools" >> config.txt
echo Assign Letter=A >> config.txt
set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac" >> config.txt
gpt attributes=0x8000000000000001 >> config.txt
echo exit >> config.txt
rem diskpart /s config.txt
echo "Windows RE tools"
rem pause
echo select disk 0 > config.txt
echo create partition efi size=100 >> config.txt
format quick fs=fat32 label="System" >> config.txt
echo Assign Letter=B >> config.txt
echo set id=2 >> config.txt
echo exit >> config.txt
rem diskpart /s config.txt
echo "System partition (ESP/EFI)"
rem pause
echo select disk 0 > config.txt
echo CREATE PARTITION MSR LABEL="MSR" SIZE=128 >> config.txt
echo Assign Letter=D >> config.txt
echo set id=3 >> config.txt
echo exit >> config.txt
rem diskpart /s config.txt
echo "Microsoft reserved partition (MSR)"
rem pause
echo select disk 0 > config.txt
echo create partition PRIMARY size=20000 >> config.txt
echo FORMAT QUICK FS=NTFS LABEL="System" >> config.txt
echo assign letter="S" >> config.txt
echo set id=5 >> config.txt
echo active >> config.txt
echo exit >> config.txt
rem diskpart /s config.txt
echo "drive S"
rem pause
echo select disk 0 > config.txt
echo create partition primary >> config.txt
echo shrink minimum=20000 >> config.txt
echo format quick fs=ntfs label="OS" >> config.txt
echo assign letter="C" >> config.txt
rem set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"
echo set id="4" >> config.txt
echo active >> config.txt
echo exit >> config.txt
rem diskpart /s config.txt
echo "drive C"
rem pause
echo create partition primary >> config.txt
echo gpt attributes=0x8000000000000001 >> config.txt
echo assign letter="R" >> config.txt
echo set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac" >> config.txt
echo list volume >> config.txt
echo exit >> config.txt
rem pause
rem diskpart /s config.txt
rem pause
rem pause
rem pause
ping -n 1 google.fr
rem pause
setup-x86_64.exe --no-admin --root X:\Cygwin\ --quiet-mode --no-shortcuts --no-startmenu --allow-unsupported-windows --arch %arch1% --force-current --no-desktop --no-replaceonreboot --no-verify --no-version-check --no-warn-deprecated-windows --no-write-registry --only-site --site %cygmirror% -l x:\Cygwin\var\cache\apt\packages --packages dos2unix,wget,ca-certificates
rem pause
X:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/win7minx86_64.iso -O x:\win7minx86_64.iso
rem pause
mkdir x:\windowssource
7z x -y x:\win7minx86_64.iso -oX:\windowssource
rem pause
X:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/win7pro-x86_64.swm -O X:\windowssource\sources\install.swm
X:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/win7pro-x86_642.swm -O X:\windowssource\sources\install2.swm
X:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/win7pro-x86_643.swm -O X:\windowssource\sources\install3.swm
X:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/win7pro-x86_644.swm -O X:\windowssource\sources\install4.swm
X:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/win7pro-x86_645.swm -O X:\windowssource\sources\install5.swm
rem S:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/install6.swm -O X:\windowssource\sources\install6.swm
rem S:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/install7.swm -O X:\windowssource\sources\install7.swm
rem S:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/install8.swm -O X:\windowssource\sources\install8.swm
rem S:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/install9.swm -O X:\windowssource\sources\install9.swm
rem S:\Cygwin\bin\wget.exe https://github.com/amidevous/wimboot-install/releases/download/windows7/install10.swm -O X:\windowssource\sources\install10.swm
rem pause
X:\windowssource\sources\setup.exe /noreboot /unattend:x:\Windows\System32\autounattend.xml
rem pause
if %isoversionmin%==win10 Dism /Image:w:\ /enable-feature /featurename:NetFx3 /All /Source:"s:\sources\sxs" /LimitAccess /NoRestart /LogLevel:4
rem pause
if exist x:\Windows\System32\e1d68x64.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\e1d68x64.inf
if exist x:\Windows\System32\balloon.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/Balloon/w10/amd64/balloon.cat -O x:\Windows\System32\balloon.cat
if exist x:\Windows\System32\balloon.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/Balloon/w10/amd64/balloon.inf -O x:\Windows\System32\balloon.inf
if exist x:\Windows\System32\balloon.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/Balloon/w10/amd64/balloon.sys -O x:\Windows\System32\balloon.sys
if exist x:\Windows\System32\balloon.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\balloon.inf
if exist x:\Windows\System32\netkvm.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/NetKVM/win7/amd64/netkvm.cat -O x:\Windows\System32\netkvm.cat
if exist x:\Windows\System32\netkvm.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/NetKVM/win7/amd64/netkvm.inf -O x:\Windows\System32\netkvm.inf
if exist x:\Windows\System32\netkvm.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/NetKVM/win7/amd64/netkvm.sys -O x:\Windows\System32\netkvm.sys
if exist x:\Windows\System32\netkvm.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\netkvm.inf
if exist x:\Windows\System32\viostor.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/viostor/win7/amd64/viostor.cat -O x:\Windows\System32\viostor.cat
if exist x:\Windows\System32\viostor.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/viostor/win7/amd64/viostor.inf -O x:\Windows\System32\viostor.inf
if exist x:\Windows\System32\viostor.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/viostor/win7/amd64/viostor.sys -O x:\Windows\System32\viostor.sys
if exist x:\Windows\System32\viostor.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viostor.inf
if exist x:\Windows\System32\VBoxGuest.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxGuest.inf
if exist x:\Windows\System32\VBoxGuestEarlyNT.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxGuestEarlyNT.inf
if exist x:\Windows\System32\VBoxMouse.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxMouse.inf
if exist x:\Windows\System32\VBoxVideo.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxVideo.inf
if exist x:\Windows\System32\VBoxVideoEarlyNT.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxVideoEarlyNT.inf
if exist x:\Windows\System32\VBoxWddm.inf.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxWddm.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\fwcfg.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\fwcfg.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic-pci.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\pvpanic-pci.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/pvpanic/win7/amd64/pvpanic.cat -O x:\Windows\System32\pvpanic.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/pvpanic/win7/amd64/pvpanic.inf -O x:\Windows\System32\pvpanic.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/pvpanic/win7/amd64/pvpanic.cat -O x:\Windows\System32\pvpanic.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\pvpanic.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\qemupciserial.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/qemupciserial/win7/amd64/qemupciserial.inf -O x:\Windows\System32\qemupciserial.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\qemupciserial.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/qemupciserial/win7/amd64/qemupciserial.cat -O x:\Windows\System32\qemupciserial.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\qemupciserial.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qemupciserial.inf
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/qxl/win7/amd64/qxl.cat -O x:\Windows\System32\qxl.cat
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/qxl/win7/amd64/qxl.inf -O x:\Windows\System32\qxl.inf
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/qxl/win7/amd64/qemupciserial.cat -O x:\Windows\System32\qemupciserial.cat
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qxl.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\qxldod.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qxldod.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioprot.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioprot.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viofs.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viofs.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viogpudo.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viogpudo.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/vioinput/win7/amd64/vioinput.cat -O x:\Windows\System32\vioinput.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/vioinput/win7/amd64/vioinput.inf -O x:\Windows\System32\vioinput.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/vioinput/win7/amd64/vioinput.sys -O x:\Windows\System32\vioinput.sys
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioinput.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/viorng/win7/amd64/viorng.cat -O x:\Windows\System32\viorng.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/viorng/win7/amd64/viorng.inf -O x:\Windows\System32\viorng.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/viorng/win7/amd64/vioinput.sys -O x:\Windows\System32\viorng.sys
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viorng.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/vioserial/win7/amd64/vioser.cat -O x:\Windows\System32\vioser.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/vioserial/win7/amd64/vioser.inf -O x:\Windows\System32\vioser.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf wget https://raw.githubusercontent.com/amidevous/wimboot-install/refs/heads/main/win10/drv/virtio-win-0.1.240/vioserial/win7/amd64/vioser.sys -O x:\Windows\System32\vioser.sys
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioser.inf
shutdown -r -t 1

