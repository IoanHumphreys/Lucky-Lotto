# 🎟️ Lucky Lotto 

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![QBCore](https://img.shields.io/badge/qbcore-framework-green.svg)
![ox_lib](https://img.shields.io/badge/ox__lib-context_menu-orange.svg)

A comprehensive lottery system for FiveM servers using the QBCore framework. This script adds an engaging lottery experience to your server, allowing players to purchase tickets and win big!

## 🌟 Features

- **Multiple Ticket Types**: From quick picks to premium tickets, catering to all player budgets.
- **Configurable Odds**: Each ticket type has its own odds of winning, fully customizable.
- **Inventory Integration**: Tickets are added as usable items in the player's inventory.
- **User-Friendly Interface**: Easy-to-use menu system for purchasing tickets.
- **Target Integration**: Use `qb-target` to interact with lottery machines in-game.

## 🛠️ Dependencies

- [QBCore Framework](https://github.com/qbcore-framework)
- [ox_lib](https://github.com/overextended/ox_lib) (for context menus)
- [qb-target](https://github.com/BerkieBb/qb-target) (optional, for interaction)

## 📦 Installation

1. Ensure you have QBCore and ox_lib installed and configured.
2. Clone this repository into your server's `resources` folder.
3. Add `ensure lucky-lotto` to your `server.cfg` file.
4. Configure the `config.lua` file to your liking.
5. Restart your server.

## ⚙️ Configuration

The `config.lua` file allows you to customize various aspects of the lottery system:

```lua
Config.Tickets = {
    ["lucky_7_ticket"] = {
        label = "Lucky 7",
        price = 700,
        prize = 2500,
        odds = 10 -- 1 in 10 chance
    },
    -- More ticket types...
}

Config.TicketItems = {
    ["Lucky 7"] = "lucky_7_ticket",
    -- More ticket items...
}
```

## 🎮 Usage

Players can interact with lottery machines in-game to access the Lucky Lotto menu. From there, they can:

1. Choose between Quick Pick and Premium tickets.
2. Purchase tickets using in-game cash.
3. Use tickets from their inventory to see if they've won.

## 🏆 Winning

When a player uses a ticket:
- The system checks if it's a winning ticket based on the configured odds.
- If it's a winner, the prize money is automatically added to the player's cash.
- The player receives a notification of their win or loss.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 👏 Show your support

Give a ⭐️ if this project helped you!

---
