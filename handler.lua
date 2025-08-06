if _G.ConsoleWebhookActive then return end
_G.ConsoleWebhookActive = true

local webhookUrl = "https://discord.com/api/webhooks/1402739813643321545/YnLmb017hGDOB3HD3nyhp4QVLec6BLs5Robg_FfzX5BIuKR1XA5wjfwhyXZi64Us1xn5"  -- Replace this!

local function sendToDiscord(message)
    request({
        Url = webhookUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({
            content = "```\n" .. message .. "\n```"  -- Wrapped in code blocks
        })
    })
end

-- Send session start time (UTC ISO 8601)
sendToDiscord("# session " .. os.date("!%Y-%m-%dT%H:%M:%SZ"))

local consoleTypes = {
    ["info"] = "[ℹ️ info]",
    ["warn"] = "[⚠️ warn]",
    ["error"] = "[❌ error]"
}

debug.setconsoleoutput(function(type, message)
    local prefix = consoleTypes[type:lower()] or "[❓ unknown]"
    sendToDiscord(prefix .. " " .. tostring(message))  -- Already wrapped via sendToDiscord
end)

-- Test messages
print("Logger activated!")
warn("Test warning")
error("Test error")