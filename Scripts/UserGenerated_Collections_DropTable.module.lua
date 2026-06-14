-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Asserts__2 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local u1 = require(l__ReplicatedStorage__1.UserGenerated.Randoms.ISAAC).Unique();
local u2 = l__Asserts__2.Table({
    Weight = l__Asserts__2.FinitePositive,
    Value = l__Asserts__2.Any
});
local v3 = l__Asserts__2.Table({
    Weight = l__Asserts__2.FinitePositive,
    Chance = l__Asserts__2.Range(0, 1),
    Value = l__Asserts__2.Any
});
local v4 = {};
local function u10(p5, p6) --[[ Line: 73 ]]
    local v7 = #p5;
    local v8 = 1;
    while v8 < v7 do
        local v9 = v8 + (v7 - v8) // 2;
        if p6 < p5[v9] then
            v7 = v9;
        else
            v8 = v9 + 1;
        end;
    end;
    return v8;
end;
function v4.Next(p11) --[[ Line: 90 ]]
    -- upvalues: u1 (copy), u10 (copy)
    local v12 = u1:NextDouble();
    local v13 = u10(p11.Uppers, p11.TotalWeight * v12);
    local v14 = p11.Entries[v13];
    return v14.Value, v14;
end;
function v4.Pick(p15, p16) --[[ Line: 102 ]]
    -- upvalues: u10 (copy)
    local v17;
    if p16 >= 0 then
        v17 = p16 <= 1;
    else
        v17 = false;
    end;
    assert(v17);
    local v18 = u10(p15.Uppers, p15.TotalWeight * p16);
    local v19 = p15.Entries[v18];
    return v19.Value, v19;
end;
local u20 = table.freeze({
    __index = table.freeze(v4)
});
local function u23(p21, p22) --[[ Line: 115 ]]
    if p21.Weight == p22.Weight then
        return p21.Index < p22.Index;
    else
        return p21.Weight < p22.Weight;
    end;
end;
local function u37(p24) --[[ Line: 123 ]]
    -- upvalues: l__Asserts__2 (copy), u2 (copy), u23 (copy), u20 (copy)
    l__Asserts__2.Array(u2)(p24);
    local v25 = #p24;
    assert(v25 > 0);
    local v26 = {};
    for v27, v28 in ipairs(p24) do
        table.insert(v26, {
            Index = v27,
            Weight = v28.Weight
        });
    end;
    table.sort(v26, u23);
    local v29 = table.create(v25, 0);
    local v30 = 0;
    local v31 = {};
    for v32, v33 in ipairs(v26) do
        local v34 = p24[v33.Index];
        local l__Weight__3 = v34.Weight;
        v30 = v30 + l__Weight__3;
        v29[v32] = v30;
        table.insert(v31, {
            Chance = 0,
            Weight = l__Weight__3,
            Value = v34.Value
        });
    end;
    table.freeze(v29);
    for _, v35 in ipairs(v31) do
        v35.Chance = v35.Weight / v30;
        table.freeze(v35);
    end;
    table.freeze(v31);
    local v36 = setmetatable({
        TotalWeight = v30,
        Entries = v31,
        Uppers = v29
    }, u20);
    table.freeze(v36);
    return v36;
end;
local u42 = table.freeze({
    __index = table.freeze({
        Add = function(p38, p39, p40) --[[ Name: Add, Line 211 ]]
            -- upvalues: l__Asserts__2 (copy)
            l__Asserts__2.FinitePositive(p39);
            p38.AssertValue(p40);
            table.insert(p38.Entries, {
                Weight = p39,
                Value = p40
            });
            return p38;
        end,
        Build = function(p41) --[[ Name: Build, Line 221 ]]
            -- upvalues: u37 (copy)
            return u37(p41.Entries);
        end
    })
});
return table.freeze({
    new = u37,
    IsA = function(p43) --[[ Name: IsA, Line 176 ]]
        -- upvalues: u20 (copy)
        local v44;
        if type(p43) == "table" then
            v44 = getmetatable(p43) == u20;
        else
            v44 = false;
        end;
        return v44;
    end,
    Assert = function(p45) --[[ Name: Assert, Line 180 ]]
        -- upvalues: u20 (copy)
        if type(p45) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p45) ~= u20 then
            error("DropTable", 2);
        end;
        return p45;
    end,
    AssertEntry = v3,
    Builder = function(p46) --[[ Name: Builder, Line 227 ]]
        -- upvalues: l__Asserts__2 (copy), u42 (copy)
        l__Asserts__2.Function(p46);
        local v47 = setmetatable({
            AssertValue = p46,
            Entries = {}
        }, u42);
        table.freeze(v47);
        return v47;
    end,
    IsABuilder = function(p48) --[[ Name: IsABuilder, Line 241 ]]
        -- upvalues: u42 (copy)
        local v49;
        if type(p48) == "table" then
            v49 = getmetatable(p48) == u42;
        else
            v49 = false;
        end;
        return v49;
    end,
    AssertBuilder = function(p50) --[[ Name: AssertBuilder, Line 245 ]]
        -- upvalues: u42 (copy)
        if type(p50) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p50) ~= u42 then
            error("table", 2);
        end;
        return p50;
    end,
    AssertBuilderEntry = u2
});