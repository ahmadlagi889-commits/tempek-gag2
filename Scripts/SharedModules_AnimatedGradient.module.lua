-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__PerfFlags__3 = require(l__ReplicatedStorage__2.SharedModules.Flags.PerfFlags);
local u1 = {};
local u2 = {};
local u3 = nil;
local function u10(p4, p5) --[[ Line: 74 ]]
    for v6 = 1, #p4 - 1 do
        local v7 = p4[v6];
        local v8 = p4[v6 + 1];
        if v7.Time <= p5 and p5 <= v8.Time then
            local v9 = v8.Time - v7.Time;
            return v7.Value:Lerp(v8.Value, v9 <= 0 and 0 or (p5 - v7.Time) / v9);
        end;
    end;
    return p4[#p4].Value;
end;
local function u16(p11, p12) --[[ Line: 89 ]]
    -- upvalues: u10 (copy)
    local l__Keypoints__4 = p11.Keypoints;
    local v13 = table.create(20);
    for v14 = 0, 19 do
        local v15 = v14 / 19;
        v13[v14 + 1] = ColorSequenceKeypoint.new(v15, u10(l__Keypoints__4, (v15 + p12) % 1));
    end;
    return ColorSequence.new(v13);
end;
local u17 = {};
local function u24(p18) --[[ Line: 112 ]]
    -- upvalues: l__PerfFlags__3 (copy), u1 (copy), u17 (copy), u16 (copy), u2 (copy)
    if l__PerfFlags__3.AnimatedGradientsDisabled:Get() then
    else
        for v19, v20 in u1 do
            if v19.Parent then
                v20.Shift = (v20.Shift + p18 * v20.Speed) % 1;
                v19.Color = u16(v20.Base, v20.Shift);
            else
                u17:Remove(v19);
            end;
        end;
        local v21 = os.clock();
        for v22, v23 in u2 do
            if v22.Parent then
                v22[v23.Property] = Color3.fromHSV(v21 * v23.Speed % 1, v23.Saturation, v23.Value);
            else
                u17:Remove(v22);
            end;
        end;
    end;
end;
function u17.Add(_, u25, p26) --[[ Line: 148 ]]
    -- upvalues: u1 (copy), u17 (copy), u3 (ref), l__RunService__1 (copy), u24 (copy)
    if typeof(u25) == "Instance" and u25:IsA("UIGradient") then
        local v27 = u1[u25];
        if v27 then
            v27.Base = u25.Color;
            v27.Speed = p26 or v27.Speed;
        else
            u1[u25] = {
                Shift = 0,
                Base = u25.Color,
                Speed = p26 or 0.5,
                DestroyConn = u25.Destroying:Once(function() --[[ Line: 162 ]]
                    -- upvalues: u17 (ref), u25 (copy)
                    u17:Remove(u25);
                end)
            };
            if not u3 then
                u3 = l__RunService__1.RenderStepped:Connect(u24);
            end;
        end;
    end;
end;
function u17.AddRainbowColor(_, u28, p29, p30) --[[ Line: 173 ]]
    -- upvalues: u2 (copy), u17 (copy), u3 (ref), l__RunService__1 (copy), u24 (copy)
    if typeof(u28) == "Instance" then
        local u31 = p29 or "ImageColor3";
        local v32 = u2[u28];
        if v32 then
            v32.Property = u31;
            v32.Speed = p30 or v32.Speed;
        else
            local u33 = Color3.new(1, 1, 1);
            pcall(function() --[[ Line: 185 ]]
                -- upvalues: u33 (ref), u28 (copy), u31 (copy)
                u33 = u28[u31];
            end);
            u2[u28] = {
                Saturation = 1,
                Value = 1,
                Instance = u28,
                Property = u31,
                Speed = p30 or 0.5,
                Original = u33,
                DestroyConn = u28.Destroying:Once(function() --[[ Line: 196 ]]
                    -- upvalues: u17 (ref), u28 (copy)
                    u17:Remove(u28);
                end)
            };
            if not u3 then
                u3 = l__RunService__1.RenderStepped:Connect(u24);
            end;
        end;
    end;
end;
function u17.Remove(_, u34) --[[ Line: 207 ]]
    -- upvalues: u1 (copy), u3 (ref), u2 (copy)
    local v35 = u1[u34];
    if v35 then
        v35.DestroyConn:Disconnect();
        u1[u34] = nil;
        if u34.Parent then
            u34.Color = v35.Base;
        end;
        if u3 and (next(u1) == nil and next(u2) == nil) then
            u3:Disconnect();
            u3 = nil;
        end;
    else
        local u36 = u2[u34];
        if u36 then
            u36.DestroyConn:Disconnect();
            u2[u34] = nil;
            if u34.Parent then
                pcall(function() --[[ Line: 225 ]]
                    -- upvalues: u34 (copy), u36 (copy)
                    u34[u36.Property] = u36.Original;
                end);
            end;
            if u3 and (next(u1) == nil and next(u2) == nil) then
                u3:Disconnect();
                u3 = nil;
            end;
        end;
    end;
end;
return u17;