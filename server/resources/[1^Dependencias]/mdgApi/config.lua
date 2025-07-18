Config = {}

Config.Framework = "VORP"
-- VORP, REDEM, REDEMREBOOT, QBR, RSG,  CUSTOM



if  Config.Framework == "VORP" then
    Config.FolderWithIcons = "vorp_inventory/html/img/items/"
elseif Config.Framework == "REDEM" then
    Config.FolderWithIcons = "redemrp_inventory/html/items/"
elseif Config.Framework == "REDEMREBOOT" then
    Config.FolderWithIcons = "redemrp_inventory/html/items/"
elseif Config.Framework == "QBR" then
    Config.FolderWithIcons = "qbr-inventory/html/images/"
elseif Config.Framework == "RSG" then
    Config.FolderWithIcons = "rsg-inventory/html/images/"
else
    Config.FolderWithIcons = "custom/traceToInventoryIcons/Items/"
end

--Discord hook language
Config.Language = {
    [1] = "**Info**",
    [2] = "**Name**",
    [3] = "**CharID** : ",
    [4] = "**Steam** : ",
    [5] = "**Firstname** : ",
    [6] = "**Lastname** : "
}