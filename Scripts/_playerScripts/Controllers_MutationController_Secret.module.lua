-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__GrowEffects__3 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GrowEffects"));
local l__PerfFlags__4 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags"));
local u2 = {};
local u3 = {};
local u4 = false;
local l__VFX__5 = script.VFX;
local function u10(u5) --[[ Line: 15 ]]
    -- upvalues: l__PerfFlags__4 (copy), u3 (copy), l__GrowEffects__3 (copy), l__VFX__5 (copy)
    if l__PerfFlags__4.MutationVFXDisabled:Get() then
    elseif u3[u5] then
    elseif u5:IsA("Model") and u5.PrimaryPart then
        l__GrowEffects__3.AddDescendantsAtBaseline(u5, function() --[[ Line: 19 ]]
            -- upvalues: u5 (copy), l__VFX__5 (ref), u3 (ref)
            local v6, v7 = u5:GetBoundingBox();
            local v8 = Instance.new("Part");
            v8.Name = "SecretVFX";
            v8.Size = v7;
            v8.CFrame = v6;
            v8.Transparency = 1;
            v8.CanCollide = false;
            v8.CanQuery = false;
            v8.CanTouch = false;
            v8.Anchored = true;
            v8.Massless = true;
            v8:AddTag("MutationVFX");
            v8.Parent = u5;
            for _, v9 in l__VFX__5:GetChildren() do
                v9:Clone().Parent = v8;
            end;
            u3[u5] = v8;
        end);
    end;
end;
local function u15(p11, p12) --[[ Line: 46 ]]
    -- upvalues: u2 (copy)
    if p12:IsA("BasePart") then
        if u2[p11] then
            local l__Parent__6 = p12.Parent;
            while l__Parent__6 and l__Parent__6 ~= p11 do
                if l__Parent__6.Name == "Fruits" then
                    return;
                end;
                l__Parent__6 = l__Parent__6.Parent;
            end;
            for _, v13 in u2[p11] do
                if v13.Part == p12 then
                    return;
                end;
            end;
            local _, _, v14 = p12.Color:ToHSV();
            p12.Reflectance = 0.1;
            table.insert(u2[p11], {
                Part = p12,
                Value = v14
            });
        end;
    end;
end;
function v1.ApplyMutationEffect(u16) --[[ Line: 93 ]]
    -- upvalues: u2 (copy), l__CollectionService__2 (copy), u10 (copy), u15 (copy), u3 (copy), u4 (ref), l__RunService__1 (copy), l__PerfFlags__4 (copy)
    if u2[u16] then
    else
        l__CollectionService__2:AddTag(u16, "Secret");
        u2[u16] = {};
        if u16:IsA("Model") and u16.PrimaryPart then
            u10(u16);
        end;
        u15(u16, u16);
        for _, v17 in u16:GetDescendants() do
            u15(u16, v17);
        end;
        u16.DescendantAdded:Connect(function(p18) --[[ Line: 102 ]]
            -- upvalues: u15 (ref), u16 (copy), u3 (ref), u10 (ref)
            u15(u16, p18);
            if not u3[u16] then
                local v19 = u16;
                if v19:IsA("Model") and v19.PrimaryPart then
                    u10(v19);
                end;
            end;
        end);
        if u4 then
        else
            u4 = true;
            l__RunService__1.Heartbeat:Connect(function() --[[ Line: 68 ]]
                -- upvalues: l__PerfFlags__4 (ref), u2 (ref), u3 (ref)
                if l__PerfFlags__4.MutationVFXDisabled:Get() then
                else
                    debug.profilebegin("Controllers/MutationController/Secret/Heartbeat");
                    local v20 = tick() * 0.5;
                    for v21, v22 in u2 do
                        if v21.Parent then
                            for _, v23 in v22 do
                                if v23.Part.Parent then
                                    local v24 = (math.sin((v23.Part.Position.Y / 0.2 + v20) * 3.141592653589793 * 2) + 1) / 2 * 0.85 + 0.05;
                                    local v25 = math.clamp(v24, 0.05, 0.9);
                                    v23.Part.Color = Color3.new(v25, v25, v25);
                                end;
                            end;
                        else
                            u2[v21] = nil;
                            if u3[v21] then
                                u3[v21]:Destroy();
                                u3[v21] = nil;
                            end;
                        end;
                    end;
                    debug.profileend();
                end;
            end);
        end;
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal("Secret"):Connect(v1.ApplyMutationEffect);
for _, v26 in l__CollectionService__2:GetTagged("Secret") do
    task.spawn(v1.ApplyMutationEffect, v26);
end;
l__PerfFlags__4.MutationVFXDisabled.Changed:Connect(function(p27) --[[ Line: 117 ]]
    -- upvalues: u3 (copy), u2 (copy), u10 (copy)
    if p27 then
        for v28, v29 in u3 do
            v29:Destroy();
            u3[v28] = nil;
        end;
    else
        for v30 in u2 do
            if v30:IsA("Model") and v30.PrimaryPart then
                u10(v30);
            end;
        end;
    end;
end);
return v1;