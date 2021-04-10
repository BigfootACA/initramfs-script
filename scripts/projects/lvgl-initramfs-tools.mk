LVGLTOOLS_OUTS=\
	build/sysroot/usr/bin/usb \
	build/sysroot/usr/bin/menu \
	build/sysroot/usr/lib/liblvgl.so \
	build/sysroot/usr/lib/liblvgl_font.so \
	build/sysroot/usr/lib/liblvgl_icon.so \
	build/sysroot/usr/lib/liblvgl_tool.so
build/lvgl-initramfs-tools/lvgl/Makefile:
	@cd build/lvgl-initramfs-tools/lvgl/;\
		git submodule init;\
		git submodule update
	@touch $@
build/lvgl-initramfs-tools/.built: build/musl-gcc build/lvgl-initramfs-tools/Makefile build/sysroot/usr/lib/libdrm.so build/sysroot/usr/lib/libjson-c.so
	@$(MAKE) \
		-C build/lvgl-initramfs-tools \
		NO_DEFAULT=1 \
		CC="$(REALCC)" \
		STRIP="$(XSTRIP)" \
		$(LVGL_INITRAMFS_TOOLS_BUILD_FLAGS)
	@touch $@
build/lvgl-initramfs-tools/.installed: build/lvgl-initramfs-tools/.built
	@install -vDm755 build/lvgl-initramfs-tools/usb build/sysroot/usr/bin/usb
	@install -vDm755 build/lvgl-initramfs-tools/menu build/sysroot/usr/bin/menu
	@install -vDm755 build/lvgl-initramfs-tools/lvgl-build/liblvgl.so build/sysroot/usr/lib/liblvgl.so
	@install -vDm755 build/lvgl-initramfs-tools/fonts/liblvgl_font.so build/sysroot/usr/lib/liblvgl_font.so
	@install -vDm755 build/lvgl-initramfs-tools/icons/liblvgl_icon.so build/sysroot/usr/lib/liblvgl_icon.so
	@install -vDm755 build/lvgl-initramfs-tools/src/liblvgl_tool.so build/sysroot/usr/lib/liblvgl_tool.so
	@touch $@
$(LVGLTOOLS_OUTS): build/lvgl-initramfs-tools/.installed
build-lvgl-initramfs-tools: build/lvgl-initramfs-tools/.built
install-lvgl-initramfs-tools: build/lvgl-initramfs-tools/.installed
clean-lvgl-initramfs-tools: build/lvgl-initramfs-tools/.git
	@cd $(shell dirname $<)&&git clean -xdf&&git reset --hard
.PHONY: clean-lvgl-initramfs-tools
.PHONY: build-lvgl-initramfs-tools
.PHONY: install-lvgl-initramfs-tools
