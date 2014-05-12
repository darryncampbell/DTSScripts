@echo off
REM This batch script will save the files associated with the project given on the command line to the archive area
REM %1 is the project bin directory
REM %2 is the CAB or APK file name
REM e.g. Archive_Files.bat C:\git\RMS-Testing\manual\feature_def\manual_common_spec\ manual_common_spec
REM e.g. Archive_Files.bat C:\git\RMS-Testing\auto\feature_def\auto_common_spec\ auto_common_spec
cd %1
pwd

NET USE Z: \\192.168.0.5\Public\MotorolaSolutions

if not exist ".\bin\target\MC3000c50b (ARMV4I)\%2.cab" goto buildFailed
rem if not exist ".\bin\target\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\%2.cab" goto buildFailed
if not exist ".\bin\target\android\%2_signed.apk" goto buildFailed

REM obtain our current gem version
for /f "delims=" %%a in ('gem list rhoelements') do @set foobar=%%a
@set f1=%foobar:~13,100%
@set folderName=RMS_%f1:~0,-1%
REM folderName now contains the required folderName
echo %folderName%

REM create the folder
rem rmdir /S /Q z:\%folderName%
mkdir z:\%folderName%
echo z:\%folderName%
mkdir "z:\%folderName%\MC3000c50b (ARMV4I)\"
rem mkdir "z:\%folderName%\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\"
mkdir "z:\%folderName%\android\"

REM Copy the builds to the archive storage
copy ".\bin\target\MC3000c50b (ARMV4I)\%2.cab" "z:\%folderName%\MC3000c50b (ARMV4I)\%2.cab" /Y
rem copy ".\bin\target\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\%2.cab" "z:\%folderName%\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\%2.cab" /Y
copy ".\bin\target\android\%2_signed.apk" "z:\%folderName%\android\%2.apk" /Y

REM Double check the builds were copied successfully
if not exist "z:\%folderName%\MC3000c50b (ARMV4I)\%2.cab" goto buildFailed
rem if not exist "z:\%folderName%\Windows Mobile 6.5.3 Professional DTK (ARMV4I)\%2.cab" goto buildFailed
if not exist "z:\%folderName%\android\%2.apk" goto buildFailed


goto buildSuccess
:buildFailed:
pwd
echo "Failed to Archive Files: %2 (%1)"

exit 1

:buildSuccess:
echo "Archiving Files successful: %2 (%1)"

