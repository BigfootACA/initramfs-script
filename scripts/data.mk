root/usr/share/misc/magic.mgc: build/sysroot/usr/share/misc/magic.mgc
	@install -vDm644 $< $@
root/usr/lib/udev/ata_id: build/sysroot/usr/lib/udev/ata_id
	@$(BIN_INSTALL) $< $@
root/usr/lib/udev/cdrom_id: build/sysroot/usr/lib/udev/cdrom_id
	@$(BIN_INSTALL) $< $@
root/usr/lib/udev/collect: build/sysroot/usr/lib/udev/collect
	@$(BIN_INSTALL) $< $@
root/usr/lib/udev/mtd_probe: build/sysroot/usr/lib/udev/mtd_probe
	@$(BIN_INSTALL) $< $@
root/usr/lib/udev/scsi_id: build/sysroot/usr/lib/udev/scsi_id
	@$(BIN_INSTALL) $< $@
root/usr/lib/udev/v4l_id: build/sysroot/usr/lib/udev/v4l_id
	@$(BIN_INSTALL) $< $@
