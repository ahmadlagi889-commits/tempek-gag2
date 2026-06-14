-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local u1 = {
    Years = 31556926,
    Months = 2629744,
    Weeks = 604800,
    Days = 86400,
    Hours = 3600,
    Minutes = 60,
    Seconds = 1
};
local v2 = {};
for v3, _ in pairs(u1) do
    table.insert(v2, v3);
end;
local u4 = l__Util__1.MakeFuzzyFinder(v2);
local function u13(p5) --[[ Line: 19 ]]
    -- upvalues: u4 (copy), u1 (copy)
    if p5 == nil or p5 == "" then
        return nil;
    else
        local v6 = tonumber(p5);
        if v6 and v6 == 0 then
            return 0, 0, true;
        else
            local v7 = p5:gsub("-?%d+%a+", ""):match("-?%d+");
            if v7 then
                return nil, tonumber(v7), true;
            else
                local v8 = nil;
                local v9 = nil;
                for v10 in p5:gmatch("-?%d+%a+") do
                    local v11;
                    v9, v11 = v10:match("(-?%d+)(%a+)");
                    local v12 = u4(v11);
                    if #v12 == 0 then
                        return nil, tonumber(v9);
                    end;
                    v8 = (v8 == nil and 0 or v8) + (v11:lower() == "m" and 60 or u1[v12[1]]) * tonumber(v9);
                end;
                if v8 == nil then
                    return nil;
                else
                    return v8, tonumber(v9);
                end;
            end;
        end;
    end;
end;
local function u22(p14, p15, p16, p17) --[[ Line: 58 ]]
    local v18 = p17 or 1;
    local v19 = {};
    for v20, v21 in pairs(p14) do
        if p16 == 1 then
            v19[v20] = p15 .. v21:sub(v18, #v21 - 1);
        else
            v19[v20] = p15 .. v21:sub(v18);
        end;
    end;
    return v19;
end;
local u33 = {
    Transform = function(p23) --[[ Name: Transform, Line 72 ]]
        -- upvalues: u13 (copy)
        return p23, u13(p23);
    end,
    Validate = function(_, p24) --[[ Name: Validate, Line 76 ]]
        return p24 ~= nil;
    end,
    Autocomplete = function(p25, p26, p27, p28, p29) --[[ Name: Autocomplete, Line 80 ]]
        -- upvalues: u4 (copy), u22 (copy)
        local v30 = {};
        if p28 or p29 then
            if p28 == true then
                p29 = u4("") or p29;
            end;
            if p28 == true then
                return u22(p29, p25, p27);
            else
                return u22(p29, p25, p25:match("^.*(%a+)$"):len() + 1);
            end;
        else
            if p26 ~= nil then
                local v31 = p25:match("^.*-?%d+(%a+)%s?$");
                v30 = u22(u4(v31), p25, p27, #v31 + 1);
                table.sort(v30);
            end;
            return v30;
        end;
    end,
    Parse = function(_, p32) --[[ Name: Parse, Line 104 ]]
        return p32;
    end
};
return function(p34) --[[ Line: 109 ]]
    -- upvalues: u33 (copy), l__Util__1 (copy)
    p34:RegisterType("duration", u33);
    p34:RegisterType("durations", l__Util__1.MakeListableType(u33));
end;