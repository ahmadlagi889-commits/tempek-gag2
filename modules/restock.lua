--[[
    GAG Hub - Restock Sniper Module
    Monitors shop restock timers and auto-buys target seeds.
    
    Data: _values/StockValues_SeedShop_*
    Listens: shop refresh events
]]

local Restock = {}

Restock._running = false
Restock._thread  = nil
Restock._connections = {}
Restock._stats = { bought = 0, scanned = 0, moneySpent = 0, errors = 0 }
Restock._lastRestockTime = 0

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Restock.start(config, Net, Utils)
    if Restock._running then return end
    Restock._running = true

    local interval = config.Timings.RestockPollInterval or 1
    local restockConfig = config.Restock or {}

    Restock._thread = task.spawn(function()
        while Restock._running do
            Restock._pollAndBuy(restockConfig, Net, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Restock Sniper started (targets: " ..
        #(restockConfig.TargetSeeds or {}) .. " seeds)")
end

---------------------------------------------------------------
-- POLL RESTOCK AND BUY
---------------------------------------------------------------

function Restock._pollAndBuy(restockConfig, Net, Utils)
    Restock._stats.scanned += 1

    -- Check if shop has restocked by monitoring stock changes
    local sheckles = Utils.getSheckles()
    local maxSpend = restockConfig.MaxSpendPerCycle or 500000
    local spent = 0

    -- Get target seeds
    local targets = restockConfig.TargetSeeds or {}
    local blacklist = {}
    for _, name in ipairs(restockConfig.BlacklistedSeeds or {}) do
        blacklist[name] = true
    end

    -- Try to buy each target seed
    for _, seedName in ipairs(targets) do
        if blacklist[seedName] then continue end
        if spent >= maxSpend then break end

        -- Check if this seed is in stock
        -- The game uses inventory-based shop system
        -- We attempt to buy and handle failure gracefully
        local canBuy = Restock._checkStock(seedName)
        if canBuy then
            -- Attempt purchase via the shop system
            local buyOk = Restock._attemptBuy(Net, seedName)
            if buyOk then
                Restock._stats.bought += 1
                spent += Restock._estimatePrice(seedName)
                Config.Notify("Restock Sniper",
                    "Bought " .. seedName .. "!", 3)
                task.wait(0.5) -- delay between purchases
            end
        end
    end

    if spent > 0 then
        Restock._stats.moneySpent += spent
    end
end

---------------------------------------------------------------
-- CHECK STOCK (reads from value objects or game state)
---------------------------------------------------------------

function Restock._checkStock(seedName)
    -- Method 1: Check ReplicatedStorage stock values
    local RS = game:GetService("ReplicatedStorage")
    local stockFolder = RS:FindFirstChild("StockValues")
        and RS.StockValues:FindFirstChild("SeedShop")
        and RS.StockValues.SeedShop:FindFirstChild("Items")

    if stockFolder then
        local stockVal = stockFolder:FindFirstChild(seedName)
        if stockVal and stockVal:IsA("ValueBase") then
            return (stockVal.Value or 0) > 0
        end
    end

    -- Method 2: Assume available (let buy attempt fail if not)
    return true
end

---------------------------------------------------------------
-- ATTEMPT BUY
---------------------------------------------------------------

function Restock._attemptBuy(Net, seedName)
    -- Try various buy remotes the game might use
    -- The shop system may use DevProducts or direct purchase

    -- Method 1: Direct seed purchase (if exists)
    if Net.exists("SeedShop.BuySeed") then
        return Net.fire("SeedShop.BuySeed", seedName)
    end

    -- Method 2: Generic shop purchase
    if Net.exists("Shop.BuyItem") then
        return Net.fire("Shop.BuyItem", seedName)
    end

    -- Method 3: Token purchase
    if Net.exists("DevProducts.PurchaseWithTokens") then
        return Net.fire("DevProducts.PurchaseWithTokens", seedName)
    end

    -- Method 4: Use ProximityPrompt on seed shop NPC
    local success = false
    pcall(function()
        local CollectionService = game:GetService("CollectionService")
        for _, obj in ipairs(CollectionService:GetTagged("SeedShop")) do
            if obj:IsA("ProximityPrompt") and obj.Enabled then
                -- Trigger to open shop, then buy from UI
                fireproximityprompt(obj)
                success = true
                break
            end
        end
    end)

    if not success then
        -- Method 5: Click seed shop button in GUI
        pcall(function()
            local LP = game:GetService("Players").LocalPlayer
            local gui = LP.PlayerGui:FindFirstChild("SeedShop")
                or LP.PlayerGui:FindFirstChild("Shop")
            if gui then
                -- Look for buy button for this seed
                local btn = Restock._findBuyButton(gui, seedName)
                if btn then
                    -- Simulate click
                    if btn.Activated then
                        -- This is client-side, need to fire the actual remote
                    end
                end
            end
        end)
    end

    return false
end

---------------------------------------------------------------
-- FIND BUY BUTTON IN GUI
---------------------------------------------------------------

function Restock._findBuyButton(gui, seedName)
    for _, desc in ipairs(gui:GetDescendants()) do
        if desc:IsA("TextButton") or desc:IsA("ImageButton") then
            if desc.Name:match(seedName) or
               (desc.Text and desc.Text:match(seedName)) then
                return desc
            end
        end
    end
    return nil
end

---------------------------------------------------------------
-- ESTIMATE PRICE
---------------------------------------------------------------

function Restock._estimatePrice(seedName)
    -- Common seed prices (approximate)
    local prices = {
        ["Carrot"] = 10,
        ["Strawberry"] = 50,
        ["Blueberry"] = 400,
        ["Tomato"] = 800,
        ["Corn"] = 1300,
        ["Tulip"] = 1000,
        ["Apple"] = 3250,
        ["Bamboo"] = 4000,
        ["Coconut"] = 6000,
        ["Pineapple"] = 7500,
        ["Banana"] = 7000,
        ["Cactus"] = 15000,
        ["Grape"] = 850000,
        ["Mango"] = 1000000,
        ["Dragon Fruit"] = 1200000,
        ["Mushroom"] = 150000,
        ["Cherry"] = 500000,
        ["Pomegranate"] = 750000,
        ["Sunflower"] = 1250000,
        ["Venus Fly Trap"] = 2000000,
        ["Moon Bloom"] = 3000000,
        ["Dragon's Breath"] = 2500000,
        ["Ghost Pepper"] = 1800000,
    }
    return prices[seedName] or 50000
end

---------------------------------------------------------------
-- GET TIME UNTIL RESTOCK
---------------------------------------------------------------

function Restock.getTimeUntilRestock()
    local RS = game:GetService("ReplicatedStorage")
    local nextRestock = RS:FindFirstChild("StockValues")
        and RS.StockValues:FindFirstChild("SeedShop")
        and RS.StockValues.SeedShop:FindFirstChild("UnixNextRestock")

    if nextRestock then
        local restockTime = nextRestock.Value or 0
        local now = os.time()
        return math.max(0, restockTime - now)
    end
    return -1
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Restock.stop()
    Restock._running = false
    for _, conn in ipairs(Restock._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Restock._connections = {}
end

function Restock.getStats()
    return Restock._stats
end

return Restock
