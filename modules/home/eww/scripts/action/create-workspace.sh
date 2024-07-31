current_ids=$(hyprctl workspaces -j | jq -r '.[].id')

for id in {1..9}; do
    if ! echo "$current_ids" | grep -q -w "$id"; then
        hyprctl dispatch workspace "$id"
        exit 0
    fi
done

exit 1
