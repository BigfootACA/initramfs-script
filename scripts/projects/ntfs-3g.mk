NTFS_DEPS=\
	build/sysroot/usr/lib/libz.so \
	build/sysroot/usr/lib/libfuse.so \
	build/sysroot/usr/lib/liblzo2.so \
	build/sysroot/usr/lib/libzstd.so \
	build/sysroot/usr/lib/libuuid.so \
	build/sysroot/usr/lib/libblkid.so
NTFS_LIBS=\
	build/sysroot/usr/lib/libntfs-3g.so
NTFS_BINS=\
        build/sysroot/usr/bin/lowntfs-3g \
        build/sysroot/usr/bin/mkfs.ntfs \
        build/sysroot/usr/bin/mkntfs \
        build/sysroot/usr/bin/mount.lowntfs-3g \
        build/sysroot/usr/bin/mount.ntfs \
        build/sysroot/usr/bin/mount.ntfs-3g \
        build/sysroot/usr/bin/ntfs-3g \
        build/sysroot/usr/bin/ntfs-3g.probe \
        build/sysroot/usr/bin/ntfscat \
        build/sysroot/usr/bin/ntfsclone \
        build/sysroot/usr/bin/ntfscluster \
        build/sysroot/usr/bin/ntfscmp \
        build/sysroot/usr/bin/ntfscp \
        build/sysroot/usr/bin/ntfsdecrypt \
        build/sysroot/usr/bin/ntfsfix \
        build/sysroot/usr/bin/ntfsinfo \
        build/sysroot/usr/bin/ntfslabel \
        build/sysroot/usr/bin/ntfsls \
        build/sysroot/usr/bin/ntfsrecover \
        build/sysroot/usr/bin/ntfsresize \
        build/sysroot/usr/bin/ntfssecaudit \
        build/sysroot/usr/bin/ntfstruncate \
        build/sysroot/usr/bin/ntfsundelete \
        build/sysroot/usr/bin/ntfsusermap \
        build/sysroot/usr/bin/ntfswipe
build/ntfs-3g/.patched: build/patches/ntfs-3g.patch build/ntfs-3g/libtool
	@patch -Np1 < $<
	@touch $@
build/ntfs-3g/libtool: build/ntfs-3g/Makefile
build/ntfs-3g/configure: build/ntfs-3g/autogen.sh
	@cd build/ntfs-3g;bash autogen.sh
build/ntfs-3g/Makefile: build/hostroot/usr/bin/musl-gcc build/ntfs-3g/configure $(NTFS_DEPS)
	@cd build/ntfs-3g;./configure \
		CC="$(REALCC)" \
		--host=$(TARGET) \
		--prefix=/usr \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sbindir=/usr/bin \
		--enable-extras \
		--with-uuid \
		--with-fuse=external \
		--with-sysroot="$(SYSROOT)" \
		$(NTFS_3G_CONFIGURE_FLAGS)
	@touch $@
build/ntfs-3g/.built: build/hostroot/usr/bin/musl-gcc build/ntfs-3g/.patched build/ntfs-3g/Makefile
	@$(MAKE) \
		-C build/ntfs-3g \
		CC="$(REALCC)" \
		$(NTFS_3G_BUILD_FLAGS)
	@touch $@
build/ntfs-3g/.installed: build/ntfs-3g/.built
	@$(MAKE) \
		-C build/ntfs-3g \
		DESTDIR="$(SYSROOT)" \
		$(NTFS_3G_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/libntfs-3g.pc
	@touch $@
$(NTFS_BINS) $(NTFS_LIBS): build/ntfs-3g/.installed
configure-ntfs-3g: build/ntfs-3g/Makefile
build-ntfs-3g: build/ntfs-3g/.built
install-ntfs-3g: build/ntfs-3g/.installed
clean-ntfs-3g: build/ntfs-3g/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-ntfs-3g configure-ntfs-3g build-ntfs-3g install-ntfs-3g
