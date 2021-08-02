

local currentPosition  = nil
local lastPosition = nil
local currentHeading   = nil
local lastHeading  = nil
local timer = 0
local msec = 1000
local bypass = false

-- This event is used to activate the afk kick system
AddEventHandler("onClientMapStart", function()
	if not connection then return end
    TriggerServerEvent('bk_afk:check')
end)

AddEventHandler("onResourceStart", function(r)
    if r ~= GetCurrentResourceName() then return end
    TriggerServerEvent('bk_afk:check')
end)

AddEventHandler('playerSpawning', function()
    TriggerServerEvent('bk_afk:check')
end)

-- This event allows to know if the person bypass the afk kick system (client side)
RegisterNetEvent('bk_afk:return')
AddEventHandler('bk_afk:return', function(bool)
    if bool then 
        bypass = true 
    else
        bypass = false 
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(msec)

        if bypass == false then
            local playerPed = PlayerPedId(-1)

            if playerPed then 
                
                currentPosition = GetEntityCoords(playerPed, true)
                currentHeading = GetEntityHeading(playerPed)

                if currentPosition == lastPosition and currentHeading == lastHeading then 

                    if timer > 0 then 

                        if timer == math.ceil(Config.Time / 5) then

                            Notification(string.format(Locale.alertMessage, math.ceil(Config.Time / 5)))

                        end 

                        if timer == math.ceil(Config.Time / 2) then

                            Notification(string.format(Locale.alertMessage, math.ceil(Config.Time / 2)))

                        end 

                        timer = timer - 1

                    else

                        TriggerServerEvent('bk_afk:kick') 

                    end
                else

                    timer = Config.Time

                end

                lastPosition = currentPosition
                lastHeading  = currentHeading
            end
        else
            msec = 60000*24
        end
    end
end)

function Notification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(0, 1)
end 