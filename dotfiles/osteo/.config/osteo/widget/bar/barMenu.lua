local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local seg = require("widget.bar.segments")

local Astal = astal.require("Astal")
local Anchor = Astal.WindowAnchor

return function(idx, gdkmonitor)
	local menu = seg.createMenu(idx)

	return Widget.Window({
		name = "barMenu " .. idx,
		gdkmonitor = gdkmonitor,
		anchor = Anchor.TOP + Anchor.BOTTOM + Anchor.LEFT + Anchor.RIGHT,
		exclusivity = "IGNORE",
		-- layer = "ASTAL_LAYER_OVERLAY",
		class_name = "window",
		["margin-left"] = 56,

		menu(),
	})
end
