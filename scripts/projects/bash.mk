BASH_DEPS=\
	build/sysroot/usr/lib/libncursesw.so \
	build/sysroot/usr/lib/libreadline.so \
	build/sysroot/usr/lib/libhistory.so
build/bash/Makefile: build/musl-gcc build/bash/configure $(BASH_DEPS)
	@cd build/bash;./configure \
		CC="$(REALCC)" \
		LDFLAGS="-L$(PWD)/build/sysroot/usr/lib" \
		RL_LIBDIR="$(PWD)/build/sysroot/usr/lib" \
		--host=$(TARGET) \
		--prefix=/usr \
		--with-curses \
		--with-installed-readline \
		--disable-nls \
		--disable-rpath \
		$(BASH_CONFIGURE_FLAGS)
	@sed -i "s,_LIBDIR = /usr/lib,_LIBDIR = $(PWD)/build/sysroot/usr/lib,g" build/bash/Makefile
build/bash/bash: build/musl-gcc build/bash/Makefile
	@$(MAKE) \
		-C build/bash \
		CC="$(REALCC)" \
		LDFLAGS="-L$(PWD)/build/sysroot/usr/lib" \
		$(BASH_BUILD_FLAGS)
build/sysroot/usr/bin/bash: build/bash/bash
	@$(MAKE) \
		-C build/bash \
		DESTDIR="$(PWD)/build/sysroot" \
		$(BASH_INSTALL_FLAGS) \
		install
configure-bash: build/bash/Makefile
build-bash: build/bash/bash
install-bash: build/sysroot/usr/bin/bash
clean-bash: build/bash/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-bash configure-bash build-bash install-bash
