CLEAN_TARGETS=\
	clean-sysroot \
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
	clean-busybox
toolchain: build/musl-gcc
clean-sysroot:
	@rm -rf $(SYSROOT)/*
clean-build: $(CLEAN_TARGETS)
.PHONY: clean-build $(CLEAN_TARGETS)
include scripts/projects/*.mk
