
if Config.Framework.ESX then
    if Config.UseNewESX then 
        ESX = exports["es_extended"]:getSharedObject()
    else
        ESX = nil

        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(0)
            end
        end)
    end
elseif Config.Framework.QBCore then 
    QBCore = exports['qb-core']:GetCoreObject()
end

AddEventHandler('onClientResourceStart', function(ressourceName)
    if(GetCurrentResourceName() ~= ressourceName) then 
        print("" ..ressourceName.." started sucessfully")
    end 
end)

local busy = false
local propspawned = false
local returncompany = false
local timer = 0
local intervall = Config.RewardTimeIntervall


if Config.Target.drawtext3d then
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(0)
            for k, v in pairs(Config.StartMission) do
                local Boxcoords = vector3(v.startcoords.x, v.startcoords.y, v.startcoords.z)
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local distance = GetDistanceBetweenCoords(coords,v.startcoords.x, v.startcoords.y, v.startcoords.z)
                if distance < 2 then 
                    DrawText3D(v.startcoords.x, v.startcoords.y, v.startcoords.z+0.3,Translation[Config.Locale]['start_mission'])
                    DrawText3D(v.startcoords.x, v.startcoords.y, v.startcoords.z+0.1,Translation[Config.Locale]['cancel_mission'])
                    if IsControlJustPressed(1, 47)then 
                        if busy then
                            endjob()
                            Config.MSG(Translation[Config.Locale]['job_canceled'])
                        else
                            Config.MSG(Translation[Config.Locale]['job_not_started'])
                        end
                    end
                    if IsControlJustPressed(1, 38) then 
                        if not busy then
                            startsnowplow(v.vehicle, v.vehiclespawn)
                        else 
                            Config.MSG(Translation[Config.Locale]['already_started_Mission'])
                        end
                    end
                end
            end 
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if propspawned then
            local vehcoords = GetEntityCoords(vehicle)
            local dst = Vdist(vehcoords, result.x, result.y, result.z)
            if dst < 30 and timer < Config.MaxTime then 
                DrawMarker(0, result.x, result.y, result.z + 2.02, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.1, 255, 255, 255, 150, 1, 0, 2, 0, 0, 0, 0)
                if dst < Config.DistancetoProp and timer < Config.MaxTime then 
                    showPictureNotification(Translation[Config.Locale]['Picture'], Translation[Config.Locale]['snow_message'], Translation[Config.Locale]['snow_Title'])
                    DeleteEntity(snowprop)
                    RemoveBlip(snowblip)
                    propspawned = false 
                    spawnprop()
                end
            end
        end
    end
end)

local invehicle = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DoesEntityExist(vehicle) then 
            if IsPedInVehicle(PlayerPedId(), vehicle, false) and not invehicle then 
                invehicle = true 
                RemoveBlip(vehicleblip)
            elseif not IsPedInVehicle(PlayerPedId(), vehicle, false) and invehicle then 
                invehicle = false 
                ps_vehicleblip()
            end 
        end  
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if IsPedInVehicle(PlayerPedId(), vehicle, false) and busy and not endstep then
            Citizen.Wait(1)
            if Config.Settings.usekmh then
                speed = GetEntitySpeed(vehicle) * 3.6
            else
                speed = GetEntitySpeed(vehicle)
            end
            if speed > Config.Settings.minspeed then 
                if speed < Config.Settings.maxspeed then                            
                    timer = timer + 1
                    Citizen.Wait(1000)
                else
                    shownotify(Translation[Config.Locale]['max_speed'])
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.StartMission) do
        RequestModel(GetHashKey(v.npcname))
		while not HasModelLoaded(GetHashKey(v.npcname)) do
			Wait(1)
		end
        RequestAnimDict("oddjobs@assassinate@guard")
		while not HasAnimDictLoaded("oddjobs@assassinate@guard") do
			Wait(1)
		end
        ped =  CreatePed(4, v.npcname, v.startcoords.x, v.startcoords.y, v.startcoords.z -1.0, v.startcoords.w, false, false)
        SetEntityHeading(ped, v.startcoords.w)
        FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped,"oddjobs@assassinate@guard","unarmed_fold_arms", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        --table.insert(SpawnedPeds, ped)

        while not DoesEntityExist(ped) do 
            Citizen.Wait(25)
        end
        if Config.Target.oxtarget then
            exports.ox_target:addLocalEntity(ped,
            {
                name = 'snowplow',
                icon = 'fas fa-snowflake',
                distance = 3.0,
                onSelect = function()
                    if busy then
                        endjob()
                        Config.MSG(Translation[Config.Locale]['job_canceled'])
                    else
                        Config.MSG(Translation[Config.Locale]['job_not_started'])
                    end
                end,
                label = 'Stop Job',
            },
            exports.ox_target:addLocalEntity(ped,
            {
                name = 'snowplow2',
                icon = 'fas fa-snowflake',
                distance = 3.0,
                onSelect = function()
                    if not busy then
                        startsnowplow(v.vehicle, v.vehiclespawn)
                    else 
                        Config.MSG(Translation[Config.Locale]['already_started_Mission'])
                    end
                end,
                label = 'Start Job',
            }))
        elseif Config.Target.qbtarget then 
            exports['qb-target']:AddEntityZone('snowplowped', ped, {
                name = 'snowplowped',
                debugPoly = false,
            }, {
                options = {
                    {
                        icon = 'fas fa-snowflake',
                        label = 'Start Job',
                        action = function(entity)
                            if not busy then
                                startsnowplow(v.vehicle, v.vehiclespawn)
                            else 
                                Config.MSG(Translation[Config.Locale]['already_started_Mission'])
                            end
                        end,
                    },
                    {
                        icon = 'fas fa-snowflake',
                        label = 'Stop Job',
                        action = function(entity)
                            if busy then
                                endjob()
                                Config.MSG(Translation[Config.Locale]['job_canceled'])
                            else
                                Config.MSG(Translation[Config.Locale]['job_not_started'])
                            end
                        end,
                    },
                },
                distance = 1.5,
            })
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.StartMission) do 
        MapBlip = AddBlipForCoord(v.startcoords.x, v.startcoords.y, v.startcoords.z)
        SetBlipSprite(MapBlip, Config.Blip.mapstart.id) 
        SetBlipDisplay(MapBlip, 4)
        SetBlipScale(MapBlip, 0.7)
        SetBlipColour(MapBlip, Config.Blip.mapstart.color)
        SetBlipAsShortRange(MapBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Translation[Config.Locale]['start_mission_blip'])
        EndTextCommandSetBlipName(MapBlip)
    end
end)

local endstep = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if busy and not endstep then
            if Config.UseTimerOnScreen then
                DrawTextScreen(timer)
            end
            if timer < Config.MaxTime then
                if timer > intervall then 
                    intervall = (intervall + Config.RewardTimeIntervall)
                    PlaySoundFrontend(-1, "REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                    TriggerServerEvent("phoenix:addmoneyintervall")   
                end
            else 
                if not endstep then
                    endstep = true
                    PlaySoundFrontend(-1, "REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                    TriggerServerEvent("phoenix:addmoneyintervall") 
                    returntocompany()
                end
            end
        end
    end
end)

local try = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if returncompany then
            local PlayerPed = PlayerPedId()
            local plycoords = GetEntityCoords(PlayerPedId())
            local dist = Vdist(plycoords, globalvehcoords)
            if dist < 20 then 
                --DrawText3D(globalvehcoords.x, globalvehcoords.y, globalvehcoords.z+0.3, Translation[Config.Locale]['complete_mission']) 
                DrawMarker(1, globalvehcoords.x, globalvehcoords.y, globalvehcoords.z -1.0, 0, 0, 0, 0, 0, 0, 5.0,5.0,1.0, 255,255,255, 150, 0, 0, 2, 0, 0, 0, 0)
                if dist < 6 then 
                    shownotify(Translation[Config.Locale]['complete_mission'])
                    if IsControlJustReleased(0, 38) then 
                        if IsPedInVehicle(PlayerPed, vehicle, false) then
                            endjob()
                            PlaySoundFrontend(-1, "REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                            TriggerServerEvent("phoenix:addmoney")
                        else 
                            try = try + 1
                            Config.MSG(Translation[Config.Locale]['need_car'])
                            if try > 3 then 
                                Config.MSG(Translation[Config.Locale]['try_to_end'])
                                try = 0
                            end
                        end
                    end 
                end
            end 
        end
    end
end)

startsnowplow = function(veh, vehcoords)
    TriggerServerEvent("phoenix_snowplow:bail", 'remove')
    globalvehcoords = vehcoords
    busy = true
    local hash = GetHashKey(veh)
    local playerPed = PlayerPedId()
    RequestModel(hash)
    while not HasModelLoaded(hash) do 
        Citizen.Wait(50)
    end
    vehicle = CreateVehicle(hash, vehcoords.x, vehcoords.y, vehcoords.z, vehcoords.w, true, true)
    SetVehicleNumberPlateText(vehicle, 'XMAS')
    --SetPedIntoVehicle(playerPed, vehicle, -1)
    if veh == 'phoenixsnow' then
        SetVehicleExtra(vehicle, 10, true)
        SetVehicleExtra(vehicle, 11, true)
    end
    Config.MSG(Translation[Config.Locale]['info_on_start'])
    if Config.SpawnProps then 
        spawnprop()
    end
end


spawnprop = function()
    result = Config.SnowProps[math.random(#Config.SnowProps)]
    local hash = GetHashKey('prop_pile_dirt_01')
    RequestModel(hash)
    while not HasModelLoaded(hash) do 
        Citizen.Wait(50)
    end
    snowprop = CreateObject(hash, result.x, result.y, result.z - 1.5, Config.VisibleforAll, false, false)
    PlaceObjectOnGroundProperly(snowprop)
    FreezeEntityPosition(snowprop, true)
    
    snowblip = AddBlipForCoord(result.x, result.y, result.z)
    SetBlipSprite(snowblip, Config.Blip.prop.id)
    SetBlipScale(snowblip, 0.9)
    SetBlipColour(snowblip, Config.Blip.prop.color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Translation[Config.Locale]['Snow'])
    EndTextCommandSetBlipName(snowblip)
    SetBlipRoute(snowblip, true)
    propspawned = true
end

returntocompany = function()
    returncompany = true
    RemoveBlip(snowblip)
    DeleteEntity(snowprop)
    local playerPed = PlayerPedId()
    Citizen.Wait(5000)
    showPictureNotification(Translation[Config.Locale]['Picture'], Translation[Config.Locale]['message_step10_end'],Translation[Config.Locale]['Title_Step10'])
    returnblip = AddBlipForCoord(globalvehcoords.x, globalvehcoords.y, globalvehcoords.z)
    SetBlipSprite(returnblip, Config.Blip.delivery.id)
    SetBlipScale(returnblip, 0.9)
    SetBlipColour(returnblip, Config.Blip.delivery.color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Translation[Config.Locale]['blipname_delivery'])
    EndTextCommandSetBlipName(returnblip)
    SetBlipRoute(returnblip, true)
end

ps_vehicleblip = function()
    vehicleblip = AddBlipForEntity(vehicle)
    SetBlipSprite(vehicleblip, 227) 
    SetBlipDisplay(vehicleblip, 4)
    SetBlipScale(vehicleblip, 0.7)
    SetBlipColour(vehicleblip, 4)
    SetBlipAsShortRange(vehicleblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Translation[Config.Locale]['your_car'])
    EndTextCommandSetBlipName(vehicleblip)
    --SetBlipRoute(vehicleblip, true)
    Config.MSG(Translation[Config.Locale]['need_car'])
end

DrawTextScreen = function(text)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 200)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.010, 0.050)
end

endjob = function()
    if DoesEntityExist(vehicle) then
        TriggerServerEvent("phoenix_snowplow:bail", 'add')
    end
    DeleteVehicle(vehicle)
    DeleteEntity(snowprop)
    RemoveBlip(returnblip)
    RemoveBlip(snowblip)
    busy = false
    returncompany = false
    propspawned = false
    endstep = false
    invehicle = false
    intervall = Config.RewardTimeIntervall
    timer = 0
    try = 0
end

showPictureNotification = function(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg);
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true);
end

shownotify = function(msg)
	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

DrawText3D = function(x, y, z, text, scale)
    SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

RegisterNetEvent("phoenix_snow:notify")
AddEventHandler("phoenix_snow:notify", function(add)
    print("notify event CLIENT SEITIG")
    if add then
        Config.MSG(Translation[Config.Locale]['bail_added'])
    else 
        Config.MSG(Translation[Config.Locale]['bail_removed'])
    end
end)


RegisterNetEvent("phoenix_snow:picnotify")
AddEventHandler("phoenix_snow:picnotify", function(random)
    showPictureNotification(Translation[Config.Locale]['Picture'],  Translation[Config.Locale]['message_stepintervall']..' ~g~'..random..'$', Translation[Config.Locale]['title_stepintervall'])
end)

RegisterNetEvent("phoenix_snow:bonusnotify")
AddEventHandler("phoenix_snow:bonusnotify", function(random)
    showPictureNotification(Translation[Config.Locale]['Picture'], Translation[Config.Locale]['Mission_Complete_MSG']..' ~g~'..random..'$', Translation[Config.Locale]['Title_complete'])
end)

AddEventHandler('onResourceStop', function(ressourceName)
    if(GetCurrentResourceName() == ressourceName) then  
        endjob()
    end
end)