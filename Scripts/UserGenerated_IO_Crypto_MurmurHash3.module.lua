-- Decompiled with Potassium's decompiler.

local l__band__1 = bit32.band;
local l__lshift__2 = bit32.lshift;
local l__rshift__3 = bit32.rshift;
local l__lrotate__4 = bit32.lrotate;
local l__bxor__5 = bit32.bxor;
local l__bor__6 = bit32.bor;
local l__len__7 = buffer.len;
local l__readu32__8 = buffer.readu32;
local l__readu8__9 = buffer.readu8;
local l__readu16__10 = buffer.readu16;
local l__fromstring__11 = buffer.fromstring;
function mul32(p1, p2)
    -- upvalues: l__band__1 (copy), l__rshift__3 (copy), l__lshift__2 (copy)
    return l__band__1(p1, 65535) * p2 + l__lshift__2(l__band__1(l__rshift__3(p1, 16) * p2, 65535), 16);
end;
function DigestBufferUnsafe(p3, p4, p5, p6)
    -- upvalues: l__bor__6 (copy), l__readu32__8 (copy), l__lrotate__4 (copy), l__bxor__5 (copy), l__lshift__2 (copy), l__band__1 (copy), l__readu8__9 (copy), l__readu16__10 (copy), l__rshift__3 (copy)
    if p6 == nil then
        p6 = 0;
    else
        local v7 = l__bor__6(p6, 0) == p6;
        assert(v7);
    end;
    local v8 = p4 + p5 - 3;
    while p4 < v8 do
        local v9 = l__readu32__8(p3, p4);
        local v10 = l__lrotate__4(mul32(v9, 3432918353), 15);
        p6 = l__lshift__2(l__lrotate__4(l__bxor__5(p6, (mul32(v10, 461845907))), 13) * 5, 0) + 3864292196;
        p4 = p4 + 4;
    end;
    local v11 = l__band__1(p5, 3);
    if v11 > 0 then
        local v12;
        if v11 == 3 then
            v12 = l__readu8__9(p3, p4) + l__lshift__2(l__readu16__10(p3, p4 + 1), 8);
        elseif v11 == 2 then
            v12 = l__readu16__10(p3, p4);
        else
            v12 = l__readu8__9(p3, p4);
        end;
        local v13 = l__lrotate__4(mul32(v12, 3432918353), 15);
        p6 = l__bxor__5(p6, (mul32(v13, 461845907)));
    end;
    local v14 = l__bxor__5(p6, p5);
    local v15 = l__bxor__5(v14, (l__rshift__3(v14, 16)));
    local v16 = mul32(v15, 2246822507);
    local v17 = l__bxor__5(v16, (l__rshift__3(v16, 13)));
    local v18 = mul32(v17, 3266489909);
    return l__bxor__5(v18, (l__rshift__3(v18, 16)));
end;
function DigestBufferCustom(p19, p20, p21, p22)
    -- upvalues: l__len__7 (copy)
    local v23 = type(p19) == "buffer";
    assert(v23);
    local v24;
    if type(p20) == "number" and p20 >= 0 then
        v24 = p20 <= l__len__7(p19);
    else
        v24 = false;
    end;
    assert(v24);
    local v25;
    if type(p21) == "number" and p21 >= 0 then
        v25 = p21 <= l__len__7(p19) - p20;
    else
        v25 = false;
    end;
    assert(v25);
    return DigestBufferUnsafe(p19, p20, p21, p22);
end;
function DigestBuffer(p26, p27)
    -- upvalues: l__len__7 (copy)
    return DigestBufferUnsafe(p26, 0, l__len__7(p26), p27);
end;
function Digest(p28, p29)
    -- upvalues: l__fromstring__11 (copy), l__len__7 (copy)
    local v30 = l__fromstring__11(p28);
    return DigestBufferUnsafe(v30, 0, l__len__7(v30), p29);
end;
local v31 = {
    DigestBufferCustom = DigestBufferCustom,
    DigestBuffer = DigestBuffer,
    Digest = Digest
};
table.freeze(v31);
return v31;