*****************************************
Buildroot for BTicino i.MX6DL Mamoj board:
*****************************************

This file documents the Buildroot support for BTicino i.MX6DL Mamoj
platform boards.

This configuration uses U-Boot mainline and kernel mainline.

Build
=====

First, configure Buildroot for the BTicino i.MX6DL Mamoj:

  make bticino_imx6dl_mamoj_qt5_defconfig

Build all components:

  make

You will find the following files in output/images/:
  - uImage
  - imx6dl-mamoj.dtb
  - rootfs.ext4
  - rootfs.tar
  - sdcard.img
  - SPL
  - u-boot-dtb.img

Create a bootable eMMC:
======================

To determine the device associated to the eMMC card have a look in the
/proc/partitions file:

  cat /proc/partitions

Buildroot prepares a bootable "sdcard.img" image in the output/images/
directory, ready to be dumped on a eMMC card. Launch the following
command as root:

  dd if=output/images/sdcard.img of=/dev/<your-emmc-device>
  sync

*** WARNING! This will destroy all the card content. Use with care! ***

For details about the medium image layout, see the definition in
board/bticino/mamoj/genimage.cfg

Testing graphics:
================

Running kmscube
# kmscube -D /dev/dri/card1

Running glmark2-es2-drm
# glmark2-es2-drm

Enjoy!
