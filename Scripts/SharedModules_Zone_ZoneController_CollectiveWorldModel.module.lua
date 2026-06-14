-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = nil;
local l__RunService__1 = game:GetService("RunService");
function v1.setupWorldModel(_) --[[ Line: 8 ]]
    -- upvalues: u2 (ref), l__RunService__1 (copy)
    if u2 then
        return u2;
    end;
    local v3 = l__RunService__1:IsClient() and "ReplicatedStorage" or "ServerStorage";
    u2 = Instance.new("WorldModel");
    u2.Name = "ZonePlusWorldModel";
    u2.Parent = game:GetService(v3);
    return u2;
end;
function v1._getCombinedResults(_, p4, ...) --[[ Line: 22 ]]
    -- upvalues: u2 (ref)
    local v5 = workspace[p4](workspace, ...);
    if u2 then
        local v6 = u2[p4](u2, ...);
        for _, v7 in pairs(v6) do
            table.insert(v5, v7);
        end;
    end;
    return v5;
end;
function v1.GetPartBoundsInBox(p8, p9, p10, p11) --[[ Line: 33 ]]
    return p8:_getCombinedResults("GetPartBoundsInBox", p9, p10, p11);
end;
function v1.GetPartBoundsInRadius(p12, p13, p14, p15) --[[ Line: 37 ]]
    return p12:_getCombinedResults("GetPartBoundsInRadius", p13, p14, p15);
end;
function v1.GetPartsInPart(p16, p17, p18) --[[ Line: 41 ]]
    return p16:_getCombinedResults("GetPartsInPart", p17, p18);
end;
return v1;