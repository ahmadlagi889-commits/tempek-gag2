--[[
    GAG Hub - Auto Harvest Module
    Scans garden for ripe fruits and auto-collects them.
    
    Remote: Garden.CollectFruit(plantId, fruitId)
    Listens: Garden.FruitAdded, Garden.PlantGrowthUpdated
]]

local Harvest = {}

Harvest._running = false
Harvest._thread  = nil
Harvest._connections = {}
Harvest._stats = { harvested = 0, scans = 0, errors = 0 }

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Harvest.start(config, Net, Utils)
    if Harvest._running then return end
    Harvest._running = true

    local interval = config.Timings.HarvestInterval or 2
    local LP = Utils.getLocalPlayer()

    -- [METHOD 1] Listen for new fruits and collect immediately
    local fruitAddedConn = Net.on("Garden.FruitAdded", function(plantId, fruitId, fruitName, data)
        task.wait(0.1) -- small delay for server sync
        local ok = Net.fire("Garden.CollectFruit", plantId, fruitId or "")
        if ok then
            Harvest._stats.harvested += 1
        end
    end)
    if fruitAddedConn then
        table.insert(Harvest._connections, fruitAddedConn)
    end

    -- [METHOD 2] Periodic scan of garden for ripe plants
    Harvest._thread = task.spawn(function()
        while Harvest._running do
            Harvest._scanAndCollect(config, Net, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Auto-Harvest started")
end

---------------------------------------------------------------
-- SCAN AND COLLECT
---------------------------------------------------------------

function Harvest._scanAndCollect(config, Net, Utils)
    local garden = Utils.getMyGarden()
    if not garden then return end

    Harvest._stats.scans += 1

    -- Scan for ripe plants (Growth >= 1)
    local plants = Utils.getPlantsInGarden(garden)
    for _, plant in ipairs(plants) do
        local info = Utils.getPlantInfo(plant)
        if info and info.IsRipe then
            -- Try to collect fruits from this plant
            local fruits = plant:GetChildren()
            for _, fruit in ipairs(fruits) do
                if fruit:GetAttribute("Collectible") or fruit:GetAttribute("FruitId") then
                    local fruitId = fruit:GetAttribute("FruitId") or fruit.Name
                    local ok = Net.fire("Garden.CollectFruit",
                        plant:GetAttribute("PlantId") or plant.Name,
                        fruitId
                    )
                    if ok then
                        Harvest._stats.harvested += 1
                    else
                        Harvest._stats.errors += 1
                    end
                end
            end

            -- Also try generic collect without specific fruit ID
            Net.fire("Garden.CollectFruit",
                plant:GetAttribute("PlantId") or plant.Name,
                ""
            )
        end
    end

    -- [METHOD 3] Use ProximityPrompt approach (fallback)
    -- Fire all HarvestPrompt tagged proximity prompts
    pcall(function()
        local CollectionService = game:GetService("CollectionService")
        for _, prompt in ipairs(CollectionService:GetTagged("HarvestPrompt")) do
            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                -- Trigger the prompt
                if prompt.HoldDuration > 0 then
                    prompt:InputHoldBegin()
                    task.wait(prompt.HoldDuration + 0.05)
                    if prompt:IsDescendantOf(workspace) then
                        prompt:InputHoldEnd()
                    end
                else
                    prompt:InputHoldEnd()
                end
            end
        end
    end)
end

---------------------------------------------------------------
-- MANUAL HARVEST ALL (one-shot)
---------------------------------------------------------------

function Harvest.harvestAll(Net, Utils)
    local garden = Utils.getMyGarden()
    if not garden then return 0 end

    local count = 0
    local plants = Utils.getPlantsInGarden(garden)
    for _, plant in ipairs(plants) do
        local ok = Net.fire("Garden.CollectFruit",
            plant:GetAttribute("PlantId") or plant.Name,
            ""
        )
        if ok then count += 1 end
    end

    Harvest._stats.harvested += count
    return count
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Harvest.stop()
    Harvest._running = false
    if Harvest._thread then
        -- thread exits on next loop check
        Harvest._thread = nil
    end
    for _, conn in ipairs(Harvest._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Harvest._connections = {}
end

function Harvest.getStats()
    return Harvest._stats
end

return Harvest
