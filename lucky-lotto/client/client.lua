local QBCore = exports['qb-core']:GetCoreObject()

-- Model Hashes
local modelHashes = {
    `v_ret_247_lotterysign`,
    `v_ret_247_lottery`,
}

-- Target Models
local function AddTargetModels()
    exports['qb-target']:AddTargetModel(modelHashes, {
        options = {
            {
                type = "client",
                event = "openLuckyLottoMenu",
                icon = "fas fa-ticket-alt",
                label = "Open Lucky Lotto",
            },
        },
        distance = 2.5,
    })
end

-- Purchaseable Tickets
local function PurchaseTicket(ticketName, price)
    local Player = QBCore.Functions.GetPlayerData()
    local cash = Player.money['cash']

    print("Debug: Attempting to purchase " .. ticketName .. " for $" .. price)
    print("Debug: Player cash: $" .. cash)

    if cash >= price then
        QBCore.Functions.TriggerCallback('lottery:server:purchaseTicket', function(success)
            if success then
                QBCore.Functions.Notify("You purchased a " .. ticketName .. " for $" .. price, "success")
            else
                QBCore.Functions.Notify("Failed to purchase the ticket", "error")
            end
        end, ticketName, price)
    else
        QBCore.Functions.Notify("You don't have enough cash!", "error")
    end

    -- Debug event
    TriggerServerEvent('lottery:server:debugPurchase', ticketName, price)
end

-- Main Lucky Lotto Menu
lib.registerContext({
    id = 'lucky_lotto_main',
    title = 'Lucky Lotto',
    options = {
        {
            title = 'Quick Pick Tickets',
            description = 'Fast and easy lottery options',
            icon = 'fas fa-bolt',
            menu = 'quick_pick_menu',
        },
        {
            title = 'Premium Tickets',
            description = 'Higher stakes, bigger rewards',
            icon = 'fas fa-star',
            menu = 'premium_tickets_menu',
        }
    }
})

-- Quick Pick Tickets Submenu
lib.registerContext({
    id = 'quick_pick_menu',
    title = 'Quick Pick Tickets',
    menu = 'lucky_lotto_main',
    options = {
        {
            title = 'Lucky 7 - $2,500',
            description = 'Quick $700 ticket',
            icon = 'fa-solid fa-clover',
            onSelect = function()
                PurchaseTicket("Lucky 7", 700)
            end,
        },
        {
            title = 'Double Digits - $5,000',
            description = 'Try your luck for $1,200',
            icon = 'fas fa-dice',
            onSelect = function()
                PurchaseTicket("Double Digits", 1200)
            end,
        },
    }
})

-- Premium Tickets Submenu
lib.registerContext({
    id = 'premium_tickets_menu',
    title = 'Premium Tickets',
    menu = 'lucky_lotto_main',
    options = {
        {
            title = 'Golden Ticket - $25,000',
            description = 'Premium $8,000 ticket',
            icon = 'fas fa-trophy',
            onSelect = function()
                PurchaseTicket("Golden Ticket", 8000)
            end,
        },
        {
            title = 'Platinum Pass - $50,000',
            description = 'High roller $15,000 ticket',
            icon = 'fas fa-gem',
            onSelect = function()
                PurchaseTicket("Platinum Pass", 15000)
            end,
        },
        {
            title = 'Diamond Dream - $100,000',
            description = 'Luxurious $35,000 ticket',
            icon = 'fas fa-dice-d20',
            onSelect = function()
                PurchaseTicket("Diamond Dream", 25000)
            end,
        },
        {
            title = 'Royal Flush - $200,000',
            description = 'Majestic $75,000 ticket',
            icon = 'fas fa-crown',
            onSelect = function()
                PurchaseTicket("Royal Flush", 40000)
            end,
        },
        {
            title = 'Millionaire Maker - $1,000,000',
            description = 'Ultimate $150,000 ticket',
            icon = 'fas fa-money-bill-wave',
            onSelect = function()
                PurchaseTicket("Millionaire Maker", 100000)
            end,
        },
    }
})

-- Open Lucky Lotto
RegisterNetEvent('openLuckyLottoMenu')
AddEventHandler('openLuckyLottoMenu', function()
    lib.showContext("lucky_lotto_main")
end)

RegisterNetEvent('lottery:client:purchaseTicket')
AddEventHandler('lottery:client:purchaseTicket', function(ticketName, price)
    QBCore.Functions.TriggerCallback('lottery:server:purchaseTicket', function(success)
        if success then
            QBCore.Functions.Notify("You purchased a " .. ticketName .. " for $" .. price, "success")
        else
            QBCore.Functions.Notify("Failed to purchase the ticket", "error")
        end
    end, ticketName, price)
end)

-- Initialize when server starts
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    AddTargetModels()
end)

-- Initialize when player loads
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    AddTargetModels()
end)