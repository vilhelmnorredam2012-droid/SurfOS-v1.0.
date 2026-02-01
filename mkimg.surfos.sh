#!/bin/sh

set -e

echo "=== Starting SurfOS build ==="

# Lav en midlertidig raw disk-image (ikke iso endnu)
TEMP_IMAGE="surfos-temp.raw"
qemu-img create -f raw "$TEMP_IMAGE" 2G

# Monter image som loop-device og formatér
LOOP_DEV=$(sudo losetup -f --show "$TEMP_IMAGE")
sudo mkfs.ext4 "$LOOP_DEV"
sudo mkdir /mnt/surfos
sudo mount "$LOOP_DEV" /mnt/surfos

# Installer base Alpine
sudo apk --root /mnt/surfos --initdb --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add alpine-base musl openrc chromium xorg-server xf86-video-vesa xf86-input-libinput xinit dbus openbox unclutter ttf-dejavu font-noto linux-lts

# Kopier overlay-filer
sudo cp -r overlay/* /mnt/surfos/

# Lav initramfs og konfigurer boot
sudo mkinitfs -c /mnt/surfos/etc/mkinitfs/mkinitfs.conf -b /mnt/surfos $(ls /mnt/surfos/lib/modules/ | head -1)

# Umount og lav ISO
sudo umount /mnt/surfos
sudo losetup -d "$LOOP_DEV"

# Lav hybrid ISO fra raw image (simpel måde – kan udvides)
xorriso -as mkisofs -o surfos-hybrid.iso -b boot/syslinux/isolinux.bin -c boot/syslinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot "$TEMP_IMAGE"

isohybrid surfos-hybrid.iso

echo "ISO bygget: surfos-hybrid.iso"
ls -la surfos-hybrid.iso
