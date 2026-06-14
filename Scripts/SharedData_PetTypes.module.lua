-- Decompiled with Potassium's decompiler.

local u1 = {
    Rainbow = {
        DisplayText = "RAINBOW"
    }
};
return table.freeze({
    Rainbow = "Rainbow",
    BOOST_MULTIPLIER = 1.25,
    IsValid = function(p2) --[[ Name: IsValid, Line 49 ]]
        -- upvalues: u1 (copy)
        if type(p2) == "string" then
            return u1[p2] ~= nil;
        else
            return false;
        end;
    end,
    GetBoostMultiplier = function(p3) --[[ Name: GetBoostMultiplier, Line 56 ]]
        return p3 == "Rainbow" and 1.25 or 1;
    end,
    GetDisplayText = function(p4) --[[ Name: GetDisplayText, Line 63 ]]
        -- upvalues: u1 (copy)
        if type(p4) == "string" then
            local v5 = u1[p4];
            if v5 then
                return v5.DisplayText;
            else
                return nil;
            end;
        else
            return nil;
        end;
    end,
    IsRainbow = function(p6) --[[ Name: IsRainbow, Line 72 ]]
        if type(p6) == "table" then
            return p6.Type == "Rainbow";
        else
            return false;
        end;
    end
});