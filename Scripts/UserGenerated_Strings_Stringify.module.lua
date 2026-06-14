-- Decompiled with Potassium's decompiler.

local u1 = {
    Pretty = true,
    IndentChar = " ",
    IndentSize = 2
};
local u2 = {};
local function u6(p3, p4) --[[ Line: 100 ]]
    -- upvalues: u2 (copy)
    local v5 = u2[typeof(p3)];
    if v5 then
        return v5(p3, p4);
    else
        return `[{typeof(p3)}]`;
    end;
end;
u2["nil"] = function(_, _) --[[ Line: 113 ]]
    return "nil";
end;
function u2.boolean(p7, _) --[[ Line: 117 ]]
    return p7 and "true" or "false";
end;
function u2.number(p8, p9) --[[ Line: 121 ]]
    if p8 == (1 / 0) then
        return "math.huge";
    end;
    if p8 == (-1 / 0) then
        return "-math.huge";
    end;
    if p8 ~= p8 then
        return "0/0";
    end;
    local v10;
    if p9.cfg.Pretty then
        local v11 = math.round(p8 * 1000000) / 1000000;
        if v11 == 0 and p8 ~= 0 then
            v10 = tostring(p8);
        else
            local v12, _ = string.format("%." .. 6 .. "f", v11):gsub("%.?0+$", "");
            v10 = (v12 == "" or v12 == "-") and "0" or v12;
        end;
        if v10 then
            return v10;
        end;
    end;
    v10 = tostring(p8);
    return v10;
end;
function u2.string(p13, _) --[[ Line: 128 ]]
    return string.format("%q", p13);
end;
u2["function"] = function(_) --[[ Line: 132 ]]
    return "[function]";
end;
function u2.Instance(p14) --[[ Line: 136 ]]
    if p14.Parent then
        return `[{p14.ClassName} {p14:GetFullName()}]`;
    else
        return `[{p14.ClassName}]`;
    end;
end;
function u2.table(p15, p16) --[[ Line: 147 ]]
    -- upvalues: u2 (copy)
    local v17 = getmetatable(p15);
    if v17 and v17.__tostring then
        return tostring(p15):gsub("\n", "\n" .. string.rep(p16.cfg.IndentChar, p16.cfg.IndentSize * p16.depth));
    end;
    if p16.seen[p15] then
        return "{...}";
    end;
    p16.seen[p15] = true;
    local v18 = {};
    local v19 = 0;
    for v20 in pairs(p15) do
        if typeof(v20) == "number" then
            local v21 = v20 - math.round(v20);
            if math.abs(v21) < 1e-6 and v20 > 0 then
                v19 = math.max(v19, v20);
            end;
        end;
        table.insert(v18, v20);
    end;
    local v22;
    if #v18 == v19 then
        v22 = #v18 > 0;
    else
        v22 = false;
    end;
    for v23 = 1, v19 do
        if p15[v23] == nil then
            v22 = false;
            break;
        end;
    end;
    p16.depth = p16.depth + 1;
    local l__Pretty__1 = p16.cfg.Pretty;
    local v24 = l__Pretty__1 and ("\n" .. string.rep(p16.cfg.IndentChar, p16.cfg.IndentSize * p16.depth) or "") or "";
    local v25 = l__Pretty__1 and (",\n" .. string.rep(p16.cfg.IndentChar, p16.cfg.IndentSize * p16.depth) or ",") or ",";
    local v26 = {};
    if v22 then
        for v27 = 1, v19 do
            local v28 = p15[v27];
            local v29 = u2[typeof(v28)];
            local v30;
            if v29 then
                v30 = v29(v28, p16);
            else
                v30 = `[{typeof(v28)}]`;
            end;
            v26[v27] = v30;
        end;
    else
        local l__order__2 = p16.order;
        local u31 = {};
        for v32, v33 in ipairs(v18) do
            u31[v33] = v32;
        end;
        local v34 = {};
        for _, v35 in ipairs(v18) do
            table.insert(v34, { v35, p15[v35] });
        end;
        if l__order__2 then
            table.sort(v34, function(p36, p37) --[[ Line: 199 ]]
                -- upvalues: l__order__2 (copy), u31 (copy)
                local v38 = l__order__2[p36[1]] and (l__order__2[p36[1]].Index or (1 / 0)) or (1 / 0);
                local v39 = l__order__2[p37[1]] and (l__order__2[p37[1]].Index or (1 / 0)) or (1 / 0);
                return v38 ~= v39 and v38 < v39 and true or u31[p36[1]] < u31[p37[1]];
            end);
        end;
        for _, v40 in ipairs(v34) do
            local v41 = v40[1];
            local v42 = v40[2];
            local v43;
            if l__order__2 and l__order__2[v41] then
                v43 = l__order__2[v41].Child or nil;
            else
                v43 = nil;
            end;
            local l__order__3 = p16.order;
            p16.order = v43;
            if typeof(v41) ~= "string" or (v41:match("^[a-zA-Z_][a-zA-Z0-9_]*$") ~= v41 or not v41) then
                local v44 = "[%*]";
                local v45 = u2[typeof(v41)];
                local v46;
                if v45 then
                    v46 = v45(v41, p16);
                else
                    v46 = `[{typeof(v41)}]`;
                end;
                v41 = v44:format(v46);
            end;
            local v47 = u2[typeof(v42)];
            local v48;
            if v47 then
                v48 = v47(v42, p16);
            else
                v48 = `[{typeof(v42)}]`;
            end;
            local v49 = l__Pretty__1 and `{v41} = {v48}` or `{v41}={v48}`;
            table.insert(v26, v49);
            p16.order = l__order__3;
        end;
    end;
    p16.depth = p16.depth - 1;
    p16.seen[p15] = nil;
    if #v26 == 0 then
        return "{}";
    end;
    if not l__Pretty__1 then
        return "{" .. table.concat(v26, v25) .. "}";
    end;
    local v50 = "\n" .. string.rep(p16.cfg.IndentChar, p16.cfg.IndentSize * p16.depth);
    return "{" .. v24 .. table.concat(v26, v25) .. "," .. v50 .. "}";
end;
function u2.Color3(p51, p52) --[[ Line: 237 ]]
    -- upvalues: u2 (copy)
    local v53 = p51.R * 255;
    local v54 = p51.G * 255;
    local v55 = p51.B * 255;
    local v56 = "fromRGB";
    local v57 = v53 - math.round(v53);
    local v58, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74;
    if math.abs(v57) < 1e-6 then
        local v75 = v54 - math.round(v54);
        if math.abs(v75) < 1e-6 then
            local v76 = v55 - math.round(v55);
            if math.abs(v76) < 1e-6 then
                v58 = math.round(v53);
                v59 = math.round(v54);
                v60 = math.round(v55);
                if p52.cfg.Pretty then
                    v61 = "Color3.%*(%*, %*, %*)";
                    v62 = u2[typeof(v58)];
                    if v62 then
                        v63 = v62(v58, p52);
                    else
                        v63 = `[{typeof(v58)}]`;
                    end;
                    v64 = u2[typeof(v59)];
                    if v64 then
                        v65 = v64(v59, p52);
                    else
                        v65 = `[{typeof(v59)}]`;
                    end;
                    v66 = u2[typeof(v60)];
                    if v66 then
                        v67 = v66(v60, p52);
                    else
                        v67 = `[{typeof(v60)}]`;
                    end;
                    return v61:format(v56, v63, v65, v67);
                else
                    v68 = "Color3.%*(%*,%*,%*)";
                    v69 = u2[typeof(v58)];
                    if v69 then
                        v70 = v69(v58, p52);
                    else
                        v70 = `[{typeof(v58)}]`;
                    end;
                    v71 = u2[typeof(v59)];
                    if v71 then
                        v72 = v71(v59, p52);
                    else
                        v72 = `[{typeof(v59)}]`;
                    end;
                    v73 = u2[typeof(v60)];
                    if v73 then
                        v74 = v73(v60, p52);
                    else
                        v74 = `[{typeof(v60)}]`;
                    end;
                    return v68:format(v56, v70, v72, v74);
                end;
            end;
        end;
    end;
    v58 = p51.R;
    v59 = p51.G;
    v60 = p51.B;
    v56 = "new";
    if p52.cfg.Pretty then
        v61 = "Color3.%*(%*, %*, %*)";
        v62 = u2[typeof(v58)];
        if v62 then
            v63 = v62(v58, p52);
        else
            v63 = `[{typeof(v58)}]`;
        end;
        v64 = u2[typeof(v59)];
        if v64 then
            v65 = v64(v59, p52);
        else
            v65 = `[{typeof(v59)}]`;
        end;
        v66 = u2[typeof(v60)];
        if v66 then
            v67 = v66(v60, p52);
        else
            v67 = `[{typeof(v60)}]`;
        end;
        return v61:format(v56, v63, v65, v67);
    else
        v68 = "Color3.%*(%*,%*,%*)";
        v69 = u2[typeof(v58)];
        if v69 then
            v70 = v69(v58, p52);
        else
            v70 = `[{typeof(v58)}]`;
        end;
        v71 = u2[typeof(v59)];
        if v71 then
            v72 = v71(v59, p52);
        else
            v72 = `[{typeof(v59)}]`;
        end;
        v73 = u2[typeof(v60)];
        if v73 then
            v74 = v73(v60, p52);
        else
            v74 = `[{typeof(v60)}]`;
        end;
        return v68:format(v56, v70, v72, v74);
    end;
end;
function u2.Vector3(p77, p78) --[[ Line: 251 ]]
    -- upvalues: u2 (copy)
    if p77 == Vector3.new(0, 0, 0) then
        return "Vector3.zero";
    elseif p77 == Vector3.new(1, 1, 1) then
        return "Vector3.one";
    elseif p77 == Vector3.new(1, 0, 0) then
        return "Vector3.xAxis";
    elseif p77 == Vector3.new(0, 1, 0) then
        return "Vector3.yAxis";
    elseif p77 == Vector3.new(0, 0, 1) then
        return "Vector3.zAxis";
    elseif p78.cfg.Pretty then
        local v79 = "Vector3.new(%*, %*, %*)";
        local l__X__4 = p77.X;
        local v80 = u2[typeof(l__X__4)];
        local v81;
        if v80 then
            v81 = v80(l__X__4, p78);
        else
            v81 = `[{typeof(l__X__4)}]`;
        end;
        local l__Y__5 = p77.Y;
        local v82 = u2[typeof(l__Y__5)];
        local v83;
        if v82 then
            v83 = v82(l__Y__5, p78);
        else
            v83 = `[{typeof(l__Y__5)}]`;
        end;
        local l__Z__6 = p77.Z;
        local v84 = u2[typeof(l__Z__6)];
        local v85;
        if v84 then
            v85 = v84(l__Z__6, p78);
        else
            v85 = `[{typeof(l__Z__6)}]`;
        end;
        return v79:format(v81, v83, v85);
    else
        local v86 = "Vector3.new(%*,%*,%*)";
        local l__X__7 = p77.X;
        local v87 = u2[typeof(l__X__7)];
        local v88;
        if v87 then
            v88 = v87(l__X__7, p78);
        else
            v88 = `[{typeof(l__X__7)}]`;
        end;
        local l__Y__8 = p77.Y;
        local v89 = u2[typeof(l__Y__8)];
        local v90;
        if v89 then
            v90 = v89(l__Y__8, p78);
        else
            v90 = `[{typeof(l__Y__8)}]`;
        end;
        local l__Z__9 = p77.Z;
        local v91 = u2[typeof(l__Z__9)];
        local v92;
        if v91 then
            v92 = v91(l__Z__9, p78);
        else
            v92 = `[{typeof(l__Z__9)}]`;
        end;
        return v86:format(v88, v90, v92);
    end;
end;
function u2.Vector2(p93, p94) --[[ Line: 263 ]]
    -- upvalues: u2 (copy)
    if p93 == Vector2.zero then
        return "Vector2.zero";
    elseif p93 == Vector2.one then
        return "Vector2.one";
    elseif p93 == Vector2.xAxis then
        return "Vector2.xAxis";
    elseif p93 == Vector2.yAxis then
        return "Vector2.yAxis";
    elseif p94.cfg.Pretty then
        local v95 = "Vector2.new(%*, %*)";
        local l__X__10 = p93.X;
        local v96 = u2[typeof(l__X__10)];
        local v97;
        if v96 then
            v97 = v96(l__X__10, p94);
        else
            v97 = `[{typeof(l__X__10)}]`;
        end;
        local l__Y__11 = p93.Y;
        local v98 = u2[typeof(l__Y__11)];
        local v99;
        if v98 then
            v99 = v98(l__Y__11, p94);
        else
            v99 = `[{typeof(l__Y__11)}]`;
        end;
        return v95:format(v97, v99);
    else
        local v100 = "Vector2.new(%*,%*)";
        local l__X__12 = p93.X;
        local v101 = u2[typeof(l__X__12)];
        local v102;
        if v101 then
            v102 = v101(l__X__12, p94);
        else
            v102 = `[{typeof(l__X__12)}]`;
        end;
        local l__Y__13 = p93.Y;
        local v103 = u2[typeof(l__Y__13)];
        local v104;
        if v103 then
            v104 = v103(l__Y__13, p94);
        else
            v104 = `[{typeof(l__Y__13)}]`;
        end;
        return v100:format(v102, v104);
    end;
end;
function u2.CFrame(p105, p106) --[[ Line: 274 ]]
    -- upvalues: u2 (copy)
    if p105 == CFrame.identity then
        return "CFrame.identity";
    end;
    local l__Position__14 = p105.Position;
    local v107, v108, v109 = p105:ToOrientation();
    local l__Magnitude__15 = l__Position__14.Magnitude;
    local _, _, _, v110, v111, v112, v113, v114, v115, v116, v117, v118 = p105:GetComponents();
    local v119 = (math.abs(v110 - 1) > 1e-6 or (math.abs(v114 - 1) > 1e-6 or (math.abs(v118 - 1) > 1e-6 or (math.abs(v111) > 1e-6 or (math.abs(v112) > 1e-6 or (math.abs(v113) > 1e-6 or (math.abs(v115) > 1e-6 or math.abs(v116) > 1e-6))))))) and true or math.abs(v117) > 1e-6;
    local v120 = l__Magnitude__15 > 1e-6;
    local l__Pretty__16 = p106.cfg.Pretty;
    local v121;
    if l__Pretty__16 then
        local v122 = "CFrame.new(%*, %*, %*)";
        local v123 = math.round(l__Position__14.X * 1000000) / 1000000;
        local v124 = u2[typeof(v123)];
        local v125;
        if v124 then
            v125 = v124(v123, p106);
        else
            v125 = `[{typeof(v123)}]`;
        end;
        local v126 = math.round(l__Position__14.Y * 1000000) / 1000000;
        local v127 = u2[typeof(v126)];
        local v128;
        if v127 then
            v128 = v127(v126, p106);
        else
            v128 = `[{typeof(v126)}]`;
        end;
        local v129 = math.round(l__Position__14.Z * 1000000) / 1000000;
        local v130 = u2[typeof(v129)];
        local v131;
        if v130 then
            v131 = v130(v129, p106);
        else
            v131 = `[{typeof(v129)}]`;
        end;
        v121 = v122:format(v125, v128, v131);
        if v121 then
            local v132 = 0;
            while true do
                if v132 == 0 then
                    v132 = -1;
                    local v133;
                    if l__Pretty__16 then
                        local v134 = "CFrame.fromOrientation(math.rad(%*), math.rad(%*), math.rad(%*))";
                        local v135 = math.deg(v107) * 1000000;
                        local v136 = math.round(v135) / 1000000;
                        local v137 = u2[typeof(v136)];
                        local v138;
                        if v137 then
                            v138 = v137(v136, p106);
                        else
                            v138 = `[{typeof(v136)}]`;
                        end;
                        local v139 = math.deg(v108) * 1000000;
                        local v140 = math.round(v139) / 1000000;
                        local v141 = u2[typeof(v140)];
                        local v142;
                        if v141 then
                            v142 = v141(v140, p106);
                        else
                            v142 = `[{typeof(v140)}]`;
                        end;
                        local v143 = math.deg(v109) * 1000000;
                        local v144 = math.round(v143) / 1000000;
                        local v145 = u2[typeof(v144)];
                        local v146;
                        if v145 then
                            v146 = v145(v144, p106);
                        else
                            v146 = `[{typeof(v144)}]`;
                        end;
                        v133 = v134:format(v138, v142, v146);
                        if v133 then
                            if not v120 then
                                return v133;
                            end;
                            if v119 then
                                v121 = v121 .. (l__Pretty__16 and " * " or "*") .. v133 or v121;
                            end;
                            return v121;
                        end;
                    end;
                    local v147 = "CFrame.fromOrientation(%*,%*,%*)";
                    local v148 = u2[typeof(v107)];
                    local v149;
                    if v148 then
                        v149 = v148(v107, p106);
                    else
                        v149 = `[{typeof(v107)}]`;
                    end;
                    local v150 = u2[typeof(v108)];
                    local v151;
                    if v150 then
                        v151 = v150(v108, p106);
                    else
                        v151 = `[{typeof(v108)}]`;
                    end;
                    local v152 = u2[typeof(v109)];
                    local v153;
                    if v152 then
                        v153 = v152(v109, p106);
                    else
                        v153 = `[{typeof(v109)}]`;
                    end;
                    v133 = v147:format(v149, v151, v153);
                    goto l0;
                else
                    break;
                end;
            end;
        end;
    end;
    local v154 = "CFrame.new(%*,%*,%*)";
    local l__X__17 = l__Position__14.X;
    local v155 = u2[typeof(l__X__17)];
    local v156;
    if v155 then
        v156 = v155(l__X__17, p106);
    else
        v156 = `[{typeof(l__X__17)}]`;
    end;
    local l__Y__18 = l__Position__14.Y;
    local v157 = u2[typeof(l__Y__18)];
    local v158;
    if v157 then
        v158 = v157(l__Y__18, p106);
    else
        v158 = `[{typeof(l__Y__18)}]`;
    end;
    local l__Z__19 = l__Position__14.Z;
    local v159 = u2[typeof(l__Z__19)];
    local v160;
    if v159 then
        v160 = v159(l__Z__19, p106);
    else
        v160 = `[{typeof(l__Z__19)}]`;
    end;
    v121 = v154:format(v156, v158, v160);
    goto l1;
end;
function u2.EnumItem(p161, _) --[[ Line: 304 ]]
    return `Enum.{tostring(p161.EnumType)}.{p161.Name}`;
end;
local u169 = {
    DEFAULT_CONFIG = u1,
    Pretty = function(p162, p163) --[[ Name: Pretty, Line 316 ]]
        -- upvalues: u1 (copy), u6 (copy)
        local v164 = {
            Pretty = p163 and p163.Pretty or u1.Pretty,
            IndentChar = p163 and p163.IndentChar or u1.IndentChar,
            IndentSize = p163 and p163.IndentSize or u1.IndentSize,
            Order = p163 and p163.Order or u1.Order
        };
        return u6(p162, {
            depth = 0,
            cfg = v164,
            order = v164.Order,
            seen = {}
        });
    end,
    Serialize = function(p165, p166) --[[ Name: Serialize, Line 332 ]]
        -- upvalues: u6 (copy)
        return u6(p165, {
            depth = 0,
            cfg = p166,
            order = p166.Order,
            seen = {}
        });
    end,
    Default = function(p167) --[[ Name: Default, Line 341 ]]
        -- upvalues: u1 (copy), u6 (copy)
        local v168 = u1;
        return u6(p167, {
            depth = 0,
            cfg = v168,
            order = v168.Order,
            seen = {}
        });
    end
};
function u169.DefaultArgs(...) --[[ Line: 351 ]]
    -- upvalues: u169 (copy)
    local v170 = table.pack(...);
    local v171 = {};
    for v172 = 1, v170.n do
        if v172 > 1 then
            table.insert(v171, ", ");
        end;
        table.insert(v171, u169.Default(v170[v172]));
    end;
    return table.concat(v171);
end;
function u169.DefaultArgsPrefix(...) --[[ Line: 363 ]]
    -- upvalues: u169 (copy)
    local v173 = table.pack(...);
    local v174 = {};
    for v175 = 1, v173.n do
        table.insert(v174, ", ");
        table.insert(v174, u169.Default(v173[v175]));
    end;
    return table.concat(v174);
end;
function u169.CompileOrder(p176) --[[ Line: 373 ]]
    -- upvalues: u169 (copy)
    local v177 = type(p176) == "table";
    assert(v177);
    local v178 = #p176 ~= 0 and true or next(p176) == nil;
    assert(v178);
    local v179 = {};
    for v180, v181 in ipairs(p176) do
        if type(v181) == "table" then
            local l__Key__20 = v181.Key;
            local v182 = type(l__Key__20) == "string";
            assert(v182);
            v179[l__Key__20] = {
                Index = v180,
                Child = u169.CompileOrder(v181.Value)
            };
        else
            v179[v181] = {
                Index = v180
            };
        end;
    end;
    return v179;
end;
return table.freeze(u169);