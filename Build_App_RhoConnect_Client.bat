@echo OFF

REM navigate to testing repository
cd ..\git\rhoconnect-client\

REM Download the latest sources
call git pull

REM Build manual_common_spec
cd spec\rhoconnect_spec_js
call rake clean:wince
call rake device:wince:production
call rake clean:wm
call rake device:wm:production
call rake clean:android
call rake device:android:production

if not exist ".\bin\target\MC3000c50b (ARMV4I)\JavascriptTests.cab" goto buildFailed
if not exist ".\bin\target\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\JavascriptTests.cab" goto buildFailed
if not exist ".\bin\target\android\JavascriptTests_signed.apk" goto buildFailed

goto buildSuccess
:buildFailed:
pwd
echo "Failed to build Test App: RhoConnect ClientSpec"
cd ..\..\
exit 1
:buildSuccess:
echo "Building test apps has succeeded (RhoConnect Client Spec)"
cd ..\..\



REM Navigate back to the jobs directory
cd ..\..\jobs