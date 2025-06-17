local Widget = require("astal.gtk3.widget")

local hostname_
local function hostname()
	if hostname_ then
		return hostname_
	end

	local file = io.open("/proc/sys/kernel/hostname", "rb")
	if file then
		hostname_ = file:read("*a")
		file:close()
	else
		hostname_ = "unknown"
	end

	return hostname_
end

local username_
local function username()
	if username_ then
		return username_
	end

	username_ = os.getenv("USER")
	username_ = username_ or "unknown"

	return username_
end

local function segment()
	return Widget.Icon({
		icon = "nix-snowflake-white",
	})
end

local function menu()
	return Widget.Box({
		orientation = "VERTICAL",

		Widget.Label({
			label = username() .. "@" .. hostname(),
		}),
		Widget.Box({
			Widget.Button({
				Widget.Icon({
					icon = "system-logout",
				}),
			}),
			Widget.Button({
				Widget.Icon({
					icon = "system-reboot",
				}),
			}),
			Widget.Button({
				Widget.Icon({
					icon = "system-shutdown",
				}),
			}),
		}),
	})
end

return {
	segment = segment,
	menu = menu,
}
