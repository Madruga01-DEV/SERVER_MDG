fx_version "adamant"

games { 'rdr3'}

lua54 "yes"
autor 'Madruga Dev'
description 'Hud 01'
version '0.0.2'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


ui_page 'ui/index.html'
files {
  'ui/index.html',
  'ui/style.css',
  'ui/img/logo.png',
  'ui/script.js'
}

client_script "client.lua"

escrow_ignore {
	'ui/index.html',
  'ui/style.css',
  'ui/img/logo.png',
  'ui/script.js'
}