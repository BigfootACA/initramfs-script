root/usr/bin/%:
	@mkdir -p root/usr/bin
	@case "$<" in \
		build/sysroot/usr/bin/?*|bin/?*)$(BIN_INSTALL) $< $@;;\
		root/usr/bin/?*)ln -vs $(shell basename $<) $@;;\
	esac
root/usr/bin/charger: root/usr/bin/true
root/usr/bin/bash: build/sysroot/usr/bin/bash root/usr/lib/libreadline.so root/usr/lib/libhistory.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/bin/blkid: build/sysroot/usr/bin/blkid root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/busybox: build/sysroot/usr/bin/busybox root/usr/lib/libc.so
root/usr/bin/adbd: build/sysroot/usr/bin/adbd
root/usr/bin/dmesg: build/sysroot/usr/bin/dmesg root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/bin/lsblk: build/sysroot/usr/bin/lsblk root/usr/lib/libblkid.so root/usr/lib/libmount.so root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/udevadm: build/sysroot/usr/bin/udevadm root/usr/lib/libblkid.so root/usr/lib/libkmod.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/udevd: build/sysroot/usr/bin/udevd root/usr/lib/libblkid.so root/usr/lib/libkmod.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/uuidgen: build/sysroot/usr/bin/uuidgen root/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/bin/kmod: build/sysroot/usr/bin/kmod root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/mount: build/sysroot/usr/bin/mount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/umount: build/sysroot/usr/bin/umount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/file: build/sysroot/usr/bin/file root/usr/lib/libmagic.so root/usr/lib/liblzma.so root/usr/lib/libbz2.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/losetup: build/sysroot/usr/bin/losetup root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/boot_menu: bin/boot_menu root/usr/lib/libc.so
root/usr/bin/advreboot: build/sysroot/usr/bin/advreboot root/usr/lib/libc.so
root/usr/bin/lz4: build/sysroot/usr/bin/lz4 root/usr/lib/libc.so
root/usr/bin/bzip2: build/sysroot/usr/bin/bzip2 root/usr/lib/libc.so
root/usr/bin/zstd: build/sysroot/usr/bin/zstd root/usr/lib/libz.so root/usr/lib/liblzma.so root/usr/lib/liblz4.so root/usr/lib/libc.so
root/usr/bin/xz: build/sysroot/usr/bin/xz root/usr/lib/liblzma.so root/usr/lib/libc.so
root/usr/bin/abootimg: build/sysroot/usr/bin/abootimg root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/e2fsck: build/sysroot/usr/bin/e2fsck root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libe2p.so root/usr/lib/libc.so
root/usr/bin/ntfs-3g: bin/ntfs-3g root/usr/lib/libntfs.so root/usr/lib/libc.so
root/usr/bin/fsck.f2fs: bin/fsck.f2fs root/usr/lib/libuuid.so root/usr/lib/libf2fs.so root/usr/lib/libc.so
root/usr/bin/ntfsfix: bin/ntfsfix root/usr/lib/libntfs.so root/usr/lib/libc.so
root/usr/bin/fsck.exfat: bin/fsck.exfat root/usr/lib/libc.so
root/usr/bin/fsck: build/sysroot/usr/bin/fsck root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/btrfs: bin/btrfs root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libz.so root/usr/lib/liblzo2.so root/usr/lib/libc.so
root/usr/bin/btrfsck: bin/btrfsck root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libz.so root/usr/lib/liblzo2.so root/usr/lib/libc.so
root/usr/bin/fsck.btrfs: bin/fsck.btrfs
root/usr/bin/fsck.fat: bin/fsck.fat root/usr/lib/libc.so
root/usr/bin/debugfs: build/sysroot/usr/bin/debugfs root/usr/lib/libext2fs.so root/usr/lib/libe2p.so root/usr/lib/libss.so root/usr/lib/libcom_err.so root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/bin/tune2fs: build/sysroot/usr/bin/tune2fs root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libe2p.so root/usr/lib/libc.so
root/usr/bin/e2undo: build/sysroot/usr/bin/e2undo root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libc.so
root/usr/bin/e4crypt: build/sysroot/usr/bin/e4crypt root/usr/lib/libuuid.so root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libc.so
root/usr/bin/dumpe2fs: build/sysroot/usr/bin/dumpe2fs root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libe2p.so root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/resize2fs: build/sysroot/usr/bin/resize2fs root/usr/lib/libe2p.so root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libc.so
root/usr/bin/e4defrag: build/sysroot/usr/bin/e4defrag root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libc.so
root/usr/bin/e2freefrag: build/sysroot/usr/bin/e2freefrag root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libc.so
root/usr/bin/e2fsck: build/sysroot/usr/bin/e2fsck root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libe2p.so root/usr/lib/libc.so
root/usr/bin/e2image: build/sysroot/usr/bin/e2image root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/mke2fs: build/sysroot/usr/bin/mke2fs root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libe2p.so root/usr/lib/libc.so
