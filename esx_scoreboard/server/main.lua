ESX = nil
local connectedPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	RefreshScoreboard()
end)




AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	RefreshScoreboard()
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil

	RefreshScoreboard()
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		RefreshScoreboard()
	end
end)

function RefreshScoreboard()
	connectedPlayers = {}

	local players = GetPlayers()

	for _, playerId in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		connectedPlayers[playerId] = {}
		connectedPlayers[playerId].ping = 0
		connectedPlayers[playerId].id = playerId
		connectedPlayers[playerId].name = ''
		connectedPlayers[playerId].job = {}
		connectedPlayers[playerId].job.name = ''
		connectedPlayers[playerId].job2 = {}
		connectedPlayers[playerId].job2.name = ''

		if (xPlayer ~= nil) then
			connectedPlayers[playerId].job = xPlayer.job
			connectedPlayers[playerId].job2 = xPlayer.job2
		end
	end

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end

function AddPlayersToScoreboard()
	RefreshScoreboard()
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end

TriggerEvent('es:addGroupCommand', 'screfresh', 'admin', function(source, args, user)
	AddPlayersToScoreboard()
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'brak permisji.' } })
end, {help = 'Refresh esx_scoreboard names!'})

TriggerEvent('es:addGroupCommand', 'sctoggle', 'admin', function(source, args, user)
	TriggerClientEvent('lysy_scoreboard:toggleID', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'brak permisji.' } })
end, {help = 'Toggle ID column on the scoreboard!'})