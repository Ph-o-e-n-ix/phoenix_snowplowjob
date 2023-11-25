fx_version 'adamant'

games { 'gta5' }

script_author 'Phoenix Studios'
description 'Phoenix SnowPlow Job V2'

shared_scripts {
	'config.lua',
	'@es_extended/locale.lua' -- Disable if you using QB
}

server_scripts {
	'server.lua',
	'svconfig.lua',
	'config.lua'
}

client_scripts {
	'client.lua',
	'config.lua',
}