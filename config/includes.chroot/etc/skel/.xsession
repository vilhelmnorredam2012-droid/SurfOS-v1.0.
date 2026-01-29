#!/bin/sh

xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 &

openbox-session &

exec chromium --kiosk --incognito --no-first-run --noerrdialogs --disable-infobars https://www.startpage.com
