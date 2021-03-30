build/ncurses/.patched: build/patches/ncurses.patch
	@patch -Np1 < $<
	@touch $@
build/ncurses/Makefile: build/musl-gcc build/ncurses/.patched build/ncurses/configure
	cd build/ncurses;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--without-ada \
		--without-cxx \
		--without-cxx-binding \
		--without-manpages \
		--without-progs \
		--without-tack \
		--without-tests \
		--with-shlib-version= \
		--with-shared \
		--disable-rpath-hack \
		--with-default-terminfo-dir=/etc/terminfo \
		--disable-home-terminfo \
		--enable-widec \
		$(NCURSES_CONFIGURE_FLAGS)
build/ncurses/.built: build/ncurses/Makefile
	@$(MAKE) \
		-C build/ncurses \
		CC="$(REALCC)" \
		$(NCURSES_BUILD_FLAGS)
	@touch $@
build/ncurses/.installed: build/ncurses/.built
	@$(MAKE) \
		-C build/ncurses \
		DESTDIR="$(PWD)/build/sysroot" \
		$(NCURSES_INSTALL_FLAGS) \
		install
	@echo 'INPUT(-lncursesw)' > build/sysroot/usr/lib/libcurses.so
	@touch $@
build/sysroot/usr/lib/libncursesw.so build/sysroot/usr/lib/libpanelw.so build/sysroot/usr/lib/libmenuw.so build/sysroot/usr/lib/libformw.so: build/ncurses/.installed
configure-ncurses: build/ncurses/Makefile
build-ncurses: build/ncurses/.built
install-ncurses: build/ncurses/.installed
clean-ncurses: build/ncurses/.git
	@git clean -xdf
	@git reset --hard
.PHONY: clean-ncurses configure-ncurses build-ncurses install-ncurses