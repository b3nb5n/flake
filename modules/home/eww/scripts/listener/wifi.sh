powered=false
if [[ $(nmcli radio wifi) = "enabled" ]]; then
	powered=true
fi

connected=false
if nmcli -t -f NAME con show --active | grep -qvx "lo"; then
	connected=true
fi

print_status() {
	echo "{\"powered\":${powered},\"connected\":${connected}}"
}

print_status
nmcli -c no monitor | while read -r line; do
	status=$(echo "$line" | grep "Connectivity is now" | awk -F"'" '{print $2}')
	case "$status" in
		none)
			connected=false
			;;
		limited)
			connected=true
			# internet=false
			;;
		full)
			connected=true
			# internet=true
			;;
	esac

	if [ "${status// }" ]; then
		print_status
		continue
	fi

	status=$(echo "$line" | grep "Networkmanager is now in the" | awk -F"'" '{print $2}')
	case "$status" in
		connected)
			powered=true
			;;
		disconnected)
			powered=false
			;;
	esac

	if [ "${status// }" ]; then
		print_status
		continue
	fi
done
