--[[
    Pet Catch Recon — run this in-game to discover pet catch mechanics
    Paste output back to me so I can build AutoPetCatch module
    
    Usage: loadstring(game:HttpGet("URL"))() or paste in executor
]]

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CS = game:GetService("CollectionService")

print("=== PET CATCH RECON ===")
print("Player:", LP.Name)
print("PlaceId:", game.PlaceId)
print("JobId:", game.JobId)
print("")

---------------------------------------------------------------
-- 1. SCAN WORKSPACE FOR PET-RELATED MODELS/PARTS
---------------------------------------------------------------
print("--- 1. PET-RELATED INSTANCES IN WORKSPACE ---")
local petKeywords = {"pet", "catch", "animal", "creature", "wild", "spawn", "net", "trap"}
local found = {}

for _, desc in ipairs(workspace:GetDescendants()) do
    local name = string.lower(desc.Name)
    for _, kw in ipairs(petKeywords) do
        if string.find(name, kw) then
            table.insert(found, {
                path = desc:GetFullName(),
                class = desc.ClassName,
                name = desc.Name,
            })
            break
        end
    end
end

-- Also check CollectionService tags
print("Checking CollectionService tags...")
local petTags = {}
for _, tag in ipairs(CS:GetAllTags()) do
    local tagLower = string.lower(tag)
    for _, kw in ipairs(petKeywords) do
        if string.find(tagLower, kw) then
            local instances = CS:GetTagged(tag)
            table.insert(petTags, { tag = tag, count = #instances })
            for _, inst in ipairs(instances) do
                table.insert(found, {
                    path = inst:GetFullName(),
                    class = inst.ClassName,
                    name = inst.Name,
                    tag = tag,
                })
            end
            break
        end
    end
end

if #petTags > 0 then
    print("Pet-related CollectionService tags:")
    for _, t in ipairs(petTags) do
        print("  [" .. t.tag .. "] x" .. t.count)
    end
end

print("Found " .. #found .. " pet-related instances:")
for i, f in ipairs(found) do
    local tagStr = f.tag and (" [tag:" .. f.tag .. "]") or ""
    print("  " .. i .. ". " .. f.class .. " → " .. f.path .. tagStr)
end
print("")

---------------------------------------------------------------
-- 2. SCAN FOR PROXIMITYPROMPTS NEAR PET-RELATED AREAS
---------------------------------------------------------------
print("--- 2. PROXIMITYPROMPTS ON PET-RELATED INSTANCES ---")
local promptCount = 0
for _, f in ipairs(found) do
    local inst = workspace:FindFirstChild(f.path) -- might not resolve full path
end

-- Broader scan: all ProximityPrompts and check parent context
for _, desc in ipairs(workspace:GetDescendants()) do
    if desc:IsA("ProximityPrompt") then
        local parent = desc.Parent
        local grandparent = parent and parent.Parent
        local context = string.lower((parent and parent.Name or "") .. " " .. (grandparent and grandparent.Name or ""))
        
        local isPetRelated = false
        for _, kw in ipairs(petKeywords) do
            if string.find(context, kw) then
                isPetRelated = true
                break
            end
        end
        
        if isPetRelated then
            promptCount += 1
            print("  ProximityPrompt in: " .. desc.Parent:GetFullName())
            print("    ActionText:", desc.ActionText)
            print("    ObjectText:", desc.ObjectText)
            print("    HoldDuration:", desc.HoldDuration)
            print("    MaxActivationDistance:", desc.MaxActivationDistance)
            print("    Enabled:", desc.Enabled)
            print("    KeyboardKeyCode:", desc.KeyboardKeyCode)
        end
    end
end
if promptCount == 0 then
    print("  (none found near pet-related instances)")
end
print("")

---------------------------------------------------------------
-- 3. SCAN ATTRIBUTES ON FOUND PET INSTANCES
---------------------------------------------------------------
print("--- 3. ATTRIBUTES ON PET INSTANCES ---")
local attrCount = 0
for _, f in ipairs(found) do
    -- Try to resolve the instance
    local parts = {}
    for seg in string.gmatch(f.path, "[^%.]+") do
        table.insert(parts, seg)
    end
    
    local inst = workspace
    for _, seg in ipairs(parts) do
        inst = inst:FindFirstChild(seg)
        if not inst then break end
    end
    
    if inst then
        local attrs = inst:GetAttributes()
        local hasAttrs = false
        for _ in pairs(attrs) do hasAttrs = true break end
        
        if hasAttrs then
            attrCount += 1
            print("  " .. f.path .. " (" .. f.class .. ")")
            for k, v in pairs(attrs) do
                print("    " .. k .. " = " .. tostring(v) .. " (" .. typeof(v) .. ")")
            end
        end
    end
end
if attrCount == 0 then
    print("  (no attributes found)")
end
print("")

---------------------------------------------------------------
-- 4. SCAN FOR PET/REMOTE EVENTS IN REPLICATEDSTORAGE
---------------------------------------------------------------
print("--- 4. PET/CATCH REMOTES IN REPLICATEDSTORAGE ---")
local remoteCount = 0
for _, desc in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    local name = string.lower(desc.Name)
    local isPet = false
    for _, kw in ipairs(petKeywords) do
        if string.find(name, kw) then
            isPet = true
            break
        end
    end
    
    if isPet and (desc:IsA("RemoteEvent") or desc:IsA("RemoteFunction")) then
        remoteCount += 1
        print("  " .. desc.ClassName .. " → " .. desc:GetFullName())
    end
end
if remoteCount == 0 then
    print("  (no pet-related remotes found)")
end
print("")

---------------------------------------------------------------
-- 5. CHECK NETWORKING MODULE FOR PET/CATCH METHODS
---------------------------------------------------------------
print("--- 5. NETWORKING MODULE - PET/CATCH KEYS ---")
local ok, net = pcall(function()
    local shared = game:GetService("ReplicatedStorage"):WaitForChild("SharedModules", 5)
    if not shared then return nil end
    local netMod = shared:FindFirstChild("Networking")
    if not netMod then return nil end
    return require(netMod)
end)

if ok and net and type(net) == "table" then
    for key, val in pairs(net) do
        if type(val) == "table" then
            local keyLower = string.lower(key)
            local isPet = false
            for _, kw in ipairs(petKeywords) do
                if string.find(keyLower, kw) then
                    isPet = true
                    break
                end
            end
            
            if isPet then
                print("  Networking." .. key .. ":")
                for method, _ in pairs(val) do
                    print("    ." .. tostring(method))
                end
            end
        end
    end
    
    -- Also check for Pet/Catch in all top-level keys
    print("  All top-level Networking keys:")
    for key, val in pairs(net) do
        if type(val) == "table" then
            local methods = {}
            for m, _ in pairs(val) do table.insert(methods, m) end
            print("    " .. key .. " → {" .. table.concat(methods, ", ") .. "}")
        end
    end
else
    print("  (Networking module not accessible)")
end
print("")

---------------------------------------------------------------
-- 6. SCAN PLAYER BACKPACK/CHARACTER FOR CATCH TOOLS
---------------------------------------------------------------
print("--- 6. CATCH-RELATED TOOLS ---")
local bp = LP:FindFirstChild("Backpack")
if bp then
    for _, tool in ipairs(bp:GetChildren()) do
        if tool:IsA("Tool") then
            local name = string.lower(tool.Name)
            for _, kw in ipairs(petKeywords) do
                if string.find(name, kw) then
                    print("  Tool:", tool.Name)
                    for k, v in pairs(tool:GetAttributes()) do
                        print("    " .. k .. " = " .. tostring(v))
                    end
                    break
                end
            end
        end
    end
end
local char = LP.Character
if char then
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local name = string.lower(tool.Name)
            for _, kw in ipairs(petKeywords) do
                if string.find(name, kw) then
                    print("  Equipped Tool:", tool.Name)
                    for k, v in pairs(tool:GetAttributes()) do
                        print("    " .. k .. " = " .. tostring(v))
                    end
                    break
                end
            end
        end
    end
end
print("")

---------------------------------------------------------------
-- 7. CHECK MAP FOLDERS FOR PET SPAWN LOCATIONS
---------------------------------------------------------------
print("--- 7. MAP FOLDERS WITH PET/SPAWN ---")
local map = workspace:FindFirstChild("Map")
if map then
    for _, child in ipairs(map:GetChildren()) do
        local name = string.lower(child.Name)
        for _, kw in ipairs(petKeywords) do
            if string.find(name, kw) then
                local childCount = #child:GetChildren()
                print("  Folder: " .. child.Name .. " (" .. childCount .. " children)")
                -- List first few children
                for i, c in ipairs(child:GetChildren()) do
                    if i > 5 then
                        print("    ... and " .. (childCount - 5) .. " more")
                        break
                    end
                    print("    " .. c.ClassName .. ": " .. c.Name)
                    for k, v in pairs(c:GetAttributes()) do
                        print("      " .. k .. " = " .. tostring(v))
                    end
                end
                break
            end
        end
    end
end
print("")

print("=== RECON COMPLETE ===")
print("Copy ALL output above and send back to build AutoPetCatch module")
