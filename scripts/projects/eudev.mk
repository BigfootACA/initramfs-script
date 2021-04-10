EUDEV_DEPS=\
	build/sysroot/usr/lib/libkmod.so \
	build/sysroot/usr/lib/libuuid.so \
	build/sysroot/usr/lib/libblkid.so
EUDEV_OUTS=\
	build/sysroot/usr/lib/libudev.so \
	build/sysroot/usr/bin/udevadm \
	build/sysroot/usr/bin/udevd \
	build/sysroot/usr/lib/udev/ata_id \
	build/sysroot/usr/lib/udev/cdrom_id \
	build/sysroot/usr/lib/udev/collect \
	build/sysroot/usr/lib/udev/mtd_probe \
	build/sysroot/usr/lib/udev/scsi_id \
	build/sysroot/usr/lib/udev/v4l_id
build/eudev/.patched: build/patches/eudev.patch build/eudev/libtool
	@patch -Np1 < $<
	@touch $@
build/eudev/libtool: build/eudev/Makefile
build/eudev/configure: build/eudev/configure.ac
	@cd build/eudev;autoreconf -f -i -s
build/eudev/Makefile: build/musl-gcc build/eudev/configure $(EUDEV_DEPS)
	@cd build/eudev;./configure \
		KMOD_LIBS="-lkmod -lzstd -llzma -lz" \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-selinux \
		--disable-manpages \
		--enable-introspection=no \
		--with-sysroot="$(SYSROOT)" \
		$(EUDEV_CONFIGURE_FLAGS)
build/eudev/.built: build/eudev/Makefile build/eudev/.patched
	@$(MAKE) \
		-C build/eudev \
		CC="$(REALCC)" \
		$(EUDEV_BUILD_FLAGS)
	@touch $@
build/eudev/.installed: build/eudev/.built
	@$(MAKE) \
		-C build/eudev \
		DESTDIR="$(SYSROOT)" \
		$(EUDEV_INSTALL_FLAGS) \
		install
	@mv -v build/sysroot/usr/sbin/udevd build/sysroot/usr/bin/
	@rm -vf build/sysroot/usr/sbin/udevadm
	@rmdir -v --ignore-fail-on-non-empty build/sysroot/usr/sbin
	@touch $@
$(EUDEV_OUTS): build/eudev/.installed
configure-eudev: build/eudev/Makefile
build-eudev: build/eudev/.built
install-eudev: build/eudev/.installed
clean-eudev: build/eudev/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-eudev configure-eudev build-eudev install-eudev
