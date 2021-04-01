UL_DEPS=\
	build/sysroot/usr/lib/libz.so \
	build/sysroot/usr/lib/libmagic.so \
	build/sysroot/usr/lib/libncursesw.so
UL_LIBS=\
	build/sysroot/usr/lib/libblkid.so \
	build/sysroot/usr/lib/libfdisk.so \
	build/sysroot/usr/lib/libmount.so \
	build/sysroot/usr/lib/libsmartcols.so \
	build/sysroot/usr/lib/libuuid.so
UL_BINS=\
	build/sysroot/usr/bin/addpart \
	build/sysroot/usr/bin/agetty \
	build/sysroot/usr/bin/blkdiscard \
	build/sysroot/usr/bin/blkid \
	build/sysroot/usr/bin/blkzone \
	build/sysroot/usr/bin/blockdev \
	build/sysroot/usr/bin/cal \
	build/sysroot/usr/bin/cfdisk \
	build/sysroot/usr/bin/chcpu \
	build/sysroot/usr/bin/chfn \
	build/sysroot/usr/bin/chmem \
	build/sysroot/usr/bin/choom \
	build/sysroot/usr/bin/chrt \
	build/sysroot/usr/bin/chsh \
	build/sysroot/usr/bin/col \
	build/sysroot/usr/bin/colcrt \
	build/sysroot/usr/bin/colrm \
	build/sysroot/usr/bin/column \
	build/sysroot/usr/bin/ctrlaltdel \
	build/sysroot/usr/bin/delpart \
	build/sysroot/usr/bin/dmesg \
	build/sysroot/usr/bin/eject \
	build/sysroot/usr/bin/fallocate \
	build/sysroot/usr/bin/fdformat \
	build/sysroot/usr/bin/fdisk \
	build/sysroot/usr/bin/fincore \
	build/sysroot/usr/bin/findfs \
	build/sysroot/usr/bin/findmnt \
	build/sysroot/usr/bin/flock \
	build/sysroot/usr/bin/fsck \
	build/sysroot/usr/bin/fsck.cramfs \
	build/sysroot/usr/bin/fsck.minix \
	build/sysroot/usr/bin/fsfreeze \
	build/sysroot/usr/bin/fstrim \
	build/sysroot/usr/bin/getopt \
	build/sysroot/usr/bin/hexdump \
	build/sysroot/usr/bin/hwclock \
	build/sysroot/usr/bin/ionice \
	build/sysroot/usr/bin/ipcmk \
	build/sysroot/usr/bin/ipcrm \
	build/sysroot/usr/bin/ipcs \
	build/sysroot/usr/bin/irqtop \
	build/sysroot/usr/bin/isosize \
	build/sysroot/usr/bin/kill \
	build/sysroot/usr/bin/last \
	build/sysroot/usr/bin/ldattach \
	build/sysroot/usr/bin/logger \
	build/sysroot/usr/bin/login \
	build/sysroot/usr/bin/look \
	build/sysroot/usr/bin/losetup \
	build/sysroot/usr/bin/lsblk \
	build/sysroot/usr/bin/lscpu \
	build/sysroot/usr/bin/lsipc \
	build/sysroot/usr/bin/lsirq \
	build/sysroot/usr/bin/lslocks \
	build/sysroot/usr/bin/lslogins \
	build/sysroot/usr/bin/lsmem \
	build/sysroot/usr/bin/lsns \
	build/sysroot/usr/bin/mcookie \
	build/sysroot/usr/bin/mesg \
	build/sysroot/usr/bin/mkfs \
	build/sysroot/usr/bin/mkfs.bfs \
	build/sysroot/usr/bin/mkfs.cramfs \
	build/sysroot/usr/bin/mkfs.minix \
	build/sysroot/usr/bin/mkswap \
	build/sysroot/usr/bin/more \
	build/sysroot/usr/bin/mount \
	build/sysroot/usr/bin/mountpoint \
	build/sysroot/usr/bin/namei \
	build/sysroot/usr/bin/newgrp \
	build/sysroot/usr/bin/nologin \
	build/sysroot/usr/bin/nsenter \
	build/sysroot/usr/bin/partx \
	build/sysroot/usr/bin/pivot_root \
	build/sysroot/usr/bin/prlimit \
	build/sysroot/usr/bin/raw \
	build/sysroot/usr/bin/readprofile \
	build/sysroot/usr/bin/rename \
	build/sysroot/usr/bin/renice \
	build/sysroot/usr/bin/resizepart \
	build/sysroot/usr/bin/rev \
	build/sysroot/usr/bin/rfkill \
	build/sysroot/usr/bin/rtcwake \
	build/sysroot/usr/bin/runuser \
	build/sysroot/usr/bin/script \
	build/sysroot/usr/bin/scriptlive \
	build/sysroot/usr/bin/scriptreplay \
	build/sysroot/usr/bin/setarch \
	build/sysroot/usr/bin/setpriv \
	build/sysroot/usr/bin/setsid \
	build/sysroot/usr/bin/setterm \
	build/sysroot/usr/bin/sfdisk \
	build/sysroot/usr/bin/su \
	build/sysroot/usr/bin/sulogin \
	build/sysroot/usr/bin/swaplabel \
	build/sysroot/usr/bin/swapoff \
	build/sysroot/usr/bin/swapon \
	build/sysroot/usr/bin/switch_root \
	build/sysroot/usr/bin/taskset \
	build/sysroot/usr/bin/ul \
	build/sysroot/usr/bin/umount \
	build/sysroot/usr/bin/unshare \
	build/sysroot/usr/bin/utmpdump \
	build/sysroot/usr/bin/uuidd \
	build/sysroot/usr/bin/uuidgen \
	build/sysroot/usr/bin/uuidparse \
	build/sysroot/usr/bin/vipw \
	build/sysroot/usr/bin/wall \
	build/sysroot/usr/bin/wdctl \
	build/sysroot/usr/bin/whereis \
	build/sysroot/usr/bin/wipefs \
	build/sysroot/usr/bin/write \
	build/sysroot/usr/bin/zramctl
build/util-linux/.patched: build/patches/util-linux.patch build/util-linux/libtool
	@patch -Np1 < $<
	@touch $@
build/util-linux/configure: build/util-linux/autogen.sh
	@cd build/util-linux;bash autogen.sh
build/util-linux/libtool: build/util-linux/Makefile
build/util-linux/Makefile: build/musl-gcc build/util-linux/configure $(UL_DEPS)
	@cd build/util-linux;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--disable-nls \
		--disable-rpath \
		--without-udev \
		--without-python \
		--without-systemd \
		--disable-hardlink \
		--disable-pylibmount \
		--disable-bash-completion \
		--enable-libsmartcols \
		--enable-libmount \
		--enable-libfdisk \
		--enable-libblkid \
		--enable-libuuid \
		$(UTIL_LINUX_CONFIGURE_FLAGS)
build/util-linux/.built: build/musl-gcc build/util-linux/.patched build/util-linux/Makefile
	@$(MAKE) \
		-C build/util-linux \
		CC="$(REALCC)" \
		$(UTIL_LINUX_BUILD_FLAGS)
	@touch $@
build/util-linux/.installed: build/util-linux/.built
	@$(MAKE) \
		-C build/util-linux \
		DESTDIR="$(SYSROOT)" \
		$(UTIL_LINUX_INSTALL_FLAGS) \
		install
	@mv -v build/sysroot/lib/* build/sysroot/usr/lib/
	@mv -v build/sysroot/bin/* build/sysroot/usr/bin/
	@mv -v build/sysroot/sbin/* build/sysroot/usr/bin/
	@mv -v build/sysroot/usr/sbin/* build/sysroot/usr/bin/
	@rmdir -v build/sysroot/{lib,bin,{usr/,}sbin}
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/{blkid,mount,fdisk,smartcols,uuid}.pc
	@touch $@
$(UL_BINS) $(UL_LIBS): build/util-linux/.installed
configure-util-linux: build/util-linux/Makefile
build-util-linux: build/util-linux/.built
install-util-linux: build/util-linux/.installed
clean-util-linux: build/util-linux/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-util-linux configure-util-linux build-util-linux install-util-linux