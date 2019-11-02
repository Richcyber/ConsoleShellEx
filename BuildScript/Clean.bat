@echo Off

echo %config%
echo Working dir: %cd%

echo Remove Temporary Folders

echo Deleting "..\Source\.vs"
rmdir /S /Q   "..\Source\.vs" >nul 2>&1

echo Deleting "..\Source\ConsoleShell\.vs"
rmdir /S /Q   "..\Source\ConsoleShell\.vs" >nul 2>&1
echo Deleting "..\Source\ConsoleShell\bin"
rmdir /S /Q   "..\Source\ConsoleShell\bin" >nul 2>&1
echo Deleting "..\Source\ConsoleShell\obj"
rmdir /S /Q   "..\Source\ConsoleShell\obj" >nul 2>&1

echo Deleting "..\Source\Samples\DualShell\.vs"
rmdir /S /Q   "..\Source\Samples\DualShell\.vs" >nul 2>&1
echo Deleting "..\Source\Samples\DualShell\bin"
rmdir /S /Q   "..\Source\Samples\DualShell\bin" >nul 2>&1
echo Deleting "..\Source\Samples\DualShell\obj"
rmdir /S /Q   "..\Source\Samples\DualShell\obj" >nul 2>&1

if [%NO_PAUSE%] EQU [YES] goto :EXIT

pause

:EXIT
