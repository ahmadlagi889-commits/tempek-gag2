-- Decompiled with Potassium's decompiler.

local u1 = {
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    "　",
    " ",
    "\r\n",
    "\t",
    "\n",
    "\11",
    "\f",
    "\r",
    " "
};
local v2 = {};
local u3 = {
    " ",
    " ",
    "\r\n",
    "\r",
    "\n"
};
for _, v4 in ipairs(u1) do
    v2[v4] = true;
end;
local u5 = {};
for _, v6 in ipairs(u3) do
    u5[v6] = true;
end;
local u7 = {
    ["0"] = "\0",
    ["\'"] = "\'",
    ["\""] = "\"",
    ["\\"] = "\\",
    b = "\8",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t",
    v = "\11"
};
local function u10(p8, p9) --[[ Line: 98 ]]
    return string.format("%s at line %d col %d", p8, p9[1], p9[2]);
end;
local function u15(p11, p12) --[[ Line: 122 ]]
    -- upvalues: u3 (copy), u5 (copy)
    for _, v13 in ipairs(u3) do
        if p11:sub(1, #v13) == v13 then
            local v14;
            if u5[v13] then
                p12[1] = p12[1] + 1;
                p12[2] = 1;
                v14 = true;
            else
                v14 = false;
            end;
            if v14 then
                return v13;
            end;
        end;
    end;
    return nil;
end;
local function u19(p16, p17) --[[ Line: 137 ]]
    -- upvalues: u1 (copy), u5 (copy)
    if #p16 == 0 then
        return nil;
    end;
    for _, v18 in ipairs(u1) do
        if p16:sub(1, #v18) == v18 then
            p17[2] = p17[2] + #v18;
            if not u5[v18] then
                return v18;
            end;
            p17[1] = p17[1] + 1;
            p17[2] = 1;
            return v18;
        end;
    end;
    return nil;
end;
local function u23(p20, p21) --[[ Line: 158 ]]
    -- upvalues: u19 (copy)
    while true do
        local v22 = u19(p20, p21);
        if v22 == nil then
            break;
        end;
        p20 = p20:sub(#v22 + 1);
    end;
    return p20;
end;
local function u27(p24, p25) --[[ Line: 178 ]]
    -- upvalues: u15 (copy)
    while #p24 ~= 0 do
        local v26 = u15(p24, p25);
        if v26 then
            return p24:sub(#v26 + 1);
        end;
        p24 = p24:sub(2);
        p25[2] = p25[2] + 1;
    end;
    return p24;
end;
local function u31(p28, p29) --[[ Line: 205 ]]
    -- upvalues: u15 (copy), u10 (copy)
    while #p28 > 0 do
        if p28:sub(1, 2) == "*/" then
            p29[2] = p29[2] + 2;
            return p28:sub(3);
        end;
        local v30 = u15(p28, p29);
        if v30 then
            p28 = p28:sub(#v30 + 1);
        else
            p29[2] = p29[2] + 1;
            p28 = p28:sub(2);
        end;
    end;
    error(u10("missing multiline comment close tag", p29));
    return "";
end;
local function u39(p32) --[[ Line: 232 ]]
    if p32 <= 127 then
        return string.char(p32);
    end;
    if p32 <= 2047 then
        local v33 = math.floor(p32 / 64) + 192;
        return string.char(v33, p32 % 64 + 128);
    end;
    if p32 <= 65535 then
        local v34 = math.floor(p32 / 4096) + 224;
        local v35 = math.floor(p32 % 4096 / 64) + 128;
        return string.char(v34, v35, p32 % 64 + 128);
    end;
    if p32 > 1114111 then
        return nil, string.format("invalid unicode codepoint \'%x\'", p32);
    end;
    local v36 = math.floor(p32 / 262144) + 240;
    local v37 = math.floor(p32 % 262144 / 4096) + 128;
    local v38 = math.floor(p32 % 4096 / 64) + 128;
    return string.char(v36, v37, v38, p32 % 64 + 128);
end;
local function u44(p40, p41) --[[ Line: 257 ]]
    -- upvalues: u10 (copy)
    local v42 = p40:match("^\\u(%x%x%x%x)");
    if not v42 then
        error(u10("invalid unicode hex escape sequence", p41));
    end;
    local v43 = tonumber(v42, 16);
    if not v43 then
        error(u10("invalid unicode hex escape sequence", p41));
    end;
    p41[2] = p41[2] + 6;
    return v43, p40:sub(7);
end;
local function u54(p45, p46) --[[ Line: 283 ]]
    -- upvalues: u44 (copy), u39 (copy), u10 (copy)
    local v47 = p46[1];
    local v48 = p46[2];
    local v49, v50 = u44(p45, p46);
    if v49 >= 55296 and v49 < 56320 then
        local v51;
        v51, v50 = u44(v50, p46);
        if v51 and (v51 >= 56320 and v51 <= 57343) then
            v49 = (v49 - 55296) * 1024 + (v51 - 56320) + 65536;
        end;
    end;
    local v52, v53 = u39(v49);
    if not v52 then
        error(u10(assert(v53), { v47, v48 }));
    end;
    return v52, v50;
end;
local function u66(p55, p56, p57, p58) --[[ Line: 316 ]]
    -- upvalues: u7 (copy), u10 (copy), u54 (copy), u15 (copy)
    local v59 = {};
    while not p56(p55) do
        local v60 = p55:sub(1, 1);
        if v60 == "\\" then
            local v61 = p55:sub(2, 2);
            p58[2] = p58[2] + 1;
            if u7[v61] then
                p58[2] = p58[2] + 1;
                if p57 then
                    error(u10("escape sequence not allowed", p58));
                end;
                v59[#v59 + 1] = u7[v61];
                p55 = p55:sub(3);
            elseif v61 == "u" then
                local v62;
                v62, p55 = u54(p55, p58);
                v59[#v59 + 1] = v62;
            elseif v61 == "x" then
                if p57 then
                    error(u10("hex escape sequence not allowed", p58));
                end;
                p58[2] = p58[2] + 2;
                local v63 = p55:sub(2, 3);
                local v64 = tonumber(v63, 16);
                if not v64 then
                    error(u10("invalid hex escape sequence", p58));
                end;
                v59[#v59 + 1] = string.char(v64);
                p58[2] = p58[2] + 2;
                p55 = p55:sub(5);
            else
                if p57 then
                    error(u10("invalid escape sequence", p58));
                end;
                local v65 = u15(p55:sub(2), p58);
                p55 = p55:sub(not v65 and 2 or #v65 + 2);
            end;
        elseif v60:byte(1, 1) < 32 then
            error(u10("control character found", p58));
        else
            v59[#v59 + 1] = v60;
            p55 = p55:sub(2);
            p58[2] = p58[2] + 1;
        end;
    end;
    return table.concat(v59), p55;
end;
local function u73(p67, p68) --[[ Line: 395 ]]
    -- upvalues: u66 (copy)
    local u69 = p67:sub(1, 1);
    local v71, v72 = u66(p67:sub(2), function(p70) --[[ Name: stopCriterion, Line 403 ]]
        -- upvalues: u69 (copy)
        return p70:sub(1, 1) == u69;
    end, false, p68);
    p68[2] = p68[2] + 1;
    return v71, v72:sub(2);
end;
local function v85(p74, p75) --[[ Line: 416 ]]
    -- upvalues: u19 (copy), u10 (copy)
    local v76 = 1;
    local v77 = p74:sub(1, 1);
    local v78 = p75[1];
    local v79 = p75[2];
    if v77 == "+" then
        p74 = p74:sub(2);
        p75[2] = p75[2] + 1;
        v76 = 1;
    elseif v77 == "-" then
        p74 = p74:sub(2);
        p75[2] = p75[2] + 1;
        v76 = -1;
    end;
    if p74:sub(1, 3) == "NaN" then
        p75[2] = p75[2] + 3;
        return (0 / 0), p74:sub(4);
    end;
    if p74:find("Infinity", 1, true) == 1 then
        p75[2] = p75[2] + 8;
        return (1 / 0) * v76, p74:sub(9);
    end;
    local v80 = p74;
    local v81 = 0;
    while not u19(p74, p75) do
        local v82 = p74:sub(1, 1);
        if v82 == "" or (v82 == "," or (v82 == "]" or v82 == "}")) then
            break;
        end;
        v81 = v81 + 1;
        p74 = p74:sub(2);
        p75[2] = p75[2] + 1;
    end;
    local v83 = v80:sub(1, v81);
    local v84;
    if v83:sub(1, 1) == "0" and v83:sub(2):find("^%d+$") then
        v84 = nil;
    else
        v84 = tonumber(v83);
    end;
    if v84 == nil then
        error(u10("invalid number sequence " .. string.format("%q", v83):gsub("\r", "\\r"):gsub("\n", "\\n"), { v78, v79 }));
    end;
    p75[2] = p75[2] + v81;
    return v84 * v76, v80:sub(v81 + 1);
end;
local function v88(p86, p87) --[[ Line: 501 ]]
    -- upvalues: u10 (copy)
    if p86:sub(1, 4) == "true" then
        p87[2] = p87[2] + 4;
        return true, p86:sub(5);
    end;
    if p86:sub(1, 5) == "false" then
        p87[2] = p87[2] + 5;
        return false, p86:sub(6);
    end;
    error(u10("invalid boolean literal", p87));
end;
local function u92(p89, p90) --[[ Line: 518 ]]
    -- upvalues: u27 (copy), u31 (copy)
    local v91 = p89:sub(1, 2);
    if v91 == "//" then
        p90[2] = p90[2] + 2;
        return u27(p89:sub(3), p90);
    end;
    if v91 ~= "/*" then
        return p89;
    end;
    p90[2] = p90[2] + 2;
    return u31(p89:sub(3), p90);
end;
local function u96(p93, p94) --[[ Line: 536 ]]
    -- upvalues: u23 (copy), u92 (copy)
    while true do
        local v95 = u92(u23(p93, p94), p94);
        if v95 == p93 then
            break;
        end;
        p93 = v95;
    end;
    return p93;
end;
local u97 = nil;
local function u102(p98) --[[ Line: 610 ]]
    local v99 = p98:byte(1, 1);
    if v99 >= 48 and v99 <= 57 then
        return false;
    end;
    for v100 = 1, #p98 do
        local v101 = p98:byte(v100, v100);
        if v101 < 36 then
            return false;
        end;
        if v101 >= 37 and v101 <= 47 then
            return false;
        end;
        if v101 >= 58 and v101 <= 64 then
            return false;
        end;
        if v101 >= 91 and v101 <= 94 then
            return false;
        end;
        if v101 == 96 then
            return false;
        end;
        if v101 >= 123 and v101 <= 128 then
            return false;
        end;
    end;
    return true;
end;
local function u104(p103) --[[ Line: 649 ]]
    -- upvalues: u19 (copy)
    return p103:sub(1, 1) == ":" and true or u19(p103, { 0, 0 }) ~= nil;
end;
local function u112(p105, p106) --[[ Line: 657 ]]
    -- upvalues: u73 (copy), u66 (copy), u104 (copy), u102 (copy), u10 (copy)
    local v107 = p105:sub(1, 1);
    local v108, v109;
    if v107 == "\'" or v107 == "\"" then
        v108, v109 = u73(p105, p106);
    else
        local v110 = p106[1];
        local v111 = p106[2];
        v108, v109 = u66(p105, u104, true, p106);
        if not u102(v108) then
            error(u10("invalid identifier " .. string.format("%q", v108):gsub("\r", "\\r"):gsub("\n", "\\n"), { v110, v111 }));
        end;
    end;
    return v108, v109;
end;
local u143 = {
    ["-"] = v85,
    ["+"] = v85,
    ["."] = v85,
    ["0"] = v85,
    ["1"] = v85,
    ["2"] = v85,
    ["3"] = v85,
    ["4"] = v85,
    ["5"] = v85,
    ["6"] = v85,
    ["7"] = v85,
    ["8"] = v85,
    ["9"] = v85,
    N = v85,
    I = v85,
    n = function(p113, p114, p115) --[[ Name: parseNull, Line 486 ]]
        -- upvalues: u10 (copy)
        if p113:sub(1, 4) ~= "null" then
            error(u10("invalid null literal", p114));
        end;
        p114[2] = p114[2] + 1;
        return p115, p113:sub(5);
    end,
    t = v88,
    f = v88,
    ["\'"] = u73,
    ["\""] = u73,
    ["["] = function(p116, p117, p118) --[[ Name: parseArray, Line 564 ]]
        -- upvalues: u96 (copy), u97 (ref), u10 (copy)
        local v119 = p116:sub(2);
        p117[2] = p117[2] + 1;
        local v120 = {};
        while true do
            local v121 = u96(v119, p117);
            if v121:sub(1, 1) == "]" then
                p117[2] = p117[2] + 1;
                v119 = v121:sub(2);
                break;
            end;
            local v122, v123 = u97(v121, p117, p118);
            local v124 = u96(v123, p117);
            v120[#v120 + 1] = v122;
            local v125 = v124:sub(1, 1);
            v119 = v124:sub(2);
            if v125 == "]" then
                p117[2] = p117[2] + 1;
                break;
            end;
            if v125 ~= "," then
                error(u10("expected comma got " .. string.format("%q", v125):gsub("\r", "\\r"):gsub("\n", "\\n"), p117));
            end;
            p117[2] = p117[2] + 1;
        end;
        return v120, v119;
    end,
    ["{"] = function(p126, p127, p128) --[[ Name: parseObject, Line 685 ]]
        -- upvalues: u96 (copy), u112 (copy), u10 (copy), u97 (ref)
        p127[2] = p127[2] + 1;
        local v129 = p126:sub(2);
        local v130 = {};
        while true do
            local v131 = u96(v129, p127);
            if v131:sub(1, 1) == "}" then
                p127[2] = p127[2] + 1;
                v129 = v131:sub(2);
                break;
            end;
            local v132, v133 = u112(v131, p127);
            local v134 = u96(v133, p127);
            if v134:sub(1, 1) ~= ":" then
                local v135 = error;
                local v136 = u10;
                local v137 = v134:sub(1, 1);
                v135(v136("expected colon after identifier, got " .. string.format("%q", v137):gsub("\r", "\\r"):gsub("\n", "\\n"), p127));
            end;
            p127[2] = p127[2] + 1;
            local v138, v139 = u97(u96(v134:sub(2), p127), p127, p128);
            local v140 = u96(v139, p127);
            v130[v132] = v138;
            local v141 = v140:sub(1, 1);
            v129 = v140:sub(2);
            if v141 == "}" then
                p127[2] = p127[2] + 1;
                break;
            end;
            if v141 ~= "," then
                error(u10("expected comma got " .. string.format("%q", v141):gsub("\r", "\\r"):gsub("\n", "\\n"), p127));
            end;
            p127[2] = p127[2] + 1;
        end;
        return v130, v129;
    end,
    [""] = function(_, p142) --[[ Name: catchEOF, Line 752 ]]
        -- upvalues: u10 (copy)
        error(u10("unexpected eof", p142));
    end
};
u97 = function(p144, p145, p146) --[[ Line: 786 ]]
    -- upvalues: u96 (copy), u143 (copy), u10 (copy)
    local v147 = u96(p144, p145);
    local v148 = v147:sub(1, 1);
    local v149 = u143[v148];
    if not v149 then
        error(u10("invalid value literal " .. string.format("%q", v148):gsub("\r", "\\r"):gsub("\n", "\\n"), p145));
    end;
    return v149(v147, p145, p146);
end;
local v155 = {
    Null = newproxy(false),
    Decode = function(p150, p151) --[[ Name: Decode, Line 821 ]]
        -- upvalues: u96 (copy), u97 (ref), u10 (copy)
        local v152 = { 1, 1 };
        local v153, v154 = u97(u96(p150, v152), v152, p151);
        if #u96(v154, v152) > 0 then
            error(u10("trailing garbage", v152));
        end;
        return v153;
    end
};
return table.freeze(v155);