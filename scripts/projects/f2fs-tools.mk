F2FS_DEPS=\
	build/sysroot/usr/lib/libblkid.so \
	build/sysroot/usr/lib/libuuid.so
F2FS_LIBS=\
	build/sysroot/usr/lib/libf2fs.so \
	build/sysroot/usr/lib/libf2fs_format.so
F2FS_BINS=\
	build/sysroot/usr/bin/f2fscrypt \
	build/sysroot/usr/bin/f2fstat \
	build/sysroot/usr/bin/fibmap.f2fs \
	build/sysroot/usr/bin/fsck.f2fs \
	build/sysroot/usr/bin/mkfs.f2fs \
	build/sysroot/usr/bin/parse.f2fs
build/f2fs-tools/.patched: build/patches/f2fs-tools.patch build/f2fs-tools/Makefile
	@patch -Np1 < $<
	@touch $@
build/f2fs-tools/libtool: build/f2fs-tools/Makefile
build/f2fs-tools/configure: build/f2fs-tools/autogen.sh
	@cd build/f2fs-tools;\
		bash autogen.sh; \
		sed -i '/sg_write_buffer/d' tools/Makefile.am
build/f2fs-tools/Makefile: build/musl-gcc build/f2fs-tools/configure $(E2P_DEPS)
	@cd build/f2fs-tools;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--sbindir=/usr/bin \
		--without-selinux \
		--with-sysroot="$(SYSROOT)" \
		$(F2FS_TOOLSCONFIGURE_FLAGS)
build/f2fs-tools/.built: build/musl-gcc build/f2fs-tools/.patched build/f2fs-tools/Makefile
	@$(MAKE) \
		-C build/f2fs-tools \
		CC="$(REALCC)" \
		$(F2FS_TOOLSBUILD_FLAGS)
	@touch $@
build/f2fs-tools/.installed: build/f2fs-tools/.built
	@$(MAKE) \
		-C build/f2fs-tools \
		DESTDIR="$(SYSROOT)" \
		$(F2FS_TOOLSINSTALL_FLAGS) \
		install
	@touch $@
$(E2P_BINS) $(E2P_LIBS): build/f2fs-tools/.installed
configure-f2fs-tools: build/f2fs-tools/Makefile
build-f2fs-tools: build/f2fs-tools/.built
install-f2fs-tools: build/f2fs-tools/.installed
clean-f2fs-tools: build/f2fs-tools/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-f2fs-tools configure-f2fs-tools build-f2fs-tools install-f2fs-tools