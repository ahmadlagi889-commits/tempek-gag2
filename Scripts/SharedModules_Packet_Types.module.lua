-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local v7 = {};
local v8 = {};
local v9 = {};
local u10 = {};
local u11 = {};
local function u16() --[[ Line: 85 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v12 = u4 * 8;
    u4 = u4 + 2;
    local v13 = buffer.readbits(u2, v12 + 0, 10);
    local v14 = buffer.readbits(u2, v12 + 10, 5);
    local v15 = buffer.readbits(u2, v12 + 15, 1);
    if v13 == 0 then
        if v14 == 0 then
            return 0;
        end;
        if v14 == 31 then
            return v15 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif v14 == 31 then
        return (0 / 0);
    end;
    if v15 == 0 then
        return (v13 / 1024 + 1) * 2 ^ (v14 - 15);
    else
        return -(v13 / 1024 + 1) * 2 ^ (v14 - 15);
    end;
end;
local function u22(p17) --[[ Line: 101 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v18 = u4 * 8;
    u4 = u4 + 2;
    if p17 == 0 then
        buffer.writebits(u2, v18, 16, 0);
    elseif p17 >= 65520 then
        buffer.writebits(u2, v18, 16, 31744);
    elseif p17 <= -65520 then
        buffer.writebits(u2, v18, 16, 64512);
    elseif p17 == p17 then
        local v19;
        if p17 < 0 then
            p17 = -p17;
            v19 = 1;
        else
            v19 = 0;
        end;
        local v20, v21 = math.frexp(p17);
        buffer.writebits(u2, v18 + 0, 10, v20 * 2048 - 1023.5);
        buffer.writebits(u2, v18 + 10, 5, v21 + 14);
        buffer.writebits(u2, v18 + 15, 1, v19);
    else
        buffer.writebits(u2, v18, 16, 31745);
    end;
end;
local function u27() --[[ Line: 122 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v23 = u4 * 8;
    u4 = u4 + 3;
    local v24 = buffer.readbits(u2, v23 + 0, 17);
    local v25 = buffer.readbits(u2, v23 + 17, 6);
    local v26 = buffer.readbits(u2, v23 + 23, 1);
    if v24 == 0 then
        if v25 == 0 then
            return 0;
        end;
        if v25 == 63 then
            return v26 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif v25 == 63 then
        return (0 / 0);
    end;
    if v26 == 0 then
        return (v24 / 131072 + 1) * 2 ^ (v25 - 31);
    else
        return -(v24 / 131072 + 1) * 2 ^ (v25 - 31);
    end;
end;
local function u33(p28) --[[ Line: 138 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v29 = u4 * 8;
    u4 = u4 + 3;
    if p28 == 0 then
        buffer.writebits(u2, v29, 24, 0);
    elseif p28 >= 4294959104 then
        buffer.writebits(u2, v29, 24, 8257536);
    elseif p28 <= -4294959104 then
        buffer.writebits(u2, v29, 24, 16646144);
    elseif p28 == p28 then
        local v30;
        if p28 < 0 then
            p28 = -p28;
            v30 = 1;
        else
            v30 = 0;
        end;
        local v31, v32 = math.frexp(p28);
        buffer.writebits(u2, v29 + 0, 17, v31 * 262144 - 131071.5);
        buffer.writebits(u2, v29 + 17, 6, v32 + 30);
        buffer.writebits(u2, v29 + 23, 1, v30);
    else
        buffer.writebits(u2, v29, 24, 8257537);
    end;
end;
v7.Any = "Any";
function v8.Any() --[[ Line: 162 ]]
    -- upvalues: u10 (copy), u2 (ref), u4 (ref)
    local v34 = u10;
    local v35 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return v34[v35]();
end;
function v9.Any(p36) --[[ Line: 163 ]]
    -- upvalues: u11 (copy)
    u11[typeof(p36)](p36);
end;
v7.Nil = "Nil";
function v8.Nil() --[[ Line: 166 ]]
    return nil;
end;
function v9.Nil(_) --[[ Line: 167 ]] end;
v7.NumberS8 = "NumberS8";
function v8.NumberS8() --[[ Line: 170 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v37 = buffer.readi8(u2, u4);
    u4 = u4 + 1;
    return v37;
end;
function v9.NumberS8(p38) --[[ Line: 171 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v39 = u4 + 1;
    if u3 < v39 then
        while u3 < v39 do
            u3 = u3 * 2;
        end;
        local v40 = buffer.create(u3);
        buffer.copy(v40, 0, u2, 0, u4);
        u1.Buffer = v40;
        u2 = v40;
    end;
    buffer.writei8(u2, u4, p38);
    u4 = u4 + 1;
end;
v7.NumberS16 = "NumberS16";
function v8.NumberS16() --[[ Line: 174 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v41 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return v41;
end;
function v9.NumberS16(p42) --[[ Line: 175 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v43 = u4 + 2;
    if u3 < v43 then
        while u3 < v43 do
            u3 = u3 * 2;
        end;
        local v44 = buffer.create(u3);
        buffer.copy(v44, 0, u2, 0, u4);
        u1.Buffer = v44;
        u2 = v44;
    end;
    buffer.writei16(u2, u4, p42);
    u4 = u4 + 2;
end;
v7.NumberS24 = "NumberS24";
function v8.NumberS24() --[[ Line: 178 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v45 = buffer.readbits(u2, u4 * 8, 24) - 8388608;
    u4 = u4 + 3;
    return v45;
end;
function v9.NumberS24(p46) --[[ Line: 179 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v47 = u4 + 3;
    if u3 < v47 then
        while u3 < v47 do
            u3 = u3 * 2;
        end;
        local v48 = buffer.create(u3);
        buffer.copy(v48, 0, u2, 0, u4);
        u1.Buffer = v48;
        u2 = v48;
    end;
    buffer.writebits(u2, u4 * 8, 24, p46 + 8388608);
    u4 = u4 + 3;
end;
v7.NumberS32 = "NumberS32";
function v8.NumberS32() --[[ Line: 182 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v49 = buffer.readi32(u2, u4);
    u4 = u4 + 4;
    return v49;
end;
function v9.NumberS32(p50) --[[ Line: 183 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v51 = u4 + 4;
    if u3 < v51 then
        while u3 < v51 do
            u3 = u3 * 2;
        end;
        local v52 = buffer.create(u3);
        buffer.copy(v52, 0, u2, 0, u4);
        u1.Buffer = v52;
        u2 = v52;
    end;
    buffer.writei32(u2, u4, p50);
    u4 = u4 + 4;
end;
v7.NumberU8 = "NumberU8";
function v8.NumberU8() --[[ Line: 186 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v53 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return v53;
end;
function v9.NumberU8(p54) --[[ Line: 187 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v55 = u4 + 1;
    if u3 < v55 then
        while u3 < v55 do
            u3 = u3 * 2;
        end;
        local v56 = buffer.create(u3);
        buffer.copy(v56, 0, u2, 0, u4);
        u1.Buffer = v56;
        u2 = v56;
    end;
    buffer.writeu8(u2, u4, p54);
    u4 = u4 + 1;
end;
v7.NumberU16 = "NumberU16";
function v8.NumberU16() --[[ Line: 190 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v57 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    return v57;
end;
function v9.NumberU16(p58) --[[ Line: 191 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v59 = u4 + 2;
    if u3 < v59 then
        while u3 < v59 do
            u3 = u3 * 2;
        end;
        local v60 = buffer.create(u3);
        buffer.copy(v60, 0, u2, 0, u4);
        u1.Buffer = v60;
        u2 = v60;
    end;
    buffer.writeu16(u2, u4, p58);
    u4 = u4 + 2;
end;
v7.NumberU24 = "NumberU24";
function v8.NumberU24() --[[ Line: 194 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v61 = buffer.readbits(u2, u4 * 8, 24);
    u4 = u4 + 3;
    return v61;
end;
function v9.NumberU24(p62) --[[ Line: 195 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v63 = u4 + 3;
    if u3 < v63 then
        while u3 < v63 do
            u3 = u3 * 2;
        end;
        local v64 = buffer.create(u3);
        buffer.copy(v64, 0, u2, 0, u4);
        u1.Buffer = v64;
        u2 = v64;
    end;
    buffer.writebits(u2, u4 * 8, 24, p62);
    u4 = u4 + 3;
end;
v7.NumberU32 = "NumberU32";
function v8.NumberU32() --[[ Line: 198 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v65 = buffer.readu32(u2, u4);
    u4 = u4 + 4;
    return v65;
end;
function v9.NumberU32(p66) --[[ Line: 199 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v67 = u4 + 4;
    if u3 < v67 then
        while u3 < v67 do
            u3 = u3 * 2;
        end;
        local v68 = buffer.create(u3);
        buffer.copy(v68, 0, u2, 0, u4);
        u1.Buffer = v68;
        u2 = v68;
    end;
    buffer.writeu32(u2, u4, p66);
    u4 = u4 + 4;
end;
v7.NumberF16 = "NumberF16";
function v8.NumberF16() --[[ Line: 202 ]]
    -- upvalues: u16 (copy)
    return u16();
end;
function v9.NumberF16(p69) --[[ Line: 203 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u22 (copy)
    local v70 = u4 + 2;
    if u3 < v70 then
        while u3 < v70 do
            u3 = u3 * 2;
        end;
        local v71 = buffer.create(u3);
        buffer.copy(v71, 0, u2, 0, u4);
        u1.Buffer = v71;
        u2 = v71;
    end;
    u22(p69);
end;
v7.NumberF24 = "NumberF24";
function v8.NumberF24() --[[ Line: 206 ]]
    -- upvalues: u27 (copy)
    return u27();
end;
function v9.NumberF24(p72) --[[ Line: 207 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v73 = u4 + 3;
    if u3 < v73 then
        while u3 < v73 do
            u3 = u3 * 2;
        end;
        local v74 = buffer.create(u3);
        buffer.copy(v74, 0, u2, 0, u4);
        u1.Buffer = v74;
        u2 = v74;
    end;
    u33(p72);
end;
v7.NumberF32 = "NumberF32";
function v8.NumberF32() --[[ Line: 210 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v75 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return v75;
end;
function v9.NumberF32(p76) --[[ Line: 211 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v77 = u4 + 4;
    if u3 < v77 then
        while u3 < v77 do
            u3 = u3 * 2;
        end;
        local v78 = buffer.create(u3);
        buffer.copy(v78, 0, u2, 0, u4);
        u1.Buffer = v78;
        u2 = v78;
    end;
    buffer.writef32(u2, u4, p76);
    u4 = u4 + 4;
end;
v7.NumberF64 = "NumberF64";
function v8.NumberF64() --[[ Line: 214 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v79 = buffer.readf64(u2, u4);
    u4 = u4 + 8;
    return v79;
end;
function v9.NumberF64(p80) --[[ Line: 215 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v81 = u4 + 8;
    if u3 < v81 then
        while u3 < v81 do
            u3 = u3 * 2;
        end;
        local v82 = buffer.create(u3);
        buffer.copy(v82, 0, u2, 0, u4);
        u1.Buffer = v82;
        u2 = v82;
    end;
    buffer.writef64(u2, u4, p80);
    u4 = u4 + 8;
end;
v7.String = "String";
function v8.String() --[[ Line: 218 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v83 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v84 = buffer.readstring(u2, u4, v83);
    u4 = u4 + v83;
    return v84;
end;
function v9.String(p85) --[[ Line: 219 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v86 = #p85;
    local v87 = u4 + (v86 + 1);
    if u3 < v87 then
        while u3 < v87 do
            u3 = u3 * 2;
        end;
        local v88 = buffer.create(u3);
        buffer.copy(v88, 0, u2, 0, u4);
        u1.Buffer = v88;
        u2 = v88;
    end;
    buffer.writeu8(u2, u4, v86);
    u4 = u4 + 1;
    buffer.writestring(u2, u4, p85);
    u4 = u4 + #p85;
end;
v7.StringLong = "StringLong";
function v8.StringLong() --[[ Line: 222 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v89 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v90 = buffer.readstring(u2, u4, v89);
    u4 = u4 + v89;
    return v90;
end;
function v9.StringLong(p91) --[[ Line: 223 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v92 = #p91;
    local v93 = u4 + (v92 + 2);
    if u3 < v93 then
        while u3 < v93 do
            u3 = u3 * 2;
        end;
        local v94 = buffer.create(u3);
        buffer.copy(v94, 0, u2, 0, u4);
        u1.Buffer = v94;
        u2 = v94;
    end;
    buffer.writeu16(u2, u4, v92);
    u4 = u4 + 2;
    buffer.writestring(u2, u4, p91);
    u4 = u4 + #p91;
end;
v7.Buffer = "Buffer";
function v8.Buffer() --[[ Line: 226 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v95 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v96 = buffer.create(v95);
    buffer.copy(v96, 0, u2, u4, v95);
    u4 = u4 + v95;
    return v96;
end;
function v9.Buffer(p97) --[[ Line: 227 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v98 = buffer.len(p97);
    local v99 = u4 + (1 + v98);
    if u3 < v99 then
        while u3 < v99 do
            u3 = u3 * 2;
        end;
        local v100 = buffer.create(u3);
        buffer.copy(v100, 0, u2, 0, u4);
        u1.Buffer = v100;
        u2 = v100;
    end;
    buffer.writeu8(u2, u4, v98);
    u4 = u4 + 1;
    buffer.copy(u2, u4, p97);
    u4 = u4 + buffer.len(p97);
end;
v7.BufferLong = "BufferLong";
function v8.BufferLong() --[[ Line: 230 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v101 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v102 = buffer.create(v101);
    buffer.copy(v102, 0, u2, u4, v101);
    u4 = u4 + v101;
    return v102;
end;
function v9.BufferLong(p103) --[[ Line: 231 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v104 = buffer.len(p103);
    local v105 = u4 + (2 + v104);
    if u3 < v105 then
        while u3 < v105 do
            u3 = u3 * 2;
        end;
        local v106 = buffer.create(u3);
        buffer.copy(v106, 0, u2, 0, u4);
        u1.Buffer = v106;
        u2 = v106;
    end;
    buffer.writeu16(u2, u4, v104);
    u4 = u4 + 2;
    buffer.copy(u2, u4, p103);
    u4 = u4 + buffer.len(p103);
end;
v7.Instance = "Instance";
function v8.Instance() --[[ Line: 235 ]]
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;
    return u5[u6];
end;
function v9.Instance(p107) --[[ Line: 236 ]]
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;
    u5[u6] = p107;
end;
v7.Boolean8 = "Boolean8";
function v8.Boolean8() --[[ Line: 239 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v108 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return v108 == 1;
end;
function v9.Boolean8(p109) --[[ Line: 240 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v110 = u4 + 1;
    if u3 < v110 then
        while u3 < v110 do
            u3 = u3 * 2;
        end;
        local v111 = buffer.create(u3);
        buffer.copy(v111, 0, u2, 0, u4);
        u1.Buffer = v111;
        u2 = v111;
    end;
    buffer.writeu8(u2, u4, p109 and 1 or 0);
    u4 = u4 + 1;
end;
v7.NumberRange = "NumberRange";
function v8.NumberRange() --[[ Line: 243 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__1 = NumberRange.new;
    local v112 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v113 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__1(v112, v113);
end;
function v9.NumberRange(p114) --[[ Line: 244 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v115 = u4 + 8;
    if u3 < v115 then
        while u3 < v115 do
            u3 = u3 * 2;
        end;
        local v116 = buffer.create(u3);
        buffer.copy(v116, 0, u2, 0, u4);
        u1.Buffer = v116;
        u2 = v116;
    end;
    buffer.writef32(u2, u4, p114.Min);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p114.Max);
    u4 = u4 + 4;
end;
v7.BrickColor = "BrickColor";
function v8.BrickColor() --[[ Line: 247 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__2 = BrickColor.new;
    local v117 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    return l__new__2(v117);
end;
function v9.BrickColor(p118) --[[ Line: 248 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v119 = u4 + 2;
    if u3 < v119 then
        while u3 < v119 do
            u3 = u3 * 2;
        end;
        local v120 = buffer.create(u3);
        buffer.copy(v120, 0, u2, 0, u4);
        u1.Buffer = v120;
        u2 = v120;
    end;
    buffer.writeu16(u2, u4, p118.Number);
    u4 = u4 + 2;
end;
v7.Color3 = "Color3";
function v8.Color3() --[[ Line: 251 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__fromRGB__3 = Color3.fromRGB;
    local v121 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v122 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v123 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    return l__fromRGB__3(v121, v122, v123);
end;
function v9.Color3(p124) --[[ Line: 252 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v125 = u4 + 3;
    if u3 < v125 then
        while u3 < v125 do
            u3 = u3 * 2;
        end;
        local v126 = buffer.create(u3);
        buffer.copy(v126, 0, u2, 0, u4);
        u1.Buffer = v126;
        u2 = v126;
    end;
    buffer.writeu8(u2, u4, p124.R * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p124.G * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p124.B * 255 + 0.5);
    u4 = u4 + 1;
end;
v7.UDim = "UDim";
function v8.UDim() --[[ Line: 255 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__4 = UDim.new;
    local v127 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v128 = v127 / 1000;
    local v129 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return l__new__4(v128, v129);
end;
function v9.UDim(p130) --[[ Line: 256 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v131 = u4 + 4;
    if u3 < v131 then
        while u3 < v131 do
            u3 = u3 * 2;
        end;
        local v132 = buffer.create(u3);
        buffer.copy(v132, 0, u2, 0, u4);
        u1.Buffer = v132;
        u2 = v132;
    end;
    buffer.writei16(u2, u4, p130.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p130.Offset);
    u4 = u4 + 2;
end;
v7.UDim2 = "UDim2";
function v8.UDim2() --[[ Line: 259 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__5 = UDim2.new;
    local v133 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v134 = v133 / 1000;
    local v135 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v136 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v137 = v136 / 1000;
    local v138 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return l__new__5(v134, v135, v137, v138);
end;
function v9.UDim2(p139) --[[ Line: 260 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v140 = u4 + 8;
    if u3 < v140 then
        while u3 < v140 do
            u3 = u3 * 2;
        end;
        local v141 = buffer.create(u3);
        buffer.copy(v141, 0, u2, 0, u4);
        u1.Buffer = v141;
        u2 = v141;
    end;
    buffer.writei16(u2, u4, p139.X.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p139.X.Offset);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p139.Y.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p139.Y.Offset);
    u4 = u4 + 2;
end;
v7.Rect = "Rect";
function v8.Rect() --[[ Line: 263 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__6 = Rect.new;
    local v142 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v143 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v144 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v145 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__6(v142, v143, v144, v145);
end;
function v9.Rect(p146) --[[ Line: 264 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v147 = u4 + 16;
    if u3 < v147 then
        while u3 < v147 do
            u3 = u3 * 2;
        end;
        local v148 = buffer.create(u3);
        buffer.copy(v148, 0, u2, 0, u4);
        u1.Buffer = v148;
        u2 = v148;
    end;
    buffer.writef32(u2, u4, p146.Min.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p146.Min.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p146.Max.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p146.Max.Y);
    u4 = u4 + 4;
end;
v7.Vector2S16 = "Vector2S16";
function v8.Vector2S16() --[[ Line: 267 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__7 = Vector2.new;
    local v149 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v150 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return l__new__7(v149, v150);
end;
function v9.Vector2S16(p151) --[[ Line: 268 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v152 = u4 + 4;
    if u3 < v152 then
        while u3 < v152 do
            u3 = u3 * 2;
        end;
        local v153 = buffer.create(u3);
        buffer.copy(v153, 0, u2, 0, u4);
        u1.Buffer = v153;
        u2 = v153;
    end;
    buffer.writei16(u2, u4, p151.X);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p151.Y);
    u4 = u4 + 2;
end;
v7.Vector2F24 = "Vector2F24";
function v8.Vector2F24() --[[ Line: 271 ]]
    -- upvalues: u27 (copy)
    return Vector2.new(u27(), (u27()));
end;
function v9.Vector2F24(p154) --[[ Line: 272 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v155 = u4 + 6;
    if u3 < v155 then
        while u3 < v155 do
            u3 = u3 * 2;
        end;
        local v156 = buffer.create(u3);
        buffer.copy(v156, 0, u2, 0, u4);
        u1.Buffer = v156;
        u2 = v156;
    end;
    u33(p154.X);
    u33(p154.Y);
end;
v7.Vector2F32 = "Vector2F32";
function v8.Vector2F32() --[[ Line: 275 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__8 = Vector2.new;
    local v157 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v158 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__8(v157, v158);
end;
function v9.Vector2F32(p159) --[[ Line: 276 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v160 = u4 + 8;
    if u3 < v160 then
        while u3 < v160 do
            u3 = u3 * 2;
        end;
        local v161 = buffer.create(u3);
        buffer.copy(v161, 0, u2, 0, u4);
        u1.Buffer = v161;
        u2 = v161;
    end;
    buffer.writef32(u2, u4, p159.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p159.Y);
    u4 = u4 + 4;
end;
v7.Vector3S16 = "Vector3S16";
function v8.Vector3S16() --[[ Line: 279 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v162 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v163 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local v164 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    return Vector3.new(v162, v163, v164);
end;
function v9.Vector3S16(p165) --[[ Line: 280 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v166 = u4 + 6;
    if u3 < v166 then
        while u3 < v166 do
            u3 = u3 * 2;
        end;
        local v167 = buffer.create(u3);
        buffer.copy(v167, 0, u2, 0, u4);
        u1.Buffer = v167;
        u2 = v167;
    end;
    buffer.writei16(u2, u4, p165.X);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p165.Y);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p165.Z);
    u4 = u4 + 2;
end;
v7.Vector3F24 = "Vector3F24";
function v8.Vector3F24() --[[ Line: 283 ]]
    -- upvalues: u27 (copy)
    local v168 = u27();
    local v169 = u27();
    local v170 = u27();
    return Vector3.new(v168, v169, v170);
end;
function v9.Vector3F24(p171) --[[ Line: 284 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v172 = u4 + 9;
    if u3 < v172 then
        while u3 < v172 do
            u3 = u3 * 2;
        end;
        local v173 = buffer.create(u3);
        buffer.copy(v173, 0, u2, 0, u4);
        u1.Buffer = v173;
        u2 = v173;
    end;
    u33(p171.X);
    u33(p171.Y);
    u33(p171.Z);
end;
v7.InstanceVector3F24Array = "InstanceVector3F24Array";
function v8.InstanceVector3F24Array() --[[ Line: 287 ]]
    -- upvalues: u2 (ref), u4 (ref), u6 (ref), u5 (ref), u27 (copy)
    local v174 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v175 = table.create(v174);
    for v176 = 1, v174 do
        local v177 = {};
        u6 = u6 + 1;
        local v178 = u5[u6];
        local v179 = u27();
        local v180 = u27();
        local v181 = u27();
        v177[1], v177[2] = v178, Vector3.new(v179, v180, v181);
        v175[v176] = v177;
    end;
    return v175;
end;
function v9.InstanceVector3F24Array(p182) --[[ Line: 295 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u6 (ref), u5 (ref), u33 (copy)
    local v183 = #p182;
    local v184 = v183 > 65535 and 65535 or v183;
    local v185 = u4 + 2;
    if u3 < v185 then
        while u3 < v185 do
            u3 = u3 * 2;
        end;
        local v186 = buffer.create(u3);
        buffer.copy(v186, 0, u2, 0, u4);
        u1.Buffer = v186;
        u2 = v186;
    end;
    buffer.writeu16(u2, u4, v184);
    u4 = u4 + 2;
    for v187 = 1, v184 do
        local v188 = p182[v187];
        local v189 = v188[1];
        u6 = u6 + 1;
        u5[u6] = v189;
        local v190 = v188[2];
        local v191 = u4 + 9;
        if u3 < v191 then
            while u3 < v191 do
                u3 = u3 * 2;
            end;
            local v192 = buffer.create(u3);
            buffer.copy(v192, 0, u2, 0, u4);
            u1.Buffer = v192;
            u2 = v192;
        end;
        u33(v190.X);
        u33(v190.Y);
        u33(v190.Z);
    end;
end;
v7.Vector3F32 = "Vector3F32";
function v8.Vector3F32() --[[ Line: 312 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v193 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v194 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v195 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return Vector3.new(v193, v194, v195);
end;
function v9.Vector3F32(p196) --[[ Line: 313 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v197 = u4 + 12;
    if u3 < v197 then
        while u3 < v197 do
            u3 = u3 * 2;
        end;
        local v198 = buffer.create(u3);
        buffer.copy(v198, 0, u2, 0, u4);
        u1.Buffer = v198;
        u2 = v198;
    end;
    buffer.writef32(u2, u4, p196.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p196.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p196.Z);
    u4 = u4 + 4;
end;
v7.NumberU4 = "NumberU4";
function v8.NumberU4() --[[ Line: 316 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v199 = u4 * 8;
    u4 = u4 + 1;
    return { buffer.readbits(u2, v199 + 0, 4), buffer.readbits(u2, v199 + 4, 4) };
end;
function v9.NumberU4(p200) --[[ Line: 324 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v201 = u4 + 1;
    if u3 < v201 then
        while u3 < v201 do
            u3 = u3 * 2;
        end;
        local v202 = buffer.create(u3);
        buffer.copy(v202, 0, u2, 0, u4);
        u1.Buffer = v202;
        u2 = v202;
    end;
    local v203 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v203 + 0, 4, p200[1]);
    buffer.writebits(u2, v203 + 4, 4, p200[2]);
end;
v7.BooleanNumber = "BooleanNumber";
function v8.BooleanNumber() --[[ Line: 333 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v204 = u4 * 8;
    u4 = u4 + 1;
    return {
        Boolean = buffer.readbits(u2, v204 + 0, 1) == 1,
        Number = buffer.readbits(u2, v204 + 1, 7)
    };
end;
function v9.BooleanNumber(p205) --[[ Line: 341 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v206 = u4 + 1;
    if u3 < v206 then
        while u3 < v206 do
            u3 = u3 * 2;
        end;
        local v207 = buffer.create(u3);
        buffer.copy(v207, 0, u2, 0, u4);
        u1.Buffer = v207;
        u2 = v207;
    end;
    local v208 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v208 + 0, 1, p205.Boolean and 1 or 0);
    buffer.writebits(u2, v208 + 1, 7, p205.Number);
end;
v7.Boolean1 = "Boolean1";
function v8.Boolean1() --[[ Line: 350 ]]
    -- upvalues: u4 (ref), u2 (ref)
    local v209 = u4 * 8;
    u4 = u4 + 1;
    return {
        buffer.readbits(u2, v209 + 0, 1) == 1,
        buffer.readbits(u2, v209 + 1, 1) == 1,
        buffer.readbits(u2, v209 + 2, 1) == 1,
        buffer.readbits(u2, v209 + 3, 1) == 1,
        buffer.readbits(u2, v209 + 4, 1) == 1,
        buffer.readbits(u2, v209 + 5, 1) == 1,
        buffer.readbits(u2, v209 + 6, 1) == 1,
        buffer.readbits(u2, v209 + 7, 1) == 1
    };
end;
function v9.Boolean1(p210) --[[ Line: 364 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v211 = u4 + 1;
    if u3 < v211 then
        while u3 < v211 do
            u3 = u3 * 2;
        end;
        local v212 = buffer.create(u3);
        buffer.copy(v212, 0, u2, 0, u4);
        u1.Buffer = v212;
        u2 = v212;
    end;
    local v213 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v213 + 0, 1, p210[1] and 1 or 0);
    buffer.writebits(u2, v213 + 1, 1, p210[2] and 1 or 0);
    buffer.writebits(u2, v213 + 2, 1, p210[3] and 1 or 0);
    buffer.writebits(u2, v213 + 3, 1, p210[4] and 1 or 0);
    buffer.writebits(u2, v213 + 4, 1, p210[5] and 1 or 0);
    buffer.writebits(u2, v213 + 5, 1, p210[6] and 1 or 0);
    buffer.writebits(u2, v213 + 6, 1, p210[7] and 1 or 0);
    buffer.writebits(u2, v213 + 7, 1, p210[8] and 1 or 0);
end;
v7.CFrameF24U8 = "CFrameF24U8";
function v8.CFrameF24U8() --[[ Line: 379 ]]
    -- upvalues: u2 (ref), u4 (ref), u27 (copy)
    local l__fromEulerAnglesXYZ__9 = CFrame.fromEulerAnglesXYZ;
    local v214 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v215 = v214 / 40.58451048843331;
    local v216 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v217 = v216 / 40.58451048843331;
    local v218 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v219 = l__fromEulerAnglesXYZ__9(v215, v217, v218 / 40.58451048843331);
    local v220 = u27();
    local v221 = u27();
    local v222 = u27();
    return v219 + Vector3.new(v220, v221, v222);
end;
function v9.CFrameF24U8(p223) --[[ Line: 383 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u33 (copy)
    local v224, v225, v226 = p223:ToEulerAnglesXYZ();
    local v227 = u4 + 12;
    if u3 < v227 then
        while u3 < v227 do
            u3 = u3 * 2;
        end;
        local v228 = buffer.create(u3);
        buffer.copy(v228, 0, u2, 0, u4);
        u1.Buffer = v228;
        u2 = v228;
    end;
    buffer.writeu8(u2, u4, v224 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v225 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v226 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    u33(p223.X);
    u33(p223.Y);
    u33(p223.Z);
end;
v7.CFrameF32U8 = "CFrameF32U8";
function v8.CFrameF32U8() --[[ Line: 391 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__fromEulerAnglesXYZ__10 = CFrame.fromEulerAnglesXYZ;
    local v229 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v230 = v229 / 40.58451048843331;
    local v231 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v232 = v231 / 40.58451048843331;
    local v233 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v234 = l__fromEulerAnglesXYZ__10(v230, v232, v233 / 40.58451048843331);
    local v235 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v236 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v237 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return v234 + Vector3.new(v235, v236, v237);
end;
function v9.CFrameF32U8(p238) --[[ Line: 395 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v239, v240, v241 = p238:ToEulerAnglesXYZ();
    local v242 = u4 + 15;
    if u3 < v242 then
        while u3 < v242 do
            u3 = u3 * 2;
        end;
        local v243 = buffer.create(u3);
        buffer.copy(v243, 0, u2, 0, u4);
        u1.Buffer = v243;
        u2 = v243;
    end;
    buffer.writeu8(u2, u4, v239 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v240 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v241 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, p238.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p238.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p238.Z);
    u4 = u4 + 4;
end;
v7.CFrameF32U16 = "CFrameF32U16";
function v8.CFrameF32U16() --[[ Line: 403 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__fromEulerAnglesXYZ__11 = CFrame.fromEulerAnglesXYZ;
    local v244 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v245 = v244 / 10430.219195527361;
    local v246 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v247 = v246 / 10430.219195527361;
    local v248 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v249 = l__fromEulerAnglesXYZ__11(v245, v247, v248 / 10430.219195527361);
    local v250 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v251 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v252 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return v249 + Vector3.new(v250, v251, v252);
end;
function v9.CFrameF32U16(p253) --[[ Line: 407 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v254, v255, v256 = p253:ToEulerAnglesXYZ();
    local v257 = u4 + 18;
    if u3 < v257 then
        while u3 < v257 do
            u3 = u3 * 2;
        end;
        local v258 = buffer.create(u3);
        buffer.copy(v258, 0, u2, 0, u4);
        u1.Buffer = v258;
        u2 = v258;
    end;
    buffer.writeu16(u2, u4, v254 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v255 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v256 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writef32(u2, u4, p253.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p253.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p253.Z);
    u4 = u4 + 4;
end;
v7.Region3 = "Region3";
function v8.Region3() --[[ Line: 415 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local l__new__12 = Region3.new;
    local v259 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v260 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v261 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v262 = Vector3.new(v259, v260, v261);
    local v263 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v264 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local v265 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    return l__new__12(v262, (Vector3.new(v263, v264, v265)));
end;
function v9.Region3(p266) --[[ Line: 421 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v267 = p266.Size / 2;
    local v268 = p266.CFrame.Position - v267;
    local v269 = p266.CFrame.Position + v267;
    local v270 = u4 + 24;
    if u3 < v270 then
        while u3 < v270 do
            u3 = u3 * 2;
        end;
        local v271 = buffer.create(u3);
        buffer.copy(v271, 0, u2, 0, u4);
        u1.Buffer = v271;
        u2 = v271;
    end;
    buffer.writef32(u2, u4, v268.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v268.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v268.Z);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v269.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v269.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v269.Z);
    u4 = u4 + 4;
end;
v7.NumberSequence = "NumberSequence";
function v8.NumberSequence() --[[ Line: 431 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v272 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v273 = table.create(v272);
    for _ = 1, v272 do
        local l__new__13 = NumberSequenceKeypoint.new;
        local v274 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v275 = v274 / 255;
        local v276 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v277 = v276 / 255;
        local v278 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(v273, l__new__13(v275, v277, v278 / 255));
    end;
    return NumberSequence.new(v273);
end;
function v9.NumberSequence(p279) --[[ Line: 439 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v280 = #p279.Keypoints;
    local v281 = u4 + (v280 * 3 + 1);
    if u3 < v281 then
        while u3 < v281 do
            u3 = u3 * 2;
        end;
        local v282 = buffer.create(u3);
        buffer.copy(v282, 0, u2, 0, u4);
        u1.Buffer = v282;
        u2 = v282;
    end;
    buffer.writeu8(u2, u4, v280);
    u4 = u4 + 1;
    for _, v283 in p279.Keypoints do
        buffer.writeu8(u2, u4, v283.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v283.Value * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v283.Envelope * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;
v7.ColorSequence = "ColorSequence";
function v8.ColorSequence() --[[ Line: 449 ]]
    -- upvalues: u2 (ref), u4 (ref)
    local v284 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v285 = table.create(v284);
    for _ = 1, v284 do
        local l__new__14 = ColorSequenceKeypoint.new;
        local v286 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v287 = v286 / 255;
        local l__fromRGB__15 = Color3.fromRGB;
        local v288 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v289 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local v290 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(v285, l__new__14(v287, l__fromRGB__15(v288, v289, v290)));
    end;
    return ColorSequence.new(v285);
end;
function v9.ColorSequence(p291) --[[ Line: 457 ]]
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v292 = #p291.Keypoints;
    local v293 = u4 + (v292 * 4 + 1);
    if u3 < v293 then
        while u3 < v293 do
            u3 = u3 * 2;
        end;
        local v294 = buffer.create(u3);
        buffer.copy(v294, 0, u2, 0, u4);
        u1.Buffer = v294;
        u2 = v294;
    end;
    buffer.writeu8(u2, u4, v292);
    u4 = u4 + 1;
    for _, v295 in p291.Keypoints do
        buffer.writeu8(u2, u4, v295.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v295.Value.R * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v295.Value.G * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v295.Value.B * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;
local l__Characters__16 = require(script.Characters);
local u296 = u5;
local u297 = u6;
local u298 = u1;
local u299 = u3;
local u300 = u4;
local u301 = u2;
local u302 = {};
for v303, v304 in l__Characters__16 do
    u302[v304] = v303;
end;
local v305 = math.log(#l__Characters__16 + 1, 2);
local u306 = math.ceil(v305);
local u307 = u306 / 8;
v7.Characters = "Characters";
function v8.Characters() --[[ Line: 473 ]]
    -- upvalues: u301 (ref), u300 (ref), u307 (copy), l__Characters__16 (copy), u306 (copy)
    local v308 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v309 = table.create(v308);
    local v310 = u300 * 8;
    u300 = u300 + math.ceil(v308 * u307);
    for _ = 1, v308 do
        local v311 = l__Characters__16[buffer.readbits(u301, v310, u306)];
        table.insert(v309, v311);
        v310 = v310 + u306;
    end;
    return table.concat(v309);
end;
function v9.Characters(p312) --[[ Line: 484 ]]
    -- upvalues: u307 (copy), u300 (ref), u299 (ref), u301 (ref), u298 (ref), u306 (copy), u302 (copy)
    local v313 = #p312;
    local v314 = math.ceil(v313 * u307);
    local v315 = u300 + (v314 + 1);
    if u299 < v315 then
        while u299 < v315 do
            u299 = u299 * 2;
        end;
        local v316 = buffer.create(u299);
        buffer.copy(v316, 0, u301, 0, u300);
        u298.Buffer = v316;
        u301 = v316;
    end;
    buffer.writeu8(u301, u300, v313);
    u300 = u300 + 1;
    local v317 = u300 * 8;
    for v318 = 1, v313 do
        buffer.writebits(u301, v317, u306, u302[p312:sub(v318, v318)]);
        v317 = v317 + u306;
    end;
    u300 = u300 + v314;
end;
local l__Enums__17 = require(script.Enums);
local u319 = {};
for v320, v321 in l__Enums__17 do
    u319[v321] = v320;
end;
v7.EnumItem = "EnumItem";
function v8.EnumItem() --[[ Line: 501 ]]
    -- upvalues: l__Enums__17 (copy), u301 (ref), u300 (ref)
    local v322 = l__Enums__17;
    local v323 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v324 = v322[v323];
    local v325 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    return v324:FromValue(v325);
end;
function v9.EnumItem(p326) --[[ Line: 502 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref), u319 (copy)
    local v327 = u300 + 3;
    if u299 < v327 then
        while u299 < v327 do
            u299 = u299 * 2;
        end;
        local v328 = buffer.create(u299);
        buffer.copy(v328, 0, u301, 0, u300);
        u298.Buffer = v328;
        u301 = v328;
    end;
    buffer.writeu8(u301, u300, u319[p326.EnumType]);
    u300 = u300 + 1;
    buffer.writeu16(u301, u300, p326.Value);
    u300 = u300 + 2;
end;
local l__Static1__18 = require(script.Static1);
local u329 = {};
for v330, v331 in l__Static1__18 do
    u329[v331] = v330;
end;
v7.Static1 = "Static1";
function v8.Static1() --[[ Line: 508 ]]
    -- upvalues: l__Static1__18 (copy), u301 (ref), u300 (ref)
    local v332 = l__Static1__18;
    local v333 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    return v332[v333];
end;
function v9.Static1(p334) --[[ Line: 509 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref), u329 (copy)
    local v335 = u300 + 1;
    if u299 < v335 then
        while u299 < v335 do
            u299 = u299 * 2;
        end;
        local v336 = buffer.create(u299);
        buffer.copy(v336, 0, u301, 0, u300);
        u298.Buffer = v336;
        u301 = v336;
    end;
    buffer.writeu8(u301, u300, u329[p334] or 0);
    u300 = u300 + 1;
end;
local l__Static2__19 = require(script.Static2);
local u337 = {};
for v338, v339 in l__Static2__19 do
    u337[v339] = v338;
end;
v7.Static2 = "Static2";
function v8.Static2() --[[ Line: 515 ]]
    -- upvalues: l__Static2__19 (copy), u301 (ref), u300 (ref)
    local v340 = l__Static2__19;
    local v341 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    return v340[v341];
end;
function v9.Static2(p342) --[[ Line: 516 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref), u337 (copy)
    local v343 = u300 + 1;
    if u299 < v343 then
        while u299 < v343 do
            u299 = u299 * 2;
        end;
        local v344 = buffer.create(u299);
        buffer.copy(v344, 0, u301, 0, u300);
        u298.Buffer = v344;
        u301 = v344;
    end;
    buffer.writeu8(u301, u300, u337[p342] or 0);
    u300 = u300 + 1;
end;
local l__Static3__20 = require(script.Static3);
local u345 = {};
for v346, v347 in l__Static3__20 do
    u345[v347] = v346;
end;
v7.Static3 = "Static3";
function v8.Static3() --[[ Line: 522 ]]
    -- upvalues: l__Static3__20 (copy), u301 (ref), u300 (ref)
    local v348 = l__Static3__20;
    local v349 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    return v348[v349];
end;
function v9.Static3(p350) --[[ Line: 523 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref), u345 (copy)
    local v351 = u300 + 1;
    if u299 < v351 then
        while u299 < v351 do
            u299 = u299 * 2;
        end;
        local v352 = buffer.create(u299);
        buffer.copy(v352, 0, u301, 0, u300);
        u298.Buffer = v352;
        u301 = v352;
    end;
    buffer.writeu8(u301, u300, u345[p350] or 0);
    u300 = u300 + 1;
end;
u10[0] = function() --[[ Line: 527 ]]
    return nil;
end;
u11["nil"] = function(_) --[[ Line: 528 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v353 = u300 + 1;
    if u299 < v353 then
        while u299 < v353 do
            u299 = u299 * 2;
        end;
        local v354 = buffer.create(u299);
        buffer.copy(v354, 0, u301, 0, u300);
        u298.Buffer = v354;
        u301 = v354;
    end;
    buffer.writeu8(u301, u300, 0);
    u300 = u300 + 1;
end;
u10[1] = function() --[[ Line: 530 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v355 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    return -v355;
end;
u10[2] = function() --[[ Line: 531 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v356 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    return -v356;
end;
u10[3] = function() --[[ Line: 532 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v357 = buffer.readbits(u301, u300 * 8, 24);
    u300 = u300 + 3;
    return -v357;
end;
u10[4] = function() --[[ Line: 533 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v358 = buffer.readu32(u301, u300);
    u300 = u300 + 4;
    return -v358;
end;
u10[5] = function() --[[ Line: 534 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v359 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    return v359;
end;
u10[6] = function() --[[ Line: 535 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v360 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    return v360;
end;
u10[7] = function() --[[ Line: 536 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v361 = buffer.readbits(u301, u300 * 8, 24);
    u300 = u300 + 3;
    return v361;
end;
u10[8] = function() --[[ Line: 537 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v362 = buffer.readu32(u301, u300);
    u300 = u300 + 4;
    return v362;
end;
u10[9] = function() --[[ Line: 538 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v363 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    return v363;
end;
u10[10] = function() --[[ Line: 539 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v364 = buffer.readf64(u301, u300);
    u300 = u300 + 8;
    return v364;
end;
function u11.number(p365) --[[ Line: 540 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    if p365 % 1 == 0 then
        if p365 < 0 then
            if p365 > -256 then
                local v366 = u300 + 2;
                if u299 < v366 then
                    while u299 < v366 do
                        u299 = u299 * 2;
                    end;
                    local v367 = buffer.create(u299);
                    buffer.copy(v367, 0, u301, 0, u300);
                    u298.Buffer = v367;
                    u301 = v367;
                end;
                buffer.writeu8(u301, u300, 1);
                u300 = u300 + 1;
                buffer.writeu8(u301, u300, -p365);
                u300 = u300 + 1;
            elseif p365 > -65536 then
                local v368 = u300 + 3;
                if u299 < v368 then
                    while u299 < v368 do
                        u299 = u299 * 2;
                    end;
                    local v369 = buffer.create(u299);
                    buffer.copy(v369, 0, u301, 0, u300);
                    u298.Buffer = v369;
                    u301 = v369;
                end;
                buffer.writeu8(u301, u300, 2);
                u300 = u300 + 1;
                buffer.writeu16(u301, u300, -p365);
                u300 = u300 + 2;
            elseif p365 > -16777216 then
                local v370 = u300 + 4;
                if u299 < v370 then
                    while u299 < v370 do
                        u299 = u299 * 2;
                    end;
                    local v371 = buffer.create(u299);
                    buffer.copy(v371, 0, u301, 0, u300);
                    u298.Buffer = v371;
                    u301 = v371;
                end;
                buffer.writeu8(u301, u300, 3);
                u300 = u300 + 1;
                buffer.writebits(u301, u300 * 8, 24, -p365);
                u300 = u300 + 3;
            elseif p365 > -4294967296 then
                local v372 = u300 + 5;
                if u299 < v372 then
                    while u299 < v372 do
                        u299 = u299 * 2;
                    end;
                    local v373 = buffer.create(u299);
                    buffer.copy(v373, 0, u301, 0, u300);
                    u298.Buffer = v373;
                    u301 = v373;
                end;
                buffer.writeu8(u301, u300, 4);
                u300 = u300 + 1;
                buffer.writeu32(u301, u300, -p365);
                u300 = u300 + 4;
            else
                local v374 = u300 + 9;
                if u299 < v374 then
                    while u299 < v374 do
                        u299 = u299 * 2;
                    end;
                    local v375 = buffer.create(u299);
                    buffer.copy(v375, 0, u301, 0, u300);
                    u298.Buffer = v375;
                    u301 = v375;
                end;
                buffer.writeu8(u301, u300, 10);
                u300 = u300 + 1;
                buffer.writef64(u301, u300, p365);
                u300 = u300 + 8;
            end;
        elseif p365 < 256 then
            local v376 = u300 + 2;
            if u299 < v376 then
                while u299 < v376 do
                    u299 = u299 * 2;
                end;
                local v377 = buffer.create(u299);
                buffer.copy(v377, 0, u301, 0, u300);
                u298.Buffer = v377;
                u301 = v377;
            end;
            buffer.writeu8(u301, u300, 5);
            u300 = u300 + 1;
            buffer.writeu8(u301, u300, p365);
            u300 = u300 + 1;
        elseif p365 < 65536 then
            local v378 = u300 + 3;
            if u299 < v378 then
                while u299 < v378 do
                    u299 = u299 * 2;
                end;
                local v379 = buffer.create(u299);
                buffer.copy(v379, 0, u301, 0, u300);
                u298.Buffer = v379;
                u301 = v379;
            end;
            buffer.writeu8(u301, u300, 6);
            u300 = u300 + 1;
            buffer.writeu16(u301, u300, p365);
            u300 = u300 + 2;
        elseif p365 < 16777216 then
            local v380 = u300 + 4;
            if u299 < v380 then
                while u299 < v380 do
                    u299 = u299 * 2;
                end;
                local v381 = buffer.create(u299);
                buffer.copy(v381, 0, u301, 0, u300);
                u298.Buffer = v381;
                u301 = v381;
            end;
            buffer.writeu8(u301, u300, 7);
            u300 = u300 + 1;
            buffer.writebits(u301, u300 * 8, 24, p365);
            u300 = u300 + 3;
        elseif p365 < 4294967296 then
            local v382 = u300 + 5;
            if u299 < v382 then
                while u299 < v382 do
                    u299 = u299 * 2;
                end;
                local v383 = buffer.create(u299);
                buffer.copy(v383, 0, u301, 0, u300);
                u298.Buffer = v383;
                u301 = v383;
            end;
            buffer.writeu8(u301, u300, 8);
            u300 = u300 + 1;
            buffer.writeu32(u301, u300, p365);
            u300 = u300 + 4;
        else
            local v384 = u300 + 9;
            if u299 < v384 then
                while u299 < v384 do
                    u299 = u299 * 2;
                end;
                local v385 = buffer.create(u299);
                buffer.copy(v385, 0, u301, 0, u300);
                u298.Buffer = v385;
                u301 = v385;
            end;
            buffer.writeu8(u301, u300, 10);
            u300 = u300 + 1;
            buffer.writef64(u301, u300, p365);
            u300 = u300 + 8;
        end;
    elseif p365 > -1048576 and p365 < 1048576 then
        local v386 = u300 + 5;
        if u299 < v386 then
            while u299 < v386 do
                u299 = u299 * 2;
            end;
            local v387 = buffer.create(u299);
            buffer.copy(v387, 0, u301, 0, u300);
            u298.Buffer = v387;
            u301 = v387;
        end;
        buffer.writeu8(u301, u300, 9);
        u300 = u300 + 1;
        buffer.writef32(u301, u300, p365);
        u300 = u300 + 4;
    else
        local v388 = u300 + 9;
        if u299 < v388 then
            while u299 < v388 do
                u299 = u299 * 2;
            end;
            local v389 = buffer.create(u299);
            buffer.copy(v389, 0, u301, 0, u300);
            u298.Buffer = v389;
            u301 = v389;
        end;
        buffer.writeu8(u301, u300, 10);
        u300 = u300 + 1;
        buffer.writef64(u301, u300, p365);
        u300 = u300 + 8;
    end;
end;
u10[11] = function() --[[ Line: 574 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v390 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v391 = buffer.readstring(u301, u300, v390);
    u300 = u300 + v390;
    return v391;
end;
function u11.string(p392) --[[ Line: 575 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v393 = #p392;
    local v394 = u300 + (v393 + 2);
    if u299 < v394 then
        while u299 < v394 do
            u299 = u299 * 2;
        end;
        local v395 = buffer.create(u299);
        buffer.copy(v395, 0, u301, 0, u300);
        u298.Buffer = v395;
        u301 = v395;
    end;
    buffer.writeu8(u301, u300, 11);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, v393);
    u300 = u300 + 1;
    buffer.writestring(u301, u300, p392);
    u300 = u300 + #p392;
end;
u10[12] = function() --[[ Line: 577 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v396 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v397 = buffer.create(v396);
    buffer.copy(v397, 0, u301, u300, v396);
    u300 = u300 + v396;
    return v397;
end;
function u11.buffer(p398) --[[ Line: 578 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v399 = buffer.len(p398);
    local v400 = u300 + (2 + v399);
    if u299 < v400 then
        while u299 < v400 do
            u299 = u299 * 2;
        end;
        local v401 = buffer.create(u299);
        buffer.copy(v401, 0, u301, 0, u300);
        u298.Buffer = v401;
        u301 = v401;
    end;
    buffer.writeu8(u301, u300, 12);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, v399);
    u300 = u300 + 1;
    buffer.copy(u301, u300, p398);
    u300 = u300 + buffer.len(p398);
end;
u10[13] = function() --[[ Line: 580 ]]
    -- upvalues: u297 (ref), u296 (ref)
    u297 = u297 + 1;
    return u296[u297];
end;
function u11.Instance(p402) --[[ Line: 581 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref), u297 (ref), u296 (ref)
    local v403 = u300 + 1;
    if u299 < v403 then
        while u299 < v403 do
            u299 = u299 * 2;
        end;
        local v404 = buffer.create(u299);
        buffer.copy(v404, 0, u301, 0, u300);
        u298.Buffer = v404;
        u301 = v404;
    end;
    buffer.writeu8(u301, u300, 13);
    u300 = u300 + 1;
    u297 = u297 + 1;
    u296[u297] = p402;
end;
u10[14] = function() --[[ Line: 583 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v405 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    return v405 == 1;
end;
function u11.boolean(p406) --[[ Line: 584 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v407 = u300 + 2;
    if u299 < v407 then
        while u299 < v407 do
            u299 = u299 * 2;
        end;
        local v408 = buffer.create(u299);
        buffer.copy(v408, 0, u301, 0, u300);
        u298.Buffer = v408;
        u301 = v408;
    end;
    buffer.writeu8(u301, u300, 14);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, p406 and 1 or 0);
    u300 = u300 + 1;
end;
u10[15] = function() --[[ Line: 586 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__new__21 = NumberRange.new;
    local v409 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v410 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    return l__new__21(v409, v410);
end;
function u11.NumberRange(p411) --[[ Line: 587 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v412 = u300 + 9;
    if u299 < v412 then
        while u299 < v412 do
            u299 = u299 * 2;
        end;
        local v413 = buffer.create(u299);
        buffer.copy(v413, 0, u301, 0, u300);
        u298.Buffer = v413;
        u301 = v413;
    end;
    buffer.writeu8(u301, u300, 15);
    u300 = u300 + 1;
    buffer.writef32(u301, u300, p411.Min);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p411.Max);
    u300 = u300 + 4;
end;
u10[16] = function() --[[ Line: 589 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__new__22 = BrickColor.new;
    local v414 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    return l__new__22(v414);
end;
function u11.BrickColor(p415) --[[ Line: 590 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v416 = u300 + 3;
    if u299 < v416 then
        while u299 < v416 do
            u299 = u299 * 2;
        end;
        local v417 = buffer.create(u299);
        buffer.copy(v417, 0, u301, 0, u300);
        u298.Buffer = v417;
        u301 = v417;
    end;
    buffer.writeu8(u301, u300, 16);
    u300 = u300 + 1;
    buffer.writeu16(u301, u300, p415.Number);
    u300 = u300 + 2;
end;
u10[17] = function() --[[ Line: 592 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__fromRGB__23 = Color3.fromRGB;
    local v418 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v419 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v420 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    return l__fromRGB__23(v418, v419, v420);
end;
function u11.Color3(p421) --[[ Line: 593 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v422 = u300 + 4;
    if u299 < v422 then
        while u299 < v422 do
            u299 = u299 * 2;
        end;
        local v423 = buffer.create(u299);
        buffer.copy(v423, 0, u301, 0, u300);
        u298.Buffer = v423;
        u301 = v423;
    end;
    buffer.writeu8(u301, u300, 17);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, p421.R * 255 + 0.5);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, p421.G * 255 + 0.5);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, p421.B * 255 + 0.5);
    u300 = u300 + 1;
end;
u10[18] = function() --[[ Line: 595 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__new__24 = UDim.new;
    local v424 = buffer.readi16(u301, u300);
    u300 = u300 + 2;
    local v425 = v424 / 1000;
    local v426 = buffer.readi16(u301, u300);
    u300 = u300 + 2;
    return l__new__24(v425, v426);
end;
function u11.UDim(p427) --[[ Line: 596 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v428 = u300 + 5;
    if u299 < v428 then
        while u299 < v428 do
            u299 = u299 * 2;
        end;
        local v429 = buffer.create(u299);
        buffer.copy(v429, 0, u301, 0, u300);
        u298.Buffer = v429;
        u301 = v429;
    end;
    buffer.writeu8(u301, u300, 18);
    u300 = u300 + 1;
    buffer.writei16(u301, u300, p427.Scale * 1000);
    u300 = u300 + 2;
    buffer.writei16(u301, u300, p427.Offset);
    u300 = u300 + 2;
end;
u10[19] = function() --[[ Line: 598 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__new__25 = UDim2.new;
    local v430 = buffer.readi16(u301, u300);
    u300 = u300 + 2;
    local v431 = v430 / 1000;
    local v432 = buffer.readi16(u301, u300);
    u300 = u300 + 2;
    local v433 = buffer.readi16(u301, u300);
    u300 = u300 + 2;
    local v434 = v433 / 1000;
    local v435 = buffer.readi16(u301, u300);
    u300 = u300 + 2;
    return l__new__25(v431, v432, v434, v435);
end;
function u11.UDim2(p436) --[[ Line: 599 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v437 = u300 + 9;
    if u299 < v437 then
        while u299 < v437 do
            u299 = u299 * 2;
        end;
        local v438 = buffer.create(u299);
        buffer.copy(v438, 0, u301, 0, u300);
        u298.Buffer = v438;
        u301 = v438;
    end;
    buffer.writeu8(u301, u300, 19);
    u300 = u300 + 1;
    buffer.writei16(u301, u300, p436.X.Scale * 1000);
    u300 = u300 + 2;
    buffer.writei16(u301, u300, p436.X.Offset);
    u300 = u300 + 2;
    buffer.writei16(u301, u300, p436.Y.Scale * 1000);
    u300 = u300 + 2;
    buffer.writei16(u301, u300, p436.Y.Offset);
    u300 = u300 + 2;
end;
u10[20] = function() --[[ Line: 601 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__new__26 = Rect.new;
    local v439 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v440 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v441 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v442 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    return l__new__26(v439, v440, v441, v442);
end;
function u11.Rect(p443) --[[ Line: 602 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v444 = u300 + 17;
    if u299 < v444 then
        while u299 < v444 do
            u299 = u299 * 2;
        end;
        local v445 = buffer.create(u299);
        buffer.copy(v445, 0, u301, 0, u300);
        u298.Buffer = v445;
        u301 = v445;
    end;
    buffer.writeu8(u301, u300, 20);
    u300 = u300 + 1;
    buffer.writef32(u301, u300, p443.Min.X);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p443.Min.Y);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p443.Max.X);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p443.Max.Y);
    u300 = u300 + 4;
end;
u10[21] = function() --[[ Line: 604 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__new__27 = Vector2.new;
    local v446 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v447 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    return l__new__27(v446, v447);
end;
function u11.Vector2(p448) --[[ Line: 605 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v449 = u300 + 9;
    if u299 < v449 then
        while u299 < v449 do
            u299 = u299 * 2;
        end;
        local v450 = buffer.create(u299);
        buffer.copy(v450, 0, u301, 0, u300);
        u298.Buffer = v450;
        u301 = v450;
    end;
    buffer.writeu8(u301, u300, 21);
    u300 = u300 + 1;
    buffer.writef32(u301, u300, p448.X);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p448.Y);
    u300 = u300 + 4;
end;
u10[22] = function() --[[ Line: 607 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v451 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v452 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v453 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    return Vector3.new(v451, v452, v453);
end;
function u11.Vector3(p454) --[[ Line: 608 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v455 = u300 + 13;
    if u299 < v455 then
        while u299 < v455 do
            u299 = u299 * 2;
        end;
        local v456 = buffer.create(u299);
        buffer.copy(v456, 0, u301, 0, u300);
        u298.Buffer = v456;
        u301 = v456;
    end;
    buffer.writeu8(u301, u300, 22);
    u300 = u300 + 1;
    buffer.writef32(u301, u300, p454.X);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p454.Y);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p454.Z);
    u300 = u300 + 4;
end;
u10[23] = function() --[[ Line: 610 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__fromEulerAnglesXYZ__28 = CFrame.fromEulerAnglesXYZ;
    local v457 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    local v458 = v457 / 10430.219195527361;
    local v459 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    local v460 = v459 / 10430.219195527361;
    local v461 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    local v462 = l__fromEulerAnglesXYZ__28(v458, v460, v461 / 10430.219195527361);
    local v463 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v464 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v465 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    return v462 + Vector3.new(v463, v464, v465);
end;
function u11.CFrame(p466) --[[ Line: 614 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v467, v468, v469 = p466:ToEulerAnglesXYZ();
    local v470 = u300 + 19;
    if u299 < v470 then
        while u299 < v470 do
            u299 = u299 * 2;
        end;
        local v471 = buffer.create(u299);
        buffer.copy(v471, 0, u301, 0, u300);
        u298.Buffer = v471;
        u301 = v471;
    end;
    buffer.writeu8(u301, u300, 23);
    u300 = u300 + 1;
    buffer.writeu16(u301, u300, v467 * 10430.219195527361 + 0.5);
    u300 = u300 + 2;
    buffer.writeu16(u301, u300, v468 * 10430.219195527361 + 0.5);
    u300 = u300 + 2;
    buffer.writeu16(u301, u300, v469 * 10430.219195527361 + 0.5);
    u300 = u300 + 2;
    buffer.writef32(u301, u300, p466.X);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p466.Y);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, p466.Z);
    u300 = u300 + 4;
end;
u10[24] = function() --[[ Line: 622 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local l__new__29 = Region3.new;
    local v472 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v473 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v474 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v475 = Vector3.new(v472, v473, v474);
    local v476 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v477 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    local v478 = buffer.readf32(u301, u300);
    u300 = u300 + 4;
    return l__new__29(v475, (Vector3.new(v476, v477, v478)));
end;
function u11.Region3(p479) --[[ Line: 628 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v480 = p479.Size / 2;
    local v481 = p479.CFrame.Position - v480;
    local v482 = p479.CFrame.Position + v480;
    local v483 = u300 + 25;
    if u299 < v483 then
        while u299 < v483 do
            u299 = u299 * 2;
        end;
        local v484 = buffer.create(u299);
        buffer.copy(v484, 0, u301, 0, u300);
        u298.Buffer = v484;
        u301 = v484;
    end;
    buffer.writeu8(u301, u300, 24);
    u300 = u300 + 1;
    buffer.writef32(u301, u300, v481.X);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, v481.Y);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, v481.Z);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, v482.X);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, v482.Y);
    u300 = u300 + 4;
    buffer.writef32(u301, u300, v482.Z);
    u300 = u300 + 4;
end;
u10[25] = function() --[[ Line: 638 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v485 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v486 = table.create(v485);
    for _ = 1, v485 do
        local l__new__30 = NumberSequenceKeypoint.new;
        local v487 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        local v488 = v487 / 255;
        local v489 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        local v490 = v489 / 255;
        local v491 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        table.insert(v486, l__new__30(v488, v490, v491 / 255));
    end;
    return NumberSequence.new(v486);
end;
function u11.NumberSequence(p492) --[[ Line: 646 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v493 = #p492.Keypoints;
    local v494 = u300 + (v493 * 3 + 2);
    if u299 < v494 then
        while u299 < v494 do
            u299 = u299 * 2;
        end;
        local v495 = buffer.create(u299);
        buffer.copy(v495, 0, u301, 0, u300);
        u298.Buffer = v495;
        u301 = v495;
    end;
    buffer.writeu8(u301, u300, 25);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, v493);
    u300 = u300 + 1;
    for _, v496 in p492.Keypoints do
        buffer.writeu8(u301, u300, v496.Time * 255 + 0.5);
        u300 = u300 + 1;
        buffer.writeu8(u301, u300, v496.Value * 255 + 0.5);
        u300 = u300 + 1;
        buffer.writeu8(u301, u300, v496.Envelope * 255 + 0.5);
        u300 = u300 + 1;
    end;
end;
u10[26] = function() --[[ Line: 656 ]]
    -- upvalues: u301 (ref), u300 (ref)
    local v497 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v498 = table.create(v497);
    for _ = 1, v497 do
        local l__new__31 = ColorSequenceKeypoint.new;
        local v499 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        local v500 = v499 / 255;
        local l__fromRGB__32 = Color3.fromRGB;
        local v501 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        local v502 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        local v503 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        table.insert(v498, l__new__31(v500, l__fromRGB__32(v501, v502, v503)));
    end;
    return ColorSequence.new(v498);
end;
function u11.ColorSequence(p504) --[[ Line: 664 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref)
    local v505 = #p504.Keypoints;
    local v506 = u300 + (v505 * 4 + 2);
    if u299 < v506 then
        while u299 < v506 do
            u299 = u299 * 2;
        end;
        local v507 = buffer.create(u299);
        buffer.copy(v507, 0, u301, 0, u300);
        u298.Buffer = v507;
        u301 = v507;
    end;
    buffer.writeu8(u301, u300, 26);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, v505);
    u300 = u300 + 1;
    for _, v508 in p504.Keypoints do
        buffer.writeu8(u301, u300, v508.Time * 255 + 0.5);
        u300 = u300 + 1;
        buffer.writeu8(u301, u300, v508.Value.R * 255 + 0.5);
        u300 = u300 + 1;
        buffer.writeu8(u301, u300, v508.Value.G * 255 + 0.5);
        u300 = u300 + 1;
        buffer.writeu8(u301, u300, v508.Value.B * 255 + 0.5);
        u300 = u300 + 1;
    end;
end;
u10[27] = function() --[[ Line: 675 ]]
    -- upvalues: l__Enums__17 (copy), u301 (ref), u300 (ref)
    local v509 = l__Enums__17;
    local v510 = buffer.readu8(u301, u300);
    u300 = u300 + 1;
    local v511 = v509[v510];
    local v512 = buffer.readu16(u301, u300);
    u300 = u300 + 2;
    return v511:FromValue(v512);
end;
function u11.EnumItem(p513) --[[ Line: 678 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref), u319 (copy)
    local v514 = u300 + 4;
    if u299 < v514 then
        while u299 < v514 do
            u299 = u299 * 2;
        end;
        local v515 = buffer.create(u299);
        buffer.copy(v515, 0, u301, 0, u300);
        u298.Buffer = v515;
        u301 = v515;
    end;
    buffer.writeu8(u301, u300, 27);
    u300 = u300 + 1;
    buffer.writeu8(u301, u300, u319[p513.EnumType]);
    u300 = u300 + 1;
    buffer.writeu16(u301, u300, p513.Value);
    u300 = u300 + 2;
end;
u10[28] = function() --[[ Line: 685 ]]
    -- upvalues: u301 (ref), u300 (ref), u10 (copy)
    local v516 = {};
    while true do
        local v517 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        if v517 == 0 then
            break;
        end;
        local v518 = u10[v517]();
        local v519 = u10;
        local v520 = buffer.readu8(u301, u300);
        u300 = u300 + 1;
        v516[v518] = v519[v520]();
    end;
    return v516;
end;
function u11.table(p521) --[[ Line: 692 ]]
    -- upvalues: u300 (ref), u299 (ref), u301 (ref), u298 (ref), u11 (copy)
    local v522 = u300 + 1;
    if u299 < v522 then
        while u299 < v522 do
            u299 = u299 * 2;
        end;
        local v523 = buffer.create(u299);
        buffer.copy(v523, 0, u301, 0, u300);
        u298.Buffer = v523;
        u301 = v523;
    end;
    buffer.writeu8(u301, u300, 28);
    u300 = u300 + 1;
    for v524, v525 in p521 do
        u11[typeof(v524)](v524);
        u11[typeof(v525)](v525);
    end;
    local v526 = u300 + 1;
    if u299 < v526 then
        while u299 < v526 do
            u299 = u299 * 2;
        end;
        local v527 = buffer.create(u299);
        buffer.copy(v527, 0, u301, 0, u300);
        u298.Buffer = v527;
        u301 = v527;
    end;
    buffer.writeu8(u301, u300, 0);
    u300 = u300 + 1;
end;
return {
    Import = function(p528) --[[ Name: Import, Line 702 ]]
        -- upvalues: u298 (ref), u301 (ref), u299 (ref), u300 (ref), u296 (ref), u297 (ref)
        u298 = p528;
        u301 = p528.Buffer;
        u299 = p528.BufferLength;
        u300 = p528.BufferOffset;
        u296 = p528.Instances;
        u297 = p528.InstancesOffset;
    end,
    Export = function() --[[ Name: Export, Line 711 ]]
        -- upvalues: u298 (ref), u299 (ref), u300 (ref), u297 (ref)
        u298.BufferLength = u299;
        u298.BufferOffset = u300;
        u298.InstancesOffset = u297;
        return u298;
    end,
    Truncate = function() --[[ Name: Truncate, Line 718 ]]
        -- upvalues: u300 (ref), u301 (ref), u297 (ref), u296 (ref)
        local v529 = buffer.create(u300);
        buffer.copy(v529, 0, u301, 0, u300);
        if u297 == 0 then
            return v529;
        else
            return v529, u296;
        end;
    end,
    Ended = function() --[[ Name: Ended, Line 724 ]]
        -- upvalues: u300 (ref), u299 (ref)
        return u299 <= u300;
    end,
    Types = v7,
    Reads = v8,
    Writes = v9
};