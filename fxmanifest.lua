fx_version 'adamant'
games { 'rdr3', 'gta5' }

shared_script "core/shared.lua"
shared_script "@drp_core/managers/networkcallbacks.lua"

client_scripts {
	'_configs/cfg_general.lua',
	'core/client/cl_functions.lua',
	'core/client/cl_robbery.lua'
}

server_scripts {
	'_configs/cfg_general.lua',
	'core/server/sv_robbery.lua'
}
