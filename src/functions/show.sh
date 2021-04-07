function each_sys_dev(){
	for i in "/sys/dev/${1}"/*/uevent
	do
		printf '    TYPE=%s' "${1}"
		while read -r l
		do echo -n ", ${l}"
		done<"${i}"
		echo
	done
}

function each_sys_devs(){
	for i in "$@"
	do each_sys_dev "${i}"
	done
}

function dump_info(){
	date;echo '---------------------------'
	echo "Kernel: ";                line_add_prefix '    '</proc/version;echo '---------------------------'
	echo "Kernel cmdline: ";        line_add_prefix '    '</proc/cmdline;echo '---------------------------'
	echo "CPU info: ";              line_add_prefix '    '</proc/cpuinfo;echo '---------------------------'
	echo "Memory info: ";           line_add_prefix '    '</proc/meminfo;echo '---------------------------'
	echo "Mount list: ";      mount|line_add_prefix '    ';              echo '---------------------------'
	echo "System blocks: ";lsblk -O|line_add_prefix '    ';              echo '---------------------------'
	echo "System devices: ";        each_sys_devs char block;            echo '---------------------------'
	sync
}

function show_file(){
	local file="${1//\/\//\/}"
	echo "Show file of ${file}"
	{
		ls -lh "${file}"
		file "${file}"
	}|line_add_prefix '  '
}

function show_block(){
	local p="$-"
	set +x
	# shellcheck disable=2046
	eval local $(lsblk -Pdno NAME,PKNAME,SIZE,FSSIZE,FSUSED,FSAVAIL,FSUSE%,MOUNTPOINT "${1}"|sed 's/%/P/') P=0
	# shellcheck disable=SC2034 disable=2046
	local $(blkid -o export "${1}") P=0
	echo "Show block of ${1} :"
	DEV="/sys/block/${PKNAME:-${NAME}}/device"
	MODEL="$(read_empty "${DEV}/model"  '(unknown)')"
	VENDOR="$(read_empty "${DEV}/vendor" '(unknown)')"
	if [ -n "${PKNAME}" ]
	then
		echo "  Partition info:"
		echo "    Size:  ${SIZE:-(unknown)}"
		echo "    UUID:  ${PARTUUID:-(unknown)}"
		echo "    Label: ${PARTLABEL:-(unknown)}"
		echo "    Disk:  ${PKNAME}"
		echo "      Type:   $(blkid -o value -s PTTYPE "/dev/${PKNAME}")"
		echo "      Size:   $(lsblk -rdno SIZE "/dev/${PKNAME}")"
		echo "      Vendor: ${VENDOR}"
		echo "      Model:  ${MODEL}"
	elif [ -n "${PTTYPE}" ]
	then
		echo "  Disk info:"
		echo "    Type:   ${PTTYPE}"
		echo "    Size:   ${SIZE:-(unknown)}"
		echo "    UUID:   ${PTUUID:-(unknown)}"
		echo "    Vendor: ${VENDOR}"
		echo "    Model:  ${MODEL}"
	fi
	if [ -n "${TYPE}" ]
	then
		echo "  Filesystem info:"
		echo "    Type:  ${TYPE:-(unknown)}"
		echo "    UUID:  ${UUID:-(unknown)}"
		echo "    Label: ${LABEL:-(none)}"
		if [ -n "${MOUNTPOINT}" ]
		then
			echo "    Mount: ${MOUNTPOINT}"
			echo "    Size:  ${FSUSED:-0B}/${FSSIZE:-0B} (${FSUSEP:-0%})"
			echo "    Avail: ${FSAVAIL:-0B}"
			echo "  List of ${MOUNTPOINT}:"
			# shellcheck disable=SC2012
			ls -lh "${MOUNTPOINT}"|line_add_prefix '    '
		fi
	fi
	case "${p}" in *x*)set -x;;esac
}

function show_menu(){
	local _mode
	echo "start gui boot menu"
	_mode="$(menu /etc/bootmenu.json)"
	if [ -z "${_mode}" ]
	then echo "none selected, fallback to linux"
	else echo "selected ${_mode}"
	fi
	sync
	case "${_mode}" in
		linux)return;;
		edl)advreboot edl;sleep 5;exit 1;;
		android)sync;reboot -f;sleep 5;exit 1;;
		recovery)advreboot recovery;sleep 5;exit 1;;
		fastboot)advreboot bootloader;sleep 5;exit 1;;
		shutdown)poweroff -f;sleep 5;exit 1;;
		mass_lun)
			init_multimass=lun
			init_control=false
			start_usb_wait
		;;
		mass_block)
			init_multimass=block
			init_control=false
			start_usb_wait
		;;
		control)
			init_multimass=none
			init_control=true
			start_usb_wait
		;;
		*)echo "unknown select: ${_mode}";return;;
	esac
}
