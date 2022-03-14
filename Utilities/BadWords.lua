-- Word Buster BadWords file (v1.0)
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

local BadWords = {}

local open = io.open
local time = os.clock
local lines = io.lines

local words = {}
local function StringToTable(str)
    local t = {}
    for i = 1, str:len() do
        t[#t + 1] = str:sub(i, i)
    end
    return t
end

local function RemoveEmptyFilters()
    for k, v in pairs(words) do
        if (k and v[1] == "" or v[1] == " ") then
            words[k] = nil
        end
    end
end

function BadWords:Load()

    self.client:info('Loading languages...')

    local count, start = 0, time()
    local dir = self.settings.lang_directory
    local languages = self.settings.languages

    for lang, load in pairs(languages) do
        if (load) then
            local path = dir .. lang .. ".txt"
            local file = open(path, "r")
            if (file) then
                file:close()
                count = count + 1
                for line in lines(path) do
                    local regex = ""
                    local t = StringToTable(line)
                    for _, char in pairs(t) do
                        local chars = self.settings.patterns[char]
                        if (chars) then
                            for i = 1, #chars do
                                if (chars[i]) then
                                    regex = regex .. chars[i]
                                end
                            end
                        else
                            regex = regex .. "."
                        end
                    end
                    words[#words + 1] = { regex, line, lang }
                end
            end
        end
    end

    if (#words > 0) then
        RemoveEmptyFilters(self)
        local total_time = time() - start
        self.client:info("Successfully loaded " .. count .. " languages:")
        self.client:info(#words .. " words loaded in " .. total_time .. " seconds")
        self.settings.words = words
    else
        self.client:info("No words were loaded")
    end
end

return BadWords