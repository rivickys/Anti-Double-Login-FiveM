local allowedSessionsPerLicense = 1
local players = {}

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local playerLicense = GetPlayerIdentifiers(source)[1]
    if not players[playerLicense] then
        players[playerLicense] = 1
    else
        players[playerLicense] = players[playerLicense] + 1
    end
    deferrals.defer()
    Wait(1000)  
    if players[playerLicense] > allowedSessionsPerLicense then
        deferrals.done('JANGAN DOUBLE')
    else
        deferrals.done()
    end
end)


AddEventHandler('playerDropped', function()
    local playerLicense = GetPlayerIdentifiers(source)[1]
    if players[playerLicense] then
        print(players[playerLicense], 'The player has left the game, the limit has been renewed!')
        players[playerLicense] = players[playerLicense] - 1
        if players[playerLicense] == 0 then
            players[playerLicense] = nil
        end
    end
end)