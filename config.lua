--[[
    GAG Hub - Configuration
    Central config for all modules.
    Update paths here when game patches.
]]

local Config = {}

---------------------------------------------------------------
-- PATHS (update these when game structure changes)
---------------------------------------------------------------
Config.Paths = {
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    Players           = game:GetService("Players"),
    Workspace         = game:GetService("Workspace"),
    RunService        = game:GetService("RunService"),
    UserInputService  = game:GetService("UserInputService"),
    StarterGui        = game:GetService("StarterGui"),
    TweenService      = game:GetService("TweenService"),
    HttpService       = game:GetService("HttpService"),
    Lighting          = game:GetService("Lighting"),
    SoundService      = game:GetService("SoundService"),
    CollectionService = game:GetService("CollectionService"),
    ProximityPromptService = game:GetService("ProximityPromptService"),
}

-- Remote module path (auto-resolved)
Config.NetworkingPath = "SharedModules.Networking"
Config.SeedDataPath   = "SharedModules.SeedData"
Config.SellValuePath  = "SharedModules.SellValueData"
Config.MutationPath   = "SharedModules.MutationData"
Config.EggDataPath    = "SharedModules.EggData"
Config.GearShopPath   = "SharedModules.GearShopData"
Config.GrowRatePath   = "SharedModules.GrowRateData"

-- Garden path in workspace
Config.GardenPath = "Gardens"
Config.NPCSPath   = "NPCS"
Config.StevenPath = "NPCS.Steven"

---------------------------------------------------------------
-- FEATURE TOGGLES
---------------------------------------------------------------
Config.Features = {
    AutoHarvest    = false,
    AutoSell       = false,
    AutoWater      = false,
    AutoPlant      = false,
    RestockSniper  = false,
    MutationTracker = false,
    WeatherBot     = false,
    StealBot       = false,
    InventoryOptimizer = false,
    AntiAfk        = true,   -- always on by default
    AutoRejoin     = true,
}

---------------------------------------------------------------
-- TIMINGS (seconds)
---------------------------------------------------------------
Config.Timings = {
    HarvestInterval     = 2,      -- scan interval for harvest
    SellInterval        = 5,      -- sell interval
    WaterInterval       = 3,      -- water scan interval
    PlantInterval       = 5,      -- plant check interval
    RestockPollInterval = 1,      -- poll restock timer
    MutationScanInterval = 3,    -- scan mutations
    WeatherPollInterval  = 5,    -- poll weather state
    StealInterval        = 1.5,  -- steal attempt interval
    InventoryCheckInterval = 10, -- inventory scan
    AntiAfkInterval       = 60,  -- anti-afk action interval
    RejoinDelay           = 5,   -- delay before rejoin attempt
}

---------------------------------------------------------------
-- RESTOCK SNIPER CONFIG
---------------------------------------------------------------
Config.Restock = {
    -- Seeds to auto-buy (priority order)
    TargetSeeds = {
        "Grape", "Mango", "Dragon Fruit", "Mushroom",
        "Coconut", "Cherry", "Pomegranate", "Moon Bloom",
        "Dragon's Breath", "Ghost Pepper", "Sunflower",
        "Venus Fly Trap", "Lotus", "Romanesco",
    },
    -- Max sheckles to spend per restock cycle
    MaxSpendPerCycle = 500000,
    -- Auto-buy threshold: buy if stock <= this
    MinStockToBuy = 1,
    -- Blacklist: never buy these
    BlacklistedSeeds = { "Carrot", "Strawberry", "Tomato" },
}

---------------------------------------------------------------
-- STEAL BOT CONFIG
---------------------------------------------------------------
Config.Steal = {
    -- Only steal fruits worth >= this base value
    MinFruitValue = 100,
    -- Max steal attempts per night cycle
    MaxAttemptsPerNight = 20,
    -- Prefer mutation fruits
    PreferMutations = true,
    -- Target gardens with high-value plants only
    TargetAllGardens = true,
}

---------------------------------------------------------------
-- AUTO-SELL CONFIG
---------------------------------------------------------------
Config.Sell = {
    -- Sell mode: "all", "below_threshold", "keep_best"
    Mode = "all",
    -- If Mode = "below_threshold", sell fruits worth < this
    ValueThreshold = 100,
    -- If Mode = "keep_best", keep top N fruits
    KeepTopN = 10,
    -- Use daily deal if available
    UseDailyDeal = false,
}

---------------------------------------------------------------
-- AUTO-PLANT CONFIG
---------------------------------------------------------------
Config.Plant = {
    -- Seed priority (plant these first)
    SeedPriority = {
        "Mushroom", "Moon Bloom", "Lotus", "Sunflower",
        "Venus Fly Trap", "Dragon's Breath", "Ghost Pepper",
        "Pomegranate", "Cherry", "Dragon Fruit", "Mango",
        "Grape", "Coconut", "Banana", "Pineapple",
    },
    -- Only plant if empty plot available
    OnlyEmptyPlots = true,
    -- Plant in pots or ground
    PreferPots = false,
}

---------------------------------------------------------------
-- AUTO-WATER CONFIG
---------------------------------------------------------------
Config.Water = {
    -- Water all plants or only dry ones
    WaterAll = false,
    -- Watering can tier (auto-detect if nil)
    CanTier = nil,
}

---------------------------------------------------------------
-- INVENTORY OPTIMIZER CONFIG
---------------------------------------------------------------
Config.Inventory = {
    -- Auto-favorite fruits worth >= this
    FavoriteThreshold = 500,
    -- Auto-promote fruits to inventory
    AutoPromote = true,
    -- Auto-drop fruits worth < this
    DropThreshold = 5,
    -- Sort inventory by value
    SortByValue = true,
}

---------------------------------------------------------------
-- WEATHER BOT CONFIG
---------------------------------------------------------------
Config.Weather = {
    -- Alert on these weather events
    AlertEvents = {
        "Bloodmoon", "Rainbow", "GoldMoon",
        "Starstruck", "Blizzard", "Starfall",
        "Chained", "Electric",
    },
    -- Auto-action on specific weather
    Actions = {
        Bloodmoon = "harvest_priority",
        Rainbow   = "harvest_priority",
        GoldMoon  = "harvest_priority",
    },
    -- Notification sound
    PlaySound = true,
}

---------------------------------------------------------------
-- MUTATION TRACKER CONFIG
---------------------------------------------------------------
Config.Mutation = {
    -- Track all mutations or specific ones
    TrackAll = true,
    -- Alert for these (high value)
    AlertMutations = {
        "Rainbow", "Starstruck", "Gold", "Frozen",
        "Electric", "Bloodlit", "Chained",
    },
    -- Price multipliers (from game data, update if patched)
    PriceMultipliers = {
        Gold      = 20,
        Rainbow   = 50,
        Electric  = 12,
        Frozen    = 10,
        Bloodlit  = 5,
        Chained   = 8,
        Starstruck = 100,
    },
    -- Log mutations to console
    LogToConsole = true,
}

---------------------------------------------------------------
-- UI CONFIG
---------------------------------------------------------------
Config.UI = {
    Title   = "GAG Hub",
    Subtitle = "Grow A Garden Automation",
    KeyBind = Enum.KeyCode.RightControl,
    NotifyDuration = 5,
    Theme = "Dark",
}

---------------------------------------------------------------
-- NOTIFICATION HELPER
---------------------------------------------------------------
function Config.Notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "GAG Hub",
            Text = text or "",
            Duration = duration or Config.UI.NotifyDuration,
        })
    end)
end

return Config
