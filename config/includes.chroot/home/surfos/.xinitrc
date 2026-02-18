#!/bin/sh

exec openbox-session
unclutter -idle 0.1 -root &
chromium --kiosk --incognito --no-first-run --noerrdialogs --disable-infobars --disable-gpu --no-sandbox https://www.startpage.com
