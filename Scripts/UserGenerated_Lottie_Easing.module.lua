-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local function u20(p1, p2, p3, p4, p5) --[[ Line: 28 ]]
    if p5 <= 0 then
        return 0;
    end;
    if p5 >= 1 then
        return 1;
    end;
    if p1 == p2 and p3 == p4 then
        return p5;
    end;
    local v6 = p1 * 3;
    local v7 = (p3 - p1) * 3 - v6;
    local v8 = 1 - v6 - v7;
    local v9 = p2 * 3;
    local v10 = (p4 - p2) * 3 - v9;
    local v11 = 1 - v9 - v10;
    local v12 = p5;
    for _ = 1, 8 do
        local v13 = ((v8 * p5 + v7) * p5 + v6) * p5 - v12;
        if math.abs(v13) < 1e-7 then
            return ((v11 * p5 + v10) * p5 + v9) * p5;
        end;
        local v14 = (v8 * 3 * p5 + v7 * 2) * p5 + v6;
        if math.abs(v14) < 1e-7 then
            break;
        end;
        p5 = p5 - v13 / v14;
    end;
    local v15 = v12;
    local v16 = 0;
    local v17 = 1;
    for _ = 1, 16 do
        local v18 = ((v8 * v12 + v7) * v12 + v6) * v12 - v15;
        if math.abs(v18) < 1e-7 then
            break;
        end;
        if v18 > 0 then
            v17 = v12;
            v12 = v16;
        end;
        local v19 = (v12 + v17) * 0.5;
        v16 = v12;
        v12 = v19;
    end;
    return ((v11 * v12 + v10) * v12 + v9) * v12;
end;
local function u26(p21, p22, p23) --[[ Line: 82 ]]
    local v24 = table.create(#p21);
    for v25 = 1, #p21 do
        v24[v25] = p21[v25] + ((p22[v25] or p21[v25]) - p21[v25]) * p23;
    end;
    return v24;
end;
local function u40(p27, p28, p29) --[[ Line: 90 ]]
    local v30 = table.create(#p27.v);
    local v31 = table.create(#p27.i);
    local v32 = table.create(#p27.o);
    for v33 = 1, #p27.v do
        local v34 = p27.v[v33];
        local v35 = p28.v[v33];
        local v36 = p27.i[v33];
        local v37 = p28.i[v33];
        local v38 = p27.o[v33];
        local v39 = p28.o[v33];
        v30[v33] = { v34[1] + (v35[1] - v34[1]) * p29, v34[2] + (v35[2] - v34[2]) * p29 };
        v31[v33] = { v36[1] + (v37[1] - v36[1]) * p29, v36[2] + (v37[2] - v36[2]) * p29 };
        v32[v33] = { v38[1] + (v39[1] - v38[1]) * p29, v38[2] + (v39[2] - v38[2]) * p29 };
    end;
    return {
        v = v30,
        i = v31,
        o = v32,
        c = p27.c
    };
end;
local function u47(p41, p42) --[[ Line: 107 ]]
    local v43 = #p41;
    if v43 == 0 then
        return nil, nil, 0;
    end;
    if v43 == 1 then
        return p41[1], nil, 0;
    end;
    local v44 = p41[1];
    if p42 <= v44.t then
        return v44, nil, 0;
    end;
    for v45 = 2, v43 do
        local v46 = p41[v45];
        if p42 < v46.t then
            return p41[v45 - 1], v46, v45 - 1;
        end;
    end;
    return p41[v43], nil, v43;
end;
local function u58(p48, p49) --[[ Line: 139 ]]
    -- upvalues: u47 (copy), u20 (copy), u26 (copy), u40 (copy)
    local l__a__1 = p48.a;
    local l__k__2 = p48.k;
    if l__a__1 == nil or l__a__1 == 0 then
        if type(l__k__2) == "number" then
            return l__k__2;
        elseif type(l__k__2) == "table" then
            if #l__k__2 > 0 and type(l__k__2[1]) == "table" then
                return l__k__2[1];
            else
                return l__k__2;
            end;
        else
            return nil;
        end;
    else
        local v50, v51, _ = u47(l__k__2, p49);
        if v50 == nil then
            return nil;
        elseif v51 == nil then
            local l__s__3 = v50.s;
            if l__s__3 == nil or #l__s__3 == 0 then
                l__s__3 = nil;
            elseif type(l__s__3[1]) == "table" then
                l__s__3 = l__s__3[1];
            end;
            if l__s__3 == nil then
                local l__e__4 = v50.e;
                if l__e__4 == nil then
                    return nil;
                elseif #l__e__4 == 0 then
                    return nil;
                elseif type(l__e__4[1]) == "table" then
                    return l__e__4[1];
                else
                    return l__e__4;
                end;
            else
                return l__s__3;
            end;
        elseif v50.h == 1 then
            local l__s__5 = v50.s;
            if l__s__5 == nil then
                return nil;
            elseif #l__s__5 == 0 then
                return nil;
            elseif type(l__s__5[1]) == "table" then
                return l__s__5[1];
            else
                return l__s__5;
            end;
        else
            local l__t__6 = v50.t;
            local v52 = v51.t - l__t__6;
            if v52 <= 0 then
                local l__s__7 = v50.s;
                if l__s__7 == nil then
                    return nil;
                elseif #l__s__7 == 0 then
                    return nil;
                elseif type(l__s__7[1]) == "table" then
                    return l__s__7[1];
                else
                    return l__s__7;
                end;
            else
                local v53 = math.clamp((p49 - l__t__6) / v52, 0, 1);
                local l__s__8 = v50.s;
                if l__s__8 == nil or #l__s__8 == 0 then
                    l__s__8 = nil;
                elseif type(l__s__8[1]) == "table" then
                    l__s__8 = l__s__8[1];
                end;
                local l__s__9 = v51.s;
                if l__s__9 == nil or #l__s__9 == 0 then
                    l__s__9 = nil;
                elseif type(l__s__9[1]) == "table" then
                    l__s__9 = l__s__9[1];
                end;
                if not l__s__9 then
                    l__s__9 = v50.e;
                    if l__s__9 == nil or #l__s__9 == 0 then
                        l__s__9 = nil;
                    elseif type(l__s__9[1]) == "table" then
                        l__s__9 = l__s__9[1];
                    end;
                end;
                if l__s__8 == nil or l__s__9 == nil then
                    return l__s__8 or l__s__9;
                else
                    local l__o__10 = v50.o;
                    local l__i__11 = v50.i;
                    if l__o__10 and l__i__11 then
                        local v54 = u20;
                        local l__x__12 = l__o__10.x;
                        local v55 = type(l__x__12) ~= "number" and (l__x__12[1] or 0) or l__x__12;
                        local l__y__13 = l__o__10.y;
                        local v56 = type(l__y__13) ~= "number" and (l__y__13[1] or 0) or l__y__13;
                        local l__x__14 = l__i__11.x;
                        local v57 = type(l__x__14) ~= "number" and (l__x__14[1] or 0) or l__x__14;
                        local l__y__15 = l__i__11.y;
                        v53 = v54(v55, v56, v57, type(l__y__15) ~= "number" and (l__y__15[1] or 0) or l__y__15, v53);
                    end;
                    if type(l__s__8) == "number" then
                        return l__s__8 + (l__s__9 - l__s__8) * v53;
                    elseif type(l__s__8) == "table" then
                        if #l__s__8 > 0 and type(l__s__8[1]) == "number" then
                            return u26(l__s__8, l__s__9, v53);
                        else
                            return u40(l__s__8, l__s__9, v53);
                        end;
                    else
                        return l__s__8;
                    end;
                end;
            end;
        end;
    end;
end;
return table.freeze({
    SolveCubicBezier = u20,
    Evaluate = u58,
    EvaluateScalar = function(p59, p60) --[[ Name: EvaluateScalar, Line 212 ]]
        -- upvalues: u58 (copy)
        if p59 == nil then
            return p60;
        else
            local v61 = u58(p59, 0);
            if v61 == nil then
                return p60;
            elseif type(v61) == "number" then
                return v61;
            elseif type(v61) == "table" then
                return v61[1] or p60;
            else
                return p60;
            end;
        end;
    end,
    EvaluateScalarAtFrame = function(p62, p63, p64) --[[ Name: EvaluateScalarAtFrame, Line 221 ]]
        -- upvalues: u58 (copy)
        if p62 == nil then
            return p64;
        else
            local v65 = u58(p62, p63);
            if v65 == nil then
                return p64;
            elseif type(v65) == "number" then
                return v65;
            elseif type(v65) == "table" then
                return v65[1] or p64;
            else
                return p64;
            end;
        end;
    end,
    EvaluateVector = function(p66, p67, p68) --[[ Name: EvaluateVector, Line 230 ]]
        -- upvalues: u58 (copy)
        if p66 == nil then
            return p68;
        else
            local v69 = u58(p66, p67);
            if v69 == nil then
                return p68;
            elseif type(v69) == "table" then
                return v69;
            else
                return type(v69) == "number" and { v69 } or p68;
            end;
        end;
    end,
    EvaluateColor = function(p70, p71) --[[ Name: EvaluateColor, Line 239 ]]
        -- upvalues: u58 (copy)
        if p70 == nil then
            return Color3.new(1, 1, 1);
        else
            local v72 = u58(p70, p71);
            if v72 == nil then
                return Color3.new(1, 1, 1);
            elseif type(v72) == "table" then
                return Color3.new(v72[1] or 1, v72[2] or 1, v72[3] or 1);
            else
                return Color3.new(1, 1, 1);
            end;
        end;
    end,
    EvaluateBezierShape = function(p73, p74) --[[ Name: EvaluateBezierShape, Line 250 ]]
        -- upvalues: u58 (copy)
        if p73 == nil then
            return nil;
        else
            local v75 = u58(p73, p74);
            if v75 == nil then
                return nil;
            elseif type(v75) == "table" and (#v75 > 0 and type(v75[1]) ~= "number") then
                return v75;
            else
                return nil;
            end;
        end;
    end,
    LerpArray = u26
});