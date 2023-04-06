


Leaderboard = {}
Found = {}


Citizen.CreateThread(function()

local file = LoadResourceFile(GetCurrentResourceName(), "./data.json")
Leaderboard = json.decode(file) or {}
SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(Leaderboard), -1)

local file2 = LoadResourceFile(GetCurrentResourceName(), "./found.json")
Found = json.decode(file2) or {}
SaveResourceFile(GetCurrentResourceName(), "found.json", json.encode(Found), -1)

end)

function escape_magic(s)
  return (s:gsub('[%^%$%(%)%%%.%[%]%*%+%-%?]',''))
end


function calcPlace(name)

local place = 1
local score = Leaderboard[name]

for k,v in pairs(Leaderboard) do

if v > score and k ~= name then
	place = place + 1
end

end


return place
end

RegisterServerEvent('core_egghunt:server:getCurrent')
AddEventHandler('core_egghunt:server:getCurrent', function()

local source = source

for k,v in pairs(Leaderboard) do

local place = calcPlace(k)

if place < 7  then

TriggerClientEvent('core_egghunt:client:update', source ,place, k, v )
end

end

TriggerClientEvent('core_egghunt:client:setFound', source, Found )
end)

RegisterServerEvent('core_egghunt:server:addEgg')
AddEventHandler('core_egghunt:server:addEgg', function(id)

	if Found[id] then
		return end

local file = LoadResourceFile(GetCurrentResourceName(), "./data.json")
local source = source
local name = escape_magic(GetPlayerName(source))

Found[id] = true

if Leaderboard[name] then
Leaderboard[name] = Leaderboard[name] + 1
else
Leaderboard[name] = 1
end

local place = calcPlace(name)


if place < 7 then
TriggerClientEvent('core_egghunt:client:update', -1 ,place, name, Leaderboard[name] )
end


TriggerClientEvent('core_egghunt:client:setFound', -1, Found )
TriggerClientEvent('core_egghunt:client:removeObj', -1, id )

SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(Leaderboard), -1)
SaveResourceFile(GetCurrentResourceName(), "found.json", json.encode(Found), -1)

end)