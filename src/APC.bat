:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off & mode 65,14 & title Archive Password Cracker by hXR16F & setlocal EnableDelayedExpansion & color 07

:: ========================================
rem set "filename=Example.rar"
rem set method=3
:: 1 - Wordlist, 2 - Brute-Force, 3 - Random Brute-Force
rem set digit=4
rem set digit2=10
:: if 1 = 1, 2 = 10, 3 = 100, 4 = 1000 etc. (only for Random Brute-Force)
rem set "wordlist=Wordlists/Top_1000.txt"
:: Dictionary (only for Wordlist)
:: ========================================

set tempvar=1
for /F "tokens=1* delims=" %%i in (input.ini) do (
		if "!tempvar!" EQU "1" set "filename=%%i"
		if "!tempvar!" EQU "2" set "method=%%i"
		if "!tempvar!" EQU "3" set "wordlist=%%i"
		if "!tempvar!" EQU "4" set "digit=%%i"
		set /A tempvar+=1
	)
)
del /F /Q input.ini > nul
if not exist "%filename%" exit

:: To remove '0' in %?:~1,1% in Random Brute-Force (Bugged)
rem call ac.bat c ^(10^!digit!-!digit!^)/10 digit2
rem call ac.bat r !digit2! 0 digit3

set "loop=1"
rd /S /Q cracked >nul 2>&1
md cracked >nul 2>&1
set "tim=%time:~0,8%" & set "dat=%date%"

if "%method%" EQU "1" set "methodName=Wordlist" & set "digit=-" & goto loopWord
if "%method%" EQU "2" set "methodName=Brute-Force" & set "digit=-" & goto loopBrute
if "%method%" EQU "3" set "methodName=Random Brute-Force" & goto loopBrute

:loopBrute
	if %method% EQU 3 (call :random_) else (call :brute_)
	cls
	(
		echo.&echo.&echo.
		echo;        Attempt  : #%loop%
		echo;        Trying   : %n%
		echo;        Started  : %dat% / %tim%
		echo;        Digits   : %digit%
		echo;        Filename : %filename%
		echo;        Method   : %methodName%
		echo;        Password : -
	)
	rem call unrar.exe e -inul -p%n% "%filename%" "cracked" && goto cracked
	call 7z.exe -y e -p%n% -ocracked "%filename%" >nul 2>&1 && goto cracked
	set "n=" & set /A loop+=1
	goto loopBrute
	
:loopWord
	for /F "tokens=1* delims= " %%i in (!wordlist!) do (
		set "n=%%i"
		cls
		(
			echo.&echo.&echo.
			echo;        Attempt  : #!loop!
			echo;        Trying   : !n!
			echo;        Started  : !dat! / !tim!
			echo;        Digits   : !digit!
			echo;        Filename : !filename!
			echo;        Method   : !methodName!
			echo;        Password : -
		)
		rem call unrar.exe e -inul -p!n! "!filename!" "cracked" && goto cracked
		call 7z.exe -y e -p!n! -ocracked "!filename!" >nul 2>&1 && goto cracked
		set "n=" & set /A loop+=1
	)
	cls
	(
		echo.&echo.&echo.
		echo;        Attempt  : #%loop% ^(End of dictionary^)
		echo;        Trying   : -
		echo;        Started  : %dat% / %tim%
		echo;        Digits   : %digit%
		echo;        Filename : %filename%
		echo;        Method   : %methodName%
		echo;        Password : -
	)
	rd /S /Q "cracked" >nul 2>&1
	for /L %%n in (0,0,1) do pause > nul

:cracked
	rem echo;"%filename%" : '%n%' >> APC.txt
	cls
	(
		echo.&echo.&echo.
		echo;        Attempt  : #%loop%
		echo;        Trying   : %n%
		echo;        Started  : %dat% / %tim%
		echo;        Digits   : %digit%
		echo;        Filename : %filename%
		echo;        Method   : %methodName%
		echo;        Password : '%n%'
	)
	rd /S /Q "cracked" >nul 2>&1
	for /L %%n in (0,0,1) do pause > nul
	
:random_
	for /L %%n in (1,1,!digit!) do (
		for /L %%m in (1,1,3) do set /A "__rand__=!random!*10/32768"
		set n=!n!!__rand__!
	)
	if !n! LSS !digit2! (
		set "n="
		call :random_
	)
	exit /B
	
:brute_
	set /A n=%loop%-1
	exit /B
	