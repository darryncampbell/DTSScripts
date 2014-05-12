@echo off
setlocal enableDelayedExpansion

for /l %%y in (3, -1, 1) do (
for /l %%x in (80, -1, 1) do (
set url=http://rhomobile-suite.s3.amazonaws.com/4.%%y/4.%%y.0.beta.%%x/rhodes-4.%%y.0.beta.%%x.gem
set url2=http://rhomobile-suite.s3.amazonaws.com/4.%%y/4.%%y.0.beta.%%x/rhoelements-4.%%y.0.beta.%%x.gem
set url3=http://rhomobile-suite.s3.amazonaws.com/4.%%y/4.%%y.0.beta.%%x/rhoconnect-client-4.%%y.0.beta.%%x.gem
set filename=rhodes-4.%%y.0.beta.%%x.gem
wget -q --spider !url! && goto foundURL
)
)
goto urlNotFound

:foundURL:
echo Found URL: !url!

if exist !filename! (
	echo File already exists
rem 	goto endOfScript
) else (
	echo gem does not exist, downloading...
	del /Q *.gem
    wget !url!
	wget !url2!
	wget !url3!
)
REM Installing RhoElements
rem call install.bat !filename!
call gem uninstall -a -x rhodes
call gem uninstall -a -x rhoelements
call gem uninstall -a -x rhoconnect-client

call gem install --no-rdoc --no-ri rhodes
call gem install --no-rdoc --no-ri rhoelements
call gem install --no-rdoc --no-ri rhoconnect-client

rem pause.
goto endOfScript

:urlNotFound:
echo No URL Found
exit 1

:endOfScript:
echo Gems Installed
exit 0
