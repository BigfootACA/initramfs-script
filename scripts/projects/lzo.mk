build/lzo/.patched: build/patches/lzo.patch build/lzo/libtool
	@patch -Np1 < $<
	@touch $@
build/lzo/libtool: build/lzo/Makefile
build/lzo/Makefile: build/musl-gcc build/lzo/configure
	@cd build/lzo;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--enable-shared \
		--with-sysroot="$(SYSROOT)"
		$(LZO_CONFIGURE_FLAGS)
build/lzo/.built: build/musl-gcc build/lzo/.patched build/lzo/Makefile
	@$(MAKE) \
		-C build/lzo \
		PREFIX="/usr" \
		CC="$(REALCC)" \
		$(LZO_BUILD_FLAGS)
	@touch $@
build/lzo/.installed: build/lzo/.built
	@$(MAKE) \
		-C build/lzo \
		PREFIX="/usr" \
		DESTDIR="$(SYSROOT)" \
		$(LZO_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/lzo2.pc
	@touch $@
build/sysroot/usr/lib/liblzo.so: build/lzo/.installed
configure-lzo: build/lzo/Makefile
build-lzo: build/lzo/.built
install-lzo: build/lzo/.installed
clean-lzo: build/lzo/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-lzo configure-lzo build-lzo install-lzo
