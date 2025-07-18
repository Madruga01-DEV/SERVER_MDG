RegisterNetEvent('mdg_left')
AddEventHandler('mdg_left', function(t1, t2, dict, txtr, timer)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if txtr ~= nil then
        exports.mdg_notify.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    else
        local txtr = "tick"
        exports.mdg_notify.LeftNot(0, tostring(t1), tostring(t2), tostring(dict), tostring(txtr), tonumber(timer))
    end
end)

RegisterNetEvent('mdg_right')
AddEventHandler('mdg_right', function(text, dict, icon, text_color, duration)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(5)
        end
    end
    if icon ~= nil then
        exports.mdg_notify.RightNot(0, text, dict, icon, text_color, duration)
    else
        local icon = "tick"
        exports.mdg_notify.RightNot(0, text, dict, icon, text_color, duration)
    end
end)