-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local l__Lighting__2 = game:GetService("Lighting");
local l__LightingController__3 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
local l__TimeCycleData__4 = require(game.ReplicatedStorage.SharedModules.TimeCycleData);
local u2 = {};
local u3 = nil;
function v1.Start(_, _, _) --[[ Line: 15 ]]
    -- upvalues: l__LightingController__3 (copy), u2 (copy), l__TimeCycleData__4 (copy), l__Lighting__2 (copy), u3 (ref), l__RunService__1 (copy)
    local v4 = {};
    for v5, v6 in l__LightingController__3:GetDefault() do
        v4[v5] = v6;
    end;
    for v7, v8 in u2 do
        v4[v7] = v8;
    end;
    v4.ClockTime = nil;
    l__LightingController__3:TransitionTo(v4);
    local _ = l__TimeCycleData__4.Data.Day.Lasts;
    local u9 = 0;
    for _, v10 in l__TimeCycleData__4.Data do
        u9 = u9 + v10.Lasts;
    end;
    local function u20() --[[ Line: 37 ]]
        -- upvalues: u9 (ref), l__TimeCycleData__4 (ref)
        local v11 = workspace:GetAttribute("CycleOffset") or 0;
        local v12 = (os.time() + v11) % u9;
        local v13 = {};
        local v14 = 0;
        for v15, v16 in l__TimeCycleData__4.Data do
            table.insert(v13, {
                Name = v15,
                Duration = v16.Lasts,
                Order = v16.StartOrder
            });
        end;
        table.sort(v13, function(p17, p18) --[[ Line: 46 ]]
            return p17.Order < p18.Order;
        end);
        for _, v19 in v13 do
            if v19.Name == "Day" then
                return math.clamp((v12 - v14) / v19.Duration, 0, 1);
            end;
            v14 = v14 + v19.Duration;
        end;
        return 0;
    end;
    l__Lighting__2.ClockTime = 7 + 8 * u20();
    if u3 then
        u3:Disconnect();
    end;
    u3 = l__RunService__1.Heartbeat:Connect(function() --[[ Line: 66 ]]
        -- upvalues: u20 (copy), l__Lighting__2 (ref)
        local v21 = u20();
        if workspace:GetAttribute("TimeFrozen") then
        else
            l__Lighting__2.Ambient = Color3.fromHSV(0, 0, 0.5 + 0.3 * v21);
            l__Lighting__2.ClockTime = 7 + 8 * v21;
        end;
    end);
end;
function v1.End(_) --[[ Line: 76 ]]
    -- upvalues: u3 (ref)
    if u3 then
        u3:Disconnect();
        u3 = nil;
    end;
end;
return v1;