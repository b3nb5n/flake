local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local layout = require("widget.bar.layout")

local segmentConstructors = {}
local menuConstructors = {}

local groupAlignMap = { "START", "CENTER", "END" }
local menuAlignMap = {}

for groupIdx, group in ipairs(layout) do
	for _, name in ipairs(group) do
		local module = require("widget.bar.segment." .. name)
		segmentConstructors[name] = module.segment
		menuConstructors[name] = module.menu
		menuAlignMap[name] = groupAlignMap[groupIdx]
	end
end

local menuVariables = {}
local windows = require("windows")

local function openMenu(idx, name)
	local menu = menuVariables[idx]
	if menu == nil then
		print("missing menu variable " .. idx)
		return
	end

	local window = windows.barMenus[idx]
	if window == nil then
		print("missing bar menu window " .. idx)
		return
	end

	menu:set(name)
	window:show()
end

local function closeMenu(idx)
	local menu = menuVariables[idx]
	if menu == nil then
		print("missing menu variable " .. idx)
		return
	end

	local window = windows.barMenus[idx]
	if window == nil then
		print("missing bar menu window " .. idx)
		return
	end

	menu:set(nil)
	window:hide()
end

local function wrapSegmentConstructor(idx, name)
	local segment = segmentConstructors[name]

	return function(args)
		return Widget.EventBox({
			on_hover = function()
				if menuConstructors[name] then
					openMenu(idx, name)
				end
			end,

			Widget.Box({
				class_name = "barSegment",

				segment(args),
			}),
		})
	end
end

local function createSegments(idx)
	local wrappedSegments = {}
	for name, _ in pairs(segmentConstructors) do
		wrappedSegments[name] = wrapSegmentConstructor(idx, name)
	end

	return wrappedSegments
end

local function createMenu(idx)
	local menu = menuVariables[idx]
	if menu == nil then
		menu = astal.Variable(nil)
		menuVariables[idx] = menu
	end

	return function()
		return Widget.Box({
			class_name = "barRoot barMenuLayout",
			hexpand = true,
			vexpand = true,
			orientation = "HORIZONTAL",

			astal.bind(menu):as(function(name)
				if name == nil then
					return nil
				end

				local constructor = menuConstructors[name]
				if constructor == nil then
					print("missing menu constructor for " .. name)
					return
				end

				local align = menuAlignMap[name]
				if align == nil then
					print("missing menu alignment for " .. name)
					return
				end

				return Widget.Box({
					orientation = "VERTICAL",

					Widget.EventBox({
						visible = align ~= "START",
						vexpand = align ~= "START",
						on_hover = function()
							closeMenu(idx)
						end,
					}),
					Widget.Box({
						class_name = "barBg barMenu",
						halign = "START",
						valign = align,

						constructor(),
					}),
					Widget.EventBox({
						visible = align ~= "END",
						vexpand = align ~= "END",
						on_hover = function()
							closeMenu(idx)
						end,
					}),
				})
			end),

			Widget.EventBox({
				vexpand = true,
				hexpand = true,

				on_hover = function()
					closeMenu(idx)
				end,
			}),
		})
	end
end

return {
	createSegments = createSegments,
	createMenu = createMenu,
}
