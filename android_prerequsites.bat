@echo OFF

REM Build Android Test Results Writer
cd ../
cd git/Motorola-Extensions/build/ci/android/hybrid/TestResultsWriter
call mybuild.bat


rem Command to run tests on MC40
rem C:\git\Motorola-Extensions\build\ci\android\native>rake native:test_automation[7A3C00060B018010,'C:\git\RMS-Testing\auto\feature_def\auto_common_spec\bin\target\android\auto_common_spec_signed.apk','',com.rhomobile.auto_common_spec','']

rem When completed:
rem rake native:transfer_test_results_from_device[7A3C00060B018010]
rem set ERRORLEVEL=0

rem adb -s 7A3C00060B018010 logcat -d -v time | grep -v supplicant > test_results/7A3C00060B018010/logcat.logcat
rem call set ERRORLEVEL=0
rem then publish JUnit test result report