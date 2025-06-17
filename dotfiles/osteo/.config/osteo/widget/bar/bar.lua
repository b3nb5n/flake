local astal = require("astal")
local seg = require("widget.bar.segments")
local layout = require("widget.bar.layout")
local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")

local Astal = astal.require("Astal")
local Anchor = Astal.WindowAnchor
local alignMap = { "START", "CENTER", "END" }

return function(idx, gdkmonitor)
	local constructors = seg.createSegments(idx)
	local segmentGroups = {}

	for groupIdx, group in ipairs(layout) do
		local segments = {}
		for segmentIdx, name in ipairs(group) do
			local constructor = constructors[name]
			if constructor == nil then
				print("missing segment constructor " .. name)
				goto continue
			end

			segments[segmentIdx] = constructor()
			::continue::
		end

		segments.class_name = "barGroup barBg"
		segments.orientation = "VERTICAL"
		segments.valign = alignMap[groupIdx]
		segments.halign = "CENTER"
		segments.spacing = 8

		segmentGroups[groupIdx] = Widget.Box(segments)
	end

	segmentGroups.class_name = "barRoot barLayout"
	segmentGroups.orientation = "VERTICAL"

	return Widget.Window({
		name = "bar " .. idx,
		application = App,
		gdkmonitor = gdkmonitor,
		anchor = Anchor.TOP + Anchor.BOTTOM + Anchor.LEFT,
		exclusivity = "EXCLUSIVE",
		class_name = "window",

		Widget.CenterBox(segmentGroups),
	})
end
