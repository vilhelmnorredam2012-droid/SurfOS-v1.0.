# SurfOS

SurfOS is a minimal live operating system that does one thing only:  
It boots straight into a full-screen Chromium browser opened on https://www.startpage.com.

No login screen, no terminal, no desktop environment, no file manager – just the internet.

**What happens when SurfOS boots?**
- The system boots directly into Chromium in kiosk mode (full-screen, no UI elements).
- The start page is always https://www.startpage.com (privacy-focused search engine).
- The user is "surfos" and is automatically logged in (no password required).
- Danish keyboard layout and language are pre-configured.
- Everything runs in RAM – nothing is saved when you shut down (true live system).

**How to build the ISO**
Everything happens on GitHub – no terminal needed.

1. Go to the "Actions" tab in this repository.
2. Click "Build SurfOS ISO" in the left sidebar.
3. Click the green "Run workflow" button (top right).
4. Select branch "main".
5. Click "Run workflow".
6. Wait 15–30 minutes.
7. When finished (green checkmark), scroll down to "Artifacts".
8. Download "surfos-iso" (zip file).
9. Unzip → inside is the ISO file (usually named binary.iso).

**How to test the ISO**
- Use Rufus (free tool) to write the ISO to a USB stick.
- Choose "ISO Image (Recommended)" mode (not DD Image).
- Boot your computer from the USB (press F12, Esc or F2 at startup for boot menu).
- SurfOS boots directly into the browser.

**Important note about security**
Currently `--security false` is set in build.yml to avoid build errors.  
This means the ISO does not pull the latest security updates during build.  
Once we have a working bootable ISO, we will remove `--security false` and rebuild.  
After that, future builds will include full security updates.

Made with ❤️ in Skanderborg, Denmark
