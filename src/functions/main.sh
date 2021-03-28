init_early_fs
blink_led "${init_led}" 50 3 0.1 0.1
vibrate 20
depmod &>/dev/null
init_logfs
parse_cmdline
start_udevd
"${init_forcemass}"&&start_usb_wait
start_charger
"${init_menu}"&&show_menu
prepare_block
setup_resume
mount_root
find_init
vibrate 50
blink_led "${init_led}" 50 2 0.2 0.2
clean_up
wait
switchroot