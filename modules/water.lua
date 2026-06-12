--[[
    GAG Hub - Auto Water Module
    Auto-waters plants in player's garden.
    
    Remote: WateringCan.UseWateringCan(position)
    Also uses: Place.PlaceSprinkler for auto-sprinkler placement
]]

local Water = {}

Water._running = false
Water._thread  = nil
Water._connections = {}
Water._stats = { watered = 0, scans = 0, errors = 0 }

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Water.start(config, Net, Utils)
    if Water._running then return end
    Water._running = true

    local interval = config.Timings.WaterInterval or 3

    Water._thread = task.spawn(function()
        while Water._running do
            Water._waterPlants(config, Net, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Auto-Water started")
end

---------------------------------------------------------------
-- WATER PLANTS
---------------------------------------------------------------

function Water._waterPlants(config, Net, Utils)
    local garden = Utils.getMyGarden()
    if not garden then return end

    Water._stats.scans += 1
    local plants = Utils.getPlantsInGarden(garden)

    for _, plant in ipairs(plants) do
        local info = Utils.getPlantInfo(plant)
        if info then
            -- Check if plant needs water (Growth < 1 and not fully grown)
            local needsWater = info.Growth < 1

            if needsWater or config.Water.WaterAll then
                -- Get plant position for watering can
                local rootPart = plant:FindFirstChildWhichIsA("BasePart")
                if rootPart then
                    -- METHOD 1: Use watering can remote
                    local ok = Net.fire("WateringCan.UseWateringCan", rootPart.Position)
                    if ok then
                        Water._stats.watered += 1
                    else
                        Water._stats.errors += 1
                    end
                end
            end
        end
    end
end

---------------------------------------------------------------
-- AUTO SPRINKLER (place sprinklers in garden)
---------------------------------------------------------------

function Water.placeSprinkler(Net, Utils, sprinklerType)
    local garden = Utils.getMyGarden()
    if not garden then return false end

    -- Find center of garden
    local spawnPoint = garden:FindFirstChild("SpawnPoint")
    local position = spawnPoint and spawnPoint.Position or Vector3.new(0, 0, 0)

    local ok = Net.fire("Place.PlaceSprinkler", position, sprinklerType or "Common Sprinkler")
    return ok
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Water.stop()
    Water._running = false
    for _, conn in ipairs(Water._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Water._connections = {}
end

function Water.getStats()
    return Water._stats
end

return Water
