CLEAN_TARGETS=\
	clean-configs \
	clean-sysroot \
	clean-hostroot \
	clean-adbd \
	clean-advreboot \
	clean-bash \
	clean-kheaders \
	clean-kmod \
	clean-lz4 \
	clean-musl \
	clean-ncurses \
	clean-readline \
	clean-util-linux \
	clean-xz \
	clean-zlib \
	clean-zstd \
	clean-bzip2 \
	clean-file \
	clean-eudev \
	clean-util-linux \
	clean-abootimg \
	clean-busybox \
	clean-libdrm \
	clean-json-c \
	clean-e2fsprogs \
	clean-lzo \
	clean-lvgl-initramfs-tools \
	clean-f2fs-tools \
	clean-btrfs-progs \
	clean-fuse2 \
	clean-fuse3 \
	clean-ntfs-3g \
	clean-musl-fts \
	clean-argp-standalone
toolchain: build/hostroot/usr/bin/musl-gcc
clean-sysroot:
	@rm -rf $(SYSROOT)/*
clean-hostroot:
	@find build/hostroot ! -type d ! -name musl-gcc.in ! -name strip-wrapper -exec rm -f {} \;
	@find build/hostroot -type d|sort -r|xargs rmdir --ignore-fail-on-non-empty
clean-configs:
	@rm -f build/meson.conf build/toolchain.cmake build/hostroot/usr/bin/musl-gcc
clean-build: $(CLEAN_TARGETS)
build/meson.conf: build/meson.conf.in build/hostroot/usr/bin/musl-gcc
	@sed \
		-e "s|%SYSROOT%|$(SYSROOT)|g;" \
		-e "s|%HOSTROOT%|$(HOSTROOT)|g;" \
		-e "s|%BUILD%|$(PWD)/build|g;" \
		-e "s|%ARCH%|$(ARCH)|g;" \
		-e "s|%ENDIAN%|$(ENDIAN)|g;" \
		-e "s|%CROSS_COMPILE%|$(CROSS_COMPILE)|g" \
		< $< > $@
build/toolchain.cmake: build/toolchain.cmake.in build/hostroot/usr/bin/musl-gcc
	@sed \
		-e "s|%SYSROOT%|$(SYSROOT)|g;" \
		-e "s|%HOSTROOT%|$(HOSTROOT)|g;" \
		-e "s|%BUILD%|$(PWD)/build|g;" \
		-e "s|%CROSS_COMPILE%|$(CROSS_COMPILE)|g" \
		< $< > $@
.PHONY: clean-build $(CLEAN_TARGETS)
include scripts/projects/*.mk
