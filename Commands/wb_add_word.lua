-- Word Buster Add Word command file (v1.0)
-- Copyright (c) 2022, Jericho Crosby <jericho.crosby227@gmail.com>

local Command = {
    name = '>wb_add_word',
    description = 'Add a word to lang file',
    permission_node = 'administrator',
    help = 'Syntax: /$cmd (word) (lang)',
}

function Command:Run(msg, args)

    msg:delete()

    local member = msg.member
    if (self.permission(member, msg, self.permission_node)) then

        local word = args[2]
        local lang = args[3]
        local dir = self.settings.lang_directory
        local file = self.settings.languages[lang]

        if (not word) then
            member:send('No word defined.')
            member:send(self.help)
        elseif (not lang) then
            member:send('Invalid lang file.')
            member:send(self.help)
        elseif (file == nil) then
            member:send('Lang file not found.')
        elseif (file == false) then
            member:send('Sorry, that lang file is disabled.')
        else

            local content = self.read(dir .. lang)
            if (content) then
                content = content .. '\n' .. word
            else
                member:send('Error. File not found.')
                return false
            end

            self.write(dir .. lang, content)
            member:send('Adding "' .. word .. '" to ' .. lang)
        end
    end
end

return Command