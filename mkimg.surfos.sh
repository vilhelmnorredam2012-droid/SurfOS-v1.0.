#!/bin/sh

# Alpine mkimage script for SurfOS kiosk
# Køres som root inde i Docker – ingen sudo

PROFILE=surfos
ALPINE_BRANCH=edge
ARCH=x86_64

# Lav midlertidig profile-fil
cat <<EOF > /tmp/mkimg.$PROFILE.sh
profile_surfos() {
  kernel_cmdline="unionfs_size=512M console=tty0 console=ttyS0,115200"
  syslinux_serial="0 115200"
  kernel_addons="linux-lts"
  apks="alpine-base musl openrc chromium xorg-server xf86-video-vesa xf86-input-libinput xinit dbus openbox unclutter ttf-dejavu font-noto qemu-img syslinux"
  local _k _a
  for _k in \$kernel_addons; do apks="\$apks linux-\$_k"; done
  for _a in \$kernel_addons; do apks="\$apks \$_a"; done
}
profile_surfos
EOF

# Kør med korrekt syntax (ingen --profile, --tag, --out)
alpine-make-vm-image \
  --image-format iso \
  --image-size 2G \
  --arch "$ARCH" \
  --boot-mode UEFI \
  --branch "$ALPINE_BRANCH" \
  --fs-skel-dir overlay/ \
  surfos-hybrid.iso \
  /tmp/mkimg.$PROFILE.sh

# Gør ISO'en hybrid til USB-boot
isohybrid surfos-hybrid.iso

echo "ISO bygget: surfos-hybrid.iso"
