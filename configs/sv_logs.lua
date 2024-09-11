webhooks = {
    ['drop'] = '',
    ['pickup'] = '',
    ['give'] = '',
    ['stash'] = '',
}

colors = {
    red = 0xFF0000,
    green = 0x00FF00
}

hooks = {
    ['drop'] = {
        from = 'player',
        to = 'drop',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('drop', {
                {
                    title = '捨てる',
                    description = ("```\n[Player] %s\n - %s\n - ID: %s\n[Item]   %s x%s\n - META: %s\n[Coords] %s```")
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = colors.red
                }
            })
        end
    },
    ['pickup'] = {
        from = 'drop',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('pickup', {
                {
                    title = '拾う',
                    description = ("```\n[Player] %s\n - %s\n - ID: %s\n[Item]   %s x%s\n - META: %s\n[Coords] %s```")
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = colors.green
                }
            })
        end
    },
    ['give'] = {
        from = 'player',
        to = 'player',
        callback = function(payload)
            if payload.fromInventory == payload.toInventory then return end
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            local targetSource = payload.toInventory
            local targetName = GetPlayerName(targetSource)
            local targetIdentifier = GetPlayerIdentifiers(targetSource)[1]
            local targetCoords = GetEntityCoords(GetPlayerPed(targetSource))
            sendWebhook('give', {
                {
                    title = 'アイテム受け渡し',
                    description = ("```\n[Player] %s\n - %s\n - ID: %s\n[Item]   %s x%s\n - META: %s\n[Target] %s\n - %s\n - ID: %s\n[Coords] %s```")
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            targetName,
                            targetIdentifier,
                            targetSource,
                            json.encode(payload.fromSlot.metadata),
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z),
                            ('%s, %s, %s'):format(targetCoords.x, targetCoords.y, targetCoords.z)
                        ),
                    color = colors.red
                }
            })
        end
    },
    ['stash_pick'] = {
        from = 'player',
        to = 'stash',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('stash', {
                {
                    title = 'スタッシュ(入れる)',
                    description = ("```\n[Player] %s\n - %s\n - ID: %s\n[Item]   %s x%s\n - META: %s\n - ID: %s\n[Stash]  %s\n[Coords] %s```")
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.toInventory,
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = colors.green
                }
            })
        end
    },
    ['stash'] = {
        from = 'stash',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('stash', {
                {
                    title = 'スタッシュ(取り出し)',
                    description = ("```\n[Player] %s\n - %s\n - ID: %s\n[Item]   %s x%s\n - META: %s\n - ID: %s\n[Stash]  %s\n[Coords] %s```")
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.fromInventory,
                            ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
                        ),
                    color = colors.red
                }
            })
        end
    },
}

