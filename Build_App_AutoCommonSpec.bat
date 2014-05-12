@echo OFF

REM %1 can be WM, CE or Android or Blank
set buildWM=no
set buildCE=no
set buildAndroid=no
if "%1" == "WM" (set buildWM=yes)
if "%1" == "CE" (set buildCE=yes)
if "%1" == "Android" (set buildAndroid=yes)

REM navigate to testing repository
cd ..\git\RMS-Testing

REM Download the latest sources
call git pull

REM Build auto_common_spec
cd auto\feature_def\auto_common_spec
:buildingCE:
if %buildCE%==no (goto buildingWM)
call rake clean:wince
call rake device:wince:production
:buildingWM:
if %buildWM%==no (goto buildingAndroid)
call rake clean:wm
call rake device:wm:production
:buildingAndroid:
if %buildAndroid%==no (goto builtAll)
call rake clean:android
call rake device:android:production
:builtAll:

:checkingCE:
if %buildCE%==no (goto checkingWM)
if not exist ".\bin\target\MC3000c50b (ARMV4I)\auto_common_spec.cab" goto buildFailed
:checkingWM:
if %buildWM%==no (goto checkingAndroid)
if not exist ".\bin\target\MC3000c50b (ARMV4I)\auto_common_spec.cab" goto buildFailed
:checkingAndroid:
if %buildAndroid%==no (goto checkedAll)
if not exist ".\bin\target\android\auto_common_spec_signed.apk" goto buildFailed
:checkedAll:

goto buildSuccess
:buildFailed:
echo "Failed to build Test App: auto_common_spec" %1
cd ..\..\..\
exit 1
:buildSuccess:
echo "Building test apps has succeeded (auto_common_spec - %1)"
cd ..\..\..\



REM Navigate back to the jobs directory
cd ..\..\jobs
exit 0