print_uptime() {
    echo "$1" | xargs printf "%.2f"
    echo "$2"
}

uptime=$(awk '{print int($1)}' /proc/uptime)
if [ "$uptime" -lt 60 ]; then
	print_uptime "$uptime" "s"
    exit 0
fi

uptime=$(echo "scale=2; $uptime / 60" | bc)
if (( $(echo "$uptime < 60" | bc -l) )); then
    print_uptime "$uptime" "m"
    exit 0
fi

uptime=$(echo "scale=2; $uptime / 60" | bc)
if (( $(echo "$uptime < 24" | bc -l) )); then
    print_uptime "$uptime" "h"
    exit 0
fi

uptime=$(echo "scale=2; $uptime / 24" | bc)
print_uptime "$uptime" "d"

