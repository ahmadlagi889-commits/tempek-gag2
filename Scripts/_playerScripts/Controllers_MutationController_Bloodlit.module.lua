-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__RunService__1 = game:GetService("RunService");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__GrowEffects__4 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("GrowEffects"));
local l__EffectLoadManager__5 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("EffectLoadManager"));
local l__PerfFlags__6 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags"));
local l__VFX__7 = script.VFX;
local u2 = {};
local u3 = {};
local u4 = 0;
local u5 = nil;
local u6 = 0;
local function u12(u7) --[[ Line: 58 ]]
    -- upvalues: l__PerfFlags__6 (copy), u3 (copy), l__GrowEffects__4 (copy), l__VFX__7 (copy)
    if l__PerfFlags__6.MutationVFXDisabled:Get() then
    elseif u3[u7] then
    elseif u7:IsA("Model") and u7.PrimaryPart then
        l__GrowEffects__4.AddDescendantsAtBaseline(u7, function() --[[ Line: 62 ]]
            -- upvalues: u7 (copy), l__VFX__7 (ref), u3 (ref)
            local v8, v9 = u7:GetBoundingBox();
            local v10 = Instance.new("Part");
            v10.Name = "BloodlitVFX";
            v10.Size = v9;
            v10.CFrame = v8;
            v10.Transparency = 1;
            v10.CanCollide = false;
            v10.CanQuery = false;
            v10.CanTouch = false;
            v10.Anchored = true;
            v10.Massless = true;
            v10:AddTag("MutationVFX");
            v10.Parent = u7;
            for _, v11 in l__VFX__7:GetChildren() do
                v11:Clone().Parent = v10;
            end;
            u3[u7] = v10;
        end);
    end;
end;
local function u17(p13, p14) --[[ Line: 93 ]]
    -- upvalues: u2 (copy)
    if not p14:IsA("BasePart") then
        return;
    end;
    local v15 = u2[p13];
    if not v15 then
        return;
    end;
    local l__Parent__8 = p14.Parent;
    local v16;
    while true do
        if not l__Parent__8 or l__Parent__8 == p13 then
            v16 = false;
            break;
        end;
        if l__Parent__8.Name == "Fruits" then
            v16 = true;
            break;
        end;
        l__Parent__8 = l__Parent__8.Parent;
    end;
    if v16 then
    elseif v15.parts[p14] then
    else
        v15.parts[p14] = {
            OriginalColor = p14.Color,
            OriginalReflectance = p14.Reflectance
        };
        p14.Reflectance = 0.1;
    end;
end;
local function u23() --[[ Line: 114 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v18 = os.clock() * 0.5 * 3.141592653589793 * 2;
    for v19, v20 in u2 do
        if v19.Parent then
            for v21, _ in v20.parts do
                if v21.Parent then
                    local v22 = (math.sin(v21.Position.X / 50 + v18) + 1) / 2 * 0.75 + 0.05;
                    v21.Color = Color3.fromHSV(0, 1, v22);
                else
                    v20.parts[v21] = nil;
                end;
            end;
        else
            u1.RemoveMutationEffect(v19);
        end;
    end;
end;
function u1.ApplyMutationEffect(u24) --[[ Line: 169 ]]
    -- upvalues: u2 (copy), l__CollectionService__2 (copy), u12 (copy), u17 (copy), u3 (copy), l__EffectLoadManager__5 (copy), u4 (ref), u5 (ref), u6 (ref), l__RunService__1 (copy), l__PerfFlags__6 (copy), u23 (copy)
    if u2[u24] then
    else
        l__CollectionService__2:AddTag(u24, "Bloodlit");
        local v25 = {
            descendantConn = nil,
            parts = {}
        };
        u2[u24] = v25;
        if u24:IsA("Model") and u24.PrimaryPart then
            u12(u24);
        end;
        u17(u24, u24);
        for _, v26 in u24:GetDescendants() do
            u17(u24, v26);
        end;
        v25.descendantConn = u24.DescendantAdded:Connect(function(p27) --[[ Line: 183 ]]
            -- upvalues: u17 (ref), u24 (copy), u3 (ref), u12 (ref)
            u17(u24, p27);
            if not u3[u24] then
                local v28 = u24;
                if v28:IsA("Model") and v28.PrimaryPart then
                    u12(v28);
                end;
            end;
        end);
        l__EffectLoadManager__5.Register();
        u4 = u4 + 1;
        if u4 == 1 then
            if u5 then
                return;
            end;
            u6 = 0;
            u5 = l__RunService__1.Heartbeat:Connect(function(p29) --[[ Line: 143 ]]
                -- upvalues: l__PerfFlags__6 (ref), u6 (ref), l__EffectLoadManager__5 (ref), u23 (ref)
                if l__PerfFlags__6.MutationVFXDisabled:Get() then
                else
                    u6 = u6 + p29;
                    if u6 < l__EffectLoadManager__5.GetTickInterval() then
                    else
                        u6 = 0;
                        debug.profilebegin("Controllers/MutationController/Bloodlit/Tick");
                        u23();
                        debug.profileend();
                    end;
                end;
            end);
        end;
    end;
end;
function u1.RemoveMutationEffect(p30) --[[ Line: 197 ]]
    -- upvalues: u2 (copy), u3 (copy), l__EffectLoadManager__5 (copy), u4 (ref), u5 (ref)
    local v31 = u2[p30];
    if v31 then
        u2[p30] = nil;
        if v31.descendantConn then
            v31.descendantConn:Disconnect();
        end;
        for v32, v33 in v31.parts do
            if v32.Parent then
                v32.Color = v33.OriginalColor;
                v32.Reflectance = v33.OriginalReflectance;
            end;
        end;
        if u3[p30] then
            u3[p30]:Destroy();
            u3[p30] = nil;
        end;
        l__EffectLoadManager__5.Unregister();
        u4 = math.max(0, u4 - 1);
        if u4 == 0 and u5 then
            u5:Disconnect();
            u5 = nil;
        end;
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal("Bloodlit"):Connect(u1.ApplyMutationEffect);
l__CollectionService__2:GetInstanceRemovedSignal("Bloodlit"):Connect(u1.RemoveMutationEffect);
for _, v34 in l__CollectionService__2:GetTagged("Bloodlit") do
    task.spawn(u1.ApplyMutationEffect, v34);
end;
l__PerfFlags__6.MutationVFXDisabled.Changed:Connect(function(p35) --[[ Line: 238 ]]
    -- upvalues: u3 (copy), u2 (copy), u12 (copy)
    if p35 then
        for v36, v37 in u3 do
            v37:Destroy();
            u3[v36] = nil;
        end;
    else
        for v38 in u2 do
            if v38:IsA("Model") and v38.PrimaryPart then
                u12(v38);
            end;
        end;
    end;
end);
return u1;