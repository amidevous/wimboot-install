@echo off
wpeinit
:network
ping -n 1 google.fr | find "TTL"
if not errorlevel 1 goto next
if errorlevel 1 set goto network
:next
regsvr32 /s winfsp-x86.dll
rclone config create http http http=http://62.210.202.52/win7/x86 url=http://62.210.202.52/win7/x86/
start rclone mount http: y: --file-perms=0777 --dir-perms 0777 --network-mode -vv
echo select disk 0 > config.txt
echo clean >> config.txt
echo CONVERT GPT >> config.txt
echo CREATE PARTITION EFI SIZE=300 >> config.txt
echo FORMAT QUICK FS=FAT32 LABEL="System" >> config.txt
echo CREATE PARTITION MSR SIZE=16 >> config.txt
echo create partition primary >> config.txt
echo shrink minimum=1000 >> config.txt
echo format quick fs=ntfs label="Windows" >> config.txt
echo create partition primary >> config.txt
echo format quick fs=ntfs label="Recovery" >> config.txt
echo SET ID="de94bba4-06d1-4d40-a16a-bfd50179d6ac" >> config.txt
echo set GPT ATTRIBUTES=0x8000000000000001 >> config.txt
echo list volume >> config.txt
echo exit >> config.txt
diskpart /s config.txt
rclone config create http http http=http://62.210.202.52/win7/x86 url=http://62.210.202.52/win7/x86/
start rclone mount http: y: --file-perms=0777 --dir-perms 0777 --network-mode -vv
Y:\setup.exe /unattend:y:\autounattend\x86\starter\english\efi\autounattend.xml
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
if exist x:\Windows\System32\fwcfg.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\fwcfg.inf
if exist x:\Windows\System32\pvpanic-pci.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\pvpanic-pci.inf
if exist x:\Windows\System32\pvpanic.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\pvpanic.inf
if exist x:\Windows\System32\qemupciserial.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qemupciserial.inf
if exist x:\Windows\System32\qxldod.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\qxldod.inf
if exist x:\Windows\System32\vioprot.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioprot.inf
if exist x:\Windows\System32\viofs.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viofs.inf
if exist x:\Windows\System32\viogpudo.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viogpudo.inf
if exist x:\Windows\System32\vioinput.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioinput.inf
if exist x:\Windows\System32\viorng.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\viorng.inf
if exist x:\Windows\System32\vioser.inf Dism /Image:W:\ /Add-Driver /Driver:x:\Windows\System32\vioser.inf
shutdown -r -t 1
