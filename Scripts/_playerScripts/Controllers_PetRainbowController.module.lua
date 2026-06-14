-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__RunService__2 = game:GetService("RunService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__PerfFlags__4 = require(l__ReplicatedStorage__3.SharedModules.Flags.PerfFlags);
local u1 = {};
local u2 = false;
local v3 = {};
local function u11(p4, p5) --[[ Line: 61 ]]
    -- upvalues: u1 (copy)
    if p5:IsA("BasePart") then
        local v6 = u1[p4];
        if v6 then
            for _, v7 in v6.Parts do
                if v7.Part == p5 then
                    return;
                end;
            end;
            local v8, _, v9 = p5.Color:ToHSV();
            local v10 = {
                Part = p5,
                OriginalHue = v8,
                Value = v9,
                OriginalColor = p5.Color,
                OriginalReflectance = p5.Reflectance
            };
            if p5:IsA("UnionOperation") then
                v10.OriginalUsePartColor = p5.UsePartColor;
                p5.UsePartColor = true;
            end;
            p5.Reflectance = 0.1;
            table.insert(v6.Parts, v10);
        end;
    end;
end;
local function u14(p12) --[[ Line: 91 ]]
    for _, v13 in p12.Parts do
        if v13.Part.Parent then
            v13.Part.Color = v13.OriginalColor;
            v13.Part.Reflectance = v13.OriginalReflectance;
            if v13.OriginalUsePartColor ~= nil and v13.Part:IsA("UnionOperation") then
                v13.Part.UsePartColor = v13.OriginalUsePartColor;
            end;
        end;
    end;
end;
local function u24(u15) --[[ Line: 135 ]]
    -- upvalues: u1 (copy), u11 (copy), u2 (ref), l__RunService__2 (copy), l__PerfFlags__4 (copy)
    if u1[u15] then
    else
        u1[u15] = {
            Offset = math.random(),
            Parts = {},
            AddedConn = u15.DescendantAdded:Connect(function(p16) --[[ Line: 141 ]]
                -- upvalues: u11 (ref), u15 (copy)
                u11(u15, p16);
            end)
        };
        u11(u15, u15);
        for _, v17 in u15:GetDescendants() do
            u11(u15, v17);
        end;
        if u2 then
        else
            u2 = true;
            l__RunService__2.Heartbeat:Connect(function() --[[ Line: 106 ]]
                -- upvalues: l__PerfFlags__4 (ref), u1 (ref)
                if l__PerfFlags__4.AnimatedGradientsDisabled:Get() then
                else
                    debug.profilebegin("Controllers/PetRainbowController/Heartbeat");
                    local v18 = tick() * 0.5 % 1;
                    for v19, v20 in u1 do
                        if v19.Parent then
                            local v21 = (v18 + v20.Offset) % 1;
                            for _, v22 in v20.Parts do
                                if v22.Part.Parent then
                                    local v23 = math.clamp(v22.Value + (v22.OriginalHue - 0.5) * 0.5, 0.1, 1);
                                    v22.Part.Color = Color3.fromHSV(v21, 1, v23);
                                end;
                            end;
                        else
                            v20.AddedConn:Disconnect();
                            u1[v19] = nil;
                        end;
                    end;
                    debug.profileend();
                end;
            end);
        end;
    end;
end;
local function u27(p25) --[[ Line: 155 ]]
    -- upvalues: u1 (copy), u14 (copy)
    local v26 = u1[p25];
    if v26 then
        v26.AddedConn:Disconnect();
        u1[p25] = nil;
        u14(v26);
    end;
end;
function v3.Init(_) --[[ Line: 163 ]] end;
function v3.Start(_) --[[ Line: 165 ]]
    -- upvalues: l__CollectionService__1 (copy), u24 (copy), u27 (copy), l__PerfFlags__4 (copy), u1 (copy), u14 (copy)
    l__CollectionService__1:GetInstanceAddedSignal("PetRainbow"):Connect(u24);
    l__CollectionService__1:GetInstanceRemovedSignal("PetRainbow"):Connect(u27);
    for _, v28 in l__CollectionService__1:GetTagged("PetRainbow") do
        task.spawn(u24, v28);
    end;
    l__PerfFlags__4.AnimatedGradientsDisabled.Changed:Connect(function(p29) --[[ Line: 174 ]]
        -- upvalues: u1 (ref), u14 (ref)
        if p29 then
            for _, v30 in u1 do
                u14(v30);
            end;
        end;
    end);
end;
return v3;