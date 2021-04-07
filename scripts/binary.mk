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
root/usr/bin/udevd: build/sysroot/usr/bin/udevd root/usr/lib/libblkid.so root/usr/lib/libkmod.so root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so root/usr/lib/udev/ata_id root/usr/lib/udev/scsi_id
root/usr/bin/uuidgen: build/sysroot/usr/bin/uuidgen root/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/bin/kmod: build/sysroot/usr/bin/kmod root/usr/lib/liblzma.so root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/mount: build/sysroot/usr/bin/mount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/umount: build/sysroot/usr/bin/umount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/file: build/sysroot/usr/bin/file root/usr/lib/libmagic.so root/usr/lib/liblzma.so root/usr/lib/libbz2.so root/usr/lib/libz.so root/usr/lib/libc.so root/usr/share/misc/magic.mgc
root/usr/bin/losetup: build/sysroot/usr/bin/losetup root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/advreboot: build/sysroot/usr/bin/advreboot root/usr/lib/libc.so
root/usr/bin/lz4: build/sysroot/usr/bin/lz4 root/usr/lib/libc.so
root/usr/bin/bzip2: build/sysroot/usr/bin/bzip2 root/usr/lib/libc.so
root/usr/bin/zstd: build/sysroot/usr/bin/zstd root/usr/lib/libz.so root/usr/lib/liblzma.so root/usr/lib/liblz4.so root/usr/lib/libc.so
root/usr/bin/xz: build/sysroot/usr/bin/xz root/usr/lib/liblzma.so root/usr/lib/libc.so
root/usr/bin/abootimg: build/sysroot/usr/bin/abootimg root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/e2fsck: build/sysroot/usr/bin/e2fsck root/usr/lib/libext2fs.so root/usr/lib/libcom_err.so root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libe2p.so root/usr/lib/libc.so
root/usr/bin/ntfs-3g: bin/ntfs-3g root/usr/lib/libntfs.so root/usr/lib/libc.so
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
root/usr/bin/uuidd: build/sysroot/usr/bin/uuidd root/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/bin/scriptreplay: build/sysroot/usr/bin/scriptreplay root/usr/lib/libc.so
root/usr/bin/setsid: build/sysroot/usr/bin/setsid root/usr/lib/libc.so
root/usr/bin/fsck: build/sysroot/usr/bin/fsck root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/mkswap: build/sysroot/usr/bin/mkswap root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/eject: build/sysroot/usr/bin/eject root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/agetty: build/sysroot/usr/bin/agetty root/usr/lib/libc.so
root/usr/bin/wipefs: build/sysroot/usr/bin/wipefs root/usr/lib/libblkid.so root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/delpart: build/sysroot/usr/bin/delpart root/usr/lib/libc.so
root/usr/bin/mountpoint: build/sysroot/usr/bin/mountpoint root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/scriptlive: build/sysroot/usr/bin/scriptlive root/usr/lib/libc.so
root/usr/bin/fsck.minix: build/sysroot/usr/bin/fsck.minix root/usr/lib/libc.so
root/usr/bin/mkfs.cramfs: build/sysroot/usr/bin/mkfs.cramfs root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/switch_root: build/sysroot/usr/bin/switch_root root/usr/lib/libc.so
root/usr/bin/cfdisk: build/sysroot/usr/bin/cfdisk root/usr/lib/libsmartcols.so root/usr/lib/libfdisk.so root/usr/lib/libmount.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/bin/fallocate: build/sysroot/usr/bin/fallocate root/usr/lib/libc.so
root/usr/bin/blkid: build/sysroot/usr/bin/blkid root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/hexdump: build/sysroot/usr/bin/hexdump root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/bin/dmesg: build/sysroot/usr/bin/dmesg root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/bin/nsenter: build/sysroot/usr/bin/nsenter root/usr/lib/libc.so
root/usr/bin/script: build/sysroot/usr/bin/script root/usr/lib/libc.so
root/usr/bin/findfs: build/sysroot/usr/bin/findfs root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/swaplabel: build/sysroot/usr/bin/swaplabel root/usr/lib/libblkid.so root/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/bin/losetup: build/sysroot/usr/bin/losetup root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/fstrim: build/sysroot/usr/bin/fstrim root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/blkzone: build/sysroot/usr/bin/blkzone root/usr/lib/libc.so
root/usr/bin/unshare: build/sysroot/usr/bin/unshare root/usr/lib/libc.so
root/usr/bin/findmnt: build/sysroot/usr/bin/findmnt root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/mkfs.minix: build/sysroot/usr/bin/mkfs.minix root/usr/lib/libc.so
root/usr/bin/hwclock: build/sysroot/usr/bin/hwclock root/usr/lib/libc.so
root/usr/bin/swapon: build/sysroot/usr/bin/swapon root/usr/lib/libblkid.so root/usr/lib/libmount.so root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/fsfreeze: build/sysroot/usr/bin/fsfreeze root/usr/lib/libc.so
root/usr/bin/swapoff: build/sysroot/usr/bin/swapoff root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/pivot_root: build/sysroot/usr/bin/pivot_root root/usr/lib/libc.so
root/usr/bin/fdisk: build/sysroot/usr/bin/fdisk root/usr/lib/libfdisk.so root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libsmartcols.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/bin/mkfs: build/sysroot/usr/bin/mkfs root/usr/lib/libc.so
root/usr/bin/kill: build/sysroot/usr/bin/kill root/usr/lib/libc.so
root/usr/bin/whereis: build/sysroot/usr/bin/whereis root/usr/lib/libc.so
root/usr/bin/resizepart: build/sysroot/usr/bin/resizepart root/usr/lib/libc.so
root/usr/bin/lscpu: build/sysroot/usr/bin/lscpu root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/rfkill: build/sysroot/usr/bin/rfkill root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/uuidparse: build/sysroot/usr/bin/uuidparse root/usr/lib/libuuid.so root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/blkdiscard: build/sysroot/usr/bin/blkdiscard root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/blockdev: build/sysroot/usr/bin/blockdev root/usr/lib/libc.so
root/usr/bin/mkfs.bfs: build/sysroot/usr/bin/mkfs.bfs root/usr/lib/libc.so
root/usr/bin/ctrlaltdel: build/sysroot/usr/bin/ctrlaltdel root/usr/lib/libc.so
root/usr/bin/partx: build/sysroot/usr/bin/partx root/usr/lib/libblkid.so root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/addpart: build/sysroot/usr/bin/addpart root/usr/lib/libc.so
root/usr/bin/fsck.cramfs: build/sysroot/usr/bin/fsck.cramfs root/usr/lib/libz.so root/usr/lib/libc.so
root/usr/bin/mount: build/sysroot/usr/bin/mount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/flock: build/sysroot/usr/bin/flock root/usr/lib/libc.so
root/usr/bin/uuidgen: build/sysroot/usr/bin/uuidgen root/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/bin/zramctl: build/sysroot/usr/bin/zramctl root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/lsblk: build/sysroot/usr/bin/lsblk root/usr/lib/libblkid.so root/usr/lib/libmount.so root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/chcpu: build/sysroot/usr/bin/chcpu root/usr/lib/libc.so
root/usr/bin/umount: build/sysroot/usr/bin/umount root/usr/lib/libmount.so root/usr/lib/libblkid.so root/usr/lib/libc.so
root/usr/bin/wdctl: build/sysroot/usr/bin/wdctl root/usr/lib/libsmartcols.so root/usr/lib/libc.so
root/usr/bin/rtcwake: build/sysroot/usr/bin/rtcwake root/usr/lib/libc.so
root/usr/bin/sfdisk: build/sysroot/usr/bin/sfdisk root/usr/lib/libfdisk.so root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libsmartcols.so root/usr/lib/libncursesw.so root/usr/lib/libc.so
root/usr/bin/mkfs.f2fs: build/sysroot/usr/bin/mkfs.f2fs root/usr/lib/libuuid.so root/usr/lib/libblkid.so root/usr/lib/libf2fs.so root/usr/lib/libc.so
root/usr/bin/f2fstat: build/sysroot/usr/bin/f2fstat root/usr/lib/libc.so
root/usr/bin/f2fscrypt: build/sysroot/usr/bin/f2fscrypt root/usr/lib/libuuid.so root/usr/lib/libc.so
root/usr/bin/fsck.f2fs: build/sysroot/usr/bin/fsck.f2fs root/usr/lib/libuuid.so root/usr/lib/libf2fs.so root/usr/lib/libc.so
root/usr/bin/fibmap.f2fs: build/sysroot/usr/bin/fibmap.f2fs root/usr/lib/libc.so
root/usr/bin/parse.f2fs: build/sysroot/usr/bin/parse.f2fs root/usr/lib/libc.so
root/usr/bin/menu: build/sysroot/usr/bin/menu root/usr/lib/libdrm.so root/usr/lib/libjson-c.so root/usr/lib/liblvgl.so root/usr/lib/liblvgl_font.so root/usr/lib/libc.so
