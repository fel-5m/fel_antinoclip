fx_version 'cerulean'
games {'gta5' }
lua54 'yes'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
    'config/sv_*.lua'
}

shared_scripts {
    'config/sh_*.lua',
}
