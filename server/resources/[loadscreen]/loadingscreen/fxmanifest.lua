fx_version 'cerulean'
game "rdr3"

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

lua54 'yes'

loadscreen_manual_shutdown "yes"
loadscreen 'html/index.html'
loadscreen_cursor "yes"

client_script "client.lua"

files {
    'html/video.mp4',
    'html/index.html',
    'html/config.js',
    'html/assets/js/jquery.min.js',
    'html/assets/js/script.js'
}
