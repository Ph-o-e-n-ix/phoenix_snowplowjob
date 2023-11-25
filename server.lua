if Config.Framework.ESX then
	if Config.UseNewESX then 
		ESX = exports["es_extended"]:getSharedObject()
	else 
		local ESX = nil
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
	end
elseif Config.Framework.QBCore then 
	QBCore = exports['qb-core']:GetCoreObject()
end


RegisterServerEvent("phoenix_snowplow:bail")
AddEventHandler("phoenix_snowplow:bail", function(addremove) 
	local add = false
	if Config.Framework.ESX then
		local xPlayer = ESX.GetPlayerFromId(source)
		if addremove == 'remove' then
			xPlayer.removeAccountMoney(svConfig.Account, svConfig.Bail)
		elseif addremove == 'add' then 
			xPlayer.addAccountMoney(svConfig.Account, svConfig.Bail)
			add = true
		else 
			print("Event 'phoenix_snowplow:bail' didnt worked. For help discord.phoenix-studios.de")
		end
		
	elseif Config.Framework.QBCore then 
		local Player = QBCore.Functions.GetPlayer(source)
		if addremove == 'remove' then
			Player.Functions.RemoveMoney(svConfig.Account, svConfig.Bail)
		elseif addremove == 'add' then 
			Player.Functions.AddMoney(svConfig.Account, svConfig.Bail)
			add = true
		else 
			print("Event 'phoenix_snowplow:bail' didnt worked. For help discord.phoenix-studios.de")
		end
	end
	TriggerClientEvent("phoenix_snow:notify", source, add)
end)

RegisterServerEvent("phoenix:addmoney")
AddEventHandler("phoenix:addmoney", function() 
	local random = math.random(svConfig.Reward.min, svConfig.Reward.max)
	if Config.Framework.ESX then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.addAccountMoney(svConfig.Account, random)
	elseif Config.Framework.QBCore then 
		local Player = QBCore.Functions.GetPlayer(source)
		Player.Functions.AddMoney(svConfig.Account, random)
	end
	phoenixsnow_sendwebhook(random)
	TriggerClientEvent("phoenix_snow:bonusnotify", source, random)
end)

RegisterServerEvent("phoenix:addmoneyintervall")
AddEventHandler("phoenix:addmoneyintervall", function(random) 
	local random = math.random(svConfig.Intervall.min, svConfig.Intervall.max)
	if Config.Framework.ESX then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.addAccountMoney(svConfig.Account, random)
	elseif Config.Framework.QBCore then 
		local Player = QBCore.Functions.GetPlayer(source)
		Player.Functions.AddMoney(svConfig.Account, random)
	end
	TriggerClientEvent("phoenix_snow:picnotify", source, random)
end)

phoenixsnow_sendwebhook = function(money)
	if Config.Framework.ESX then
    	local xPlayer = ESX.GetPlayerFromId(source)
	elseif Config.Framework.QBCore then 
		local Player = QBCore.Functions.GetPlayer(source)
	end
	local information = {
		{
			["color"] = '6684876',
			["author"] = {
				["icon_url"] = 'https://i.imgur.com/oBjCx4T.png',
				["name"] = 'PHOENIX STUDIOS',
			},
			["title"] = 'SnowPlow Job',
			["description"] = '' ..GetPlayerName(source)..' '..Translation[Config.Locale]['webhook_message']..' '..money..'$',

			["footer"] = {
				["text"] = os.date('%d/%m/%Y [%X]'),
			}
		}
		
	}
	PerformHttpRequest(svConfig.Webhook, function(err, text, headers) end, 'POST', json.encode({username = 'Phoenix Studios', embeds = information, avatar_url = 'https://i.imgur.com/oBjCx4T.png' }), {['Content-Type'] = 'application/json'})
end