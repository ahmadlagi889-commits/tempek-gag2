-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__EggData__2 = require(l__ReplicatedStorage__1:WaitForChild("SharedModules"):WaitForChild("EggData"));
return function(p1) --[[ Line: 20 ]]
    -- upvalues: l__EggData__2 (copy)
    local u2 = {};
    for _, v3 in l__EggData__2.Data do
        table.insert(u2, v3.EggName);
    end;
    local function u8(p4, p5) --[[ Line: 5 ]]
        -- upvalues: u2 (copy)
        local v6 = {};
        for _, v7 in u2 do
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
    p1:RegisterType("eggName", {
        Validate = function(p9) --[[ Name: Validate, Line 29 ]]
            -- upvalues: u8 (copy), u2 (copy)
            return u8(p9, true) ~= nil, string.format("%q is not a valid egg. Valid eggs: %s", p9, table.concat(u2, ", "));
        end,
        Autocomplete = function(p10) --[[ Name: Autocomplete, Line 33 ]]
            -- upvalues: u8 (copy)
            return u8(p10);
        end,
        Parse = function(p11) --[[ Name: Parse, Line 36 ]]
            -- upvalues: u8 (copy)
            return u8(p11, true);
        end
    });
end;