SHELL=/bin/bash
KERNEL?=zImage
CMDLINE?=
XSTRIP=$(PWD)/build/strip-wrapper
INSTALL?=install
BIN_INSTALL=$(INSTALL) --strip-program="$(XSTRIP)" -svDm755
SYSROOT=$(PWD)/build/sysroot
REALCC?=$(PWD)/build/musl-gcc
ifndef TARGET
$(error TARGET not specified)
endif
ifndef CROSS_COMPILE
CROSS_COMPILE=$(TARGET)-
export CROSS_COMPILE
endif
ARCH?=$(shell echo $${TARGET/-*})
ENDIAN?=little
export REALCC
export SYSROOT
AR?=$(CROSS_COMPILE)ar
RANLIB?=$(CROSS_COMPILE)ranlib
PKG_CONFIG_SYSROOT_DIR?=$(SYSROOT)
PKG_CONFIG_LIBDIR?=$(SYSROOT)/usr/lib/pkgconfig
PKG_CONFIG_SYSTEM_LIBRARY_PATH?=$(SYSROOT)/usr/lib
PKG_CONFIG_SYSTEM_INCLUDE_PATH?=$(SYSROOT)/usr/include
PKGCONF?=pkgconf
export ENDIAN
export ARCH
export PKGCONF
export REALCC
export SYSROOT
export AR
export RANLIB
export PKG_CONFIG_SYSROOT_DIR
export PKG_CONFIG_LIBDIR
export PKG_CONFIG_SYSTEM_INCLUDE_PATH
export PKG_CONFIG_SYSTEM_LIBRARY_PATH
