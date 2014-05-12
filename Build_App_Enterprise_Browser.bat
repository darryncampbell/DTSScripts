@echo OFF

REM navigate to testing repository
cd ..\git\IndustrialBrowser

REM Download the latest sources
call git pull

REM Build MEB
cd Implementation\MEB
rem call rake clean:wince
rem call rake device:wince:production
call rake clean:wm
call rake device:wm:production
call rake clean:android
call rake device:android:production

if not exist ".\bin\target\MC3000c50b (ARMV4I)\MEB.cab" goto buildFailed
rem if not exist ".\bin\target\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\MEB.cab" goto buildFailed
if not exist ".\bin\target\android\MEB_signed.apk" goto buildFailed

goto buildSuccess
:buildFailed:
pwd
echo "Failed to build Test App: MEB"
cd ..\..\
exit 1
:buildSuccess:
echo "Building test apps has succeeded (MEB)"
cd ..\..\



REM Navigate back to the jobs directory
cd ..\..\jobs