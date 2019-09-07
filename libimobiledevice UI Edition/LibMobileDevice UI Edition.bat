@ECHO OFF
C:
CD\
CLS

:MENU
CLS

ECHO ============= LibMobileDevice UI Edition =============
ECHO -------------------------------------
ECHO 1.  Get Boot Nonce
ECHO 2.  Start System logging
ECHO 3.  Selection 3
ECHO 4.  Selection 4
ECHO 5.  Selection 5
ECHO 6.  Selection 6
ECHO 7.  Selection 7
ECHO -------------------------------------
ECHO 8.  Selection 8
ECHO -------------------------------------
ECHO 9.  Selection 9
ECHO -------------------------------------
ECHO ==========PRESS 'Q' TO QUIT==========
ECHO.

SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO GetBootNonce
IF /I '%INPUT%'=='2' GOTO StartSystemLogging
IF /I '%INPUT%'=='3' GOTO Selection3
IF /I '%INPUT%'=='4' GOTO Selection4
IF /I '%INPUT%'=='5' GOTO Selection5
IF /I '%INPUT%'=='6' GOTO Selection6
IF /I '%INPUT%'=='7' GOTO Selection7
IF /I '%INPUT%'=='8' GOTO Selection8
IF /I '%INPUT%'=='9' GOTO Selection9
IF /I '%INPUT%'=='Q' GOTO Quit

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

:StartSystemLogging

idevicesyslog

:Selection3

and in here too...

:Selection4

and so on

:Selection5

and so on

:Selection6

and so on

:Selection7

and so on

:Selection8

and so on

:Selection9

and so on

:Quit
CLS

ECHO ==============THANKYOU===============
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE>NUL
GOTO MENU