-- Decompiled with Potassium's decompiler.

local l__copy__1 = buffer.copy;
local l__create__2 = buffer.create;
local l__fill__3 = buffer.fill;
local l__len__4 = buffer.len;
local l__readu8__5 = buffer.readu8;
local l__writeu8__6 = buffer.writeu8;
local l__random__7 = math.random;
local v1 = {};
local function v3(p2) --[[ Line: 25 ]]
    return p2;
end;
v1.None = table.freeze({
    Overwrite = false,
    Pad = v3,
    Unpad = v3
});
local function u13(p4, p5, p6) --[[ Line: 38 ]]
    -- upvalues: l__len__4 (copy), l__copy__1 (copy), l__fill__3 (copy), l__writeu8__6 (copy), l__create__2 (copy)
    local v7 = l__len__4(p4);
    local v8 = v7 - v7 % p6;
    if not p5 then
        local v9 = v8 + p6;
        local v10 = l__create__2(v9);
        l__copy__1(v10, 0, p4, 0, v7);
        l__writeu8__6(v10, v9 - 1, p6 - v7 % p6);
        return v10;
    end;
    local v11 = l__len__4(p5) >= v7 + p6;
    assert(v11, "Output buffer out of bounds");
    local v12 = p6 - v7 % p6;
    l__copy__1(p5, 0, p4, 0, v7);
    l__fill__3(p5, v7, 0, v12 - 1);
    l__writeu8__6(p5, v8 + p6 - 1, v12);
    return p5;
end;
local function u21(p14, p15, p16) --[[ Line: 78 ]]
    -- upvalues: l__len__4 (copy), l__create__2 (copy), l__copy__1 (copy), l__random__7 (copy), l__writeu8__6 (copy)
    local v17 = l__len__4(p14);
    local v18 = v17 - v17 % p16;
    if p15 then
        local v19 = l__len__4(p15) >= v17 + p16;
        assert(v19, "Output buffer out of bounds");
    else
        p15 = l__create__2(v18 + p16);
    end;
    l__copy__1(p15, 0, p14, 0, v17);
    for v20 = v17, v18 + p16 - 2 do
        l__writeu8__6(p15, v20, (l__random__7(0, 255)));
    end;
    l__writeu8__6(p15, v18 + p16 - 1, p16 - v17 % p16);
    return p15;
end;
local function u30(p22, p23, p24) --[[ Line: 93 ]]
    -- upvalues: l__len__4 (copy), l__readu8__5 (copy), l__create__2 (copy), l__copy__1 (copy)
    local v25 = l__len__4(p22);
    local v26 = l__readu8__5(p22, v25 - 1);
    local v27 = v25 - v26;
    local v28;
    if v26 > 0 then
        v28 = v26 <= p24;
    else
        v28 = false;
    end;
    assert(v28, "Got unexpected padding");
    if p23 then
        local v29 = v27 <= l__len__4(p23);
        assert(v29, "Output buffer out of bounds");
    else
        p23 = l__create__2(v27);
    end;
    l__copy__1(p23, 0, p22, 0, v27);
    return p23;
end;
local function u38(p31, p32, p33) --[[ Line: 110 ]]
    -- upvalues: l__len__4 (copy), l__create__2 (copy), l__copy__1 (copy), l__fill__3 (copy)
    local v34 = l__len__4(p31);
    local v35 = v34 - v34 % p33;
    if p32 then
        local v36 = l__len__4(p32) >= v34 + p33;
        assert(v36, "Output buffer out of bounds");
    else
        p32 = l__create__2(v35 + p33);
    end;
    local v37 = p33 - v34 % p33;
    l__copy__1(p32, 0, p31, 0, v34);
    l__fill__3(p32, v34, v37, v37);
    return p32;
end;
local function u48(p39, p40, p41) --[[ Line: 123 ]]
    -- upvalues: l__len__4 (copy), l__readu8__5 (copy), l__create__2 (copy), l__copy__1 (copy)
    local v42 = l__len__4(p39);
    local v43 = l__readu8__5(p39, v42 - 1);
    local v44 = v42 - v43;
    local v45;
    if v43 > 0 then
        v45 = v43 <= p41;
    else
        v45 = false;
    end;
    assert(v45, "Got unexpected padding");
    for v46 = v44, v42 - 2 do
        if l__readu8__5(p39, v46) ~= v43 then
            error("Got unexpected padding");
        end;
    end;
    if p40 then
        local v47 = v44 <= l__len__4(p40);
        assert(v47, "Output buffer out of bounds");
    else
        p40 = l__create__2(v44);
    end;
    l__copy__1(p40, 0, p39, 0, v44);
    return p40;
end;
local function u54(p49, p50, p51) --[[ Line: 145 ]]
    -- upvalues: l__len__4 (copy), l__fill__3 (copy), l__create__2 (copy), l__copy__1 (copy), l__writeu8__6 (copy)
    local v52 = l__len__4(p49);
    if p50 then
        local v53 = l__len__4(p50) >= v52 + p51;
        assert(v53, "Output buffer out of bounds");
        l__fill__3(p50, v52 + 1, 0, p51 - v52 % p51 - 1);
    else
        p50 = l__create__2(v52 + p51 - v52 % p51);
    end;
    l__copy__1(p50, 0, p49, 0, v52);
    l__writeu8__6(p50, v52, 128);
    return p50;
end;
local function u62(p55, p56, p57) --[[ Line: 157 ]]
    -- upvalues: l__len__4 (copy), l__readu8__5 (copy), l__create__2 (copy), l__copy__1 (copy)
    local v58 = l__len__4(p55) - 1;
    for v59 = v58, v58 - p57, -1 do
        local v60 = l__readu8__5(p55, v59);
        if v60 == 128 then
            if p56 then
                local v61 = v59 <= l__len__4(p56);
                assert(v61, "Output buffer out of bounds");
            else
                p56 = l__create__2(v59);
            end;
            l__copy__1(p56, 0, p55, 0, v59);
            return p56;
        end;
        assert(v60 == 0, "Got unexpected padding");
    end;
    error("Got unexpected padding");
    return l__create__2(0);
end;
local function u68(p63, p64, p65) --[[ Line: 181 ]]
    -- upvalues: l__len__4 (copy), l__fill__3 (copy), l__create__2 (copy), l__copy__1 (copy)
    local v66 = l__len__4(p63);
    if p64 then
        local v67 = l__len__4(p64) >= v66 + p65;
        assert(v67, "Output buffer out of bounds");
        l__fill__3(p64, v66, 0, p65 - v66 % p65);
    else
        p64 = l__create__2(v66 + p65 - v66 % p65);
    end;
    l__copy__1(p64, 0, p63, 0, v66);
    return p64;
end;
local function u76(p69, p70, p71) --[[ Line: 192 ]]
    -- upvalues: l__len__4 (copy), l__readu8__5 (copy), l__create__2 (copy), l__copy__1 (copy)
    local v72 = l__len__4(p69) - 1;
    for v73 = v72, v72 - p71, -1 do
        if l__readu8__5(p69, v73) == 0 then
            local v74 = v73 + 1;
            if p70 then
                local v75 = v74 <= l__len__4(p70);
                assert(v75, "Output buffer out of bounds");
            else
                p70 = l__create__2(v74);
            end;
            l__copy__1(p70, 0, p69, 0, v74);
            return p70;
        end;
    end;
    l__copy__1(p70, 0, p69, 0, v72 - p71 - 1);
    return p70;
end;
local v78 = {
    __index = function(_, p77) --[[ Name: __index, Line 213 ]]
        -- upvalues: u13 (copy), u21 (copy), u30 (copy), u38 (copy), u48 (copy), u54 (copy), u62 (copy), u68 (copy), u76 (copy)
        return p77 == "AnsiX923" and {
            Overwrite = nil,
            Pad = u13,
            Unpad = u13
        } or (p77 == "Iso10126" and {
            Overwrite = nil,
            Pad = u21,
            Unpad = u30
        } or (p77 == "Pkcs7" and {
            Overwrite = nil,
            Pad = u38,
            Unpad = u48
        } or (p77 == "Iso7816_4" and {
            Overwrite = nil,
            Pad = u54,
            Unpad = u62
        } or (p77 == "Zero" and {
            Overwrite = nil,
            Pad = u68,
            Unpad = u76
        } or nil))));
    end,
    __newindex = function() --[[ Name: __newindex, Line 231 ]] end
};
setmetatable(v1, v78);
v1.AnsiX923 = {};
v1.Iso10126 = {};
v1.Pkcs7 = {};
v1.Iso7816_4 = {};
v1.Zero = {};
table.freeze(v1);
v78.__metatable = "This metatable is locked";
return v1;