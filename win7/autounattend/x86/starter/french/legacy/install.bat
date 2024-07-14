@echo off
wpeinit
pnputil /i /a x:\Windows\System32\balloon.inf
pnputil /i /a x:\Windows\System32\netkvm.inf
pnputil /i /a x:\Windows\System32\vioscsi.inf
pnputil /i /a x:\Windows\System32\viostor.inf
pnputil /i /a x:\Windows\System32\VBoxGuest.inf
pnputil /i /a x:\Windows\System32\e1d68x64.inf
pnputil /i /a x:\Windows\System32\VBoxGuestEarlyNT.inf
pnputil /i /a x:\Windows\System32\VBoxMouse.inf
pnputil /i /a x:\Windows\System32\VBoxVideo.inf
pnputil /i /a x:\Windows\System32\VBoxVideoEarlyNT.inf
pnputil /i /a x:\Windows\System32\VBoxWddm.inf
pnputil /i /a x:\Windows\System32\fwcfg.inf
pnputil /i /a x:\Windows\System32\pvpanic-pci.inf
pnputil /i /a x:\Windows\System32\pvpanic.inf
pnputil /i /a x:\Windows\System32\qemupciserial.inf
pnputil /i /a x:\Windows\System32\qxldod.inf
pnputil /i /a x:\Windows\System32\vioprot.inf
pnputil /i /a x:\Windows\System32\viofs.inf
pnputil /i /a x:\Windows\System32\viogpudo.inf
pnputil /i /a x:\Windows\System32\vioinput.inf
pnputil /i /a x:\Windows\System32\viorng.inf
pnputil /i /a x:\Windows\System32\vioser.inf
net start dnscache
rem @powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
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
regsvr32 /s winfsp-x86.dll
rem setup-x86.exe --no-admin --root X:\Cygwin\ --quiet-mode --no-shortcuts --no-startmenu --allow-unsupported-windows --arch x86 --force-current --no-desktop --no-replaceonreboot --no-verify --no-version-check --no-warn-deprecated-windows --no-write-registry --only-site --site https://mirrors.kernel.org/sourceware/cygwin-archive/20221123/ -l X:\Cygwin\\var\cache\apt\packages --packages dos2unix,wget,ca-certificates
rem cmd
rem rclone config create http http http=https://depot-andykimpe.sourceforge.net/win7/x86/starter url=https://depot-andykimpe.sourceforge.net/win7/x86/starter/
rem rclone config create http http http=http://62.210.202.52/win7/x86 url=http://62.210.202.52/win7/x86/
rem echo 195.201.179.80 andykimpe.ovh > x:\Windows\System32\Drivers\etc\hosts
rem rclone config create http http http=http://andykimpe.ovh/starter url=http://andykimpe.ovh/starter/
rem rclone config create ftp ftp host=195.201.179.80 user=andykimp pass=OMG*xvh0d$J.
rem rclone config create http2 ftp host=ftpupload.net user=ezyro_36894543 pass=e452b32bf
rem rclone config create http combine upstreams="dir1=http1:/htdocs/ dir2=http2:/htdocs/"
rem rclone config create http http http=http://10.0.0.200/win7/x86/starter url=http://10.0.0.200/win7/x86/starter/
rem start rclone mount 7starterx86: y: --transfers 4 --checkers 8 --vfs-cache-mode=full --dir-cache-time=5000h --poll-interval=10s --rc --rc-addr=:5572 --rc-no-auth --drive-pacer-min-sleep=10ms --drive-pacer-burst=200 --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127.0" --file-perms=0777 --dir-perms 0777 --network-mode -vv
rem start rclone mount 7starterx86: y: --file-perms=0777 --dir-perms 0777 --network-mode --buffer-size=0 -vv --vfs-cache-max-size=100M --vfs-cache-poll-interval 5m --bwlimit 90M --transfers 1



rem mkdir s:\sources\
rem mkdir s:\sources\dlmanifests\
rem mkdir s:\sources\bitsextensions-server\
rem mkdir s:\sources\microsoft-activedirectory-webservices-dl\
rem mkdir s:\sources\microsoft-windows-adfs-dl\
rem mkdir s:\sources\microsoft-windows-bluetooth-config\
rem mkdir s:\sources\microsoft-windows-com-complus-setup-dl\
rem mkdir s:\sources\microsoft-windows-com-dtc-setup-dl\
rem mkdir s:\sources\microsoft-windows-dhcpservermigplugin-dl\
rem mkdir s:\sources\microsoft-windows-directoryservices-adam-dl\
rem mkdir s:\sources\microsoft-windows-iasserver-migplugin\
rem mkdir s:\sources\microsoft-windows-iasserver-migplugin\en-us\
rem mkdir s:\sources\microsoft-windows-ie-clientnetworkprotocolimplementation\
rem mkdir s:\sources\microsoft-windows-iis-dl\
rem mkdir s:\sources\microsoft-windows-international-core-dl\
rem mkdir s:\sources\microsoft-windows-internet-naming-service-runtime\
rem mkdir s:\sources\microsoft-windows-mediaplayer-drm-dl\
rem mkdir s:\sources\microsoft-windows-mediaplayer\
rem mkdir s:\sources\microsoft-windows-msmq-messagingcoreservice\
rem mkdir s:\sources\microsoft-windows-ndis\
rem mkdir s:\sources\microsoft-windows-networkbridge\
rem mkdir s:\sources\microsoft-windows-networkloadbalancing-core\
rem mkdir s:\sources\microsoft-windows-offlinefiles-dl\
rem mkdir s:\sources\microsoft-windows-performancecounterinfrastructure-dl\
rem mkdir s:\sources\microsoft-windows-performancecounterinfrastructureconsumer-dl\
rem mkdir s:\sources\microsoft-windows-rasconnectionmanager\
rem mkdir s:\sources\microsoft-windows-rasserver-migplugin\
rem mkdir s:\sources\microsoft-windows-shmig-dl\
rem mkdir s:\sources\microsoft-windows-storagemigration\
rem mkdir s:\sources\microsoft-windows-storagemigration\en-us\
rem mkdir s:\sources\microsoft-windows-sxs\
rem mkdir s:\sources\microsoft-windows-tapisetup\
rem mkdir s:\sources\microsoft-windows-terminalservices-licenseserver\
rem mkdir s:\sources\microsoft-windows-textservicesframework-migration-dl\
rem mkdir s:\sources\microsoft-windows-textservicesframework-migration-dl\
setup-x86.exe --no-admin --root S:\Cygwin\ --quiet-mode --no-shortcuts --no-startmenu --allow-unsupported-windows --arch x86 --force-current --no-desktop --no-replaceonreboot --no-verify --no-version-check --no-warn-deprecated-windows --no-write-registry --only-site --site https://mirrors.kernel.org/sourceware/cygwin-archive/20221123/ -l S:\Cygwin\var\cache\apt\packages --packages dos2unix,wget,ca-certificates
rem cd s:\
S:\Cygwin\bin\wget.exe https://archive.org/download/windows_7_professional_with_sp1_original_latest_iso_multilanguage/fr_windows_7_professional_with_sp1_x86_dvd_u_677092.iso -O s:\fr_windows_7_professional_with_sp1_x86_dvd_u_677092.iso
7z x s:\fr_windows_7_professional_with_sp1_x86_dvd_u_677092.iso -o s:\
rem rclone copy http:\sources s:\sources -vv
rem start rclone mount http: y: --file-perms=0777 --dir-perms 0777 --network-mode --buffer-size=0 --vfs-cache-max-size=500M -vv
rem net use y: \\195.201.179.80\domains\andykimpe.ovh\public_html\starter /user:"andykimp" "OMG*xvh0d$J."
rem FTPUSE y: 195.201.179.80 OMG*xvh0d$J. /USER:andykimp
rem  --bwlimit 1M --buffer-size=0
rem  ping -n 5 62.210.202.52
rem wimextract y:\sources\install.swm 1 / --dest-dir=w:\ --ref="y:\sources\install*.swm"
s:\sources\setup.exe /noreboot /unattend:x:\Windows\System32\autounattend.xml
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
