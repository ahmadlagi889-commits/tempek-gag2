-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game.ReplicatedStorage;
local l__TimeCycleData__2 = require(l__ReplicatedStorage__1.SharedModules.TimeCycleData);
require(l__ReplicatedStorage__1.ClientModules.Skybox);
local l__MusicController__3 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.MusicController);
local l__Phases__4 = script.Phases;
local u1 = {};
local u2 = nil;
local u3 = nil;
local v4 = {
    StartOrder = 1
};
for v5, v6 in l__TimeCycleData__2.Data do
    table.insert(u1, {
        Name = v5,
        Weathers = v6.Weathers,
        Duration = v6.Lasts,
        Order = v6.StartOrder
    });
end;
table.sort(u1, function(p7, p8) --[[ Line: 24 ]]
    return p7.Order < p8.Order;
end);
local u9 = 0;
for _, v10 in u1 do
    u9 = u9 + v10.Duration;
end;
local function u25(p11, p12) --[[ Line: 31 ]]
    -- block 11
    local v13 = 0;
    for _, v14 in p11.Weathers do
        v13 = v13 + v14.Chance;
    end;
    local v15 = p12:NextNumber() * v13;
    local v16 = 0;
    for v17, v18 in p11.Weathers do
        v16 = v16 + v18.Chance;
        if v15 <= v16 then
            return v17, v18;
        end;
    end;
    local v19, v20, v21;
    v19, v20, v21 = p11.Weathers, nil, nil;
    local v22, v23, v24;
    if type(v19) == "function" then
        v22, v23 = v19(v20, v24);
    else
        v22, v23 = next(v19, v24);
    end;
    v24 = v22;
    -- block 2
    return v22, v23;
    return v22, v23;
end;
local function u31() --[[ Line: 49 ]]
    -- upvalues: u9 (ref), u1 (copy)
    local v26 = os.time() / u9;
    local v27 = math.floor(v26);
    local v28 = workspace:GetAttribute("ActivePhase");
    if not v28 then
        repeat
            task.wait(0.1);
            v28 = workspace:GetAttribute("ActivePhase");
        until v28;
    end;
    for v29, v30 in u1 do
        if v30.Name == v28 then
            return v27, v29, v30, 0, v30.Duration;
        end;
    end;
    return v27, #u1;
end;
local function u36(p32, p33, p34) --[[ Line: 94 ]]
    -- upvalues: u2 (ref), u3 (ref), l__Phases__4 (copy), l__MusicController__3 (copy)
    if u2 and u2.End then
        u2:End();
    end;
    u3 = p33;
    local v35 = l__Phases__4:FindFirstChild(p32);
    if v35 then
        u2 = require(v35);
        if not u2.NoMusic then
            l__MusicController__3:SetActiveWeather(p33);
        end;
        if u2.Start then
            u2:Start(p33, p34);
        end;
    else
        l__MusicController__3:SetActiveWeather(p33);
        u2 = nil;
    end;
end;
function v4.GetCurrentWeather(_) --[[ Line: 120 ]]
    -- upvalues: u3 (ref)
    return u3;
end;
function v4.Init(_) --[[ Line: 124 ]] end;
function v4.Start(_) --[[ Line: 127 ]]
    -- upvalues: u31 (copy), u25 (copy), u36 (copy)
    task.spawn(function() --[[ Line: 128 ]]
        -- upvalues: u31 (ref), u25 (ref), u36 (ref)
        while true do
            local v37, v38, v39, _, _ = u31();
            local v40 = workspace:GetAttribute("ActiveWeather");
            local v41;
            if type(v40) == "string" and (v39.Weathers and v39.Weathers[v40]) then
                v41 = v39.Weathers[v40];
            else
                v40, v41 = u25(v39, (Random.new(v37 * 1000 + v38)));
            end;
            u36(v40, v40, v41);
            local u42 = coroutine.running();
            local u43 = false;
            local u44 = nil;
            local u45 = nil;
            local function v46() --[[ Line: 152 ]]
                -- upvalues: u43 (ref), u44 (ref), u45 (ref), u42 (copy)
                if u43 then
                else
                    u43 = true;
                    if u44 then
                        u44:Disconnect();
                    end;
                    if u45 then
                        u45:Disconnect();
                    end;
                    task.spawn(u42);
                end;
            end;
            u44 = workspace:GetAttributeChangedSignal("ActivePhase"):Connect(v46);
            u45 = workspace:GetAttributeChangedSignal("ActiveWeather"):Connect(v46);
            coroutine.yield();
        end;
    end);
end;
return v4;