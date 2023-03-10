ESX = nil
TriggerEvent(Config['GetObject'], function(obj)
    ESX = obj
end)

local playerOnlineTime = 0
local canGetReward = false
local CreateMarker = {}

-- daily reward

-- 	ผู้เล่นเข้ามาสามารถกด E 			*เลือกจุดได้ markker ปรับขนาดได้ สีได้
-- 	ผู้เล่นไม่สามารถรับซ่ำได้ 			*มีแจ้งเตือน
-- 	มีนับเวลา ออนไลได้ของ 
-- 	config เวลาออนไลได้
-- 	config ให้ได้เเค่ไอเทม

-- RegiterKeyMapping
RegisterKeyMapping(GetCurrentResourceName() .. "GetDailyRward", 'Get Daily Reward', 'KEYBOARD', Config['ปุ่ม'])
RegisterCommand(GetCurrentResourceName() .. "GetDailyRward", function()
    local ped = GetPlayerPed(-1)
    local coord = GetEntityCoords(ped)
    local distance = #(coord - Config['จุดรับของ']['ตำแหน่ง'])
    if distance <= 5 and canGetReward then
        TriggerServerEvent(GetCurrentResourceName() .. ":Reward")
    else
        -- Notify
    end
end, false)

-- Online Time
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    repeat
        Wait(60 * 1000)
        playerOnlineTime = playerOnlineTime + 1

        if playerOnlineTime >= Config['เวลาออนไลน์'] then
            -- Config.ClientNotify()
            canGetReward = true
        end

    until playerOnlineTime >= Config['เวลาออนไลน์']
end)

-- Marker
Citizen.CreateThread(function()
    CreateBlip()
    local PlayerCoords
    while true do
        Citizen.Wait(5)
        PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
        local distance = #(PlayerCoords - Config['จุดรับของ']['ตำแหน่ง'])
        if distance < 50 then
            DrawMarker(Config['จุดรับของ']['Marker'].Id,
                Config['จุดรับของ']['ตำแหน่ง'],
                Config['จุดรับของ']['ตำแหน่ง'],
                Config['จุดรับของ']['ตำแหน่ง'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                Config['จุดรับของ']['Marker'].Size,
                Config['จุดรับของ']['Marker'].Size,
                Config['จุดรับของ']['Marker'].Size,
                Config['จุดรับของ']['Marker'][1], Config['จุดรับของ']['Marker'][2],
                Config['จุดรับของ']['Marker'][3], Config['จุดรับของ']['Marker'][4],
                false, false, 0, false, false, false, false)
        else
            Citizen.Wait(10000)
        end
    end
end)

-- Blip
function CreateBlip()
    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(Config['จุดรับของ']['ตำแหน่ง'])
        SetBlipSprite(blip, Config['จุดรับของ']['Blip'].Id)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(Blip, true)
        SetBlipScale(blip, Config['จุดรับของ']['Blip'].Size)
        SetBlipColour(blip, Config['จุดรับของ']['Blip'].Color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config['จุดรับของ']['Blip'].Name)
        EndTextCommandSetBlipName(blip)
    end)
end
