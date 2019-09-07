@echo off
echo Ensure this script inside of LibMobiledevice
pause
idevice_id -l > "C:\Users\%USERNAME%\Desktop\UDUD.txt"
set /p UDID=<C:\Users\%USERNAME%\Desktop\UDUD.txt
del C:\Users\%USERNAME%\Desktop\UDUD.txt
ideviceinfo > "C:\Users\%USERNAME%\Desktop\DeviceData.txt"

FOR /F "tokens=*" %%a in ('find /I "UniqueChipID:" ^<C:\Users\%USERNAME%\Desktop\DeviceData.txt') do SET ECID=%%a

FOR /F "tokens=*" %%a in ('find /I "ProductType:" ^<C:\Users\%USERNAME%\Desktop\DeviceData.txt') do SET Identifier=%%a

FOR /F "tokens=*" %%a in ('find /I "ProductVersion:" ^<C:\Users\%USERNAME%\Desktop\DeviceData.txt') do SET IOS=%%a


del C:\Users\%USERNAME%\Desktop\DeviceData.txt

ideviceenterrecovery %UDID%

cls


timeout 15 /nobreak


irecovery -q > "C:\Users\%USERNAME%\Desktop\Nonce.txt"

FOR /F "tokens=*" %%a in ('find /I "NONC:" ^<C:\Users\%USERNAME%\Desktop\Nonce.txt') do SET Nonce=%%a

del C:\Users\%USERNAME%\Desktop\Nonce.txt
irecovery -n
cls
echo See Nonce and UDID Below
echo %Nonce%
echo %ECID%	(ECID in DECIMAL)
echo %Identifier%
echo.
echo.
echo %IOS%
echo UDID %UDID%


pause

