resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Scoreboard by Łysy#0126'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_script 'client/main.lua'

ui_page 'html/scoreboard.html'

files {
	'html/listener.js',
	'html/style.css',
	'html/scoreboard.html',
	'html/img/EMS.png',
	'html/img/LSPD.png',
	'html/img/LSC.png',
	'html/img/DOJ.png'
}

client_script '@esx_bratva1/client/functions.lua'

client_script '@esx_cocaina/client/main.lua'