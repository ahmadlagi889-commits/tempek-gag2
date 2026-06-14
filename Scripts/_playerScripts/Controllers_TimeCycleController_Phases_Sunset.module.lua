-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__LightingController__1 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
local u2 = {
    ClockTime = 17
};
function v1.Start(_, _, _) --[[ Line: 9 ]]
    -- upvalues: l__LightingController__1 (copy), u2 (copy)
    local v3 = {};
    for v4, v5 in l__LightingController__1:GetDefault() do
        v3[v4] = v5;
    end;
    for v6, v7 in u2 do
        v3[v6] = v7;
    end;
    l__LightingController__1:TransitionTo(v3);
end;
function v1.End(_) --[[ Line: 20 ]] end;
return v1;