-- Word Buster Grace file (v1.0)
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

local Grace = { }

local time = os.time
local diff = os.difftime
local floor = math.floor

function Grace:Check()

    for id, v in pairs(self.infractions) do
        if (id) then
            local reference = time { day = v.last_infraction.day, month = v.last_infraction.month, year = v.last_infraction.year }
            local days_from = diff(time(), reference) / (24 * 60 * 60)
            if (floor(days_from) >= self.settings.grace_period) then
                self.infractions[id] = nil
                self.write(self.infractions)
            end
        end
    end

    self.timer.setTimeout(1000, function()
        Grace:Check()
    end)
end

return Grace