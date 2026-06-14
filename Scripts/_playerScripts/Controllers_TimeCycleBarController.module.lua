-- Decompiled with Potassium's decompiler.

local l__TimeCycleData__1 = require(game.ReplicatedStorage.SharedModules.TimeCycleData);
local l__TweenService__2 = game:GetService("TweenService");
local u1 = {};
local v2 = {};
for v3, v4 in l__TimeCycleData__1.Data do
    table.insert(u1, {
        Name = v3,
        Weathers = v4.Weathers,
        Duration = v4.Lasts,
        Order = v4.StartOrder
    });
end;
table.sort(u1, function(p5, p6) --[[ Line: 17 ]]
    return p5.Order < p6.Order;
end);
local u7 = 0;
for _, v8 in u1 do
    u7 = u7 + v8.Duration;
end;
local function u15() --[[ Line: 42 ]]
    -- upvalues: u7 (ref), u1 (copy)
    local v9 = os.time() / u7;
    local v10 = math.floor(v9);
    local v11 = workspace:GetAttribute("ActivePhase");
    if not (v11 and workspace:GetAttribute("PhaseDuration")) then
        repeat
            task.wait(0.1);
            v11 = workspace:GetAttribute("ActivePhase");
        until v11 and workspace:GetAttribute("PhaseDuration");
    end;
    local v12 = workspace:GetAttribute("PhaseDuration") - workspace:GetServerTimeNow();
    for v13, v14 in u1 do
        if v14.Name == v11 then
            return v10, v13, v14, v14.Duration - v12, v12;
        end;
    end;
end;
function v2.Init(_) --[[ Line: 104 ]] end;
function v2.Start(u16) --[[ Line: 107 ]]
    task.spawn(function() --[[ Line: 108 ]]
        -- upvalues: u16 (copy)
        local l__TimeCycleBar__3 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TeleportButtons"):WaitForChild("TimeCycleBar");
        local l__MainFrame__4 = l__TimeCycleBar__3:WaitForChild("MainFrame");
        local l__Bar__5 = l__MainFrame__4:WaitForChild("Bar");
        u16:SetupBar(l__Bar__5, l__MainFrame__4:WaitForChild("TextLabel"), l__Bar__5:WaitForChild("UIGradient"), (l__TimeCycleBar__3:WaitForChild("Vector")));
    end);
end;
function v2.SetupBar(_, u17, u18, u19, u20) --[[ Line: 121 ]]
    -- upvalues: u15 (copy), l__TweenService__2 (copy)
    local u21 = TweenInfo.new(0.1, Enum.EasingStyle.Linear);
    u20.AnchorPoint = Vector2.new(0.5, 0.5);
    task.spawn(function() --[[ Line: 137 ]]
        -- upvalues: u15 (ref), l__TweenService__2 (ref), u19 (copy), u21 (copy), u17 (copy), u20 (copy), u18 (copy)
        while true do
            local _, _, v22, v23, v24 = u15();
            local v25 = workspace:GetAttribute("ActiveWeather");
            local v26 = nil;
            if type(v25) == "string" and (v22.Weathers and v22.Weathers[v25]) then
                v26 = v22.Weathers[v25];
            else
                local v27 = (-1 / 0);
                for _, v28 in v22.Weathers do
                    if v27 < v28.Chance then
                        v27 = v28.Chance;
                        v26 = v28;
                    end;
                end;
            end;
            local v29 = v23 / v22.Duration;
            l__TweenService__2:Create(u19, u21, {
                Offset = Vector2.new(-0.9 * (1 - v29), 0)
            }):Play();
            local v30 = (u17.AbsolutePosition.X + u17.AbsoluteSize.X * (0.1 + 0.9 * v29) - u20.Parent.AbsolutePosition.X) / u20.Parent.AbsoluteSize.X;
            local v31 = 1 - v29;
            l__TweenService__2:Create(u20, u21, {
                Position = UDim2.new(v30, 0, v31 * v31 * 0.56 + 2 * v31 * v29 * 0.35 + v29 * v29 * 0.56, 0)
            }):Play();
            u17.ImageColor3 = v26.Color;
            u20.Image = v26.Image;
            local v32 = math.ceil(v24);
            local v33 = u18;
            local v34 = math.floor(v32 / 60);
            local v35 = v32 % 60;
            local v36;
            if v34 > 0 then
                v36 = string.format("%dm %ds", v34, v35);
            else
                v36 = string.format("%ds", v35);
            end;
            v33.Text = v36;
            task.wait(1);
        end;
    end);
end;
return v2;