-- i3 workspaces display on keyboard --


require "declarations"
require "utilities"
require "debug"
jsond = require "lunajson"

color_map = {}
workspaces =  {7, 13, 19, 25, 30, 34, 50, 55, 61, 67}


-- colors (set to your preferences)
white = rgba_to_color(232, 230, 227, 255)
dviol = rgba_to_color(189, 147, 249, 255)
dpink = rgba_to_color(255, 121, 198, 255)
dred  = rgba_to_color(255, 85,  85,  255)


function on_key_down(index)
	if index == 11 then
		-- when super is pressed

		color_map[11] = rgba_to_color(255, 0, 0, 255)
		
		for i = 0, canvas_size do color_map[i] = 0x00000000 end

		-- map
		
		local handle = io.popen("wks 2>&1")
		local result = handle:read("*a")
		handle:close()

		result = jsond.decode(result)
		
		for i, workspace in ipairs(result) do
			local color = dpink
			if workspace["output"] == "DP-2" then color = dviol end
			if workspace["focused"] == true then color = dred end

			color_map[tonumber(workspaces[workspace["num"]])] = color
		end
		submit_color_map(color_map)
	end
end


function on_key_up(index)
	if index == 11 then
		on_startup(nil)
	end
end


function on_apply_parameter(parameter, value)
	local update_fn = load("" .. parameter .. " = " .. value)

	update_fn()

	-- update state
	on_startup(nil)
end