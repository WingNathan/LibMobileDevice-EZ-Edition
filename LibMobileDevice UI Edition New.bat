@ECHO OFF
C:
CLS
:MENU
CLS

ideviceinfo > "C:\Users\%USERNAME%\Desktop\DeviceData.txt"

FOR /F "tokens=*" %%a in ('find /I "DeviceName:" ^<C:\Users\%USERNAME%\Desktop\DeviceData.txt') do SET DeviceName=%%a
FOR /F "tokens=*" %%a in ('find /I "ProductType:" ^<C:\Users\%USERNAME%\Desktop\DeviceData.txt') do SET Identifier=%%a
FOR /F "tokens=*" %%a in ('find /I "ProductVersion:" ^<C:\Users\%USERNAME%\Desktop\DeviceData.txt') do SET IOS=%%a
FOR /F "tokens=*" %%a in ('find /I "UniqueChipID:" ^<C:\Users\%USERNAME%\Desktop\DeviceData.txt') do SET ECID=%%a


del C:\Users\%USERNAME%\Desktop\DeviceData.txt


ECHO %DeviceName%
ECHO %Identifier%
ECHO %IOS%
ECHO ============= LibMobileDevice UI Edition =============
ECHO -------------------------------------
ECHO 1.  Get Boot Nonce
ECHO 2.  Start System Logging
ECHO 3.  Export Crash Logs
ECHO 4.  Force Enter Recovery
ECHO 5.  Force Exit Recovery
ECHO 6.  NotConfigured
ECHO 7.  Enter Custom Command
ECHO -------------------------------------
ECHO 8.  Backup Device (Full)
ECHO 9.  Restore Device (Full)
ECHO -------------------------------------
ECHO Q.  Press Q to exit the application
ECHO.
ECHO.
ECHO Note - If your device info does not show at the top of this page
ECHO please plug it in and reload this exe.
ECHO.
ECHO.
SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO GetBootNonce
IF /I '%INPUT%'=='2' GOTO StartSystemLogging
IF /I '%INPUT%'=='3' GOTO ExportCrashLogs
IF /I '%INPUT%'=='4' GOTO ForceEnterRecovery
IF /I '%INPUT%'=='5' GOTO ForceExitRecovery
IF /I '%INPUT%'=='6' GOTO NotConfigured
IF /I '%INPUT%'=='7' GOTO EnterCustomCommand
IF /I '%INPUT%'=='8' GOTO DeviceBackup
IF /I '%INPUT%'=='9' GOTO DeviceRestore
IF /I '%INPUT%'=='Q' GOTO END

CLS

ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [1-9] or select 'Q' to quit.
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU

:GetBootNonce


idevice_id -l > "C:\Users\%USERNAME%\Desktop\UDUD.txt"
set /p UDID=<C:\Users\%USERNAME%\Desktop\UDUD.txt
del C:\Users\%USERNAME%\Desktop\UDUD.txt


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
pause
GOTO MENU

:StartSystemLogging

idevicesyslog

:ExportCrashLogs
CD C:\Users\%USERNAME%\Desktop
mkdir CrashLogs
ECHO This May Take Some Time
idevicecrashreport -k C:\Users\%USERNAME%\Desktop\CrashLogs
GOTO MENU
:NotConfigured
ECHO Why'd you press this :)
Pause

GOTO MENU
:EnterCustomCommand


set /p Command="Enter your LibMobileDevice Command Now: "
%Command%



GOTO EnterCustomCommand


:ForceEnterRecovery
idevice_id -l > "C:\Users\%USERNAME%\Desktop\UDUD.txt"
set /p UDID=<C:\Users\%USERNAME%\Desktop\UDUD.txt
del C:\Users\%USERNAME%\Desktop\UDUD.txt
ideviceenterrecovery %UDID%

GOTO MENU


:ForceExitRecovery
irecovery -n
GOTO MENU

:DeviceBackup


set /p BackupLocation="Paste Backup Location Now: "
idevicebackup2 backup --full %BackupLocation%

GOTO MENU
:DeviceRestore
set /p RestoreLocation="Paste Location of Backup Location now: "
idevicebackup2 restore %RestoreLocation%


GOTO MENU
:Quit
CLS

ECHO ==============THANKYOU===============
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO GO TO MAIN MENU======

PAUSE>NUL
GOTO MENU

:END
CLS

ECHO ==============THANKYOU===============
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO GO TO CONTINUE======

PAUSE>NUL
