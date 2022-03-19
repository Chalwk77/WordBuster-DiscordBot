# Word-Buster-Discord-Bot (v1.0)

**Description:**<br/>
An advanced profanity filter Discord Bot framework built using the Discordia API and Luvit runtime environment

## **[ FEATURES ]**
* Pattern matching algorithm to detect variations of words, like "**asshole**", "**a$$hole**", "**assH0l3**" or "**a55h01e.**
* Block bad words.
* Kick, Ban or Timeout a user
* Supports multiple languages
* Warning System + Grace Period
* Customizable messages

**COMMANDS:**
Command | Description
------------ | -------------
/wb_add_word `(word)` `(lang)`|Add a word to lang file
/wb_del_word `(word)` `(lang)`|Delete a word from lang file
/wb_disable_lang `(lang)`|Disable lang file
/wb_enable_lang `(lang)`|Enable lang file
/wb_langs|Show list of langs

## **[ SUPPORTED LANGUAGES]**
Chinese, Czech, Danish, Dutch, English, Esperanto
French, German, Hungry, Italian, Japanese
Korean, Norwegian, Polish, Portuguese, Russian
Spanish, Swedish, Thai, Turkish, Vietnamese

**Download at bottom of page**
___

# Installation:

Prerequisites:
**Setup requires that you have Administrative or _Manage Server_ permissions on the Discord server.**

A quick note for Linux users:
You will be required to install the **Luvit Runtime Environment**. Follow [these instructions](https://luvit.io/install.html) to learn how.

-----

1. Register an application on the [Discord Developer Portal](https://Discordapp.com/developers/applications/) and obtain a **bot token**.
A Discord bot token is a short phrase (represented as a jumble of letters and numbers) that acts as a key to controlling a Discord Bot.

2. Put your bot token inside the *./Word-Buster-Discord-Bot/Auth.data* file and **never** share your Discord bot token with anyone.

There are many tutorials online to help you learn how to create a Discord Application, however, as a general guide, follow these steps:

1. Click **New Application**
- Provide a name for your bot and click create.
- Click the **Bot** tab then click the blue *Add Bot* button (click "*yes, do it!*", when prompted).
- Copy your token and paste it into the aforementioned Auth.data file located inside the Discord Bot folder.

2. Now click the OAuth2 tab and check the BOT scope.
Under bot permissions -> text permissions, check the following:
- View Channels
- Kick members
- Ban Members
- Send Messages
- Add Reactions
- Use External Emojis
- Use External Stickers
- Read Message History
- Mute Members

Copy and paste the URL that gets generated into a web browser and hit enter.

3. You will be prompted to add the bot to a Discord server, select one, click continue and authorize.

**You have now successfully added the Discord Application to your Discord server.**

____

### **IMPORTANT**

**Further configuration is required.**<br/>
This bot is NOT plug-and-play. See *Word-Buster-Discord-Bot/settings.lua* for full configuration.

**Launching the Discord Bot**<br/>
Open Command Prompt/Terminal and CD into the Discord Bot folder. Type *luvit main*.

If you need help installing on Linux (or Windows, for that matter), DM me on Discord:<br/>
_Chalwk#9284_

____
