build/lz4/.patched: build/patches/lz4.patch
	@patch -Np1 < $<
	@touch $@
build/lz4/Makefile: build/lz4/.patched
build/lz4/.built: build/hostroot/usr/bin/musl-gcc build/lz4/Makefile
	@$(MAKE) \
		-C build/lz4 \
		PREFIX="/usr" \
		CC="$(REALCC)" \
		$(LZ4_BUILD_FLAGS)
	@touch $@
build/lz4/.installed: build/lz4/.built
	@$(MAKE) \
		-C build/lz4 \
		PREFIX="/usr" \
		DESTDIR="$(SYSROOT)" \
		$(LZ4_INSTALL_FLAGS) \
		install
	@touch $@
build/sysroot/usr/lib/liblz4.so build/sysroot/usr/bin/lz4: build/lz4/.installed
configure-lz4: build/lz4/Makefile
build-lz4: build/lz4/.built
install-lz4: build/lz4/.installed
clean-lz4: build/lz4/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-lz4 configure-lz4 build-lz4 install-lz4
