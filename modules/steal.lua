--[[
    GAG Hub - Steal Bot Module
    Auto-steals fruits from other players' gardens during night.
    
    Mechanic: Steal prompt only active at night
    Remote: Garden.CollectFruit via StealPrompt
    Gate: ReplicatedStorage.Night.Value == true
    Attribute: CarryingStolenFruit on player
]]

local Steal = {}

Steal._running = false
Steal._thread  = nil
Steal._connections = {}
Steal._stats = { attempts = 0, stolen = 0, returned = 0, errors = 0, nightCycles = 0 }

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Steal.start(config, Net, Utils)
    if Steal._running then return end
    Steal._running = true

    local interval = config.Timings.StealInterval or 1.5
    local stealConfig = config.Steal or {}

    Steal._thread = task.spawn(function()
        local wasNight = false

        while Steal._running do
            local isNight = Utils.isNight()

            -- Track night cycles
            if isNight and not wasNight then
                Steal._stats.nightCycles += 1
                print("[GAG Hub] 🌙 Night cycle started - Steal Bot active")
                Config.Notify("Steal Bot", "🌙 Night! Steal Bot activated.", 5)
            end

            if isNight then
                Steal._stealLoop(stealConfig, Net, Utils)
            elseif wasNight then
                print("[GAG Hub] ☀️ Day started - Steal Bot sleeping")
                -- Return stolen fruit to plot if still carrying
                Steal._returnFruit(Net, Utils)
            end

            wasNight = isNight
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Steal Bot started (waits for night)")
end

---------------------------------------------------------------
-- STEAL LOOP
---------------------------------------------------------------

function Steal._stealLoop(stealConfig, Net, Utils)
    local LP = Utils.getLocalPlayer()

    -- Check if already carrying stolen fruit
    local carrying = LP:GetAttribute("CarryingStolenFruit")
    if carrying then
        -- Return to own plot first
        Steal._returnFruit(Net, Utils)
        return
    end

    -- Check max attempts per night
    local maxAttempts = stealConfig.MaxAttemptsPerNight or 20
    if Steal._stats.attempts >= maxAttempts then
        return
    end

    -- Find target gardens (other players' gardens)
    local myPlotId = Utils.getPlotId()
    local allGardens = Utils.getAllGardens()

    for _, garden in ipairs(allGardens) do
        -- Skip own garden
        local gardenPlotId = garden.Name:match("Plot(%d+)")
        if gardenPlotId and tonumber(gardenPlotId) == myPlotId then
            continue
        end

        -- Find stealable fruits in this garden
        local plants = Utils.getPlantsInGarden(garden)
        for _, plant in ipairs(plants) do
            local info = Utils.getPlantInfo(plant)
            if info and info.IsRipe then
                -- Check value threshold
                if stealConfig.MinFruitValue then
                    -- Quick value estimate
                    local seedName = info.Name
                    local sellValue = Steal._estimateValue(seedName)
                    if sellValue < stealConfig.MinFruitValue then
                        continue
                    end
                end

                -- Check for mutation preference
                if stealConfig.PreferMutations and not info.Mutation then
                    -- Skip non-mutation fruits if preference set
                    -- (still steal if no mutation fruits available)
                end

                -- Attempt steal via proximity prompt
                Steal._attemptSteal(plant, Net, Utils)
                task.wait(0.5)

                -- Check if now carrying
                local nowCarrying = LP:GetAttribute("CarryingStolenFruit")
                if nowCarrying then
                    Steal._stats.stolen += 1
                    -- Return to own plot
                    Steal._returnFruit(Net, Utils)
                    return -- exit after successful steal
                end
            end
        end
    end
end

---------------------------------------------------------------
-- ATTEMPT STEAL ON A PLANT
---------------------------------------------------------------

function Steal._attemptSteal(plant, Net, Utils)
    Steal._stats.attempts += 1

    -- Method 1: Fire ProximityPrompt tagged as StealPrompt
    pcall(function()
        local CollectionService = game:GetService("CollectionService")
        for _, prompt in ipairs(CollectionService:GetTagged("StealPrompt")) do
            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                local promptParent = prompt.Parent
                -- Check if this prompt is near our target plant
                if promptParent and plant then
                    local dist = math.huge
                    pcall(function()
                        local hrp = promptParent:FindFirstChildWhichIsA("BasePart")
                        local plantPart = plant:FindFirstChildWhichIsA("BasePart")
                        if hrp and plantPart then
                            dist = (hrp.Position - plantPart.Position).Magnitude
                        end
                    end)

                    if dist < 5 then
                        if prompt.HoldDuration > 0 then
                            prompt:InputHoldBegin()
                            task.wait(prompt.HoldDuration + 0.1)
                            if prompt:IsDescendantOf(workspace) then
                                prompt:InputHoldEnd()
                            end
                        else
                            prompt:InputHoldEnd()
                        end
                        Steal._stats.attempts += 1
                    end
                end
            end
        end
    end)

    -- Method 2: Direct character proximity
    pcall(function()
        local hrp = Utils.getHumanoidRootPart()
        local plantPart = plant:FindFirstChildWhichIsA("BasePart")
        if hrp and plantPart then
            -- Teleport to plant (risky but effective)
            -- Only do this if teleport is supported by executor
            -- hrp.CFrame = plantPart.CFrame + Vector3.new(0, 3, 0)
            -- task.wait(0.3)
        end
    end)
end

---------------------------------------------------------------
-- RETURN FRUIT TO OWN PLOT
---------------------------------------------------------------

function Steal._returnFruit(Net, Utils)
    local LP = Utils.getLocalPlayer()
    local carrying = LP:GetAttribute("CarryingStolenFruit")
    if not carrying then return end

    local garden = Utils.getMyGarden()
    if not garden then return end

    -- Navigate to own garden
    local hrp = Utils.getHumanoidRootPart()
    local spawnPoint = garden:FindFirstChild("SpawnPoint")
    if hrp and spawnPoint then
        hrp.CFrame = spawnPoint.CFrame + Vector3.new(0, 3, 0)
        task.wait(1)
    end

    -- The game auto-deposits when you reach your plot
    Steal._stats.returned += 1
end

---------------------------------------------------------------
-- ESTIMATE FRUIT VALUE
---------------------------------------------------------------

function Steal._estimateValue(seedName)
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
    }
    return values[seedName] or 0
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Steal.stop()
    Steal._running = false
    for _, conn in ipairs(Steal._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Steal._connections = {}
end

function Steal.getStats()
    return Steal._stats
end

return Steal
