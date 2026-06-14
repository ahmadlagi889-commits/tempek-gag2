-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = table.freeze({
    __index = v1
});
function v1.Insert(p3, p4, p5) --[[ Line: 68 ]]
    local v6 = typeof(p4) == "Vector3";
    assert(v6);
    local l__Epsilon__1 = p3.Epsilon;
    local v7 = p4.X // l__Epsilon__1;
    local v8 = p4.Y // l__Epsilon__1;
    local v9 = p4.Z // l__Epsilon__1;
    local v10 = (bit32.band(v7, 262143) * 262144 + bit32.band(v9, 262143)) * 131072 + bit32.band(v8, 131071);
    local v11 = {
        Pos = p4,
        Value = p5
    };
    local l__Table__2 = p3.Table;
    if not l__Table__2[v10] then
        l__Table__2[v10] = {};
    end;
    table.insert(l__Table__2[v10], v11);
end;
function v1.Remove(p12, p13, p14) --[[ Line: 80 ]]
    local v15 = typeof(p13) == "Vector3";
    assert(v15);
    local l__Epsilon__3 = p12.Epsilon;
    local v16 = p13.X // l__Epsilon__3;
    local v17 = p13.Y // l__Epsilon__3;
    local v18 = p13.Z // l__Epsilon__3;
    local v19 = (bit32.band(v16, 262143) * 262144 + bit32.band(v18, 262143)) * 131072 + bit32.band(v17, 131071);
    local v20 = p12.Table[v19];
    if v20 then
        for v21 = #v20, 1, -1 do
            if v20[v21].Value == p14 then
                table.remove(v20, v21);
            end;
        end;
        if #v20 == 0 then
            p12.Table[v19] = nil;
        end;
    end;
end;
function v1.Collect(p22, p23, p24) --[[ Line: 99 ]]
    local v25 = typeof(p23) == "Vector3";
    assert(v25);
    local v26;
    if p24 == nil then
        v26 = true;
    elseif type(p24) == "number" and p24 > 0 then
        v26 = math.floor(p24) == p24;
    else
        v26 = false;
    end;
    assert(v26);
    local l__Epsilon__4 = p22.Epsilon;
    local v27 = p23.X // l__Epsilon__4;
    local v28 = p23.Y // l__Epsilon__4;
    local v29 = p23.Z // l__Epsilon__4;
    local l__Table__5 = p22.Table;
    local v30 = p24 or 1;
    local v31 = 0;
    local v32 = {};
    for v33 = -v30, v30 do
        for v34 = -v30, v30 do
            for v35 = -v30, v30 do
                local v36 = v27 + v33;
                local v37 = v28 + v34;
                local v38 = v29 + v35;
                local v39 = l__Table__5[(bit32.band(v36, 262143) * 262144 + bit32.band(v38, 262143)) * 131072 + bit32.band(v37, 131071)];
                if v39 then
                    for _, v40 in ipairs(v39) do
                        v31 = v31 + 1;
                        v32[v31] = v40.Value;
                    end;
                end;
            end;
        end;
    end;
    v32.n = v31;
    return v32;
end;
function v1.Query(p41, p42, p43) --[[ Line: 128 ]]
    local v44 = typeof(p42) == "Vector3";
    assert(v44);
    local v45;
    if p43 == nil then
        v45 = true;
    elseif type(p43) == "number" and p43 > 0 then
        v45 = math.floor(p43) == p43;
    else
        v45 = false;
    end;
    assert(v45);
    local l__Epsilon__6 = p41.Epsilon;
    local v46 = p42.X // l__Epsilon__6;
    local v47 = p42.Y // l__Epsilon__6;
    local v48 = p42.Z // l__Epsilon__6;
    local l__Table__7 = p41.Table;
    local v49 = p43 or 1;
    local v50 = nil;
    local v51 = nil;
    for v52 = -v49, v49 do
        for v53 = -v49, v49 do
            for v54 = -v49, v49 do
                local v55 = v46 + v52;
                local v56 = v47 + v53;
                local v57 = v48 + v54;
                local v58 = l__Table__7[(bit32.band(v55, 262143) * 262144 + bit32.band(v57, 262143)) * 131072 + bit32.band(v56, 131071)];
                if v58 then
                    for _, v59 in ipairs(v58) do
                        local l__Magnitude__8 = (v59.Pos - p42).Magnitude;
                        if not v50 or l__Magnitude__8 < v50 then
                            v51 = v59.Value;
                            v50 = l__Magnitude__8;
                        end;
                    end;
                end;
            end;
        end;
    end;
    return v51;
end;
table.freeze(v1);
return table.freeze({
    new = function(p60, _) --[[ Name: new, Line 163 ]]
        -- upvalues: u2 (copy)
        local v61;
        if p60 == nil then
            v61 = true;
        elseif type(p60) == "number" then
            v61 = p60 > 0;
        else
            v61 = false;
        end;
        assert(v61);
        return setmetatable({
            Table = {},
            Epsilon = p60 or 10
        }, u2);
    end
});