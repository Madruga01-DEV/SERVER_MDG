local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

if Config.AllowPlayersToClearTheirChat then
	RegisterCommand(Config.ClearChatCommand, function(source, args, rawCommand)
		TriggerClientEvent('chat:client:ClearChat', source)
	end)
end

if Config.AllowStaffsToClearEveryonesChat then
	RegisterCommand(Config.ClearEveryonesChatCommand, function(source, args, rawCommand)
		local time = os.date(Config.DateFormat)
		
		local User = VorpCore.getUser(source)
		local Character = User.getUsedCharacter
		local admingroup = Character.group
		
		if isAdmin(admingroup) then
			TriggerClientEvent('chat:client:ClearChat', -1)
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">The chat has been cleared!</div></div>',
				args = { time }
			})			
		end
	end)
end

if Config.EnableOOCCommand then
	RegisterCommand(Config.OOCCommand, function(source, args, rawCommand)
		local length = string.len(Config.OOCCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(Config.DateFormat)
		local playerName = GetPlayerName(source)
		TriggerClientEvent('chat:ooc', -1, source, playerName, message, time)
	end)
end

function isAdmin(admingroup)
	for k,v in ipairs(Config.StaffGroups) do
		if admingroup == v then 
			return true 
		end
	end
	return false
end

function isJob(group)
	for k,v in ipairs(Config.JobGroups) do
		if group == v then 
			return true 
		end
	end
	return false
end

RegisterCommand(Config.JobCommand,function(source,Message,History)
	local time = os.date(Config.DateFormat)
	local User = VorpCore.getUser(source)
	local Character = User.getUsedCharacter
	local group = Character.job
	local playerName = GetPlayerName(source)

	if isJob(group) then
		if group == "medic" then
			TriggerClientEvent('chat:addMessage',source, {
				template = '<div class="chat-message ooc"><i class="fa fa-bell" style="color: #F7DC6F"></i> <b><span style="color: #F7DC6F">[ Medico ] {0}</span>&nbsp;<span style="font-size: 14px; color: #F7DC6F;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName..' [ '..source..' ]', History:sub(9), time }
			})
		elseif group == "sheriff" then
			TriggerClientEvent('chat:addMessage',source, {
				template = '<div class="chat-message ooc"><i class="fa fa-hammer" style="color: #F4D03F"></i> <b><span style="color: #F4D03F">[ Doctor ] {0}</span>&nbsp;<span style="font-size: 14px; color: #F4D03F;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName..' [ '..source..' ]', History:sub(9), time }
			})
		else
			TriggerClientEvent('chat:addMessage',source, {
				template = '<div class="chat-message ooc"><i class="fa fa-bullhorn" style="color: #E74C3C"></i> <b><span style="color: #E74C3C">[ Anuncio ] {0}</span>&nbsp;<span style="font-size: 14px; color: #E74C3C;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName..' [ '..source..' ]', History:sub(9), time }
			})
		end
	end
end)