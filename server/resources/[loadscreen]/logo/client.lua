-- mdg


RegisterCommand("logoon", function()
  Citizen.CreateThread(function()
    TriggerEvent('nui:on', true)
  end)
end)

RegisterCommand("logooff", function()
  Citizen.CreateThread(function()
      TriggerEvent("nui:off", true)
  end)
end)


RegisterNetEvent('nui:on')
AddEventHandler('nui:on', function()
  SendNUIMessage({
    type = "logo",
    display = true
  })
end)

RegisterNetEvent('nui:off')
AddEventHandler('nui:off', function()
  SendNUIMessage({
    type = "logo",
    display = false
  })
end)

--[[AddEventHandler('onClientMapStart', function()
  Citizen.CreateThread(function()
    local display = true

    TriggerEvent('logo:display', true)
  end)
end)

RegisterNetEvent('logo:display')
AddEventHandler('logo:display', function(value)
  SendNUIMessage({
    type = "logo",
    display = value
  })
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end]]