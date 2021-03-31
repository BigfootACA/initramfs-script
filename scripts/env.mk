KERNEL?=zImage
CMDLINE?=
XSTRIP=$(PWD)/build/strip-wrapper
INSTALL?=install
BIN_INSTALL=$(INSTALL) --strip-program="$(XSTRIP)" -svDm755
SYSROOT=$(PWD)/build/sysroot
REALCC?=$(PWD)/build/musl-gcc
ifdef TARGET
ifndef CROSS_COMPILE
CROSS_COMPILE=$(TARGET)-
export CROSS_COMPILE
endif
endif
export REALCC
export SYSROOT