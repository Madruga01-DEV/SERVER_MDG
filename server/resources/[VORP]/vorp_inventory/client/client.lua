-- if Config.DevMode then
    AddEventHandler('onClientResourceStart', function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        if Config.DevMode then
            print('loading resource ^1DEV MODE IS ENABLED')
        end
        SetNuiFocus(false, false)
        SendNUIMessage({ action = "hide" })
        TriggerServerEvent("DEV:loadweapons")
        if Config.DevMode then
            print("Loading Inventory")
        end
        TriggerServerEvent("vorpinventory:getItemsTable")
        Wait(1000)
        TriggerServerEvent("vorpinventory:getInventory")
        Wait(1000)
        TriggerServerEvent("vorpCore:LoadAllAmmo")
        if Config.DevMode then
            print("inventory loaded")
        end
        Wait(100)
        TriggerEvent("vorpinventory:loaded")
    end)
-- end


CreateThread(function()
    if not Config.UseLanternPutOnBelt then
        return
    end

    repeat Wait(2000) until LocalPlayer.state.IsInSession

    local function checkLanterns(hash)
        local lanterns <const> = { "WEAPON_MELEE_LANTERN", "WEAPON_MELEE_LANTERN_HALLOWEEN", "WEAPON_MELEE_DAVY_LANTERN", "WEAPON_MELEE_LANTERN_ELECTRIC" }
        for i = 1, #lanterns do
            if hash == joaat(lanterns[i]) then
                return true
            end
        end
        return false
    end
    local lastLantern = 0
    while true do
        local weaponHeld = GetPedCurrentHeldWeapon(PlayerPedId())
        local isLantern = IsWeaponLantern(weaponHeld) == 1 or IsWeaponLantern(weaponHeld) == true
        if isLantern then
            lastLantern = weaponHeld
        end

        if lastLantern ~= 0 and not checkLanterns(weaponHeld) then
            SetCurrentPedWeapon(PlayerPedId(), lastLantern, true, 12, false, false)
            lastLantern = 0
        end
        Wait(1000)
    end
end)
RegisterNUICallback('closeGiveMenu',function()
    onGiveMenu = false
    SendNUIMessage({action='closeGiveMenu'})
end)
RegisterNUICallback('GetNearPlayers2', function(obj)
    onGiveMenu = true
    local nuiReturn = {}
	local itemId = obj.id or 0
	local itemCount = obj.count or 1
	local itemHash = obj.hash or 1


	nuiReturn.action = "nearPlayers"
	nuiReturn.item = nuiReturn.item or obj.item
	nuiReturn.hash = itemHash
	nuiReturn.count = itemCount
	nuiReturn.id = itemId
	nuiReturn.type = obj.type
	nuiReturn.what = nuiReturn.what or obj.what

	SendNUIMessage(nuiReturn)
    Citizen.CreateThread(function()
        while onGiveMenu do
            local players = GetActivePlayers()
            local array = {}
            for k,v in pairs(players) do
                local plyCoords = GetEntityCoords(GetPlayerPed(v))
                local dist = #(plyCoords - GetEntityCoords(PlayerPedId()))
                if dist < 10 and GetPlayerServerId(v) ~= GetPlayerServerId(PlayerId()) then
                    local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(plyCoords.x, plyCoords.y, plyCoords.z)
                    if onScreen then
                        array[#array+1] = {x = screenX,y = screenY,playerid=GetPlayerServerId(v)}
                    end
                end
            end
            SendNUIMessage({
                action = "setPlayerIDS",
                array = array,
            })
            Wait(1000)
        end
    end)
    Wait(10000)
    onGiveMenu = false
    SendNUIMessage({action='closeGiveMenu'})
end)

RegisterNUICallback('sendTrade',function()
    TriggerEvent('fx-trade:client:playerSeleciton')
end)