Citizen.CreateThread( function()
	SetNuiFocus( false )
end)

RegisterNetEvent('vrpex:itens')
AddEventHandler('vrpex:itens', function(inventario, reload)
Citizen.Trace("tutorial launch")
menuEnabled = not menuEnabled
	if reload == false then
		if ( menuEnabled ) then 
			SetNuiFocus( true, true )
			SendNUIMessage({showmenu = true,InventarioJS = inventario })
			menuEnabled = not menuEnabled
		else 
			SetNuiFocus( false )
			SendNUIMessage({hidemenu = true })
		end
	else
			SetNuiFocus( true, true )
			SendNUIMessage({showmenu = true,InventarioJS = inventario})
	end		
end)

local menuEnabled = false 

function ToggleActionMenu()
	if ( menuEnabled ) then 
		SetNuiFocus( true, true )
		SendNUIMessage({showmenu = true })
	else 
		SetNuiFocus( false )
		SendNUIMessage({hidemenu = true })
	end 
end 

RegisterNUICallback('vrpex:inventory', function(data, cb)
	TriggerServerEvent("vrpex:inventory")
  	cb('ok')
end)

RegisterNUICallback('vrpex:Usar', function(data, cb)
  	cb('ok')
end)

RegisterNUICallback('Descartar', function(data, cb)
	TriggerServerEvent("vrpex:trash",data)
  	cb('ok')
  	TriggerServerEvent("vrpex:inventory", true)
end)

RegisterNUICallback('Enviar', function(data, cb)
	TriggerServerEvent("vrpex:enviar",data)
  	cb('ok')
  	TriggerServerEvent("vrpex:inventory", true)
end)

RegisterNUICallback( "ButtonClick", function( data, cb ) 
	if ( data == "button1" ) then 
		chatPrint( "Button 1 pressed!" )
	elseif ( data == "button2" ) then 
		chatPrint( "Button 2 pressed!" )
	elseif ( data == "button3" ) then 
		chatPrint( "Button 3 pressed!" )
	elseif ( data == "button4" ) then 
		chatPrint( "Button 4 pressed!" )
	elseif ( data == "button5" ) then 
		chatPrint( "Button 5 pressed!" )
	elseif ( data == "button6" ) then 
		chatPrint( "Button 6 pressed!" )
	elseif ( data == "exit" ) then 

		ToggleActionMenu()
		return 
	end 
	ToggleActionMenu()
end )

Citizen.CreateThread( function()
	SetNuiFocus( false )
	while true do 
		if ( IsControlJustPressed( 1, 20 ) ) then 
			TriggerServerEvent("reborn:inventory",false)
		end 
	    if ( menuEnabled ) then
            local ped = GetPlayerPed( -1 )	
            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( ped, true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
        end
		Citizen.Wait( 0 )
	end 
end )

function chatPrint( msg )
	TriggerEvent( 'chatMessage', "ActionMenu", { 255, 255, 255 }, msg )
end 
