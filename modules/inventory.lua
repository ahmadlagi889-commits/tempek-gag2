--[[
    GAG Hub - Inventory Optimizer Module
    Auto-manages inventory: favorite, promote, drop items.
    
    Remotes: Backpack.SetFruitFavorite, Backpack.PromoteFruit,
             Backpack.DemoteFruit, DroppedItem.RequestDrop
]]

local Inventory = {}

Inventory._running = false
Inventory._thread  = nil
Inventory._connections = {}
Inventory._stats = { favorited = 0, promoted = 0, dropped = 0, scanned = 0 }

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Inventory.start(config, Net, Utils)
    if Inventory._running then return end
    Inventory._running = true

    local interval = config.Timings.InventoryCheckInterval or 10
    local invConfig = config.Inventory or {}

    Inventory._thread = task.spawn(function()
        while Inventory._running do
            Inventory._optimize(invConfig, Net, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Inventory Optimizer started")
end

---------------------------------------------------------------
-- OPTIMIZE LOGIC
---------------------------------------------------------------

function Inventory._optimize(invConfig, Net, Utils)
    Inventory._stats.scanned += 1
    local LP = Utils.getLocalPlayer()
    local backpack = LP and LP:FindFirstChild("Backpack")
    if not backpack then return end

    for _, tool in ipairs(backpack:GetChildren()) do
        if not tool:IsA("Tool") then continue end

        local itemName = tool.Name
        local itemType = tool:GetAttribute("ItemType") or ""
        local fruitName = tool:GetAttribute("FruitName") or ""
        local mutation  = tool:GetAttribute("Mutation") or ""
        local size      = tool:GetAttribute("Size") or 1

        -- Get base value for this item
        local seedName = fruitName ~= "" and fruitName or itemName
        local baseValue = Inventory._getBaseValue(seedName)
        local mult = Inventory._getMutationMult(mutation, config)
        local estimatedValue = baseValue * (size ^ 2.65) * mult

        -- AUTO-FAVORITE high value fruits
        if invConfig.AutoFavorite ~= false and
           estimatedValue >= (invConfig.FavoriteThreshold or 500) then
            local ok = pcall(function()
                Net.fire("Backpack.SetFruitFavorite", tool.Name, true)
            end)
            if ok then
                Inventory._stats.favorited += 1
            end
        end

        -- AUTO-PROMOTE fruits to inventory
        if invConfig.AutoPromote then
            if itemType == "HarvestedFruit" or
               itemType == "Fruit" or
               fruitName ~= "" then
                local ok = pcall(function()
                    Net.fire("Backpack.PromoteFruit", tool.Name)
                end)
                if ok then
                    Inventory._stats.promoted += 1
                end
            end
        end

        -- AUTO-DROP low value items
        if invConfig.DropThreshold and
           invConfig.DropThreshold > 0 and
           estimatedValue < invConfig.DropThreshold then
            -- Don't drop seeds or tools
            if itemType ~= "SeedTool" and
               itemType ~= "WateringCan" and
               itemType ~= "Sprinkler" and
               not itemName:match("Seed") then
                local ok = pcall(function()
                    Net.fire("DroppedItem.RequestDrop", tool.Name, 1)
                end)
                if ok then
                    Inventory._stats.dropped += 1
                end
            end
        end
    end
end

---------------------------------------------------------------
-- VALUE HELPERS
---------------------------------------------------------------

function Inventory._getBaseValue(seedName)
    local values = {
        ["Carrot"] = 5, ["Strawberry"] = 3, ["Blueberry"] = 5,
        ["Tomato"] = 9, ["Apple"] = 12, ["Cactus"] = 40,
        ["Pineapple"] = 30, ["Banana"] = 35, ["Corn"] = 34,
        ["Grape"] = 45, ["Mango"] = 90, ["Coconut"] = 60,
        ["Cherry"] = 350, ["Pomegranate"] = 900,
        ["Dragon Fruit"] = 150, ["Mushroom"] = 13000,
        ["Sunflower"] = 1750, ["Venus Fly Trap"] = 3000,
        ["Moon Bloom"] = 9000, ["Dragon's Breath"] = 3400,
        ["Ghost Pepper"] = 2500, ["Lotus"] = 6500,
        ["Romanesco"] = 1500, ["Poison Apple"] = 900,
        ["Poison Ivy"] = 1700, ["Glow Mushroom"] = 700,
        ["Horned Melon"] = 200, ["Baby Cactus"] = 70,
        ["Tulip"] = 60, ["Bamboo"] = 800, ["Pumpkin"] = 350,
        ["Pinetree"] = 100, ["Green Bean"] = 10,
        ["Beanstalk"] = 2000, ["Thorn Rose"] = 140,
        ["Acorn"] = 200, ["Moon Bloom"] = 9000,
    }
    return values[seedName] or 0
end

function Inventory._getMutationMult(mutation, config)
    if not mutation or mutation == "" then return 1 end
    if config and config.Mutation and config.Mutation.PriceMultipliers then
        return config.Mutation.PriceMultipliers[mutation] or 1
    end
    local defaults = {
        Gold = 20, Rainbow = 50, Electric = 12,
        Frozen = 10, Bloodlit = 5, Chained = 8, Starstruck = 100,
    }
    return defaults[mutation] or 1
end

---------------------------------------------------------------
-- MANUAL OPERATIONS
---------------------------------------------------------------

function Inventory.favoriteAll(Net, Utils, threshold)
    local count = 0
    local backpack = Utils.getLocalPlayer():FindFirstChild("Backpack")
    if not backpack then return 0 end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            pcall(function()
                Net.fire("Backpack.SetFruitFavorite", tool.Name, true)
                count += 1
            end)
        end
    end
    Inventory._stats.favorited += count
    return count
end

function Inventory.dropAllLowValue(Net, Utils, threshold)
    local count = 0
    local backpack = Utils.getLocalPlayer():FindFirstChild("Backpack")
    if not backpack then return 0 end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local fruitName = tool:GetAttribute("FruitName") or tool.Name
            local baseValue = Inventory._getBaseValue(fruitName)
            if baseValue < threshold then
                pcall(function()
                    Net.fire("DroppedItem.RequestDrop", tool.Name, 1)
                    count += 1
                end)
            end
        end
    end
    Inventory._stats.dropped += count
    return count
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Inventory.stop()
    Inventory._running = false
    for _, conn in ipairs(Inventory._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Inventory._connections = {}
end

function Inventory.getStats()
    return Inventory._stats
end

return Inventory
