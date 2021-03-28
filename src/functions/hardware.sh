function vibrate(){
	local timed=/sys/class/timed_output/vibrator/enable
	local led=/sys/class/leds/vibrator
	if [ -f "${timed}" ]
	then echo -n "${1}" >"${timed}"
	elif [ -d "${led}" ]
	then
		echo -n "${1}" >"${led}/duration"
		echo -n 1 >"${led}/activate"
	fi
}

function set_led(){
	#1:device 2:percent
	local sysled="/sys/class/leds/${1}"
	local max
	if [ -n "${1}" ]&&[ -h "${sysled}" ]
	then
		max="$(<"${sysled}/max_brightness")"
		echo -n "$(("${max}"*"${2}"/100))" > "${sysled}/brightness"
	fi
}

function blink_led(){
	#1:device 2:percent 3:times 4:on_time 5:delay
	{
		set +x
		for((i=1;i<="$3";i++))
		do
			set_led "$1" "$2";sleep "$4"
			set_led "$1" 0;sleep "$5"
		done
	} &
}
