local astal = require("astal")
local lib = require("lib")

local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local bind = astal.bind
local Mpris = astal.require("AstalMpris")
local mpris = Mpris.get_default()

local unknownLabel = "---"
local stateIndices = { ["STOPPED"] = 1, ["PAUSED"] = 2, ["PLAYING"] = 3 }
local stateIcons = { "media-playback-stop", "media-playback-pause", "media-playback-start" }

local function segment()
	return bind(mpris, "players"):as(function(players)
		local playerStates = lib.map(players, function(p)
			return bind(p, "playback-status")
		end)

		local globalState = Variable.derive(playerStates, function(...)
			local globalStateIdx = 0
			local states = { ... }

			for _, state in ipairs(states) do
				local stateIdx = stateIndices[state] or 0
				globalStateIdx = math.max(globalStateIdx, stateIdx)
			end

			return globalStateIdx
		end)

		return Widget.Icon({
			visible = bind(globalState):as(function(s)
				return s > 0 and stateIcons[s] ~= nil
			end),
			icon = bind(globalState):as(function(s)
				return stateIcons[s]
			end),
		})
	end)
end

local function format_duration(seconds)
	local hrs = math.floor(seconds / 3600)
	local mins = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60

	if hrs > 0 then
		return string.format("%d:%02d:%02d", hrs, mins, secs)
	else
		return string.format("%d:%02d", mins, secs)
	end
end

local function PlayerControls(player)
	local release = Variable.derive({
		bind(player, "artist"),
		bind(player, "album"),
	}, function(artist, album)
		return {
			artist = artist,
			album = album,
		}
	end)

	local position = Variable.derive({
		bind(player, "position"),
		bind(player, "length"),
	}, function(position, length)
		return {
			pos = position or 0,
			len = length or 0,
		}
	end)

	local seekStep = 8
	local canSeek = bind(player, "length"):as(function(length)
		return length ~= nil and length > 0
	end)

	return Widget.Box({
		vertical = true,

		Widget.EventBox({
			on_click = function()
				player:raise()
			end,

			Widget.Box({
				vertical = true,

				-- Widget.Box({
				-- 	css = bind(player, "cover-art"):as(function(url)
				-- 		return string.format("background-image: url('%s');", url)
				-- 	end),
				-- }),
				Widget.Label({
					label = bind(player, "title"):as(function(title)
						return title or unknownLabel
					end),
				}),
				Widget.Label({
					label = bind(release):as(function(r)
						local label = r.artist or unknownLabel
						if r.album and r.album ~= "" then
							label = label .. " • " .. r.album
						end

						return label
					end),
				}),
			}),
		}),
		Widget.Box({
			visible = bind(player, "can-control"),
			homogeneous = true,

			Widget.Button({
				visible = bind(player, "can-go-previous"),
				on_clicked = function()
					player:previous()
				end,

				Widget.Icon({
					icon = "media-skip-backward-symbolic",
				}),
			}),
			Widget.Button({
				visible = canSeek,
				on_clicked = function()
					player.position = player.position - seekStep
				end,

				Widget.Icon({
					icon = "media-seek-backward",
				}),
			}),
			Widget.Button({
				on_clicked = function()
					player:play_pause()
				end,

				Widget.Icon({
					icon = bind(player, "playback-status"):as(function(status)
						if status == "PLAYING" then
							return "media-playback-pause-symbolic"
						else
							return "media-playback-start-symbolic"
						end
					end),
				}),
			}),
			Widget.Button({
				visible = canSeek,
				on_clicked = function()
					player.position = player.position + seekStep
				end,

				Widget.Icon({
					icon = "media-seek-forward",
				}),
			}),
			Widget.Button({
				visible = bind(player, "can-go-next"),
				on_clicked = function()
					player:next()
				end,

				Widget.Icon({
					icon = "media-skip-forward-symbolic",
				}),
			}),
		}),
		Widget.Slider({
			visible = canSeek,
			value = bind(position):as(function(p)
				return p.len > 0 and p.pos / p.len or 0
			end),
			on_dragged = function(event)
				player.position = event.value * player.length
			end,
		}),
		Widget.CenterBox({
			Widget.Label({
				halign = "START",
				label = bind(position):as(function(p)
					return format_duration(p.pos)
				end),
			}),
			Widget.Box({}),
			Widget.Label({
				halign = "END",
				label = bind(position):as(function(p)
					local remaining = format_duration(p.len - p.pos)
					local duration = format_duration(p.len)

					return remaining .. "/" .. duration
				end),
			}),
		}),
	})
end

local function menu()
	return Widget.Box({
		vertical = true,

		bind(mpris, "players"):as(function(players)
			return lib.map(players, PlayerControls)
		end),
	})
end

return {
	segment = segment,
	menu = menu,
}
