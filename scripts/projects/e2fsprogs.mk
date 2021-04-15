E2P_DEPS=\
	build/sysroot/usr/lib/libblkid.so \
	build/sysroot/usr/lib/libuuid.so
E2P_LIBS=\
	build/sysroot/usr/lib/libcom_err.so \
	build/sysroot/usr/lib/libe2p.so \
	build/sysroot/usr/lib/libext2fs.so \
	build/sysroot/usr/lib/libss.so
E2P_BINS=\
	build/sysroot/usr/bin/mke2fs \
	build/sysroot/usr/bin/resize2fs \
	build/sysroot/usr/bin/debugfs \
	build/sysroot/usr/bin/dumpe2fs \
	build/sysroot/usr/bin/e2freefrag \
	build/sysroot/usr/bin/e2fsck \
	build/sysroot/usr/bin/e2image \
	build/sysroot/usr/bin/e2undo \
	build/sysroot/usr/bin/e4crypt \
	build/sysroot/usr/bin/e4defrag \
	build/sysroot/usr/bin/tune2fs
build/e2fsprogs/.patched: build/patches/e2fsprogs.patch
	@patch -Np1 < $<
	@touch $@
build/e2fsprogs/libtool: build/e2fsprogs/Makefile
build/e2fsprogs/Makefile: build/hostroot/usr/bin/musl-gcc build/e2fsprogs/.patched build/e2fsprogs/configure $(E2P_DEPS)
	@cd build/e2fsprogs;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--disable-nls \
		--disable-rpath \
		--with-root-prefix="" \
		--libdir=/usr/lib \
		--sbindir=/usr/bin \
		--enable-elf-shlibs \
		--disable-fsck \
		--disable-uuidd \
		--disable-libuuid \
		--disable-libblkid \
		--enable-symlink-build \
		--enable-symlink-install \
		--enable-relative-symlinks \
		$(E2FSPROGS_CONFIGURE_FLAGS)
build/e2fsprogs/.built: build/hostroot/usr/bin/musl-gcc build/e2fsprogs/Makefile
	@$(MAKE) \
		-C build/e2fsprogs \
		CC="$(REALCC)" \
		$(E2FSPROGS_BUILD_FLAGS)
	@touch $@
build/e2fsprogs/.installed: build/e2fsprogs/.built
	@$(MAKE) \
		-C build/e2fsprogs \
		DESTDIR="$(SYSROOT)" \
		$(E2FSPROGS_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/{com_err,e2p,ext2fs,ss}.pc
	@touch $@
$(E2P_BINS) $(E2P_LIBS): build/e2fsprogs/.installed
configure-e2fsprogs: build/e2fsprogs/Makefile
build-e2fsprogs: build/e2fsprogs/.built
install-e2fsprogs: build/e2fsprogs/.installed
clean-e2fsprogs: build/e2fsprogs/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-e2fsprogs configure-e2fsprogs build-e2fsprogs install-e2fsprogs
