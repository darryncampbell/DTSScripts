@echo OFF

REM navigate to testing repository
cd ..\git\RMS-Testing

REM Download the latest sources
call git pull

REM Build manual_common_spec
cd manual\feature_def\manual_common_spec
rem call rake clean:wince
rem call rake device:wince:production
call rake clean:wm
call rake device:wm:production
call rake clean:android
call rake device:android:production

if not exist ".\bin\target\MC3000c50b (ARMV4I)\manual_common_spec.cab" goto buildFailed
rem if not exist ".\bin\target\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\manual_common_spec.cab" goto buildFailed
if not exist ".\bin\target\android\manual_common_spec_signed.apk" goto buildFailed

goto buildSuccess
:buildFailed:
echo "Failed to build Test App: manual_common_spec"
cd ..\..\..\
exit 1
:buildSuccess:
echo "Building test apps has succeeded (manual_common_spec)"
cd ..\..\..\



REM Navigate back to the jobs directory
cd ..\..\jobs