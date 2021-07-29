build/freetype/.patched: build/patches/freetype.patch
	@patch -Np1 < $<
	@touch $@
build/freetype/meson.build: build/meson.conf build/freetype/meson_options.txt
build/freetype/build/build.ninja: build/hostroot/usr/bin/musl-gcc build/freetype/meson.build build/freetype/.patched build/sysroot/usr/lib/libz.so build/sysroot/usr/lib/pkgconfig/bz2.pc
	@cd build/freetype;meson \
		--prefix=/usr \
		--cross-file=../meson.conf \
		. build \
		-Dzlib=system \
		-Dbzip2=enabled \
		-Dpng=disabled \
		-Dharfbuzz=disabled \
		-Dmmap=disabled \
		$(FREETYPE_CONFIGURE_FLAGS)
build/freetype/build/.built: build/hostroot/usr/bin/musl-gcc build/freetype/build/build.ninja
	@ninja \
		-C build/freetype/build \
		$(FREETYPE_BUILD_FLAGS)
	@touch $@
build/sysroot/usr/lib/libfreetype2.so: build/freetype/build/.built
	@DESTDIR="$(SYSROOT)" ninja \
		-C build/freetype/build \
		$(FREETYPE_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/freetype2.pc
	@touch $@
configure-freetype: build/freetype/build/build.ninja
build-freetype: build/freetype/build/.built
install-freetype: build/sysroot/usr/lib/libfreetype2.so
clean-freetype: build/freetype/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-freetype configure-freetype build-freetype install-freetype
