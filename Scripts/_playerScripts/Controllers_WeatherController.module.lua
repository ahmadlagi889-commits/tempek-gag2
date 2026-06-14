-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__WeatherData__4 = require(l__ReplicatedStorage__2.SharedModules.WeatherData);
local l__WeatherValues__5 = l__ReplicatedStorage__2:WaitForChild("WeatherValues");
local l__Frame__6 = l__Players__1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("WeatherUI"):WaitForChild("Frame");
local u2 = {};
local u3 = {};
local function u18(u4, u5) --[[ Line: 70 ]]
    -- upvalues: u3 (copy), l__WeatherValues__5 (copy), l__RunService__3 (copy)
    if u5 then
        if u3[u4] then
            u3[u4]:Disconnect();
            u3[u4] = nil;
        end;
        local l__UnixTimestamp__7 = DateTime.now().UnixTimestamp;
        local v6 = (l__WeatherValues__5:GetAttribute(u4 .. "_EndTime") or 0) - l__UnixTimestamp__7;
        local v7 = math.max(0, v6);
        local v8;
        if v7 <= 0 then
            v8 = "0s";
        else
            local v9 = math.floor(v7 / 60);
            local v10 = math.floor(v7 % 60);
            if v9 > 0 then
                v8 = string.format("%dm %ds", v9, v10);
            else
                v8 = string.format("%ds", v10);
            end;
        end;
        u5.Text = v8;
        u3[u4] = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 83 ]]
            -- upvalues: u4 (copy), l__WeatherValues__5 (ref), u5 (copy)
            if l__WeatherValues__5:GetAttribute(u4 .. "_Playing") then
                local v11 = u4;
                local v12 = u5;
                local l__UnixTimestamp__8 = DateTime.now().UnixTimestamp;
                local v13 = (l__WeatherValues__5:GetAttribute(v11 .. "_EndTime") or 0) - l__UnixTimestamp__8;
                local v14 = math.max(0, v13);
                local v15;
                if v14 <= 0 then
                    v15 = "0s";
                else
                    local v16 = math.floor(v14 / 60);
                    local v17 = math.floor(v14 % 60);
                    if v16 > 0 then
                        v15 = string.format("%dm %ds", v16, v17);
                    else
                        v15 = string.format("%ds", v17);
                    end;
                end;
                v12.Text = v15;
            end;
        end);
    end;
end;
function v1.SetupWeather(_, u19) --[[ Line: 90 ]]
    -- upvalues: u2 (copy), l__Frame__6 (copy), l__WeatherValues__5 (copy), u18 (copy), u3 (copy)
    local v20 = script:FindFirstChild(u19);
    if v20 then
        u2[u19] = require(v20);
    end;
    local u21 = l__Frame__6:FindFirstChild(u19);
    if u21 then
        local u22 = u21:FindFirstChild("Time");
        local v23 = l__WeatherValues__5:GetAttribute(u19 .. "_Playing");
        u21.Visible = v23 or false;
        if v23 then
            local v24 = u2[u19];
            if v24 and v24.StartWeather then
                v24.StartWeather();
            end;
            u18(u19, u22);
        end;
        l__WeatherValues__5:GetAttributeChangedSignal(u19 .. "_Playing"):Connect(function() --[[ Line: 113 ]]
            -- upvalues: u19 (copy), l__WeatherValues__5 (ref), u21 (copy), u2 (ref), u18 (ref), u22 (copy), u3 (ref)
            local v25 = l__WeatherValues__5:GetAttribute(u19 .. "_Playing");
            u21.Visible = v25;
            if v25 then
                local v26 = u2[u19];
                if v26 and v26.StartWeather then
                    v26.StartWeather();
                end;
                u18(u19, u22);
            else
                local v27 = u2[u19];
                if v27 and v27.EndWeather then
                    v27.EndWeather();
                end;
                if u3[u19] then
                    u3[u19]:Disconnect();
                    u3[u19] = nil;
                end;
            end;
        end);
    end;
end;
function v1.Init(_) --[[ Line: 133 ]] end;
function v1.Start(p28) --[[ Line: 138 ]]
    -- upvalues: l__WeatherData__4 (copy)
    for _, v29 in l__WeatherData__4.Data do
        p28:SetupWeather(v29.Name);
    end;
end;
return v1;