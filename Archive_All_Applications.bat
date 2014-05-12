@echo off
REM This batch script will archive all applications
REM e.g. Archive_Files.bat C:\git\RMS-Testing\manual\feature_def\manual_common_spec\ manual_common_spec
REM e.g. Archive_Files.bat C:\git\RMS-Testing\auto\feature_def\auto_common_spec\ auto_common_spec

NET USE Z: \\192.168.0.5\Public\MotorolaSolutions


CALL Archive_Files.bat C:\git\RMS-Testing\manual\feature_def\manual_common_spec\ manual_common_spec
IF ERRORLEVEL 1 GOTO errorHandling

CALL Archive_Files.bat C:\git\RMS-Testing\auto\feature_def\auto_common_spec\ auto_common_spec
IF ERRORLEVEL 1 GOTO errorHandling

CALL Archive_Files.bat C:\git\JavascriptTestsDCC\ JavascriptTests
IF ERRORLEVEL 1 GOTO errorHandling

rem CALL Archive_Files.bat C:\git\IndustrialBrowser\Implementation\MEB\ MEB
rem IF ERRORLEVEL 1 GOTO errorHandling

echo All applications successfully archived
exit 0

:errorHandling
exit 1

