
FiveM Anti-Noclip for ESX
---------------------------------
A lightweight anti-noclip script for FiveM servers using the ESX framework.
This script prevents players from using noclip cheats by detecting and blocking unauthorized movements.

Features:
- Noclip Detection: Identifies when players attempt to use noclip cheats.
- Automatic Kicking: Kicks players caught using noclip.
- Webhook Notifications: Sends a notification to a Discord webhook when a player is kicked.

Installation:
1. Clone the Repository:
   git clone https://github.com/fel-5m/fel_antinoclip.git

2. Add to server.cfg:
   start fel_antinoclip

3. Configure:
   Edit the configuration file to set up script settings and webhook URL.

Example Webhook Notification:
Here’s an example of what the Discord webhook notification looks like when a player is kicked:

![Webhook Notification Example](https://media.discordapp.net/attachments/892921942301098064/1277151802042880061/Y5WLNvn.jpg?ex=66ce1a0d&is=66ccc88d&hm=b952787d2dd41985d787327250ed226d29cfd8a139aaea32a0207ad69bc2bdb1&=&format=webp)



License:
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
