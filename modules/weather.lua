--[[
    GAG Hub - Weather Event Bot
    Monitors weather cycles and alerts on special events.
    
    Listens: WeatherController phases, moon cycles
    Also: WeatherEffects remotes
]]

local Weather = {}

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

return Weather
