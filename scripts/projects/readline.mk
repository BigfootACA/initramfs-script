build/readline/.patched: build/patches/readline.patch
	@patch -Np1 < $<
	@touch $@
build/readline/Makefile: build/musl-gcc build/readline/.patched build/readline/configure build/sysroot/usr/lib/libncursesw.so
	@cd build/readline;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--with-curses \
		$(READLINE_CONFIGURE_FLAGS)
build/readline/.built: build/musl-gcc build/readline/Makefile
	@$(MAKE) \
		-C build/readline \
		CC="$(REALCC)" \
		$(readline_BUILD_FLAGS)
	@touch $@
build/readline/.installed: build/readline/.built
	@$(MAKE) \
		-C build/readline \
		DESTDIR="$(PWD)/build/sysroot" \
		$(readline_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(PWD)/build/sysroot/usr,g build/sysroot/usr/lib/pkgconfig/readline.pc
	@rm -f build/sysroot/usr/lib/libreadline.so.old build/sysroot/usr/lib/libhistory.so.old
	@touch $@
build/sysroot/usr/lib/libreadline.so build/sysroot/usr/lib/libhistory.so: build/readline/.installed
configure-readline: build/readline/Makefile
build-readline: build/readline/.built
install-readline: build/readline/.installed
clean-readline: build/readline/.git
	@git clean -xdf
	@git reset --hard
.PHONY: clean-readline configure-readline build-readline install-readline
