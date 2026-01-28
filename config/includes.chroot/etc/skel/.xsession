#!/bin/sh

xset s noblank
xset s off
xset -dpms

openbox-session &

exec chromium --kiosk --incognito --no-first-run --noerrdialogs --disable-infobars https://www.startpage.com
