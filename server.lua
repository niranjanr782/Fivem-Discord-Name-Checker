local Config = Config

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
local src = source
deferrals.defer()
deferrals.update('Verifying Discord identity...')

-- extract discord id
local discordId = nil
for _, id in ipairs(GetPlayerIdentifiers(src)) do
if string.find(id, 'discord:') then
discordId = id:gsub('discord:', '')
break
end
end

if not discordId then
deferrals.done('Discord not linked to your FiveM account. Please open Discord and try again.')
SendWebhookEmbed(Config.rejectLogWebhook, 'Rejected — No Discord', 'Player attempted to join without a linked Discord account: ' .. tostring(playerName), 16711680, nil)
return
end

deferrals.update('Checking membership in verification server...')

GetGuildMember(Config.verifyGuildId, discordId, Config.botToken, function(status, data)
if status == 200 and data and data.user then
local discordDisplay = ''
if Config.preferNickname and data.nick and data.nick ~= '' then
discordDisplay = data.nick
else
discordDisplay = data.user.username or ''
end

-- role whitelist check
if Config.requireRoleWhitelist and (#Config.roleWhitelist > 0) then
local hasRole = false
if data.roles then
for _, roleId in ipairs(data.roles) do
for _, allowed in ipairs(Config.roleWhitelist) do
if tostring(roleId) == tostring(allowed) then
hasRole = true
break
end
end
if hasRole then break end
end
end
if not hasRole then
deferrals.done('You do not have the required Discord role to join this server.')
SendWebhookEmbed(Config.rejectLogWebhook, 'Rejected — Missing Role', 'Player ' .. tostring(playerName) .. ' (<' .. discordId .. '>) is missing required role(s).', 16711680, discordId)
return
end
end

-- compare names
local fivemName = playerName or GetPlayerName(src)
local match = false
if Config.allowCaseInsensitive then
match = string.lower(tostring(discordDisplay)) == string.lower(tostring(fivemName))
else
match = tostring(discordDisplay) == tostring(fivemName)
end

if match then
deferrals.done()
SendWebhookEmbed(Config.acceptLogWebhook, 'Allowed — Name Match', 'Player ' .. tostring(fivemName) .. ' matched Discord name: ' .. tostring(discordDisplay), 65280, discordId)
else
deferrals.done('Your Discord display name must match your FiveM name. Expected: "' .. tostring(discordDisplay) .. '"')
SendWebhookEmbed(Config.rejectLogWebhook, 'Rejected — Name Mismatch', 'Player ' .. tostring(fivemName) .. ' did not match Discord name: ' .. tostring(discordDisplay), 16711680, discordId)
end

elseif status == 404 then
deferrals.done('Your Discord account is not a member of the verification server. Join it and retry.')
SendWebhookEmbed(Config.rejectLogWebhook, 'Rejected — Not Member', 'Player ' .. tostring(playerName) .. ' (<' .. discordId .. '>) is not a member of the verification guild.', 16711680, discordId)
else
deferrals.done('Could not verify your Discord account (error ' .. tostring(status) .. '). Try again later.')
SendWebhookEmbed(Config.rejectLogWebhook, 'Verification Error', 'Failed to verify ' .. tostring(playerName) .. ' (status ' .. tostring(status) .. ').', 16711680, discordId)
end
end)
end)