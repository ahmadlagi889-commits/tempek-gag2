-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__RunService__2 = game:GetService("RunService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__PerfFlags__4 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags"));
local u1 = table.create(10);
local function u7(p2, p3) --[[ Line: 15 ]]
    for v4 = 1, #p2 - 1 do
        local v5 = p2[v4];
        local v6 = p2[v4 + 1];
        if v5.Time <= p3 and p3 <= v6.Time then
            return v5.Value:Lerp(v6.Value, (p3 - v5.Time) / (v6.Time - v5.Time));
        end;
    end;
    return p2[#p2].Value;
end;
local function u12(p8, p9) --[[ Line: 26 ]]
    -- upvalues: u1 (copy), u7 (copy)
    local l__Keypoints__5 = p8.Keypoints;
    for v10 = 0, 9 do
        local v11 = v10 / 9;
        u1[v10 + 1] = ColorSequenceKeypoint.new(v11, u7(l__Keypoints__5, (v11 + p9) % 1));
    end;
    return ColorSequence.new(u1);
end;
local function u19(u13) --[[ Line: 35 ]]
    -- upvalues: l__RunService__2 (copy), l__PerfFlags__4 (copy), u12 (copy)
    local l__Color__6 = u13.Color;
    local u14 = 0;
    local u15 = 0;
    local u16 = nil;
    u16 = l__RunService__2.Heartbeat:Connect(function(p17) --[[ Line: 41 ]]
        -- upvalues: l__PerfFlags__4 (ref), u15 (ref), u13 (copy), u16 (ref), u14 (ref), u12 (ref), l__Color__6 (copy)
        if l__PerfFlags__4.AnimatedGradientsDisabled:Get() then
        else
            u15 = u15 + p17;
            if u15 < 0.05 then
            else
                local v18 = u15;
                u15 = 0;
                if u13.Parent then
                    u14 = (u14 + v18 * 0.5) % 1;
                    u13.Color = u12(l__Color__6, u14);
                else
                    u16:Disconnect();
                end;
            end;
        end;
    end);
    u13.Destroying:Once(function() --[[ Line: 56 ]]
        -- upvalues: u16 (ref)
        u16:Disconnect();
    end);
end;
for _, v20 in l__CollectionService__1:GetTagged("InfiniteGradient") do
    u19(v20);
end;
l__CollectionService__1:GetInstanceAddedSignal("InfiniteGradient"):Connect(function(p21) --[[ Line: 65 ]]
    -- upvalues: u19 (copy)
    if p21:IsA("UIGradient") then
        u19(p21);
    end;
end);