-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(p1, p2, p3, p4) --[[ Name: read, Line 11 ]]
    local v5 = -1;
    local v6 = -1;
    local v7 = -1;
    local v8 = -1;
    if p3.colorType == 0 then
        assert(p2.length == 2, "invalid tRNS length for color type");
        local l__offset__1 = p2.offset;
        local l__bitDepth__2 = p3.bitDepth;
        local v9 = buffer.readu8(p1, l__offset__1);
        local v10 = bit32.lshift(v9, 8);
        local v11 = buffer.readu8(p1, l__offset__1 + 1);
        local v12 = bit32.bor(v10, v11);
        v5 = bit32.extract(v12, 0, l__bitDepth__2);
    elseif p3.colorType == 2 then
        assert(p2.length == 6, "invalid tRNS length for color type");
        local l__offset__3 = p2.offset;
        local l__bitDepth__4 = p3.bitDepth;
        local v13 = buffer.readu8(p1, l__offset__3);
        local v14 = bit32.lshift(v13, 8);
        local v15 = buffer.readu8(p1, l__offset__3 + 1);
        local v16 = bit32.bor(v14, v15);
        v6 = bit32.extract(v16, 0, l__bitDepth__4);
        local v17 = p2.offset + 2;
        local l__bitDepth__5 = p3.bitDepth;
        local v18 = buffer.readu8(p1, v17);
        local v19 = bit32.lshift(v18, 8);
        local v20 = buffer.readu8(p1, v17 + 1);
        local v21 = bit32.bor(v19, v20);
        v7 = bit32.extract(v21, 0, l__bitDepth__5);
        local v22 = p2.offset + 4;
        local l__bitDepth__6 = p3.bitDepth;
        local v23 = buffer.readu8(p1, v22);
        local v24 = bit32.lshift(v23, 8);
        local v25 = buffer.readu8(p1, v22 + 1);
        local v26 = bit32.bor(v24, v25);
        v8 = bit32.extract(v26, 0, l__bitDepth__6);
    else
        local l__length__7 = p2.length;
        assert(p4, "tRNS requires PLTE for color type");
        assert(l__length__7 <= #p4.colors, "tRNS specified too many PLTE alphas");
        for v27 = 1, l__length__7 do
            p4.colors[v27].a = buffer.readu8(p1, p2.offset + v27 - 1);
        end;
    end;
    return {
        gray = v5,
        red = v6,
        green = v7,
        blue = v8
    };
end;