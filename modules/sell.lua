--[[
    GAG Hub - Auto Sell Module
    Sells harvested fruits to Steven NPC.
    
    Remotes: NPCS.SellAll, NPCS.SellFruit, NPCS.UseDailyDealAll, NPCS.UseDailyDealSingle
]]

local Sell = {}

Sell._running = false
Sell._thread  = nil
Sell._connections = {}
Sell._stats = { sold = 0, totalEarned = 0, errors = 0 }

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Sell.start(config, Net, Utils)
    if Sell._running then return end
    Sell._running = true

    local interval = config.Timings.SellInterval or 5
    local sellConfig = config.Sell or {}

    Sell._thread = task.spawn(function()
        while Sell._running do
            Sell._autoSell(sellConfig, Net, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Auto-Sell started (mode: " .. (sellConfig.Mode or "all") .. ")")
end

---------------------------------------------------------------
-- AUTO SELL LOGIC
---------------------------------------------------------------

function Sell._autoSell(sellConfig, Net, Utils)
    local mode = sellConfig.Mode or "all"

    if mode == "all" then
        -- Sell everything
        local ok = Net.fire("NPCS.SellAll")
        if ok then
            Sell._stats.sold += 1
        else
            Sell._stats.errors += 1
        end

    elseif mode == "below_threshold" then
        -- Sell individual fruits below value threshold
        Sell._sellBelowThreshold(sellConfig, Net, Utils)

    elseif mode == "keep_best" then
        -- Sell all except top N
        Sell._sellKeepBest(sellConfig, Net, Utils)
    end

    -- Use daily deal if configured
    if sellConfig.UseDailyDeal then
        Net.fire("NPCS.UseDailyDealAll")
    end
end

-- Sell fruits below a certain value threshold
function Sell._sellBelowThreshold(sellConfig, Net, Utils)
    local threshold = sellConfig.ValueThreshold or 100

    -- Get backpack items
    local items = Utils.getBackpackItems()
    for _, item in ipairs(items) do
        if item.Type == "HarvestedFruit" or string.find(item.Name, "Fruit") then
            -- Try to sell this individual fruit
            local ok = Net.fire("NPCS.SellFruit", item.Name)
            if ok then
                Sell._stats.sold += 1
            end
        end
    end
end

-- Sell all except keep top N valuable fruits
function Sell._sellKeepBest(sellConfig, Net, Utils)
    -- Just sell all for now - more complex logic needs inventory API
    local ok = Net.fire("NPCS.SellAll")
    if ok then
        Sell._stats.sold += 1
    end
end

---------------------------------------------------------------
-- MANUAL SELL ALL
---------------------------------------------------------------

function Sell.sellAll(Net)
    local ok = Net.fire("NPCS.SellAll")
    if ok then
        Sell._stats.sold += 1
    end
    return ok
end

---------------------------------------------------------------
-- SELL SPECIFIC FRUIT
---------------------------------------------------------------

function Sell.sellFruit(Net, fruitName)
    local ok = Net.fire("NPCS.SellFruit", fruitName)
    if ok then
        Sell._stats.sold += 1
    end
    return ok
end

---------------------------------------------------------------
-- USE DAILY DEAL
---------------------------------------------------------------

function Sell.useDailyDeal(Net, single)
    if single then
        return Net.fire("NPCS.UseDailyDealSingle")
    else
        return Net.fire("NPCS.UseDailyDealAll")
    end
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Sell.stop()
    Sell._running = false
    for _, conn in ipairs(Sell._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Sell._connections = {}
end

function Sell.getStats()
    return Sell._stats
end

return Sell
