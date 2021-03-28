function start_udevd(){
	load_module unix
	/usr/bin/udevd \
		--resolve-names=never \
		--daemon \
		--exec-delay=3 \
		--event-timeout=3
	[ "${LOG}" == "true" ]&&udevadm monitor \
		--kernel \
		--udev \
		--property \
		&>/log/boot.udev.log &
	sleep 0.3
	udevadm trigger --type=subsystems --action=add
	udevadm trigger --type=devices --action=add
	udevadm settle --timeout=10
	sync
}

function start_charger(){
	if [ "${init_kerneltype}" == "android" ]&&[ "${init_abootmode}" == "charger" ]
	then	set_led "${init_backlight}" 50
		"${init_automass}"&&start_usb
		echo "starting android charger";sync
		charger;sync
		echo "shutdowning..."
		poweroff -f;sync
		exit 1
	fi
}
