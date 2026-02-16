#!/bin/sh

# Skjul musemarkør
unclutter -idle 0.1 -root &

# Start Chromium i kiosk-mode
chromium \
  --kiosk \
  --incognito \
  --no-first-run \
  --noerrdialogs \
  --disable-infobars \
  --disable-breakpad \
  --no-sandbox \
  --disable-gpu \
  https://www.startpage.com
