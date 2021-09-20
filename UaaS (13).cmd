@ECHO OFF
ECHO One second...
ECHO Downloading helper executable (Waasp.exe)
powershell -ExecutionPolicy Bypass -Command "(New-Object Net.WebClient).DownloadFile('https://umbracoreleases.blob.core.windows.net/download/Waasp.exe', 'Waasp.exe')"

SET /P url="Clone URL: " 
SET /P alias="Namespace: "

REM From https://stackoverflow.com/a/33155502/5018
for %%a in ("%url%") do (
   set "urlName=%%~NXa"
)
REM Remove `.git` suffix
SET identifier=%urlName:.git=%

IF NOT EXIST %alias%.Web (
	git clone %url%
)

IF EXIST %identifier% REN %identifier% %alias%.Web

Waasp.exe "%CD%" %alias% %url%
DEL Waasp.exe /Q