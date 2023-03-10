ESX = nil
TriggerEvent(Config['GetObject'], function(obj)
ESX = obj
end)

-- MySQL Update Day Reward
function mySqlUpdateAndCheck()
local xPlayer = ESX.GetPlayerFromId(source)
local playerId = xPlayer.identifier
local today = os.date("%Y-%m-%d")
local result = MySQL.Sync.fetchAll("SELECT * FROM reward_history WHERE player_id = @playerId AND date = @today", {
    ['@playerId'] = playerId,
    ['@today'] = today
})

if result[1] ~= nil then
    return false -- player already received reward today
else
    MySQL.Async.execute("INSERT INTO reward_history (player_id, date) VALUES (@playerId, @today)", {
        ['@playerId'] = playerId,
        ['@today'] = today
    })
    return true
end
end

-- Reward
RegisterNetEvent(GetCurrentResourceName() .. "Reward")
AddEventHandler(GetCurrentResourceName() .. "Reward", function()
if GetInvokingResource() ~= GetCurrentResourceName() then
return
end

local xPlayer = ESX.GetPlayerFromId(source)
if mySqlUpdateAndCheck() then
    for i, v in ipairs(Config['ไอเทม']) do
        local count = CalCount(v.count)
        xPlayer.addInventoryItem(v.name, count)
        Log(xPlayer.getName() .. "ได้รับ " .. v.name .. " จำนวน " .. count .. " ชิ้น")
    end
else
    -- Notify player that they already received the reward today
    TriggerClientEvent('chat:addMessage', source, { args = { "^1Error:", "You have already received the reward today." } })
end

end)

function CalCount(n)
if type(n) == 'table' then
return math.random(n[1],n[2])
else
return n
end
end

-- Log
function Log(msg)
local messageEmbed = {
{
["color"] = tonumber("0x" .. "00FF00"), -- Green color
["title"] = "Code-Redeem",
["description"] = msg,
}
}
PerformHttpRequest(Config['Log'], function(err, text, headers) end, "POST", json.encode({embeds = messageEmbed}), { ["Content-Type"] = "application/json" })
end