build/progress/kheaders: build/linux/Makefile
	@$(MAKE) \
		-C build/linux \
		INSTALL_HDR_PATH="$(PWD)/build/sysroot/usr" \
		$(KHEADERS_INSTALL_FLAGS) \
		headers_install
	@echo > $@
build/progress/headers: build/headers
	@mkdir -pv "$(PWD)/build/sysroot/usr/include/"
	@cp -av $</* "$(PWD)/build/sysroot/usr/include/"
	@echo > $@
install-headers: build/progress/headers
install-kheaders: build/progress/kheaders
clean-kheaders: build/linux/.git
	@git clean -xdf
	@git reset --hard
.PHONY: clean-kheaders install-kheaders install-headers
