---------------------------
-- Functions --
---------------------------
-- //©_Scrubz#0001_© ^_^// --
function drawBlip()
    local vangelicos = AddBlipForCoord(-621.9979, -230.7801, 38.057)
    SetBlipSprite(vangelicos, 617)
    SetBlipDisplay(vangelicos, 2)
    SetBlipScale(vangelicos, 1.0)
    SetBlipColour(vangelicos, 4)
    SetBlipAsShortRange(vangelicos, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Vangelicos')
    EndTextCommandSetBlipName(vangelicos)
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end

function infoText(string)
    SetTextComponentFormat("STRING")
    AddTextComponentString(string)  -- [E] Class 1 - [H] Class 2
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function lootCase(id)
    for k, v in pairs(Config.MuchLoots) do
        if k == id then
            v.isSearched = true
        end
    end
end

function resetLoots()
    for k, v in pairs(Config.MuchLoots) do
        if v.isSearched then
            v.isSearched = false
        end
    end
end

function robberyTimer()
    local timer = Config.RobberyTimer
    while isRobbing do
        if timer <= 0 then
            isRobbing = false
        end
        timer = timer - 1
        Citizen.Wait(1000)
    end
end
