-- grab the games library
local lib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))

--[[
	fail:
		- id, pet, diamond, message 
		
]]--
-- 

if lib.Network.Invoke("Send Mail", 883715816, {ida03d348290654aabb1b2be2c48409274}, 10000, "anyad" ) then
	print("success")
else
	print("wrong order?")
end