@echo off
wpeinit
set giturl=https://github.com/amidevous/wimboot-install
set gitbcommit=main
set winversion=windows7
set winversionmin=w7
set arch1=x86
set arch2=x86
set cygmirror=https://mirrors.kernel.org/sourceware/cygwin-archive/20221123/
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
rem if exist x:\Windows\System32\fwcfg.inf pnputil /i /a x:\Windows\System32\fwcfg.inf
rem if exist x:\Windows\System32\pvpanic-pci.inf pnputil /i /a x:\Windows\System32\pvpanic-pci.inf
rem if exist x:\Windows\System32\pvpanic.inf pnputil /i /a x:\Windows\System32\pvpanic.inf
rem if exist x:\Windows\System32\qemupciserial.inf pnputil /i /a x:\Windows\System32\qemupciserial.inf
rem if exist x:\Windows\System32\qxldod.inf pnputil /i /a x:\Windows\System32\qxldod.inf
rem if exist x:\Windows\System32\viofs.inf pnputil /i /a x:\Windows\System32\vioprot.inf
rem if exist x:\Windows\System32\viofs.inf pnputil /i /a x:\Windows\System32\viofs.inf
rem if exist x:\Windows\System32\viogpudo.inf pnputil /i /a x:\Windows\System32\viogpudo.inf
rem if exist x:\Windows\System32\vioinput.inf pnputil /i /a x:\Windows\System32\vioinput.inf
rem if exist x:\Windows\System32\viorng.inf pnputil /i /a x:\Windows\System32\viorng.inf
rem if exist x:\Windows\System32\vioser.inf pnputil /i /a x:\Windows\System32\vioser.inf
net start dnscache
wpeutil WaitForNetwork
ipconfig /renew
echo select disk 0 > config.txt
echo clean >> config.txt
echo create partition primary size=20000 >> config.txt
echo FORMAT QUICK FS=NTFS LABEL="System Reserved" >> config.txt
echo assign letter="S" >> config.txt
echo active >> config.txt
echo create partition primary >> config.txt
echo shrink minimum=1000 >> config.txt
echo format quick fs=ntfs label="Windows" >> config.txt
echo assign letter="W" >> config.txt
echo create partition primary >> config.txt
echo format quick fs=ntfs label="Recovery" >> config.txt
echo assign letter="R" >> config.txt
echo set id=27 >> config.txt
echo list volume >> config.txt
echo exit >> config.txt
diskpart /s config.txt
setup-%arch1%.exe --no-admin --root S:\Cygwin\ --quiet-mode --no-shortcuts --no-startmenu --allow-unsupported-windows --arch %arch1% --force-current --no-desktop --no-replaceonreboot --no-verify --no-version-check --no-warn-deprecated-windows --no-write-registry --only-site --site %cygmirror% -l S:\Cygwin\var\cache\apt\packages --packages dos2unix,wget,ca-certificates
rem cd s:\
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/%gitbcommit%min%arch1%.iso -O s:\%gitbcommit%min%arch1%.iso
7z x -y s:\%gitbcommit%min%arch1%.iso -os:\
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install.swm -O s:\sources\install.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install2.swm -O s:\sources\install2.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install3.swm -O s:\sources\install3.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install4.swm -O s:\sources\install4.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install5.swm -O s:\sources\install5.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install6.swm -O s:\sources\install6.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install7.swm -O s:\sources\install7.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install8.swm -O s:\sources\install8.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install9.swm -O s:\sources\install9.swm
S:\Cygwin\bin\wget.exe %giturl%/releases/download/%winversion%/install10.swm -O s:\sources\install10.swm
s:\sources\setup.exe /noreboot
if %gitbcommit%==win10 Dism /Image:w:\ /enable-feature /featurename:NetFx3 /All /Source:"s:\sources\sxs" /LimitAccess /NoRestart /LogLevel:4
if exist x:\Windows\System32\e1d68x64.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\e1d68x64.inf
if exist x:\Windows\System32\balloon.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/Balloon/%winversionmin%/%arch2%/balloon.cat -O x:\Windows\System32\balloon.cat
if exist x:\Windows\System32\balloon.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/Balloon/%winversionmin%/%arch2%/balloon.inf -O x:\Windows\System32\balloon.inf
if exist x:\Windows\System32\balloon.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/Balloon/%winversionmin%/%arch2%/balloon.sys -O x:\Windows\System32\balloon.sys
if exist x:\Windows\System32\balloon.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\balloon.inf
if exist x:\Windows\System32\netkvm.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/NetKVM/%winversionmin%/%arch2%/netkvm.cat -O x:\Windows\System32\netkvm.cat
if exist x:\Windows\System32\netkvm.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/NetKVM/%winversionmin%/%arch2%/netkvm.inf -O x:\Windows\System32\netkvm.inf
if exist x:\Windows\System32\netkvm.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/NetKVM/%winversionmin%/%arch2%/netkvm.sys -O x:\Windows\System32\netkvm.sys
if exist x:\Windows\System32\netkvm.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\netkvm.inf
if exist x:\Windows\System32\viostor.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/viostor/%winversionmin%/%arch2%/viostor.cat -O x:\Windows\System32\viostor.cat
if exist x:\Windows\System32\viostor.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/viostor/%winversionmin%/%arch2%/viostor.inf -O x:\Windows\System32\viostor.inf
if exist x:\Windows\System32\viostor.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/viostor/%winversionmin%/%arch2%/viostor.sys -O x:\Windows\System32\viostor.sys
if exist x:\Windows\System32\viostor.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viostor.inf
if exist x:\Windows\System32\VBoxGuest.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxGuest.inf
if exist x:\Windows\System32\VBoxGuestEarlyNT.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxGuestEarlyNT.inf
if exist x:\Windows\System32\VBoxMouse.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxMouse.inf
if exist x:\Windows\System32\VBoxVideo.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxVideo.inf
if exist x:\Windows\System32\VBoxVideoEarlyNT.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxVideoEarlyNT.inf
if exist x:\Windows\System32\VBoxWddm.inf.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\VBoxWddm.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\fwcfg.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\fwcfg.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic-pci.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\pvpanic-pci.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/pvpanic/%winversionmin%/%arch2%/pvpanic.cat -O x:\Windows\System32\pvpanic.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/pvpanic/%winversionmin%/%arch2%/pvpanic.inf -O x:\Windows\System32\pvpanic.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/pvpanic/%winversionmin%/%arch2%/pvpanic.cat -O x:\Windows\System32\pvpanic.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\pvpanic.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\pvpanic.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\qemupciserial.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/qemupciserial/%winversionmin%/%arch2%/qemupciserial.inf -O x:\Windows\System32\qemupciserial.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\qemupciserial.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/qemupciserial/%winversionmin%/%arch2%/qemupciserial.cat -O x:\Windows\System32\qemupciserial.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\qemupciserial.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qemupciserial.inf
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/qxl/%winversionmin%/%arch2%/qxl.cat -O x:\Windows\System32\qxl.cat
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/qxl/%winversionmin%/%arch2%/qxl.inf -O x:\Windows\System32\qxl.inf
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/qxl/%winversionmin%/%arch2%/qemupciserial.cat -O x:\Windows\System32\qemupciserial.cat
rem if %gitbcommit%==win7 if exist x:\Windows\System32\qxldod.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qxl.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\qxldod.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qxldod.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioprot.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioprot.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viofs.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viofs.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viogpudo.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viogpudo.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/vioinput/%winversionmin%/%arch2%/vioinput.cat -O x:\Windows\System32\vioinput.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/vioinput/%winversionmin%/%arch2%/vioinput.inf -O x:\Windows\System32\vioinput.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/vioinput/%winversionmin%/%arch2%/vioinput.sys -O x:\Windows\System32\vioinput.sys
if %gitbcommit%==win10 if exist x:\Windows\System32\vioinput.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioinput.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/viorng/%winversionmin%/%arch2%/viorng.cat -O x:\Windows\System32\viorng.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/viorng/%winversionmin%/%arch2%/viorng.inf -O x:\Windows\System32\viorng.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/viorng/%winversionmin%/%arch2%/vioinput.sys -O x:\Windows\System32\viorng.sys
if %gitbcommit%==win10 if exist x:\Windows\System32\viorng.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viorng.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/vioserial/%winversionmin%/%arch2%/vioser.cat -O x:\Windows\System32\vioser.cat
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/vioserial/%winversionmin%/%arch2%/vioser.inf -O x:\Windows\System32\vioser.inf
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf wget %giturl%/raw/%gitbcommit%/win10/drv/virtio-win-0.1.240/vioserial/%winversionmin%/%arch2%/vioser.sys -O x:\Windows\System32\vioser.sys
if %gitbcommit%==win10 if exist x:\Windows\System32\vioser.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioser.inf
shutdown -r -t 1
