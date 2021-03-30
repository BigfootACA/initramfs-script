build/zlib/.patched: build/patches/zlib.patch
	@patch -Np1 < $<
	@touch $@
build/zlib/Makefile: build/musl-gcc build/zlib/.patched build/zlib/configure
	cd build/zlib;env \
		CC="$(REALCC)" \
		./configure \
			--prefix=/usr
build/zlib/libz.so: build/musl-gcc build/zlib/Makefile
	@$(MAKE) \
		-C build/zlib \
		CC="$(REALCC)" \
		$(ZLIB_BUILD_FLAGS)
build/sysroot/usr/lib/libz.so: build/zlib/libz.so
	@$(MAKE) \
		-C build/zlib \
		DESTDIR="$(PWD)/build/sysroot" \
		$(ZLIB_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(PWD)/build/sysroot/usr,g build/sysroot/usr/lib/pkgconfig/readline.pc
configure-zlib: build/zlib/Makefile
build-zlib: build/zlib/libz.so
install-zlib: build/sysroot/usr/lib/libz.so
clean-zlib: build/zlib/Makefile
	@make -C build/zlib clean
.PHONY: clean-zlib configure-zlib build-zlib install-zlib