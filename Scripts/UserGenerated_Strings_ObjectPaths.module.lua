-- Decompiled with Potassium's decompiler.

return table.freeze({
    QueryObject = function(p1, p2, p3) --[[ Name: QueryObject, Line 29 ]]
        for _, v4 in ipairs(string.split(p2, ".")) do
            if p1 == nil then
                return false;
            end;
            if p1 == p3 then
                return true;
            end;
            if type(p1) ~= "table" then
                return false;
            end;
            p1 = p1[v4];
        end;
        if p1 == nil then
            return false;
        elseif p1 == p3 then
            return true;
        else
            return true, p1;
        end;
    end,
    HasHierarchicalOverlap = function(p5, p6) --[[ Name: HasHierarchicalOverlap, Line 51 ]]
        if p5 == p6 then
            return true;
        end;
        local v7 = string.split(p5, ".");
        local v8 = string.split(p6, ".");
        for v9 = 1, math.min(#v7, #v8) do
            if v7[v9] ~= v8[v9] then
                return false;
            end;
        end;
        return true;
    end
});