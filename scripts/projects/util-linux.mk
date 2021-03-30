UL_DEPS=\
	build/sysroot/usr/lib/libz.so
build/util-linux/configure: build/util-linux/autogen.sh
	@cd build/util-linux;bash autogen.sh
build/util-linux/Makefile: build/musl-gcc build/util-linux/configure $(UL_DEPS)
	@cd build/util-linux;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--disable-rpath \
		--without-python \
		--without-systemd \
		--disable-pylibmount \
		--disable-bash-completion \
		--disable-all-programs \
		--enable-libsmartcols \
		--enable-libfdisk \
		--enable-libblkid \
		--enable-libuuid \
		--enable-fdisks \
		--enable-mount \
		--enable-losetup \
		--enable-fsck \
		--enable-blkid \
		$(UTIL_LINUX_CONFIGURE_FLAGS)
build/util-linux/libuuid.so: build/musl-gcc build/util-linux/Makefile
	@$(MAKE) \
		-C build/util-linux \
		CC="$(REALCC)" \
		$(UTIL_LINUX_BUILD_FLAGS)
build/sysroot/usr/lib/libuuid.so: build/util-linux/libuuid.so
	@$(MAKE) \
		-C build/util-linux \
		DESTDIR="$(PWD)/build/sysroot" \
		$(UTIL_LINUX_INSTALL_FLAGS) \
		install
configure-util-linux: build/util-linux/Makefile
build-util-linux: build/util-linux/libuuid.so
install-util-linux: build/sysroot/usr/lib/libuuid.so
clean-util-linux: build/util-linux/Makefile
	@make -C build/util-linux clean
.PHONY: clean-util-linux configure-util-linux build-util-linux install-util-linux