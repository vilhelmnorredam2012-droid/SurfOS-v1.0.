#!/bin/sh

# Alpine mkimage profil for SurfOS kiosk
# Køres inde i Docker som root – ingen sudo nødvendigt

PROFILE=surfos
ALPINE_BRANCH=edge  # eller "v3.21" for stabil version
ARCH=x86_64

cat <<EOF > /tmp/mkimg.$PROFILE.sh
profile_surfos() {
  kernel_cmdline="unionfs_size=512M console=tty0 console=ttyS0,115200"
  syslinux_serial="0 115200"
  kernel_addons=""
  apks="alpine-base musl openrc
        chromium xorg-server xf86-video-vesa xf86-input-libinput
        xinit dbus openbox unclutter
        ttf-dejavu font-noto"
  local _k _a
  for _k in \$kernel_addons; do apks="\$apks linux-\${_k%-*}-modules-\${_k##*-}"; done
  for _a in \$kernel_addons; do apks="\$apks \$_a"; done
}
profile_surfos
EOF

alpine-make-vm-image \
  --image-format iso \
  --image-size 2G \
  --repositories-file /etc/apk/repositories \
  --packages "$(cat /tmp/mkimg.$PROFILE.sh | grep apks= | cut -d'"' -f2)" \
  --profile surfos \
  --tag surfos \
  --out surfos-hybrid.iso \
  overlay/

echo "ISO bygget: surfos-hybrid.iso"
