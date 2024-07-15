@echo off
wpeinit
:network
ping -n 1 google.fr | find "TTL"
if not errorlevel 1 goto next
if errorlevel 1 set goto network
:next
net use y: \\62.210.202.52\win7 /user:62.210.202.52\andy 30019295Ab /persistent:yes
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
Y:\setup.exe /unattend:y:\autounattend\x86\homepremium\english\legacy\autounattend.xml