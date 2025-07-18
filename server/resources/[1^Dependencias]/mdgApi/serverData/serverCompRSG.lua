if Config.Framework == "RSG" then
    ------ DONT REMOVE ------
    local apiSrv = {}
    RegisterServerEvent('getApi')
    AddEventHandler('getApi', function(cb)
        cb(apiSrv)
    end)
    ------ DONT REMOVE ------







    

    ---EDIT THIS PART
    local RSGCore = exports['rsg-core']:GetCoreObject()
	TriggerEvent("getCore",function(core)
        RSGCore = core
    end)
	
   Inventory = RSGCore.Player.LoadInventory

   function apiSrv.registerItem(itemId, callback)
        if type(itemId) == "string" or type(itemId) == "number" then
            RSGCore.Functions.CreateUseableItem(itemId, function(source, item)
                callback(source, item)
            end)
        end
    end


    function apiSrv.notify(source, title, message, image, time)
        TriggerClientEvent('RSGCore:Notify', source, message, 'success')
    end

    function apiSrv.CharacterTable()
        return "players"--Database characters
    end

    function apiSrv.JobColumn()
        return "job"--Job column in characters
    end

    function apiSrv.JobGradeColumn()
        return "jobgrade"--Jobgrade column in characters
    end

    function apiSrv.SteamColumn()
        return "license"--Steam identifier column in characters
    end

    function apiSrv.CharIdColumn()
        return "cid"--Char identifier column in characters
    end
    function apiSrv.getFramework()
        return "rsg"
    end
    function apiSrv.getInformation(source, cb)
        local _source = source
        local User = RSGCore.Functions.GetPlayer(_source) 
        if User then
            local player = {}
            player.getGroup = function()
                if RSGCore.Functions.HasPermission(_source, 'admin') then
                     return 'admin'
                end
            end
            player.getFirstname = function() return
                User.PlayerData.charinfo.firstname
            end 
            player.getLastname = function() return
                User.PlayerData.charinfo.lastname
            end 
            player.getSteamIdentifier = function() return
                User.PlayerData.license
            end 
            player.getCharIdentifier = function() return
                User.PlayerData.cid
			end	
            player.getMoney = function() return--Get Money
               User.PlayerData.money['cash']
            end
            player.getGold = function() return--Get Gold
               User.PlayerData.gold
            end
            player.getJob = function() return--Get Job
                 User.PlayerData.job.name
            end
            player.getGrade = function() return
                User.PlayerData.job.grade.level
            end
            player.getCountItem = function(id)
                if User.Functions.GetItemByName(id) == nil then
                    return 0
                else
                    local amountitem = User.Functions.GetItemByName(id).amount
                    return amountitem
                end
            end
            player.removeMoney = function(amount)
                User.Functions.RemoveMoney('cash', amount)
            end
            player.addMoney = function(amount)
                User.Functions.AddMoney('cash', amount)
            end
            player.setJob = function(job, grade, arg)
                User.PlayerData.job.name = job
                self.PlayerData.job.grade.name = grade
                self.PlayerData.job.grade.level = grade
            end
            player.setGrade = function(amount)
                self.PlayerData.job.grade.name = amount
                self.PlayerData.job.grade.level = amount
            end
            player.removeGold = function(amount)
                -- Character.removeCurrency(_source, 1, amount)
            end
            player.addGold = function(amount)
                -- Character.addCurrency(_source, 1, amount)
            end
            player.removeItem = function(id, amount)
                User.Functions.RemoveItem(id, amount)
            end
            player.removeItemId = function(id, amount)
                -- Inventory.subItemByID(_source, id, amount)
            end
            player.addItem = function(id, amount, metadata)
                User.Functions.AddItem(id, amount)
            end
            player.chanceSkin = function(skin)
                -- Character.changeSkin(_source, json.decode(skin))
            end
            player.createStorage = function(id, size)
                TriggerClientEvent("mdgApi:createStash", _source, id, size)
            end
            player.openStorage = function(id, size)
                TriggerClientEvent("mdgApi:openStash", _source, id, size)
            end
            player.updateStorage = function(id, size)
            end
            player.canCarryItem = function(id, count)
                local canCarry = true
                -- TriggerEvent("gumCore:canCarryItem", tonumber(_source), id, tonumber(count), function(canCarry1)
                --     canCarry = canCarry1
                -- end)
                return canCarry
            end
            player.canCarryWeapon = function(count)
                local canCarry = true
                -- TriggerEvent("gumCore:canCarryWeapons", tonumber(_source), tonumber(count), function(canCarry1)
                --    canCarry = canCarry1
                -- end)
                return canCarry
            end
            player.createWeapon = function(weapon, ammo)
                Inventory.createWeapon(tonumber(_source), weapon, ammo)
            end
            player.closeInv = function()
                TriggerClientEvent("gum_inventory:CloseInv", tonumber(_source))
            end
            player.discord = function(webhookLink, imageUrl, description, color, steamHex, charIdentifier, firstName, lastName)
                sendDiscordMessage(webhookLink, imageUrl, description, color, steamHex, charIdentifier, firstName, lastName)
            end
            player.getMetadata = function(id)
                local itemId = Inventory.getLastUsedID(_source)
                local typeMeta = Inventory.getMetaTypeById(_source, itemId, id)
                return typeMeta, itemId
            end
            cb(player)
        else
            cb(nil)
        end
    end

    function sendDiscordMessage(webhookLink, title, descriptionsString, color, steamHex, charIdentifier, firstName, lastName)
        local cleanSteamHex = string.sub(steamHex, 7)

        local footer = ""
        for i, line in ipairs(descriptionsString) do
            footer = footer .. line .. "\n"
        end
        local embed = {
            {
                ["color"] = color,
                ["title"] = title,
                ["description"] = footer,
                ["fields"] = {
                    {
                        ["name"] = ""..Config.Language[1].."",
                        ["value"] = ""..Config.Language[4]..""..cleanSteamHex.."\n"..Config.Language[3]..""..charIdentifier,
                        ["inline"] = true
                    },
                    {
                        ["name"] = ""..Config.Language[2].."",
                        ["value"] = ""..Config.Language[5]..""..firstName.."\n"..Config.Language[6]..""..lastName,
                        ["inline"] = true
                    }
                }
            }
        }
        PerformHttpRequest(""..webhookLink.."", function(err, text, headers) end, 'POST', json.encode({username = "Pets", embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end