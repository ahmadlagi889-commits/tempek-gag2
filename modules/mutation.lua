--[[
    GAG Hub - Mutation Tracker Module
    Monitors plant mutations and alerts on high-value ones.
    
    Listens: Garden.PlantMutationUpdated, Garden.FruitMutationUpdated
    Also reads: SharedModules.MutationData
]]

local Mutation = {}

Mutation._running = false
Mutation._thread  = nil
Mutation._connections = {}
Mutation._stats = { tracked = 0, alerts = 0, totalValue = 0 }
Mutation._mutationLog = {}

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Mutation.start(config, Net, Utils)
    if Mutation._running then return end
    Mutation._running = true

    local interval = config.Timings.MutationScanInterval or 3
    local mutConfig = config.Mutation or {}

    -- Load mutation data for price multipliers
    local RS = game:GetService("ReplicatedStorage")
    local mutationData = {}
    pcall(function()
        local shared = RS:WaitForChild("SharedModules", 10)
        if shared then
            local mData = shared:FindFirstChild("MutationData")
            if mData then
                mutationData = require(mData)
            end
        end
    end)

    -- Listen for real-time mutation events
    local plantMutConn = Net.on("Garden.PlantMutationUpdated",
        function(plantId, mutation)
            Mutation._onMutation("plant", plantId, mutation, mutConfig, Utils)
        end
    )
    if plantMutConn then
        table.insert(Mutation._connections, plantMutConn)
    end

    local fruitMutConn = Net.on("Garden.FruitMutationUpdated",
        function(plantId, fruitId, mutation)
            Mutation._onMutation("fruit", plantId, mutation, mutConfig, Utils)
        end
    )
    if fruitMutConn then
        table.insert(Mutation._connections, fruitMutConn)
    end

    -- Also listen for plant growth (sometimes mutation comes with growth update)
    local growthConn = Net.on("Garden.PlantGrowthUpdated",
        function(plantId, growth, size, mutation)
            if mutation and mutation ~= "" then
                Mutation._onMutation("growth", plantId, mutation, mutConfig, Utils)
            end
        end
    )
    if growthConn then
        table.insert(Mutation._connections, growthConn)
    end

    -- Periodic scan of own garden
    Mutation._thread = task.spawn(function()
        while Mutation._running do
            Mutation._scanGarden(mutConfig, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Mutation Tracker started")
end

---------------------------------------------------------------
-- ON MUTATION EVENT
---------------------------------------------------------------

function Mutation._onMutation(source, plantId, mutation, config, Utils)
    if not mutation or mutation == "" then return end

    Mutation._stats.tracked += 1

    local entry = {
        source   = source,
        plantId  = plantId,
        mutation = mutation,
        time     = os.time(),
        priceMult = config.PriceMultipliers[mutation] or 1,
    }

    table.insert(Mutation._mutationLog, entry)

    -- Keep log manageable
    if #Mutation._mutationLog > 500 then
        table.remove(Mutation._mutationLog, 1)
    end

    -- Check if this is an alert-worthy mutation
    local isAlert = false
    if config.TrackAll then
        isAlert = true
    else
        for _, name in ipairs(config.AlertMutations or {}) do
            if name == mutation then
                isAlert = true
                break
            end
        end
    end

    if isAlert then
        Mutation._stats.alerts += 1
        local mult = config.PriceMultipliers[mutation] or 1

        local msg = string.format("[%s] %s mutation: %s (x%d value)",
            source, tostring(plantId), mutation, mult)

        if config.LogToConsole then
            print("[GAG Hub] 🧬 " .. msg)
        end

        Config.Notify("🧬 Mutation Detected!", msg, 8)

        -- Play sound if available
        pcall(function()
            local SoundService = game:GetService("SoundService")
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://6518811702" -- notification sound
            sound.Volume = 0.5
            sound.Parent = SoundService
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 3)
        end)
    end
end

---------------------------------------------------------------
-- SCAN GARDEN FOR EXISTING MUTATIONS
---------------------------------------------------------------

function Mutation._scanGarden(config, Utils)
    local garden = Utils.getMyGarden()
    if not garden then return end

    local plants = Utils.getPlantsInGarden(garden)
    for _, plant in ipairs(plants) do
        local info = Utils.getPlantInfo(plant)
        if info and info.Mutation and info.Mutation ~= "" then
            -- Already tracked mutations are skipped
            -- This is mainly for initial discovery
            Mutation._stats.tracked += 1
        end
    end
end

---------------------------------------------------------------
-- GET MUTATION PRICE MULTIPLIER
---------------------------------------------------------------

function Mutation.getPriceMultiplier(mutationName, config)
    if config and config.PriceMultipliers then
        return config.PriceMultipliers[mutationName] or 1
    end
    return 1
end

---------------------------------------------------------------
-- GET MUTATION LOG
---------------------------------------------------------------

function Mutation.getLog()
    return Mutation._mutationLog
end

function Mutation.getLogByMutation(mutationName)
    local filtered = {}
    for _, entry in ipairs(Mutation._mutationLog) do
        if entry.mutation == mutationName then
            table.insert(filtered, entry)
        end
    end
    return filtered
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Mutation.stop()
    Mutation._running = false
    for _, conn in ipairs(Mutation._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Mutation._connections = {}
end

function Mutation.getStats()
    return Mutation._stats
end

return Mutation
