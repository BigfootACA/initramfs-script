REALCC?=$(PWD)/build/musl-gcc
ifdef TARGET
ifndef CROSS_COMPILE
CROSS_COMPILE=$(TARGET)-
export CROSS_COMPILE
endif
endif
export REALCC
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
	clean-zstd
toolchain: build/musl-gcc
clean-sysroot:
	@rm -rf build/sysroot/*
	@rm -f build/progress/*
clean-build: $(CLEAN_TARGETS)
.PHONY: clean-build $(CLEAN_TARGETS)
include scripts/projects/*.mk
