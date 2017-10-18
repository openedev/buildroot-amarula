#!/usr/bin/env bash
#
# sunxi64-post-build script
#
# Allwinner A64/H5 firmware consists of three parts:
# 1) U-Boot's SPL
# 2) ARM Trusted Firmware (ATF)
# 3) U-Boot proper.
#
# The SPL will load both ATF and U-Boot proper along with the right device
# tree blob (.dtb) and will pass execution to ATF (in EL3), which in turn will
# drop into the U-Boot proper (in EL2).
#
# As the ATF binary will become part of the U-Boot image file, you will need
# to build it first and export ATF variable to built U-Boot proper. Since
# buildroot not take of building ATF first and export the binary, this post-build
# script build the u-boot.itb

# source .config
source ${BR2_CONFIG}

ATF_BUILD_DIR=arm-trusted-firmware-${BR2_TARGET_ARM_TRUSTED_FIRMWARE_VERSION}/build
ATF_PLAT_DIR=${ATF_BUILD_DIR}/${BR2_TARGET_ARM_TRUSTED_FIRMWARE_PLATFORM}/release
ATF_BIN_PATH=${ATF_PLAT_DIR}/${BR2_TARGET_ARM_TRUSTED_FIRMWARE_ADDITIONAL_VARIABLES}.bin
UBOOT_BUILD_DIR=${BUILD_DIR}/uboot-${BR2_TARGET_UBOOT_VERSION}
MKIMAGE=${UBOOT_BUILD_DIR}/tools/mkimage
DTB_NAME=${BR2_LINUX_KERNEL_INTREE_DTS_NAME#*/}.dtb

cd ${UBOOT_BUILD_DIR}
export BL31=${BUILD_DIR}/${ATF_BIN_PATH}
${UBOOT_BUILD_DIR}/board/sunxi/mksunxi_fit_atf.sh ${UBOOT_BUILD_DIR}/arch/arm/dts/${DTB_NAME} > u-boot.its
${MKIMAGE} -f u-boot.its -E $BINARIES_DIR/u-boot.itb
