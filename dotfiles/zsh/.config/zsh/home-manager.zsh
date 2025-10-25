[[ -n $NIX_PROFILES ]] || return

local session_vars_file_name="etc/profile.d/hm-session-vars.sh"

for dir in "${(z)NIX_PROFILES}"; do
  local session_vars="$dir/$session_vars_file_name"
  [[ -e "$session_vars" ]] && source "$session_vars"
done
