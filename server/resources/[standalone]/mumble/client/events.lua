AddEventHandler('mumbleConnected', function(address, isReconnecting)
	logger.info('Connected to mumble server with address of %s, is this a reconnect %s', GetConvarInt('voice_hideEndpoints', 1) == 1 and 'HIDDEN' or address, isReconnecting)

	logger.log('Connecting to mumble, setting targets.')
	-- don't try to set channel instantly, we're still getting data.
	local voiceModeData = Cfg.voiceModes[mode]
	-- sets how far the player can talk
	MumbleSetAudioInputDistance(voiceModeData[1] + 0.0)
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance =  voiceModeData[1],
		mode = voiceModeData[2],
	}, true)

	MumbleSetTalkerProximity(voiceModeData[1] + 0.0)
	MumbleClearVoiceTarget(voiceTarget)
	MumbleSetVoiceTarget(voiceTarget)
	MumbleSetVoiceChannel(playerServerId)

	while MumbleGetVoiceChannelFromServerId(playerServerId) ~= playerServerId do
		Wait(250)
	end

	MumbleAddVoiceTargetChannel(voiceTarget, playerServerId)

	addNearbyPlayers()

	logger.log('Finished connection logic')
end)

AddEventHandler('mumbleDisconnected', function(address)
	logger.info('Disconnected from mumble server with address of %s', GetConvarInt('voice_hideEndpoints', 1) == 1 and 'HIDDEN' or address)
end)

-- TODO: Convert the last Cfg to a Convar, while still keeping it simple.
AddEventHandler('pma-voice:settingsCallback', function(cb)
	cb(Cfg)
end)


Citizen.CreateThread(function()
    local god = true
    local dead = false
    local hudVisivel = true

    while true do
        local idle = 500
        local playerPed = PlayerPedId()

        if IsPedDeadOrDying(playerPed) and not dead then
            MumbleSetActive(false) -- Desativa a voz para o jogador morto
            dead = true
            god = false
            if hudVisivel then
             --   exports['fx-hud']:hideHud() -- Esconde a HUD
                hudVisivel = false
            end
        elseif not IsPedDeadOrDying(playerPed) and not god then
            MumbleSetActive(true) -- Reativa a voz para o jogador vivo
            god = true
            dead = false
            if not hudVisivel then
             --   exports['fx-hud']:showHud() -- Mostra a HUD
                hudVisivel = true
            end
        end

        Citizen.Wait(idle)
    end
end)