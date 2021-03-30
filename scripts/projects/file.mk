FILE_DEPS=\
	build/sysroot/usr/lib/libz.so \
	build/sysroot/usr/lib/libbz2.so \
	build/sysroot/usr/lib/liblzma.so
build/file/.patched: build/patches/file.patch build/file/libtool
	@patch -Np1 < $<
	@touch $@
build/file/configure: build/file/configure.ac
	@cd build/file&&\
		libtoolize&&\
		aclocal -I m4&&\
		autoconf&&\
		autoheader&&\
		automake -acf --foreign
build/file/libtool: build/file/Makefile
build/file/Makefile: build/musl-gcc build/file/configure $(FILE_DEPS)
	@cd build/file;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--enable-static \
		--disable-libseccomp \
		--with-sysroot="$(PWD)/build/sysroot" \
		$(FILE_CONFIGURE_FLAGS)
build/file/.built: build/musl-gcc build/file/.patched build/file/Makefile
	@$(MAKE) \
		-C build/file \
		CC="$(REALCC)" \
		$(FILE_BUILD_FLAGS)
	@touch $@
build/file/.installed: build/file/.built
	@$(MAKE) \
		-C build/file \
		DESTDIR="$(PWD)/build/sysroot" \
		$(FILE_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(PWD)/build/sysroot/usr,g build/sysroot/usr/lib/pkgconfig/libmagic.pc
	@touch $@
build/sysroot/usr/lib/libmagic.so build/sysroot/usr/bin/file: build/file/.installed
configure-file: build/file/Makefile
build-file: build/file/.built
install-file: build/file/.installed
clean-file: build/file/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-file configure-file build-file install-file
