export PATH=/bin
export init_init=/usr/lib/systemd/systemd
export init_ro=ro
export init_loopro=rw
export init_rootopts=
export init_loopopts=
export init_rootfstype=
export init_loopfstype=
export init_rootblk=
export init_backlight=
export init_kerneltype=mainline
export init_failed=shell
export init_abootmode=normal
export init_abootusb=
export init_abootserial=
export init_control=false
export init_automass=false
export init_multimass=lun
export init_forcemass=false
export init_menu=false
export init_led=
export init_usb_id_vendor=0x2717
export init_usb_id_product=0xff88
export init_usb_manufacturer=Android
export init_usb_product="Mass Stroage"
export _CFS=/sys/kernel/config
export _GDG="${_CFS}/usb_gadget/gadget"
export _GDG_FUNC="${_GDG}/functions"
export _GDG_CFG="${_GDG}/configs/a.1"
export list_init=(
	/usr/lib/systemd/systemd
	/lib/systemd/systemd
	/sbin/init
	/bin/init
	/usr/sbin/init
	/usr/bin/init
	/init
	/linuxrc
)
