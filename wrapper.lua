--[[

	all-in-one wrapper for psx
	made by soma
	
]]--
local wrapper = {}

-- grab the games library
local library = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))

-- store og network functions
local fire_network = getupvalue(getupvalue(getrawmetatable(library.Network).__index, 1).Fire, 2)
local invoke_network = getupvalue(getupvalue(getrawmetatable(library.Network).__index, 1).Invoke, 2)

-- wrapper for firing remote events
function wrapper.fire(event_name, ...)
	local event = fire_network(event_name)
    event:FireServer(...)
end

-- wrapper for invoking remote events
function wrapper.invoke(function_name, ...)
	local func = invoke_network(function_name)
    return func:InvokeServer(...)
end

-- retrive data from library
function wrapper.get_value(...)
    local current = library
    for _, key in ipairs({...}) do
        current = rawget(current, key)
		
        if not current then 
			return nil
		end
    end
    return current
end

-- wait for game to fully load
function wrapper.ensure_load()
	while true do
        local loading = get_value("Variables", "LoadingWorld") == false
        local map = workspace:FindFirstChild("__MAP")
        local spawns = map and map:FindFirstChild("PlayerSpawns")
        
        if loading and map and spawns then
            return true
        end
        task.wait()
    end
end


return wrapper