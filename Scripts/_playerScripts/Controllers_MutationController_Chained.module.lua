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
local function u13(u5) --[[ Line: 33 ]]
    -- upvalues: l__PerfFlags__4 (copy), u3 (copy), l__GrowEffects__3 (copy), l__VFX__5 (copy)
    if l__PerfFlags__4.MutationVFXDisabled:Get() then
    elseif u3[u5] then
    elseif u5:IsA("Model") and u5.PrimaryPart then
        l__GrowEffects__3.AddDescendantsAtBaseline(u5, function() --[[ Line: 38 ]]
            -- upvalues: u5 (copy), l__VFX__5 (ref), u3 (ref)
            local v6, v7 = u5:GetBoundingBox();
            local v8 = Instance.new("Part");
            v8.Name = "ChainedVFX";
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
            local v10 = 0;
            if v10 < v8.Size.X then
                v10 = v8.Size.X;
            end;
            if v10 < v8.Size.Z then
                v10 = v8.Size.Z;
            end;
            local v11 = script.ChainedModel:Clone();
            v11:ScaleTo(v10 * 1.05);
            for _, v12 in v11.ChainCircle:GetChildren() do
                v12.Parent = v8;
            end;
            v11:Destroy();
            u3[u5] = v8;
        end);
    end;
end;
local function u19(p14, p15) --[[ Line: 89 ]]
    -- upvalues: u2 (copy)
    if not p15:IsA("BasePart") then
        return;
    end;
    if not u2[p14] then
        return;
    end;
    local l__Parent__6 = p15.Parent;
    local v16;
    while true do
        if not l__Parent__6 or l__Parent__6 == p14 then
            v16 = false;
            break;
        end;
        if l__Parent__6.Name == "Fruits" then
            v16 = true;
            break;
        end;
        l__Parent__6 = l__Parent__6.Parent;
    end;
    if v16 then
    else
        for _, v17 in u2[p14] do
            if v17.Part == p15 then
                return;
            end;
        end;
        local _, _, v18 = p15.Color:ToHSV();
        p15.Reflectance = 0.25;
        table.insert(u2[p14], {
            Part = p15,
            Value = v18
        });
    end;
end;
function v1.ApplyMutationEffect(u20) --[[ Line: 138 ]]
    -- upvalues: u2 (copy), l__CollectionService__2 (copy), u13 (copy), u19 (copy), u3 (copy), u4 (ref), l__RunService__1 (copy), l__PerfFlags__4 (copy)
    if u2[u20] then
    else
        l__CollectionService__2:AddTag(u20, "Chained");
        u2[u20] = {};
        if u20:IsA("Model") and u20.PrimaryPart then
            u13(u20);
        end;
        u19(u20, u20);
        for _, v21 in u20:GetDescendants() do
            u19(u20, v21);
        end;
        u20.DescendantAdded:Connect(function(p22) --[[ Line: 153 ]]
            -- upvalues: u19 (ref), u20 (copy), u3 (ref), u13 (ref)
            u19(u20, p22);
            if not u3[u20] then
                local v23 = u20;
                if v23:IsA("Model") and v23.PrimaryPart then
                    u13(v23);
                end;
            end;
        end);
        if u4 then
        else
            u4 = true;
            l__RunService__1.Heartbeat:Connect(function() --[[ Line: 111 ]]
                -- upvalues: l__PerfFlags__4 (ref), u2 (ref), u3 (ref)
                if l__PerfFlags__4.MutationVFXDisabled:Get() then
                else
                    debug.profilebegin("Controllers/MutationController/Chained/Heartbeat");
                    for v24, v25 in u2 do
                        if v24.Parent then
                            for _, v26 in v25 do
                                if v26.Part.Parent then
                                    local v27 = v26.Part.Position.X / 50 + tick() * 0.7 * 3.141592653589793 * 2;
                                    local v28 = (math.sin(v27) + 1) / 2 * 0.4 + 0.6;
                                    v26.Part.Color = Color3.fromHSV(0.849, 1, v28);
                                end;
                            end;
                        else
                            u2[v24] = nil;
                            if u3[v24] then
                                u3[v24]:Destroy();
                                u3[v24] = nil;
                            end;
                        end;
                    end;
                    debug.profileend();
                end;
            end);
        end;
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal("Chained"):Connect(v1.ApplyMutationEffect);
for _, v29 in l__CollectionService__2:GetTagged("Chained") do
    task.spawn(v1.ApplyMutationEffect, v29);
end;
l__PerfFlags__4.MutationVFXDisabled.Changed:Connect(function(p30) --[[ Line: 170 ]]
    -- upvalues: u3 (copy), u2 (copy), u13 (copy)
    if p30 then
        for v31, v32 in u3 do
            v32:Destroy();
            u3[v31] = nil;
        end;
    else
        for v33 in u2 do
            if v33:IsA("Model") and v33.PrimaryPart then
                u13(v33);
            end;
        end;
    end;
end);
return v1;