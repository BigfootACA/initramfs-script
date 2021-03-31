build/abootimg/abootimg: build/abootimg/Makefile build/musl-gcc build/sysroot/usr/lib/libblkid.so
	@$(MAKE) \
		-C build/abootimg \
		CC="$(REALCC)" \
		$(ABOOTIMG_BUILD_FLAGS)
	@touch $@
build/sysroot/usr/bin/abootimg: build/abootimg/abootimg
	@install -vDm755 $< $@
	@touch $@
install-abootimg: build/sysroot/usr/bin/abootimg
build-abootimg: build/abootimg/abootimg
clean-abootimg: build/abootimg/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-abootimg
.PHONY: build-abootimg
.PHONY: install-abootimg