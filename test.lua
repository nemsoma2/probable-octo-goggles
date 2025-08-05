-- we making a bank w this one

-- TODO: make sure to add sanity checks here


--local wrapper = loadstring(game:HttpGet("https://raw.githubusercontent.com/nemsoma2/probable-octo-goggles/refs/heads/main/wrapper.lua"))()

local psx_library = require(game.ReplicatedStorage:WaitForChild('Framework'):WaitForChild('Library'))
if (psx_library) then
	print("psx library found")
end

local get_my_banks = psx_library.Network.Invoke("get my banks")
if (get_my_banks) then
	print("get_my_banks found")
end

for i,v in pairs(psx_library.Save.Get().Pets) do
	local pet_info = psx_library.Directory.Pets[v.id];
	for x,y in pairs(pet_info) do
		print(x,y);
	end
end

