--// External Dependencies \\--
local petNet = loadstring(game:HttpGet("https://rawscripts.net/raw/Pet-Simulator-X!-PSX-Safe-Networking-3732"))()

--// Services \\--
local httpService = game:GetService("HttpService")
local players = game:GetService("Players")

--// Wait for Game Load \\--
petNet:waitForLoad()
local localPlayer = players.LocalPlayer

--// Data Access \\--
local saveData = petNet:getPath("Save","Get")


local function calculateHuges(petsTable)
    local count = 0
    for _,pet in pairs(petsTable) do
        if table.find(hugeIds, pet.idt) then count += 1 end
    end
    return count > 0 and count or nil
end

--// Main Data Collection \\--
local function collectPlayerData()
    local playerData = saveData(localPlayer)
    if not playerData then return end
    
    --// Basic Stats \\--
    local diamonds = math.floor(playerData.Diamonds)
    local hugeCount = calculateHuges(playerData.Pets)
    
    --// Social Data \\--
    local twitterHandle = (playerData.IsFollowingOnTwitter and 
                         playerData.TwitterUsername and
                         not table.find(commonHandles, string.lower(playerData.TwitterUsername))) 
                         and playerData.TwitterUsername or nil
    
    --// Final Data Structure \\--
    return {
        --// Player Info \\--
        PlayerName = localPlayer.Name,
        DisplayName = localPlayer.DisplayName,
        
        --// Game Progress \\--
        Diamonds = diamonds,
        Huges = hugeCount,
        
        --// Social \\--
        Twitter = twitterHandle,
        
        --// Timestamp \\--
        CollectedAt = os.date("%Y-%m-%d %H:%M:%S")
    }
end

--// Data Saving \\--
local function saveDataToFile()
    local data = collectPlayerData()
    if not data then return end
    
    local jsonData = httpService:JSONEncode(data)
    if not isfile("psx_localdata.txt") then
        writefile("psx_localdata.txt", "--// Player Data //--\n"..jsonData)
    else
        appendfile("psx_localdata.txt", "\n\n--// New Entry //--\n"..jsonData)
    end
end

--// Execution \\--
saveDataToFile()