build/musl/config.mak: build/musl/configure
	@cd build/musl;./configure \
		--target=$(TARGET) \
		--prefix=/usr \
		$(MUSL_CONFIGURE_FLAGS)
build/sysroot/usr/lib/musl.specs: build/musl.specs.in
	@mkdir -vp build/sysroot/usr/lib
	@sed "s|%SYSROOT%|$(PWD)/build/sysroot|g;s|%GCC%|$(CROSS_COMPILE)gcc|g" < $< > $@
build/musl-gcc: build/musl-gcc.in build/sysroot/usr/lib/musl.specs build/sysroot/usr/lib/libc.so build/progress/kheaders build/progress/headers
	@sed "s|%SYSROOT%|$(PWD)/build/sysroot|g;s|%GCC%|$(CROSS_COMPILE)gcc|g" < $< > $@
	@chmod +x $@
build/musl/lib/libc.so: build/linux/Makefile build/musl/config.mak
	@$(MAKE) \
		-C build/musl \
		$(MUSL_BUILD_FLAGS)
build/sysroot/usr/lib/libc.so: build/musl/lib/libc.so
	@$(MAKE) \
		-C build/musl \
		DESTDIR="$(PWD)/build/sysroot" \
		$(MUSL_INSTALL_FLAGS) \
		install
	@rm -fv \
		build/sysroot/usr/lib/musl-gcc.specs \
		build/sysroot/usr/bin/musl-gcc \
		build/sysroot/lib/ld*.so*
	@rmdir --ignore-fail-on-non-empty \
		build/sysroot/lib \
		build/sysroot/usr/bin
configure-musl: build/musl/config.mak
build-musl: build/musl/lib/libc.so
install-musl: build/sysroot/usr/lib/libc.so
clean-musl: build/musl/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-musl build-musl install-musl
