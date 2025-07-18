RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:server:ClearChat')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
	if not message or not author then
		return
	end

	TriggerEvent('chatMessage', source, author, message)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, author, {255, 255, 255}, message)
	end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
	local name = GetPlayerName(source)

	TriggerEvent('chatMessage', source, name, '/' .. command)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, name, {255, 255, 255}, '/' .. command) 
	end

	CancelEvent()
end)

local function refreshCommands(player)
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()

		local suggestions = {}

		for _, command in ipairs(registeredCommands) do
			if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
				table.insert(suggestions, {
					name = '/' .. command.name,
					help = ''
				})
			end
		end

		TriggerClientEvent('chat:addSuggestions', player, suggestions)
	end
end

AddEventHandler('onServerResourceStart', function(resName)
	Wait(500)

	for _, player in ipairs(GetPlayers()) do
		refreshCommands(player)
	end
end)

AddEventHandler("chatMessage", function(source, color, message)
	local src = source
	args = stringsplit(message, " ")
	CancelEvent()
	if string.find(args[1], "/") then
		local cmd = args[1]
		table.remove(args, 1)
	end
end)

commands = {}
commandSuggestions = {}

function starts_with(str, start)
	return str:sub(1, #start) == start
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end




























--
Citizen.CreateThread(function()
	if GetCurrentResourceName() ~= "VLT_chat" then -- There will be problems with the script if the name is changed...
		print("^1=====================================")
		print("^1NOME DO SCRIPT DIFERENTE DO ORIGINAL")
		print("^1HAVERÁ/PODERÁ HAVER PROBLEMAS COM O SCRIPT SE O NOME FOR ALTERADO")
		print("^1MUDAR NOME PARA: ^VLT_chat^1")
		print("^1=====================================^0")
	end
end)
--
--
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	print('^6 '..resourceName..'^2 Carregado com sucesso ^7')
	print('^1 Desenvolvido por VLT ^7')
	print('^7 Se você tiver alguma dúvida ou precisar de suporte, junte-se:^5 https://discord.gg/ueDwVpvnyv ^7')
end)
--