function parse_cmdline(){
	local p="$-"
	local init_end=false
	set +x
	for i in $(</proc/cmdline)
	do
		case "${i}" in
			# Android boot mode
			androidboot.mode=?*)init_abootmode="${i//androidboot.mode=}";;

			# Android serial number
			androidboot.serialno=?*)init_abootserial="${i//androidboot.serialno=}";;

			# Android default USB Device Controller (UDC)
			androidboot.usbcontroller=?*)init_abootusb="${i//androidboot.usbcontroller=}";;
		esac
		"${init_end}"&&continue
		case "${i}" in
			# Language
			LANG=?*)LANG="${i//LANG=}";;
			LANGUAGE=?*)LANG="${i//LANGUAGE=}";;
			lang=?*)LANG="${i//lang=}";;
			language=?*)LANG="${i//language=}";;

			# Root block ReadOnly / ReadWrite
			ro|rw)init_ro="${i}";;

			# Loop root block ReadOnly / ReadWrite
			loopro|looprw)init_loopro="${i//loop}";;

			# Default init path in new root
			init=?*)init_init="${i//init=}";;

			# Failed action
			failed=?*)init_failed="${i//failed=}";;

			# Backlight led (sysfs led class)
			backlight=?*)init_backlight="${i//backlight=}";;

			# Blink led (sysfs led class)
			led=?*)init_led="${i//led=}";;

			# Kernel type
			kerneltype=?*)init_kerneltype="${i//kerneltype=}";;

			# Root loop block (by path)
			root=/dev/?*:/?*)
				init_root="${i//root=}"
				init_rootblk="${init_root//:?*}"
				init_root="${init_root//?*:}"
			;;

			# Root loop block (by identifier)
			root=?*=?*:?*)
				init_root="${i//root=}"
				init_rootblk="$(blkid -l -o device -t "${init_root//:?*}")"
				init_root="${init_root//?*:}"
			;;

			# Root block (by path)
			root=/dev/?*)init_root="${i//root=}";;

			# Root block (by identifier)
			root=?*=?*)init_root="$(blkid -l -o device -t "${i//root=}")";;

			# Root block mount flags
			rootflags=?*)init_rootopts="${i//rootflags=}";;

			# Root loop block mount flags
			loopflags=?*)init_loopopts="${i//loopflags=}";;

			# Root block filesystem type
			rootfstype=?*)init_rootfstype="${i//rootfstype=}";;

			# Root loop block filesystem type
			loopfstype=?*)init_loopfstype="${i//loopfstype=}";;

			# Block for hibernate resume (by path)
			resume=/dev/?*)init_resume="${i//resume=}";;

			# Block for hibernate resume (by identifier)
			resume=?*=?*)init_resume="$(blkid -l -o device -t "${i//resume=}")";;

			# USB gadget ID Vendor (0xXXXX, four hex digitals)
			usb.idVendor=?*)init_usb_id_vendor="${i//usb.idVendor=}";;

			# USB gadget ID Product (0xXXXX, four hex digitals)
			usb.idProduct=?*)init_usb_id_product="${i//usb.idProduct=}";;

			# USB gadget Manufacturer (string)
			usb.manufacturer=?*)init_usb_manufacturer="${i//usb.manufacturer=}";;

			# USB gadget Product (string)
			usb.product=?*)init_usb_product="${i//usb.product=}";;

			# USB gadget mass storage block mode
			multimass=lun|multimass=block)init_multimass="${i//multimass=}";;
			multimass=?*)echo "value ${i//multimass=} for option multimass is unknown";;

			# USB gadget control interface (adb/serial)
			control|control=true|control=on|control=1|control=yes)init_control=true;;

			# Auto enter USB gadget mass storage
			automass|automass=true|automass=on|automass=1|automass=yes)init_automass=true;;

			# Force enter USB gadget mass storage
			forcemass|forcemass=true|forcemass=on|forcemass=1|forcemass=yes)init_forcemass=true;;

			# Show boot menu
			menu|menu=true|menu=on|menu=1|menu=yes)init_menu=true;;

			# End all cmdline expect androidboot (avoid builtin cmdline)
			end|end=true|end=on|end=1|end=yes)init_end=true;;
		esac
	done
	echo "Parsed kernel cmdline:"
	export|line_add_prefix '  '
	case "${p}" in *x*)set -x;;esac
	sync
}
