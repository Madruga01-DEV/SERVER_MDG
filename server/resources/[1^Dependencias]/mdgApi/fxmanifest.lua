fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

lua54 "yes"
autor 'Madruga Dev'
description 'MenuApi'
version '0.0.2'

server_scripts {
    'config.lua',
	'serverData/serverCompCustom.lua',
	'serverData/serverCompGum.lua',
	'serverData/serverCompRedEM.lua',
	'serverData/serverCompRedEMReboot.lua',
	'serverData/serverCompQBR.lua',
	'serverData/serverCompRSG.lua',
	'serverData/serverCompVorp.lua',
}

client_scripts {
    'config.lua',
	'clientData/data.lua', 
	'clientData/client.lua',

}

export 'mdgApi'

ui_page 'html/index.html'

files {
    'html/index.js',
    'html/index.css',
    'html/index.html',
    'html/crock.ttf',
    'html/images/*.png',
}

escrow_ignore {
	'clientData/data.lua', 
	'clientData/client.lua',
	'serverData/serverCompCustom.lua',
	'serverData/serverCompGum.lua',
	'serverData/serverCompRedEM.lua',
	'serverData/serverCompRedEMReboot.lua',
	'serverData/serverCompQBR.lua',
	'serverData/serverCompRSG.lua',
	'serverData/serverCompVorp.lua',
	'html/index.js',
    'html/index.css',
    'html/index.html',
    'html/crock.ttf',
    'html/images/*.png',
}