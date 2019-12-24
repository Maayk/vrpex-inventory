local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
riPlayer = Tunnel.getInterface("reborn-inventory", "reborn-inventory")

RegisterServerEvent("reborn:inventory")
AddEventHandler("reborn:inventory", function(reload)
  local source = source
  local user_id = vRP.getUserId(source)
  local data = vRP.getUserDataTable(user_id) or {}
    for k,v in pairs(data.inventory ) do
        local name,description,weight = vRP.getItemDefinition(k)
        v.name = name
        v.weight = weight
        v.description = description
    end
    TriggerClientEvent('reborn:itens', source, data.inventory, reload)
end)


RegisterServerEvent("reborn:trash")
AddEventHandler("reborn:trash", function(data)
  local user_id = vRP.getUserId(source)
  local idname = data.name
  local qtd = data.qtd

  player = source
  if user_id ~= nil then
      local amount = parseInt(qtd)
      if vRP.tryGetInventoryItem(user_id,idname,amount,false) then
        vRPclient.notify(player,"Item destruido")
        vRPclient.playAnim(player,true,{"pickup_object","pickup_low",1},false)
      else
        vRPclient.notify(player,"Valor inválido")
      end
  end
end)

RegisterServerEvent("reborn:enviar")
AddEventHandler("reborn:enviar", function(data)
  player = source
  idname = data.name


  local user_id = vRP.getUserId(player)

  if user_id ~= nil then
    -- get nearest player
    vRPclient.getNearestPlayer(player,10,function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
          amount = data.qtd
            local amount = parseInt(amount)
            -- weight check
            local new_weight = vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(idname)*amount
            if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
              if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
                vRP.giveInventoryItem(nuser_id,idname,amount,true)
               -- vRPclient.playAnim(player,true,{{"mp_common","givetake1_a",1}},false)
               -- vRPclient.playAnim(nplayer,true,{{"mp_common","givetake2_a",1}},false)
              else
                vRPclient.notify(player,"Valor inválido")
              end
            else
              vRPclient.notify(player,"Inventário cheio")
            end
        else
          vRPclient.notify(player,"Nenhum jogador perto de voce")
        end
      else
        vRPclient.notify(player,"Nenhum jogador perto de voce")
      end
    end)
  end
end)