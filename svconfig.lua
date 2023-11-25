svConfig = {}

svConfig.Webhook= '' --Put your Webhook link in there. If u dont want to use it, leave it blank

svConfig.Account = 'money' -- ESX: 'money', 'bank', 'black_money' | QB: 'cash', 'bank', 'crypto'

svConfig.Bail = 500 -- If the Player has to give a Bail at the beginning for bringing the Car back. If not needed just "Config.Bail = 0"

svConfig.Reward = { -- How Many Dollars the Player will receive after finishing (Bonus)
    min = 1500,
    max = 2500
}

svConfig.Intervall = { --How Many Dollars the Player will receive each Intervall
    min = 500,
    max = 1000
}