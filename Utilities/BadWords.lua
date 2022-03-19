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

local time = os.clock
local lines = io.lines

function BadWords:Load()

    local words = {}
    self.client:info('Loading languages...')

    local count, start = 0, time()
    local dir = self.settings.lang_directory
    local languages = self.settings.languages

    for lang, load in pairs(languages) do
        if (load) then
            count = count + 1
            local success = pcall(function()
                for line in lines(dir .. lang) do
                    local regex  = self:GetRegex(line)
                    words[#words + 1] = {
                        regex = regex,
                        language = lang,
                        word = line
                    }
                end
            end)
            if (not success) then
                self.client:warning('Warning: ' .. lang .. ' NOT FOUND in ' .. dir)
            end
        end
    end

    if (#words > 0) then
        local total_time = time() - start
        self.client:info('Successfully loaded ' .. count .. ' languages:')
        self.client:info(#words .. ' words loaded in ' .. total_time .. ' seconds')
        self.settings.words = words
    else
        self.client:warning('No words were loaded')
    end
end

function BadWords:GetRegex(line)
    local t = self.stringToTable(line)
    local patterns = self.settings.patterns
    local regex = {}
    for _, char in pairs(t) do
        local chars = patterns[char]
        if (chars) then
            for id, pattern in pairs(chars) do
                if (not regex[id]) then
                    regex[id] = pattern
                else
                    regex[id] = regex[id] .. pattern
                end
            end
        end
    end
    return regex
end

return BadWords