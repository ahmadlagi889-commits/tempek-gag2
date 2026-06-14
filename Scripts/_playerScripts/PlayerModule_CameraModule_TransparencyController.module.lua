-- Decompiled with Potassium's decompiler.

local l__VRService__1 = game:GetService("VRService");
local u1 = {
    "BasePart",
    "Decal",
    "Beam",
    "ParticleEmitter",
    "Trail",
    "Fire",
    "Smoke",
    "Sparkles",
    "Explosion"
};
local l__CameraUtils__2 = require(script.Parent:WaitForChild("CameraUtils"));
local v2, v3 = pcall(function() --[[ Line: 27 ]]
    return UserSettings():IsUserFeatureEnabled("UserHideCharacterParticlesInFirstPerson");
end);
local u4 = v2 and v3;
local u5 = {};
u5.__index = u5;
function u5.new() --[[ Line: 38 ]]
    -- upvalues: u5 (copy)
    local v6 = setmetatable({}, u5);
    v6.transparencyDirty = false;
    v6.enabled = false;
    v6.lastTransparency = nil;
    v6.descendantAddedConn = nil;
    v6.descendantRemovingConn = nil;
    v6.toolDescendantAddedConns = {};
    v6.toolDescendantRemovingConns = {};
    v6.cachedParts = {};
    return v6;
end;
function u5.HasToolAncestor(p7, p8) --[[ Line: 54 ]]
    if p8.Parent == nil then
        return false;
    end;
    assert(p8.Parent, "");
    return p8.Parent:IsA("Tool") or p7:HasToolAncestor(p8.Parent);
end;
function u5.IsValidPartToModify(p9, p10) --[[ Line: 60 ]]
    -- upvalues: u4 (ref), u1 (copy)
    if u4 then
        for _, v11 in u1 do
            if p10:IsA(v11) then
                return not p9:HasToolAncestor(p10);
            end;
        end;
    elseif p10:IsA("BasePart") or p10:IsA("Decal") then
        return not p9:HasToolAncestor(p10);
    end;
    return false;
end;
function u5.CachePartsRecursive(p12, p13) --[[ Line: 76 ]]
    if p13 then
        if p12:IsValidPartToModify(p13) then
            p12.cachedParts[p13] = true;
            p12.transparencyDirty = true;
        end;
        for _, v14 in pairs(p13:GetChildren()) do
            p12:CachePartsRecursive(v14);
        end;
    end;
end;
function u5.TeardownTransparency(p15) --[[ Line: 88 ]]
    for v16, _ in pairs(p15.cachedParts) do
        v16.LocalTransparencyModifier = 0;
    end;
    p15.cachedParts = {};
    p15.transparencyDirty = true;
    p15.lastTransparency = nil;
    if p15.descendantAddedConn then
        p15.descendantAddedConn:disconnect();
        p15.descendantAddedConn = nil;
    end;
    if p15.descendantRemovingConn then
        p15.descendantRemovingConn:disconnect();
        p15.descendantRemovingConn = nil;
    end;
    for v17, v18 in pairs(p15.toolDescendantAddedConns) do
        v18:Disconnect();
        p15.toolDescendantAddedConns[v17] = nil;
    end;
    for v19, v20 in pairs(p15.toolDescendantRemovingConns) do
        v20:Disconnect();
        p15.toolDescendantRemovingConns[v19] = nil;
    end;
end;
function u5.SetupTransparency(u21, u22) --[[ Line: 114 ]]
    u21:TeardownTransparency();
    if u21.descendantAddedConn then
        u21.descendantAddedConn:disconnect();
    end;
    u21.descendantAddedConn = u22.DescendantAdded:Connect(function(p23) --[[ Line: 118 ]]
        -- upvalues: u21 (copy), u22 (copy)
        if u21:IsValidPartToModify(p23) then
            u21.cachedParts[p23] = true;
            u21.transparencyDirty = true;
        else
            if p23:IsA("Tool") then
                if u21.toolDescendantAddedConns[p23] then
                    u21.toolDescendantAddedConns[p23]:Disconnect();
                end;
                u21.toolDescendantAddedConns[p23] = p23.DescendantAdded:Connect(function(p24) --[[ Line: 126 ]]
                    -- upvalues: u21 (ref)
                    u21.cachedParts[p24] = nil;
                    if p24:IsA("BasePart") or p24:IsA("Decal") then
                        p24.LocalTransparencyModifier = 0;
                    end;
                end);
                if u21.toolDescendantRemovingConns[p23] then
                    u21.toolDescendantRemovingConns[p23]:disconnect();
                end;
                u21.toolDescendantRemovingConns[p23] = p23.DescendantRemoving:Connect(function(p25) --[[ Line: 134 ]]
                    -- upvalues: u22 (ref), u21 (ref)
                    wait();
                    if u22 and (p25 and (p25:IsDescendantOf(u22) and u21:IsValidPartToModify(p25))) then
                        u21.cachedParts[p25] = true;
                        u21.transparencyDirty = true;
                    end;
                end);
            end;
        end;
    end);
    if u21.descendantRemovingConn then
        u21.descendantRemovingConn:disconnect();
    end;
    u21.descendantRemovingConn = u22.DescendantRemoving:connect(function(p26) --[[ Line: 146 ]]
        -- upvalues: u21 (copy)
        if u21.cachedParts[p26] then
            u21.cachedParts[p26] = nil;
            p26.LocalTransparencyModifier = 0;
        end;
    end);
    u21:CachePartsRecursive(u22);
end;
function u5.Enable(p27, p28) --[[ Line: 157 ]]
    if p27.enabled ~= p28 then
        p27.enabled = p28;
    end;
end;
function u5.SetSubject(p29, p30) --[[ Line: 163 ]]
    local v31;
    if p30 and p30:IsA("Humanoid") then
        v31 = p30.Parent;
    else
        v31 = nil;
    end;
    if p30 and (p30:IsA("VehicleSeat") and p30.Occupant) then
        v31 = p30.Occupant.Parent;
    end;
    if v31 then
        p29:SetupTransparency(v31);
    else
        p29:TeardownTransparency();
    end;
end;
function u5.Update(p32, p33) --[[ Line: 178 ]]
    -- upvalues: l__CameraUtils__2 (copy), l__VRService__1 (copy)
    local l__CurrentCamera__3 = workspace.CurrentCamera;
    if l__CurrentCamera__3 and p32.enabled then
        local l__magnitude__4 = (l__CurrentCamera__3.Focus.p - l__CurrentCamera__3.CoordinateFrame.p).magnitude;
        local v34 = l__magnitude__4 < 2 and 1 - (l__magnitude__4 - 0.5) / 1.5 or 0;
        local v35 = v34 < 0.5 and 0 or v34;
        if p32.lastTransparency and (v35 < 1 and p32.lastTransparency < 0.95) then
            local v36 = v35 - p32.lastTransparency;
            local v37 = 2.8 * p33;
            local v38 = math.clamp(v36, -v37, v37);
            v35 = p32.lastTransparency + v38;
        else
            p32.transparencyDirty = true;
        end;
        local v39 = l__CameraUtils__2.Round(v35, 2);
        local v40 = math.clamp(v39, 0, 1);
        if p32.transparencyDirty or p32.lastTransparency ~= v40 then
            for v41, _ in pairs(p32.cachedParts) do
                if l__VRService__1.VREnabled and l__VRService__1.AvatarGestures then
                    local v42 = {
                        [Enum.AccessoryType.Hat] = true,
                        [Enum.AccessoryType.Hair] = true,
                        [Enum.AccessoryType.Face] = true,
                        [Enum.AccessoryType.Eyebrow] = true,
                        [Enum.AccessoryType.Eyelash] = true
                    };
                    if v41.Parent:IsA("Accessory") and v42[v41.Parent.AccessoryType] or v41.Name == "Head" then
                        v41.LocalTransparencyModifier = v40;
                    else
                        v41.LocalTransparencyModifier = 0;
                    end;
                else
                    v41.LocalTransparencyModifier = v40;
                end;
            end;
            p32.transparencyDirty = false;
            p32.lastTransparency = v40;
        end;
    end;
end;
return u5;