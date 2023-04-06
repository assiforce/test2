
Found = {}
Objects = {}
EggHashes = {'core_egg02', 'core_egg01', 'core_egg03', 'core_egg04', 'core_egg05', 'core_egg06'}


Citizen.CreateThread(function()

  Citizen.Wait(1000)


    SendNUIMessage({
        type = 'open'
    })

    TriggerServerEvent('core_egghunt:server:getCurrent')

  Citizen.Wait(1000)

    for k,v in pairs(Config.EggLocations) do

              if not Found[k] then


              Objects[k] = CreateObject(
              GetHashKey(EggHashes[math.random(1, #EggHashes)]), 
              v[1],
              v[2],
              v[3], 
              false, 
              true, 
              0
              )

              end


    end


    while true do

local coords = GetEntityCoords(PlayerPedId())

    for k,v in pairs(Config.EggLocations) do

       if #(v - coords) < 2 and  not Found[k] then

              TriggerServerEvent('core_egghunt:server:addEgg', k)
                PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
              SendTextMessage(Config.Text['collected'])     
       end

    end
       Citizen.Wait(100)


    end

end)






RegisterNetEvent('core_egghunt:client:setFound')
AddEventHandler('core_egghunt:client:setFound', function(found)

Found = found

end)


RegisterNetEvent('core_egghunt:client:removeObj')
AddEventHandler('core_egghunt:client:removeObj', function(obj)

DeleteEntity(Objects[obj])

end)

RegisterNetEvent('core_egghunt:client:update')
AddEventHandler('core_egghunt:client:update', function(place, name, score)

    

 SendNUIMessage({
        type = 'update',
        place = place,
        name = name,
        score = score
    })

end)