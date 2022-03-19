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

local settings = require('settings')
settings.words = {}

local open = io.open
local timer = require('timer')
local json = require('discordia/libs/utils/Json.lua')

local function WriteFile(Dir, Content, JSON)
    local file = open(Dir, 'w')
    if (file) then
        file:write(JSON and json:encode_pretty(Content) or Content)
        file:close()
    end
end

local function ReadFile(dir)
    local content = ''
    local file = open(dir, 'r')
    if (file) then
        content = file:read('*all')
        file:close()
    end
    return content
end

local function LoadInfractions()
    local dir = settings.infractions_directory
    local content = ReadFile(dir)
    local data = json:decode(content)
    if (not data) then
        WriteFile(dir, {}, true)
    end
    return data or {}
end

local function StringToTable(str)
    local t = {}
    for i = 1, str:len() do
        t[#t + 1] = str:sub(i, i)
    end
    return t
end

local function StrSplit(str)
    local t = { }
    for arg in str:gmatch("([^%s]+)") do
        t[#t + 1] = arg:lower()
    end
    return t
end

local cmds, files = {}, {}
local required_files = {
    ['./Utilities.'] = { 'BadWords', 'Grace' },
    ['./Events.'] = { 'OnMessage' },
}

local function LoadCommands(mt)
    local path = './Commands/'
    for file, enabled in pairs(settings.commands) do
        if (enabled) then
            local command = require(path .. file)
            local cmd = command.name
            cmds[cmd] = command
            cmds[cmd].help = command.help:gsub('$cmd', cmd)
            cmds[cmd].ReloadLangs = files['BadWords']
            setmetatable(cmds[cmd], mt)
        end
    end
end

local function LoadFiles(mt)
    for path, t in pairs(required_files) do
        for _, file in pairs(t) do
            files[file] = setmetatable(require(path .. file), mt)
        end
    end
end

local function HasPermission(member, msg, node)
    if (not member:hasPermission(node)) then
        msg:delete()
        member:send {
            embed = {
                title = 'Perms Error',
                description = 'You need "' .. node .. '" perm to use this command.',
                color = 0x000000
            }
        }
        return false
    end
    return true
end

local mt = {
    timer = timer,
    read = ReadFile,
    client = Discord,
    write = WriteFile,
    settings = settings,
    permission = HasPermission,
    stringToTable = StringToTable,
    infractions = LoadInfractions()
}
mt = { __index = mt }

Discord:on('ready', function()

    local server = Discord:getGuild(settings.discord_server_id)
    if (server) then

        LoadFiles(mt)
        LoadCommands(mt)

        files['BadWords']:Load()
        files['Grace']:Check()
        Discord:info('Ready: ' .. Discord.user.tag)
    end
end)

Discord:on('messageCreate', function(msg)
    if (msg.author and not msg.author.bot) then
        local args = StrSplit(msg.content)
        return (cmds[args[1]] and cmds[args[1]]:Run(msg, args)) or files['OnMessage']:Send(msg)
    end
end)

Discord:run('Bot ' .. settings.token())
Discord:setGame('Blocking profanity since 2022')