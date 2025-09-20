RegisterNetEvent('chat:ooc')
AddEventHandler('chat:ooc', function(id, name, message, time)
    local id1 = PlayerId()
    local id2 = GetPlayerFromServerId(id) 
    if id2 == id1 then
        TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message ooc"><i class="fa fa-globe"></i> <b><span style="color: #e1e1e1">[ OOC ] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { name..' [ '..id..' ]', message, time }
		})
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id1)), GetEntityCoords(GetPlayerPed(id2)), true) < Config.OOCDistance then
        TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message ooc"><i class="fa fa-globe"></i> <b><span style="color: #e1e1e1">[ OOC ] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { name..' [ '..id..' ]', message, time }
		})
    end
end)

-- RegisterNetEvent('chat:me')
-- AddEventHandler('chat:me', function(id, message, time)
--     local id1 = PlayerId()
--     local id2 = GetPlayerFromServerId(id) 
--     if id2 == id1 then
--         TriggerEvent('chat:addMessage', {
-- 			template = '<div class="chat-message me"><i class="fas fa-comment-dots fa-lg"></i> <b><span style="color: #e1e1e1">[ ME ] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
-- 			args = { '[ '..id..' ]', message, time }
-- 		})
--     elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id1)), GetEntityCoords(GetPlayerPed(id2)), true) < Config.MEDistance then
--         TriggerEvent('chat:addMessage', {
-- 			template = '<div class="chat-message me"><i class="fas fa-comment-dots fa-lg"></i> <b><span style="color: #e1e1e1">[ ME ] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
-- 			args = { '[ '..id..' ]', message, time }
-- 		})
--     end
-- end)

-- RegisterNetEvent('chat:do')
-- AddEventHandler('chat:do', function(id, message, time)
--     local id1 = PlayerId()
--     local id2 = GetPlayerFromServerId(id) 
--     if id2 == id1 then
--         TriggerEvent('chat:addMessage', {
-- 			template = '<div class="chat-message do"><i class="fas fa-user fa-lg"></i> <b><span style="color: #e1e1e1">[ DO ] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
-- 			args = { '[ '..id..' ]', message, time }
-- 		})
--     elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id1)), GetEntityCoords(GetPlayerPed(id2)), true) < Config.MEDistance then
--         TriggerEvent('chat:addMessage', {
-- 			template = '<div class="chat-message do"><i class="fas fa-user fa-lg"></i> <b><span style="color: #e1e1e1">[ DO ] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
-- 			args = { '[ '..id..' ]', message, time }
-- 		})
--     end
-- end)