build/advreboot/advreboot: build/musl-gcc build/advreboot/Makefile
	@$(MAKE) \
		-C build/advreboot \
		CC="$(REALCC)" \
		$(ADVREBOOT_BUILD_FLAGS)
	@touch $@
build/sysroot/usr/bin/advreboot: build/advreboot/advreboot
	@$(MAKE) \
		-C build/advreboot \
		DESTDIR="$(PWD)/build/sysroot" \
		$(ADVREBOOT_INSTALL_FLAGS)
	@touch $@
build-advreboot: build/advreboot/advreboot
install-advreboot: build/sysroot/usr/bin/advreboot
clean-advreboot: build/advreboot/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-advreboot
.PHONY: build-advreboot
.PHONY: install-advreboot