local dlg = Dialog { title = 'Discord Rich Presence Setting' }
DIALOG_WIDTH = Rectangle(64, 64, 272, 360)
CONFIGFILE = 'C:\\Users\\Admin\\AppData\\Roaming\\Aseprite\\scripts\\discord-rpc-aseprite\\config.txt'
-- String to boolean converter, this will transfer value from config file to boolean
STRTOBOOL = {
    ['true'] = true,
    ['false'] = false,
}

-- This function use to fetching data from config file
local f = io.open(CONFIGFILE, 'r')
if f then
    -- Split argurment
    local function split(str, sep, plain)
        if plain then sep = string.gsub(sep, magic, '%%%1') end
        
        local N = '\255'
        str = N .. str .. N
        str = string.gsub(str, sep, N .. N)

        local result = {}
        for word in string.gmatch(str, N..'(.-)'..N) do
            if word ~= '' then
                table.insert(result, word)
            end
        end
        return result
    end
    
    -- Reading file's datas
    local line = tostring(f:read('a'))
    -- Split to table ( array )
    ARR = split(line, ';')
    f:close()
else
    app.alert('Lua Error: Cannot access file')
end

-- Default Values
local defaults = {
    applicationID = 1159493928706375831,
    detailsIdle = ARR[1],
    details = ARR[2],
    state = ARR[3],
    stateIdle = ARR[4],
    largeImageTextIdle = ARR[5],
    smallImageTextIdle = ARR[6],
    largeImageText = ARR[7],
    smallImageText = ARR[8],
    removeDetail = ARR[9],
    removeState = ARR[10],
    removeTimeStamp = ARR[11]
}

-- Input set
dlg:separator{ --
    id = 'divider0',
    text = 'Information'
}:entry { -- Details Idle
    id = 'detailsIdle',
    label = 'Idle Details: ',
    text = defaults.detailsIdle
}:entry { -- Details
    id = 'details',
    label = 'Details: ',
    text = defaults.details
}:entry { -- State Idle
    id = 'stateIdle',
    label = 'Idle State: ',
    text = defaults.stateIdle
}:entry { -- State
    id = 'state',
    label = 'State: ',
    text = defaults.state
}:entry { -- Large image text Idle
    id = 'largeImageTextIdle',
    label = 'Idle Large Img Text: ',
    text = defaults.largeImageTextIdle
}:entry { -- Small image text Idle
    id = 'smallImageTextIdle',
    label = 'Idle Small Img Text: ',
    text = defaults.smallImageTextIdle
}:entry { -- Large image text
    id = 'largeImageText',
    label = 'Large Image Text: ',
    text = defaults.largeImageText
}:entry { -- Small image text
    id = 'smallImageText',
    label = 'Small Image Text: ',
    text = defaults.smallImageText
}

-- Remove detail, state, timestamp section
dlg:check {
    id = 'removeDetail',
    label = 'Remove Details:',
    text = 'remove it',
    selected = STRTOBOOL[defaults.removeDetail]
}:check {
    id = 'removeState',
    label = 'Remove State:',
    text = 'remove it',
    selected = STRTOBOOL[defaults.removeState]
}:check {
    id = 'removeTimeStamp',
    label = 'Remove Timestamp:',
    text = 'remove it',
    selected = STRTOBOOL[defaults.removeTimeStamp]
}

-- Lets go
dlg:button {
    id = 'start',
    text = 'START',
    onclick = function()
        -- fetch pkg file
        local file = io.open('C:\\Users\\Admin\\AppData\\Roaming\\Aseprite\\scripts\\discord-rpc-aseprite\\node_modules\\.package-lock.json')
        -- check lmao
        if file ~= nil then
            os.execute('start C:\\Users\\Admin\\AppData\\Roaming\\Aseprite\\scripts\\start.bat')
            app.alert('rpc is starting!')
        end

        if file == nil then
            app.alert({
                title = 'Please install all packages first!',
                text = 'If you have installed all pkgs but receive this message, please click install again'
            })
        end
    end
}:button {
    id = 'install',
    text = 'INSTALL',
    focus = false,
    onclick = function ()
        os.execute('start C:\\Users\\Admin\\AppData\\Roaming\\Aseprite\\scripts\\installlib.bat')
        os.execute('start C:\\Users\\Admin\\AppData\\Roaming\\Aseprite\\scripts\\installtool.bat')
    end
}:separator()
:button { -- Save changes button
    id = 'save',
    text = 'SAVE',
    focus = false,
    onclick = function()
        -- Read dialog's data
        local data = dlg.data
        -- confirmation announcement
        local confirmation = app.alert({
            title = 'Confirm saving changes',
            text = 'The current datas will be lost, do you want to continue?',
            buttons = { 'Yes', 'No' }
        })
        -- if "Yes"
        if confirmation == 1 then
            -- fetch file's position
            local f = io.open(CONFIGFILE, 'w+')
            -- saving datas
            if f then
                -- Saving data
                f:write(data.detailsIdle .. ';'
                .. data.details .. ';'
                .. data.state .. ';'
                .. data.stateIdle .. ';'
                .. data.largeImageTextIdle .. ';'
                .. data.smallImageTextIdle .. ';'
                .. data.largeImageText .. ';'
                .. data.smallImageText .. ';'
                .. tostring(data.removeDetail) .. ';'
                .. tostring(data.removeState) .. ';'
                .. tostring(data.removeTimeStamp))
                f:close()
            else
                app.alert('Lua Error: Cannot access file')
            end
            -- Just for fun lol
            app.alert('Saved!')
        end
    end
}:button { -- Reset the config
    id = 'default',
    text = 'RESET',
    focus = false,
    onclick = function()
        -- confirmation announcement
        local confirmation = app.alert({
            title = 'Confirm reset',
            text = 'The current datas will be lost, do you want to continue?',
            buttons = { 'Yes', 'No' }
        })
        -- if "Yes"
        if confirmation == 1 then
            -- fetch file's position
            local f = io.open(CONFIGFILE, 'w+')
            if f then
                -- Saving data
                f:write('Idling;Editing: {file_name};Type: file {file_type};relaxing ...;Idling;i need sleeping;Editing {file_type} file;Aseprite;false;false;false')
                f:close()
            else
                app.alert('Lua Error: Cannot access file')
            end
            app.alert { title = 'Config set to default!', text = 'please reopen this dialog if nothing changed' }
        end
    end
}:button { -- Its sleep time
    id = 'cancel',
    text = 'CANCEL',
    onclick = function()
        dlg:close()
    end
}

dlg:separator {
    id = 'divider2',
    text = 'Note'
}

dlg:label { -- fuck you dialog's length
    id = 'note',
    label = 'Below are some var that will',
    text = 'be replaced with file\'s info'
}:label {
    id = 'note0',
    label = '{empty} - this will be',
    text = 'replaced with an empty space'
}:label {
    id = 'note1',
    label = '{file_name} - this will be',
    text = 'replaced with the file\'s name'
}:label {
    id = 'note2',
    label = '{file_type} - this will be',
    text = 'replaced with the file\'s format'
}

-- Config and Dialog's box size
dlg:show { wait = false, bounds = DIALOG_WIDTH }