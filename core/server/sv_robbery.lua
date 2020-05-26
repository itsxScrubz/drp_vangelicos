---------------------------
-- Locals --
---------------------------
-- //©_Scrubz#0001_© ^_^// --
local onCooldown = false

---------------------------
-- Threads --
---------------------------
-- //Police Counter Thread// --
-- Is broken until jobcore is fixed. Might just need to do database query for each player to check job.
-- That might be too heavy tho.
--[[function policeCounter()
    local copsConnected = 0
    local players = exports['drp_core']:GetPlayers()
    for i =1, #players, 1 do
        local plyJob = exports['drp_jobcore']:GetPlayerJob(players[i])
        if plyJob.jobLabel == "POLICE" then
            copsConnected = copsConnected + 1
        end
    end
    TriggerClientEvent('drp_vangelicos_cl:policeCheck', -1, copsConnected)
    SetTimeout(10000, policeCounter)
end
policeCounter()]]

-- //Robbery Cooldown Thread// --
function startCooldown()
    local cooldownTimer = Config.CooldownTimer
    while onCooldown do
        if cooldownTimer <= 0 then
            onCooldown = false
        end
        cooldownTimer = cooldownTimer - 1
        Citizen.Wait(1000)
    end
    TriggerClientEvent('drp_vangelicos_cl:setStatus', -1, false)
end

---------------------------
-- Event Handlers --
---------------------------
-- //Job Check Callback// --
DRP.NetCallbacks.Register('drp_vangelicos_sv:checkJob', function(data, send)
    local src = source
    local plyJob = nil
    local plyData = exports["drp_id"]:GetCharacterData(src)
    local results = exports["externalsql"]:AsyncQuery({
        query = "SELECT * FROM `characters` WHERE `id` = :char_id",
        data = {char_id = plyData.charid}
    })
    if #results["data"] >= 1 then
        local data = results["data"]
        for k, v in pairs(data) do
            plyJob = v.job
        end
    end
    send(plyJob)
end)

-- //Starting The Robbery// --
RegisterServerEvent('drp_vangelicos_sv:startRobbery')
AddEventHandler('drp_vangelicos_sv:startRobbery', function(disabled)
    if disabled then
        local fuckyou = math.random(1, 10)
        if fuckyou >= 4 then
            -- Alert Police
            if Config.UseChatAlert then
                TriggerClientEvent('drp_vangelicos_cl:chatAlert', -1)
            elseif Config.UseCustomAlert then
                -- Insert your custom alert stuff here
            end
        end
        onCooldown = true
        TriggerClientEvent('drp_vangelicos_cl:setStatus', -1, true)
        startCooldown()
    else
        if Config.UseChatAlert then
            TriggerClientEvent('drp_vangelicos_cl:chatAlert', -1)
        elseif Config.UseCustomAlert then
            -- Insert your custom alert stuff here
        end
        onCooldown = true
        TriggerClientEvent('drp_vangelicos_cl:setStatus', -1, true)
        startCooldown()
    end
end)

-- //Gib Loots// --
RegisterServerEvent('drp_vangelicos_sv:gibLoot')
AddEventHandler('drp_vangelicos_sv:gibLoot', function(id)
    local src = source
    local plyData = exports["drp_id"]:GetCharacterData(src)
    local canHasLoot = math.random()
    -- Valuable Goods
    if Config.EnableDefaultLoot then
        exports['drp_inventory']:AddItem(plyData.charid, Config.DefaultLoots, Config.DefaultAmount)
    end
    -- Good Loot
    if Config.EnableGoodLoot then
        if Config.EnableBestLoot then
            local lootChance = math.random()
            if lootChance <= Config.BestLootChance then
                for k, v in pairs(Config.GibBestestLoot) do
                    if math.random() <= v.chance then
                        exports['drp_inventory']:AddItem(plyData.charid, v.item, v.amount)
                        break
                    end
                end
            else
                local itemCount = 0
                for k, v in pairs(Config.GibGoodLoot) do
                    if math.random() <= v.chance then
                        if itemCount ~= Config.GibGoodLootAmount then
                            itemCount = itemCount + 1
                            exports['drp_inventory']:AddItem(plyData.charid, v.item, v.amount)
                        end
                    end
                end
            end
        else
            local itemCount = 0
            for k, v in pairs(Config.GibGoodLoot) do
                if math.random() <= v.chance then
                    if itemCount ~= Config.GibGoodLootAmount then
                        itemCount = itemCount + 1
                        exports['drp_inventory']:AddItem(plyData.charid, v.item, v.amount)
                    end
                end
            end
        end
    end
    TriggerClientEvent('drp_vangelicos_cl:gibLoot', -1, id)
end)

-- //Silent Alarm Toggle// --
RegisterServerEvent('drp_vangelicos_sv:toggleAlarm')
AddEventHandler('drp_vangelicos_sv:toggleAlarm', function()
    TriggerClientEvent('drp_vangelicos_cl:alarmToggle', -1)
end)
