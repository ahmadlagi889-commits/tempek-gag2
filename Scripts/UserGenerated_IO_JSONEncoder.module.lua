-- Decompiled with Potassium's decompiler.

local u1 = {
    [36] = true,
    [95] = true
};
local u2 = {
    [36] = true,
    [95] = true
};
local u3 = {
    [0] = -12336,
    [1] = -12592,
    [2] = -12848,
    [3] = -13104,
    [4] = -13360,
    [5] = -13616,
    [6] = -13872,
    [7] = -14128,
    [8] = 25180,
    [9] = 29788,
    [10] = 28252,
    [11] = -25136,
    [12] = 26204,
    [13] = 29276,
    [14] = -25904,
    [15] = -26160,
    [16] = -12337,
    [17] = -12593,
    [18] = -12849,
    [19] = -13105,
    [20] = -13361,
    [21] = -13617,
    [22] = -13873,
    [23] = -14129,
    [24] = -14385,
    [25] = -14641,
    [26] = -24881,
    [27] = -25137,
    [28] = -25393,
    [29] = -25649,
    [30] = -25905,
    [31] = -26161
};
for v4 = 65, 90 do
    u1[v4] = true;
    u2[v4] = true;
end;
for v5 = 97, 122 do
    u1[v5] = true;
    u2[v5] = true;
end;
u2[48] = true;
u2[49] = true;
u2[50] = true;
u2[51] = true;
u2[52] = true;
u2[53] = true;
u2[54] = true;
u2[55] = true;
u2[56] = true;
u2[57] = true;
local function v7(p6) --[[ Line: 91 ]]
    return {
        Pos = 0,
        Indent = 0,
        Pretty = false,
        Null = nil,
        QuoteChar = 34,
        UnquoteIdent = false,
        Buf = p6,
        Cap = buffer.len(p6),
        Encoders = {}
    };
end;
local function u9(p8) --[[ Line: 105 ]]
    return buffer.readstring(p8.Buf, 0, p8.Pos);
end;
local function u17(p10, p11) --[[ Line: 115 ]]
    local l__Pos__1 = p10.Pos;
    local v12 = l__Pos__1 + p11;
    if p10.Cap < v12 then
        local v13 = math.log(v12, 2);
        local v14 = 2 ^ math.ceil(v13);
        local v15 = math.max(v12, v14);
        local v16 = buffer.create(v15);
        buffer.copy(v16, 0, p10.Buf, 0, l__Pos__1);
        p10.Buf = v16;
        p10.Cap = v15;
    end;
    p10.Pos = v12;
    return l__Pos__1;
end;
local function u27(p18, p19) --[[ Line: 180 ]]
    -- upvalues: u17 (copy)
    if p19 == p19 then
        if p19 == (1 / 0) then
            local v20 = u17(p18, 8);
            local l__Buf__2 = p18.Buf;
            buffer.writeu32(l__Buf__2, v20, 1768320585);
            buffer.writeu32(l__Buf__2, v20 + 4, 2037672302);
        elseif p19 == (-1 / 0) then
            local v21 = u17(p18, 9);
            local l__Buf__3 = p18.Buf;
            buffer.writeu8(l__Buf__3, v21, 45);
            buffer.writeu32(l__Buf__3, v21 + 1, 1768320585);
            buffer.writeu32(l__Buf__3, v21 + 5, 2037672302);
        else
            local v22 = tostring(p19);
            local v23 = string.find(v22, "e%+");
            if v23 then
                v22 = string.sub(v22, 1, v23) .. string.sub(v22, v23 + 2);
            end;
            local v24 = string.len(v22);
            local v25 = u17(p18, v24);
            buffer.writestring(p18.Buf, v25, v22, v24);
        end;
    else
        local v26 = u17(p18, 3);
        local l__Buf__4 = p18.Buf;
        buffer.writeu16(l__Buf__4, v26, 24910);
        buffer.writeu8(l__Buf__4, v26 + 2, 78);
    end;
end;
local function u41(p28, p29, p30) --[[ Line: 228 ]]
    -- upvalues: u1 (copy), u2 (copy), u17 (copy), u3 (copy)
    if p30 then
        local v31 = string.len(p29);
        local v32;
        if v31 ~= 0 and u1[string.byte(p29, 1)] then
            local v33 = u2;
            for v34 = 2, v31 do
                if not v33[string.byte(p29, v34)] then
                    v32 = false;
                    if not v32 then
                        p30 = false;
                    end;
                end;
            end;
            v32 = true;
            if not v32 then
                p30 = false;
            end;
        end;
        v32 = false;
        if not v32 then
            p30 = false;
        end;
    end;
    local v35 = string.len(p29);
    local v36 = u17(p28, v35 * 6 + 2);
    local l__Buf__5 = p28.Buf;
    local l__QuoteChar__6 = p28.QuoteChar;
    if not p30 then
        buffer.writeu8(l__Buf__5, v36, l__QuoteChar__6);
        v36 = v36 + 1;
    end;
    for v37 = 1, v35 do
        local v38 = string.byte(p29, v37);
        if v38 > 31 then
            if v38 == l__QuoteChar__6 or v38 == 92 then
                local v39 = bit32.lshift(v38, 8) + 92;
                buffer.writeu16(l__Buf__5, v36, v39);
                v36 = v36 + 2;
            else
                buffer.writeu8(l__Buf__5, v36, v38);
                v36 = v36 + 1;
            end;
        else
            local v40 = u3[v38];
            if v40 < 0 then
                v40 = -v40;
                buffer.writeu32(l__Buf__5, v36, 808482140);
                v36 = v36 + 4;
            end;
            buffer.writeu16(l__Buf__5, v36, v40);
            v36 = v36 + 2;
        end;
    end;
    if not p30 then
        buffer.writeu8(l__Buf__5, v36, l__QuoteChar__6);
        v36 = v36 + 1;
    end;
    p28.Pos = v36;
end;
local function u58(p42, p43) --[[ Line: 323 ]]
    -- upvalues: u17 (copy)
    local l__Pretty__7 = p42.Pretty;
    local v44 = u17(p42, 1);
    buffer.writeu8(p42.Buf, v44, 91);
    if l__Pretty__7 then
        p42.Indent = p42.Indent + 1;
    end;
    for v45, v52 in ipairs(p43) do
        if v45 > 1 then
            local v47 = u17(p42, 1);
            buffer.writeu8(p42.Buf, v47, 44);
        end;
        if l__Pretty__7 then
            local v48 = u17(p42, 1);
            buffer.writeu8(p42.Buf, v48, 10);
            local v49 = p42.Indent * 2;
            local v50 = u17(p42, v49);
            local l__Buf__8 = p42.Buf;
            for v51 = 0, v49 - 1 do
                buffer.writeu16(l__Buf__8, v50 + v51 * 2, 8224);
            end;
        end;
        if v52 == p42.Null then
            local v52 = nil;
        end;
        p42.Encoders[typeof(v52)](p42, v52);
    end;
    if l__Pretty__7 then
        p42.Indent = p42.Indent + -1;
        if #p43 > 0 then
            local v53 = u17(p42, 1);
            buffer.writeu8(p42.Buf, v53, 10);
            local v54 = p42.Indent * 2;
            local v55 = u17(p42, v54);
            local l__Buf__9 = p42.Buf;
            for v56 = 0, v54 - 1 do
                buffer.writeu16(l__Buf__9, v55 + v56 * 2, 8224);
            end;
        end;
    end;
    local v57 = u17(p42, 1);
    buffer.writeu8(p42.Buf, v57, 93);
end;
local function u80(p59, p60) --[[ Line: 350 ]]
    -- upvalues: u17 (copy), u41 (copy)
    local v61 = {};
    for v62, _ in pairs(p60) do
        local v63 = type(v62) == "string";
        assert(v63);
        table.insert(v61, v62);
    end;
    table.sort(v61);
    local l__Pretty__10 = p59.Pretty;
    local l__UnquoteIdent__11 = p59.UnquoteIdent;
    local v64 = u17(p59, 1);
    buffer.writeu8(p59.Buf, v64, 123);
    if l__Pretty__10 then
        p59.Indent = p59.Indent + 1;
    end;
    for v65, v66 in ipairs(v61) do
        if v65 > 1 then
            local v67 = u17(p59, 1);
            buffer.writeu8(p59.Buf, v67, 44);
        end;
        if l__Pretty__10 then
            local v68 = u17(p59, 1);
            buffer.writeu8(p59.Buf, v68, 10);
            local v69 = p59.Indent * 2;
            local v70 = u17(p59, v69);
            local l__Buf__12 = p59.Buf;
            for v71 = 0, v69 - 1 do
                buffer.writeu16(l__Buf__12, v70 + v71 * 2, 8224);
            end;
        end;
        u41(p59, v66, l__UnquoteIdent__11);
        if l__Pretty__10 then
            local v72 = u17(p59, 2);
            buffer.writeu16(p59.Buf, v72, 8250);
        else
            local v73 = u17(p59, 1);
            buffer.writeu8(p59.Buf, v73, 58);
        end;
        local v74 = p60[v66];
        if v74 == p59.Null then
            v74 = nil;
        end;
        p59.Encoders[typeof(v74)](p59, v74);
    end;
    if l__Pretty__10 then
        p59.Indent = p59.Indent + -1;
        if #v61 > 0 then
            local v75 = u17(p59, 1);
            buffer.writeu8(p59.Buf, v75, 10);
            local v76 = p59.Indent * 2;
            local v77 = u17(p59, v76);
            local l__Buf__13 = p59.Buf;
            for v78 = 0, v76 - 1 do
                buffer.writeu16(l__Buf__13, v77 + v78 * 2, 8224);
            end;
        end;
    end;
    local v79 = u17(p59, 1);
    buffer.writeu8(p59.Buf, v79, 125);
end;
local v98 = {
    ["nil"] = function(p81, _) --[[ Name: EncodeNull, Line 165 ]]
        -- upvalues: u17 (copy)
        local v82 = u17(p81, 4);
        buffer.writeu32(p81.Buf, v82, 1819047278);
    end,
    boolean = function(p83, p84) --[[ Name: EncodeBoolean, Line 169 ]]
        -- upvalues: u17 (copy)
        if p84 then
            local v85 = u17(p83, 4);
            buffer.writeu32(p83.Buf, v85, 1702195828);
        else
            local v86 = u17(p83, 5);
            local l__Buf__14 = p83.Buf;
            buffer.writeu32(l__Buf__14, v86, 1936482662);
            buffer.writeu8(l__Buf__14, v86 + 4, 101);
        end;
    end,
    number = u27,
    string = u41,
    buffer = function(p87, p88) --[[ Name: EncodeBuffer, Line 278 ]]
        -- upvalues: u17 (copy), u3 (copy)
        local v89 = buffer.len(p88);
        local v90 = u17(p87, 2 + v89 * 6);
        local l__Buf__15 = p87.Buf;
        local l__QuoteChar__16 = p87.QuoteChar;
        buffer.writeu8(l__Buf__15, v90, l__QuoteChar__16);
        local v91 = v90 + 1;
        for v92 = 0, v89 - 1 do
            local v93 = buffer.readu8(p88, v92);
            if v93 > 31 then
                if v93 == l__QuoteChar__16 or v93 == 92 then
                    local v94 = bit32.lshift(v93, 8) + 92;
                    buffer.writeu16(l__Buf__15, v91, v94);
                    v91 = v91 + 2;
                else
                    buffer.writeu8(l__Buf__15, v91, v93);
                    v91 = v91 + 1;
                end;
            else
                local v95 = u3[v93];
                if v95 < 0 then
                    v95 = -v95;
                    buffer.writeu32(l__Buf__15, v91, 808482140);
                    v91 = v91 + 4;
                end;
                buffer.writeu16(l__Buf__15, v91, v95);
                v91 = v91 + 2;
            end;
        end;
        buffer.writeu8(l__Buf__15, v91, l__QuoteChar__16);
        p87.Pos = v91 + 1;
    end,
    table = function(p96, p97) --[[ Name: EncodeTable, Line 389 ]]
        -- upvalues: u58 (copy), u80 (copy)
        if #p97 > 0 or next(p97) == nil then
            u58(p96, p97);
        else
            u80(p96, p97);
        end;
    end
};
local v99 = table.clone(v98);
function v99.Vector2(p100, p101) --[[ Line: 398 ]]
    -- upvalues: u58 (copy)
    u58(p100, { p101.X, p101.Y });
end;
function v99.Vector3(p102, p103) --[[ Line: 402 ]]
    -- upvalues: u58 (copy)
    u58(p102, { p103.X, p103.Y, p103.Z });
end;
function v99.Vector2int16(p104, p105) --[[ Line: 406 ]]
    -- upvalues: u58 (copy)
    u58(p104, { p105.X, p105.Y });
end;
function v99.Vector3int16(p106, p107) --[[ Line: 410 ]]
    -- upvalues: u58 (copy)
    u58(p106, { p107.X, p107.Y, p107.Z });
end;
function v99.Region3(p108, p109) --[[ Line: 414 ]]
    -- upvalues: u58 (copy)
    local v110 = p109.CFrame * (p109.Size * -0.5);
    local v111 = p109.CFrame * (p109.Size * 0.5);
    u58(p108, {
        v110.X,
        v110.Y,
        v110.Z,
        v111.X,
        v111.Y,
        v111.Z
    });
end;
function v99.Region3int16(p112, p113) --[[ Line: 420 ]]
    -- upvalues: u58 (copy)
    u58(p112, {
        p113.Min.X,
        p113.Min.Y,
        p113.Min.Z,
        p113.Max.X,
        p113.Max.Y,
        p113.Max.Z
    });
end;
function v99.UDim(p114, p115) --[[ Line: 424 ]]
    -- upvalues: u58 (copy)
    u58(p114, { p115.Scale, p115.Offset });
end;
function v99.UDim2(p116, p117) --[[ Line: 428 ]]
    -- upvalues: u58 (copy)
    u58(p116, {
        p117.X.Scale,
        p117.X.Offset,
        p117.Y.Scale,
        p117.Y.Offset
    });
end;
function v99.CFrame(p118, p119) --[[ Line: 432 ]]
    -- upvalues: u58 (copy)
    u58(p118, { p119:GetComponents() });
end;
function v99.Color3(p120, p121) --[[ Line: 436 ]]
    -- upvalues: u58 (copy)
    u58(p120, { math.round(p121.R * 255), math.round(p121.G * 255), (math.round(p121.B * 255)) });
end;
function v99.NumberRange(p122, p123) --[[ Line: 444 ]]
    -- upvalues: u58 (copy)
    u58(p122, { p123.Min, p123.Max });
end;
function v99.Rect(p124, p125) --[[ Line: 448 ]]
    -- upvalues: u58 (copy)
    u58(p124, {
        p125.Min.X,
        p125.Min.Y,
        p125.Max.X,
        p125.Max.Y
    });
end;
function v99.EnumItem(p126, p127) --[[ Line: 452 ]]
    -- upvalues: u27 (copy)
    u27(p126, p127.Value);
end;
local v128 = buffer.create(4096);
local u129 = v7(v128);
u129.Encoders = v98;
local u130 = v7(v128);
u130.Encoders = v98;
u130.Pretty = true;
local u131 = v7(v128);
u131.Encoders = v99;
local u132 = v7(v128);
u132.Encoders = v99;
u132.Pretty = true;
local u133 = v7(v128);
u133.Encoders = v98;
u133.UnquoteIdent = true;
u133.QuoteChar = 39;
local u134 = v7(v128);
u134.Encoders = v98;
u134.Pretty = true;
u134.UnquoteIdent = true;
u134.QuoteChar = 39;
return table.freeze({
    Compact = function(p135, p136) --[[ Name: Compact, Line 485 ]]
        -- upvalues: u129 (copy), u9 (copy)
        local v137 = u129;
        v137.Pos = 0;
        v137.Null = p136;
        if p135 == v137.Null then
            p135 = nil;
        end;
        v137.Encoders[typeof(p135)](v137, p135);
        return u9(v137);
    end,
    Pretty = function(p138, p139) --[[ Name: Pretty, Line 496 ]]
        -- upvalues: u130 (copy), u9 (copy)
        local v140 = u130;
        v140.Pos = 0;
        v140.Indent = 0;
        v140.Null = p139;
        if p138 == v140.Null then
            p138 = nil;
        end;
        v140.Encoders[typeof(p138)](v140, p138);
        return u9(v140);
    end,
    CompactExt = function(p141, p142) --[[ Name: CompactExt, Line 507 ]]
        -- upvalues: u131 (copy), u9 (copy)
        local v143 = u131;
        v143.Pos = 0;
        v143.Null = p142;
        if p141 == v143.Null then
            p141 = nil;
        end;
        v143.Encoders[typeof(p141)](v143, p141);
        return u9(v143);
    end,
    PrettyExt = function(p144, p145) --[[ Name: PrettyExt, Line 518 ]]
        -- upvalues: u132 (copy), u9 (copy)
        local v146 = u132;
        v146.Pos = 0;
        v146.Indent = 0;
        v146.Null = p145;
        if p144 == v146.Null then
            p144 = nil;
        end;
        v146.Encoders[typeof(p144)](v146, p144);
        return u9(v146);
    end,
    Compact5 = function(p147, p148) --[[ Name: Compact5, Line 532 ]]
        -- upvalues: u133 (copy), u9 (copy)
        local v149 = u133;
        v149.Pos = 0;
        v149.Null = p148;
        if p147 == v149.Null then
            p147 = nil;
        end;
        v149.Encoders[typeof(p147)](v149, p147);
        return u9(v149);
    end,
    Pretty5 = function(p150, p151) --[[ Name: Pretty5, Line 545 ]]
        -- upvalues: u134 (copy), u9 (copy)
        local v152 = u134;
        v152.Pos = 0;
        v152.Indent = 0;
        v152.Null = p151;
        if p150 == v152.Null then
            p150 = nil;
        end;
        v152.Encoders[typeof(p150)](v152, p150);
        return u9(v152);
    end
});