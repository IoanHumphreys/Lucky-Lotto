local QBCore = exports['qb-core']:GetCoreObject()

-- Function to check if a ticket wins
local function checkWinningTicket(odds)
    return math.random(1, odds) == 1
end

QBCore.Functions.CreateCallback('lottery:server:purchaseTicket', function(source, cb, ticketName, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.Functions.RemoveMoney("cash", price, "lottery-ticket-purchase") then
        local itemName = Config.TicketItems[ticketName]
        if itemName then
            if Player.Functions.AddItem(itemName, 1) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "add")
                cb(true)
            else
                Player.Functions.AddMoney("cash", price, "lottery-ticket-purchase-refund")
                cb(false)
            end
        else
            print("Error: Invalid ticket name - " .. ticketName)
            Player.Functions.AddMoney("cash", price, "lottery-ticket-purchase-refund")
            cb(false)
        end
    else
        cb(false)
    end
end)

-- Create usable items for each ticket type
for itemName, ticketInfo in pairs(Config.Tickets) do
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        if checkWinningTicket(ticketInfo.odds) then
            -- Winner!
            Player.Functions.AddMoney('cash', ticketInfo.prize, "lottery-ticket-win")
            TriggerClientEvent('QBCore:Notify', src, "Congratulations! You won $" .. ticketInfo.prize .. "!", "success")
        else
            -- Loss
            TriggerClientEvent('QBCore:Notify', src, "Sorry, this ticket didn't win. Better luck next time!", "error")
        end

        -- Remove the used ticket from inventory
        Player.Functions.RemoveItem(itemName, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "remove")
    end)
end
