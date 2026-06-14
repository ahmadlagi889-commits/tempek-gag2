-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
return function(p1) --[[ Line: 19 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local u2 = {};
    for _, v3 in require(l__ReplicatedStorage__1:WaitForChild("SharedModules"):WaitForChild("RakeData")) do
        table.insert(u2, v3.RakeName);
    end;
    local function u8(p4, p5) --[[ Line: 4 ]]
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
    p1:RegisterType("rakeName", {
        Validate = function(p9) --[[ Name: Validate, Line 30 ]]
            -- upvalues: u8 (copy), u2 (copy)
            return u8(p9, true) ~= nil, string.format("%q is not a valid rake. Valid: %s", p9, table.concat(u2, ", "));
        end,
        Autocomplete = function(p10) --[[ Name: Autocomplete, Line 34 ]]
            -- upvalues: u8 (copy)
            return u8(p10);
        end,
        Parse = function(p11) --[[ Name: Parse, Line 37 ]]
            -- upvalues: u8 (copy)
            return u8(p11, true);
        end
    });
end;