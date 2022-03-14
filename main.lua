-- Word Buster Entry point file (v1.0)
-- Copyright (c) 2022, Jericho Crosby <jericho.crosby227@gmail.com>

--[[
    This file is part of Word Buster.

    Word Buster is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Word Buster is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Word Buster. If not, see <http://www.gnu.org/licenses/>.
]]

local Discordia = require('discordia')
local Discord = Discordia.Client()

local json = require('discordia/libs/utils/Json.lua')

local timer = require('timer')
local settings = require('settings')
settings.words = { }

local Grace = require('Utilities.Grace')
local BadWords = require('Utilities.BadWords')
local MessageHandler = require('Events.MessageHandler')

local open = io.open
local function WriteToFile(t)
    local file = open('infractions.json', 'w')
    if (file) then
        file:write(json:encode_pretty(t))
        file:close()
    end
end

local function LoadInfractions()

    local content = ''
    local file = open('infractions.json', 'r')
    if (file) then
        content = file:read('*all')
        file:close()
    end

    local data = json:decode(content)
    if (not data) then
        WriteToFile({})
    end
    data = data or {}

    return data
end

Discord:on('ready', function()

    local server = Discord:getGuild(settings.discord_server_id)
    if (server) then

        local mt = {
            timer = timer,
            client = Discord,
            write = WriteToFile,
            settings = settings,
            infractions = LoadInfractions()
        }
        mt = { __index = mt }

        setmetatable(Grace, mt)
        setmetatable(BadWords, mt)
        setmetatable(MessageHandler, mt)

        BadWords:Load()
        Grace:Check()
        Discord:info('Ready: ' .. Discord.user.tag)
    end
end)

Discord:on('messageCreate', function(msg)
    if (msg.author and not msg.author.bot) then
        MessageHandler:OnSend(msg)
    end
end)

Discord:run('Bot ' .. settings.token())
Discord:setGame('Blocking profanity since 2022')