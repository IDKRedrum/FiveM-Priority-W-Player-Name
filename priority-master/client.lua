local cooldown = 0
local ispriority = false
local ishold = false
local hide = false
local name = ''

-- Reset Clock
RegisterCommand("resetcooldown", function(source, args, rawCommand)
    TriggerServerEvent("cancelcooldown")
    drawNotification("The priority cooldown has been ~r~reset~w~.")
end)

RegisterNetEvent('UpdateCooldown')
AddEventHandler('UpdateCooldown', function(newCooldown)
    cooldown = newCooldown
end)

RegisterNetEvent('UpdatePriority')
AddEventHandler('UpdatePriority', function(newispriority, newName)
	ispriority = newispriority
	name = newName
end)

RegisterNetEvent('UpdateHold')
AddEventHandler('UpdateHold', function(newishold)
    ishold = newishold
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ishold == true then
			DrawText2("~c~Priority Status~w~ : ~r~Priorities Are On Hold")
		elseif ispriority == true then
            DrawText2("~c~Priority Status~w~ : ~r~Active ~w~(".. name .. "~w~)")
		elseif cooldown == 0 then
            DrawText2("~c~Priority Status~w~ : ~w~Inactive")
        elseif ispriority == false then
			DrawText2("~c~Priority Status~w~ : ~w~Cooldown ~w~(".. cooldown .."m)")
		end
	end
end)

function DrawText2(text)
    SetTextProportional(1)
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.17580, 0.860)
end

function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end