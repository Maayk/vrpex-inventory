local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "reborn-inventory")

RegisterServerEvent("reborn-inv:openGui")
AddEventHandler("reborn-inv:openGui",function()
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data and data.inventory then
        local inventory = {}
        for data_k, data_v in pairs(data.inventory) do
            for items_k, items_v in pairs(items) do
                if data_k == items_k then
                    local item_name = items_v[4]
                    local item_desc = items_v[6]
                    item_peso = items_v[5]
                    if item_name then
                        table.insert(inventory,{name = items_v[4],amount = data_v.amount,idname = data_k,icon = items_v[3], item_desc = items_v[6]})
                    end
                end
            end
        end
        local weight = vRP.getInventoryWeight(user_id)
        local maxWeight = vRP.getInventoryMaxWeight(user_id)
        TriggerClientEvent("reborn-inv:updateInventory", source, inventory, weight, maxWeight)
    end
end)

RegisterServerEvent("reborn-inv:useItem")
AddEventHandler("reborn-inv:useItem",function(args)
    local data = args[1]
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if data.idname then
        for k, v in pairs(items) do
            if data.idname == k then
                useItem(user_id, player, k, v[1], v[2], data.amount)
            end
        end
    end
end)

RegisterServerEvent("reborn-inv:dropItem")
AddEventHandler("reborn-inv:dropItem",function(data)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local amount = parseInt(data.amount)
    local px,py,pz = vRPclient.getPosition(source)
    print("1 Drop Item")
    if vRP.tryGetInventoryItem(user_id, data.idname, amount, false) then
        TriggerClientEvent("reborn-inv:closeGui", player)
        TriggerClientEvent("reborn-inv:UpdateGui", player)
        TriggerEvent("DropSystem:create",data.idname,amount,px,py,pz)
        vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
        TriggerClientEvent("Notify",player,"sucesso","Você jogou fora "..amount.."x "..data.idname,2500)
    else
        TriggerClientEvent("Notify",player,"sucesso","Ainda não sei ",2500)
        --TriggerClientEvent("reborn-inv:UINotification",player,"warning",Config.Language.WarningTitle,Config.Language.Error)
    end
    print("2 Drop Item")
end)

function split(str, sep)
    local array = {}
    local reg = string.format("([^%s]+)", sep)
    for mem in string.gmatch(str, reg) do
        table.insert(array, mem)
    end
    return array
end

function useItem(user_id, player, idname, type, variation, amount)
    if type == "drink" or type == "food" or type == "drugs" or type == "heal" or type == "weapon" or type == "ammo" then
        if type == "drink" then
            if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                TriggerClientEvent("reborn-inv:objectForAnimation", player, "prop_ld_flow_bottle")
                vRPclient._playAnim(source,true,{{"mp_player_intdrink","intro_bottle"}},false)
                play_drink(player)
                for i = 1, tonumber(amount) do
                    vRP.varyThirst(user_id, variation)
                end
            end
        end
        if type == "food" then
            if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                TriggerClientEvent("reborn-inv:objectForAnimation", player, "prop_cs_burger_01")
                play_eat(player)
                for i = 1, tonumber(amount) do
                    vRP.varyHunger(user_id, variation)
                end
            end
        end
        if type == "drugs" then
            if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                TriggerClientEvent("reborn-inv:objectForAnimation", player, "prop_cs_burger_01")
                play_eat(player)
                for i = 1, tonumber(amount) do
                    vRP.varyHunger(user_id, variation)
                    vRP.varyThirst(user_id, variation)
                end
            end
        end
        if type == "heal" then
            if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                for i = 1, tonumber(amount) do
                    vRPclient.varyHealth(player, 25)
                end
            end
        end
        if type == "weapon" then
            if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                local fullidname = split(idname, "|")
                vRPclient.giveWeapons(player,{[fullidname[2]] = {ammo = 0}},false)
            end
        end
        if type == "ammo" then
            local fullidname = split(idname, "|")
            local exists = false
            weapons = vRPclient.getWeapons(player)
            for k, v in pairs(weapons) do
                if k == fullidname[2] then
                    exists = true
                end
            end
            if exists == true then
                if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                    vRPclient.giveWeapons(player,{[fullidname[2]] = {ammo = tonumber(amount)}},false)
                end
            else
                TriggerClientEvent("reborn-inv:UINotification",player,"warning",Config.Language.WarningTitle,Config.Language.WeaponNotEquipped)
            end
        end
    end
    if type == "none" then
        TriggerClientEvent("reborn-inv:UINotification",player,"warning",Config.Language.WarningTitle,Config.Language.CannotBeUsed)
    end
end

RegisterServerEvent("reborn-inv:giveItem")
AddEventHandler("reborn-inv:giveItem",function(data)
        local user_id = vRP.getUserId(source)
        local player = vRP.getUserSource(user_id)
        if user_id ~= nil then
            local nplayer = vRPclient.getNearestPlayer(player,2)
                    if nplayer ~= nil then
                        local nuser_id = vRP.getUserId(nplayer)
                        if nuser_id ~= nil then
                            local amount = parseInt(data.amount)
                            local new_weight = vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(data.idname) * amount
                            if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
                                if vRP.tryGetInventoryItem(user_id, data.idname, amount, false) then
                                    vRP.giveInventoryItem(nuser_id, data.idname, amount, true)
                                    TriggerClientEvent("reborn-inv:closeGui", player)
                                    TriggerClientEvent("reborn-inv:UpdateGui", player)
                                              vRPclient._playAnim(player,true,{{"mp_common","givetake1_a"}},false)
                                    vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
                                    TriggerClientEvent("Notify",player,"sucesso","Você enviou "..amount.."x "..data.idname,2500)
                                else
                                    TriggerClientEvent("Notify",source,"negado","Bolsa cheia.",2500)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","A pessoa está com a mochila cheia.",2500)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Erro 2.",2500)
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Nenhuma pessoa perto de você.",2800)
                    end
        end
    end
)

function play_eat(player)
    local seq = {
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
    }

    vRPclient.playAnim(player,true,seq,false)
end

function play_drink(player)
    local seq = {
        {"mp_player_intdrink","intro_bottle",1},
        {"mp_player_intdrink","loop_bottle",1},
        {"mp_player_intdrink","outro_bottle",1}
    }

    vRPclient.playAnim(player,true,seq,false)
end