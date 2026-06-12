--[[
    GAG Hub - Utilities
    Shared helper functions used across all modules.
]]

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

return Utils
