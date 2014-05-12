@echo OFF
setlocal enableDelayedExpansion

rem %1 is Y if the user is requesting a beta build, else N
rem %2 is the major version number
rem %3 is the first minor version number
rem %4 is the second minor version number
rem %5 is the beta build number (if applicable)

set root=http://rhomobile-suite.s3.amazonaws.com/
if "%1"=="Y" (
	echo Requesting Beta Build
	echo Requesting Build %2.%3.%4.beta.%5
	echo Will Download %2.%3/%2.%3.%4.beta.%5/[package]-%2.%3.%4.beta.%5.gem
	set url1=%root%%2.%3/%2.%3.%4.beta.%5/rhodes-%2.%3.%4.beta.%5.gem
	set url2=%root%%2.%3/%2.%3.%4.beta.%5/rhoelements-%2.%3.%4.beta.%5.gem
	set url3=%root%%2.%3/%2.%3.%4.beta.%5/rhoconnect-client-%2.%3.%4.beta.%5.gem
	wget -q --spider !url1! && goto foundURL
	
	
) else (
	echo Not requesting beta build
rem 	4.0/4.0.0.1/rhodes-4.0.0.1.gem 
	echo Requesting Build %2.%3.%4
	echo Will Download %2.%3/%2.%3.%4/[package]-%2.%3.%4.gem
	echo or %2.%3/%2.%3.%4.%5/[package]-%2.%3.%4.%5.gem
 	set url1=%root%%2.%3/%2.%3.%4.%5/rhodes-%2.%3.%4.%5.gem
 	set url2=%root%%2.%3/%2.%3.%4.%5/rhoelements-%2.%3.%4.%5.gem
 	set url3=%root%%2.%3/%2.%3.%4.%5/rhoconnect-client-%2.%3.%4.%5.gem
 	wget -q --spider !url1! && goto foundURL
 	echo Did not find specified build, !url1!, trying alternative format
	set url1=%root%%2.%3/%2.%3.%4/rhodes-%2.%3.%4.gem
	set url2=%root%%2.%3/%2.%3.%4/rhoelements-%2.%3.%4.gem
	set url3=%root%%2.%3/%2.%3.%4/rhoconnect-client-%2.%3.%4.gem
 	wget -q --spider !url1! && goto foundURL
)


:urlNotFound:
echo Specified Build, %url1%, could not be located on the Server
exit 1
goto endScript

:foundURL:
echo Specified Build, %url1%, was found, downloading
del /Q *.gem
wget %url1%
wget %url2%
wget %url3%

REM Installing RhoElements
call gem uninstall -a -x rhodes
call gem uninstall -a -x rhoelements
call gem uninstall -a -x rhoconnect-client

call gem install --no-rdoc --no-ri rhodes
call gem install --no-rdoc --no-ri rhoelements
call gem install --no-rdoc --no-ri rhoconnect-client

:endScript:
exit 0
