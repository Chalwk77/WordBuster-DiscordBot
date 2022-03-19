-- Word Buster List Langs command file (v1.0)
-- Copyright (c) 2022, Jericho Crosby <jericho.crosby227@gmail.com>

local Command = {
    name = '>wb_langs',
    description = 'Show list of langs',
    permission_node = 'administrator',
    help = 'Syntax: /$cmd',
}

function Command:Run(msg)

    msg:delete()

    local member = msg.member
    if (self.permission(member, msg, self.permission_node)) then
        local output = '**Available Languages:**\n'
        for Lang, Enabled in pairs(self.settings.languages) do
            if (Enabled) then
                output = output .. Lang .. ' `[Enabled]`\n'
            else
                output = output .. Lang .. ' [Disabled]\n'
            end
        end
        member:send(output)
    end
end

return Command