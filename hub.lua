--[[
    ╔══════════════════════════════════════════╗
    ║       GAG HUB - Dynamic HTTP Loader      ║
    ║       Grow A Garden Automation Suite      ║
    ╚══════════════════════════════════════════╝

    Single entry point. Loads all modules from GitHub raw.

    Usage (one-liner in executor):
        loadstring(game:HttpGet("https://raw.githubusercontent.com/USER/REPO/main/hub/hub.lua"))()
]]

---------------------------------------------------------------
-- CONFIG: SET YOUR GITHUB RAW BASE URL HERE
---------------------------------------------------------------

local GITHUB_USER   = "ahmadlagi889-commits"
local GITHUB_REPO   = "tempek-gag2"
local GITHUB_BRANCH = "main"
local GITHUB_FOLDER = ""  -- files at repo root

local BASE_URL
if GITHUB_FOLDER ~= "" then
    BASE_URL = string.format(
        "https://raw.githubusercontent.com/%s/%s/%s/%s",
        GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH, GITHUB_FOLDER
    )
else
    BASE_URL = string.format(
        "https://raw.githubusercontent.com/%s/%s/%s",
        GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH
    )
end

---------------------------------------------------------------
-- HTTP MODULE LOADER
---------------------------------------------------------------

local loadedModules = {}

local function httpLoad(path)
    if loadedModules[path] then return loadedModules[path] end

    local url = BASE_URL .. "/" .. path
    local ok, source = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok then
        warn("[GAG Hub] HTTP load failed:", path, "|", source)
        return nil
    end

    if not source or source == "" then
        warn("[GAG Hub] Empty response:", path)
        return nil
    end

    -- Check for GitHub 404 page
    if source:find("404") and source:find("Not Found") and #source < 500 then
        warn("[GAG Hub] File not found on GitHub:", path)
        return nil
    end

    local fn, err = loadstring(source, path)
    if not fn then
        warn("[GAG Hub] Parse error in:", path, "|", err)
        return nil
    end

    local runOk, result = pcall(fn)
    if not runOk then
        warn("[GAG Hub] Runtime error in:", path, "|", result)
        return nil
    end

    loadedModules[path] = result
    print("[GAG Hub] Loaded:", path)
    return result
end

---------------------------------------------------------------
-- ENVIRONMENT CHECK
---------------------------------------------------------------

if not game or not game:GetService("Players") then
    error("[GAG Hub] Must run inside Roblox game")
end

---------------------------------------------------------------
-- LOAD CORE MODULES
---------------------------------------------------------------

print("[GAG Hub] Loading from:", BASE_URL)

local Net    = httpLoad("core/networking.lua")
local Utils  = httpLoad("core/utils.lua")

if not Net then
    warn("[GAG Hub] CRITICAL: Networking module failed to load!")
    warn("[GAG Hub] Check URL:", BASE_URL .. "/core/networking.lua")
    return
end

if not Utils then
    warn("[GAG Hub] CRITICAL: Utils module failed to load!")
    return
end

---------------------------------------------------------------
-- CONFIG TABLE
---------------------------------------------------------------

local Config = {
    Features = {
        AutoHarvest = false,
        AutoSell = false,
        AutoWater = false,
        AutoPlant = false,
        RestockSniper = false,
        MutationTracker = false,
        WeatherBot = false,
        StealBot = false,
        InventoryOptimizer = false,
        AntiAfk = true,
        AutoRejoin = true,
    },
    Timings = {
        HarvestInterval = 2,
        SellInterval = 5,
        WaterInterval = 3,
        PlantInterval = 5,
        RestockPollInterval = 1,
        MutationScanInterval = 3,
        WeatherPollInterval = 5,
        StealInterval = 1.5,
        InventoryCheckInterval = 10,
        AntiAfkInterval = 60,
        RejoinDelay = 5,
    },
    Restock = {
        TargetSeeds = {
            "Grape", "Mango", "Dragon Fruit", "Mushroom",
            "Coconut", "Cherry", "Pomegranate", "Moon Bloom",
            "Dragon's Breath", "Ghost Pepper", "Sunflower",
            "Venus Fly Trap", "Lotus", "Romanesco",
        },
        MaxSpendPerCycle = 500000,
        BlacklistedSeeds = { "Carrot", "Strawberry", "Tomato" },
    },
    Steal = {
        MinFruitValue = 100,
        MaxAttemptsPerNight = 20,
        PreferMutations = true,
    },
    Sell = { Mode = "all", UseDailyDeal = false },
    Plant = { OnlyEmptyPlots = true },
    Water = { WaterAll = false },
    Inventory = {
        FavoriteThreshold = 500,
        AutoPromote = true,
        DropThreshold = 5,
    },
    Weather = {
        AlertEvents = {
            "Bloodmoon", "Rainbow", "GoldMoon",
            "Starstruck", "Blizzard", "Starfall",
        },
        PlaySound = true,
    },
    Mutation = {
        TrackAll = true,
        AlertMutations = {
            "Rainbow", "Starstruck", "Gold", "Frozen",
            "Electric", "Bloodlit", "Chained",
        },
        PriceMultipliers = {
            Gold = 20, Rainbow = 50, Electric = 12,
            Frozen = 10, Bloodlit = 5, Chained = 8,
            Starstruck = 100,
        },
        LogToConsole = true,
    },
    UI = {
        Title = "GAG Hub",
        Subtitle = "Grow A Garden Automation",
        NotifyDuration = 5,
    },
}

function Config.Notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "GAG Hub",
            Text = text or "",
            Duration = duration or Config.UI.NotifyDuration,
        })
    end)
end

---------------------------------------------------------------
-- MODULE REGISTRY
---------------------------------------------------------------

local Modules = {}
local Running = {}

-- Module loader: try HTTP first, fallback to inline
local function loadModule(name, path)
    -- Try HTTP load
    local mod = httpLoad(path)
    if mod then
        Modules[name] = mod
        return mod
    end

    -- Fallback: try local file (for dev)
    local localOk, localMod = pcall(function()
        local fn = loadfile(path)
        if fn then return fn() end
        return nil
    end)
    if localOk and localMod then
        Modules[name] = localMod
        return localMod
    end

    warn("[GAG Hub] Module not found:", name, "@", path)
    return nil
end

---------------------------------------------------------------
-- START / STOP
---------------------------------------------------------------

local function startModule(name)
    if Running[name] then return end
    local mod = Modules[name]
    if mod and mod.start then
        mod.start(Config, Net, Utils)
        Running[name] = true
        print("[GAG Hub] ✅ Started:", name)
    end
end

local function stopModule(name)
    if not Running[name] then return end
    local mod = Modules[name]
    if mod and mod.stop then
        mod.stop()
        Running[name] = false
        print("[GAG Hub] ❌ Stopped:", name)
    end
end

local function toggleModule(name)
    if Running[name] then
        stopModule(name)
    else
        startModule(name)
    end
    Config.Features[name] = Running[name]
end

---------------------------------------------------------------
-- LOAD ALL FEATURE MODULES
---------------------------------------------------------------

-- Each file must return a table: { start=function, stop=function, getStats=function }
loadModule("AutoHarvest",        "modules/harvest.lua")
loadModule("AutoSell",           "modules/sell.lua")
loadModule("AutoWater",          "modules/water.lua")
loadModule("AutoPlant",          "modules/plant.lua")
loadModule("RestockSniper",      "modules/restock.lua")
loadModule("MutationTracker",    "modules/mutation.lua")
loadModule("WeatherBot",         "modules/weather.lua")
loadModule("StealBot",           "modules/steal.lua")
loadModule("InventoryOptimizer", "modules/inventory.lua")

---------------------------------------------------------------
-- STATUS
---------------------------------------------------------------

local function getFullStatus()
    local lines = {}
    table.insert(lines, "═══ GAG HUB STATUS ═══")
    table.insert(lines, "Sheckles: " .. Utils.formatNumber(Utils.getSheckles()))
    table.insert(lines, "Phase: " .. (
        Modules.WeatherBot and Modules.WeatherBot.getPhase
        and Modules.WeatherBot.getPhase() or "Unknown"
    ))
    table.insert(lines, "Night: " .. tostring(Utils.isNight()))
    table.insert(lines, "")

    for name, mod in pairs(Modules) do
        local status = Running[name] and "✅" or "❌"
        local stats = mod.getStats and mod.getStats() or {}
        local parts = {}
        for k, v in pairs(stats) do
            table.insert(parts, k .. "=" .. tostring(v))
        end
        table.insert(lines, string.format("  %s %s: %s",
            status, name, table.concat(parts, " | ")))
    end

    return table.concat(lines, "\n")
end

---------------------------------------------------------------
-- RAYFIELD UI
---------------------------------------------------------------

local function createUI()
    local Rayfield = nil
    local ok, err = pcall(function()
        Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end)

    if not ok or not Rayfield then
        warn("[GAG Hub] Rayfield failed, using console mode only.")
        return false
    end

    local Window = Rayfield:CreateWindow({
        Name = Config.UI.Title,
        LoadingTitle = Config.UI.Subtitle,
        LoadingSubtitle = "Loading from GitHub...",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "GAGHub",
            FileName = "config",
        },
        Discord = { Enabled = false },
        KeySystem = false,
    })

    -- Farming Tab
    local FarmTab = Window:CreateTab("🌱 Farming", nil)

    FarmTab:CreateToggle({
        Name = "Auto Harvest",
        CurrentValue = false,
        Flag = "AutoHarvest",
        Callback = function(v)
            if v then startModule("AutoHarvest") else stopModule("AutoHarvest") end
        end,
    })

    FarmTab:CreateToggle({
        Name = "Auto Sell",
        CurrentValue = false,
        Flag = "AutoSell",
        Callback = function(v)
            if v then startModule("AutoSell") else stopModule("AutoSell") end
        end,
    })

    FarmTab:CreateToggle({
        Name = "Auto Water",
        CurrentValue = false,
        Flag = "AutoWater",
        Callback = function(v)
            if v then startModule("AutoWater") else stopModule("AutoWater") end
        end,
    })

    FarmTab:CreateToggle({
        Name = "Auto Plant",
        CurrentValue = false,
        Flag = "AutoPlant",
        Callback = function(v)
            if v then startModule("AutoPlant") else stopModule("AutoPlant") end
        end,
    })

    -- Shop Tab
    local ShopTab = Window:CreateTab("🛒 Shop", nil)

    ShopTab:CreateToggle({
        Name = "Restock Sniper",
        CurrentValue = false,
        Flag = "RestockSniper",
        Callback = function(v)
            if v then startModule("RestockSniper") else stopModule("RestockSniper") end
        end,
    })

    -- Mutation Tab
    local MutTab = Window:CreateTab("🧬 Mutations", nil)

    MutTab:CreateToggle({
        Name = "Mutation Tracker",
        CurrentValue = false,
        Flag = "MutationTracker",
        Callback = function(v)
            if v then startModule("MutationTracker")
            else stopModule("MutationTracker") end
        end,
    })

    MutTab:CreateLabel({
        Name = "Tracked: Rainbow, Starstruck, Gold, Frozen, Electric, Bloodlit, Chained"
    })

    -- Weather Tab
    local WeatherTab = Window:CreateTab("🌤️ Weather", nil)

    WeatherTab:CreateToggle({
        Name = "Weather Bot",
        CurrentValue = false,
        Flag = "WeatherBot",
        Callback = function(v)
            if v then startModule("WeatherBot") else stopModule("WeatherBot") end
        end,
    })

    -- Steal Tab
    local StealTab = Window:CreateTab("🌙 Steal", nil)

    StealTab:CreateToggle({
        Name = "Steal Bot (Night Only)",
        CurrentValue = false,
        Flag = "StealBot",
        Callback = function(v)
            if v then startModule("StealBot") else stopModule("StealBot") end
        end,
    })

    -- Inventory Tab
    local InvTab = Window:CreateTab("🎒 Inventory", nil)

    InvTab:CreateToggle({
        Name = "Inventory Optimizer",
        CurrentValue = false,
        Flag = "InventoryOptimizer",
        Callback = function(v)
            if v then startModule("InventoryOptimizer")
            else stopModule("InventoryOptimizer") end
        end,
    })

    -- Status Tab
    local StatusTab = Window:CreateTab("📊 Status", nil)

    StatusTab:CreateParagraph({
        Title = "Module Stats",
        Content = "Loading..."
    })

    StatusTab:CreateButton({
        Name = "Refresh Status",
        Callback = function()
            Rayfield:Notify({
                Title = "GAG Hub Status",
                Content = getFullStatus(),
                Duration = 10,
            })
        end,
    })

    StatusTab:CreateButton({
        Name = "Enable All Modules",
        Callback = function()
            for name in pairs(Modules) do startModule(name) end
            Rayfield:Notify({
                Title = "GAG Hub",
                Content = "All modules enabled!",
                Duration = 3,
            })
        end,
    })

    StatusTab:CreateButton({
        Name = "Disable All Modules",
        Callback = function()
            for name in pairs(Modules) do stopModule(name) end
            Rayfield:Notify({
                Title = "GAG Hub",
                Content = "All modules disabled.",
                Duration = 3,
            })
        end,
    })

    -- Remote Debug Tab
    local DebugTab = Window:CreateTab("🔧 Debug", nil)

    DebugTab:CreateButton({
        Name = "List Known Remotes",
        Callback = function()
            local count = 0
            local names = {}
            for path in pairs(Net._cache) do
                table.insert(names, path)
                count += 1
            end
            Rayfield:Notify({
                Title = "Remotes (" .. count .. ")",
                Content = table.concat(names, "\n"),
                Duration = 10,
            })
        end,
    })

    DebugTab:CreateButton({
        Name = "Refresh Networking Cache",
        Callback = function()
            Net._module = nil
            Net._cache = {}
            Net._resolve()
            Rayfield:Notify({
                Title = "GAG Hub",
                Content = "Networking cache refreshed!",
                Duration = 3,
            })
        end,
    })

    DebugTab:CreateButton({
        Name = "Re-download All Modules",
        Callback = function()
            -- Clear module cache and reload
            for k in pairs(loadedModules) do loadedModules[k] = nil end
            for name in pairs(Running) do stopModule(name) end
            for name in pairs(Modules) do Modules[name] = nil end

            loadModule("AutoHarvest",        "modules/harvest.lua")
            loadModule("AutoSell",           "modules/sell.lua")
            loadModule("AutoWater",          "modules/water.lua")
            loadModule("AutoPlant",          "modules/plant.lua")
            loadModule("RestockSniper",      "modules/restock.lua")
            loadModule("MutationTracker",    "modules/mutation.lua")
            loadModule("WeatherBot",         "modules/weather.lua")
            loadModule("StealBot",           "modules/steal.lua")
            loadModule("InventoryOptimizer", "modules/inventory.lua")

            Rayfield:Notify({
                Title = "GAG Hub",
                Content = "All modules re-downloaded from GitHub!",
                Duration = 5,
            })
        end,
    })

    Rayfield:LoadConfiguration()
    return true
end

---------------------------------------------------------------
-- CONSOLE API (always available)
---------------------------------------------------------------

_G.GAGHub = {
    Config = Config,
    Modules = Modules,
    Net = Net,
    Utils = Utils,
    BASE_URL = BASE_URL,
    httpLoad = httpLoad,

    toggle = function(name)
        toggleModule(name)
        print("[GAG Hub] " .. name .. ": " .. (Running[name] and "ON ✅" or "OFF ❌"))
    end,
    start = startModule,
    stop = stopModule,
    status = function() print(getFullStatus()) end,
    enableAll = function()
        for name in pairs(Modules) do startModule(name) end
    end,
    disableAll = function()
        for name in pairs(Modules) do stopModule(name) end
    end,
    stats = function(name)
        if Modules[name] and Modules[name].getStats then
            local s = Modules[name].getStats()
            print("[GAG Hub] " .. name .. ":")
            for k, v in pairs(s) do print("  " .. k .. ": " .. tostring(v)) end
        end
    end,
    netTest = function(path, ...)
        local args = {...}
        local argc = select("#", ...)
        print("[GAG Hub] Test:", path)
        print("  Exists:", Net.exists(path))
        if Net.exists(path) then
            print("  Fire:", Net.fire(path, unpack(args, 1, argc)))
        end
    end,
    reloadModule = function(name)
        stopModule(name)
        local pathMap = {
            AutoHarvest = "modules/harvest.lua",
            AutoSell = "modules/sell.lua",
            AutoWater = "modules/water.lua",
            AutoPlant = "modules/plant.lua",
            RestockSniper = "modules/restock.lua",
            MutationTracker = "modules/mutation.lua",
            WeatherBot = "modules/weather.lua",
            StealBot = "modules/steal.lua",
            InventoryOptimizer = "modules/inventory.lua",
        }
        local path = pathMap[name]
        if path then
            loadedModules[path] = nil  -- bust cache
            loadModule(name, path)
            print("[GAG Hub] Reloaded:", name)
        end
    end,
    -- Hot update: re-download a single module from GitHub
    hotReload = function(name)
        _G.GAGHub.reloadModule(name)
    end,
    -- Re-download everything
    fullReload = function()
        for k in pairs(loadedModules) do loadedModules[k] = nil end
        for name in pairs(Running) do stopModule(name) end
        for name in pairs(Modules) do Modules[name] = nil end
        Net._module = nil; Net._cache = {}; Net._resolve()

        loadModule("AutoHarvest",        "modules/harvest.lua")
        loadModule("AutoSell",           "modules/sell.lua")
        loadModule("AutoWater",          "modules/water.lua")
        loadModule("AutoPlant",          "modules/plant.lua")
        loadModule("RestockSniper",      "modules/restock.lua")
        loadModule("MutationTracker",    "modules/mutation.lua")
        loadModule("WeatherBot",         "modules/weather.lua")
        loadModule("StealBot",           "modules/steal.lua")
        loadModule("InventoryOptimizer", "modules/inventory.lua")
        print("[GAG Hub] Full reload complete!")
    end,
    listRemotes = function()
        for path in pairs(Net._cache) do print("  " .. path) end
    end,
}

---------------------------------------------------------------
-- STARTUP
---------------------------------------------------------------

local LP = Utils.getLocalPlayer()

-- Respawn handler: restart active modules after character reset
LP.CharacterAdded:Connect(function()
    task.wait(3)
    for name, active in pairs(Running) do
        if active then
            task.spawn(function()
                stopModule(name)
                task.wait(1)
                startModule(name)
            end)
        end
    end
end)

-- Anti-AFK (always on)
task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    LP.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("[GAG Hub] Anti-AFK: prevented kick")
    end)
end)

-- Create UI
local uiOk = task.spawn(createUI)

-- Done
Config.Notify("GAG Hub Loaded! 🌱",
    "Toggle features in UI or use _G.GAGHub API.", 5)

print("")
print("╔═══════════════════════════════════════════╗")
print("║        GAG HUB loaded successfully!       ║")
print("║                                           ║")
print("║  Console API:  _G.GAGHub                  ║")
print("║  Toggle:       _G.GAGHub.toggle('Name')   ║")
print("║  Status:       _G.GAGHub.status()          ║")
print("║  Hot reload:   _G.GAGHub.hotReload('Name') ║")
print("║  Full reload:  _G.GAGHub.fullReload()      ║")
print("║                                           ║")
print("║  Source: " .. BASE_URL)
print("╚═══════════════════════════════════════════╝")
print("")
