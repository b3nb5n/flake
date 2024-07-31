powered=false
connected=false

if bluetoothctl show | grep -q "Powered: yes"; then
	powered=true
fi

if bluetoothctl info | grep -q "Connected: yes"; then
	connected=true
fi

print_status() {
	echo "{\"powered\":$powered,\"connected\":$connected}"
}

print_status
bluetoothctl | while read -r line; do
	case $line in
		*"Powered: yes")
			powered=true
			;;
		*"Powered: no")
			powered=false
			;;
		*"Connected: yes")
			connected=true
			;;
		*"Connected: no")
			connected=false
			;;
		*)
			continue
			;;
	esac

	print_status
done
