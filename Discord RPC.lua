local dlg = Dialog { title = 'Discord Rich Presence Setting' }

-- applicationID: 1159493928706375831

-- This function use to fetching data from config file
local f = io.open('C:\\Users\\Admin\\AppData\\Roaming\\Aseprite\\scripts\\discord-rpc-aseprite\\config.txt', 'r')
if f then
    -- Split argurment
    local function split(str, sep, plain)
        if plain then sep = string.gsub(sep, magic, '%%%1') end
        
        local N = '\255'
        str = N..str..N
        str = string.gsub(str, sep, N..N)

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

dlg:entry {
    id = 'detailsIdle',
    label = 'Idle Details: ',
    text = defaults.detailsIdle
}

dlg:entry {
    id = 'details',
    label = 'Details: ',
    text = defaults.details
}

dlg:entry {
    id = 'stateIdle',
    label = 'Idle State: ',
    text = defaults.stateIdle
}

dlg:entry {
    id = 'state',
    label = 'State: ',
    text = defaults.state
}

dlg:entry {
    id = 'largeImageTextIdle',
    label = 'Idle Large Img Text: ',
    text = defaults.largeImageTextIdle
}

dlg:entry {
    id = 'smallImageTextIdle',
    label = 'Idle Small Img Text: ',
    text = defaults.smallImageTextIdle
}

dlg:entry {
    id = 'largeImageText',
    label = 'Large Image Text: ',
    text = defaults.largeImageText
}

dlg:entry {
    id = 'smallImageText',
    label = 'Small Image Text: ',
    text = defaults.smallImageText
}

-- String to boolean converter, this will transfer value from config file to boolean
STRTOBOOL = {
    ['true'] = true,
    ['false'] = false,
}

-- Remove detail section
dlg:check{
    id = 'removeDetail',
    label = 'Remove Details:',
    text = 'remove it',
    selected = STRTOBOOL[defaults.removeDetail]
}

-- Remove state section
dlg:check{
    id = 'removeState',
    label = 'Remove State:',
    text = 'remove it',
    selected = STRTOBOOL[defaults.removeState]
}

-- Remove timetstamp ( counter )
dlg:check{
    id = 'removeTimeStamp',
    label = 'Remove Timestamp:',
    text = 'remove it',
    selected = STRTOBOOL[defaults.removeTimeStamp]
}

-- Save changes
dlg:button{
    id = 'save',
    text = 'SAVE',
    focus = false,
    onclick = function()
        -- Read dialog's data
        local data = dlg.data
        -- fetch file's position
        local f = io.open('C:\\Users\\Admin\\AppData\\Roaming\\Aseprite\\scripts\\discord-rpc-aseprite\\config.txt', 'w+')
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
}

-- Its sleep time
dlg:button {
    id = 'cancel',
    text = 'CANCEL',
    onclick = function()
        dlg:close()
    end
}

-- Config and Dialog's box size
dlg:show { wait = false, bounds = Rectangle(64, 64, 240, 340) }

