KMOD_DEPS=\
	build/sysroot/usr/lib/libz.so \
	build/sysroot/usr/lib/libzstd.so \
	build/sysroot/usr/lib/liblzma.so
build/kmod/.patched: build/patches/kmod.patch build/kmod/libtool
	@patch -Np1 < $<
	@touch $@
build/kmod/configure: build/kmod/autogen.sh
	@cd build/kmod;bash autogen.sh
build/kmod/libtool: build/kmod/Makefile
build/kmod/Makefile: build/hostroot/usr/bin/musl-gcc build/kmod/configure $(KMOD_DEPS)
	@cd build/kmod;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--disable-rpath \
		--disable-manpages \
		--disable-test-modules \
		--with-zstd \
		--with-xz \
		--with-zlib \
		--with-sysroot="$(SYSROOT)" \
		$(KMOD_CONFIGURE_FLAGS)
build/kmod/.built: build/hostroot/usr/bin/musl-gcc build/kmod/.patched build/kmod/Makefile
	@$(MAKE) \
		-C build/kmod \
		CC="$(REALCC)" \
		$(KMOD_BUILD_FLAGS)
	@touch $@
build/kmod/.installed: build/kmod/.built
	@$(MAKE) \
		-C build/kmod \
		DESTDIR="$(SYSROOT)" \
		$(KMOD_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/libkmod.pc
	@touch $@
build/sysroot/usr/lib/libkmod.so build/sysroot/usr/bin/kmod: build/kmod/.installed
configure-kmod: build/kmod/Makefile
build-kmod: build/kmod/.built
install-kmod: build/kmod/.installed
clean-kmod: build/kmod/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-kmod configure-kmod build-kmod install-kmod
