# CHANGELOG – SurfOS

### v1.0 – January 30, 2026 – First build (plain ISO)

**What works now?**
- SurfOS boots as a live system from USB/CD.
- Boots directly into full-screen Chromium browser (kiosk mode).
- Start page is always https://www.startpage.com.
- No login screen – autologin as user "surfos" (no password).
- Danish keyboard layout and language pre-configured.
- No terminal, no desktop, no file manager – only the browser.
- Sound and network (WiFi) work (network-manager).
- Mouse hides after a few seconds (unclutter).

**What does not work yet / is temporarily disabled?**
- Security updates during build (--security false) – we had 404 errors on security.debian.org/bookworm/updates. This means the ISO does not pull the latest patches. We will enable it again later.
- Hybrid boot (USB boot on all PCs) – we use plain ISO (--binary-images iso) to avoid isohybrid errors. It still works on USB with Rufus in "ISO Image" mode.
- Installation to hard drive – debian-installer is not enabled yet. Coming in next version.

**Problems we have had (short overview)**
- Many 404 errors on security and Contents.gz (wrong path in live-build for bookworm).
- cp errors on isolinux.bin / vesamenu.c32 (live-build could not find bootloader files on ubuntu-latest).
- isohybrid not found (missing tool for hybrid ISO).
- Upload errors in GitHub Actions (wrong file name – we found it's called binary.iso).
- VirtualBox boot issues (wrong boot order, EFI enabled, hard disk in the way).

**Next versions (plan)**
- v1.1: Enable security again (remove --security false) and test if build works.
- v1.2: Enable debian-installer (--debian-installer gui) – so it can be installed to hard drive.
- v1.3: Add hybrid boot again (--binary-images iso-hybrid) with grub-efi + syslinux.
- v1.4: Add option for local start page or multiple browsers (optional).
- v1.5: Make it even easier to use (better README, video guide).

Made with ❤️ in Denmark
