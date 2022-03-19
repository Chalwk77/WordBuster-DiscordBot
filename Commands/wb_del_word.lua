-- Word Buster Delete Word command file (v1.0)
-- Copyright (c) 2022, Jericho Crosby <jericho.crosby227@gmail.com>

local Command = {
    name = '>wb_del_word',
    description = 'Delete a word from lang file',
    permission_node = 'administrator',
    help = 'Syntax: /$cmd (word) (lang)',
}

local lines = io.lines
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

            local words = {}
            local success = pcall(function()
                for line in lines(dir .. lang) do
                    if (line ~= word) then
                        words[#words + 1] = line
                    end
                end
            end)

            if (not success) then
                member:send('Error. File not found.')
            else
                self.write(dir .. lang, table.concat(words, '\n'))
                member:send('Deleting "' .. word .. '" from ' .. lang)
            end
        end
    end
end

return Command