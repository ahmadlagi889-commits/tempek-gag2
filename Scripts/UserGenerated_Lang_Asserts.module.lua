-- Decompiled with Potassium's decompiler.

local function u11(p1) --[[ Line: 90 ]]
    if type(p1) == "number" or type(p1) == "boolean" then
        return `{p1}`;
    end;
    if type(p1) ~= "string" then
        if typeof(p1) == "Instance" then
            return p1:GetFullName();
        else
            return `UnknownType({typeof(p1)})`;
        end;
    end;
    local v2 = utf8.len(p1);
    if not v2 then
        return "InvalidUTF8";
    end;
    local v3, v4, v5, v6, v7, v8;
    for v9 = 1, string.len(p1) do
        local v10 = string.byte(p1, v9);
        if v10 < 32 or v10 > 126 then
            v3 = false;
            if not v3 then
                return "NonASCII";
            end;
            if v2 <= 30 then
                v4, v5 = string.format("%q", p1):gsub("\n", "n");
                return v4;
            end;
            v6 = string.sub(p1, 1, 30);
            v7, v8 = string.format("%q", v6):gsub("\n", "n");
            return `{v7}...{v2 - 30}`;
        end;
    end;
    v3 = true;
    if not v3 then
        return "NonASCII";
    end;
    if v2 <= 30 then
        v4, v5 = string.format("%q", p1):gsub("\n", "n");
        return v4;
    end;
    v6 = string.sub(p1, 1, 30);
    v7, v8 = string.format("%q", v6):gsub("\n", "n");
    return `{v7}...{v2 - 30}`;
end;
local u33 = {
    IsCFrameFinite = function(p12) --[[ Name: IsCFrameFinite, Line 59 ]]
        local v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 = p12:GetComponents();
        local v25 = v13 + v14 + v15 + v16 + v17 + v18 + v19 + v20 + v21 + v22 + v23 + v24;
        local v26;
        if v25 == v25 and v25 ~= (1 / 0) then
            v26 = v25 ~= (-1 / 0);
        else
            v26 = false;
        end;
        return v26;
    end,
    IsVector2Finite = function(p27) --[[ Name: IsVector2Finite, Line 67 ]]
        local v28 = p27.X + p27.Y;
        local v29;
        if v28 == v28 and v28 ~= (1 / 0) then
            v29 = v28 ~= (-1 / 0);
        else
            v29 = false;
        end;
        return v29;
    end,
    IsVector3Finite = function(p30) --[[ Name: IsVector3Finite, Line 71 ]]
        local v31 = p30.X + p30.Y + p30.Z;
        local v32;
        if v31 == v31 and v31 ~= (1 / 0) then
            v32 = v31 ~= (-1 / 0);
        else
            v32 = false;
        end;
        return v32;
    end
};
function u33.Array(u34) --[[ Line: 145 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.Function(u34);
    return function(p35) --[[ Line: 149 ]]
        -- upvalues: u11 (ref), u34 (copy)
        if type(p35) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p35) ~= nil then
            error("metatable", 2);
        end;
        local v36 = rawlen(p35);
        local v37 = 0;
        for v38, v39 in pairs(p35) do
            v37 = v37 + 1;
            if v38 ~= v37 then
                error(`IndexMismatch ${`[{u11(v38)}]`}`, 2);
            end;
            if v36 < v37 then
                error(`IndexOverflow ${`[{v37}]`}`, 2);
            end;
            local v40, v41 = pcall(u34, v39);
            if not v40 then
                local v42 = tostring(v41);
                local v43, v44 = string.match(v42, "^(.*:%d+): (.+)$");
                if v43 then
                    v42 = v44 or v42;
                end;
                local v45, v46 = string.match(v42, "^(.+) $(%[.+)$");
                if v45 then
                    if not v46 then
                        v45 = v42;
                    end;
                else
                    v45 = v42;
                end;
                error(`{v45} ${`[{v37}]{v46 or ""}`}`, 2);
            end;
        end;
        if v36 ~= v37 then
            error("LengthMismatch", 2);
        end;
        return p35;
    end;
end;
function u33.ArrayCoerce(u47) --[[ Line: 179 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.Function(u47);
    return function(p48) --[[ Line: 183 ]]
        -- upvalues: u11 (ref), u47 (copy)
        if type(p48) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p48) ~= nil then
            error("metatable", 2);
        end;
        local v49 = rawlen(p48);
        local v50 = 0;
        local v51 = {};
        for v52, v53 in pairs(p48) do
            v50 = v50 + 1;
            if v52 ~= v50 then
                error(`IndexMismatch ${`[{u11(v52)}]`}`, 2);
            end;
            if v49 < v50 then
                error(`IndexOverflow ${`[{v50}]`}`, 2);
            end;
            local v54, v55 = pcall(u47, v53);
            if not v54 then
                local v56 = tostring(v55);
                local v57, v58 = string.match(v56, "^(.*:%d+): (.+)$");
                if v57 then
                    v56 = v58 or v56;
                end;
                local v59, v60 = string.match(v56, "^(.+) $(%[.+)$");
                if v59 then
                    if not v60 then
                        v59 = v56;
                    end;
                else
                    v59 = v56;
                end;
                error(`{v59} ${`[{v50}]{v60 or ""}`}`, 2);
            end;
            v51[v52] = v55;
        end;
        if v49 ~= v50 then
            error("LengthMismatch", 2);
        end;
        return v51;
    end;
end;
function u33.UniqueArray(u61) --[[ Line: 215 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.Function(u61);
    return function(p62) --[[ Line: 219 ]]
        -- upvalues: u11 (ref), u61 (copy)
        if type(p62) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p62) ~= nil then
            error("metatable", 2);
        end;
        local v63 = rawlen(p62);
        local v64 = 0;
        local v65 = {};
        for v66, v67 in pairs(p62) do
            v64 = v64 + 1;
            if v66 ~= v64 then
                error(`IndexMismatch ${`[{u11(v66)}]`}`, 2);
            end;
            if v63 < v64 then
                error(`IndexOverflow ${`[{v64}]`}`, 2);
            end;
            if v65[v67] then
                error(`UniqueArray ${`[{v64}]`}`, 2);
            end;
            v65[v67] = true;
            if not v65[v67] then
                error(`InvalidKey ${`[{v64}]`}`, 2);
            end;
            local v68, v69 = pcall(u61, v67);
            if not v68 then
                local v70 = tostring(v69);
                local v71, v72 = string.match(v70, "^(.*:%d+): (.+)$");
                if v71 then
                    v70 = v72 or v70;
                end;
                local v73, v74 = string.match(v70, "^(.+) $(%[.+)$");
                if v73 then
                    if not v74 then
                        v73 = v70;
                    end;
                else
                    v73 = v70;
                end;
                error(`{v73} ${`[{v64}]{v74 or ""}`}`, 2);
            end;
        end;
        if v63 ~= v64 then
            error("LengthMismatch", 2);
        end;
        return p62;
    end;
end;
function u33.UniqueArrayCoerce(u75) --[[ Line: 257 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.Function(u75);
    return function(p76) --[[ Line: 261 ]]
        -- upvalues: u11 (ref), u75 (copy)
        if type(p76) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p76) ~= nil then
            error("metatable", 2);
        end;
        local v77 = rawlen(p76);
        local v78 = 0;
        local v79 = {};
        local v80 = {};
        for v81, v82 in pairs(p76) do
            v78 = v78 + 1;
            if v81 ~= v78 then
                error(`IndexMismatch ${`[{u11(v81)}]`}`, 2);
            end;
            if v77 < v78 then
                error(`IndexOverflow ${`[{v78}]`}`, 2);
            end;
            if v79[v82] then
                error(`UniqueArray ${`[{v78}]`}`, 2);
            end;
            v79[v82] = true;
            if not v79[v82] then
                error(`InvalidKey ${`[{v78}]`}`, 2);
            end;
            local v83, v84 = pcall(u75, v82);
            if not v83 then
                local v85 = tostring(v84);
                local v86, v87 = string.match(v85, "^(.*:%d+): (.+)$");
                if v86 then
                    v85 = v87 or v85;
                end;
                local v88, v89 = string.match(v85, "^(.+) $(%[.+)$");
                if v88 then
                    if not v89 then
                        v88 = v85;
                    end;
                else
                    v88 = v85;
                end;
                error(`{v88} ${`[{v78}]{v89 or ""}`}`, 2);
            end;
            v80[v81] = v84;
        end;
        if v77 ~= v78 then
            error("LengthMismatch", 2);
        end;
        return v80;
    end;
end;
function u33.Map(u90, u91, p92) --[[ Line: 302 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.Function(u90);
    u33.Function(u91);
    u33.Optional(u33.IntegerPositive)(p92);
    local u93 = p92 or (1 / 0);
    return function(p94) --[[ Line: 312 ]]
        -- upvalues: u93 (copy), u90 (copy), u11 (ref), u91 (copy)
        if type(p94) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p94) ~= nil then
            error("metatable", 2);
        end;
        local v95 = 0;
        for v96, v97 in pairs(p94) do
            v95 = v95 + 1;
            if u93 < v95 then
                error(`LengthLimit({u93})`, 2);
            end;
            local v98, v99 = pcall(u90, v96);
            if not v98 then
                local v100 = tostring(v99);
                local v101, v102 = string.match(v100, "^(.*:%d+): (.+)$");
                if v101 then
                    v100 = v102 or v100;
                end;
                local v103, v104 = string.match(v100, "^(.+) $(%[.+)$");
                if v103 then
                    if not v104 then
                        v103 = v100;
                    end;
                else
                    v103 = v100;
                end;
                error(`{v103} ${`<{u11(v96)}>{v104 or ""}`}`, 2);
            end;
            local v105, v106 = pcall(u91, v97);
            if not v105 then
                local v107 = tostring(v106);
                local v108, v109 = string.match(v107, "^(.*:%d+): (.+)$");
                if v108 then
                    v107 = v109 or v107;
                end;
                local v110, v111 = string.match(v107, "^(.+) $(%[.+)$");
                if v110 then
                    if not v111 then
                        v110 = v107;
                    end;
                else
                    v110 = v107;
                end;
                error(`{v110} ${`[{u11(v96)}]{v111 or ""}`}`, 2);
            end;
        end;
        return p94;
    end;
end;
function u33.MapCoerce(u112, u113, p114) --[[ Line: 347 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.Function(u112);
    u33.Function(u113);
    u33.Optional(u33.IntegerPositive)(p114);
    local u115 = p114 or (1 / 0);
    return function(p116) --[[ Line: 357 ]]
        -- upvalues: u115 (copy), u112 (copy), u11 (ref), u113 (copy)
        if type(p116) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p116) ~= nil then
            error("metatable", 2);
        end;
        local v117 = 0;
        local v118 = {};
        for v119, v120 in pairs(p116) do
            v117 = v117 + 1;
            if u115 < v117 then
                error(`LengthLimit({u115})`, 2);
            end;
            local v121, v122 = pcall(u112, v119);
            if not v121 then
                local v123 = tostring(v122);
                local v124, v125 = string.match(v123, "^(.*:%d+): (.+)$");
                if v124 then
                    v123 = v125 or v123;
                end;
                local v126, v127 = string.match(v123, "^(.+) $(%[.+)$");
                if v126 then
                    if not v127 then
                        v126 = v123;
                    end;
                else
                    v126 = v123;
                end;
                error(`{v126} ${`<{u11(v119)}>{v127 or ""}`}`, 2);
            end;
            local v128, v129 = pcall(u113, v120);
            if not v128 then
                local v130 = tostring(v129);
                local v131, v132 = string.match(v130, "^(.*:%d+): (.+)$");
                if v131 then
                    v130 = v132 or v130;
                end;
                local v133, v134 = string.match(v130, "^(.+) $(%[.+)$");
                if v133 then
                    if not v134 then
                        v133 = v130;
                    end;
                else
                    v133 = v130;
                end;
                error(`{v133} ${`[{u11(v119)}]{v134 or ""}`}`, 2);
            end;
            v118[v122] = v129;
        end;
        return v118;
    end;
end;
function u33.Table(p135) --[[ Line: 394 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.NoMetatable(p135);
    for _, v136 in pairs(p135) do
        u33.Function(v136);
    end;
    local u137 = table.clone(p135);
    return function(p138) --[[ Line: 403 ]]
        -- upvalues: u137 (ref), u11 (ref)
        if type(p138) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p138) ~= nil then
            error("metatable", 2);
        end;
        if rawlen(u137) ~= rawlen(p138) then
            error("LengthMismatch", 2);
        end;
        for v139, _ in pairs(p138) do
            if not u137[v139] then
                error(`UnknownKey ${`[{u11(v139)}]`}`, 2);
            end;
        end;
        for v140, v141 in pairs(u137) do
            local v142, v143 = pcall(v141, p138[v140]);
            if not v142 then
                local v144 = tostring(v143);
                local v145, v146 = string.match(v144, "^(.*:%d+): (.+)$");
                if v145 then
                    v144 = v146 or v144;
                end;
                local v147, v148 = string.match(v144, "^(.+) $(%[.+)$");
                if v147 then
                    if not v148 then
                        v147 = v144;
                    end;
                else
                    v147 = v144;
                end;
                local v149 = error;
                local v150 = "[%*]%*";
                local v151;
                if type(v140) == "string" then
                    local v152;
                    v151, v152 = string.format("%q", v140):gsub("\n", "n");
                elseif typeof(v140) == "Instance" then
                    v151 = v140:GetFullName();
                else
                    v151 = tostring(v140);
                end;
                v149(`{v147} ${v150:format(v151, v148 or "")}`, 2);
            end;
        end;
        return p138;
    end;
end;
function u33.TablePermissive(p153) --[[ Line: 431 ]]
    -- upvalues: u33 (copy)
    u33.NoMetatable(p153);
    for _, v154 in pairs(p153) do
        u33.Function(v154);
    end;
    local u155 = table.clone(p153);
    return function(p156) --[[ Line: 440 ]]
        -- upvalues: u155 (ref)
        if type(p156) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p156) ~= nil then
            error("metatable", 2);
        end;
        if rawlen(u155) ~= rawlen(p156) then
            error("LengthMismatch", 2);
        end;
        for v157, v158 in pairs(u155) do
            local v159, v160 = pcall(v158, p156[v157]);
            if not v159 then
                local v161 = tostring(v160);
                local v162, v163 = string.match(v161, "^(.*:%d+): (.+)$");
                if v162 then
                    v161 = v163 or v161;
                end;
                local v164, v165 = string.match(v161, "^(.+) $(%[.+)$");
                if v164 then
                    if not v165 then
                        v164 = v161;
                    end;
                else
                    v164 = v161;
                end;
                local v166 = error;
                local v167 = "[%*]%*";
                local v168;
                if type(v157) == "string" then
                    local v169;
                    v168, v169 = string.format("%q", v157):gsub("\n", "n");
                elseif typeof(v157) == "Instance" then
                    v168 = v157:GetFullName();
                else
                    v168 = tostring(v157);
                end;
                v166(`{v164} ${v167:format(v168, v165 or "")}`, 2);
            end;
        end;
        return p156;
    end;
end;
function u33.TableCoerce(p170) --[[ Line: 469 ]]
    -- upvalues: u33 (copy), u11 (copy)
    u33.NoMetatable(p170);
    for _, v171 in pairs(p170) do
        u33.Function(v171);
    end;
    local u172 = table.clone(p170);
    return function(p173) --[[ Line: 478 ]]
        -- upvalues: u172 (ref), u11 (ref)
        if type(p173) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p173) ~= nil then
            error("metatable", 2);
        end;
        if rawlen(u172) ~= rawlen(p173) then
            error("LengthMismatch", 2);
        end;
        local v174 = {};
        for v175, _ in pairs(p173) do
            if not u172[v175] then
                error(`UnknownKey ${`[{u11(v175)}]`}`, 2);
            end;
        end;
        for v176, v177 in pairs(u172) do
            local v178, v179 = pcall(v177, p173[v176]);
            if not v178 then
                local v180 = tostring(v179);
                local v181, v182 = string.match(v180, "^(.*:%d+): (.+)$");
                if v181 then
                    v180 = v182 or v180;
                end;
                local v183, v184 = string.match(v180, "^(.+) $(%[.+)$");
                if v183 then
                    if not v184 then
                        v183 = v180;
                    end;
                else
                    v183 = v180;
                end;
                local v185 = error;
                local v186 = "[%*]%*";
                local v187;
                if type(v176) == "string" then
                    local v188;
                    v187, v188 = string.format("%q", v176):gsub("\n", "n");
                elseif typeof(v176) == "Instance" then
                    v187 = v176:GetFullName();
                else
                    v187 = tostring(v176);
                end;
                v185(`{v183} ${v186:format(v187, v184 or "")}`, 2);
            end;
            v174[v176] = v179;
        end;
        return v174;
    end;
end;
function u33.IsASCII(p189) --[[ Line: 508 ]]
    local v190;
    if type(p189) == "string" then
        for v191 = 1, string.len(p189) do
            local v192 = string.byte(p189, v191);
            if v192 < 32 or v192 > 126 then
                return false;
            end;
        end;
        v190 = true;
    else
        v190 = false;
    end;
    return v190;
end;
function u33.IsFinite(p193) --[[ Line: 511 ]]
    local v194;
    if type(p193) == "number" and (p193 == p193 and p193 ~= (1 / 0)) then
        v194 = p193 ~= (-1 / 0);
    else
        v194 = false;
    end;
    return v194;
end;
function u33.IsInteger(p195) --[[ Line: 514 ]]
    local v196;
    if type(p195) == "number" and (math.floor(p195) == p195 and p195 ~= (1 / 0)) then
        v196 = p195 ~= (-1 / 0);
    else
        v196 = false;
    end;
    return v196;
end;
function u33.IsCFrameFinite(p197) --[[ Line: 517 ]]
    local v198;
    if typeof(p197) == "CFrame" then
        local v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209, v210 = p197:GetComponents();
        local v211 = v199 + v200 + v201 + v202 + v203 + v204 + v205 + v206 + v207 + v208 + v209 + v210;
        if v211 == v211 and v211 ~= (1 / 0) then
            v198 = v211 ~= (-1 / 0);
        else
            v198 = false;
        end;
    else
        v198 = false;
    end;
    return v198;
end;
function u33.IsVector2Finite(p212) --[[ Line: 520 ]]
    local v213;
    if typeof(p212) == "Vector2" then
        local v214 = p212.X + p212.Y;
        if v214 == v214 and v214 ~= (1 / 0) then
            v213 = v214 ~= (-1 / 0);
        else
            v213 = false;
        end;
    else
        v213 = false;
    end;
    return v213;
end;
function u33.Optional(u215) --[[ Line: 524 ]]
    if type(u215) ~= "function" then
        error("function", 2);
    end;
    return function(p216) --[[ Line: 526 ]]
        -- upvalues: u215 (copy)
        if p216 == nil then
            return nil;
        end;
        local v217, v218 = pcall(u215, p216);
        if not v217 then
            local v219 = error;
            local v220 = tostring(v218);
            local v221, v222 = string.match(v220, "^(.*:%d+): (.+)$");
            if v221 then
                v220 = v222 or v220;
            end;
            v219(v220, 2);
        end;
        return v218;
    end;
end;
function u33.Default(u223, p224) --[[ Line: 538 ]]
    if type(u223) ~= "function" then
        error("function", 2);
    end;
    local u225 = u223(p224);
    return function(p226) --[[ Line: 544 ]]
        -- upvalues: u225 (copy), u223 (copy)
        if p226 == nil then
            return u225;
        end;
        local v227, v228 = pcall(u223, p226);
        if not v227 then
            local v229 = error;
            local v230 = tostring(v228);
            local v231, v232 = string.match(v230, "^(.*:%d+): (.+)$");
            if v231 then
                v230 = v232 or v230;
            end;
            v229(v230, 2);
        end;
        return v228;
    end;
end;
function u33.AnyOf(...) --[[ Line: 556 ]]
    local u233 = table.pack(...);
    for v234 = 1, u233.n do
        local v235 = type(u233[v234]) == "function";
        assert(v235, "function");
    end;
    assert(u233.n > 0);
    return function(p236) --[[ Line: 562 ]]
        -- upvalues: u233 (copy)
        for v237 = 1, u233.n do
            local v238, v239 = pcall(u233[v237], p236);
            if v238 then
                return v239;
            end;
        end;
        error("AnyOf", 2);
    end;
end;
function u33.AllOf(...) --[[ Line: 573 ]]
    local u240 = table.pack(...);
    for v241 = 1, u240.n do
        local v242 = type(u240[v241]) == "function";
        assert(v242, "function");
    end;
    assert(u240.n > 0);
    return function(p243) --[[ Line: 579 ]]
        -- upvalues: u240 (copy)
        for v244 = 1, u240.n do
            local v245, v246 = pcall(u240[v244], p243);
            if not v245 then
                local v247 = error;
                local v248 = tostring(v246);
                local v249, v250 = string.match(v248, "^(.*:%d+): (.+)$");
                if v249 then
                    v248 = v250 or v248;
                end;
                v247(v248, 2);
            end;
        end;
        return p243;
    end;
end;
function u33.AnyTable(p251) --[[ Line: 591 ]]
    if type(p251) ~= "table" then
        error("table", 2);
    end;
    return p251;
end;
function u33.Number(p252) --[[ Line: 597 ]]
    if type(p252) ~= "number" then
        error("number", 2);
    end;
    return p252;
end;
function u33.Boolean(p253) --[[ Line: 603 ]]
    if type(p253) ~= "boolean" then
        error("boolean", 2);
    end;
    return p253;
end;
function u33.Buffer(p254) --[[ Line: 609 ]]
    if type(p254) ~= "buffer" then
        error("buffer", 2);
    end;
    return p254;
end;
function u33.Function(p255) --[[ Line: 615 ]]
    if type(p255) ~= "function" then
        error("function", 2);
    end;
    return p255;
end;
function u33.Thread(p256) --[[ Line: 621 ]]
    if type(p256) ~= "thread" then
        error("thread", 2);
    end;
    return p256;
end;
function u33.String(p257) --[[ Line: 628 ]]
    if type(p257) ~= "string" then
        error("string", 2);
    end;
    if not utf8.len(p257) then
        error("UTF8", 2);
    end;
    return p257;
end;
function u33.RawString(p258) --[[ Line: 638 ]]
    if type(p258) ~= "string" then
        error("string", 2);
    end;
    return p258;
end;
function u33.Any(p259) --[[ Line: 645 ]]
    return p259;
end;
function u33.Equals(u260) --[[ Line: 649 ]]
    return function(p261) --[[ Line: 650 ]]
        -- upvalues: u260 (copy)
        local v262 = u260;
        if not rawequal(p261, v262) and (type(p261) ~= "number" or (type(v262) ~= "number" or (p261 == p261 or v262 == v262))) then
            error("Equals", 2);
        end;
        return p261;
    end;
end;
function u33.Set(p263) --[[ Line: 656 ]]
    -- upvalues: u33 (copy)
    u33.Array(u33.Any);
    local u264 = {};
    for _, v265 in ipairs(p263) do
        if v265 ~= v265 then
            error("InvalidKeyNaN", 2);
        end;
        u264[v265] = true;
        if not u264[v265] then
            error("InvalidKey", 2);
        end;
    end;
    return function(p266) --[[ Line: 668 ]]
        -- upvalues: u264 (copy)
        if not u264[p266] then
            error("Set", 2);
        end;
        return p266;
    end;
end;
function u33.Pattern(u267) --[[ Line: 674 ]]
    -- upvalues: u33 (copy)
    u33.String(u267);
    return function(p268) --[[ Line: 676 ]]
        -- upvalues: u267 (copy)
        if type(p268) ~= "string" then
            error("string", 2);
        end;
        if not utf8.len(p268) then
            error("UTF8", 2);
        end;
        if not string.find(p268, u267) then
            error("Pattern", 2);
        end;
        return p268;
    end;
end;
function u33.NoMetatable(p269) --[[ Line: 684 ]]
    if type(p269) ~= "table" then
        error("table", 2);
    end;
    if getmetatable(p269) ~= nil then
        error("metatable", 2);
    end;
    return p269;
end;
function u33.Finite(p270) --[[ Line: 691 ]]
    if type(p270) ~= "number" then
        error("number", 2);
    end;
    local v271;
    if p270 == p270 and p270 ~= (1 / 0) then
        v271 = p270 ~= (-1 / 0);
    else
        v271 = false;
    end;
    if not v271 then
        error("Finite", 2);
    end;
    return p270;
end;
function u33.FinitePositive(p272) --[[ Line: 698 ]]
    if type(p272) ~= "number" then
        error("number", 2);
    end;
    local v273;
    if p272 == p272 and p272 ~= (1 / 0) then
        v273 = p272 ~= (-1 / 0);
    else
        v273 = false;
    end;
    if not v273 then
        error("Finite", 2);
    end;
    if p272 <= 0 then
        error("Positive", 2);
    end;
    return p272;
end;
function u33.FiniteNonNegative(p274) --[[ Line: 706 ]]
    if type(p274) ~= "number" then
        error("number", 2);
    end;
    local v275;
    if p274 == p274 and p274 ~= (1 / 0) then
        v275 = p274 ~= (-1 / 0);
    else
        v275 = false;
    end;
    if not v275 then
        error("Finite", 2);
    end;
    if p274 < 0 then
        error("NonNegative", 2);
    end;
    return p274;
end;
function u33.Positive(p276) --[[ Line: 714 ]]
    if type(p276) ~= "number" then
        error("number", 2);
    end;
    if p276 <= 0 then
        error("Positive", 2);
    end;
    return p276;
end;
function u33.NonNegative(p277) --[[ Line: 721 ]]
    if type(p277) ~= "number" then
        error("number", 2);
    end;
    if p277 < 0 then
        error("NonNegative", 2);
    end;
    return p277;
end;
function u33.Real(p278) --[[ Line: 728 ]]
    if type(p278) ~= "number" then
        error("number", 2);
    end;
    if p278 ~= p278 then
        error("Real", 2);
    end;
    return p278;
end;
function u33.Range(u279, u280) --[[ Line: 735 ]]
    -- upvalues: u33 (copy)
    u33.Real(u279);
    u33.Real(u280);
    if u279 > u280 then
        error("a<=b", 2);
    end;
    return function(p281) --[[ Line: 739 ]]
        -- upvalues: u279 (copy), u280 (copy)
        if type(p281) ~= "number" then
            error("number", 2);
        end;
        if u279 > p281 or p281 > u280 then
            error(`Range({u279},{u280})`, 2);
        end;
        return p281;
    end;
end;
function u33.Integer(p282) --[[ Line: 747 ]]
    if type(p282) ~= "number" then
        error("number", 2);
    end;
    local v283;
    if math.floor(p282) == p282 and p282 ~= (1 / 0) then
        v283 = p282 ~= (-1 / 0);
    else
        v283 = false;
    end;
    if not v283 then
        error("Integer", 2);
    end;
    return p282;
end;
function u33.Unsigned32(p284) --[[ Line: 754 ]]
    if bit32.bor(p284, 0) ~= p284 then
        error("Unsigned32", 2);
    end;
    return p284;
end;
function u33.IntegerPositive(p285) --[[ Line: 761 ]]
    if type(p285) ~= "number" then
        error("number", 2);
    end;
    local v286;
    if math.floor(p285) == p285 and p285 ~= (1 / 0) then
        v286 = p285 ~= (-1 / 0);
    else
        v286 = false;
    end;
    if not v286 then
        error("Integer", 2);
    end;
    if p285 < 1 then
        error("Positive", 2);
    end;
    return p285;
end;
function u33.Index(p287) --[[ Line: 769 ]]
    if type(p287) ~= "number" then
        error("number", 2);
    end;
    local v288;
    if math.floor(p287) == p287 and p287 ~= (1 / 0) then
        v288 = p287 ~= (-1 / 0);
    else
        v288 = false;
    end;
    if not v288 then
        error("Integer", 2);
    end;
    if p287 < 1 then
        error("Positive", 2);
    end;
    return p287;
end;
function u33.IntegerNonNegative(p289) --[[ Line: 777 ]]
    if type(p289) ~= "number" then
        error("number", 2);
    end;
    local v290;
    if math.floor(p289) == p289 and p289 ~= (1 / 0) then
        v290 = p289 ~= (-1 / 0);
    else
        v290 = false;
    end;
    if not v290 then
        error("Integer", 2);
    end;
    if p289 < 0 then
        error("NonNegative", 2);
    end;
    return p289;
end;
function u33.IntegerRange(u291, u292) --[[ Line: 785 ]]
    -- upvalues: u33 (copy)
    u33.Integer(u291);
    u33.Integer(u292);
    if u291 > u292 then
        error("a<=b", 2);
    end;
    return function(p293) --[[ Line: 789 ]]
        -- upvalues: u291 (copy), u292 (copy)
        if type(p293) ~= "number" then
            error("number", 2);
        end;
        local v294;
        if math.floor(p293) == p293 and p293 ~= (1 / 0) then
            v294 = p293 ~= (-1 / 0);
        else
            v294 = false;
        end;
        if not v294 then
            error("Integer", 2);
        end;
        if u291 > p293 or p293 > u292 then
            error(`Range({u291},{u292})`, 2);
        end;
        return p293;
    end;
end;
function u33.UInt32() --[[ Line: 797 ]]
    return function(p295) --[[ Line: 798 ]]
        if type(p295) ~= "number" then
            error("number", 2);
        end;
        if bit32.bor(p295, 0) ~= p295 then
            error("UInt32", 2);
        end;
        return p295;
    end;
end;
function u33.StringRange(u296, u297) --[[ Line: 806 ]]
    -- upvalues: u33 (copy)
    u33.Integer(u296);
    u33.Integer(u297);
    if u296 > u297 then
        error("a<=b", 2);
    end;
    return function(p298) --[[ Line: 810 ]]
        -- upvalues: u296 (copy), u297 (copy)
        if type(p298) ~= "string" then
            error("string", 2);
        end;
        local v299 = utf8.len(p298);
        if not v299 then
            error("UTF8", 2);
        end;
        if u296 > v299 or v299 > u297 then
            error(`StringRange({u296},{u297})`, 2);
        end;
        return p298;
    end;
end;
function u33.ASCII(p300) --[[ Line: 823 ]]
    if type(p300) ~= "string" then
        error("string", 2);
    end;
    for v301 = 1, string.len(p300) do
        local v302 = string.byte(p300, v301);
        if v302 < 32 or v302 > 126 then
            error("ASCII", 2);
        end;
    end;
    return p300;
end;
function u33.ASCIIRange(u303, u304) --[[ Line: 835 ]]
    -- upvalues: u33 (copy)
    u33.Integer(u303);
    u33.Integer(u304);
    if u303 > u304 then
        error("a<=b", 2);
    end;
    return function(p305) --[[ Line: 839 ]]
        -- upvalues: u303 (copy), u304 (copy)
        if type(p305) ~= "string" then
            error("string", 2);
        end;
        local v306 = string.len(p305);
        if u303 > v306 or v306 > u304 then
            error(`ASCIIRange({u303},{u304})`, 2);
        end;
        for v307 = 1, v306 do
            local v308 = string.byte(p305, v307);
            if v308 < 32 or v308 > 126 then
                error("ASCII", 2);
            end;
        end;
        return p305;
    end;
end;
function u33.CFrame(p309) --[[ Line: 855 ]]
    if typeof(p309) ~= "CFrame" then
        error("CFrame", 2);
    end;
    return p309;
end;
function u33.CFrameFinite(p310) --[[ Line: 861 ]]
    if typeof(p310) ~= "CFrame" then
        error("CFrame", 2);
    end;
    local v311, v312, v313, v314, v315, v316, v317, v318, v319, v320, v321, v322 = p310:GetComponents();
    local v323 = v311 + v312 + v313 + v314 + v315 + v316 + v317 + v318 + v319 + v320 + v321 + v322;
    local v324;
    if v323 == v323 and v323 ~= (1 / 0) then
        v324 = v323 ~= (-1 / 0);
    else
        v324 = false;
    end;
    if not v324 then
        error("CFrameFinite", 2);
    end;
    return p310;
end;
function u33.Vector2(p325) --[[ Line: 870 ]]
    if typeof(p325) ~= "Vector2" then
        error("Vector2", 2);
    end;
    return p325;
end;
function u33.Vector2Finite(p326) --[[ Line: 876 ]]
    if typeof(p326) ~= "Vector2" then
        error("Vector2", 2);
    end;
    local v327 = p326.X + p326.Y;
    local v328;
    if v327 == v327 and v327 ~= (1 / 0) then
        v328 = v327 ~= (-1 / 0);
    else
        v328 = false;
    end;
    if not v328 then
        error("Vector2Finite", 2);
    end;
    return p326;
end;
function u33.Vector2Unit(p329) --[[ Line: 885 ]]
    if typeof(p329) ~= "Vector2" then
        error("Vector2", 2);
    end;
    local v330 = p329.X + p329.Y;
    local v331;
    if v330 == v330 and v330 ~= (1 / 0) then
        v331 = v330 ~= (-1 / 0);
    else
        v331 = false;
    end;
    if not v331 then
        error("Vector2Finite", 2);
    end;
    if math.abs(p329.Magnitude - 1) > 1e-6 then
        error("Vector2Unit", 2);
    end;
    return p329;
end;
function u33.Vector3(p332) --[[ Line: 897 ]]
    if typeof(p332) ~= "Vector3" then
        error("Vector3", 2);
    end;
    return p332;
end;
function u33.Vector3Finite(p333) --[[ Line: 903 ]]
    if typeof(p333) ~= "Vector3" then
        error("Vector3", 2);
    end;
    local v334 = p333.X + p333.Y + p333.Z;
    local v335;
    if v334 == v334 and v334 ~= (1 / 0) then
        v335 = v334 ~= (-1 / 0);
    else
        v335 = false;
    end;
    if not v335 then
        error("Vector3Finite", 2);
    end;
    return p333;
end;
function u33.Vector3Unit(p336) --[[ Line: 912 ]]
    if typeof(p336) ~= "Vector3" then
        error("Vector3", 2);
    end;
    local v337 = p336.X + p336.Y + p336.Z;
    local v338;
    if v337 == v337 and v337 ~= (1 / 0) then
        v338 = v337 ~= (-1 / 0);
    else
        v338 = false;
    end;
    if not v338 then
        error("Vector3Finite", 2);
    end;
    if math.abs(p336.Magnitude - 1) > 1e-6 then
        error("Vector3Unit", 2);
    end;
    return p336;
end;
function u33.Vector3Positive(p339) --[[ Line: 924 ]]
    if typeof(p339) ~= "Vector3" then
        error("Vector3", 2);
    end;
    local v340 = p339.X + p339.Y + p339.Z;
    local v341;
    if v340 == v340 and v340 ~= (1 / 0) then
        v341 = v340 ~= (-1 / 0);
    else
        v341 = false;
    end;
    if not v341 then
        error("Vector3Finite", 2);
    end;
    if p339.X <= 0 or (p339.Y <= 0 or p339.Z <= 0) then
        error("Vector3Positive");
    end;
    return p339;
end;
function u33.Vector3int16(p342) --[[ Line: 936 ]]
    if typeof(p342) ~= "Vector3int16" then
        error("Vector3int16", 2);
    end;
    return p342;
end;
function u33.Vector2int16(p343) --[[ Line: 942 ]]
    if typeof(p343) ~= "Vector2int16" then
        error("Vector2int16", 2);
    end;
    return p343;
end;
function u33.Region3(p344) --[[ Line: 948 ]]
    if typeof(p344) ~= "Region3" then
        error("Region3", 2);
    end;
    return p344;
end;
function u33.Region3int16(p345) --[[ Line: 954 ]]
    if typeof(p345) ~= "Region3int16" then
        error("Region3int16", 2);
    end;
    return p345;
end;
function u33.UDim(p346) --[[ Line: 960 ]]
    if typeof(p346) ~= "UDim" then
        error("UDim", 2);
    end;
    return p346;
end;
function u33.UDim2(p347) --[[ Line: 966 ]]
    if typeof(p347) ~= "UDim2" then
        error("UDim2", 2);
    end;
    return p347;
end;
function u33.Rect(p348) --[[ Line: 972 ]]
    if typeof(p348) ~= "Rect" then
        error("Rect", 2);
    end;
    return p348;
end;
function u33.PhysicalProperties(p349) --[[ Line: 978 ]]
    if typeof(p349) ~= "PhysicalProperties" then
        error("PhysicalProperties", 2);
    end;
    return p349;
end;
function u33.Storable(p350, p351) --[[ Line: 988 ]]
    -- upvalues: u11 (copy), u33 (copy)
    if type(p350) == "boolean" then
        return p350;
    end;
    if type(p350) == "number" then
        return p350;
    end;
    if type(p350) == "string" then
        if not utf8.len(p350) then
            error("UTF8", 2);
            return p350;
        end;
    else
        if type(p350) == "buffer" then
            return p350;
        end;
        if type(p350) == "table" then
            if type(p350) ~= "table" then
                error("table", 2);
            end;
            if getmetatable(p350) ~= nil then
                error("metatable", 2);
            end;
            local v352 = p351 or {};
            if v352[p350] then
                error("Loop", 2);
            end;
            v352[p350] = true;
            local v353 = rawlen(p350);
            if v353 <= 0 then
                for v354, v355 in pairs(p350) do
                    if type(v354) ~= "string" then
                        error(`KeyString ${`[{u11(v354)}]`}`, 2);
                    end;
                    if not utf8.len(v354) then
                        error(`KeyUTF8 ${`[{u11(v354)}]`}`, 2);
                    end;
                    local v356, v357 = pcall(u33.Storable, v355, v352);
                    if not v356 then
                        local v358 = tostring(v357);
                        local v359, v360 = string.match(v358, "^(.*:%d+): (.+)$");
                        if v359 then
                            v358 = v360 or v358;
                        end;
                        local v361, v362 = string.match(v358, "^(.+) $(%[.+)$");
                        if v361 then
                            if not v362 then
                                v361 = v358;
                            end;
                        else
                            v361 = v358;
                        end;
                        error(`{v361} ${`[{u11(v354)}]{v362 or ""}`}`, 2);
                    end;
                end;
                return p350;
            end;
            local v363 = 0;
            for v364, v365 in pairs(p350) do
                v363 = v363 + 1;
                if v364 ~= v363 then
                    error(`IndexMismatch ${`[{u11(v364)}]`}`, 2);
                end;
                if v353 < v363 then
                    error(`IndexOverflow ${`[{v363}]`}`, 2);
                end;
                local v366, v367 = pcall(u33.Storable, v365, v352);
                if not v366 then
                    local v368 = tostring(v367);
                    local v369, v370 = string.match(v368, "^(.*:%d+): (.+)$");
                    if v369 then
                        v368 = v370 or v368;
                    end;
                    local v371, v372 = string.match(v368, "^(.+) $(%[.+)$");
                    if v371 then
                        if not v372 then
                            v371 = v368;
                        end;
                    else
                        v371 = v368;
                    end;
                    error(`{v371} ${`[{v363}]{v372 or ""}`}`, 2);
                end;
            end;
            if v353 ~= v363 then
                error("LengthMismatch", 2);
                return p350;
            end;
        else
            error("Storable", 2);
        end;
    end;
    return p350;
end;
local u373 = {
    boolean = true,
    number = true,
    string = true,
    buffer = true,
    Color3 = true,
    Instance = true,
    NumberRange = true,
    Rect = true,
    Region3 = true,
    Region3int16 = true,
    UDim = true,
    UDim2 = true,
    CFrame = true,
    Vector2 = true,
    Vector2int16 = true,
    Vector3 = true,
    Vector3int16 = true,
    EnumItem = true
};
table.freeze(u373);
function u33.Networkable(p374, p375) --[[ Line: 1084 ]]
    -- upvalues: u11 (copy), u33 (copy), u373 (copy)
    if type(p374) == "string" then
        if not utf8.len(p374) then
            error("UTF8", 2);
            return p374;
        end;
    elseif type(p374) == "table" then
        if type(p374) ~= "table" then
            error("table", 2);
        end;
        if getmetatable(p374) ~= nil then
            error("metatable", 2);
        end;
        local v376 = p375 or {};
        if v376[p374] then
            error("Loop", 2);
        end;
        v376[p374] = true;
        local v377 = rawlen(p374);
        if v377 <= 0 then
            for v378, v379 in pairs(p374) do
                if type(v378) ~= "string" then
                    error(`KeyString ${`[{u11(v378)}]`}`, 2);
                end;
                if not utf8.len(v378) then
                    error(`KeyUTF8 ${`[{u11(v378)}]`}`, 2);
                end;
                local v380, v381 = pcall(u33.Networkable, v379, v376);
                if not v380 then
                    local v382 = tostring(v381);
                    local v383, v384 = string.match(v382, "^(.*:%d+): (.+)$");
                    if v383 then
                        v382 = v384 or v382;
                    end;
                    local v385, v386 = string.match(v382, "^(.+) $(%[.+)$");
                    if v385 then
                        if not v386 then
                            v385 = v382;
                        end;
                    else
                        v385 = v382;
                    end;
                    error(`{v385} ${`[{u11(v378)}]{v386 or ""}`}`, 2);
                end;
            end;
            return p374;
        end;
        local v387 = 0;
        for v388, v389 in pairs(p374) do
            v387 = v387 + 1;
            if v388 ~= v387 then
                error(`IndexMismatch ${`[{u11(v388)}]`}`, 2);
            end;
            if v377 < v387 then
                error(`IndexOverflow ${`[{v387}]`}`, 2);
            end;
            local v390, v391 = pcall(u33.Networkable, v389, v376);
            if not v390 then
                local v392 = tostring(v391);
                local v393, v394 = string.match(v392, "^(.*:%d+): (.+)$");
                if v393 then
                    v392 = v394 or v392;
                end;
                local v395, v396 = string.match(v392, "^(.+) $(%[.+)$");
                if v395 then
                    if not v396 then
                        v395 = v392;
                    end;
                else
                    v395 = v392;
                end;
                error(`{v395} ${`[{v387}]{v396 or ""}`}`, 2);
            end;
        end;
        if v377 ~= v387 then
            error("LengthMismatch", 2);
            return p374;
        end;
    elseif not u373[typeof(p374)] then
        error("Networkable", 2);
    end;
    return p374;
end;
function u33.Enum(u397) --[[ Line: 1150 ]]
    if typeof(u397) ~= "Enum" then
        error("Enum", 2);
    end;
    return function(p398) --[[ Line: 1152 ]]
        -- upvalues: u397 (copy)
        if typeof(p398) ~= "EnumItem" then
            error("EnumItem", 2);
        end;
        if p398.EnumType ~= u397 then
            error(tostring(u397), 2);
        end;
        return p398;
    end;
end;
function u33.EnumValue(p399) --[[ Line: 1159 ]]
    if typeof(p399) ~= "Enum" then
        error("Enum", 2);
    end;
    local u400 = {};
    for _, v401 in ipairs(p399:GetEnumItems()) do
        u400[v401.Value] = v401;
    end;
    return function(p402) --[[ Line: 1165 ]]
        -- upvalues: u400 (copy)
        if typeof(p402) ~= "number" then
            error("number", 2);
        end;
        if not u400[p402] then
            error("EnumValue", 2);
        end;
        return p402;
    end;
end;
function u33.Player(p403) --[[ Line: 1172 ]]
    if typeof(p403) ~= "Instance" or not p403:IsA("Player") then
        error("Player", 2);
    end;
    return p403;
end;
function u33.BasePart(p404) --[[ Line: 1178 ]]
    if typeof(p404) ~= "Instance" or not p404:IsA("BasePart") then
        error("BasePart", 2);
    end;
    return p404;
end;
function u33.Part(p405) --[[ Line: 1184 ]]
    if typeof(p405) ~= "Instance" or not p405:IsA("Part") then
        error("Part", 2);
    end;
    return p405;
end;
function u33.MeshPart(p406) --[[ Line: 1190 ]]
    if typeof(p406) ~= "Instance" or not p406:IsA("MeshPart") then
        error("MeshPart", 2);
    end;
    return p406;
end;
function u33.Model(p407) --[[ Line: 1196 ]]
    if typeof(p407) ~= "Instance" or not p407:IsA("Model") then
        error("Model", 2);
    end;
    return p407;
end;
function u33.Animation(p408) --[[ Line: 1202 ]]
    if typeof(p408) ~= "Instance" or not p408:IsA("Animation") then
        error("Animation", 2);
    end;
    return p408;
end;
function u33.Humanoid(p409) --[[ Line: 1208 ]]
    if typeof(p409) ~= "Instance" or not p409:IsA("Humanoid") then
        error("Humanoid", 2);
    end;
    return p409;
end;
function u33.ParticleEmitter(p410) --[[ Line: 1214 ]]
    if typeof(p410) ~= "Instance" or not p410:IsA("ParticleEmitter") then
        error("ParticleEmitter", 2);
    end;
    return p410;
end;
function u33.Sound(p411) --[[ Line: 1220 ]]
    if typeof(p411) ~= "Instance" or not p411:IsA("Sound") then
        error("Sound", 2);
    end;
    return p411;
end;
function u33.Instance(p412) --[[ Line: 1226 ]]
    if typeof(p412) ~= "Instance" then
        error("Instance", 2);
    end;
    return p412;
end;
function u33.InstanceOf(u413) --[[ Line: 1234 ]]
    -- upvalues: u33 (copy)
    u33.String(u413);
    return function(p414) --[[ Line: 1236 ]]
        -- upvalues: u413 (copy)
        if typeof(p414) ~= "Instance" then
            error("Instance", 2);
        end;
        if not p414:IsA(u413) then
            error(u413, 2);
        end;
        return p414;
    end;
end;
function u33.InstanceClass(u415) --[[ Line: 1243 ]]
    -- upvalues: u33 (copy)
    u33.String(u415);
    return function(p416) --[[ Line: 1245 ]]
        -- upvalues: u415 (copy)
        if typeof(p416) ~= "Instance" then
            error("Instance", 2);
        end;
        if p416.ClassName ~= u415 then
            error(u415, 2);
        end;
        return p416;
    end;
end;
function u33.HexLower(p417) --[[ Line: 1253 ]]
    if type(p417) ~= "string" then
        error("string", 2);
    end;
    for v418 = 1, string.len(p417) do
        local v419 = string.byte(p417, v418);
        if (v419 < 48 or v419 > 57) and (v419 < 97 or v419 > 102) then
            error("HexLower", 2);
        end;
    end;
    return p417;
end;
function u33.HexUpper(p420) --[[ Line: 1267 ]]
    if type(p420) ~= "string" then
        error("string", 2);
    end;
    for v421 = 1, string.len(p420) do
        local v422 = string.byte(p420, v421);
        if (v422 < 48 or v422 > 57) and (v422 < 65 or v422 > 70) then
            error("HexUpper", 2);
        end;
    end;
    return p420;
end;
function u33.UUIDStripped(p423) --[[ Line: 1281 ]]
    if type(p423) ~= "string" then
        error("string", 2);
    end;
    local v424 = string.len(p423);
    if v424 ~= 32 then
        error("Length32", 2);
    end;
    for v425 = 1, v424 do
        local v426 = string.byte(p423, v425);
        if (v426 < 48 or v426 > 57) and (v426 < 97 or v426 > 102) then
            error("HexLower", 2);
        end;
    end;
    return p423;
end;
function u33.UUID(p427) --[[ Line: 1295 ]]
    if type(p427) ~= "string" then
        error("string", 2);
    end;
    if string.len(p427) ~= 36 then
        error("Length36", 2);
    end;
    if not p427:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        error("UUID", 2);
    end;
    return p427;
end;
function u33.Base64(p428) --[[ Line: 1306 ]]
    if type(p428) ~= "string" then
        error("string", 2);
    end;
    if string.len(p428) % 4 ~= 0 then
        error("Base64Length", 2);
    end;
    if not string.match(p428, "^[A-Za-z0-9+/]*=?=?$") or string.match(p428, "[^=]=+[^=]") then
        error("Base64", 2);
    end;
    return p428;
end;
function u33.ToNumber(u429) --[[ Line: 1317 ]]
    return function(p430) --[[ Line: 1320 ]]
        -- upvalues: u429 (copy)
        local v431 = tonumber(p430);
        if not v431 then
            error("tonumber", 2);
        end;
        local v432, v433 = pcall(u429, v431);
        if not v432 then
            local v434 = error;
            local v435 = tostring(v433);
            local v436, v437 = string.match(v435, "^(.*:%d+): (.+)$");
            if v436 then
                v435 = v437 or v435;
            end;
            v434(v435, 2);
        end;
        return v433;
    end;
end;
function u33.IsoDate(p438) --[[ Line: 1333 ]]
    if not DateTime.fromIsoDate(p438) then
        error("IsoDate", 2);
    end;
    return p438;
end;
return table.freeze(u33);