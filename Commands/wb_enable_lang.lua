-- Word Buster Enable Lang command file (v1.0)
-- Copyright (c) 2022, Jericho Crosby <jericho.crosby227@gmail.com>

local Command = {
    name = '>wb_enable_lang',
    description = 'Enable lang file',
    permission_node = 'administrator',
    help = 'Syntax: /$cmd',
}

function Command:Run(msg, args)

    msg:delete()

    local member = msg.member
    if (self.permission(member, msg, self.permission_node)) then

        local lang = args[2]
        local file = self.settings.languages[lang]

        if (file == nil) then
            member:send('Lang file not found.')
        elseif (not lang) then
            member:send('Invalid lang file.')
            member:send(self.help)
        elseif (file == true) then
            member:send(lang .. ' is already enabled')
        else
            member:send('Enabling ' .. lang .. ', please wait...')
            self.settings.languages[lang] = true
            self.ReloadLangs:Load()
        end
    end
end

return Command