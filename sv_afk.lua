
-- This Event allows you to check if the person bypass the afk kick
RegisterServerEvent('bk_afk:check')
AddEventHandler('bk_afk:check', function()
    local _source = source
    local steamid
    for k,v in pairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        end
    end

    print(table.contains(Config.Bypass, steamid))

    if steamid then 
        if table.contains(Config.Bypass, steamid) == true then
            TriggerClientEvent('bk_afk:return', _source, true)
        else
            TriggerClientEvent('bk_afk:return', _source, false)
        end
    else
        TriggerClientEvent('bk_afk:return', _source, false)   
    end 
end)

-- This event allows to kick the player at the end of the timer
RegisterNetEvent('bk_afk:kick')
AddEventHandler('bk_afk:kick', function()
    local _source = source
    DropPlayer(_source, Locale.kickMessage)
end)

function table.contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
  end