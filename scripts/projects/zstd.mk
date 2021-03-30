build/zstd/.patched: build/patches/zstd.patch
	@patch -Np1 < $<
	@touch $@
build/zstd/Makefile: build/zstd/.patched
build/zstd/.built: build/musl-gcc build/zstd/Makefile build/sysroot/usr/lib/liblzma.so build/sysroot/usr/lib/liblz4.so build/sysroot/usr/lib/libz.so
	@$(MAKE) \
		-C build/zstd \
		PREFIX="/usr" \
		CC="$(REALCC)" \
		$(ZSTD_BUILD_FLAGS)
	@touch $@
build/zstd/.installed: build/zstd/.built
	@$(MAKE) \
		-C build/zstd \
		PREFIX="/usr" \
		DESTDIR="$(PWD)/build/sysroot" \
		$(ZSTD_INSTALL_FLAGS) \
		install
	@touch $@
build/sysroot/usr/lib/libzstd.so build/sysroot/usr/bin/zstd: build/zstd/.installed
configure-zstd: build/zstd/Makefile
build-zstd: build/zstd/.built
install-zstd: build/zstd/.installed
clean-zstd: build/zstd/Makefile
	@make -C build/zstd clean
	@rm -f build/zstd/.built build/zstd/.installed
.PHONY: clean-zstd configure-zstd build-zstd install-zstd
