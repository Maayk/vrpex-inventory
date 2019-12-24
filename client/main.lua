local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrpex-inventory")

local show = false
local temp_inventory = nil
local temp_weight = nil
local temp_maxWeight = nil
local cooldown = 0

Citizen.CreateThread( function()
  SetNuiFocus(false, false)
end)


function openGui(inventory, weight, maxWeight)
  if show == false then
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage({show = true,inventory = inventory,weight = weight,maxWeight = maxWeight})
    IsPauseMenuActive(true)
  end
end

function UpdateGui()
  show = false
  SetNuiFocus(true, true)
  SendNUIMessage({show = false})
end

function FechandoJanela()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end


RegisterNetEvent("vrpex-inv:UpdateGui")
AddEventHandler("vrpex-inv:UpdateGui",function()
  UpdateGui()
  TriggerServerEvent("vrpex-inv:openGui")
end)


RegisterNetEvent("vrpex-inv:openGui")
AddEventHandler("vrpex-inv:openGui",function()
    if cooldown > 0 and temp_inventory ~= nil and temp_weight ~= nil and temp_maxWeight ~= nil then
      openGui(temp_inventory, temp_weight, temp_maxWeight)
    else
      TriggerServerEvent("vrpex-inv:openGui")
    end
end)

RegisterNetEvent("vrpex-inv:updateInventory")
AddEventHandler("vrpex-inv:updateInventory",function(inventory, weight, maxWeight)
    cooldown = Config.AntiSpamCooldown
    temp_inventory = inventory
    temp_weight = weight
    temp_maxWeight = maxWeight
    openGui(temp_inventory, temp_weight, temp_maxWeight)
end)

RegisterNetEvent("vrpex-inv:UINotification")
AddEventHandler("vrpex-inv:UINotification",function(type, title, message)
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage({show = true,notification = true,type = type,title = title,message = message })
end)

RegisterNetEvent("vrpex-inv:closeGui")
AddEventHandler("vrpex-inv:closeGui",function()
  FechandoJanela()

  
end)

RegisterNetEvent("vrpex-inv:objectForAnimation")
AddEventHandler("vrpex-inv:objectForAnimation",function(type)
    local ped = GetPlayerPed(-1)
    DeleteObject(object)
    bone = GetPedBoneIndex(ped, 60309)
    coords = GetEntityCoords(ped)
    modelHash = GetHashKey(type)

    RequestModel(modelHash)
    object = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(object, ped, bone, 0.1, 0.0, 0.0, 1.0, 1.0, 1.0, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(2500)
    DeleteObject(object)
end)

RegisterNUICallback("close",function(data)
  FechandoJanela()

end)

RegisterNUICallback("useItem",function(data)
    TriggerServerEvent("vrpex-inv:useItem", {data})
    UpdateGui()
    TriggerEvent("vrpex-inv:openGui")
end)

RegisterNUICallback("dropItem",function(data)
  TriggerServerEvent("vrpex-inv:dropItem", data)
  UpdateGui()
end)

RegisterNUICallback("giveItem",function(data)
    TriggerServerEvent("vrpex-inv:giveItem", data)
    UpdateGui()
end)

RegisterCommand("inventory",function(source, args)
    TriggerEvent("vrpex-inv:openGui")
end)

Citizen.CreateThread(function()while true do
      Citizen.Wait(1)
      if IsControlPressed(0, Config.OpenMenu) then

        TriggerEvent("rplay_sound:Sound:PlayOnOne","openback",0.3,true)
        TriggerEvent("vrpex-inv:openGui")
      end
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cooldown > 0 then 
      cooldown = cooldown - 1
    end
  end
end)

AddEventHandler("onResourceStop",function(resource)
    if resource == GetCurrentResourceName() then
      UpdateGui()
    end
end)



Citizen.CreateThread(function()
	RegisterNetEvent('rplay_sound:Sound:PlayOnOne')
	AddEventHandler('rplay_sound:Sound:PlayOnOne', function(soundFile, soundVolume, loop)
	    SendNUIMessage({
	        transactionType     = 'playSound',
	        transactionFile     = soundFile,
	        transactionVolume   = soundVolume,
			transactionLoop   = loop
	    })
	end)
	RegisterNetEvent('rplay_sound:Sound:StopOnOne')
	AddEventHandler('rplay_sound:Sound:StopOnOne', function()
	    SendNUIMessage({
	        transactionType     = 'stopSound'
	    })
	end)
end)
