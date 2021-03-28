
function mount_block(){
	#1:source 2:target 3:label 4:fstype 5:ro/rw 6:options
	local opts fstype fs _file
	fs="${4}"
	[ -n "${fs}" ]&&fstype=" -t ${4}"
	[ -n "${5}" ]&&opts="${5}"
	if [ -n "${6}" ]
	then	if [ -z "${opts}" ]
		then opts="${6}"
		else opts="${opts},${6}"
		fi
	fi
	[ -n "${opts}" ]&&opts=" -o ${opts}"
	echo "mount ${3}..."
	case "${fs}" in
		initrd|initramfs|ramdisk)fs=cpio;;
		boot|abootimg|android)fs=aboot;;
	esac
	case "${fs}" in
		ar|tar|zip|cpio|aboot)
			mount -t tmpfs -o rw "${3}" "${2}"||\
				on_failed "failed to mount tmpfs to ${2}"

			_file="${1}"
			echo "unpacking ${fs} file ${_file}"
			if [ "${fs}" == "aboot" ]
			then	abootimg \
					-x "${_file}" \
					/dev/null \
					/dev/null \
					/tmp/initrd.img \
					/dev/null\
				||on_failed "failed to unpack Android Boot Image ${_file}"
				_file=/tmp/initrd.img
				fs=cpio
			fi

			pushd "${2}"||\
				on_failed "open mountpoint failed"
			case "${fs}" in
				zip)unzip "${_file}"||on_failed "failed to unpack zip file ${_file}";;
				cpio)auto_decompress "${_file}"|cpio -i||on_failed "failed to unpack cpio file ${_file}";;
				tar)auto_decompress "${_file}"|tar x||on_failed "failed to unpack tar file ${_file}";;
				ar)auto_decompress "${_file}"|ar -x||on_failed "failed to unpack ar file ${_file}";;
				*)return 1;;
			esac
			popd||return 1
		;;
		*)
			[ -n "${fs}" ]&&load_module "${4}"
			# shellcheck disable=SC2086
			while ! mount --verbose ${opts} ${fstype} "${1}" "${2}"
			do	on_failed "failed to mount ${3} ${1}"
				echo "retry to mount ${3}...";sync
			done
		;;
	esac
	echo "mounted ${3}"
	mount|grep -w "${1}"
	show_block "${1}"
	sync
}

function init_early_fs(){
	mount -t proc proc /proc
	mount -t sysfs sys /sys
	mount -t devtmpfs devfs /dev||mount -t tmpfs devfs /dev
	mount -t tmpfs -o mode=755 run /run
	mdev -s
}

function load_rootblk(){
	echo "using loop block ${init_root} from ${init_rootblk}"
	wait_block "${init_rootblk}" "loop rootblk"
	mount_block \
		"${init_rootblk}" \
		/rootblk \
		"loop rootblk" \
		"${init_loopfstype}" \
		"${init_loopro}" \
		"${init_loopopts}"

	local loopfile="/rootblk/${init_root}"
	[ -f "${loopfile}" ]||\
		on_failed "failed to found loop root ${init_root} on loop rootblk ${init_rootblk}"

	show_file "${loopfile}";sync
	load_module loop
	loopblk="$(losetup --show --find "${loopfile}")"||\
		on_failed "failed to run losetup"

	[ -b "${loopblk}" ]||\
		on_failed "losetup ${loopfile} failed"

	init_root="${loopblk}"
	losetup --all --list
	show_block "${loopblk}"
}

function prepare_block(){
	if [ -z "${init_rootblk}" ]
	then wait_block "${init_root}" "root"
	else load_rootblk
	fi
	sync
}

function setup_resume(){
	if [ -b "${init_resume}" ]&&[ -e /sys/power/resume ]
	then	echo "setup resume..."
		# shellcheck disable=SC2046 disable=SC2183
		printf "%d:%d" $(stat -Lc "0x%t 0x%T" "${init_resume}") >/sys/power/resume
	else	echo "no swap block or hibernate support."
	fi
	sync
}

function mount_root(){ mount_block "${init_root}" /root "${init_root}" "${init_rootfstype}" "${init_ro}" "${init_rootopts}"; }

function init_logfs(){
	logfs="$(blkid -l -o device -t PARTLABEL=logfs)"
	if ! [ -b "${logfs}" ]
	then	echo "cannot find logfs block '${logfs}'";LOG=false
	else	LOG=true
		mount -v -t vfat "${logfs}" /log
		load_module vfat
		rm -f /log/boot.{std{out,err},sysinfo,kernel,udev}.log
		touch /log/boot.{std{out,err},sysinfo,kernel,udev}.log
		dmesg -wx > /log/boot.kernel.log&
		exec 0<>/dev/null
		exec 1<>/log/boot.stdout.log
		exec 2<>/log/boot.stderr.log
		dump_info>/log/boot.sysinfo.log
		echo 'Started initramfs boot log.'
		echo 'Started initramfs boot log.'>&2
		echo '---------------------------'
		echo '---------------------------'>&2
		set -x
	fi
	syslogd -t -O -
	sync
}
