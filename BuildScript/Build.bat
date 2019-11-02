@echo Off
setlocal
set config=%1
if "%config%" == "" (
   set config=Release
)

if "%NuGet%" == "" (
   set NuGet=NuGet.exe
)

echo Working dir: %cd%

echo Create Build Folders

del /F /S /Q "..\Build"

mkdir ..\Build
mkdir ..\Build\lib
mkdir ..\Build\lib\netstandard2.0

set NO_PAUSE=YES
call .\Clean.bat

echo Compile Projects

dotnet build /p:Configuration="%config%" /p:Platform="AnyCPU" ..\Source\ConsoleShellEx\ConsoleShellEx.csproj
copy "..\Source\ConsoleShellEx\bin\%config%\netstandard2.0\ConsoleShellEx.dll" "..\Build\lib\netstandard2.0"
copy "..\Source\ConsoleShellEx\bin\%config%\netstandard2.0\ConsoleShellEx.pdb" "..\Build\lib\netstandard2.0"
del /F /S /Q "..\Source\ConsoleShellEx\bin"
del /F /S /Q "..\Source\ConsoleShellEx\obj"

echo Assembly information

powershell -Command "[Reflection.Assembly]::ReflectionOnlyLoadFrom(\"%cd%\..\Build\lib\netstandard2.0\ConsoleShellEx.dll\").ImageRuntimeVersion"
certUtil -hashfile "..\Build\lib\netstandard2.0\ConsoleShellEx.dll" md5

powershell -Command "$version = [Diagnostics.FileVersionInfo]::GetVersionInfo('..\Build\lib\netstandard2.0\ConsoleShellEx.dll').FileVersion;[IO.File]::WriteAllLines('..\\Build\\SetPackageVersion.bat', 'set version=' + $version)"
call ..\Build\SetPackageVersion.bat
call %NuGet% pack "ConsoleShellEx.nuspec" -NoPackageAnalysis -verbosity detailed -OutputDirectory ..\Build -Version %version% -p Configuration="%config%"
