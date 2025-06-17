local astal = require("astal")
local lib = require("lib")
local Widget = require("astal.gtk3.widget")

local bind = astal.bind

local WirePlumber = astal.require("AstalWp").get_default()

local function segment()
	local speaker = WirePlumber.audio.default_speaker

	return Widget.Icon({
		icon = bind(speaker, "volume-icon"),
	})
end

local function OutputControls(speaker)
	return Widget.Box({
		-- Widget.Icon({
		-- 	icon = bind(speakerdevice, "icon"),
		-- }),
		Widget.Label({
			label = "hello?",
		}),
	})
end

local function menu()
	return Widget.Box({
		lib.map(WirePlumber.audio.speakers, OutputControls),
	})
end

return {
	segment = segment,
	menu = menu,
}
