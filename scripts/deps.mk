MOD_BOOT_DEP=\
	root/usr/bin/bash \
	root/usr/bin/sync \
	root/usr/bin/udevadm \
	root/usr/bin/killall \
	root/usr/bin/env \
	root/usr/bin/switch_root

MOD_CMDLINE_DEP=\
	root/usr/bin/bash \
	root/usr/bin/sync \
	root/usr/bin/blkid

MOD_ENV_DEP=\
	root/usr/bin/bash

MOD_FS_DEP=\
	root/usr/bin/bash \
	root/usr/bin/mount \
	root/usr/bin/abootimg \
	root/usr/bin/unzip \
	root/usr/bin/cpio \
	root/usr/bin/ar \
	root/usr/bin/tar \
	root/usr/bin/stat \
	root/usr/bin/sync \
	root/usr/bin/mdev \
	root/usr/bin/losetup \
	root/usr/bin/rm \
	root/usr/bin/touch \
	root/usr/bin/dmesg \
	root/usr/bin/syslogd

MOD_FUNC_DEP=\
	root/usr/bin/bash \
	root/usr/bin/modprobe \
	root/usr/bin/abootimg \
	root/usr/bin/losetup \
	root/usr/bin/dmesg \
	root/usr/bin/sync \
	root/usr/bin/sleep \
	root/usr/bin/reboot \
	root/usr/bin/poweroff \
	root/usr/bin/rm \
	root/usr/bin/file \
	root/usr/bin/xz \
	root/usr/bin/lz4 \
	root/usr/bin/gzip \
	root/usr/bin/bzip2 \
	root/usr/bin/zstd \
	root/usr/bin/cat

MOD_GADGET_DEP=\
	root/usr/bin/bash \
	root/usr/bin/mkdir \
	root/usr/bin/mount \
	root/usr/bin/adbd \
	root/usr/bin/ln \
	root/usr/bin/lsblk \
	root/usr/bin/sync \
	root/usr/bin/touch \
	root/usr/bin/rmdir \
	root/usr/bin/rm \
	root/usr/bin/mkfifo \
	root/usr/bin/mountpoint \
	root/usr/bin/basename \
	root/usr/bin/sleep \
	root/usr/bin/true \
	root/usr/bin/usb

MOD_HARDWARE_DEP=\
	root/usr/bin/bash \
	root/usr/bin/sleep

MOD_MAIN_DEP=\
	root/usr/bin/bash \
	root/usr/bin/depmod

MOD_SERVICE_DEP=\
	root/usr/bin/bash \
	root/usr/bin/udevd \
	root/usr/bin/udevadm \
	root/usr/bin/sleep \
	root/usr/bin/sync \
	root/usr/bin/charger \
	root/usr/bin/sleep

MOD_SHOW_DEP=\
	root/usr/bin/bash \
	root/usr/bin/date \
	root/usr/bin/ls \
	root/usr/bin/file \
	root/usr/bin/lsblk \
	root/usr/bin/blkid \
	root/usr/bin/advreboot \
	root/usr/bin/menu

INIT_MOD=\
	root/functions/env.sh \
	root/functions/boot.sh \
	root/functions/cmdline.sh \
	root/functions/fs.sh \
	root/functions/func.sh \
	root/functions/gadget.sh \
	root/functions/hardware.sh \
	root/functions/service.sh \
	root/functions/show.sh \
	root/functions/main.sh
