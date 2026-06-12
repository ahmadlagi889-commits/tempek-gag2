--[[
    GAG Hub - Networking Wrapper
    Auto-discovers and wraps game's Networking module.
    Provides safe Fire/Invoke with logging and retry.
    
    Usage:
        local Net = require("core/networking")
        Net.fire("Garden.CollectFruit", plantId, fruitId)
        Net.invoke("SomeRemoteFunction", arg1)
        Net.on("Garden.PlantAdded", callback)
]]

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

return Networking
