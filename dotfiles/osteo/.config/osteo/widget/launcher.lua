local astal = require("astal")
local lib = require("lib")

local Astal = astal.require("Astal")
local App = require("astal.gtk3.app")

local Apps = astal.require("AstalApps")
local Gdk = require("astal.gtk3").Gdk
local Widget = require("astal.gtk3.widget")

local Variable = astal.Variable
local Anchor = Astal.WindowAnchor

local MAX_RESULTS = 6

local function LauncherEntry(entry)
	return Widget.Button({
		class_name = "launcherEntry",
		on_clicked = function()
			entry:launch()
		end,

		Widget.Box({
			class_name = "launcherEntry",
			spacing = 6,

			Widget.Icon({
				icon = entry.icon_name,
			}),
			Widget.Box({
				valign = "CENTER",
				vertical = true,

				Widget.Label({
					wrap = true,
					xalign = 0,
					label = entry.name,
				}),
			}),
		}),
	})
end

return function(idx, monitor)
	local search = Variable("")

	local apps = Apps.Apps()
	local results = search(function(value)
		local matches = apps:fuzzy_query(value)
		return lib.slice(matches, 1, MAX_RESULTS)
	end)

	return Widget.Window({
		name = "launcher " .. idx,
		application = App,
		gdkmonitor = monitor,
		class_name = "launcherWindow",
		anchor = Anchor.TOP + Anchor.BOTTOM + Anchor.LEFT + Anchor.RIGHT,
		exclusivity = "IGNORE",
		keymode = "ON_DEMAND",

		on_show = function()
			search:set("")
		end,

		on_key_press_event = function(self, event)
			if event.keyval == Gdk.KEY_Escape then
				self:hide()
			end
		end,

		Widget.Box({
			class_name = "launcherRoot",
			-- hexpand = true,
			-- vexpand = true,
			valign = "CENTER",
			halign = "CENTER",
			vertical = true,

			Widget.Entry({
				placeholder_text = "Search",
				text = search(),
				on_changed = function(self)
					search:set(self.text)
				end,
				on_activate = function()
					local selected = results:get()[1]
					if selected then
						selected:launch()
					end
				end,
			}),

			Widget.Box({
				spacing = 4,
				vertical = true,

				results:as(function(r)
					return lib.map(r, LauncherEntry)
				end),
			}),

			-- Widget.Box({
			-- 	halign = "CENTER",
			-- 	class_name = "not-found",
			-- 	vertical = true,
			-- 	visible = results:as(function(r)
			-- 		return #r == 0
			-- 	end),
			--
			-- 	Widget.Icon({ icon = "system-search-symbolic" }),
			-- 	Widget.Label({ label = "No matches" }),
			-- }),
		}),
	})
end
