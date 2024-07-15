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