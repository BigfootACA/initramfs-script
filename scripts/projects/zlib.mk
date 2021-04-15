build/zlib/.patched: build/patches/zlib.patch
	@patch -Np1 < $<
	@touch $@
build/zlib/Makefile: build/hostroot/usr/bin/musl-gcc build/zlib/.patched build/zlib/configure
	@cd build/zlib;env CC="$(REALCC)" ./configure --prefix=/usr
build/zlib/libz.so: build/hostroot/usr/bin/musl-gcc build/zlib/Makefile
	@$(MAKE) \
		-C build/zlib \
		CC="$(REALCC)" \
		$(ZLIB_BUILD_FLAGS)
build/sysroot/usr/lib/libz.so: build/zlib/libz.so
	@$(MAKE) \
		-C build/zlib \
		DESTDIR="$(SYSROOT)" \
		$(ZLIB_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/zlib.pc
configure-zlib: build/zlib/Makefile
build-zlib: build/zlib/libz.so
install-zlib: build/sysroot/usr/lib/libz.so
clean-zlib: build/zlib/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-zlib configure-zlib build-zlib install-zlib
