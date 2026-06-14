-- Decompiled with Potassium's decompiler.

local u1 = {
    "perch",
    "eat",
    "circle",
    "dropseed"
};
local function u6(p2, p3) --[[ Line: 3 ]]
    -- upvalues: u1 (copy)
    local v4 = {};
    for _, v5 in u1 do
        if v5:lower() == p2:lower() then
            if p3 then
                return v5;
            end;
            table.insert(v4, 1, v5);
        elseif v5:lower():find(p2:lower(), 1, true) then
            table.insert(v4, v5);
        end;
    end;
    if p3 then
        return v4[1];
    else
        return v4;
    end;
end;
return function(p7) --[[ Line: 17 ]]
    -- upvalues: u6 (copy), u1 (copy)
    p7:RegisterType("robinAction", {
        Validate = function(p8) --[[ Name: Validate, Line 19 ]]
            -- upvalues: u6 (ref), u1 (ref)
            return u6(p8, true) ~= nil, string.format("%q is not a valid action. Valid actions: %s", p8, table.concat(u1, ", "));
        end,
        Autocomplete = function(p9) --[[ Name: Autocomplete, Line 23 ]]
            -- upvalues: u6 (ref)
            return u6(p9);
        end,
        Parse = function(p10) --[[ Name: Parse, Line 26 ]]
            -- upvalues: u6 (ref)
            return u6(p10, true);
        end
    });
end;