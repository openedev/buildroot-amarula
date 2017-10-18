Intro
=====

This default configuration will allow you to start experimenting with the
buildroot environment for the Pine64. With the current configuration
it will bring-up the board, and allow access through the serial console.

Pine64 link:
https://www.pine64.org/?page_id=1194

SoPINE link:
https://www.pine64.org/?page_id=1491

Pine64 Wiki link:
https://confluence.amarulasolutions.com/display/ODWIKI/Pine64

SoPINE Wiki link:
https://confluence.amarulasolutions.com/display/ODWIKI/Pine64+SoPine

This configuration uses U-Boot mainline and kernel mainline.

How to build
============

    $ make pine64_defconfig (to configure pine64)

    $ make pine64_sopine_defconfig (to configure sopine)

    $ make

Note: you will need access to the internet to download the required
sources.

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX bs=1M
  $ sudo sync

Insert the micro SDcard in your Pine64 and power it up. The console
is on the serial line, 115200 8N1.
