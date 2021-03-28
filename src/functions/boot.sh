function find_init(){
	if
		[ -z "${init_init}" ]||\
		! [ -x "/root/${init_init}" ]||\
		! [ -f "/root/${init_init}" ]
	then	echo "find init..."
		sync
		for i in "${list_init[@]}"
		do	[ -x "/root/${i}" ]||continue
			[ -f "/root/${i}" ]||continue
			[ -d "/root/${i}" ]&&continue
			init_init="${i}"
			break
		done
		[ -x "/root/${init_init}" ]||\
			on_failed "failed to found init"
	fi
	echo "found init ${init_init}"
	show_file "/root/${init_init}"
	sync
}

function clean_up(){
	echo "clean up..."
	udevadm control --exit --timeout=10
	killall syslogd &>/dev/null
	killall dmesg &>/dev/null
	killall udevadm &>/dev/null
	sync
}

function switchroot(){
	echo "switch to new root with init ${init_init}..."
	sync
	exec env -i /usr/bin/switch_root /root "${init_init}"
}
