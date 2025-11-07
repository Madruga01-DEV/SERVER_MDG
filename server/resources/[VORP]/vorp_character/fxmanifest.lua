fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'


name 'vorp character'
author 'FIX : MDG'
authorFIX "Madruga Dev"
description 'A Character creator with also shops built in for vorpcore framework '

shared_scripts {
	'config.lua',
	'config_shops.lua',
	'shared/utils.lua',
	'shared/translation.lua',
}

client_scripts {
	'@vorp_core/client/dataview.lua',
	'shared/clothing.lua',
	'shared/hairs.lua',
	'client/*.lua',
}

server_scripts {
	'logs.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

files {
	'images/*png',
	'images/clothingfemale/*png',
	'images/eyes/*png',
	'images/skin/*png',
}

