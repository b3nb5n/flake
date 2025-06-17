local astal = require("astal")
local gtk3 = require("astal.gtk3")
local Widget = require("astal.gtk3.widget")

local GLib = astal.require("GLib")
local Variable = astal.Variable
local bind = astal.bind
local Calendar = gtk3.astalify(gtk3.Gtk.Calendar)

local time = Variable(nil):poll(1000, function()
	return GLib.DateTime.new_now_local()
end)

local function segment()
	return Widget.Label({
		label = bind(time):as(function(t)
			if t then
				return t:format("%I\n%M")
			end
		end),
	})
end

local function menu()
	return Widget.Box({
		orientation = "VERTICAL",

		Widget.Label({
			label = bind(time):as(function(t)
				if t then
					return t:format("%I:%M:%S")
				end
			end),
		}),
		Widget.Label({
			label = bind(time):as(function(t)
				if t then
					return t:format("%A, %B %d, %Y")
				end
			end),
		}),
		Calendar(),
	})
end

return {
	segment = segment,
	menu = menu,
}
