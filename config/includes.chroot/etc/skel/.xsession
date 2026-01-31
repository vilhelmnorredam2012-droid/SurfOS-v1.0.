#!/bin/sh
unclutter -idle 0.1 -root &  # Skjul mus
chromium --kiosk --no-first-run --noerrdialogs --disable-infobars --incognito https://www.startpage.com
