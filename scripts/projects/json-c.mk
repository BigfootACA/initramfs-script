build/json-c/.patched: build/patches/json-c.patch build/json-c/CMakeLists.txt
	@patch -Np1 < $<
	@touch $@
build/json-c/CMakeLists.txt: build/toolchain.cmake
build/json-c/build/Makefle: build/musl-gcc build/json-c/CMakeLists.txt build/json-c/.patched
	@echo|$(REALCC) -mno-outline-atomics -E - &>/dev/null&&FLAGS="-mno-outline-atomics";\
	cd build/json-c;cmake \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		-DCMAKE_C_FLAGS="$$FLAGS" \
		-DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake \
		-S . \
		-B build \
		$(JSON_C_CONFIGURE_FLAGS)
	@touch $@
build/json-c/build/.built: build/musl-gcc build/json-c/build/Makefle
	@$(MAKE) \
		-C build/json-c/build \
		$(JSON_C_BUILD_FLAGS)
	@touch $@
build/json-c/build/.installed: build/json-c/build/.built
	@$(MAKE) \
		-C build/json-c/build \
		DESTDIR="$(SYSROOT)" \
		$(JSON_C_INSTALL_FLAGS) \
		install
	@touch $@
build/sysroot/usr/lib/libjson-c.so: build/json-c/build/.installed
configure-json-c: build/json-c/build/Makefle
build-json-c: build/json-c/build/.built
install-json-c: build/json-c/build/.installed
clean-json-c: build/json-c/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-json-c configure-json-c build-json-c install-json-c