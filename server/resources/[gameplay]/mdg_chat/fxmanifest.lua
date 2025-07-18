fx_version 'adamant'

games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
ui_page 'web/ui.html'

files {
	'web/animate.min.css',
	'web/app.js',
	'web/crock.ttf',
	'web/message.js',
	'web/styles.css',
	'web/suggestions.js',
	'web/ui.html',
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
	'cl_events.lua',
}

server_scripts {
	'server.lua',
	'commands.lua',
}