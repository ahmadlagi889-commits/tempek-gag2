--[[
    GAG HUB - All-in-One
    Single file. No sub-module loading. Paste & play.
    Usage: loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadlagi889-commits/tempek-gag2/main/hub.lua"))()
]]

if not game or not game:GetService("Players") then
    error("[GAG Hub] Must run inside Roblox game")
end

---------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------

local Config = {
    Features = {
        AutoHarvest = false, AutoSell = false, AutoWater = false,
        AutoPlant = false, RestockSniper = false, MutationTracker = false,
        WeatherBot = false, StealBot = false, InventoryOptimizer = false,
        AntiAfk = true,
    },
    Timings = {
        HarvestInterval = 2, SellInterval = 5, WaterInterval = 3,
        PlantInterval = 5, RestockPollInterval = 1, WeatherPollInterval = 5,
        StealInterval = 1.5, InventoryCheckInterval = 10,
    },
    Restock = {
        TargetSeeds = {
            "Grape", "Mango", "Dragon Fruit", "Mushroom", "Coconut",
            "Cherry", "Pomegranate", "Moon Bloom", "Dragon's Breath",
            "Ghost Pepper", "Sunflower", "Venus Fly Trap", "Lotus", "Romanesco",
        },
        MaxSpendPerCycle = 500000,
        BlacklistedSeeds = { "Carrot", "Strawberry", "Tomato" },
    },
    Steal = { MinFruitValue = 100, MaxAttemptsPerNight = 20, PreferMutations = true },
    Sell = { Mode = "all", UseDailyDeal = false },
    Plant = { OnlyEmptyPlots = true },
    Water = { WaterAll = false },
    Inventory = { FavoriteThreshold = 500, AutoPromote = true, DropThreshold = 5 },
    Mutation = {
        AlertMutations = { "Rainbow", "Starstruck", "Gold", "Frozen", "Electric", "Bloodlit", "Chained" },
        PriceMultipliers = { Gold = 20, Rainbow = 50, Electric = 12, Frozen = 10, Bloodlit = 5, Chained = 8, Starstruck = 100 },
        LogToConsole = true,
    },
    UI = { Title = "GAG Hub", Subtitle = "Grow A Garden Automation", NotifyDuration = 5 },
}

function Config.Notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "GAG Hub", Text = text or "",
            Duration = duration or Config.UI.NotifyDuration,
        })
    end)
end

---------------------------------------------------------------
-- CORE: NETWORKING (inlined from core/networking.lua)
---------------------------------------------------------------

local Networking = {}
local RS = game:GetService("ReplicatedStorage")

-- Internal cache
Networking._module = nil
Networking._cache = {}
Networking._connections = {}
Networking._log = true

---------------------------------------------------------------
-- RESOLVE NETWORKING MODULE
---------------------------------------------------------------

function Networking._resolve()
    if Networking._module then return Networking._module end

    -- Try the standard path
    local ok, result = pcall(function()
        local shared = RS:WaitForChild("SharedModules", 10)
        if not shared then error("SharedModules not found") end
        local net = shared:WaitForChild("Networking", 10)
        if not net then error("Networking not found") end
        return require(net)
    end)

    if ok and result then
        Networking._module = result
        return result
    end

    warn("[GAG Hub] Failed to resolve Networking module:", result)
    return nil
end

---------------------------------------------------------------
-- RESOLVE REMOTE BY DOT PATH
-- e.g., "Garden.CollectFruit" → Networking.Garden.CollectFruit
---------------------------------------------------------------

function Networking._resolveRemote(path)
    -- Check cache
    if Networking._cache[path] then return Networking._cache[path] end

    local net = Networking._resolve()
    if not net then return nil end

    local current = net
    for segment in string.gmatch(path, "[^%.]+") do
        if type(current) ~= "table" then
            warn("[GAG Hub] Remote path broken at segment:", segment, "in", path)
            return nil
        end
        current = current[segment]
        if current == nil then
            -- Try searching by iterating keys (case-insensitive fallback)
            for k, v in pairs(current or {}) do
                if string.lower(k) == string.lower(segment) then
                    current = v
                    break
                end
            end
            if current == nil then
                warn("[GAG Hub] Remote not found:", segment, "in path", path)
                return nil
            end
        end
    end

    Networking._cache[path] = current
    return current
end

---------------------------------------------------------------
-- FIRE (RemoteEvent → server)
---------------------------------------------------------------

function Networking.fire(path, ...)
    local remote = Networking._resolveRemote(path)
    if not remote then
        warn("[GAG Hub] Cannot fire - remote not found:", path)
        return false
    end

    local args = {...}
    local argc = select("#", ...)
    local ok, err = pcall(function()
        if remote.Fire then
            remote:Fire(unpack(args, 1, argc))
        elseif type(remote) == "table" and remote.fire then
            remote:fire(unpack(args, 1, argc))
        else
            error("Remote has no :Fire method - type: " .. typeof(remote))
        end
    end)

    if not ok then
        warn("[GAG Hub] Fire error on", path, ":", err)
        return false
    end

    if Networking._log then
        print("[GAG Hub] Fired:", path)
    end
    return true
end

---------------------------------------------------------------
-- INVOKE (RemoteFunction → server → response)
---------------------------------------------------------------

function Networking.invoke(path, ...)
    local remote = Networking._resolveRemote(path)
    if not remote then
        warn("[GAG Hub] Cannot invoke - remote not found:", path)
        return nil
    end

    local args = {...}
    local argc = select("#", ...)
    local ok, result = pcall(function()
        if remote.Invoke then
            return remote:Invoke(unpack(args, 1, argc))
        else
            error("Remote has no :Invoke method")
        end
    end)

    if not ok then
        warn("[GAG Hub] Invoke error on", path, ":", result)
        return nil
    end

    return result
end

---------------------------------------------------------------
-- LISTEN (RemoteEvent ← server)
---------------------------------------------------------------

function Networking.on(path, callback)
    local remote = Networking._resolveRemote(path)
    if not remote then
        warn("[GAG Hub] Cannot listen - remote not found:", path)
        return nil
    end

    local ok, connection = pcall(function()
        if remote.OnClientEvent then
            return remote.OnClientEvent:Connect(callback)
        elseif remote.Connect then
            return remote:Connect(callback)
        else
            -- Try the .Changed pattern or direct connect
            warn("[GAG Hub] Remote has no OnClientEvent:", path)
            return nil
        end
    end)

    if ok and connection then
        table.insert(Networking._connections, connection)
        return connection
    end
    return nil
end

---------------------------------------------------------------
-- BATCH LISTEN (connect multiple events at once)
---------------------------------------------------------------

function Networking.onMany(map)
    local connections = {}
    for path, callback in pairs(map) do
        local conn = Networking.on(path, callback)
        if conn then
            connections[path] = conn
        end
    end
    return connections
end

---------------------------------------------------------------
-- GET RAW REMOTE (for advanced usage)
---------------------------------------------------------------

function Networking.get(path)
    return Networking._resolveRemote(path)
end

---------------------------------------------------------------
-- CHECK IF REMOTE EXISTS
---------------------------------------------------------------

function Networking.exists(path)
    return Networking._resolveRemote(path) ~= nil
end

---------------------------------------------------------------
-- LOGGING
---------------------------------------------------------------

function Networking.setLogging(enabled)
    Networking._log = enabled
end

---------------------------------------------------------------
-- DISCONNECT ALL
---------------------------------------------------------------

function Networking.disconnectAll()
    for _, conn in ipairs(Networking._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Networking._connections = {}
end

---------------------------------------------------------------
-- CACHE REFRESH (call after game update)
---------------------------------------------------------------

function Networking.refreshCache()
    Networking._module = nil
    Networking._cache = {}
    Networking._resolve()
end

---------------------------------------------------------------
-- AUTO-INIT
---------------------------------------------------------------

Networking._resolve()


---------------------------------------------------------------
-- CORE: UTILITIES (inlined from core/utils.lua)
---------------------------------------------------------------

local Utils = {}
local Players = game:GetService("Players")
local RS      = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

---------------------------------------------------------------
-- INSTANCE RESOLVER
---------------------------------------------------------------

-- Resolve dot-path: "A.B.C" → A.B.C
function Utils.resolve(root, path)
    if not root or not path then return nil end
    local current = root
    for segment in string.gmatch(path, "[^%.]+") do
        current = current:FindFirstChild(segment)
        if not current then return nil end
    end
    return current
end

-- Safe resolve with WaitForChild (timeout)
function Utils.resolveWait(root, path, timeout)
    if not root or not path then return nil end
    local current = root
    for segment in string.gmatch(path, "[^%.]+") do
        current = current:WaitForChild(segment, timeout or 10)
        if not current then return nil end
    end
    return current
end

---------------------------------------------------------------
-- PLAYER HELPERS
---------------------------------------------------------------

function Utils.getLocalPlayer()
    return Players.LocalPlayer
end

function Utils.getCharacter()
    local lp = Players.LocalPlayer
    return lp and lp.Character or nil
end

function Utils.getHumanoidRootPart()
    local char = Utils.getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

function Utils.getHumanoid()
    local char = Utils.getCharacter()
    return char and char:FindFirstChildWhichIsA("Humanoid")
end

function Utils.getPlotId()
    local lp = Players.LocalPlayer
    return lp and lp:GetAttribute("PlotId")
end

function Utils.getMyGarden()
    local plotId = Utils.getPlotId()
    if not plotId then return nil end
    local gardens = workspace:FindFirstChild("Gardens")
    if not gardens then return nil end
    return gardens:FindFirstChild("Plot" .. tostring(plotId))
end

---------------------------------------------------------------
-- GARDEN HELPERS
---------------------------------------------------------------

-- Get all plants in a garden plot
function Utils.getPlantsInGarden(garden)
    if not garden then return {} end
    local plants = {}
    for _, child in ipairs(garden:GetDescendants()) do
        if child:IsA("Model") and child:GetAttribute("SeedName") then
            table.insert(plants, child)
        end
    end
    return plants
end

-- Get plant info from attributes
function Utils.getPlantInfo(plant)
    if not plant then return nil end
    return {
        Name     = plant:GetAttribute("SeedName") or plant.Name,
        Growth   = plant:GetAttribute("Growth") or 0,
        Mutation = plant:GetAttribute("Mutation"),
        Age      = plant:GetAttribute("Age") or 0,
        Size     = plant:GetAttribute("Size") or 1,
        IsRipe   = (plant:GetAttribute("Growth") or 0) >= 1,
        Owner    = plant:GetAttribute("Owner"),
        Instance = plant,
    }
end

-- Get all fruits in a garden
function Utils.getFruitsInGarden(garden)
    if not garden then return {} end
    local fruits = {}
    for _, child in ipairs(garden:GetDescendants()) do
        if child:GetAttribute("FruitName") or child:GetAttribute("IsFruit") then
            table.insert(fruits, child)
        end
    end
    return fruits
end

-- Get all gardens in workspace
function Utils.getAllGardens()
    local gardens = workspace:FindFirstChild("Gardens")
    if not gardens then return {} end
    local result = {}
    for _, garden in ipairs(gardens:GetChildren()) do
        table.insert(result, garden)
    end
    return result
end

---------------------------------------------------------------
-- VALUE CALCULATOR
---------------------------------------------------------------

-- Calculate fruit sell value (mirrors FruitValueCalc)
-- baseValue * size^exponent * mutationMult * sizeMult
function Utils.calculateFruitValue(seedName, size, mutation, sellData, mutationData)
    local base = sellData and sellData[seedName] or 0
    local sizeExponent = 2.65
    local sizeMult = 1
    local mutationMult = 1

    if mutation and mutationData then
        local mData = mutationData[mutation]
        mutationMult = mData and mData.PriceMultiplier or 1
    end

    local value = base * (size ^ sizeExponent) * sizeMult * mutationMult
    return math.floor(value)
end

---------------------------------------------------------------
-- INVENTORY HELPERS
---------------------------------------------------------------

-- Get backpack contents
function Utils.getBackpackItems()
    local lp = Players.LocalPlayer
    local bp = lp and lp:FindFirstChild("Backpack")
    if not bp then return {} end
    local items = {}
    for _, tool in ipairs(bp:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(items, {
                Name = tool.Name,
                Instance = tool,
                Type = tool:GetAttribute("ItemType") or "Unknown",
            })
        end
    end
    return items
end

-- Get equipped tool
function Utils.getEquippedTool()
    local char = Utils.getCharacter()
    if not char then return nil end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Tool") then
            return child
        end
    end
    return nil
end

---------------------------------------------------------------
-- NIGHT CHECK
---------------------------------------------------------------

function Utils.isNight()
    local night = RS:FindFirstChild("Night")
    if night then return night.Value == true end
    -- Fallback: check lighting
    local clock = game:GetService("Lighting").ClockTime
    return clock >= 18 or clock < 6
end

---------------------------------------------------------------
-- SHECKLE BALANCE
---------------------------------------------------------------

function Utils.getSheckles()
    local lp = Players.LocalPlayer
    local leaderstats = lp and lp:FindFirstChild("leaderstats")
    if not leaderstats then return 0 end
    local sheckles = leaderstats:FindFirstChild("Sheckles")
    return sheckles and sheckles.Value or 0
end

---------------------------------------------------------------
-- SAFE CALL
---------------------------------------------------------------

function Utils.safeCall(fn, ...)
    local ok, result = pcall(fn, ...)
    if not ok then
        warn("[GAG Hub] Error:", result)
    end
    return ok, result
end

---------------------------------------------------------------
-- TABLE HELPERS
---------------------------------------------------------------

function Utils.tableContains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then return true end
    end
    return false
end

function Utils.tableKeys(tbl)
    local keys = {}
    for k in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

function Utils.deepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Utils.deepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

---------------------------------------------------------------
-- STRING HELPERS
---------------------------------------------------------------

function Utils.formatNumber(n)
    if n >= 1e12 then return string.format("%.1fT", n / 1e12) end
    if n >= 1e9  then return string.format("%.1fB", n / 1e9) end
    if n >= 1e6  then return string.format("%.1fM", n / 1e6) end
    if n >= 1e3  then return string.format("%.1fK", n / 1e3) end
    return tostring(n)
end

function Utils.formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    if h > 0 then return string.format("%dh %dm %ds", h, m, s) end
    if m > 0 then return string.format("%dm %ds", m, s) end
    return string.format("%ds", s)
end

---------------------------------------------------------------
-- SIGNAL (simple event)
---------------------------------------------------------------

function Utils.createSignal()
    local signal = {}
    signal._bindables = {}

    function signal:Connect(fn)
        local connection = { _fn = fn, _connected = true }
        table.insert(signal._bindables, connection)
        function connection:Disconnect()
            self._connected = false
        end
        return connection
    end

    function signal:Fire(...)
        for _, conn in ipairs(signal._bindables) do
            if conn._connected then
                task.spawn(conn._fn, ...)
            end
        end
    end

    return signal
end


---------------------------------------------------------------
-- CORE: ANTI-AFK (inlined from core/antiafk.lua)
---------------------------------------------------------------

local AntiAfk = {}
local Players    = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local GuiService  = game:GetService("GuiService")
local RS          = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer

AntiAfk._running = false
AntiAfk._thread  = nil
AntiAfk._rejoinThread = nil
AntiAfk._stats   = { actions = 0, rejoins = 0, lastAction = 0 }

---------------------------------------------------------------
-- ANTI-AFK
---------------------------------------------------------------

function AntiAfk.start(config)
    if AntiAfk._running then return end
    AntiAfk._running = true

    local interval = config.Timings.AntiAfkInterval or 60

    AntiAfk._thread = task.spawn(function()
        while AntiAfk._running do
            -- Method 1: VirtualUser click (most reliable)
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)

            -- Method 2: Simulate movement
            pcall(function()
                local humanoid = LP.Character
                    and LP.Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    humanoid.Jump = true
                end
            end)

            -- Method 3: Fire game's anti-AFK remote if available
            pcall(function()
                local Net = require(
                    RS:WaitForChild("SharedModules"):WaitForChild("Networking")
                )
                if Net.AntiAfk and Net.AntiAfk.RequestHop then
                    -- Only fire if idle long enough (game tracks this)
                end
            end)

            AntiAfk._stats.actions += 1
            AntiAfk._stats.lastAction = os.time()
            task.wait(interval)
        end
    end)

    -- Also handle the idle kicked event
    LP.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)

    print("[GAG Hub] Anti-AFK started (interval: " .. interval .. "s)")
end

function AntiAfk.stop()
    AntiAfk._running = false
    if AntiAfk._thread then
        task.cancel(AntiAfk._thread)
        AntiAfk._thread = nil
    end
end

---------------------------------------------------------------
-- AUTO-REJOIN
---------------------------------------------------------------

function AntiAfk.startAutoRejoin(config)
    if AntiAfk._rejoinThread then return end

    local delay = config.Timings.RejoinDelay or 5

    -- Handle disconnection
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay
        .ChildAdded:Connect(function(child)
            if child.Name == "ErrorPrompt" or child.Name == "TeleportPrompt" then
                AntiAfk._stats.rejoins += 1
                task.wait(delay)
                pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(
                        game.PlaceId,
                        game.JobId,
                        LP
                    )
                end)
            end
        end)

    -- Handle kick messages
    game:GetService("GuiService").ErrorMessageChanged:Connect(function()
        AntiAfk._stats.rejoins += 1
        task.wait(delay)
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
        end)
    end)

    -- Handle character death (auto-respawn)
    LP.CharacterAdded:Connect(function(char)
        local humanoid = char:WaitForChild("Humanoid", 10)
        if humanoid then
            humanoid.Died:Connect(function()
                task.wait(3)
                pcall(function()
                    LP:LoadCharacter()
                end)
            end)
        end
    end)

    print("[GAG Hub] Auto-Rejoin enabled")
end

function AntiAfk.getStats()
    return AntiAfk._stats
end


---------------------------------------------------------------
-- MODULE REGISTRY
---------------------------------------------------------------

local Modules = {}
local Running = {}

local function startModule(name)
    if Running[name] then return end
    local mod = Modules[name]
    if mod and mod.start then
        mod.start(Config, Networking, Utils)
        Running[name] = true
        print("[GAG Hub] Started:", name)
    end
end

local function stopModule(name)
    if not Running[name] then return end
    local mod = Modules[name]
    if mod and mod.stop then
        mod.stop()
        Running[name] = false
        print("[GAG Hub] Stopped:", name)
    end
end

local function toggleModule(name)
    if Running[name] then stopModule(name) else startModule(name) end
    Config.Features[name] = Running[name]
end

---------------------------------------------------------------
-- MODULE: AUTO HARVEST
---------------------------------------------------------------

Modules.AutoHarvest = {}
do
    local M = Modules.AutoHarvest
    local Harvest = M
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

end

---------------------------------------------------------------
-- MODULE: AUTO SELL
---------------------------------------------------------------

Modules.AutoSell = {}
do
    local M = Modules.AutoSell
    local Sell = M
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

end

---------------------------------------------------------------
-- MODULE: AUTO WATER
---------------------------------------------------------------

Modules.AutoWater = {}
do
    local M = Modules.AutoWater
    local Water = M
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

end

---------------------------------------------------------------
-- MODULE: AUTO PLANT
---------------------------------------------------------------

Modules.AutoPlant = {}
do
    local M = Modules.AutoPlant
    local Plant = M
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

end

---------------------------------------------------------------
-- MODULE: RESTOCK SNIPER
---------------------------------------------------------------

Modules.RestockSniper = {}
do
    local M = Modules.RestockSniper
    local Restock = M
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

end

---------------------------------------------------------------
-- MODULE: MUTATION TRACKER
---------------------------------------------------------------

Modules.MutationTracker = {}
do
    local M = Modules.MutationTracker
    local Mutation = M
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

end

---------------------------------------------------------------
-- MODULE: WEATHER BOT
---------------------------------------------------------------

Modules.WeatherBot = {}
do
    local M = Modules.WeatherBot
    local Weather = M
Weather._running = false
Weather._thread  = nil
Weather._connections = {}
Weather._stats = { events = 0, alerts = 0, scans = 0 }
Weather._currentWeather = "Unknown"
Weather._currentPhase   = "Unknown"
Weather._weatherLog = {}

---------------------------------------------------------------
-- WEATHER TYPES (from decompiled TimeCycleController)
---------------------------------------------------------------

Weather.Phases = {
    Day         = { color = "☀️", value = "Day" },
    Sunset      = { color = "🌅", value = "Sunset" },
    Moon        = { color = "🌙", value = "Moon" },
    Bloodmoon   = { color = "🔴", value = "Bloodmoon", rare = true },
    Goldmoon    = { color = "🟡", value = "Goldmoon", rare = true },
    Rainbow     = { color = "🌈", value = "Rainbow", rare = true },
    Chained     = { color = "⛓️", value = "Chained Moon", rare = true },
    Pizza       = { color = "🍕", value = "Pizza Moon" },
}

---------------------------------------------------------------
-- START
---------------------------------------------------------------

function Weather.start(config, Net, Utils)
    if Weather._running then return end
    Weather._running = true

    local interval = config.Timings.WeatherPollInterval or 5
    local weatherConfig = config.Weather or {}

    -- Listen for weather effect events
    local weatherEvents = {
        "WeatherEffects.BloodmoonBeam",
        "WeatherEffects.RainbowStart",
        "WeatherEffects.RainbowEnd",
        "WeatherEffects.GoldMoonStrike",
        "WeatherEffects.RainbowMoonStrike",
        "WeatherEffects.BlizzardStart",
        "WeatherEffects.BlizzardEnd",
        "WeatherEffects.ShootingStar",
        "WeatherEffects.ChainPull",
    }

    for _, eventPath in ipairs(weatherEvents) do
        local conn = Net.on(eventPath, function(...)
            Weather._onWeatherEvent(eventPath, weatherConfig, Utils, ...)
        end)
        if conn then
            table.insert(Weather._connections, conn)
        end
    end

    -- Listen for time cycle changes
    local RS = game:GetService("ReplicatedStorage")
    local nightValue = RS:FindFirstChild("Night")
    if nightValue then
        local conn = nightValue.Changed:Connect(function(isNight)
            if isNight then
                Weather._currentPhase = "Night"
                Weather._logEvent("Night", "Night cycle started")
            else
                Weather._currentPhase = "Day"
                Weather._logEvent("Day", "Day cycle started")
            end
        end)
        table.insert(Weather._connections, conn)
    end

    -- Periodic scan of weather state
    Weather._thread = task.spawn(function()
        while Weather._running do
            Weather._scanWeather(weatherConfig, Utils)
            task.wait(interval)
        end
    end)

    print("[GAG Hub] Weather Bot started")
end

---------------------------------------------------------------
-- ON WEATHER EVENT
---------------------------------------------------------------

function Weather._onWeatherEvent(eventPath, config, Utils, ...)
    local args = {...}
    Weather._stats.events += 1

    -- Extract weather type from event path
    local weatherType = eventPath:match("WeatherEffects%.(.+)")
    if not weatherType then return end

    -- Determine if this is an alert-worthy event
    local isSpecial = false
    for _, name in ipairs(config.AlertEvents or {}) do
        if weatherType:match(name) then
            isSpecial = true
            break
        end
    end

    -- Alert for all start events
    if weatherType:match("Start") or weatherType:match("Strike") or
       weatherType:match("Beam") or weatherType:match("Star") then
        isSpecial = true
    end

    if isSpecial then
        Weather._stats.alerts += 1
        local emoji = "🌤️"
        for _, phase in pairs(Weather.Phases) do
            if weatherType:match(phase.value) then
                emoji = phase.color
                break
            end
        end

        local msg = emoji .. " " .. weatherType .. " event detected!"
        print("[GAG Hub] " .. msg)
        Config.Notify("Weather Event!", msg, 10)

        -- Execute configured action
        local action = config.Actions and config.Actions[weatherType]
        if action == "harvest_priority" then
            print("[GAG Hub] Priority harvest triggered by weather event")
        end

        -- Play sound
        if config.PlaySound then
            pcall(function()
                local SoundService = game:GetService("SoundService")
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://6518811702"
                sound.Volume = 0.8
                sound.Parent = SoundService
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 3)
            end)
        end
    end

    Weather._logEvent(weatherType, "Weather event fired")
end

---------------------------------------------------------------
-- SCAN WEATHER STATE
---------------------------------------------------------------

function Weather._scanWeather(config, Utils)
    Weather._stats.scans += 1

    -- Check moon phase from workspace or ReplicatedStorage
    local RS = game:GetService("ReplicatedStorage")

    -- Check if night
    local isNight = Utils.isNight()

    -- Try to read current moon phase
    local moonPhase = nil
    pcall(function()
        local lighting = game:GetService("Lighting")
        -- Some games store weather in lighting attributes
        moonPhase = lighting:GetAttribute("MoonPhase")
            or lighting:GetAttribute("CurrentPhase")
    end)

    -- Check workspace for weather indicators
    pcall(function()
        local weatherFolder = workspace:FindFirstChild("Weather")
            or workspace:FindFirstChild("WeatherEffects")
        if weatherFolder then
            for _, child in ipairs(weatherFolder:GetChildren()) do
                if child:IsA("BoolValue") and child.Value then
                    Weather._currentWeather = child.Name
                end
            end
        end
    end)

    -- Update phase
    if isNight and Weather._currentPhase == "Day" then
        Weather._currentPhase = "Night"
        Weather._logEvent("Phase", "Transition to Night")
    elseif not isNight and Weather._currentPhase ~= "Day" then
        Weather._currentPhase = "Day"
        Weather._logEvent("Phase", "Transition to Day")
    end
end

---------------------------------------------------------------
-- LOG
---------------------------------------------------------------

function Weather._logEvent(eventType, description)
    table.insert(Weather._weatherLog, {
        type = eventType,
        desc = description,
        time = os.time(),
        phase = Weather._currentPhase,
    })
    if #Weather._weatherLog > 200 then
        table.remove(Weather._weatherLog, 1)
    end
end

---------------------------------------------------------------
-- GETTERS
---------------------------------------------------------------

function Weather.getCurrentWeather()
    return Weather._currentWeather
end

function Weather.getCurrentPhase()
    return Weather._currentPhase
end

function Weather.getLog()
    return Weather._weatherLog
end

---------------------------------------------------------------
-- STOP / STATUS
---------------------------------------------------------------

function Weather.stop()
    Weather._running = false
    for _, conn in ipairs(Weather._connections) do
        pcall(function() conn:Disconnect() end)
    end
    Weather._connections = {}
end

function Weather.getStats()
    return Weather._stats
end

end

---------------------------------------------------------------
-- MODULE: STEAL BOT
---------------------------------------------------------------

Modules.StealBot = {}
do
    local M = Modules.StealBot
    local Steal = M
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

end

---------------------------------------------------------------
-- MODULE: INVENTORY OPTIMIZER
---------------------------------------------------------------

Modules.InventoryOptimizer = {}
do
    local M = Modules.InventoryOptimizer
    local Inventory = M
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

end

---------------------------------------------------------------
-- STATUS
---------------------------------------------------------------

local function getFullStatus()
    local lines = {"GAG HUB STATUS", "Sheckles: " .. Utils.formatNumber(Utils.getSheckles()), ""}
    for name, mod in pairs(Modules) do
        local st = Running[name] and "ON" or "OFF"
        local stats = mod.getStats and mod.getStats() or {}
        local parts = {}
        for k, v in pairs(stats) do parts[#parts+1] = k .. "=" .. tostring(v) end
        lines[#lines+1] = "  " .. st .. " " .. name .. ": " .. table.concat(parts, " | ")
    end
    return table.concat(lines, "\n")
end

---------------------------------------------------------------
-- RAYFIELD UI
---------------------------------------------------------------

local function createUI()
    local Rayfield = nil
    local ok = pcall(function()
        Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end)
    if not ok or not Rayfield then warn("[GAG Hub] Rayfield failed") return false end

    local Window = Rayfield:CreateWindow({
        Name = Config.UI.Title, LoadingTitle = Config.UI.Subtitle,
        ConfigurationSaving = { Enabled = true, FolderName = "GAGHub", FileName = "config" },
        Discord = { Enabled = false }, KeySystem = false,
    })

    local FarmTab = Window:CreateTab("Farming", nil)
    for _, e in ipairs({{"Auto Harvest","AutoHarvest"},{"Auto Sell","AutoSell"},{"Auto Water","AutoWater"},{"Auto Plant","AutoPlant"}}) do
        FarmTab:CreateToggle({Name=e[1],CurrentValue=false,Flag=e[2],Callback=function(v) if v then startModule(e[2]) else stopModule(e[2]) end end})
    end

    local ShopTab = Window:CreateTab("Shop", nil)
    ShopTab:CreateToggle({Name="Restock Sniper",CurrentValue=false,Flag="RestockSniper",Callback=function(v) if v then startModule("RestockSniper") else stopModule("RestockSniper") end end})

    local MutTab = Window:CreateTab("Mutations", nil)
    MutTab:CreateToggle({Name="Mutation Tracker",CurrentValue=false,Flag="MutationTracker",Callback=function(v) if v then startModule("MutationTracker") else stopModule("MutationTracker") end end})

    local WeatherTab = Window:CreateTab("Weather", nil)
    WeatherTab:CreateToggle({Name="Weather Bot",CurrentValue=false,Flag="WeatherBot",Callback=function(v) if v then startModule("WeatherBot") else stopModule("WeatherBot") end end})

    local StealTab = Window:CreateTab("Steal", nil)
    StealTab:CreateToggle({Name="Steal Bot (Night)",CurrentValue=false,Flag="StealBot",Callback=function(v) if v then startModule("StealBot") else stopModule("StealBot") end end})

    local InvTab = Window:CreateTab("Inventory", nil)
    InvTab:CreateToggle({Name="Inventory Optimizer",CurrentValue=false,Flag="InventoryOptimizer",Callback=function(v) if v then startModule("InventoryOptimizer") else stopModule("InventoryOptimizer") end end})

    local StatusTab = Window:CreateTab("Status", nil)
    StatusTab:CreateButton({Name="Refresh",Callback=function() Rayfield:Notify({Title="GAG Hub",Content=getFullStatus(),Duration=10}) end})
    StatusTab:CreateButton({Name="Enable All",Callback=function() for n in pairs(Modules) do startModule(n) end end})
    StatusTab:CreateButton({Name="Disable All",Callback=function() for n in pairs(Modules) do stopModule(n) end end})

    Rayfield:LoadConfiguration()
    return true
end

---------------------------------------------------------------
-- CONSOLE API
---------------------------------------------------------------

_G.GAGHub = {
    Config = Config, Modules = Modules, Net = Networking, Utils = Utils,
    toggle = function(name) toggleModule(name) print("[GAG Hub] " .. name .. ": " .. (Running[name] and "ON" or "OFF")) end,
    start = startModule, stop = stopModule,
    status = function() print(getFullStatus()) end,
    enableAll = function() for n in pairs(Modules) do startModule(n) end end,
    disableAll = function() for n in pairs(Modules) do stopModule(n) end end,
    stats = function(name) if Modules[name] and Modules[name].getStats then for k,v in pairs(Modules[name].getStats()) do print("  "..k..": "..tostring(v)) end end end,
}

---------------------------------------------------------------
-- STARTUP
---------------------------------------------------------------

local LP = Utils.getLocalPlayer()

LP.CharacterAdded:Connect(function()
    task.wait(3)
    for name, active in pairs(Running) do
        if active then task.spawn(function() stopModule(name) task.wait(1) startModule(name) end) end
    end
end)

task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    LP.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

task.spawn(createUI)
Config.Notify("GAG Hub Loaded!", "Toggle in UI or use _G.GAGHub API.", 5)
print("GAG HUB loaded! Console: _G.GAGHub")
