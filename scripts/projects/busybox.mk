build/busybox/.config: build/patches/busybox.patch
	@patch -Np1 < $<
build/busybox/busybox: build/musl-gcc build/busybox/Makefile build/busybox/.config
	@$(MAKE) \
		-C build/busybox \
		CC="$(REALCC)" \
		CONFIG_CROSS_COMPILER_PREFIX="$(CROSS_COMPILE)" \
		CONFIG_SYSROOT="$(PWD)/build/sysroot" \
		$(BUSYBOX_BUILD_FLAGS)
build/sysroot/usr/bin/busybox: build/busybox/busybox
	@install -vDm755 $< $@
configure-busybox: build/busybox/.config
build-busybox: build/busybox/busybox
install-busybox: build/sysroot/usr/bin/busybox
clean-busybox: build/busybox/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-busybox configure-busybox build-busybox install-busybox
