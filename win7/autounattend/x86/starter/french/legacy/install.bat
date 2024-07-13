@echo off
wpeinit
pnputil /i /a x:\Windows\System32\balloon.inf
pnputil /i /a x:\Windows\System32\netkvm.inf
pnputil /i /a x:\Windows\System32\vioscsi.inf
pnputil /i /a x:\Windows\System32\viostor.inf
start net start dnscache
@powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
wpeutil WaitForNetwork
ipconfig /renew

:network
ping -n 1 google.fr | find "TTL"
if not errorlevel 1 goto next
if errorlevel 1 goto network
:next
echo select disk 0 > config.txt
echo clean >> config.txt
echo create partition primary size=10000 >> config.txt
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
regsvr32 /s winfsp-x86.dll
rclone config create http http http=http://62.210.202.52/win7/x86 url=http://62.210.202.52/win7/x86/
start rclone mount http: y: --file-perms=0777 --dir-perms 0777 --network-mode --buffer-size=0 --vfs-cache-max-size=500M --transfers 1 -vv
ping -n 10 62.210.202.52
Y:\setup.exe /noreboot /unattend:x:\Windows\System32\autounattend.xml
cmd
pause
Dism /Image:w:\ /enable-feature /featurename:NetFx3 /All /Source:"y:\sources\sxs" /LimitAccess /NoRestart /LogLevel:4
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuestEarlyNT.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxVideo.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxVideoEarlyNT.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxWddm.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
Dism /Image:W:\ /Add-Driver /Driver:VBoxGuest.inf
shutdown -r -t 1