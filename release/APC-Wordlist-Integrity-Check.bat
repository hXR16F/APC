@echo off & setlocal EnableDelayedExpansion
if exist "Integrity-Check.lst" del /F /Q "Integrity-Check.lst"
if exist "Integrity-Check.txt" del /F /Q "Integrity-Check.txt"
cd Wordlists && dir /B *.txt > "Integrity-Check.lst"
if exist "Integrity-Check.lst" (
	for /F "tokens=1*" %%i in (Integrity-Check.lst) do (
		find /N "^!" %%i >> "Integrity-Check.txt"
		find /N "%%" %%i >> "Integrity-Check.txt"
		find /N "^^" %%i >> "Integrity-Check.txt"
		find /N "&" %%i >> "Integrity-Check.txt"
		find /N "(" %%i >> "Integrity-Check.txt"
		find /N ")" %%i >> "Integrity-Check.txt"
		find /N "|" %%i >> "Integrity-Check.txt"
		find /N "<" %%i >> "Integrity-Check.txt"
		find /N ">" %%i >> "Integrity-Check.txt"
	)
	del /F /Q "Integrity-Check.lst" > nul
	if exist "Integrity-Check.txt" (
		start Integrity-Check.txt && (
			timeout /T 1 /NOBREAK > nul
			del /F /Q "Integrity-Check.txt"
		)
	)
	exit
)
exit