-- Word Buster Settings file (v1.0)
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

return {

    --------------------------------------

    -- DISCORD SERVER ID --
    -- Paste your Discord server ID (NOT NAME):
    -- 1). Right click the Discord server icon and click "Copy ID".
    -- 2). Replace "xxxxxxxxxxxxxxxxxx" below with the id you copied.
    discord_server_id = 'xxxxxxxxxxxxxxxxxx',


    -- Infraction Count:
    -- How many infractions before a user is punished
    -- Default: 5
    warnings = 5,


    -- Grace Period:
    -- Infractions reset after this many days of no profanity.
    -- Default: 1
    grace_period = 1,


    -- Notify Text:
    -- Warn user when they use profanity (if not last warning).
    notify_text = 'Please do not use profanity.',


    -- Notify Warning Text:
    last_warning = 'Last warning. You will be punished if you continue to use profanity.',


    -- Punishment:
    -- Valid punishments: 'kick', 'timeout' or 'ban'
    punishment = 'timeout',


    -- Notify Punish Text:
    on_punish = 'You were $punishment for profanity',


    -- Timeout:
    -- Maximum timeout (in minutes) that a user will be timed out:
    timeout_duration = 60,


    -- Ban Time:
    -- Maximum time (in days) that a user will be banned
    ban_duration = 1,


    -- Language Directory.
    -- Folder path to language files database:
    lang_directory = './langs/',


    -- Languages:
    -- Which languages should be loaded?
    languages = {
        ['cs'] = false, -- Czech
        ['da'] = false, -- Danish
        ['de'] = false, -- German
        ['en'] = true, -- English
        ['eo'] = false, -- Esperanto
        ['es'] = false, -- Spanish
        ['fr'] = false, -- French
        ['hu'] = false, -- Hungry
        ['it'] = false, -- Italy
        ['ja'] = false, -- Japan
        ['ko'] = false, -- Korea
        ['nl'] = false, -- Dutch
        ['no'] = false, -- Norway
        ['pl'] = false, -- Poland
        ['pt'] = false, -- Portuguese
        ['ru'] = false, -- Russia
        ['sv'] = false, -- Swedish
        ['th'] = false, -- Thai
        ['tr'] = false, -- Turkish
        ['zh'] = false, -- Chinese
        ['tlh'] = false -- Vietnamese
    },

    -- Patterns:
    -- Advanced users only, patterns used to block variations of bad words.

    patterns = {
        ['a'] = { '[aA@]' },
        ['b'] = { '[bB]' },
        ['c'] = { '[cCkK]' },
        ['d'] = { '[dD]' },
        ['e'] = { '[eE3]' },
        ['f'] = { '[fF]' },
        ['g'] = { '[gG6]' },
        ['h'] = { '[hH]' },
        ['i'] = { '[iIl!1]' },
        ['j'] = { '[jJ]' },
        ['k'] = { '[cCkK]' },
        ['l'] = { '[lL1!i]' },
        ['m'] = { '[mM]' },
        ['n'] = { '[nN]' },
        ['o'] = { '[oO0]' },
        ['p'] = { '[pP]' },
        ['q'] = { '[qQ9]' },
        ['r'] = { '[rR]' },
        ['s'] = { '[sS$5]' },
        ['t'] = { '[tT7]' },
        ['u'] = { '[uUvV]' },
        ['v'] = { '[vVuU]' },
        ['w'] = { '[wW]' },
        ['x'] = { '[xX]' },
        ['y'] = { '[yY]' },
        ['z'] = { '[zZ2]' }
    },

    -- do not touch --
    token = function()
        local token = ''
        local file = io.open('./Auth.data')
        if (file) then
            token = file:read()
            file:close()
        end
        return token
    end
}