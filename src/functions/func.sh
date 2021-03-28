function line_add_prefix(){ while read -r l;do echo "${1}${l}";done; }
function load_module(){ modprobe "${1}" &>/dev/null; }
function read_exists(){ [ -r "${1}" ]&&echo "$(<"${1}")"; }
function read_empty(){
	local data
	data="$(read_exists "${1}")"
	shift
	if [ -n "${data}" ]
	then echo "${data}"
	else echo "${@}"
	fi
}
function run_tty(){
	local tty
	case "${1}" in /dev/?*)tty="${1}";shift;;esac
	# shellcheck disable=SC2094
	"${@}" 0<"${tty}" 1>"${tty}" 2>"${tty}"
}
function on_failed(){
	echo "${@}"
	echo "${@}">/tmp/failed
	vibrate 200
	blink_led "${init_led}" 50 5 0.5 0.5
	wait
	case "${init_failed}" in
		sh|shell|bash)echo "drop into shell...";sync;run_tty /dev/console /usr/bin/bash;sleep 1;sync;;
		reboot|reset|restart|reload)echo "rebooting...";sync;sleep 1;reboot -f;exit 1;;
		halt|shutdown|poweroff|powerdown)echo "shutdowning...";sync;sleep 1;poweroff -f;exit 1;;
		panic|exit|quit)echo "drop into panic...";sync;sleep 1;exit 1;;
		usb|mass|gadget)echo "starting usb gadget";sync;start_usb_wait;;
		*)sleep 1;sync;;
	esac
	rm -f /tmp/failed
}
function auto_decompress(){
	case "$(file "${1}")" in
		*"XZ compressed data"*)xz -d <"${1}";;
		*"LZ4 compressed data"*)lz4 -d <"${1}";;
		*"LZMA compressed data"*)xz -d <"${1}";;
		*"gzip compressed data"*)gzip -d <"${1}";;
		*"bzip2 compressed data"*)bzip2 -d <"${1}";;
		*"Zstandard compressed data"*)zstd -d <"${1}";;
		*"compressed data"*)
			echo "Unsupported compress method for file $1"
			file "${1}"
			return 1
		;;
		?*)cat<"${1}"
	esac
}
function wait_block(){
	#1:block 2:label
	[ -b "${1}" ]||sleep 10
	while ! [ -b "${1}" ];do on_failed "cannot find ${2} ${1}";done
	echo "found ${2} on ${1}"
	show_block "${1}"
	sync
}
