----------------------------------------------------------------------------
---------------------------------- BOOSTERS --------------------------------
local god = false

local goldenCores = false
local infiniteammo = false
local NoClipActive = false
local invis = false
local T = Translation.Langs[Config.Lang]

function GODmode()
    local player = PlayerPedId()
    if not god then
        TriggerEvent('vorp:TipRight', T.Notify.switchedOn, 3000)

        -- Invencibilidade geral
        SetEntityCanBeDamaged(player, true)
        SetEntityInvincible(player, true)
        SetPlayerInvincible(player, true)

        -- Configurações de resistência
        SetPedConfigFlag(player, 2, true)  -- Sem acertos críticos
        SetPedConfigFlag(player, 430, true) -- Sem dano de queda
        SetPedConfigFlag(player, 43, true) -- Sem ataques de animais

        -- Impedir ragdoll e alvos
        SetPedCanRagdoll(player, false)
        SetPedCanBeTargetted(player, false)

        -- Outras proteções
        Citizen.InvokeNative(0x5240864E847C691C, player, false) -- Não pode ser incapacitado
        Citizen.InvokeNative(0xFD6943B6DF77E449, player, false) -- Não pode ser laçado

        -- Log de ativação
        if Config.BoosterLogs.GodMode then
            TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.GodMode, T.Webhooks.ActionBoosters.title,
                T.Webhooks.ActionBoosters.usedgod)
        end

        god = true
    else
        TriggerEvent('vorp:TipRight', T.Notify.switchedOff, 3000)

        -- Reativar dano e vulnerabilidades
        SetEntityCanBeDamaged(player, true)
        SetEntityInvincible(player, false)
        SetPlayerInvincible(PlayerId(), false)

        -- Restaurar comportamento normal do jogador
        SetPedConfigFlag(player, 2, false)
        SetPedConfigFlag(player, 430, false) -- Reativar dano de queda
        SetPedConfigFlag(player, 43, false) -- Reativar ataques de animais

        SetPedCanRagdoll(player, true)
        SetPedCanBeTargetted(player, true)

        -- Restaurar incapacitação e laço
        Citizen.InvokeNative(0x5240864E847C691C, player, true)
        Citizen.InvokeNative(0xFD6943B6DF77E449, player, true)

        god = false
    end
end


function GoldenCores()
    local player = PlayerPedId()
    if not goldenCores then
        TriggerEvent('vorp:TipRight', T.Notify.switchedOn, 3000)
        -- inner cores
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100)
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100)
        -- Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100) -- dead eye

        --outter cores
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 0, 5000.0)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 1, 5000.0)
        -- Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 2, 5000.0) -- dead eye

        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 5000.0)
        -- Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 5000.0)-- dead eye
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 5000.0)
        if Config.BoosterLogs.GoldenCores then
            TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.GoldenCores, T.Webhooks.ActionBoosters.title,
                T.Webhooks.ActionBoosters.usedgoldcores)
        end
        goldenCores = true
    else
        TriggerEvent('vorp:TipRight', T.Notify.switchedOff, 3000)
        --inner cores
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100)
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100)
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100)

        --outter cores
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 0, 0.0)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 1, 0.0)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, player, 2, 0.0)

        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 0.0)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 0.0)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 0.0)
        goldenCores = false
    end
end

function InfiAmmo()
    local player = PlayerPedId()
    local _, weaponHash = GetCurrentPedWeapon(player, false, 0, false)
    if not infiniteammo then
        infiniteammo = true
        local unarmed = -1569615261
        TriggerEvent("vorp:TipRight", T.Notify.switchedOn, 3000)
        if weaponHash == unarmed then
            TriggerEvent("vorp:Tip", T.Notify.needWeaponInHands, 3000)
        else
            SetPedInfiniteAmmo(player, true, weaponHash)
            if Config.BoosterLogs.InfiniteAmmo then
                TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.InfiniteAmmo, T.Webhooks.ActionBoosters.title,
                    T.Webhooks.ActionBoosters.usedinfinitammo)
            end
        end
    else
        infiniteammo = false
        TriggerEvent("vorp:TipRight", T.Notify.switchedOff, 3000)
        SetPedInfiniteAmmo(player, false, weaponHash)
    end
end

function Boost()
    MenuData.CloseAll()

    local elements = {
        { label = T.Menus.MainBoostOptions.selfGodMode,         value = 'god',          desc = T.Menus.MainBoostOptions.selfGodMode_desc },
        { label = T.Menus.MainBoostOptions.selfNoClip,          value = 'noclip',       desc = "<span>" .. T.Menus.MainBoostOptions.selfNoClip_desc .. "</span><br><span>" .. T.Menus.MainBoostOptions.move .. "</span><br><span>" .. T.Menus.MainBoostOptions.speedMode .. "</span><br>" .. T.Menus.MainBoostOptions.cammode .. "" },
        { label = T.Menus.MainBoostOptions.selfGoldCores,       value = 'goldcores',    desc = T.Menus.MainBoostOptions.selfGoldCores_desc },
        { label = T.Menus.MainBoostOptions.enabledInfinityAmmo, value = 'infiniteammo', desc = T.Menus.MainBoostOptions.enabledInfinityAmmo_desc },
        { label = T.Menus.MainBoostOptions.spawnWagon,          value = 'spawnwagon',   desc = T.Menus.MainBoostOptions.spawnWagon_desc },
        { label = T.Menus.MainBoostOptions.spawnHorse,          value = 'spawnhorse',   desc = T.Menus.MainBoostOptions.spawnHorse_desc },
        { label = T.Menus.MainBoostOptions.selfHeal,            value = 'selfheal',     desc = T.Menus.MainBoostOptions.selfHeal_desc },
        { label = T.Menus.MainBoostOptions.selfRevive,          value = 'selfrevive',   desc = T.Menus.MainBoostOptions.selfRevive_desc },
        { label = T.Menus.MainBoostOptions.selfInvisible,       value = 'invisibility', desc = T.Menus.MainBoostOptions.selfInvisible_desc },
        --{ label = "players blip map", value = 'playerblip', desc = "show players blip on the map" }, todo
        --{ label = "players id", value = 'showid', desc = "show players id over head", }, todo
    }

    MenuData.Open('default', GetCurrentResourceName(), 'Boost',
        {
            title    = T.Menus.DefaultsMenusTitle.menuTitle,
            subtext  = T.Menus.DefaultsMenusTitle.menuSubTitleBooster,
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu'
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == "god" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.Godmode")
                if AdminAllowed then
                    GODmode()
                end
            elseif data.current.value == "invisibility" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.Invisibility")
                if AdminAllowed then
                    if invis == false then
                        SetEntityVisible(PlayerPedId(), false)
                        invis = true
                    elseif invis == true then
                        SetEntityVisible(PlayerPedId(), true)
                        invis = false
                    end
                end
            elseif data.current.value == "goldcores" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.Golden")
                if AdminAllowed then
                    GoldenCores()
                end
            elseif data.current.value == "noclip" then
                local player = PlayerPedId()
                local AdminAllowed = IsAdminAllowed("vorp.staff.Noclip")
                if AdminAllowed then
                    if not NoClipActive then
                        SetEveryoneIgnorePlayer(PlayerId(), true)
                        SetPedCanBeTargetted(player, false)
                        NoClipActive = true
                        VORP.NotifyObjective(T.Notify.switchedOn, 5000)
                        if Config.FrozenPosition then
                            SetEntityHeading(player, GetEntityHeading(player) + 180)
                        end
                        if Config.BoosterLogs.NoClip then
                            TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.NoClip, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usednoclip)
                        end
                    else
                        SetEveryoneIgnorePlayer(PlayerId(), false)
                        SetPedCanBeTargetted(player, true)
                        NoClipActive = false
                        VORP.NotifyObjective(T.Notify.switchedOff, 5000)
                    end
                end
            elseif data.current.value == "infiniteammo" then
                local AdminAllowed = IsAdminAllowed("vorp.staff.InfiniteAmmo")
                if AdminAllowed then
                    InfiAmmo()
                end
            elseif data.current.value == "selfrevive" then
                TriggerServerEvent('vorp_admin:ReviveSelf', "vorp.staff.SelfRevive")
                if Config.BoosterLogs.SelfRevive then
                    TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.SelfRevive, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usedrevive)
                end
            elseif data.current.value == "selfheal" then
                if Config.BoosterLogs.SelfHeal then
                    TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.SelfHeal, T.Webhooks.ActionBoosters.title, T.Webhooks.ActionBoosters.usedheal)
                end
                TriggerServerEvent('vorp_admin:HealSelf', "vorp.staff.SelfHeal")
                Config.Heal.Players()
                local horse = GetMount(PlayerPedId())
                if horse ~= 0 then
                    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, 600) -- Health
                    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, 600) -- Stamina
                end
            elseif data.current.value == "spawnhorse" then
                local player = PlayerPedId()
                local AdminAllowed = IsAdminAllowed("vorp.staff.SpawnHorse")
                if AdminAllowed then
                    local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm, T.Menus.MainBoostOptions.SpawnHorseInput.placeholder, T.Menus.MainBoostOptions.SpawnHorseInput.title, "text", T.Menus.MainBoostOptions.SpawnHorseInput.errorMsg, "[A-Za-z0-9_ \\-]{5,60}")
                    MenuData.CloseAll()
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                        local horse = tostring(result)
                        local playerCoords = GetEntityCoords(player) + 1
                        if horse ~= "" then
                            RequestModel(horse, false)
                            repeat Wait(0) until HasModelLoaded(horse)
                            local horse = CreatePed(joaat(horse), playerCoords.x, playerCoords.y, playerCoords.z, 0.0, true, true, false, false)
                            repeat Wait(0) until DoesEntityExist(horse)
                            Citizen.InvokeNative(0x77FF8D35EEC6BBC4, horse, 1, 0)
                            Citizen.InvokeNative(0x028F76B6E78246EB, player, horse, -1, true)
                            if Config.BoosterLogs.SelfSpawnHorse then
                                TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.SelfSpawnHorse, T.Webhooks.ActionBoosters.title, "Horse: " .. horse)
                            end
                        else
                            VORP.NotifyObjective(T.Notify.empty, 3000)
                        end
                    end)
                end
            elseif data.current.value == "spawnwagon" then
                local player = PlayerPedId()
                local AdminAllowed = IsAdminAllowed("vorp.staff.SpawnWagon")
                if AdminAllowed then
                    local myInput = Inputs("input", T.Menus.DefaultsInputs.confirm,
                        T.Menus.MainBoostOptions.SpawnWagonInput.placeholder,
                        T.Menus.MainBoostOptions.SpawnWagonInput.title, "text",
                        T.Menus.MainBoostOptions.SpawnWagonInput.errorMsg, "[A-Za-z0-9_ \\-]{5,60}")
                    MenuData.CloseAll()
                    TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                        local wagon = result
                        local playerCoords = GetEntityCoords(player)
                        if wagon ~= "" then
                            RequestModel(wagon, false)
                            while not HasModelLoaded(wagon) do
                                Wait(10)
                            end
                            wagon = CreateVehicle(wagon, playerCoords.x, playerCoords.y, playerCoords.z, 0, true, true, false, false)
                            repeat Wait(0) until DoesEntityExist(wagon)
                            Citizen.InvokeNative(0x77FF8D35EEC6BBC4, wagon, 1, 0)
                            SetPedIntoVehicle(player, wagon, -1)
                            if Config.BoosterLogs.SelfSpawnWagon then
                                TriggerServerEvent("vorp_admin:logs", Config.BoosterLogs.SelfSpawnWagon, T.Webhooks.ActionBoosters.title, "Wagon: " .. wagon)
                            end
                        else
                            VORP.NotifyObjective(T.Notify.empty, 3000)
                        end
                    end)
                end
            end
        end,

        function(menu)
            menu.close()
        end)
end

local function DisableControls()
    DisableControlAction(0, 0xB238FE0B, true) --disable controls here
    DisableControlAction(0, 0x3C0A40F2, true) --disable controls here
end


local Prompt1
local Prompt2
local Prompt4
local Prompt6
local PromptGroup = GetRandomIntInRange(0, 0xffffff)

--PROMPTS
--[[CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession

    local str = T.Menus.MainBoostOptions.Prompts.down .. "/" .. T.Menus.MainBoostOptions.Prompts.up
    Prompt1 = PromptRegisterBegin()
    PromptSetControlAction(Prompt1, Config.Controls.goDown)
    PromptSetControlAction(Prompt1, Config.Controls.goUp)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(Prompt1, str)
    PromptSetEnabled(Prompt1, 1)
    PromptSetVisible(Prompt1, 1)
    PromptSetStandardMode(Prompt1, 1)
    PromptSetGroup(Prompt1, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, Prompt1, true)
    PromptRegisterEnd(Prompt1)

    local str = T.Menus.MainBoostOptions.Prompts.speed
    Prompt2 = PromptRegisterBegin()
    PromptSetControlAction(Prompt2, Config.Controls.changeSpeed) -- shift
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(Prompt2, str)
    PromptSetEnabled(Prompt2, 1)
    PromptSetVisible(Prompt2, 1)
    PromptSetStandardMode(Prompt2, 1)
    PromptSetGroup(Prompt2, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, Prompt2, true)
    PromptRegisterEnd(Prompt2)

    local str = T.Menus.MainBoostOptions.Prompts.backward .. "/" .. T.Menus.MainBoostOptions.Prompts.forward
    Prompt4 = PromptRegisterBegin()
    PromptSetControlAction(Prompt4, Config.Controls.goBackward)
    PromptSetControlAction(Prompt4, Config.Controls.goForward)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(Prompt4, str)
    PromptSetEnabled(Prompt4, 1)
    PromptSetVisible(Prompt4, 1)
    PromptSetStandardMode(Prompt4, 1)
    PromptSetGroup(Prompt4, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, Prompt4, true)
    PromptRegisterEnd(Prompt4)

    local str = T.Menus.MainBoostOptions.Prompts.cancel
    Prompt6 = PromptRegisterBegin()
    PromptSetControlAction(Prompt6, Config.Controls.Cancel)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(Prompt6, str)
    PromptSetEnabled(Prompt6, 1)
    PromptSetVisible(Prompt6, 1)
    PromptSetStandardMode(Prompt6, 1)
    PromptSetGroup(Prompt6, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, Prompt6, true)
    PromptRegisterEnd(Prompt6)
end)]]--


RegisterCommand("noclip", function(source, args, rawCommand)
    NoClipActive = not NoClipActive
    if NoClipActive then
        -- print("NoClip ativado")
    else
      --  print("NoClip desativado")
    end
end, false)

Citizen.CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession
    local player = PlayerPedId()
    local index = 1
    local CurrentSpeed = Config.Speeds[index].speed
    local FollowCamMode = true
    local Label = Config.Speeds[index].label

    while true do
        local sleep = 1000

        while NoClipActive do
            sleep = 0
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                player = GetVehiclePedIsIn(PlayerPedId(), false)
            else
                player = PlayerPedId()
            end

            local xoff = 0.0
            local yoff = 0.0
            local zoff = 0.0

            DisableControls()

            if IsDisabledControlJustPressed(1, Config.Controls.camMode) then
                FollowCamMode = not FollowCamMode
            end

            local label = CreateVarString(10, 'LITERAL_STRING', T.Menus.MainBoostOptions.Prompts.speed_desc .. Label .. " " .. CurrentSpeed)
            PromptSetActiveGroupThisFrame(PromptGroup, label)

            if IsDisabledControlJustPressed(1, Config.Controls.changeSpeed) then
                if index ~= #Config.Speeds then
                    index = index + 1
                    CurrentSpeed = Config.Speeds[index].speed
                    Label = Config.Speeds[index].label
                else
                    CurrentSpeed = Config.Speeds[1].speed
                    index = 1
                    Label = Config.Speeds[index].label
                end
            end

            if IsDisabledControlPressed(0, Config.Controls.goForward) then
                yoff = -Config.Offsets.y 
            end
            if IsDisabledControlPressed(0, Config.Controls.goBackward) then
                yoff = Config.Offsets.y 
            end

            if IsDisabledControlPressed(0, Config.Controls.goRight) then
                xoff = -Config.Offsets.y 
            end
            if IsDisabledControlPressed(0, Config.Controls.goLeft) then
                xoff = Config.Offsets.y 
            end

            if IsDisabledControlPressed(0, Config.Controls.goUp) then
                zoff = Config.Offsets.z
            end
            if IsDisabledControlPressed(0, Config.Controls.goDown) then
                zoff = -Config.Offsets.z
            end

            if IsDisabledControlPressed(0, Config.Controls.Cancel) then
                SetEveryoneIgnorePlayer(PlayerId(), false)
                SetPedCanBeTargetted(player, true)
                NoClipActive = false
                break
            end

            local speedMultiplier = (CurrentSpeed + 0.3)
            local newPos = GetOffsetFromEntityInWorldCoords(player, xoff * speedMultiplier, yoff * speedMultiplier, zoff * speedMultiplier)

            local heading = GetEntityHeading(player)
            SetEntityVelocity(player, 0.0, 0.0, 0.0)

            if Config.FrozenPosition then
                SetEntityRotation(player, 0.0, 0.0, 180.0, 0, false)
            else
                SetEntityRotation(player, 0.0, 0.0, 0.0, 0, false)
            end

            if (FollowCamMode) then
                SetEntityHeading(player, GetGameplayCamRelativeHeading())
            else
                SetEntityHeading(player, heading)
            end

            SetEntityCoordsNoOffset(player, newPos.x, newPos.y, newPos.z, false, false, false)

            SetEntityAlpha(player, 51, false)
            if (player ~= PlayerPedId()) then
                SetEntityAlpha(PlayerPedId(), 51, false)
            end

            SetEntityCollision(player, false, false)
            FreezeEntityPosition(player, true)
            SetEntityInvincible(player, true)
            SetEntityVisible(player, false)
            SetEveryoneIgnorePlayer(PlayerPedId(), true)
            SetPedCanBeTargetted(player, false)

            Wait(0)

            ResetEntityAlpha(player)
            if (player ~= PlayerPedId()) then
                ResetEntityAlpha(PlayerPedId())
            end

            SetEntityCollision(player, true, true)
            FreezeEntityPosition(player, false)
            SetEntityInvincible(player, false)
            SetEntityVisible(player, true)
            SetEveryoneIgnorePlayer(PlayerPedId(), false)
            SetPedCanBeTargetted(player, true)
        end
        Wait(sleep)
    end
end)







