-- Decompiled with Potassium's decompiler.

local l__Lighting__1 = game:GetService("Lighting");
local v1 = {};
if l__Lighting__1:GetAttribute("ActiveWeatherEffects") == nil then
    l__Lighting__1:SetAttribute("ActiveWeatherEffects", 0);
end;
local u2 = 0.016666666666666666;
local function v5() --[[ Line: 30 ]]
    -- upvalues: l__Lighting__1 (copy), u2 (ref)
    local v3 = l__Lighting__1:GetAttribute("ActiveWeatherEffects") or 1;
    local v4 = math.max(1, v3);
    u2 = 1 / math.max(10, 60 / v4);
end;
l__Lighting__1:GetAttributeChangedSignal("ActiveWeatherEffects"):Connect(v5);
local v6 = l__Lighting__1:GetAttribute("ActiveWeatherEffects") or 1;
local v7 = math.max(1, v6);
u2 = 1 / math.max(10, 60 / v7);
function v1.Register() --[[ Line: 40 ]]
    -- upvalues: l__Lighting__1 (copy)
    l__Lighting__1:SetAttribute("ActiveWeatherEffects", (l__Lighting__1:GetAttribute("ActiveWeatherEffects") or 0) + 1);
end;
function v1.Unregister() --[[ Line: 45 ]]
    -- upvalues: l__Lighting__1 (copy)
    local v8 = l__Lighting__1;
    local v9 = (l__Lighting__1:GetAttribute("ActiveWeatherEffects") or 0) - 1;
    v8:SetAttribute("ActiveWeatherEffects", (math.max(0, v9)));
end;
function v1.GetTickInterval() --[[ Line: 51 ]]
    -- upvalues: u2 (ref)
    return u2;
end;
function v1.GetActiveCount() --[[ Line: 56 ]]
    -- upvalues: l__Lighting__1 (copy)
    local v10 = l__Lighting__1:GetAttribute("ActiveWeatherEffects") or 1;
    return math.max(1, v10);
end;
return v1;