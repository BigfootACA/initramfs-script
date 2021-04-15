build/bzip2/.patched: build/patches/bzip2.patch build/bzip2/Makefile-libbz2_so
	@patch -Np1 < $<
	@touch $@
build/bzip2/.built: build/hostroot/usr/bin/musl-gcc build/bzip2/.patched build/bzip2/Makefile
	@$(MAKE) \
		-f Makefile-libbz2_so \
		-C build/bzip2 \
		CC="$(REALCC)" \
		$(BZIP2_BUILD_FLAGS)
	@$(MAKE) \
		-C build/bzip2 \
		CC="$(REALCC)" \
		$(bzip2_BUILD_FLAGS) \
		libbz2.a
	@touch $@
build/bzip2/.installed: build/bzip2/.built
	@install -vDm755 build/bzip2/bzip2-shared build/sysroot/usr/bin/bzip2
	@install -vDm755 build/bzip2/libbz2.so build/sysroot/usr/lib/libbz2.so
	@install -vDm644 build/bzip2/libbz2.a build/sysroot/usr/lib/libbz2.a
	@install -vDm644 build/bzip2/bzlib.h build/sysroot/usr/include/bzlib.h
	@touch $@
build/sysroot/usr/lib/libbz2.so build/sysroot/usr/bin/bzip2: build/bzip2/.installed
build-bzip2: build/bzip2/.built
install-bzip2: build/bzip2/.installed
clean-bzip2: build/bzip2/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-bzip2 build-bzip2 install-bzip2
