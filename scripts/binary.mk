root/usr/bin/%:
	@mkdir -p root/usr/bin
	@case "$<" in \
		bin/?*)install -vDm755 $< $@;;\
		root/usr/bin/?*)ln -vs $(shell basename $<) $@;;\
	esac
root/usr/bin/bash: build/sysroot/usr/bin/bash root/usr/lib/libreadline.so root/usr/lib/libhistory.so root/usr/lib/libncursesw.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/blkid: bin/blkid root/usr/lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/busybox: bin/busybox root/usr/lib/libc.so
root/usr/bin/charger: bin/charger
root/usr/bin/adbd: build/sysroot/usr/bin/adbd
root/usr/bin/dmesg: bin/dmesg root/usr/lib/libncursesw.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/lsblk: bin/lsblk root/usr/lib/libblkid.so root/usr/lib/libmount.so root/usr/lib/libsmartcols.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/udevadm: bin/udevadm root/usr/lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libkmod.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/udevd: bin/udevd root/usr/lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libkmod.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/uuidgen: bin/uuidgen root/usr/lib/libuuid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/kmod: build/sysroot/usr/bin/kmod root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/mount: bin/mount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/umount: bin/umount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/file: build/sysroot/usr/bin/file root/usr/lib/libmagic.so root/usr/lib/liblzma.so root/usr/lib/libbz2.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/stat: bin/stat root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/losetup: bin/losetup root/usr/lib/libsmartcols.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/boot_menu: bin/boot_menu root/usr/lib/libc.so
root/usr/bin/advreboot: build/sysroot/usr/bin/advreboot root/usr/lib/libc.so
root/usr/bin/lz4: build/sysroot/usr/bin/lz4 root/usr/lib/libc.so
root/usr/bin/bzip2: build/sysroot/usr/bin/bzip2 root/usr/lib/libc.so
root/usr/bin/zstd: build/sysroot/usr/bin/zstd root/usr/lib/libz.so root/usr/lib/liblzma.so root/usr/lib/liblz4.so root/usr/lib/libc.so
root/usr/bin/xz: build/sysroot/usr/bin/xz root/usr/lib/liblzma.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/abootimg: bin/abootimg root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/e2fsck: bin/e2fsck root/usr/lib/libintl.so root/usr/lib/libext2fs.so root/usr/lib/libcom-err.so root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libe2p.so root/usr/lib/libc.so
root/usr/bin/ntfs-3g: bin/ntfs-3g root/usr/lib/libntfs.so root/usr/lib/libc.so
root/usr/bin/fsck.f2fs: bin/fsck.f2fs root/usr/lib/libuuid.so root/usr/lib/libintl.so root/usr/lib/libf2fs.so root/usr/lib/libc.so
root/usr/bin/ntfsfix: bin/ntfsfix root/usr/lib/libntfs.so root/usr/lib/libc.so
root/usr/bin/fsck.exfat: bin/fsck.exfat root/usr/lib/libc.so
root/usr/bin/fsck: bin/fsck root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libintl.so root/usr/lib/libc.so
root/usr/bin/btrfs: bin/btrfs root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libz.so root/usr/lib/liblzo2.so root/usr/lib/libc.so
root/usr/bin/btrfsck: bin/btrfsck root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libz.so root/usr/lib/liblzo2.so root/usr/lib/libc.so
root/usr/bin/fsck.btrfs: bin/fsck.btrfs
root/usr/bin/fsck.fat: bin/fsck.fat root/usr/lib/libc.so

