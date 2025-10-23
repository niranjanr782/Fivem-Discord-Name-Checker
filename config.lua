Config = {}
Config.verifyGuildId = ""-- Verification guild
Config.botToken = ""
-- Logging webhooks
Config.acceptLogWebhook = ""
Config.rejectLogWebhook = ""
-- Settings
Config.allowCaseInsensitive = false -- true to compare names case-insensitively
Config.preferNickname = true -- true to prefer guild nickname over username
Config.requireRoleWhitelist = false -- true to enable role whitelist check
Config.roleWhitelist = { } -- role IDs allowed when requireRoleWhitelist is true
-- API responses Timeout
Config.requestTimeout = 5000
-- Logs
Config.systemName = "ZFX - Name Verification"
Config.footerIcon = ""


return Config