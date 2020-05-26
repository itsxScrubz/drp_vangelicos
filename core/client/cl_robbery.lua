---------------------------
-- Locals --
---------------------------
-- //©_Scrubz#0001_© ^_^// --
-- //BaysideRP Public Release// --
-- //Made for the NextGen Framework using the DRP Core// --
isRobbing = false
local canRob = false
local isPlyLoaded = false
local govEmployee = false
local onCooldown = false
local alarmCut = false
local markerPos = vector3(-621.9979, -230.7801, 38.057)
local silentAlarm = vector3(-630.9418, -230.6714, 38.0571)

---------------------------
-- Threads --
---------------------------
-- //Job Checking Thread// --
function setJob()
    local timeOut = 1000
    if exports["drp_id"]:SpawnedInAndLoaded() and not isPlyLoaded then
        isPlyLoaded = true
    end
    if isPlyLoaded then
        timeOut = 30000
        DRP.NetCallbacks.Trigger('drp_vangelicos_sv:checkJob', function(plyJob)
            if plyJob == "POLICE" then
                if not govEmployee then
                    govEmployee = true
                end
            else
                if govEmployee then
                    govEmployee = false
                end
            end
        end)
    end
    SetTimeout(timeOut, setJob)
end
setJob()

-- //Marker Thread// --
Citizen.CreateThread(function()
    local plyPed = GetPlayerPed(-1)
    drawBlip()
    while true do
        local sleep = 1000
        if not govEmployee then
            if not onCooldown 
                and not isRobbing
                and canRob
                then
                local plyPos = GetEntityCoords(plyPed)
                local isNearMarker = #(plyPos - markerPos)
                if isNearMarker <= 10 then
                    sleep = 100
                    if isNearMarker <= 3 then
                        sleep = 3
                        DrawMarker(29, markerPos.x, markerPos.y, markerPos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 255, 255, 255, 255, false, false, 2, true, nil, nil, false)
                        if not alarmCut then
                            DrawText3Ds(markerPos.x, markerPos.y, markerPos.z - 0.3, '~r~Alarm Armed')
                        else
                            DrawText3Ds(markerPos.x, markerPos.y, markerPos.z - 0.3, '~b~Alarm Disabled')
                        end
                        if isNearMarker <= 1 then
                            infoText('Press ~INPUT_VEH_HORN~ to start the robbery.')
                            if IsControlJustPressed(1, 86) then  -- Key: E
                                if not alarmCut then
                                    TriggerServerEvent('drp_vangelicos_sv:startRobbery', false)
                                else
                                    TriggerServerEvent('drp_vangelicos_sv:startRobbery', true)
                                end
                            end
                        end
                    end
                    local isNearAlarm = #(plyPos - silentAlarm)
                    if isNearAlarm <= 2 
                        and not alarmCut
                        then
                        sleep = 4
                        DrawText3Ds(silentAlarm.x, silentAlarm.y, silentAlarm.z, 'Press ~r~[E]~w~ to attempt to cut the silent alarm')
                        if IsControlJustPressed(1, 86) then  -- Key: E
                            TriggerServerEvent('drp_vangelicos_sv:toggleAlarm')
                            -- Either add fuckyou chances to alert police anyways here, or add a check for the cut alarm and do it when you start the robbery.
                        end
                    end
                end
            end
        else
            sleep = 60000
        end
        Citizen.Wait(sleep)
    end
end)

-- //Wow. Much Loots// --
Citizen.CreateThread(function()
    local plyPed = GetPlayerPed(-1)
    while true do
        local sleep = 500
        -- Code
        if not govEmployee then
            if onCooldown 
                and isRobbing
                then
                sleep = 100
                local plyPos = GetEntityCoords(plyPed)
                for k, v in pairs(Config.MuchLoots) do
                    local canHasLoot = #(plyPos - v.location)
                    if canHasLoot <= 15 then
                        sleep = 4
                        if not v.isSearched then
                            DrawMarker(27, v.location.x, v.location.y, v.location.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 255, false, false, 2, true, nil, nil, false)
                            if canHasLoot <= 0.4 then
                                DrawText3Ds(v.location.x, v.location.y, v.location.z, 'Press ~r~[E]~w~ to smash the case')
                                if IsControlJustPressed(1, 86) then  -- Key: E
                                    local fuckyou = math.random(1, 6)
                                    if fuckyou <= 2 then
                                        while not HasAnimDictLoaded("missheist_jewel") do
                                            RequestAnimDict("missheist_jewel")
                                            Citizen.Wait(0)
                                        end
                                        FreezeEntityPosition(plyPed, true)
                                        TaskPlayAnim(plyPed, "missheist_jewel", "smash_case", 5.0, 1.0, -1, 1, 0, 0, 0, 0)
                                        Citizen.Wait(2500)
                                        ClearPedTasks(plyPed)
                                        FreezeEntityPosition(plyPed, false)
                                        TriggerServerEvent('drp_vangelicos_sv:gibLoot', k)
                                    else
                                        while not HasAnimDictLoaded("missheist_jewel") do
                                            RequestAnimDict("missheist_jewel")
                                            Citizen.Wait(0)
                                        end
                                        FreezeEntityPosition(plyPed, true)
                                        TaskPlayAnim(plyPed, "missheist_jewel", "smash_case", 5.0, 1.0, -1, 1, 0, 0, 0, 0)
                                        Citizen.Wait(1000)
                                        ClearPedTasks(plyPed)
                                        FreezeEntityPosition(plyPed, false)
                                        print("Fuck you nigga")
                                    end
                                end
                            end
                        else
                            DrawMarker(27, v.location.x, v.location.y, v.location.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 255, false, false, 2, true, nil, nil, false)
                        end
                    end
                end
            end
        else
            sleep = 60000
        end
        Citizen.Wait(sleep)
    end
end)

---------------------------
-- Event Handlers --
---------------------------
-- //Setting Robbery Status// --
RegisterNetEvent('drp_vangelicos_cl:setStatus')
AddEventHandler('drp_vangelicos_cl:setStatus', function(status)
    print("1")
    if status then
        onCooldown = true
        isRobbing = true
        robberyTimer()
    elseif not status then
        onCooldown = false
        alarmCut = false
        resetLoots()
    end
end)

-- //Syncing Searched Locations// --
RegisterNetEvent('drp_vangelicos_cl:gibLoot')
AddEventHandler('drp_vangelicos_cl:gibLoot', function(id)
    lootCase(id)
end)

-- //Silent Alarm Toggle// --
RegisterNetEvent('drp_vangelicos_cl:alarmToggle')
AddEventHandler('drp_vangelicos_cl:alarmToggle', function()
    alarmCut = true
end)

-- //Police Chat Alert// --
RegisterNetEvent('drp_vangelicos_cl:chatAlert')
AddEventHandler('drp_vangelicos_cl:chatAlert', function()
    if govEmployee then
        TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(48, 145, 255, 0.616); border-radius: 10px;">{0}</div>',
			args = {'[911] Vangelicos Silent Alarm Triggered'}
        })
    end
end)

-- //Police Counter// --
RegisterNetEvent('drp_vangelicos_cl:policeCheck')
AddEventHandler('drp_vangelicos_cl:policeCheck', function(policeConnected)
    if policeConnected >= Config.PoliceRequired then
        canRob = true
    else
        canRob = false
    end
end)