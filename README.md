🧩 Discord Two-Server Name Verification

A lightweight **FiveM resource** that ensures player identity consistency by verifying each player’s **FiveM in-game name** against their **Discord display name** in a designated **verification server**.
If the names don’t match, the player is rejected and a detailed log is sent to your **Discord logging server**

🚀 Features

* 🔍 **Two-Server Verification** — Checks player identity between a verification guild and a logging guild.
* 🧠 **Name Matching System** — Ensures the FiveM in-game name matches the Discord display name or nickname.
* ⚙️ **Configurable Rules** — Options for case-insensitive checks, nickname preference, and role-based whitelisting.
* 🧾 **Discord Webhook Logging** — Sends professional embeds for accepted and rejected verifications.
* 🔒 **Secure & Lightweight** — Minimal performance impact with clear logging and Discord API integration.
* 🧰 **Easy Integration** — Plug-and-play setup for any FiveM ESX or standalone server.

🧱 How It Works

1. When a player connects, their FiveM name and Discord ID are fetched.
2. The script queries the verification Discord guild to find the user.
3. If their **Discord display name** matches their **FiveM name**, verification passes.
4. If not, the player is rejected, and a rejection log is sent to the logging Discord server.
5. All logs are posted through clean, color-coded **Discord webhook embeds** for easy monitoring.

⚙️ Setup

1. Place the resource folder in your `resources` directory.
2. Add the following line to your `server.cfg`:

   ```bash
   ensure Fivem-Namecheck
   ```
3. Invite your verification bot to the Discord guild and enable **Server Members Intent**.
4. Ensure your bot has the `View Members` permission in the verification guild.

🧩 Customization Options

* **allowCaseInsensitive** — Compare names ignoring case differences.
* **preferNickname** — Use the user’s nickname instead of their global username if available.
* **requireRoleWhitelist** — Allow only specific roles to pass verification (e.g., whitelisted members).

📋 Troubleshooting

| Issue                        | Possible Fix                                                                            |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| ❌ *"Member not found (404)"* | Check if the bot is in the correct verification guild and has the right permissions.    |
| 🚫 *Webhook not sending*     | Verify webhook URLs and that the target channel allows the bot to post messages.        |
| ⚠️ *Discord ID not detected* | Ensure players open Discord before launching FiveM, and `DiscordIdentifier` is enabled. |

📜 License

This project is licensed under the **MIT License** — allowing you to freely modify, use, and distribute the resource, with proper credit.

💬 Credits

Developed by **ZENIX-RHEOX**
Made for the FiveM community — focused on reliability, security, and server identity integrity.<3
