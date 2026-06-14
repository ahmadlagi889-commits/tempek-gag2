-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local function u6() --[[ Line: 19 ]]
    -- upvalues: l__HttpService__1 (copy)
    local v1 = workspace:GetAttribute("RemoteGamepasses");
    if type(v1) ~= "string" or v1 == "" then
        return {};
    end;
    local v2, v3 = pcall(l__HttpService__1.JSONDecode, l__HttpService__1, v1);
    if not v2 or type(v3) ~= "table" then
        return {};
    end;
    local v4 = {};
    for _, v5 in v3 do
        if type(v5) == "table" and type(v5[3]) == "string" then
            table.insert(v4, v5[3]);
        end;
    end;
    return v4;
end;
return function(p7) --[[ Line: 33 ]]
    -- upvalues: u6 (copy)
    p7:RegisterType("gamepassName", {
        Validate = function(p8) --[[ Name: Validate, Line 35 ]]
            -- upvalues: u6 (ref)
            local u9 = u6();
            return (function(p10, p11) --[[ Line: 4 ]]
                -- upvalues: u9 (copy)
                local v12 = {};
                for _, v13 in u9 do
                    if v13:lower() == p10:lower() then
                        if p11 then
                            return v13;
                        end;
                        table.insert(v12, 1, v13);
                    elseif v13:lower():find(p10:lower(), 1, true) then
                        table.insert(v12, v13);
                    end;
                end;
                if p11 then
                    return v12[1];
                else
                    return v12;
                end;
            end)(p8, true) ~= nil, string.format("%q is not a valid gamepass. Valid gamepasses: %s", p8, table.concat(u9, ", "));
        end,
        Autocomplete = function(p14) --[[ Name: Autocomplete, Line 40 ]]
            -- upvalues: u6 (ref)
            local u15 = u6();
            return (function(p16, p17) --[[ Line: 4 ]]
                -- upvalues: u15 (copy)
                local v18 = {};
                for _, v19 in u15 do
                    if v19:lower() == p16:lower() then
                        if p17 then
                            return v19;
                        end;
                        table.insert(v18, 1, v19);
                    elseif v19:lower():find(p16:lower(), 1, true) then
                        table.insert(v18, v19);
                    end;
                end;
                if p17 then
                    return v18[1];
                else
                    return v18;
                end;
            end)(p14);
        end,
        Parse = function(p20) --[[ Name: Parse, Line 43 ]]
            -- upvalues: u6 (ref)
            local u21 = u6();
            return (function(p22, p23) --[[ Line: 4 ]]
                -- upvalues: u21 (copy)
                local v24 = {};
                for _, v25 in u21 do
                    if v25:lower() == p22:lower() then
                        if p23 then
                            return v25;
                        end;
                        table.insert(v24, 1, v25);
                    elseif v25:lower():find(p22:lower(), 1, true) then
                        table.insert(v24, v25);
                    end;
                end;
                if p23 then
                    return v24[1];
                else
                    return v24;
                end;
            end)(p20, true);
        end
    });
end;