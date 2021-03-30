build/xz/.patched: build/patches/xz.patch build/xz/libtool
	@patch -Np1 < $<
	@touch $@
build/xz/configure: build/xz/autogen.sh
	@cd build/xz;bash autogen.sh
build/xz/libtool: build/xz/Makefile
build/xz/Makefile: build/musl-gcc build/xz/configure
	@cd build/xz;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--disable-scripts \
		--disable-doc
		$(XZ_CONFIGURE_FLAGS)
build/xz/.built: build/musl-gcc build/xz/.patched build/xz/Makefile
	@$(MAKE) \
		-C build/xz \
		CC="$(REALCC)" \
		$(XZ_BUILD_FLAGS)
	@touch $@
build/xz/.installed: build/xz/.built
	@$(MAKE) \
		-C build/xz \
		DESTDIR="$(PWD)/build/sysroot" \
		$(XZ_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(PWD)/build/sysroot/usr,g build/sysroot/usr/lib/pkgconfig/liblzma.pc
	@touch $@
build/sysroot/usr/lib/liblzma.so build/sysroot/usr/bin/xz: build/xz/.installed
configure-xz: build/xz/Makefile
build-xz: build/xz/.built
install-xz: build/xz/.installed
clean-xz: build/xz/.git
	@git clean -xdf
	@git reset --hard
.PHONY: clean-xz configure-xz build-xz install-xz
