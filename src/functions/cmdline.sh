function parse_cmdline(){
	local p="$-"
	local init_end=false
	set +x
	for i in $(</proc/cmdline)
	do
		case "${i}" in
			androidboot.mode=?*)init_abootmode="${i//androidboot.mode=}";;
			androidboot.serialno=?*)init_abootserial="${i//androidboot.serialno=}";;
			androidboot.usbcontroller=?*)init_abootusb="${i//androidboot.usbcontroller=}";;
		esac
		"${init_end}"&&continue
		case "${i}" in
			LANG=?*)LANG="${i//LANG=}";;
			LANGUAGE=?*)LANG="${i//LANGUAGE=}";;
			lang=?*)LANG="${i//lang=}";;
			language=?*)LANG="${i//language=}";;
			ro|rw)init_ro="${i}";;
			loopro|looprw)init_loopro="${i//loop}";;
			init=?*)init_init="${i//init=}";;
			failed=?*)init_failed="${i//failed=}";;
			backlight=?*)init_backlight="${i//backlight=}";;
			led=?*)init_led="${i//led=}";;
			kerneltype=?*)init_kerneltype="${i//kerneltype=}";;
			root=/dev/?*:/?*)
				init_root="${i//root=}"
				init_rootblk="${init_root//:?*}"
				init_root="${init_root//?*:}"
			;;
			root=?*=?*:?*)
				init_root="${i//root=}"
				init_rootblk="$(blkid -l -o device -t "${init_root//:?*}")"
				init_root="${init_root//?*:}"
			;;
			root=/dev/?*)init_root="${i//root=}";;
			root=?*=?*)init_root="$(blkid -l -o device -t "${i//root=}")";;
			rootflags=?*)init_rootopts="${i//rootflags=}";;
			loopflags=?*)init_loopopts="${i//loopflags=}";;
			rootfstype=?*)init_rootfstype="${i//rootfstype=}";;
			loopfstype=?*)init_loopfstype="${i//loopfstype=}";;
			resume=/dev/?*)init_resume="${i//resume=}";;
			resume=?*=?*)init_resume="$(blkid -l -o device -t "${i//resume=}")";;
			usb.idVendor=?*)init_usb_id_vendor="${i//usb.idVendor=}";;
			usb.idProduct=?*)init_usb_id_product="${i//usb.idProduct=}";;
			usb.manufacturer=?*)init_usb_manufacturer="${i//usb.manufacturer=}";;
			usb.product=?*)init_usb_product="${i//usb.product=}";;
			multimass=lun|multimass=block)init_multimass="${i//multimass=}";;
			multimass=?*)echo "value ${i//multimass=} for option multimass is unknown";;
			control|control=true|control=on|control=1|control=yes)init_control=true;;
			automass|automass=true|automass=on|automass=1|automass=yes)init_automass=true;;
			forcemass|forcemass=true|forcemass=on|forcemass=1|forcemass=yes)init_forcemass=true;;
			menu|menu=true|menu=on|menu=1|menu=yes)init_menu=true;;
			end|end=true|end=on|end=1|end=yes)init_end=true;;
		esac
	done
	echo "Parsed kernel cmdline:"
	export|line_add_prefix '  '
	case "${p}" in *x*)set -x;;esac
	sync
}
