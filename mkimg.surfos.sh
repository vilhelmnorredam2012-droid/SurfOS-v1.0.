#!/bin/sh

# Alpine mkimage profil for SurfOS kiosk
# Køres inde i Docker som root – ingen sudo nødvendigt

PROFILE=surfos
ALPINE_BRANCH=edge  # eller "v3.20" for stabil
ARCH=x86_64

# Lav profile-scriptet
cat <<EOF > /tmp/mkimg.$PROFILE.sh
profile_surfos() {
  kernel_cmdline="unionfs_size=512M console=tty0 console=ttyS0,115200"
  syslinux_serial="0 115200"
  kernel_addons="linux-lts"
  apks="alpine-base musl openrc
        chromium xorg-server xf86-video-vesa xf86-input-libinput
        xinit dbus openbox unclutter
        ttf-dejavu font-noto"
  local _k _a
  for _k in \$kernel_addons; do apks="\$apks linux-\$_k"; done
  for _a in \$kernel_addons; do apks="\$apks \$_a"; done
}

profile_surfos
EOF

# Kør alpine-make-vm-image med korrekt syntax
alpine-make-vm-image \
  --image-format iso \
  --image-size 2G \
  --arch "$ARCH" \
  --boot-mode UEFI \
  --branch "$ALPINE_BRANCH" \
  --fs-skel-dir overlay/ \
  surfos-hybrid.iso \
  /tmp/mkimg.$PROFILE.sh

# Lav ISO'en hybrid (til USB)
isohybrid surfos-hybrid.iso

echo "ISO bygget: surfos-hybrid.iso"
