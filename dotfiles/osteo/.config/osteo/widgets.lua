local windows = require("windows")

local Bar = require("widget.bar.bar")
local BarMenu = require("widget.bar.barMenu")
local Launcher = require("widget.launcher")

local function createWidgets(idx, monitor)
	windows.bars[idx] = Bar(idx, monitor)
	windows.barMenus[idx] = BarMenu(idx, monitor)
	windows.launchers[idx] = Launcher(idx, monitor)

	windows.barMenus[idx]:hide()
	windows.launchers[idx]:hide()
end

local function destroyWidgets(idx, monitor)
	for _, map in pairs(windows) do
		local widget = map[idx]

		if widget then
			widget:destroy()
			map[idx] = nil
		end
	end
end

return {
	createWidgets = createWidgets,
	destroyWidgets = destroyWidgets,
}
