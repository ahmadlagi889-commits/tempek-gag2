-- Decompiled with Potassium's decompiler.

local l__HideCollectProximityPrompts__1 = game.Players.LocalPlayer:WaitForChild("HideCollectProximityPrompts");
local l__CollectionService__2 = game:GetService("CollectionService");
local u1 = {};
local u2 = {};
for _, u3 in l__CollectionService__2:GetTagged("HarvestPrompt") do
    u1[u3] = true;
    if l__HideCollectProximityPrompts__1.Value == true then
        u3.Enabled = false;
    end;
    u3.Destroying:Once(function() --[[ Line: 17 ]]
        -- upvalues: u1 (copy), u3 (copy)
        u1[u3] = nil;
    end);
end;
for _, u4 in l__CollectionService__2:GetTagged("StealPrompt") do
    u2[u4] = true;
    if l__HideCollectProximityPrompts__1.Value == true then
        u4.Enabled = false;
    end;
    u4.Destroying:Once(function() --[[ Line: 17 ]]
        -- upvalues: u2 (copy), u4 (copy)
        u2[u4] = nil;
    end);
end;
l__CollectionService__2:GetInstanceAddedSignal("HarvestPrompt"):Connect(function(u5) --[[ Line: 30 ]]
    -- upvalues: u1 (copy), l__HideCollectProximityPrompts__1 (copy)
    local u6 = u1;
    u6[u5] = true;
    if l__HideCollectProximityPrompts__1.Value == true then
        u5.Enabled = false;
    end;
    u5.Destroying:Once(function() --[[ Line: 17 ]]
        -- upvalues: u6 (copy), u5 (copy)
        u6[u5] = nil;
    end);
end);
l__CollectionService__2:GetInstanceAddedSignal("StealPrompt"):Connect(function(u7) --[[ Line: 34 ]]
    -- upvalues: u2 (copy), l__HideCollectProximityPrompts__1 (copy)
    local u8 = u2;
    u8[u7] = true;
    if l__HideCollectProximityPrompts__1.Value == true then
        u7.Enabled = false;
    end;
    u7.Destroying:Once(function() --[[ Line: 17 ]]
        -- upvalues: u8 (copy), u7 (copy)
        u8[u7] = nil;
    end);
end);
l__HideCollectProximityPrompts__1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 38 ]]
    -- upvalues: l__HideCollectProximityPrompts__1 (copy), u1 (copy), u2 (copy)
    local l__Value__3 = l__HideCollectProximityPrompts__1.Value;
    for v9 in u1 do
        v9.Enabled = not l__Value__3;
    end;
    for v10 in u2 do
        v10.Enabled = not l__Value__3;
    end;
end);