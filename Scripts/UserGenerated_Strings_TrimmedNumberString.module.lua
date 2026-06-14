-- Decompiled with Potassium's decompiler.

return function(p1) --[[ Name: TrimmedNumberString, Line 20 ]]
    local v2 = type(p1) == "number";
    assert(v2);
    if p1 == p1 then
        if p1 == (1 / 0) then
            return "Infinity";
        elseif p1 == (-1 / 0) then
            return "-Infinity";
        else
            local v3 = string.format("%f", p1);
            local v4, v5 = string.match(v3, "^([^%.]*)%.?(.*)$");
            assert(v4);
            if v5 then
                local v6 = string.gsub(v5, "0+$", "");
                if #v6 == 0 then
                    return v4;
                else
                    return `{v4}.{v6}`;
                end;
            else
                return v4;
            end;
        end;
    else
        return "NaN";
    end;
end;