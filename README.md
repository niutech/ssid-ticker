# SSID Ticker
© 2017 Jerzy Głowacki, Apache License 2.0

![Screenshot](https://i.imgur.com/WnUbaNt.png)

This script takes a current _Common Air Quality Index_ ([CAQI](https://www.airqualitynow.eu/about_indices_definition.php)) for a provided location from the [Airly API](https://airly.eu/en/api/) and shows it as a _Service Set Identifier_ ([SSID](https://www.webopedia.com/TERM/S/SSID.html)) using [Wireless Hosted Network](https://msdn.microsoft.com/en-us/library/windows/desktop/dd815243.aspx) on Windows. It also displays an ASCII sparkline of the last 12-hour pollution level. The script can continuously process fresh numerical data from any JSON API using just [curl](https://curl.haxx.se/) and [jq](https://stedolan.github.io/jq/).

In order for SSID Ticker to work, your wireless network card has to support Hosted Network. You can check it in Windows Command Prompt by running: `netsh wlan show drivers`.

SSID Ticker sets a random Wi-Fi passphrase each time it runs, so that nobody could connect to the virtual Wi-Fi hotspot.