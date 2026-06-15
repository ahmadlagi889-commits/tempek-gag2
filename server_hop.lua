--[[
    GAG2 — Auto Random Server Hop
    Standalone script. No hub.lua / loader.lua dependency.
    
    Usage:
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadlagi889-commits/tempek-gag2/main/server_hop.lua"))()
    
    What it does:
      1. Fetch public server list via Roblox API
      2. Filter out current server + low-player servers
      3. Pick random server from filtered list
      4. Teleport to it
      5. Repeat on interval (configurable)
    
    Supports: most executors (Synapse, Fluxus, Wave, Delta, etc.)
]]

if not game or not game:GetService("Players") then
    error("[ServerHop] Must run inside Roblox game")
end

---------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------

local Config = {
    -- Hop interval in seconds (0 = hop once, no repeat)
    HopInterval = 0,
    
    -- Minimum players in target server
    MinPlayers = 1,
    
    -- Maximum players in target server (0 = no limit)
    MaxPlayers = 0,
    
    -- Exclude current server
    ExcludeCurrent = true,
    
    -- Max pages to fetch (each page = up to 100 servers)
    MaxPages = 5,
    
    -- Delay before teleport (seconds)
    PreTeleportDelay = 1,
    
    -- Max retries per hop attempt
    MaxRetries = 5,
    
    -- Retry delay (seconds)
    RetryDelay = 3,
    
    -- Notification duration
    NotifyDuration = 5,
}

---------------------------------------------------------------
-- SERVICES
---------------------------------------------------------------

local Players       = game:GetService("Players")
local HttpService   = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local StarterGui    = game:GetService("StarterGui")

local LP = Players.LocalPlayer
local PlaceId = game.PlaceId
local CurrentJobId = game.JobId

---------------------------------------------------------------
-- UTILS
---------------------------------------------------------------

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "ServerHop",
            Text = text or "",
            Duration = duration or Config.NotifyDuration,
        })
    end)
    print("[ServerHop]", title, "—", text)
end

local function httpGet(url)
    local ok, result = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if not ok then
        warn("[ServerHop] HTTP GET failed:", result)
        return nil
    end
    return result
end

---------------------------------------------------------------
-- SERVER LIST FETCHER
---------------------------------------------------------------

local function fetchServers()
    local allServers = {}
    local cursor = ""
    local pagesFetched = 0
    
    while pagesFetched < Config.MaxPages do
        local url = string.format(
            "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100%s",
            PlaceId,
            cursor ~= "" and ("&cursor=" .. cursor) or ""
        )
        
        local raw = httpGet(url)
        if not raw then break end
        
        local ok, data = pcall(function()
            return HttpService:JSONDecode(raw)
        end)
        
        if not ok or not data then
            warn("[ServerHop] Failed to decode server list")
            break
        end
        
        local servers = data.data
        if not servers or #servers == 0 then break end
        
        for _, server in ipairs(servers) do
            table.insert(allServers, server)
        end
        
        pagesFetched += 1
        cursor = data.nextPageCursor or ""
        
        if cursor == "" then break end
        task.wait(0.5) -- rate limit friendly
    end
    
    print("[ServerHop] Fetched", #allServers, "servers across", pagesFetched, "pages")
    return allServers
end

---------------------------------------------------------------
-- SERVER FILTER + PICK
---------------------------------------------------------------

local function pickRandomServer(servers)
    local candidates = {}
    
    for _, server in ipairs(servers) do
        -- Skip current server
        if Config.ExcludeCurrent and server.id == CurrentJobId then
            continue
        end
        
        -- Skip if server is full
        if server.playing >= server.maxPlayers then
            continue
        end
        
        -- Min players filter
        if server.playing < Config.MinPlayers then
            continue
        end
        
        -- Max players filter (0 = no limit)
        if Config.MaxPlayers > 0 and server.playing > Config.MaxPlayers then
            continue
        end
        
        -- Skip servers with 0 players (likely dead/empty)
        if server.playing <= 0 then
            continue
        end
        
        table.insert(candidates, server)
    end
    
    if #candidates == 0 then
        warn("[ServerHop] No candidate servers found after filtering")
        return nil
    end
    
    local pick = candidates[math.random(1, #candidates)]
    return pick
end

---------------------------------------------------------------
-- TELEPORT
---------------------------------------------------------------

local function hopToServer(server)
    if not server then return false end
    
    local serverId = server.id
    local playerCount = server.playing
    
    notify("Hopping", string.format("→ %s (%d players)", serverId:sub(1, 8), playerCount))
    
    task.wait(Config.PreTeleportDelay)
    
    local ok, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, LP)
    end)
    
    if not ok then
        warn("[ServerHop] Teleport failed:", err)
        return false
    end
    
    return true
end

---------------------------------------------------------------
-- MAIN HOP LOGIC
---------------------------------------------------------------

local function doHop()
    local attempt = 0
    
    while attempt < Config.MaxRetries do
        attempt += 1
        print("[ServerHop] Hop attempt", attempt .. "/" .. Config.MaxRetries)
        
        -- Fetch server list
        local servers = fetchServers()
        if not servers or #servers == 0 then
            warn("[ServerHop] No servers fetched, retrying...")
            task.wait(Config.RetryDelay)
            continue
        end
        
        -- Pick random server
        local target = pickRandomServer(servers)
        if not target then
            warn("[ServerHop] No valid target, retrying...")
            task.wait(Config.RetryDelay)
            continue
        end
        
        -- Teleport
        local success = hopToServer(target)
        if success then
            -- Wait for teleport to process
            task.wait(10)
            -- If still here, teleport may have failed
            warn("[ServerHop] Still on same server after teleport, retrying...")
        end
        
        task.wait(Config.RetryDelay)
    end
    
    notify("ServerHop Failed", "Could not hop after " .. Config.MaxRetries .. " attempts", 10)
    return false
end

---------------------------------------------------------------
-- ANTI-AFK (optional, runs alongside)
---------------------------------------------------------------

local VirtualUser = game:GetService("VirtualUser")
local antiAfkConn

antiAfkConn = Players.LocalPlayer.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    print("[ServerHop] Anti-AFK triggered")
end)

---------------------------------------------------------------
-- AUTO-REJOIN ON TELEPORT FAIL
---------------------------------------------------------------

TeleportService.TeleportFailed:Connect(function(player, teleportResult, errorMessage)
    warn("[ServerHop] TeleportFailed:", errorMessage)
    notify("Teleport Failed", errorMessage, 5)
    
    task.wait(Config.RetryDelay)
    doHop()
end)

---------------------------------------------------------------
-- ENTRY POINT
---------------------------------------------------------------

-- Seed random
math.randomseed(tick())

notify("ServerHop", "Starting random hop...")

if Config.HopInterval > 0 then
    -- Repeating mode: hop every N seconds
    print("[ServerHop] Repeating mode — interval:", Config.HopInterval, "s")
    
    task.spawn(function()
        while true do
            doHop()
            print("[ServerHop] Waiting", Config.HopInterval, "s before next hop...")
            task.wait(Config.HopInterval)
        end
    end)
else
    -- Single hop mode
    print("[ServerHop] Single hop mode")
    doHop()
end

print("[ServerHop] Script loaded | PlaceId:", PlaceId, "| JobId:", CurrentJobId)
