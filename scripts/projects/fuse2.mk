FUSE2_LIBS=\
	build/sysroot/usr/lib/libfuse.so \
	build/sysroot/usr/lib/libulockmgr.so
FUSE2_BINS=\
	build/sysroot/usr/bin/fusermount \
	build/sysroot/usr/bin/mount.fuse \
	build/sysroot/usr/bin/ulockmgr_server
build/fuse2/.patched: build/patches/fuse2.patch build/fuse2/libtool
	@patch -Np1 < $<
	@touch $@
build/fuse2/configure: build/fuse2/makeconf.sh
	@cd build/fuse2;bash makeconf.sh
build/fuse2/libtool: build/fuse2/Makefile
build/fuse2/Makefile: build/musl-gcc build/fuse2/configure
	@cd build/fuse2;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--sbindir=/usr/bin \
		--enable-lib \
		--enable-util \
		--disable-rpath \
		--with-sysroot="$(SYSROOT)" \
		UDEV_RULES_PATH=/usr/lib/udev/rules.d \
		MOUNT_FUSE_PATH=/usr/bin \
		$(FUSE2_CONFIGURE_FLAGS)
build/fuse2/.built: build/musl-gcc build/fuse2/.patched build/fuse2/Makefile
	@$(MAKE) \
		-C build/fuse2 \
		CC="$(REALCC)" \
		$(FUSE2_BUILD_FLAGS)
	@touch $@
build/fuse2/.installed: build/fuse2/.built
	@$(MAKE) \
		-C build/fuse2 \
		DESTDIR="$(SYSROOT)" \
		$(FUSE2_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/fuse.pc
	@touch $@
$(FUSE2_LIBS) $(FUSE2_BINS): build/fuse2/.installed
configure-fuse2: build/fuse2/Makefile
build-fuse2: build/fuse2/.built
install-fuse2: build/fuse2/.installed
clean-fuse2: build/fuse2/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-fuse2 configure-fuse2 build-fuse2 install-fuse2
