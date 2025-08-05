--[[

	all-in-one wrapper for psx
	made by soma
	
]]--

local wrapper = {}

local library = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))


function wrapper:get_value(...)
	local keys = {...}
	local current = library

	for _, key in ipairs(keys) do
		current = rawget(current, key)
		
		if current == nil then 
			break 
		end
	end

	return current 
end

-- wait for game to fully load
function wrapper.ensure_load()
	
end


return wrapper