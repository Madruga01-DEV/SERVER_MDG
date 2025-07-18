Config = {}

-- DateFormat
Config.DateFormat = '%H:%M'

-- Staff Groups for chat commands/
Config.StaffGroups = {
	'superadmin',  -- Set the group in your "characters" database for VORP CORE
	'admin',  -- Set the group in your "characters" database for VORP CORE
	'moderator',  -- Set the group in your "characters" database for VORP CORE
}

-- Job Groups for chat commands/
Config.JobGroups = {
	'ferreiro',  -- Set the group in your "characters" database for VORP CORE
	'sallon',  -- Set the group in your "characters" database for VORP CORE
	'Doctor',  -- Set the group in your "characters" database for VORP CORE
	'sheriff',
}

Config.AllowStaffsToClearEveryonesChat = true
Config.ClearEveryonesChatCommand = 'cchatall'

-- Everyone Commands
Config.AllowPlayersToClearTheirChat = true
Config.ClearChatCommand = 'cchat'

-- OOC Command
Config.EnableOOCCommand = true
Config.OOCCommand = 'ooc'
Config.OOCDistance = 99999999999999.0

-- JOB Command
Config.JobCommand = 'ad'

-- /ME AND /DO Distance -- For this command u need to add on server "3ddo" and "3dme" plugins.
Config.MEDistance = 5.0