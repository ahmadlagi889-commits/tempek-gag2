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
local function u12(u7) --[[ Line: 44 ]]
    -- upvalues: l__PerfFlags__6 (copy), u3 (copy), l__GrowEffects__4 (copy), l__VFX__7 (copy)
    if l__PerfFlags__6.MutationVFXDisabled:Get() then
    elseif u3[u7] then
    elseif u7:IsA("Model") and u7.PrimaryPart then
        l__GrowEffects__4.AddDescendantsAtBaseline(u7, function() --[[ Line: 48 ]]
            -- upvalues: u7 (copy), l__VFX__7 (ref), u3 (ref)
            local v8, v9 = u7:GetBoundingBox();
            local v10 = Instance.new("Part");
            v10.Name = "RainbowVFX";
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
local function u18(p13, p14) --[[ Line: 79 ]]
    -- upvalues: u2 (copy)
    if p14:IsA("BasePart") then
        local v15 = u2[p13];
        if v15 then
            local l__Parent__8 = p14.Parent;
            while l__Parent__8 and l__Parent__8 ~= p13 do
                if l__Parent__8.Name == "Fruits" then
                    return;
                end;
                l__Parent__8 = l__Parent__8.Parent;
            end;
            if v15.parts[p14] then
            else
                local v16, _, v17 = p14.Color:ToHSV();
                v15.parts[p14] = {
                    Value = v17,
                    OriginalHue = v16,
                    OriginalColor = p14.Color,
                    OriginalReflectance = p14.Reflectance
                };
                p14.Reflectance = 0.1;
            end;
        end;
    end;
end;
local function u26() --[[ Line: 109 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v19 = os.clock() * 0.5 % 1;
    for v20, v21 in u2 do
        if v20.Parent then
            for v22, v23 in v21.parts do
                if v22.Parent then
                    local l__Position__9 = v22.Position;
                    local v24 = (v19 + (l__Position__9.X + l__Position__9.Z) / 50 % 1) % 1;
                    local v25 = math.clamp(v23.Value + (v23.OriginalHue - 0.5) * 0.5, 0.1, 1);
                    v22.Color = Color3.fromHSV(v24, 1, v25);
                else
                    v21.parts[v22] = nil;
                end;
            end;
        else
            u1.RemoveMutationEffect(v20);
        end;
    end;
end;
function u1.ApplyMutationEffect(u27) --[[ Line: 164 ]]
    -- upvalues: u2 (copy), l__CollectionService__2 (copy), u12 (copy), u18 (copy), u3 (copy), l__EffectLoadManager__5 (copy), u4 (ref), u5 (ref), u6 (ref), l__RunService__1 (copy), l__PerfFlags__6 (copy), u26 (copy)
    if u2[u27] then
    else
        l__CollectionService__2:AddTag(u27, "Rainbow");
        local v28 = {
            descendantConn = nil,
            parts = {}
        };
        u2[u27] = v28;
        if u27:IsA("Model") and u27.PrimaryPart then
            u12(u27);
        end;
        u18(u27, u27);
        for _, v29 in u27:GetDescendants() do
            u18(u27, v29);
        end;
        v28.descendantConn = u27.DescendantAdded:Connect(function(p30) --[[ Line: 179 ]]
            -- upvalues: u18 (ref), u27 (copy), u3 (ref), u12 (ref)
            u18(u27, p30);
            if not u3[u27] then
                local v31 = u27;
                if v31:IsA("Model") and v31.PrimaryPart then
                    u12(v31);
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
            u5 = l__RunService__1.Heartbeat:Connect(function(p32) --[[ Line: 138 ]]
                -- upvalues: l__PerfFlags__6 (ref), u6 (ref), l__EffectLoadManager__5 (ref), u26 (ref)
                if l__PerfFlags__6.MutationVFXDisabled:Get() then
                else
                    u6 = u6 + p32;
                    if u6 < l__EffectLoadManager__5.GetTickInterval() then
                    else
                        u6 = 0;
                        debug.profilebegin("Controllers/MutationController/Rainbow/Tick");
                        u26();
                        debug.profileend();
                    end;
                end;
            end);
        end;
    end;
end;
function u1.RemoveMutationEffect(p33) --[[ Line: 193 ]]
    -- upvalues: u2 (copy), u3 (copy), l__EffectLoadManager__5 (copy), u4 (ref), u5 (ref)
    local v34 = u2[p33];
    if v34 then
        u2[p33] = nil;
        if v34.descendantConn then
            v34.descendantConn:Disconnect();
        end;
        for v35, v36 in v34.parts do
            if v35.Parent then
                v35.Color = v36.OriginalColor;
                v35.Reflectance = v36.OriginalReflectance;
            end;
        end;
        if u3[p33] then
            u3[p33]:Destroy();
            u3[p33] = nil;
        end;
        l__EffectLoadManager__5.Unregister();
        u4 = math.max(0, u4 - 1);
        if u4 == 0 and u5 then
            u5:Disconnect();
            u5 = nil;
        end;
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal("Rainbow"):Connect(u1.ApplyMutationEffect);
l__CollectionService__2:GetInstanceRemovedSignal("Rainbow"):Connect(u1.RemoveMutationEffect);
for _, v37 in l__CollectionService__2:GetTagged("Rainbow") do
    task.spawn(u1.ApplyMutationEffect, v37);
end;
l__PerfFlags__6.MutationVFXDisabled.Changed:Connect(function(p38) --[[ Line: 234 ]]
    -- upvalues: u3 (copy), u2 (copy), u12 (copy)
    if p38 then
        for v39, v40 in u3 do
            v40:Destroy();
            u3[v39] = nil;
        end;
    else
        for v41 in u2 do
            if v41:IsA("Model") and v41.PrimaryPart then
                u12(v41);
            end;
        end;
    end;
end);
return u1;