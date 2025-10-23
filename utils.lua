local json = json
local Config = Config


-- Discord webhook
function SendWebhookEmbed(webhookUrl, title, description, color, mention)
local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")

local embed = {
title = title,
description = description,
color = color,
footer = { text = Config.systemName, icon_url = Config.footerIcon },
timestamp = timestamp,
fields = {}
}

if mention then
        table.insert(embed.fields, {
            name = "User [Discord]:",
            value = "<@" .. tostring(mention) .. ">",
            inline = true
        })
end

local payload = {
embeds = { embed }
}

PerformHttpRequest(webhookUrl, function(status, text, headers)
if status ~= 204 and status ~= 200 and status ~= 201 then
print("[NameVerify] Failed to send webhook to " .. webhookUrl .. " (status: " .. tostring(status) .. ")")
end
end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end


function GetGuildMember(guildId, userId, botToken, callback)
local url = string.format('https://discord.com/api/v10/guilds/%s/members/%s', guildId, userId)
local headers = { ['Authorization'] = 'Bot ' .. botToken, ['Content-Type'] = 'application/json' }

PerformHttpRequest(url, function(status, text, resHeaders)
if status == 200 then
local ok, data = pcall(json.decode, text)
if ok and data then
callback(200, data)
else
callback(status, nil)
end
else
callback(status, nil)
end
end, 'GET', '', headers)
end