-- Decompiled with Potassium's decompiler.

local u1 = {
    "BaseSpeed",
    "BaseJump",
    "ShovelPower",
    "MaxBackpack"
};
return function(p2) --[[ Line: 19 ]]
    -- upvalues: u1 (copy)
    local u3 = u1;
    local function u8(p4, p5) --[[ Line: 4 ]]
        -- upvalues: u3 (copy)
        local v6 = {};
        for _, v7 in u3 do
            if v7:lower() == p4:lower() then
                if p5 then
                    return v7;
                end;
                table.insert(v6, 1, v7);
            elseif v7:lower():find(p4:lower(), 1, true) then
                table.insert(v6, v7);
            end;
        end;
        if p5 then
            return v6[1];
        else
            return v6;
        end;
    end;
    p2:RegisterType("skillName", {
        Validate = function(p9) --[[ Name: Validate, Line 23 ]]
            -- upvalues: u8 (copy), u1 (ref)
            return u8(p9, true) ~= nil, string.format("%q is not a valid skill. Valid skills: %s", p9, table.concat(u1, ", "));
        end,
        Autocomplete = function(p10) --[[ Name: Autocomplete, Line 27 ]]
            -- upvalues: u8 (copy)
            return u8(p10);
        end,
        Parse = function(p11) --[[ Name: Parse, Line 30 ]]
            -- upvalues: u8 (copy)
            return u8(p11, true);
        end
    });
end;