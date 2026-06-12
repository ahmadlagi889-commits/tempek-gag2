--[[
    GAG Hub - Auto Plant Module
    Auto-plants seeds in empty plots on player's garden.
    
    Remote: Plant.PlantSeed(seedName, position)
    Also: Garden.PotPlant (for potted plants)
]]

local Plant = {}

Plant._running = false
Plant._thread  = nil
Plant._connections = {}
Plant._stats = { planted = 0, scans = 0, errors = 0, noSeeds = 0 }

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Plant.start(config, Net, Utils)
    if Plant._running then return end
    Plant._running = true

    local interval = config.Timings.PlantInterval or 5
    local plantConfig = config.Plant or {}

    Plant._thread = task.spawn(function()
        while Plant._running do
            Plant._autoPlant(plantConfig, Net, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Auto-Plant started")
end

---------------------------------------------------------------
-- AUTO PLANT LOGIC
---------------------------------------------------------------

function Plant._autoPlant(plantConfig, Net, Utils)
    local garden = Utils.getMyGarden()
    if not garden then return end

    Plant._stats.scans += 1

    -- Check for empty soil patches
    local soilPatches = {}
    for _, child in ipairs(garden:GetDescendants()) do
        if child:IsA("BasePart") and (
            child.Name == "Soil" or
            child.Name == "Dirt" or
            child:GetAttribute("PlantSpot") or
            child.Name:match("^Soil%d*$")
        ) then
            -- Check if this spot is empty (no plant attached)
            local hasPlant = false
            for _, sibling in ipairs(child:GetChildren()) do
                if sibling:GetAttribute("SeedName") then
                    hasPlant = true
                    break
                end
            end
            -- Also check nearby descendants
            if not hasPlant then
                for _, desc in ipairs(garden:GetDescendants()) do
                    if desc:GetAttribute("SeedName") then
                        local dist = 0
                        pcall(function()
                            local part = desc:FindFirstChildWhichIsA("BasePart")
                            if part and child then
                                dist = (part.Position - child.Position).Magnitude
                            end
                        end)
                        if dist < 3 then
                            hasPlant = true
                            break
                        end
                    end
                end
            end

            if not hasPlant then
                table.insert(soilPatches, child)
            end
        end
    end

    if #soilPatches == 0 then return end

    -- Get available seeds from backpack
    local availableSeeds = Plant._getAvailableSeeds(Utils)

    if #availableSeeds == 0 then
        Plant._stats.noSeeds += 1
        return
    end

    -- Plant seeds in empty spots
    local seedsPlanted = 0
    for i, soil in ipairs(soilPatches) do
        if i > #availableSeeds then break end

        local seedName = availableSeeds[i]

        -- Method 1: Use Plant.PlantSeed remote
        local ok = Net.fire("Plant.PlantSeed", seedName, soil.Position)
        if ok then
            Plant._stats.planted += 1
            seedsPlanted += 1
        else
            -- Method 2: Try Garden.PotPlant
            ok = Net.fire("Garden.PotPlant", seedName)
            if ok then
                Plant._stats.planted += 1
                seedsPlanted += 1
            else
                Plant._stats.errors += 1
            end
        end

        task.wait(0.2) -- small delay between plantings
    end
end

---------------------------------------------------------------
-- GET AVAILABLE SEEDS
---------------------------------------------------------------

function Plant._getAvailableSeeds(Utils)
    local items = Utils.getBackpackItems()
    local seeds = {}

    for _, item in ipairs(items) do
        if item.Type == "SeedTool" or
           item.Type == "Seed" or
           item.Name:match("Seed$") or
           item.Instance:GetAttribute("SeedName") then
            local seedName = item.Instance:GetAttribute("SeedName") or item.Name
            table.insert(seeds, seedName)
        end
    end

    -- Sort by priority
    table.sort(seeds, function(a, b)
        return Plant._getSeedPriority(a) < Plant._getSeedPriority(b)
    end)

    return seeds
end

-- Get seed priority (lower = higher priority)
function Plant._getSeedPriority(seedName)
    local priorityMap = {
        ["Mushroom"] = 1,
        ["Moon Bloom"] = 2,
        ["Lotus"] = 3,
        ["Sunflower"] = 4,
        ["Venus Fly Trap"] = 5,
        ["Dragon's Breath"] = 6,
        ["Ghost Pepper"] = 7,
        ["Pomegranate"] = 8,
        ["Cherry"] = 9,
        ["Dragon Fruit"] = 10,
        ["Mango"] = 11,
        ["Grape"] = 12,
        ["Coconut"] = 13,
        ["Banana"] = 14,
        ["Pineapple"] = 15,
    }
    return priorityMap[seedName] or 999
end

---------------------------------------------------------------
-- MANUAL PLANT ONE
---------------------------------------------------------------

function Plant.plantOne(Net, seedName, position)
    local ok = Net.fire("Plant.PlantSeed", seedName, position)
    if ok then
        Plant._stats.planted += 1
    end
    return ok
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Plant.stop()
    Plant._running = false
    for _, conn in ipairs(Plant._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Plant._connections = {}
end

function Plant.getStats()
    return Plant._stats
end

return Plant
