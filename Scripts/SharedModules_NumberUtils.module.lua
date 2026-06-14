-- Decompiled with Potassium's decompiler.

return {
    HumanFriendlyRound = function(p1) --[[ Line: 2 ]]
        if p1 < 10 then
            return math.floor(p1 + 0.5);
        elseif p1 < 100 then
            return math.floor(p1 / 5 + 0.5) * 5;
        elseif p1 < 1000 then
            return math.floor(p1 / 25 + 0.5) * 25;
        elseif p1 < 10000 then
            return math.floor(p1 / 100 + 0.5) * 100;
        elseif p1 < 100000 then
            return math.floor(p1 / 500 + 0.5) * 500;
        elseif p1 < 1000000 then
            return math.floor(p1 / 1000 + 0.5) * 1000;
        else
            return math.floor(p1 / 5000 + 0.5) * 5000;
        end;
    end,
    FormatWithCommas = function(p2) --[[ Line: 12 ]]
        local v3, v4, v5 = tostring(p2):match("^([^%d]*)(%d+)(.-)$");
        return v3 .. v4:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. v5;
    end,
    Abbreviate = function(p6, p7) --[[ Line: 19 ]]
        local v8 = p7 or 2;
        local v9 = math.abs(p6);
        local v10, v11;
        if v9 >= 1000000000000000 then
            v10 = p6 / 1000000000000000;
            v11 = "Qd";
        elseif v9 >= 1000000000000 then
            v10 = p6 / 1000000000000;
            v11 = "T";
        elseif v9 >= 1000000000 then
            v10 = p6 / 1000000000;
            v11 = "B";
        elseif v9 >= 1000000 then
            v10 = p6 / 1000000;
            v11 = "M";
        else
            if v9 < 1000 then
                return tostring(p6);
            end;
            v10 = p6 / 1000;
            v11 = "K";
        end;
        return string.format(`%.{v8}f`, v10):gsub("%.?0+$", "") .. v11;
    end,
    Parse = function(p12, p13, p14) --[[ Line: 43 ]]
        local v15 = 0;
        if type(p12) == "string" then
            local v16 = p12:lower():gsub("[,%s]", ""):gsub("[^%d%.kmbtqn%-]", "");
            if not v16:find("[i]") then
                local v17 = (v16:find("qi") or v16:find("qn")) and 1e18 or (v16:find("q") and 1000000000000000 or (v16:find("t") and 1000000000000 or (v16:find("b") and 1000000000 or (v16:find("m") and 1000000 or (v16:find("k") and 1000 or 1)))));
                local v18 = v16:gsub("[^%d%.%-]", "");
                if v18 ~= "" and (v18 ~= "." and (v18 ~= "-" and v18 ~= "-.")) then
                    v15 = (tonumber(v18) or 0) * v17;
                end;
            end;
        else
            v15 = tonumber(p12) or 0;
        end;
        local v19 = (v15 ~= v15 or math.abs(v15) == (1 / 0)) and 0 or v15;
        if p13 or p14 then
            v19 = math.clamp(v19, p13 or (-1 / 0), p14 or (1 / 0)) or v19;
        end;
        return v19;
    end
};