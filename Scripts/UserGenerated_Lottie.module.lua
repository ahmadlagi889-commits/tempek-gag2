-- Decompiled with Potassium's decompiler.

local v1 = not game:GetService("RunService"):IsClient();
assert(v1);
local l__HttpService__1 = game:GetService("HttpService");
local l__AssetService__2 = game:GetService("AssetService");
local l__EncodingService__3 = game:GetService("EncodingService");
require(script.Types);
local l__Easing__4 = require(script.Easing);
local u2 = Rect.new(64, 64, 192, 192);
local u3 = UDim2.fromScale(0, 0);
local u4 = UDim2.fromScale(1, 1);
local v5, u6 = pcall(require, script.PNG);
if not v5 then
    u6 = nil;
end;
local function u24(p7, p8, p9, p10, p11, p12, p13, p14, p15, p16) --[[ Line: 109 ]]
    for v17 = 1, p15 do
        local v18 = v17 / p15;
        local v19 = 1 - v18;
        local v20 = v19 * v19;
        local v21 = v20 * v19;
        local v22 = v18 * v18;
        local v23 = v22 * v18;
        table.insert(p16, { v21 * p7 + v20 * 3 * v18 * p9 + v19 * 3 * v22 * p11 + v23 * p13, v21 * p8 + v20 * 3 * v18 * p10 + v19 * 3 * v22 * p12 + v23 * p14 });
    end;
end;
local function u44(p25) --[[ Line: 131 ]]
    -- upvalues: u24 (copy)
    local l__v__5 = p25.v;
    local l__i__6 = p25.i;
    local l__o__7 = p25.o;
    local v26 = #l__v__5;
    if v26 == 0 then
        return {};
    end;
    local v27 = {
        { l__v__5[1][1], l__v__5[1][2] }
    };
    local v28;
    if p25.c then
        v28 = v26;
    else
        v28 = v26 - 1;
    end;
    for v29 = 1, v28 do
        local v30 = v29 >= v26 and 1 or v29 + 1;
        local v31 = l__v__5[v29];
        local v32 = l__v__5[v30];
        local v33 = l__o__7[v29];
        local v34 = l__i__6[v30];
        local v35 = v31[1];
        local v36 = v31[2];
        local v37 = v35 + v33[1];
        local v38 = v36 + v33[2];
        local v39 = v32[1] + v34[1];
        local v40 = v32[2] + v34[2];
        local v41 = v32[1];
        local v42 = v32[2];
        local v43;
        if math.abs(v33[1]) < 0.01 and (math.abs(v33[2]) < 0.01 and math.abs(v34[1]) < 0.01) then
            v43 = math.abs(v34[2]) < 0.01;
        else
            v43 = false;
        end;
        if v43 then
            table.insert(v27, { v41, v42 });
        else
            u24(v35, v36, v37, v38, v39, v40, v41, v42, 12, v27);
        end;
    end;
    return v27;
end;
local function u56(p45, p46, p47, p48, p49, p50, p51, p52) --[[ Line: 172 ]]
    local v53 = (p47 - p45) * (p50 - p46) - (p48 - p46) * (p49 - p45);
    local v54 = (p49 - p45) * (p52 - p46) - (p50 - p46) * (p51 - p45);
    local v55 = (p51 - p45) * (p48 - p46) - (p52 - p46) * (p47 - p45);
    return (v53 >= 0 and v54 >= 0 and v55 >= 0 or v53 <= 0 and v54 <= 0 and v55 <= 0) and true or false;
end;
local function u66(p57) --[[ Line: 181 ]]
    local v58 = #p57;
    if v58 < 3 then
        return false;
    end;
    local v59 = 0;
    for v60 = 1, v58 do
        local v61 = v60 >= v58 and 1 or v60 + 1;
        local v62 = v61 >= v58 and 1 or v61 + 1;
        local v63 = p57[v60][1];
        local v64 = p57[v60][2];
        local v65 = (p57[v61][1] - v63) * (p57[v62][2] - v64) - (p57[v61][2] - v64) * (p57[v62][1] - v63);
        if v65 ~= 0 then
            if v59 == 0 then
                if v65 > 0 then
                    v59 = 1;
                else
                    v59 = -1;
                end;
            elseif v65 > 0 and v59 < 0 or v65 < 0 and v59 > 0 then
                return false;
            end;
        end;
    end;
    return true;
end;
local function u70(p67) --[[ Line: 204 ]]
    local v68 = {};
    for v69 = 2, #p67 - 1 do
        table.insert(v68, { p67[1], p67[v69], p67[v69 + 1] });
    end;
    return v68;
end;
local function u93(p71) --[[ Line: 212 ]]
    -- upvalues: u66 (copy), u70 (copy), u56 (copy)
    local v72 = #p71;
    if v72 < 3 then
        return {};
    end;
    if v72 == 3 then
        return {
            { p71[1], p71[2], p71[3] }
        };
    end;
    if u66(p71) then
        return u70(p71);
    end;
    local v73 = table.create(v72);
    local v74 = 0;
    for v75 = 1, v72 do
        v73[v75] = v75;
        local v76 = v75 >= v72 and 1 or v75 + 1;
        v74 = v74 + (p71[v76][1] - p71[v75][1]) * (p71[v76][2] + p71[v75][2]);
    end;
    local v77;
    if v74 > 0 then
        v77 = table.create(v72);
        for v78 = 1, v72 do
            v77[v78] = v73[v72 - v78 + 1];
        end;
    else
        v77 = v73;
    end;
    local v79 = #v77;
    local v80 = v79 * v79;
    local v81 = 0;
    local v82 = 1;
    local v83 = {};
    while true do
        while true do
            if v79 <= 2 or v81 >= v80 then
                return v83;
            end;
            v81 = v81 + 1;
            v82 = v79 < v82 and 1 or v82;
            local v84;
            if v82 > 1 then
                v84 = v82 - 1;
            else
                v84 = v79;
            end;
            local v85 = v82 >= v79 and 1 or v82 + 1;
            local v86 = p71[v77[v84]];
            local v87 = p71[v77[v82]];
            local v88 = p71[v77[v85]];
            local v89 = v86[1];
            local v90 = v86[2];
            if (v87[1] - v89) * (v88[2] - v90) - (v87[2] - v90) * (v88[1] - v89) <= 0 then
                break;
            end;
            local v91 = true;
            for v92 = 1, v79 do
                if v92 ~= v84 and (v92 ~= v82 and (v92 ~= v85 and u56(p71[v77[v92]][1], p71[v77[v92]][2], v86[1], v86[2], v87[1], v87[2], v88[1], v88[2]))) then
                    v91 = false;
                    break;
                end;
            end;
            if not v91 then
                break;
            end;
            table.insert(v83, { v86, v87, v88 });
            table.remove(v77, v82);
            v79 = v79 - 1;
            if v79 < v82 then
                v82 = 1;
            end;
        end;
        v82 = v82 + 1;
    end;
end;
local function u117(p94, p95, p96, p97, p98, p99, p100, p101, p102) --[[ Line: 285 ]]
    local v103 = p97 - p95;
    local v104 = p98 - p96;
    local v105 = p99 - p95;
    local v106 = p100 - p96;
    if v103 * v106 - v104 * v105 < 0 then
        v103 = p99 - p95;
        v104 = p100 - p96;
        v105 = p97 - p95;
        v106 = p98 - p96;
    end;
    local v107 = math.sqrt(v103 * v103 + v104 * v104);
    local v108 = math.sqrt(v105 * v105 + v106 * v106);
    if v107 < 1e-6 or v108 < 1e-6 then
        p94.A.Visible = false;
        p94.B.Visible = false;
    else
        local v109 = v103 / v107;
        local v110 = v104 / v107;
        local v111 = v105 * v109 + v106 * v110;
        local v112 = v105 - v109 * v111;
        local v113 = v106 - v110 * v111;
        local v114 = math.sqrt(v112 * v112 + v113 * v113);
        if v114 < 1e-6 then
            p94.A.Visible = false;
            p94.B.Visible = false;
        else
            local v115 = math.atan2(v110, v109) * 57.29577951308232;
            local l__A__8 = p94.A;
            l__A__8.Visible = true;
            l__A__8.Position = UDim2.fromScale(p95, p96);
            l__A__8.Size = UDim2.fromScale(math.max(v111, 0.0001), v114);
            l__A__8.Rotation = v115;
            l__A__8.AnchorPoint = Vector2.zero;
            l__A__8.ImageColor3 = p101;
            l__A__8.ImageTransparency = p102;
            local l__B__9 = p94.B;
            local v116 = v107 - v111;
            l__B__9.Visible = v116 > 1e-6;
            if l__B__9.Visible then
                l__B__9.Position = UDim2.fromScale(p95 + v109 * v107, p96 + v110 * v107);
                l__B__9.Size = UDim2.fromScale(math.max(v116, 0.0001), v114);
                l__B__9.Rotation = v115 + 180;
                l__B__9.AnchorPoint = Vector2.zero;
                l__B__9.ImageColor3 = p101;
                l__B__9.ImageTransparency = p102;
            end;
        end;
    end;
end;
local function u137(p118, p119, p120, p121, p122, p123, p124) --[[ Line: 359 ]]
    -- upvalues: u44 (copy), u93 (copy), u117 (copy)
    local v125 = u44(p119);
    if #v125 < 3 then
    else
        local v126 = table.create(#v125);
        for v127, v128 in v125 do
            v126[v127] = { v128[1] / p121, v128[2] / p122 };
        end;
        local v129 = u93(v126);
        local v130 = p118.Triangles or {};
        for v131, v132 in v129 do
            local v133;
            if v131 <= #v130 then
                v133 = v130[v131];
            else
                v133 = {};
                local v134 = Instance.new("ImageLabel");
                v134.Image = "rbxassetid://83051256678409";
                v134.BackgroundTransparency = 1;
                v134.BorderSizePixel = 0;
                v134.Size = UDim2.fromScale(1, 1);
                v134.Parent = p120;
                v133.A = v134;
                local v135 = Instance.new("ImageLabel");
                v135.Image = "rbxassetid://83051256678409";
                v135.BackgroundTransparency = 1;
                v135.BorderSizePixel = 0;
                v135.Size = UDim2.fromScale(1, 1);
                v135.Parent = p120;
                v133.B = v135;
                table.insert(v130, v133);
            end;
            u117(v133, v132[1][1], v132[1][2], v132[2][1], v132[2][2], v132[3][1], v132[3][2], p123, p124);
        end;
        for v136 = #v129 + 1, #v130 do
            v130[v136].A.Visible = false;
            v130[v136].B.Visible = false;
        end;
        p118.Triangles = v130;
    end;
end;
local function u184(p138, p139, p140, p141, p142, p143, p144, p145, p146, p147, p148, p149) --[[ Line: 403 ]]
    -- upvalues: u44 (copy), l__Easing__4 (copy)
    local v150 = u44(p139);
    if #v150 < 2 then
        return;
    end;
    local v151 = p138.Segments or {};
    local v152 = 0;
    local v153 = { 0 };
    local v154 = p148 or 100;
    local v155 = p149 or 0;
    local v156 = p147 or 0;
    for v157 = 2, #v150 do
        local v158 = v150[v157][1] - v150[v157 - 1][1];
        local v159 = v150[v157][2] - v150[v157 - 1][2];
        v152 = v152 + math.sqrt(v158 * v158 + v159 * v159);
        v153[v157] = v152;
    end;
    local v160 = nil;
    local v161;
    if p146 then
        v161 = {};
        for _, v162 in p146 do
            if v162.v then
                table.insert(v161, l__Easing__4.EvaluateScalar(v162.v, 0));
            end;
        end;
        if #v161 <= 0 then
            v161 = v160;
        end;
    else
        v161 = v160;
    end;
    local v163 = p145 / math.min(p141, p142);
    local v164 = 0;
    for v165 = 2, #v150 do
        local v166 = v150[v165 - 1];
        local v167 = v150[v165];
        local v168 = v167[1] - v166[1];
        local v169 = v167[2] - v166[2];
        local v170 = math.sqrt(v168 * v168 + v169 * v169);
        if v170 >= 0.01 then
            local v171 = ((v153[v165 - 1] + v153[v165]) * 0.5 / math.max(v152, 1e-6) * 100 + v155) % 100;
            if v171 >= v156 and v154 >= v171 then
                local v172 = true;
                if v161 then
                    local v173 = v153[v165 - 1];
                    local v174 = 0;
                    for _, v175 in v161 do
                        v174 = v174 + v175;
                    end;
                    if v174 > 0 then
                        local v176 = v173 % v174;
                        local v177 = 0;
                        for v178, v179 in v161 do
                            v177 = v177 + v179;
                            if v176 < v177 then
                                v172 = v178 % 2 == 1;
                                break;
                            end;
                        end;
                    end;
                end;
                v164 = v164 + 1;
                local v180;
                if v164 <= #v151 then
                    v180 = v151[v164];
                else
                    v180 = Instance.new("Frame");
                    v180.BorderSizePixel = 0;
                    v180.AnchorPoint = Vector2.new(0, 0.5);
                    v180.Parent = p140;
                    table.insert(v151, v180);
                end;
                v180.Visible = v172;
                if v172 then
                    local v181 = math.atan2(v169, v168) * 57.29577951308232;
                    local v182 = v170 / p141;
                    v180.Position = UDim2.fromScale(v166[1] / p141, v166[2] / p142);
                    v180.Size = UDim2.fromScale(v182, v163);
                    v180.Rotation = v181;
                    v180.BackgroundColor3 = p143;
                    v180.BackgroundTransparency = p144;
                end;
            end;
        end;
    end;
    for v183 = v164 + 1, #v151 do
        v151[v183].Visible = false;
    end;
    p138.Segments = v151;
end;
local function u203(p185, p186, p187, p188, p189) --[[ Line: 509 ]]
    -- upvalues: l__Easing__4 (copy)
    local v190 = Instance.new("UIGradient");
    local l__p__10 = p186.p;
    local v191 = l__Easing__4.EvaluateVector(p186.k, p189, {});
    local v192 = {};
    for v193 = 0, l__p__10 - 1 do
        local v194 = v193 * 4;
        local v195 = v191[v194 + 1] or v193 / math.max(l__p__10 - 1, 1);
        local v196 = v191[v194 + 2] or 1;
        local v197 = v191[v194 + 3] or 1;
        local v198 = v191[v194 + 4] or 1;
        local l__new__11 = ColorSequenceKeypoint.new;
        local v199 = math.clamp(v195, 0, 1);
        table.insert(v192, l__new__11(v199, Color3.new(v196, v197, v198)));
    end;
    local v200 = #v192 < 2 and { ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) } or v192;
    v190.Color = ColorSequence.new(v200);
    local v201 = l__Easing__4.EvaluateVector(p187, p189, { 0, 0 });
    local v202 = l__Easing__4.EvaluateVector(p188, p189, { 1, 0 });
    v190.Rotation = math.atan2(v202[2] - v201[2], v202[1] - v201[1]) * 57.29577951308232;
    v190.Parent = p185;
    return v190;
end;
local function u231(p204, p205, p206, p207, p208, p209, p210) --[[ Line: 548 ]]
    -- upvalues: l__Easing__4 (copy)
    local l__p__12 = p205.p;
    local v211 = l__Easing__4.EvaluateVector(p205.k, p208, {});
    local v212 = l__Easing__4.EvaluateVector(p206, p208, { p209 / 2, p210 / 2 });
    local v213 = l__Easing__4.EvaluateVector(p207, p208, { p209, p210 / 2 });
    local v214 = v212[1];
    local v215 = v212[2];
    local v216 = v213[1] - v214;
    local v217 = v213[2] - v215;
    local v218 = math.sqrt(v216 * v216 + v217 * v217);
    local v219 = math.min(l__p__12, 6);
    local v220 = {};
    for v221 = v219, 1, -1 do
        local v222 = v221 / v219;
        local v223 = math.floor(v222 * (l__p__12 - 1));
        local v224 = math.min(v223, l__p__12 - 1) * 4;
        local v225 = v211[v224 + 2] or 1;
        local v226 = v211[v224 + 3] or 1;
        local v227 = v211[v224 + 4] or 1;
        local v228 = v218 * 2 * v222;
        local v229 = Instance.new("Frame");
        v229.AnchorPoint = Vector2.new(0.5, 0.5);
        v229.Position = UDim2.fromScale(v214 / p209, v215 / p210);
        v229.Size = UDim2.fromScale(v228 / p209, v228 / p210);
        v229.BackgroundColor3 = Color3.new(v225, v226, v227);
        v229.BackgroundTransparency = 0;
        v229.BorderSizePixel = 0;
        local v230 = Instance.new("UICorner");
        v230.CornerRadius = UDim.new(0.5, 0);
        v230.Parent = v229;
        v229.Parent = p204;
        table.insert(v220, v229);
    end;
    return v220;
end;
local function u249(p232, p233, p234, p235, p236, p237, p238, p239) --[[ Line: 597 ]]
    -- upvalues: l__Easing__4 (copy)
    if p233 == nil then
    else
        local l__p__13 = p233.p;
        local v240;
        if l__p__13 == nil or type(l__p__13) ~= "table" then
            v240 = { 0, 0 };
        elseif l__p__13.s == true then
            v240 = { l__Easing__4.EvaluateScalarAtFrame(l__p__13.x, p234, 0), (l__Easing__4.EvaluateScalarAtFrame(l__p__13.y, p234, 0)) };
        else
            v240 = l__Easing__4.EvaluateVector(l__p__13, p234, { 0, 0 });
        end;
        local v241 = l__Easing__4.EvaluateVector(p233.s, p234, { 100, 100 });
        local v242 = l__Easing__4.EvaluateScalarAtFrame(p233.r, p234, 0);
        local v243 = l__Easing__4.EvaluateScalarAtFrame(p233.o, p234, 100);
        local v244 = l__Easing__4.EvaluateVector(p233.a, p234, { 0, 0 });
        local v245 = v241[1] / 100;
        local v246 = v241[2] / 100;
        p232.Position = UDim2.fromScale(v240[1] / p235, v240[2] / p236);
        p232.Rotation = v242;
        p232.Size = UDim2.fromScale(p238 * v245, p239 * v246);
        if p237 then
            p232.GroupTransparency = 1 - v243 / 100;
        end;
        local v247 = p238 * v245 * p235;
        local v248 = p239 * v246 * p236;
        if (v244[1] ~= 0 or v244[2] ~= 0) and (v247 > 0 and v248 > 0) then
            p232.AnchorPoint = Vector2.new(math.clamp(v244[1] / v247, 0, 1), (math.clamp(v244[2] / v248, 0, 1)));
        end;
    end;
end;
local function u265(p250) --[[ Line: 651 ]]
    local v251 = nil;
    local v252 = nil;
    local v253 = nil;
    local v254 = nil;
    local v255 = nil;
    local v256 = nil;
    local v257 = nil;
    local v258 = nil;
    local v259 = nil;
    local v260 = nil;
    local v261 = nil;
    local v262 = nil;
    local v263 = nil;
    for _, v264 in p250 do
        if not v264.hd then
            local l__ty__14 = v264.ty;
            if l__ty__14 == "fl" then
                v256 = v264.c;
                v257 = v264.o;
            elseif l__ty__14 == "st" then
                v258 = v264.c;
                v259 = v264.o;
                v260 = v264.w;
                v262 = v264.da;
            elseif l__ty__14 == "sh" then
                v261 = v264.ks;
            elseif l__ty__14 == "tr" then
                v254 = v264;
            elseif l__ty__14 == "tm" then
                v263 = v264.s;
                v251 = v264.e;
                v252 = v264.o;
                v253 = v264.m;
            elseif l__ty__14 == "mm" then
                v255 = v264.mm;
            end;
        end;
    end;
    return v256, v257, v258, v259, v260, v261, v262, v263, v251, v252, v253, v254, v255;
end;
local function u333(p266, p267, p268, p269, p270) --[[ Line: 696 ]]
    -- upvalues: u265 (copy), u4 (copy), u3 (copy), u249 (copy), l__Easing__4 (copy), u137 (copy), u184 (copy), u203 (copy), u231 (copy), u333 (copy)
    local v271 = p266.it or {};
    local v272, v273, v274, v275, v276, v277, v278, v279, v280, v281, _, v282, _ = u265(v271);
    local v283 = false;
    for _, v284 in v271 do
        if v284.ty == "tr" then
            local l__o__15 = v284.o;
            local v285;
            if l__o__15 == nil then
                v285 = false;
            else
                v285 = l__o__15.a == 1;
            end;
            if v285 then
                v283 = true;
                break;
            end;
        end;
    end;
    local v286;
    if v283 then
        v286 = Instance.new("CanvasGroup");
    else
        v286 = Instance.new("Frame");
    end;
    v286.BackgroundTransparency = 1;
    v286.BorderSizePixel = 0;
    v286.Size = u4;
    v286.Position = u3;
    v286.Parent = p267;
    if v282 then
        u249(v286, {
            a = v282.a,
            p = v282.p,
            s = v282.s,
            r = v282.r,
            o = v282.o
        }, p270, p268, p269, v283, 1, 1);
    end;
    local v287 = {
        Shape = p266,
        Frame = v286,
        Children = {},
        FillColor = v272,
        FillOpacity = v273,
        StrokeColor = v274,
        StrokeOpacity = v275,
        StrokeWidth = v276,
        PathData = v277
    };
    local v288;
    if v277 == nil then
        v288 = false;
    else
        v288 = v277.a == 1;
    end;
    v287.IsAnimatedPath = v288;
    local v289 = l__Easing__4.EvaluateColor(v272, p270);
    local v290 = 1 - l__Easing__4.EvaluateScalarAtFrame(v273, p270, 100) / 100;
    local v291 = l__Easing__4.EvaluateColor(v274, p270);
    local v292 = 1 - l__Easing__4.EvaluateScalarAtFrame(v275, p270, 100) / 100;
    local v293 = l__Easing__4.EvaluateScalarAtFrame(v276, p270, 0);
    local v294 = l__Easing__4.EvaluateScalarAtFrame(v279, p270, 0);
    local v295 = l__Easing__4.EvaluateScalarAtFrame(v280, p270, 100);
    local v296 = l__Easing__4.EvaluateScalarAtFrame(v281, p270, 0);
    local v297 = 0;
    for _, v298 in v271 do
        if v298.ty == "op" and v298.a then
            v297 = l__Easing__4.EvaluateScalarAtFrame(v298.a, p270, 0);
        end;
    end;
    for _, v299 in v271 do
        if not v299.hd then
            local l__ty__16 = v299.ty;
            if l__ty__16 == "sh" then
                local v300 = l__Easing__4.EvaluateBezierShape(v299.ks, p270);
                if v300 and v297 ~= 0 then
                    local v301 = 0;
                    local v302 = 0;
                    for _, v303 in v300.v do
                        v301 = v301 + v303[1];
                        v302 = v302 + v303[2];
                    end;
                    local v304 = v301 / #v300.v;
                    local v305 = v302 / #v300.v;
                    local v306 = math.sqrt((v300.v[1][1] - v304) ^ 2 + (v300.v[1][2] - v305) ^ 2);
                    local v307 = v297 / math.max(v306, 1) + 1;
                    local v308 = table.create(#v300.v);
                    for v309, v310 in v300.v do
                        v308[v309] = { v304 + (v310[1] - v304) * v307, v305 + (v310[2] - v305) * v307 };
                    end;
                    v300 = {
                        v = v308,
                        i = v300.i,
                        o = v300.o,
                        c = v300.c
                    };
                end;
                if v300 then
                    if v272 then
                        u137(v287, v300, v286, p268, p269, v289, v290);
                    end;
                    if v274 and v293 > 0 then
                        u184(v287, v300, v286, p268, p269, v291, v292, v293, v278, v294, v295, v296);
                    end;
                end;
            elseif l__ty__16 == "rc" then
                local v311 = Instance.new("Frame");
                v311.BorderSizePixel = 0;
                local v312 = l__Easing__4.EvaluateVector(v299.s, p270, { 100, 100 });
                local v313 = l__Easing__4.EvaluateVector(v299.p, p270, { 0, 0 });
                local v314 = l__Easing__4.EvaluateScalarAtFrame(v299.r, p270, 0);
                v311.Size = UDim2.fromScale(v312[1] / p268, v312[2] / p269);
                v311.Position = UDim2.fromScale(v313[1] / p268, v313[2] / p269);
                v311.AnchorPoint = Vector2.new(0.5, 0.5);
                if v272 then
                    v311.BackgroundColor3 = v289;
                    v311.BackgroundTransparency = v290;
                else
                    v311.BackgroundTransparency = 1;
                end;
                if v314 > 0 then
                    local v315 = Instance.new("UICorner");
                    v315.CornerRadius = UDim.new(0, v314);
                    v315.Parent = v311;
                    v287.UICorner = v315;
                end;
                if v274 and v293 > 0 then
                    local u316 = Instance.new("UIStroke");
                    u316.Color = v291;
                    u316.Transparency = v292;
                    u316.Thickness = v293 / math.min(p268, p269);
                    u316.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    if not pcall(function() --[[ Line: 836 ]]
                        -- upvalues: u316 (copy)
                        u316.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
                    end) then
                        u316.Thickness = v293;
                    end;
                    u316.Parent = v311;
                    v287.UIStroke = u316;
                end;
                v311.Parent = v286;
                v287.Frame = v311;
            elseif l__ty__16 == "el" then
                local v317 = Instance.new("Frame");
                v317.BorderSizePixel = 0;
                local v318 = l__Easing__4.EvaluateVector(v299.s, p270, { 100, 100 });
                local v319 = l__Easing__4.EvaluateVector(v299.p, p270, { 0, 0 });
                v317.Size = UDim2.fromScale(v318[1] / p268, v318[2] / p269);
                v317.Position = UDim2.fromScale(v319[1] / p268, v319[2] / p269);
                v317.AnchorPoint = Vector2.new(0.5, 0.5);
                if v272 then
                    v317.BackgroundColor3 = v289;
                    v317.BackgroundTransparency = v290;
                else
                    v317.BackgroundTransparency = 1;
                end;
                local v320 = Instance.new("UICorner");
                v320.CornerRadius = UDim.new(0.5, 0);
                v320.Parent = v317;
                v287.UICorner = v320;
                if v274 and v293 > 0 then
                    local u321 = Instance.new("UIStroke");
                    u321.Color = v291;
                    u321.Transparency = v292;
                    u321.Thickness = v293 / math.min(p268, p269);
                    u321.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    pcall(function() --[[ Line: 877 ]]
                        -- upvalues: u321 (copy)
                        u321.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
                    end);
                    u321.Parent = v317;
                    v287.UIStroke = u321;
                end;
                v317.Parent = v286;
                v287.Frame = v317;
            elseif l__ty__16 == "gf" or l__ty__16 == "gs" then
                local v322 = v299.t or 1;
                if v299.g then
                    if v322 == 1 then
                        v287.UIGradient = u203(v286, v299.g, v299.s, v299.e, p270);
                    elseif v322 == 2 then
                        u231(v286, v299.g, v299.s, v299.e, p270, p268, p269);
                    end;
                end;
            elseif l__ty__16 == "gr" then
                local v323 = u333(v299, v286, p268, p269, p270);
                if v287.Children then
                    table.insert(v287.Children, v323);
                end;
            elseif l__ty__16 == "rp" then
                local v324 = l__Easing__4.EvaluateScalarAtFrame(v299.c, p270, 1);
                local l__tr__17 = v299.tr;
                if l__tr__17 and v324 > 1 then
                    local v325 = l__Easing__4.EvaluateScalarAtFrame(l__tr__17.so, p270, 100);
                    local v326 = l__Easing__4.EvaluateScalarAtFrame(l__tr__17.eo, p270, 100);
                    for v327 = 0, math.floor(v324) - 1 do
                        local v328 = Instance.new("Frame");
                        v328.BackgroundTransparency = 1;
                        v328.BorderSizePixel = 0;
                        v328.Size = u4;
                        local v329 = v327 / math.max(v324 - 1, 1);
                        v328.BackgroundTransparency = 1 - math.lerp(v325, v326, v329) / 100;
                        local _ = {
                            p = l__tr__17.p,
                            s = l__tr__17.s,
                            r = l__tr__17.r,
                            a = l__tr__17.a,
                            o = l__tr__17.o
                        };
                        local v330 = l__Easing__4.EvaluateVector(l__tr__17.p, p270, { 0, 0 });
                        l__Easing__4.EvaluateVector(l__tr__17.s, p270, { 100, 100 });
                        local v331 = l__Easing__4.EvaluateScalarAtFrame(l__tr__17.r, p270, 0);
                        v328.Position = UDim2.fromScale(v330[1] * v327 / p268, v330[2] * v327 / p269);
                        v328.Rotation = v331 * v327;
                        v328.Parent = v286;
                        for _, v332 in v271 do
                            if v332.ty == "gr" and v332 ~= p266 then
                                u333(v332, v328, p268, p269, p270);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    return v287;
end;
local function u343(p334, p335, p336, p337, p338) --[[ Line: 950 ]]
    -- upvalues: u333 (copy)
    local l__shapes__18 = p334.shapes;
    if l__shapes__18 == nil then
        return {};
    end;
    local v339 = {};
    for v340 = #l__shapes__18, 1, -1 do
        local v341 = l__shapes__18[v340];
        if not v341.hd and v341.ty == "gr" then
            local v342 = u333(v341, p335, p336, p337, p338);
            table.insert(v339, v342);
        end;
    end;
    return v339;
end;
local function u354(p344, p345, _, p346, p347) --[[ Line: 967 ]]
    -- upvalues: u4 (copy)
    local l__t__19 = p344.t;
    if l__t__19 == nil then
        return nil;
    end;
    local l__d__20 = l__t__19.d;
    if l__d__20 == nil then
        return nil;
    end;
    local l__k__21 = l__d__20.k;
    if l__k__21 == nil or #l__k__21 == 0 then
        return nil;
    end;
    local u348 = nil;
    for _, v349 in l__k__21 do
        if v349.t == nil or v349.t <= p347 then
            u348 = v349.s;
        end;
    end;
    if u348 == nil then
        u348 = l__k__21[1].s;
    end;
    if u348 == nil then
        return nil;
    end;
    local v350 = Instance.new("TextLabel");
    v350.BackgroundTransparency = 1;
    v350.BorderSizePixel = 0;
    v350.Size = u4;
    v350.Text = u348.t or "";
    v350.TextScaled = false;
    v350.RichText = false;
    v350.TextSize = (u348.s or 24) / p346 * 100;
    if u348.fc then
        local l__fc__22 = u348.fc;
        v350.TextColor3 = Color3.new(l__fc__22[1] or 1, l__fc__22[2] or 1, l__fc__22[3] or 1);
    end;
    local v351 = u348.j or 0;
    if v351 == 0 then
        v350.TextXAlignment = Enum.TextXAlignment.Left;
    elseif v351 == 1 then
        v350.TextXAlignment = Enum.TextXAlignment.Right;
    else
        v350.TextXAlignment = Enum.TextXAlignment.Center;
    end;
    v350.TextYAlignment = Enum.TextYAlignment.Top;
    if u348.f then
        local v352, v353 = pcall(function() --[[ Line: 1013 ]]
            -- upvalues: u348 (ref)
            return Enum.Font[u348.f];
        end);
        if v352 and v353 then
            v350.Font = v353;
        else
            v350.Font = Enum.Font.GothamMedium;
        end;
    end;
    v350.Parent = p345;
    return v350;
end;
local function u366(p355, p356, p357, _, _) --[[ Line: 1027 ]]
    -- upvalues: u4 (copy), u6 (ref), l__EncodingService__3 (copy), l__AssetService__2 (copy)
    local l__refId__23 = p355.refId;
    if l__refId__23 == nil then
        return nil;
    end;
    local v358 = p357[l__refId__23];
    if v358 == nil then
        return nil;
    end;
    local v359 = Instance.new("ImageLabel");
    v359.BackgroundTransparency = 1;
    v359.BorderSizePixel = 0;
    v359.Size = u4;
    v359.ScaleType = Enum.ScaleType.Stretch;
    if v358.e == 1 and v358.p then
        local l__p__24 = v358.p;
        if string.sub(l__p__24, 1, 22) == "data:image/png;base64," then
            local u360 = string.sub(l__p__24, 23);
            if u6 then
                local v362, u363 = pcall(function() --[[ Line: 1053 ]]
                    -- upvalues: l__EncodingService__3 (ref), u360 (copy), u6 (ref)
                    local v361 = l__EncodingService__3:Base64Decode(buffer.fromstring(u360));
                    return u6.decode(v361);
                end);
                if v362 and u363 then
                    local v364, u365 = pcall(function() --[[ Line: 1058 ]]
                        -- upvalues: l__AssetService__2 (ref), u363 (copy)
                        return l__AssetService__2:CreateEditableImage({
                            Size = Vector2.new(u363.width, u363.height)
                        });
                    end);
                    if v364 and (u365 and pcall(function() --[[ Line: 1062 ]]
                        -- upvalues: u365 (copy), u363 (copy)
                        u365:WritePixelsBuffer(Vector2.zero, Vector2.new(u363.width, u363.height), u363.pixels);
                    end)) then
                        v359.ImageContent = Content.fromObject(u365);
                    end;
                end;
            end;
        elseif string.sub(l__p__24, 1, 23) == "data:image/jpeg;base64," then
            warn("[Lottie] Embedded JPEG not supported, skipping image layer:", p355.nm or "");
        end;
    elseif v358.p and not v358.e then
        v359.Image = v358.p;
    end;
    v359.Parent = p356;
    return v359;
end;
local function u384(p367, p368, p369, p370, p371) --[[ Line: 1086 ]]
    -- upvalues: l__Easing__4 (copy), u2 (copy)
    local l__ef__25 = p367.ef;
    if l__ef__25 == nil then
    else
        for _, v372 in l__ef__25 do
            if v372.ty == 25 then
                local l__ef__26 = v372.ef;
                if l__ef__26 ~= nil then
                    local v373 = Color3.new(0, 0, 0);
                    local v374 = 0;
                    local v375 = 5;
                    local v376 = 5;
                    local v377 = 0.5;
                    for _, v378 in l__ef__26 do
                        local l__ty__27 = v378.ty;
                        if l__ty__27 ~= nil then
                            if l__ty__27 == 1 then
                                v373 = l__Easing__4.EvaluateColor(v378.v, p371);
                            elseif l__ty__27 == 0 then
                                v377 = l__Easing__4.EvaluateScalarAtFrame(v378.v, p371, 128) / 255;
                            elseif l__ty__27 == 3 then
                                v374 = l__Easing__4.EvaluateScalarAtFrame(v378.v, p371, 0);
                            elseif l__ty__27 == 2 then
                                v375 = l__Easing__4.EvaluateScalarAtFrame(v378.v, p371, 5);
                            elseif l__ty__27 == 4 then
                                v376 = l__Easing__4.EvaluateScalarAtFrame(v378.v, p371, 5);
                            end;
                        end;
                    end;
                    local v379 = math.rad(v374 + 180);
                    local v380 = math.cos(v379) * v375 / p369;
                    local v381 = math.sin(v379) * v375 / p370;
                    local v382 = (v376 * 2 + math.max(p369, p370)) / math.max(p369, p370);
                    local v383 = Instance.new("ImageLabel");
                    v383.Image = "rbxassetid://100849323991833";
                    v383.ScaleType = Enum.ScaleType.Slice;
                    v383.SliceCenter = u2;
                    v383.ImageColor3 = v373;
                    v383.ImageTransparency = 1 - v377;
                    v383.BackgroundTransparency = 1;
                    v383.BorderSizePixel = 0;
                    v383.AnchorPoint = Vector2.new(0.5, 0.5);
                    v383.Position = UDim2.fromScale(v380 + 0.5, v381 + 0.5);
                    v383.Size = UDim2.fromScale(v382, v382);
                    v383.ZIndex = -1;
                    v383.Parent = p368;
                    return;
                end;
            end;
        end;
    end;
end;
local function u430(p385, p386, p387, p388, p389, p390) --[[ Line: 1148 ]]
    -- upvalues: u4 (copy), u343 (copy), u354 (copy), u366 (copy), u430 (copy), u384 (copy), l__Easing__4 (copy), u249 (copy)
    local v391 = {};
    local v392 = {};
    for v393 = #p385, 1, -1 do
        local v394 = p385[v393];
        if not v394.hd then
            local l__ty__28 = v394.ty;
            local l__ks__29 = v394.ks;
            local v395;
            if l__ks__29 == nil then
                v395 = false;
            else
                local l__o__30 = l__ks__29.o;
                if l__o__30 == nil then
                    v395 = false;
                else
                    v395 = l__o__30.a == 1;
                end;
            end;
            local v396;
            if l__ty__28 == 1 then
                v396 = Instance.new("Frame");
                v396.BorderSizePixel = 0;
                local v397;
                if v394.sc then
                    local l__sc__31 = v394.sc;
                    local v398 = string.sub(l__sc__31, 2, 3);
                    local v399 = tonumber(v398, 16) or 0;
                    local v400 = string.sub(l__sc__31, 4, 5);
                    local v401 = tonumber(v400, 16) or 0;
                    local v402 = string.sub(l__sc__31, 6, 7);
                    local v403 = tonumber(v402, 16) or 0;
                    v397 = Color3.fromRGB(v399, v401, v403);
                else
                    v397 = Color3.new(0, 0, 0);
                end;
                v396.BackgroundColor3 = v397;
                v396.BackgroundTransparency = 0;
                v396.Size = UDim2.fromScale((v394.sw or p388) / p388, (v394.sh or p389) / p389);
            elseif v395 then
                v396 = Instance.new("CanvasGroup");
                v396.BackgroundTransparency = 1;
                v396.BorderSizePixel = 0;
                v396.Size = u4;
            else
                v396 = Instance.new("Frame");
                v396.BackgroundTransparency = 1;
                v396.BorderSizePixel = 0;
                v396.Size = u4;
            end;
            v396.Name = v394.nm or `Layer_{v394.ind or v393}`;
            local l__Scale__32 = v396.Size.X.Scale;
            local l__Scale__33 = v396.Size.Y.Scale;
            local v404 = {
                Layer = v394,
                Frame = v396,
                BaseSizeX = l__Scale__32,
                BaseSizeY = l__Scale__33
            };
            if v394.ind then
                v391[v394.ind] = v404;
            end;
            if l__ty__28 == 4 then
                v404.Shapes = u343(v394, v396, p388, p389, p390);
            elseif l__ty__28 == 5 then
                v404.TextLabel = u354(v394, v396, p388, p389, p390);
            elseif l__ty__28 == 2 then
                v404.ImageLabel = u366(v394, v396, p387, p388, p389);
            elseif l__ty__28 == 0 then
                local l__refId__34 = v394.refId;
                if l__refId__34 and p387[l__refId__34] then
                    local v405 = p387[l__refId__34];
                    if v405.layers then
                        local v406 = v394.w or (v405.w or p388);
                        local v407 = v394.h or (v405.h or p389);
                        v396.ClipsDescendants = true;
                        v396.Size = UDim2.fromScale(v406 / p388, v407 / p389);
                        v404.Children = u430(v405.layers, v396, p387, v406, v407, p390);
                    end;
                end;
            end;
            u384(v394, v396, p388, p389, p390);
            if v394.masksProperties then
                for _, v408 in v394.masksProperties do
                    if v408.mode == "a" or v408.mode == nil then
                        local v409 = l__Easing__4.EvaluateBezierShape(v408.pt, p390);
                        if v409 then
                            local v410 = (1 / 0);
                            local v411 = (1 / 0);
                            local v412 = (-1 / 0);
                            local v413 = (-1 / 0);
                            for _, v414 in v409.v do
                                v410 = math.min(v410, v414[1]);
                                v411 = math.min(v411, v414[2]);
                                v412 = math.max(v412, v414[1]);
                                v413 = math.max(v413, v414[2]);
                            end;
                            local v415 = Instance.new("Frame");
                            v415.BackgroundTransparency = 1;
                            v415.BorderSizePixel = 0;
                            v415.ClipsDescendants = true;
                            v415.Position = UDim2.fromScale(v410 / p388, v411 / p389);
                            v415.Size = UDim2.fromScale((v412 - v410) / p388, (v413 - v411) / p389);
                            v415.Parent = p386;
                            v396.Parent = v415;
                            v404.MatteClip = v415;
                        end;
                    end;
                end;
            end;
            u249(v396, v394.ks, p390, p388, p389, v395, l__Scale__32, l__Scale__33);
            local v416 = p390 - (v394.st or 0);
            local v417;
            if v394.ip <= v416 then
                v417 = v416 < v394.op;
            else
                v417 = false;
            end;
            v396.Visible = v417;
            table.insert(v392, v404);
        end;
    end;
    for _, v418 in v392 do
        local l__Layer__35 = v418.Layer;
        if l__Layer__35.parent and v391[l__Layer__35.parent] then
            v418.Frame.Parent = v391[l__Layer__35.parent].Frame;
        elseif v418.MatteClip == nil then
            v418.Frame.Parent = p386;
        end;
    end;
    for v419 = 1, #v392 - 1 do
        local v420 = v392[v419];
        local v421 = v392[v419 + 1];
        if v421.Layer.tt then
            local v422 = nil;
            for _, v423 in v420.Shapes or {} do
                if v423.PathData then
                    v422 = l__Easing__4.EvaluateBezierShape(v423.PathData, p390);
                    break;
                end;
            end;
            if v422 then
                local v424 = (1 / 0);
                local v425 = (1 / 0);
                local v426 = (-1 / 0);
                local v427 = (-1 / 0);
                for _, v428 in v422.v do
                    v424 = math.min(v424, v428[1]);
                    v425 = math.min(v425, v428[2]);
                    v426 = math.max(v426, v428[1]);
                    v427 = math.max(v427, v428[2]);
                end;
                local v429 = Instance.new("Frame");
                v429.BackgroundTransparency = 1;
                v429.BorderSizePixel = 0;
                v429.ClipsDescendants = true;
                v429.Position = UDim2.fromScale(v424 / p388, v425 / p389);
                v429.Size = UDim2.fromScale((v426 - v424) / p388, (v427 - v425) / p389);
                v429.Parent = p386;
                v421.Frame.Parent = v429;
                v421.MatteClip = v429;
                v420.Frame.Visible = false;
            end;
        end;
    end;
    return v392;
end;
local u431 = nil;
local function u446(p432, p433, p434, p435) --[[ Line: 1314 ]]
    -- upvalues: u249 (copy), u431 (ref), l__Easing__4 (copy), u446 (copy)
    for _, v436 in p432 do
        local l__Layer__36 = v436.Layer;
        local v437 = p433 - (l__Layer__36.st or 0);
        local v438;
        if l__Layer__36.ip <= v437 then
            v438 = v437 < l__Layer__36.op;
        else
            v438 = false;
        end;
        v436.Frame.Visible = v438;
        if v438 then
            local v439 = v436.Frame:IsA("CanvasGroup");
            u249(v436.Frame, l__Layer__36.ks, v437, p434, p435, v439, v436.BaseSizeX, v436.BaseSizeY);
            if v436.Shapes then
                for _, v440 in v436.Shapes do
                    u431(v440, v437, p434, p435);
                end;
            end;
            if v436.Children then
                local v441 = l__Layer__36.w or p434;
                local v442 = l__Layer__36.h or p435;
                local v443;
                if l__Layer__36.tm then
                    v443 = l__Easing__4.EvaluateScalarAtFrame(l__Layer__36.tm, v437, 0) * (l__Layer__36.op - l__Layer__36.ip);
                else
                    v443 = v437;
                end;
                u446(v436.Children, v443, v441, v442);
            end;
            if v436.TextLabel and l__Layer__36.t then
                local l__d__37 = l__Layer__36.t.d;
                if l__d__37 and l__d__37.k then
                    local v444 = nil;
                    for _, v445 in l__d__37.k do
                        if v445.t == nil or v445.t <= v437 then
                            v444 = v445.s;
                        end;
                    end;
                    if v444 then
                        v436.TextLabel.Text = v444.t or "";
                        if v444.fc then
                            v436.TextLabel.TextColor3 = Color3.new(v444.fc[1] or 1, v444.fc[2] or 1, v444.fc[3] or 1);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
u431 = function(p447, p448, p449, p450) --[[ Line: 1368 ]]
    -- upvalues: u431 (ref), l__Easing__4 (copy), u137 (copy), u184 (copy)
    if p447.Children then
        for _, v451 in p447.Children do
            u431(v451, p448, p449, p450);
        end;
    end;
    if p447.IsAnimatedPath and p447.PathData then
        local v452 = l__Easing__4.EvaluateBezierShape(p447.PathData, p448);
        if v452 and p447.Frame then
            local v453 = l__Easing__4.EvaluateColor(p447.FillColor, p448);
            local v454 = l__Easing__4.EvaluateScalarAtFrame(p447.FillOpacity, p448, 100);
            if p447.FillColor then
                u137(p447, v452, p447.Frame, p449, p450, v453, 1 - v454 / 100);
            end;
            if p447.StrokeColor then
                local v455 = l__Easing__4.EvaluateColor(p447.StrokeColor, p448);
                local v456 = l__Easing__4.EvaluateScalarAtFrame(p447.StrokeOpacity, p448, 100);
                local v457 = l__Easing__4.EvaluateScalarAtFrame(p447.StrokeWidth, p448, 0);
                if v457 > 0 then
                    u184(p447, v452, p447.Frame, p449, p450, v455, 1 - v456 / 100, v457);
                end;
            end;
        end;
    elseif p447.FillColor then
        local l__FillColor__38 = p447.FillColor;
        local v458;
        if l__FillColor__38 == nil then
            v458 = false;
        else
            v458 = l__FillColor__38.a == 1;
        end;
        if v458 then
            local v459 = l__Easing__4.EvaluateColor(p447.FillColor, p448);
            local v460 = 1 - l__Easing__4.EvaluateScalarAtFrame(p447.FillOpacity, p448, 100) / 100;
            if p447.Triangles then
                for _, v461 in p447.Triangles do
                    if v461.A.Visible then
                        v461.A.ImageColor3 = v459;
                        v461.A.ImageTransparency = v460;
                    end;
                    if v461.B.Visible then
                        v461.B.ImageColor3 = v459;
                        v461.B.ImageTransparency = v460;
                    end;
                end;
            end;
            if p447.Frame and p447.Frame.BackgroundTransparency < 1 then
                p447.Frame.BackgroundColor3 = v459;
                p447.Frame.BackgroundTransparency = v460;
            end;
        end;
    end;
    if p447.StrokeColor then
        local l__StrokeColor__39 = p447.StrokeColor;
        local v462;
        if l__StrokeColor__39 == nil then
            v462 = false;
        else
            v462 = l__StrokeColor__39.a == 1;
        end;
        if v462 then
            local v463 = l__Easing__4.EvaluateColor(p447.StrokeColor, p448);
            local v464 = l__Easing__4.EvaluateScalarAtFrame(p447.StrokeOpacity, p448, 100);
            if p447.Segments then
                for _, v465 in p447.Segments do
                    if v465.Visible then
                        v465.BackgroundColor3 = v463;
                        v465.BackgroundTransparency = 1 - v464 / 100;
                    end;
                end;
            end;
            if p447.UIStroke then
                p447.UIStroke.Color = v463;
                p447.UIStroke.Transparency = 1 - v464 / 100;
            end;
        end;
    end;
end;
return table.freeze({
    Parse = function(p466) --[[ Name: Parse, Line 1437 ]]
        -- upvalues: l__HttpService__1 (copy)
        return l__HttpService__1:JSONDecode(p466);
    end,
    Create = function(p467) --[[ Name: Create, Line 1441 ]]
        -- upvalues: u4 (copy), u430 (copy)
        local l__w__40 = p467.w;
        local l__h__41 = p467.h;
        local l__ip__42 = p467.ip;
        local l__op__43 = p467.op;
        local l__fr__44 = p467.fr;
        local v468 = Instance.new("Frame");
        v468.Name = p467.nm or "LottieAnimation";
        v468.BackgroundTransparency = 1;
        v468.BorderSizePixel = 0;
        v468.ClipsDescendants = true;
        v468.Size = u4;
        local v469 = {};
        if p467.assets then
            for _, v470 in p467.assets do
                v469[v470.id] = v470;
            end;
        end;
        return {
            Animation = p467,
            Root = v468,
            Layers = u430(p467.layers, v468, v469, l__w__40, l__h__41, l__ip__42),
            AssetMap = v469,
            Duration = (l__op__43 - l__ip__42) / l__fr__44,
            Width = l__w__40,
            Height = l__h__41
        };
    end,
    Render = function(p471, p472) --[[ Name: Render, Line 1476 ]]
        -- upvalues: u446 (copy)
        local l__Animation__45 = p471.Animation;
        local l__ip__46 = l__Animation__45.ip;
        u446(p471.Layers, l__ip__46 + p472 * l__Animation__45.fr % (l__Animation__45.op - l__ip__46), p471.Width, p471.Height);
    end,
    Destroy = function(p473) --[[ Name: Destroy, Line 1487 ]]
        p473.Root:Destroy();
        table.clear(p473.Layers);
        table.clear(p473.AssetMap);
    end
});