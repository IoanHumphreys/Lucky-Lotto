fx_version 'cerulean'
game 'gta5'

author 'Lucky Lotto'
description 'Simple QB-Core Lottery Script'
version '1.0.0'

shared_script {
    'config.lua',
    '@ox_lib/init.lua'
} 

client_script 'client/client.lua'

server_script 'server/server.lua'

dependencies {
    'qb-core',
    'qb-target',
    'ox_lib'
}

lua54 'yes'