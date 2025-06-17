local App = require("astal.gtk3.app")
local widgets = require("widgets")
local lib = require("lib")

App:start({
	instance_name = "astal",
	css = lib.src("styles.css"),
	request_handler = function(msg, res)
		print(msg)
		res("ok")
	end,
	main = function()
		for idx, monitor in pairs(App.monitors) do
			widgets.createWidgets(idx, monitor)
		end

		-- App.on_monitor_added = createWidgets
		-- App.on_monitor_removed = destroyWidgets
	end,
})
