---------------------------
-- Configs --
---------------------------
-- //©_Scrubz#0001_© ^_^// --
Config = {}
-- Robbery Core Mechanics
Config.RobberyTimer = 25   -- In Seconds
Config.CooldownTimer = 32   -- In Seconds
Config.PoliceRequired = 0   -- 0 to disable
Config.UseChatAlert = false   -- Enable to use default chat alerts for police
Config.UseCustomAlert = false   -- Enable to use your own police alerts
Config.UseProgbar = true   -- Enable to use DRP Progbar
Config.UseCustomProgbar = false   -- Enable to use your own progbar
-- Robbery Default Section
Config.EnableDefaultLoot = true   -- Whether to give default loot or now
Config.DefaultLoots = 'valuablegoods'   -- Default Loot Item Name
Config.DefaultAmount = math.random(2, 4)   -- Random amount between 2 and 4
-- Robbery Loot Section
Config.EnableGoodLoot = true   -- Enable to have a chance to get good loot
Config.EnableBestLoot = true   -- Enable to have a chance to get really good loot
Config.GibGoodLootAmount = 2   -- Amount of seperate good loot items to give at a time
Config.GoodLootChance = 1.0   -- 1.0 = 100% | 0.1 = 10%
Config.BestLootChance = 0.35   -- 1.0 = 100% | 0.1 = 10%
---------------------------------------------------------------------------------
Config.GibBestestLoot = 
{
    [1] = {item = 'ldiamonds', chance = 0.25, amount = 7},
    [2] = {item = 'ldiamonds', chance = 0.5, amount = 3},
    [3] = {item = 'sdiamonds', chance = 0.75, amount = 10},
    [4] = {item = 'sdiamonds', chance = 1.0, amount = 5}
}
---------------------------------------------------------------------------------
Config.GibGoodLoot = 
{
    [1] = {item = 'dearings', chance = 0.25, amount = 1},
    [2] = {item = 'dnecklace', chance = 0.25, amount = 1},
    [3] = {item = 'dwatch', chance = 0.25, amount = 1},
    [4] = {item = 'dring', chance = 0.25, amount = 1},
    [5] = {item = 'rolex', chance = 0.5, amount = 1},
    [6] = {item = '24knecklace', chance = 0.75, amount = 1},
    [7] = {item = '10knecklace', chance = 0.75, amount = 1},
    [8] = {item = 'goldring', chance = 1.0, amount = 1}
}
---------------------------------------------------------------------------------
Config.MuchLoots = 
{
    [1] = {location = vector3(-626.7151, -238.6176, 38.057), isSearched = false},
    [2] = {location = vector3(-625.6683, -237.8564, 38.057), isSearched = false},
    [3] = {location = vector3(-626.8333, -235.3542, 38.057), isSearched = false},
    [4] = {location = vector3(-625.7693, -234.5863, 38.057), isSearched = false},
    [5] = {location = vector3(-623.1668, -232.9536, 38.057), isSearched = false},
    [6] = {location = vector3(-620.1784, -234.4206, 38.057), isSearched = false},
    [7] = {location = vector3(-619.1897, -233.7025, 38.057), isSearched = false},
    [8] = {location = vector3(-620.1614, -233.3275, 38.057), isSearched = false},
    [9] = {location = vector3(-617.5204, -230.5452, 38.057), isSearched = false},
    [10] = {location = vector3(-618.2759, -229.5203, 38.057), isSearched = false},
    [11] = {location = vector3(-619.7253, -230.4052, 38.057), isSearched = false},
    [12] = {location = vector3(-619.6434, -227.6554, 38.057), isSearched = false},
    [13] = {location = vector3(-620.4242, -226.5816, 38.057), isSearched = false},
    [14] = {location = vector3(-621.0642, -228.5634, 38.057), isSearched = false},
    [15] = {location = vector3(-623.8863, -227.0309, 38.057), isSearched = false},
    [16] = {location = vector3(-624.9652, -227.8132, 38.057), isSearched = false},
    [17] = {location = vector3(-632.9976, -228.1696, 38.057), isSearched = false},
    [18] = {location = vector3(-624.4401, -231.0459, 38.057), isSearched = false},
    [19] = {location = vector3(-626.9193, -233.1595, 38.057), isSearched = false},
    [20] = {location = vector3(-627.9591, -233.9099, 38.057), isSearched = false}
}
---------------------------------------------------------------------------------