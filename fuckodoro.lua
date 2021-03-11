_addon.name = "fuckodoro"
_addon.version = "1.0"

local packets = require('packets')


windower.register_event('incoming chunk', function(id, data)

    if id == 0x021 then

        local tradeRequest = packets.parse('incoming', data)

        local trade = packets.new('outgoing', 0x033)

        packets.inject(trade);
    
    end

    if id == 0x023 then

        local tradeItem = packets.parse('incoming', data)

        tradeCount = tradeItem["Trade Count"]

    end

    if id == 0x022 then

        local tradeState = packets.parse('incoming', data)

        local tradeOtherParty = windower.ffxi.get_mob_by_id(tradeState["Player"])

        if tradeState["Type"] == 2 then --Trade accepted by other party
           
            local tradeFinish = packets.new('outgoing', 0x033)

            tradeFinish["Type"] = 2
            tradeFinish["Trade Count"] = tradeCount

            packets.inject(tradeFinish)

        end

    end

end)
