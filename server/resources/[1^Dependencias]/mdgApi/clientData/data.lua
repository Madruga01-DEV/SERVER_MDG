
-- local mdgApi
-- TriggerEvent("getApi",function(mdgApi)
--     mdgApi = mdgApi
-- end)

exports('mdgApi',function()
    local self = {}
    self.getTarget = function()
		return mdgApi.getTarget()
	end
	self.getPromptButtonData = function(promptHash, text)
		return mdgApi.getPromptButtonData(x, y, z, dist, mark)
	end
    self.getPrompt = function(promptHash, text)
		mdgApi.getPrompt(promptHash, text)
	end
    self.drawMe = function(x, y, z, text, dist, marker)
		mdgApi.drawMe(x, y, z, text, dist, marker)
	end
    self.createPrompt = function(text, key, promptHash, holdMode)
		mdgApi.createPrompt(text, key, promptHash, holdMode)
	end
    self.getPromptButton = function(text, promptHash, hold)
		return mdgApi.getPromptButton(text, promptHash, hold)
	end
    self.playerNearCoords = function(x, y, z, dist, mark)
		return mdgApi.playerNearCoords(x, y, z, dist, mark)
	end
    self.checkPlayersNearEntity = function(entity, distance)
		return mdgApi.checkPlayersNearEntity(entity, distance)
	end
    self.createPed = function(model,x,y,z,h,dist,scenario)
        mdgApi.createPed(model,x,y,z,h,dist,scenario)
    end
	self.getLastPed = function()
		return mdgApi.getLastPed()
	end
	self.createBlip = function(text, x, y, z, sprite)
		mdgApi.createBlip(text, x, y, z, sprite)
	end
	self.notify = function(title, text, time, img)
		mdgApi.notify(title, text, time, img)
	end
	self.createVehicle = function(model, x, y, z, h)
		mdgApi.createVehicle(model, x, y, z, h)
	end
    self.getLastVehicle = function()
		return mdgApi.getLastVehicle()
	end
	self.getAllPeds = function()
		return mdgApi.getAllPeds()
	end
	self.getAllEntities = function()
		return mdgApi.getAllEntities()
	end
	self.getAllVehicles = function()
		return mdgApi.getAllVehicles()
	end
	self.playAnim = function(entity, dict, anim, flag, time)
		mdgApi.playAnim(entity, dict, anim, flag, time)
	end
	self.deleteObj = function(obj)
		mdgApi.deleteObj(obj)
	end
	self.groundCheck = function(x, y)
		return mdgApi.groundCheck(x, y)
	end
	self.getTime = function()
		return mdgApi.getTime()
	end
    return self
end)