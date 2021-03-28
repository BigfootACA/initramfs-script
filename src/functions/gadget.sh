function add_gadget_func(){
	#1: function 2: name
	load_module "usbfunc:${1}"
	local _path="${_GDG_FUNC}/${1}.${2}"
	[ -d "${_path}" ]&&return 1
	mkdir "${_path}"||return 1
	echo "${_path}"
}

function add_adb(){
	local _gdg
	echo "setup adb daemon"
	if ! _gdg="$(add_gadget_func ffs adb)"
	then
		echo "failed to add functionfs for adbd"
		return 1
	fi
	mkdir -p /dev/usb-ffs/adb
	load_module fs-functionfs
	mount -t functionfs adb /dev/usb-ffs/adb
	/usr/bin/adbd \
		-d \
		-n "${init_usb_manufacturer} ${init_usb_product}" \
		-m "${init_usb_manufacturer}" \
		-p "${init_usb_product}" \
		-b device
	ln -s "${_gdg}" "${_GDG_CFG}/"
}

function add_acm(){
	local _gdg
	echo "setup acm serial console"
	if ! _gdg="$(add_gadget_func acm ttyGS0)"
	then
		echo "failed to add acm device"
		return 1
	fi
	while true
	do run_tty /dev/ttyGS0 /bin/bash
	done &
	ln -s "${_gdg}" "${_GDG_CFG}/"
}

function add_mass_disk_blocks(){
	local _gdg _dev _type _path
	echo "setup mass_storage with multi-block mode"
	lsblk -rno KNAME,TYPE,PATH|while read -r _dev _type _path _
	do
		[ "${_type}" != "disk" ]&&continue
		case "${_dev}" in
			# VirtIO, UFS/SATA/SCSI, eMMC/SD Card/microSD, NVMe
			vd?*|sd?*|mmcblk?*|nvme?*);;
			?*)continue;;
		esac
		if ! _gdg="$(add_gadget_func mass_storage "${_dev}")"
		then
			echo "failed to add mass storage function ${_dev}"
			continue
		fi
		echo -n "${_path}" > "${_gdg}/lun.0/file"
		ln -s "${_gdg}" "${_GDG_CFG}/"
		sync
	done
}

function add_mass_disk_luns(){
	local _gdg _luns _lun _dev _type _path
	echo "setup mass_storage with multi-lun mode"
	if ! _gdg="$(add_gadget_func mass_storage disk)"
	then
		echo "failed to add mass storage function"
		return 1
	fi
	mkdir -p /tmp/luns
	lsblk -rno KNAME,TYPE,PATH|while read -r _dev _type _path _
	do	[ "${_type}" != "disk" ]&&continue
		case "${_dev}" in
			# VirtIO, UFS/SATA/SCSI, eMMC/SD Card/microSD, NVMe
			vd?*|sd?*|mmcblk?*|nvme?*);;
			?*)continue;;
		esac
		_lun=""
		for _luns in {0..32}
		do
			[ -f "/tmp/luns/${_luns}" ]&&continue
			touch "/tmp/luns/${_luns}"
			_lun="${_gdg}/lun.${_luns}"
		done
		if [ -z "${_lun}" ]
		then
			echo "no availables lun found"
			break
		fi
		[ -d "${_lun}" ]||mkdir "${_lun}"
		echo -n "${_path}" > "${_lun}/file"
		sync
	done
	rm -f /tmp/luns/*
	rmdir /tmp/luns
	ln -s "${_gdg}" "${_GDG_CFG}/"
	sync
}

function show_splash(){
	exit_splash
	mkfifo /run/splash
	echo "start show splash ${1}"
	fbsplash \
		-s "${1}" \
		-i /etc/fbsplash.cfg \
		-f /run/splash &
	set_led "${init_backlight}" 50
}

function exit_splash(){
	[ -e /run/splash ]||return
	echo "stop show splash"
	echo exit > /run/splash
	rm -f /run/splash
}

function show_usb(){ show_splash /etc/usb.ppm; }

function init_gadget(){
	load_module libcomposite
	mountpoint -q "${_CFS}"||mount -t configfs configfs "${_CFS}"
	mkdir "${_GDG}"
	echo -n "${init_usb_id_vendor}" > "${_GDG}/idVendor"
	echo -n "${init_usb_id_product}" > "${_GDG}/idProduct"
	echo -n 0x0200 > "${_GDG}/bcdUSB"
	mkdir "${_GDG_CFG}"
	mkdir "${_GDG}/strings/0x409"
	echo "${init_abootserial}" > "${_GDG}/strings/0x409/serialnumber"
	echo "${init_usb_manufacturer}" > "${_GDG}/strings/0x409/manufacturer"
	echo "${init_usb_product}" > "${_GDG}/strings/0x409/product"
	echo -n 1 > "${_GDG}/os_desc/use"
	echo -n 0x1 > "${_GDG}/os_desc/b_vendor_code"
	echo -n MSFT100 > "${_GDG}/os_desc/qw_sign"
	ln -s "${_GDG_CFG}" "${_GDG}/os_desc/a.1"
	mkdir "${_GDG_CFG}/strings/0x409"
	echo -n "INITRAMFS" > "${_GDG}/configs/b.1/strings/0x409/configuration"
	sync
}

function start_gadget(){
	load_module udc-core
	if [ -n "${init_abootusb}" ]
	then
		echo "${init_abootusb}" >"${_GDG}/UDC"
	else
		for i in /sys/class/udc/*
		do
			[ -h "${i}" ]||continue
			case "${i}" in *dummy*|*vudc*)continue;;esac
			basename "$i" > "${_GDG}/UDC"
			break
		done
	fi
	sync
}

function init_usb_control(){
	add_adb
	add_acm
}

function start_usb(){
	echo "starting usb gadget mass storage";sync
	init_gadget
	case "${init_multimass}" in
		lun)add_mass_disk_luns;;
		block)add_mass_disk_blocks;;
	esac
	"${init_control}"&&init_usb_control
	start_gadget
}

function start_usb_wait(){
	show_usb
	start_usb
	while true
	do sleep 3600
	done
	exit_splash
}
