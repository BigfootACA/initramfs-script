all:initramfs.cpio
KERNEL?=zImage
CMDLINE?=
XSTRIP=$(PWD)/build/strip-wrapper
INSTALL?=install
BIN_INSTALL=$(INSTALL) --strip-program="$(XSTRIP)" -svDm755
SYSROOT=$(PWD)/build/sysroot
include scripts/deps.mk
include scripts/build.mk
include scripts/binary.mk
include scripts/link.mk
include scripts/library.mk
src/init.sh: root/usr/bin/bash
root/functions/%.sh:
	@install -vDm644 $< $@
root/functions/boot.sh:     src/functions/boot.sh     $(MOD_BOOT_DEP)
root/functions/cmdline.sh:  src/functions/cmdline.sh  $(MOD_CMDLINE_DEP)
root/functions/env.sh:      src/functions/env.sh      $(MOD_ENV_DEP)
root/functions/fs.sh:       src/functions/fs.sh       $(MOD_FS_DEP)
root/functions/func.sh:     src/functions/func.sh     $(MOD_FUNC_DEP)
root/functions/gadget.sh:   src/functions/gadget.sh   $(MOD_GADGET_DEP)
root/functions/hardware.sh: src/functions/hardware.sh $(MOD_HARDWARE_DEP)
root/functions/main.sh:     src/functions/main.sh     $(MOD_MAIN_DEP)
root/functions/service.sh:  src/functions/service.sh  $(MOD_SERVICE_DEP)
root/functions/show.sh:     src/functions/show.sh     $(MOD_SHOW_DEP)
root/init: src/init.sh root/usr/bin/bash $(INIT_MOD)
	@install -vDm755 $< $@
initramfs.cpio: root
	@cd root;find|cpio -o -H newc > ../initramfs.cpio
initramfs.cpio.gz: initramfs.cpio
	@gzip -v -c -9 < $< > $@
initramfs.cpio.xz: initramfs.cpio
	@xz -v --check=crc32 -9 < $< > $@
initramfs.cpio.zst: initramfs.cpio
	@zstd -v -T0 < $< > $@
initramfs.cpio.lz4: initramfs.cpio
	@lz4 -l < $< > $@
initramfs.cpio.lzo: initramfs.cpio
	@lzop -9 -v < $< > $@
initramfs.cpio.bz2: initramfs.cpio
	@bzip2 -v -c -9 < $< > $@
initramfs.cpio.lzma: initramfs.cpio
	@lzma -v -c -9 < $< > $@
initramfs.tar: root
	@cd root;find|tar --create . > ../initramfs.tar
initramfs.tar.gz: initramfs.tar
	@gzip -v -c -9 < $< > $@
initramfs.tar.xz: initramfs.tar
	@xz -v --check=crc32 -9 < $< > $@
initramfs.tar.zst: initramfs.tar
	@zstd -v -T0 < $< > $@
initramfs.tar.lz4: initramfs.tar
	@lz4 -l < $< > $@
initramfs.tar.lzo: initramfs.tar
	@lzop -9 -v < $< > $@
initramfs.tar.bz2: initramfs.tar
	@bzip2 -v -c -9 < $< > $@
initramfs.tar.lzma: initramfs.tar
	@lzma -v -c -9 < $< > $@
boot.img: $(KERNEL) initramfs.cpio.gz
	@abootimg \
		--create $@ \
		-c "cmdline=$(CMDLINE)" \
		-k $(KERNEL) \
		-r initramfs.cpio.gz
boot: boot.img
	@fastboot boot $<
flash-boot: boot.img
	fastboot flash boot $<
flash-recovery: boot.img
	fastboot flash recovery $<
root/usr/lib/firmware: firmware FORCE
	@mkdir -vp root/usr/lib
	@cp -uva $< root/usr/lib/
	@rm -f root/usr/lib/firmware/.gitkeep
root/usr/lib/modules: modules FORCE
	@mkdir -vp root/usr/lib
	@cp -uva $< root/usr/lib/
	@rm -f root/usr/lib/modules/.gitkeep
root/etc/bashrc: root/usr/bin/bash root/usr/bin/id
root/etc: assets/etc root/etc/bashrc FORCE
	@cp -uva $< root/
	@ln -sf /proc/self/mounts root/etc/mtab
root/usr/bin:
	@mkdir -p $@
root/bin: root/usr/bin
	@ln -vs usr/bin $@
root/sbin: root/usr/bin
	@ln -vs usr/bin $@
root/usr/sbin: root/usr/bin
	@ln -vs bin $@
root/lib: root/usr/lib
	@ln -vs usr/lib $@
root/usr/lib: root/usr/lib/firmware root/usr/lib/modules FORCE
root: extra root/init root/bin root/sbin root/usr/sbin root/lib root/etc
	@mkdir -pv \
		root/sys \
		root/dev \
		root/proc \
		root/run \
		root/tmp \
		root/log \
		root/root \
		root/rootblk
	@cp -va extra/* root/||true
check: root
	@cd root;shellcheck -x init
test: check
clean-root:
	@rm -rfv root
clean-initramfs-cpio:
	@rm -fv initramfs.cpio*
clean-initramfs-tar:
	@rm -fv initramfs.tar*
clean-initramfs-sfs:
	@rm -fv initramfs.sfs*
clean-initramfs: clean-initramfs-sfs clean-initramfs-tar clean-initramfs-cpio
clean-bootimg:
	@rm -fv boot.img
clean: clean-root clean-initramfs clean-bootimg clean-build
FORCE:
.PHONY: FORCE check all boot flash-boot flash-recovery
