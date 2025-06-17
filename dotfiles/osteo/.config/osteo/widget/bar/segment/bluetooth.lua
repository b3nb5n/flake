local Widget = require("astal.gtk3.widget")

local function segment()
	return Widget.Icon({
		icon = "bluetooth-disabled",
	})
end

return {
	segment = segment,
}
