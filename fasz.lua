
local lib = require(game.ReplicatedStorage:WaitForChild('Framework'):WaitForChild('Library'))
local mybanks = lib.Network.Invoke("Get My Banks")
for k,v in pairs(mybanks) do
    print(k.." = "..v)
end