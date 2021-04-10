BTRFS_DEPS=\
	build/sysroot/usr/lib/libz.so \
	build/sysroot/usr/lib/liblzo2.so \
	build/sysroot/usr/lib/libzstd.so \
	build/sysroot/usr/lib/libuuid.so \
	build/sysroot/usr/lib/libblkid.so
BTRFS_LIBS=\
	build/sysroot/usr/lib/libbtrfs.so \
	build/sysroot/usr/lib/libbtrfsutil.so
BTRFS_BINS=\
	build/sysroot/usr/bin/btrfs \
	build/sysroot/usr/bin/btrfs-convert \
	build/sysroot/usr/bin/btrfs-find-root \
	build/sysroot/usr/bin/btrfs-image \
	build/sysroot/usr/bin/btrfs-map-logical \
	build/sysroot/usr/bin/btrfs-select-super \
	build/sysroot/usr/bin/btrfsck \
	build/sysroot/usr/bin/btrfstune \
	build/sysroot/usr/bin/fsck.btrfs \
	build/sysroot/usr/bin/mkfs.btrfs
build/btrfs-progs/.patched: build/patches/btrfs-progs.patch
	@patch -Np1 < $<
	@touch $@
build/btrfs-progs/libtool: build/btrfs-progs/Makefile
build/btrfs-progs/configure: build/btrfs-progs/autogen.sh build/btrfs-progs/.patched
	@cd build/btrfs-progs;bash autogen.sh
build/btrfs-progs/version.h: build/musl-gcc build/btrfs-progs/configure $(BTRFS_DEPS)
	@cd build/btrfs-progs;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--sbindir=/usr/bin \
		--with-crypto=builtin \
		--disable-documentation \
		--disable-backtrace \
		--disable-convert \
		--disable-python \
		$(BTRFS_PROGS_CONFIGURE_FLAGS)
	@touch $@
build/btrfs-progs/.built: build/musl-gcc build/btrfs-progs/version.h
	@$(MAKE) \
		-C build/btrfs-progs \
		CC="$(REALCC)" \
		$(BTRFS_PROGS_BUILD_FLAGS)
	@touch $@
build/btrfs-progs/.installed: build/btrfs-progs/.built
	@$(MAKE) \
		-C build/btrfs-progs \
		DESTDIR="$(SYSROOT)" \
		$(BTRFS_PROGS_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/libbtrfsutil.pc
	@touch $@
$(BTRFS_BINS) $(BTRFS_LIBS): build/btrfs-progs/.installed
configure-btrfs-progs: build/btrfs-progs/version.h
build-btrfs-progs: build/btrfs-progs/.built
install-btrfs-progs: build/btrfs-progs/.installed
clean-btrfs-progs: build/btrfs-progs/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-btrfs-progs configure-btrfs-progs build-btrfs-progs install-btrfs-progs
