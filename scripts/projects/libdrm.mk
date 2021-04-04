build/libdrm/.patched: build/patches/libdrm.patch build/libdrm/meson.build
	@patch -Np1 < $<
	@touch $@
build/libdrm/meson.build: build/meson.conf build/libdrm/meson_options.txt
build/libdrm/build/build.ninja: build/musl-gcc build/libdrm/meson.build build/libdrm/.patched build/sysroot/usr/lib/libudev.so
	@cd build/libdrm;meson \
		--prefix=/usr \
		--cross-file=../meson.conf \
		. build \
		-Dlibkms=false \
		-Dintel=false \
		-Dradeon=false \
		-Damdgpu=false \
		-Dnouveau=false \
		-Dvmwgfx=false \
		-Domap=false \
		-Dexynos=false \
		-Dfreedreno=false \
		-Dtegra=false \
		-Dvc4=false \
		-Detnaviv=false \
		-Dcairo-tests=false \
		-Dman-pages=false \
		-Dvalgrind=false \
		-Dinstall-test-programs=false \
		-Dudev=true \
		$(LIBDRM_CONFIGURE_FLAGS)
build/libdrm/build/.built: build/musl-gcc build/libdrm/build/build.ninja
	@ninja \
		-C build/libdrm/build \
		$(LIBDRM_BUILD_FLAGS)
	@touch $@
build/libdrm/build/.installed: build/libdrm/build/.built
	@DESTDIR="$(SYSROOT)" ninja \
		-C build/libdrm/build \
		$(LIBDRM_INSTALL_FLAGS) \
		install
	@sed -i s,=/usr,=$(SYSROOT)/usr,g build/sysroot/usr/lib/pkgconfig/libdrm.pc
	@touch $@
sysroot/usr/lib/libdrm.so: build/libdrm/build/.installed
configure-libdrm: build/libdrm/build/build.ninja
build-libdrm: build/libdrm/build/.built
install-libdrm: build/libdrm/build/.installed
clean-libdrm: build/libdrm/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-libdrm configure-libdrm build-libdrm install-libdrm