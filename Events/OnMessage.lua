-- Word Buster Message Handler file (v1.0)
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

local Message = {
    kick = function(member, settings)
        member:send(settings.on_punish:gsub('$punishment', 'kicked'))
        member:kick()
    end,
    ban = function(member, settings)
        member:send(settings.on_punish:gsub('$punishment', 'banned'))
        member:ban()
    end,
    timeout = function(member, settings)
        member:send(settings.on_punish:gsub('$punishment', 'timed out'))
        member:timeoutFor(settings.timeout_duration * 60)
    end
}

function Message:FormatNotify(name, word, pattern, lang)
    local msg = self.settings.notify_console_format
    if (self.settings.notify_console) then
        msg = msg              :gsub('$name', name):
        gsub('$word', word)    :
        gsub('$regex', pattern):
        gsub('$lang', lang)
        self.client:warning(msg)
    end
end

function Message:Send(msg)

    local words = self.settings.words
    local id = msg.member.id
    local member = msg.member
    local message = msg.content
    local name = msg.member.name
    local word = message:lower():gsub('(.*)', ' %1 ')

    for i = 1, #words do

        local regex = words[i].regex
        local lang = words[i].language

        for j = 1, #regex do
            if (word:find('[^%a]' .. regex[j] .. '[^%a]')) then

                msg:delete()

                self:FormatNotify(name, words[i].word, regex[j], lang)
                self:NewInfraction(id, msg.member.name)

                if (self.infractions[id].warnings == self.settings.warnings) then
                    member:send(self.settings.last_warning)
                elseif (self.infractions[id].warnings > self.settings.warnings) then
                    if (self.settings.punishment == 'kick') then
                        self:kick(member, self.settings)
                    elseif (self.settings.punishment == 'ban') then
                        self:ban(member, self.settings)
                    elseif (self.settings.punishment == 'timeout') then
                        self:timeout(member, self.settings)
                    end
                    self.infractions[id] = nil
                else
                    member:send(self.settings.notify_text)
                end
                self.write(self.settings.infractions_directory, self.infractions, true)
                goto done
            end
        end
    end
    :: done ::
end

local date = os.date
function Message:NewInfraction(id, name)

    local day = date('*t').day
    local month = date('*t').month
    local year = date('*t').year

    self.infractions[id] = self.infractions[id] or { warnings = 0 }
    self.infractions[id].last_infraction = { day = day, month = month, year = year }
    self.infractions[id].warnings = self.infractions[id].warnings + 1
    self.infractions[id].name = name
end

return Message