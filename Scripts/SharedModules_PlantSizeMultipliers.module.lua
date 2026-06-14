-- Decompiled with Potassium's decompiler.

local v1 = {};
local u3 = Random and function(p2) --[[ Line: 6 ]]
    return p2 and Random.new(p2) or Random.new();
end or nil;
local u4 = {
    chanceAtLuck1 = 0.01,
    chanceAtLuck100 = 0.05,
    maxSize = 10000000
};
local function u11(p5, p6, p7) --[[ Line: 41 ]]
    -- upvalues: u4 (copy)
    local v8 = (math.clamp(p6 or 1, 1, 100) - 1) / 99;
    local v9 = u4.chanceAtLuck1 + (u4.chanceAtLuck100 - u4.chanceAtLuck1) * v8;
    local v10 = 0;
    while p7 * 2 <= u4.maxSize and p5:NextNumber() <= v9 do
        p7 = p7 * 2;
        v10 = v10 + 1;
    end;
    return p7, v10;
end;
local function u18(p12, p13) --[[ Line: 66 ]]
    if p12.usesLuck then
        local l__luckExponent__1 = p12.luckExponent;
        if l__luckExponent__1 == 1 then
            local v14 = 1 / (math.exp(-(0.8 * (p13 - 8))) + 1);
            local v15 = 1 / (math.exp(-(0.5 * (p13 - 20))) + 1);
            return 100 + 14000 * v14 * (1 - v15 * 0.85);
        elseif l__luckExponent__1 == 1.5 then
            local v16 = 1 / (math.exp(-(0.3 * (p13 - 18))) + 1);
            local v17 = 1 / (math.exp(-(0.08 * (p13 - 75))) + 1);
            return 20 + 18000 * v16 * (1 - v17 * 0.6);
        elseif l__luckExponent__1 == 2 then
            return 5 + 25000 * (1 / (math.exp(-(0.1 * (p13 - 50))) + 1));
        elseif l__luckExponent__1 == 2.5 then
            return 1.5 + p13 * 30;
        elseif l__luckExponent__1 == 3.5 then
            return 0.01 + p13 * 3;
        elseif l__luckExponent__1 == 4.5 then
            return 0.001 + p13 * 0.1;
        elseif l__luckExponent__1 == 5.5 then
            return 0.0001 + p13 * 0.003;
        else
            return p12.weight;
        end;
    else
        return p12.weight;
    end;
end;
local function u28(p19, p20) --[[ Line: 108 ]]
    if p19.usesLuck then
        local v21 = p19.luckExponent or 1;
        if v21 == 1 then
            local v22 = 1 / (math.exp(-(1 * (p20 - 3))) + 1);
            local v23 = 1 / (math.exp(-(0.4 * (p20 - 12))) + 1);
            return 500 + 5000 * v22 * (1 - v23 * 0.85);
        elseif v21 == 1.5 then
            local v24 = 1 / (math.exp(-(0.4 * (p20 - 10))) + 1);
            local v25 = 1 / (math.exp(-(0.06 * (p20 - 55))) + 1);
            return 250 + 10000 * v24 * (1 - v25 * 0.5);
        elseif v21 == 2 then
            local v26 = 1 / (math.exp(-(0.12 * (p20 - 30))) + 1);
            local v27 = 1 / (math.exp(-(0.06 * (p20 - 75))) + 1);
            return 125 + 15000 * v26 * (1 - v27 * 0.4);
        elseif v21 == 2.5 then
            return 62.5 + 20000 * (1 / (math.exp(-(0.08 * (p20 - 55))) + 1));
        elseif v21 == 3 then
            return 31.25 + p20 * 50;
        elseif v21 == 3.5 then
            return 15.625 + p20 * 8;
        elseif v21 == 4 then
            return 3 + p20 * 0.5;
        elseif v21 == 4.5 then
            return 0.05 + p20 * 0.02;
        else
            return p19.weight;
        end;
    else
        return p19.weight;
    end;
end;
local function u46(p29, p30, p31, p32) --[[ Line: 147 ]]
    -- upvalues: u3 (ref), u11 (copy)
    local v33 = u3(p31);
    local v34 = math.clamp(p30 or 1, 1, 100);
    local v35 = {};
    local v36 = 0;
    for v37, v38 in p29 do
        v35[v37] = p32(v38, v34);
        v36 = v36 + v35[v37];
    end;
    local v39 = v33:NextNumber() * v36;
    local v40 = 0;
    local v41 = 1;
    for v42, v43 in p29 do
        v40 = v40 + v35[v42];
        if v39 <= v40 then
            v41 = v43.min + v33:NextNumber() * (v43.max - v43.min);
            break;
        end;
    end;
    local v44, v45 = u11(v33, v34, v41);
    return v44, v45, v41;
end;
function v1.GetRandomFruitSize(p47, p48) --[[ Line: 174 ]]
    -- upvalues: u46 (copy), u18 (copy)
    return u46({
        {
            min = 0.85,
            max = 1.15,
            weight = 10000,
            usesLuck = false
        },
        {
            min = 2.8,
            max = 3.3,
            weight = 5,
            usesLuck = true,
            luckExponent = 2
        },
        {
            min = 4,
            max = 5,
            weight = 1.5,
            usesLuck = true,
            luckExponent = 2.5
        },
        {
            min = 6.5,
            max = 7.5,
            weight = 0.01,
            usesLuck = true,
            luckExponent = 3.5
        },
        {
            min = 9.5,
            max = 12.5,
            weight = 0.001,
            usesLuck = true,
            luckExponent = 4.5
        },
        {
            min = 14.5,
            max = 17.5,
            weight = 0.0001,
            usesLuck = true,
            luckExponent = 5.5
        }
    }, p47, p48, u18);
end;
local u49 = {
    {
        min = 0.95,
        max = 1.05,
        weight = 2000,
        usesLuck = false
    },
    {
        min = 1.45,
        max = 1.55,
        weight = 250,
        usesLuck = true,
        luckExponent = 1.5
    },
    {
        min = 1.9,
        max = 2.1,
        weight = 125,
        usesLuck = true,
        luckExponent = 2
    },
    {
        min = 2.85,
        max = 3.15,
        weight = 62.5,
        usesLuck = true,
        luckExponent = 2.5
    },
    {
        min = 3.8,
        max = 4.2,
        weight = 31.25,
        usesLuck = true,
        luckExponent = 3
    },
    {
        min = 5.8,
        max = 6.2,
        weight = 15.625,
        usesLuck = true,
        luckExponent = 3.5
    },
    {
        min = 9.5,
        max = 12.5,
        weight = 3,
        usesLuck = true,
        luckExponent = 4
    },
    {
        min = 12,
        max = 17,
        weight = 0.05,
        usesLuck = true,
        luckExponent = 4.5
    },
    {
        min = 20,
        max = 35,
        weight = 0.0001,
        usesLuck = true,
        luckExponent = 5
    }
};
local u50 = {};
local function u55(p51) --[[ Line: 206 ]]
    local v52 = {};
    for v53, v54 in p51 do
        v52[v53] = {
            min = v54.min,
            max = v54.max,
            weight = v54.weight,
            usesLuck = v54.usesLuck,
            luckExponent = v54.luckExponent
        };
    end;
    return v52;
end;
function v1.GetRandomPlantSize(p56, p57, p58) --[[ Line: 220 ]]
    -- upvalues: u50 (copy), u49 (copy), u46 (copy), u28 (copy)
    return u46(p58 and u50[p58] or u49, p56, p57, u28);
end;
function v1.GetDefaultPlantTiers() --[[ Line: 227 ]]
    -- upvalues: u55 (copy), u49 (copy)
    return u55(u49);
end;
function v1.SetDevOverride(p59, p60) --[[ Line: 234 ]]
    -- upvalues: u50 (copy), u55 (copy)
    u50[p59] = u55(p60);
end;
function v1.ClearDevOverride(p61) --[[ Line: 238 ]]
    -- upvalues: u50 (copy)
    u50[p61] = nil;
end;
function v1.GetPlantWeightAtLuck(p62, p63) --[[ Line: 245 ]]
    -- upvalues: u28 (copy)
    return u28(p62, (math.clamp(p63 or 1, 1, 100)));
end;
function v1.SetDoublingConfig(p64) --[[ Line: 253 ]]
    -- upvalues: u4 (copy)
    for v65, v66 in p64 do
        u4[v65] = v66;
    end;
end;
function v1.GetDoublingChanceAtLuck(p67) --[[ Line: 260 ]]
    -- upvalues: u4 (copy)
    local v68 = (math.clamp(p67 or 1, 1, 100) - 1) / 99;
    return u4.chanceAtLuck1 + (u4.chanceAtLuck100 - u4.chanceAtLuck1) * v68;
end;
function v1.GetDoublingOdds(p69, p70) --[[ Line: 266 ]]
    -- upvalues: u4 (copy)
    local v71 = (math.clamp(p69 or 1, 1, 100) - 1) / 99;
    return (u4.chanceAtLuck1 + (u4.chanceAtLuck100 - u4.chanceAtLuck1) * v71) ^ p70;
end;
return v1;