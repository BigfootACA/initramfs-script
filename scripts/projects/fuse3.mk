FUSE3_LIBS=\
	build/sysroot/usr/lib/libfuse3.so
FUSE3_BINS=\
	build/sysroot/usr/bin/fusermount3 \
	build/sysroot/usr/bin/mount.fuse3
build/fuse3/.patched: build/patches/fuse3.patch build/fuse3/meson.build
	@patch -Np1 < $<
	@touch $@
build/fuse3/meson.build: build/meson.conf build/fuse3/meson_options.txt
build/fuse3/build/build.ninja: build/hostroot/usr/bin/musl-gcc build/fuse3/meson.build build/fuse3/.patched build/sysroot/usr/lib/libudev.so
	@cd build/fuse3;meson \
		--prefix=/usr \
		--sbindir=bin \
		--cross-file=../meson.conf \
		. build \
		-Dexamples=false \
		-Duseroot=false \
		-Dudevrulesdir=/usr/lib/udev/rules.d \
		$(FUSE3_CONFIGURE_FLAGS)
build/fuse3/build/.built: build/hostroot/usr/bin/musl-gcc build/fuse3/build/build.ninja
	@ninja \
		-C build/fuse3/build \
		$(FUSE3_BUILD_FLAGS)
	@touch $@
build/fuse3/build/.installed: build/fuse3/build/.built
	@DESTDIR="$(SYSROOT)" ninja \
		-C build/fuse3/build \
		$(FUSE3_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/fuse3.pc
	@touch $@
$(FUSE3_LIBS) $(FUSE3_BINS): build/fuse3/build/.installed
configure-fuse3: build/fuse3/build/build.ninja
build-fuse3: build/fuse3/build/.built
install-fuse3: build/fuse3/build/.installed
clean-fuse3: build/fuse3/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-fuse3 configure-fuse3 build-fuse3 install-fuse3
