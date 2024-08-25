local ESX = nil
local ESX = exports.es_extended:getSharedObject()
local RNE = RegisterNetEvent


local function sendToDiscord(playerId, playerName, playerSteamId, playerIdentifier, playerPing, imageUrl)
    local embed = {
        {
            ["title"] = "Alerte de comportement suspect",
            ["color"] = 15158332,
            ["fields"] = {
                {
                    ["name"] = "ID du joueur",
                    ["value"] = "```" .. tostring(playerId) .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "Nom Steam",
                    ["value"] = "```" .. (playerName or "Inconnu") .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "Steam ID",
                    ["value"] = "```" .. (playerSteamId or "Inconnu") .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "Identifier",
                    ["value"] = "```" .. (playerIdentifier or "Inconnu") .. "```",
                    ["inline"] = false
                },
                {
                    ["name"] = "Ping",
                    ["value"] = "```" .. tostring(playerPing) .. " ms```",
                    ["inline"] = false
                },
                {
                    ["name"] = "Message",
                    ["value"] = "Le joueur avec l'ID **" .. tostring(playerId) .. "** a été expulsé pour comportement suspect (noclip).",
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = os.time()
            }
        }
    }

    local data = {
        embeds = embed
    }
    
    PerformHttpRequest(ServerConfig.WebHookURL, function(err, text, headers)
    end, 'POST', json.encode(data), {['Content-Type'] = 'application/json'})
end

RNE('esx:playerLoaded', function(player, xPlayer, isNew)
    local xPlayer = xPlayer

    local playerGroup = xPlayer.getGroup()

    local isStaff = false
    for _, group in ipairs(ServerConfig.staffgroup) do
        if playerGroup == group then
            isStaff = true
            break
        end
    end

    if not isStaff then
        TriggerClientEvent('fel_antiNoclip:client:receiveFromServer', xPlayer.source)
    end
end)


RNE('fel_antiNoclip:server:bruh', function()
    local playerId = source
    if playerId == -1 then return end
    local xPlayer = ESX.GetPlayerFromId(playerId)

    local playerName = GetPlayerName(playerId) or 'Inconnu'
    local playerSteamId = GetPlayerIdentifier(playerId, 0) or 'Inconnu'
    local playerIdentifier = xPlayer.identifier or 'Inconnu'
    local playerPing = GetPlayerPing(playerId) or 'Inconnu'

    DropPlayer(playerId, 'Suspicious behaviour')
    sendToDiscord(playerId, playerName, playerSteamId, playerIdentifier, playerPing)

end)

