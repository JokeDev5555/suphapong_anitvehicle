ESX								= nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local vehicle = GetClosestVehicle()
        if vehicle then
            DrawMarker(1, GetEntityCoords(vehicle)+vector3(0,0,0), 0.0,0.0,0.0, 0.0,0.0,0.0, 5.0,5.0,0.125, 255,255,255, 255, false,true,2,nil,nil,false)
            SetEntityNoCollisionEntity(PlayerPedId(), vehicle, false)
        end
    end
end)

GetClosestVehicle = function()
    local data = {}
    local coords = GetEntityCoords(PlayerPedId())
	local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 50.0)
    for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= 15.0 then
			table.insert(data, {
                Veh = vehicles[i],
                dist = distance
            })
		end
	end
    table.sort(data, function(a, b) return b.dist > a.dist end)

    if #data > 0 then
        return data[1].Veh
    else
        return nil
    end
end