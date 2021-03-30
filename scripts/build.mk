REALCC?=$(PWD)/build/musl-gcc
ifdef TARGET
ifndef CROSS_COMPILE
CROSS_COMPILE=$(TARGET)-
export CROSS_COMPILE
endif
endif
export REALCC
toolchain: build/musl-gcc
clean-sysroot:
	@rm -rf build/sysroot/*
	@rm -f build/progress/*
clean-build: clean-musl clean-kheaders clean-sysroot clean-advreboot clean-adbd
.PHONY: clean-build clean-sysroot
include scripts/projects/*.mk
