build/sysroot/usr/include/.kheaders: build/linux/Makefile
	@$(MAKE) \
		-C build/linux \
		INSTALL_HDR_PATH="$(SYSROOT)/usr" \
		$(KHEADERS_INSTALL_FLAGS) \
		headers_install
	@touch $@
build/sysroot/usr/include/.headers: build/headers
	@mkdir -pv "$(SYSROOT)/usr/include/"
	@cp -av $</* "$(SYSROOT)/usr/include/"
	@touch $@
install-headers: build/sysroot/usr/include/.headers
install-kheaders: build/sysroot/usr/include/.kheaders
clean-kheaders: build/linux/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-kheaders install-kheaders install-headers
