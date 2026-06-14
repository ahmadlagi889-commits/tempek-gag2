-- Decompiled with Potassium's decompiler.

local l__NumberUtils__1 = require(script.Parent.NumberUtils);
local l__WeightFormat__2 = require(script.Parent.WeightFormat);
local u1 = {
    Tags = {
        CarrotsHarvested = "carrots_harvested",
        GoldenCarrotsHarvested = "golden_carrots_harvested",
        PlantWeightHarvested = "plant_weight_harvested"
    }
};
local u2 = {};
for _, v3 in u1.Tags do
    u2[v3] = true;
end;
function u1.IsKnownTag(p4) --[[ Line: 42 ]]
    -- upvalues: u2 (copy)
    return u2[p4] == true;
end;
local u5 = nil;
function u1._setReporter(p6) --[[ Line: 53 ]]
    -- upvalues: u5 (ref)
    u5 = p6;
end;
function u1.Report(p7, p8, p9) --[[ Line: 61 ]]
    -- upvalues: u5 (ref), u2 (copy)
    if u5 then
        if typeof(p7) == "Instance" and p7:IsA("Player") then
            if typeof(p8) == "string" and u2[p8] then
                if typeof(p9) == "number" and (p9 == p9 and p9 > 0) then
                    u5(p7, p8, p9);
                end;
            end;
        end;
    end;
end;
function u1.Combine(p10, p11) --[[ Line: 74 ]]
    if not (p10 and p11) then
        return 0;
    end;
    local v12 = 0;
    for v13, v14 in p10 do
        local v15 = p11[v13];
        if typeof(v15) == "number" and typeof(v14) == "number" then
            v12 = v12 + v15 * v14;
        end;
    end;
    return v12;
end;
u1.ScoreFormats = {
    integer = function(p16) --[[ Name: integer, Line 95 ]]
        return string.format("%d", (math.round(p16)));
    end,
    commas = function(p17) --[[ Name: commas, Line 99 ]]
        -- upvalues: l__NumberUtils__1 (copy)
        return l__NumberUtils__1.FormatWithCommas((math.round(p17)));
    end,
    abbreviated = function(p18) --[[ Name: abbreviated, Line 103 ]]
        -- upvalues: l__NumberUtils__1 (copy)
        return l__NumberUtils__1.Abbreviate((math.floor(p18)));
    end,
    weight = function(p19) --[[ Name: weight, Line 107 ]]
        -- upvalues: l__WeightFormat__2 (copy)
        return l__WeightFormat__2.FormatGrams(p19);
    end
};
function u1.FormatScore(p20, p21) --[[ Line: 116 ]]
    -- upvalues: u1 (copy)
    local v22 = typeof(p20) ~= "number" and 0 or p20;
    local v23 = (v22 ~= v22 or (v22 == (1 / 0) or v22 == (-1 / 0))) and 0 or v22;
    local l__ScoreFormats__3 = u1.ScoreFormats;
    local v24;
    if p21 == nil then
        v24 = nil;
    else
        v24 = l__ScoreFormats__3[p21];
    end;
    return (v24 or l__ScoreFormats__3.integer)(v23);
end;
return u1;