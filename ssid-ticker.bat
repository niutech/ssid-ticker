@echo off
if "%~1" equ ":loop" goto loop
chcp 65001 >NUL 2>&1
echo SSID Ticker 1.0
echo © 2017 Jerzy Głowacki, Apache License 2.0
echo.

where /q curl || echo This script requires curl from https://curl.haxx.se/ && exit /b 1
where /q jq || echo This script requires jq from https://stedolan.github.io/jq/ && exit /b 1

set URL="http://airapi.airly.eu/v1/mapPoint/measurements?latitude=50.02831&longitude=19.9598&historyHours=12&historyResolutionHours=1"
set APIKEY=f084fcab76f74d6d96d7481be928dcbe
set FILTER="""""CAQI:"""", $space, ([.history[].measurements.pollutionLevel | if .==1 then """"_"""" elif .==2 then """".."""" elif.==3 then """"··"""" elif .==4 then """"¨"""" else """"!!"""" end][12:] | join("""""")), $space, (.currentMeasurements.airQualityIndex | floor)"
set SSID=SSID Ticker Error
set /a KEY=%RANDOM%*10000000
set TIMEOUT=600

cmd /d /c "%~f0" :loop %*
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=disallow
exit /b

:loop
echo.
echo Downloading data...
for /f "tokens=*" %%i in ('curl -s -H "Accept: application/json" -H "apikey: %APIKEY%" %URL% ^| jq -j --arg space " " %FILTER%') do set SSID=%%i
echo.
echo %SSID%
echo.
netsh wlan set hostednetwork mode=allow ssid="%SSID%" key="%KEY%"
netsh wlan start hostednetwork
timeout /t %TIMEOUT% /nobreak && goto loop