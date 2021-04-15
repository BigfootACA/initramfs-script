build/adbd/adbd: build/adbd/Makefile build/hostroot/usr/bin/musl-gcc
	@$(MAKE) \
		-C build/adbd \
		CC="$(REALCC)" \
		$(ADBD_BUILD_FLAGS)
	@touch $@
build/sysroot/usr/bin/adbd: build/adbd/adbd
	@$(MAKE) \
		-C build/adbd \
		DESTDIR="$(SYSROOT)" \
		$(ADBD_INSTALL_FLAGS) \
		install
	@touch $@
install-adbd: build/sysroot/usr/bin/adbd
build-adbd: build/adbd/adbd
clean-adbd: build/adbd/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-adbd
.PHONY: build-adbd
.PHONY: install-adbd
