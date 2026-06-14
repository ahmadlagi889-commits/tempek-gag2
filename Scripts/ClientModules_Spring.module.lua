-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__exp__2 = math.exp;
local l__sin__3 = math.sin;
local l__cos__4 = math.cos;
local l__min__5 = math.min;
local l__sqrt__6 = math.sqrt;
local l__round__7 = math.round;
local u1 = {};
u1.__index = u1;
function u1.new(p2, p3, p4, p5, p6) --[[ Line: 89 ]]
    -- upvalues: u1 (copy)
    local v7 = p6.toIntermediate(p4);
    local v8 = {
        d = p2,
        f = p3,
        g = v7,
        p = v7,
        v = table.create(#v7, 0),
        typedat = p6,
        rawGoal = p5
    };
    return setmetatable(v8, u1);
end;
function u1.setGoal(p9, p10) --[[ Line: 105 ]]
    p9.rawGoal = p10;
    p9.g = p9.typedat.toIntermediate(p10);
end;
function u1.setDampingRatio(p11, p12) --[[ Line: 110 ]]
    p11.d = p12;
end;
function u1.setFrequency(p13, p14) --[[ Line: 114 ]]
    p13.f = p14;
end;
function u1.canSleep(p15) --[[ Line: 118 ]]
    local v16 = 0;
    for _, v17 in p15.v do
        v16 = v16 + v17 ^ 2;
    end;
    if v16 > 0.0001 then
        return false;
    end;
    local l__p__8 = p15.p;
    local l__g__9 = p15.g;
    local v18 = 0;
    for v19, v20 in l__p__8 do
        v18 = v18 + (l__g__9[v19] - v20) ^ 2;
    end;
    return v18 <= 6.781684027777778e-8;
end;
function u1.step(p21, p22) --[[ Line: 130 ]]
    -- upvalues: l__exp__2 (copy), l__sqrt__6 (copy), l__cos__4 (copy), l__sin__3 (copy)
    local l__d__10 = p21.d;
    local v23 = p21.f * 2 * 3.141592653589793;
    local l__g__11 = p21.g;
    local l__p__12 = p21.p;
    local l__v__13 = p21.v;
    if l__d__10 == 1 then
        local v24 = l__exp__2(-v23 * p22);
        local v25 = p22 * v24;
        local v26 = v24 + v25 * v23;
        local v27 = v24 - v25 * v23;
        local v28 = v25 * v23 * v23;
        for v29 = 1, #l__p__12 do
            local v30 = l__p__12[v29] - l__g__11[v29];
            l__p__12[v29] = v30 * v26 + l__v__13[v29] * v25 + l__g__11[v29];
            l__v__13[v29] = l__v__13[v29] * v27 - v30 * v28;
        end;
    elseif l__d__10 < 1 then
        local v31 = l__exp__2(-l__d__10 * v23 * p22);
        local v32 = l__sqrt__6(1 - l__d__10 * l__d__10);
        local v33 = l__cos__4(p22 * v23 * v32);
        local v34 = l__sin__3(p22 * v23 * v32);
        local v35;
        if v32 > 0.00001 then
            v35 = v34 / v32;
        else
            local v36 = p22 * v23;
            v35 = v36 + (v36 * v36 * (v32 * v32) * (v32 * v32) / 20 - v32 * v32) * (v36 * v36 * v36) / 6;
        end;
        local v37;
        if v23 * v32 > 0.00001 then
            v37 = v34 / (v23 * v32);
        else
            local v38 = v23 * v32;
            v37 = p22 + (p22 * p22 * (v38 * v38) * (v38 * v38) / 20 - v38 * v38) * (p22 * p22 * p22) / 6;
        end;
        for v39 = 1, #l__p__12 do
            local v40 = l__p__12[v39] - l__g__11[v39];
            l__p__12[v39] = (v40 * (v33 + v35 * l__d__10) + l__v__13[v39] * v37) * v31 + l__g__11[v39];
            l__v__13[v39] = (l__v__13[v39] * (v33 - v35 * l__d__10) - v40 * (v35 * v23)) * v31;
        end;
    else
        local v41 = l__sqrt__6(l__d__10 * l__d__10 - 1);
        local v42 = -v23 * (l__d__10 - v41);
        local v43 = -v23 * (l__d__10 + v41);
        local v44 = l__exp__2(v42 * p22);
        local v45 = l__exp__2(v43 * p22);
        for v46 = 1, #l__p__12 do
            local v47 = l__p__12[v46] - l__g__11[v46];
            local v48 = (l__v__13[v46] - v47 * v42) / (2 * v23 * v41);
            local v49 = v44 * (v47 - v48);
            l__p__12[v46] = v49 + v48 * v45 + l__g__11[v46];
            l__v__13[v46] = v49 * v42 + v48 * v45 * v43;
        end;
    end;
    return p21.typedat.fromIntermediate(p21.p);
end;
local u50 = {};
u50.__index = u50;
function u50.new(p51, p52, p53, p54) --[[ Line: 264 ]]
    -- upvalues: u50 (copy)
    return setmetatable({
        v = Vector3.new(0, 0, 0),
        d = p51,
        f = p52,
        g = p54,
        p = p53
    }, u50);
end;
function u50.setGoal(p55, p56) --[[ Line: 277 ]]
    p55.g = p56;
end;
function u50.setDampingRatio(p57, p58) --[[ Line: 281 ]]
    p57.d = p58;
end;
function u50.setFrequency(p59, p60) --[[ Line: 285 ]]
    p59.f = p60;
end;
function u50.canSleep(p61) --[[ Line: 289 ]]
    local _, v62 = p61.g:ToObjectSpace(p61.p):ToAxisAngle();
    return math.abs(v62) < 0.00017453292519943296 and p61.v.Magnitude < 0.0017453292519943296;
end;
function u50.step(p63, p64) --[[ Line: 295 ]]
    -- upvalues: l__exp__2 (copy), l__sqrt__6 (copy), l__cos__4 (copy), l__sin__3 (copy)
    local l__d__14 = p63.d;
    local v65 = p63.f * 2 * 3.141592653589793;
    local l__g__15 = p63.g;
    local l__p__16 = p63.p;
    local l__v__17 = p63.v;
    local v66, v67 = (l__p__16 * l__g__15:Inverse()):ToAxisAngle();
    local v68 = v66 * v67;
    local v69 = l__exp__2(-l__d__14 * v65 * p64);
    local v70, v71;
    if l__d__14 == 1 then
        local _ = p64 * v69;
        local v72 = (v68 * (1 + v65 * p64) + l__v__17 * p64) * v69;
        local l__Magnitude__18 = v72.Magnitude;
        local v73;
        if l__Magnitude__18 > 1e-6 then
            v73 = CFrame.fromAxisAngle(v72.Unit, l__Magnitude__18);
        else
            v73 = CFrame.identity;
        end;
        v70 = v73 * l__g__15;
        v71 = (l__v__17 * (1 - p64 * v65) - v68 * (p64 * v65 * v65)) * v69;
    elseif l__d__14 < 1 then
        local v74 = l__sqrt__6(1 - l__d__14 * l__d__14);
        local v75 = l__cos__4(p64 * v65 * v74);
        local v76 = l__sin__3(p64 * v65 * v74);
        local v77 = v76 / (v65 * v74);
        local v78 = v76 / v74;
        local v79 = (v68 * (v75 + v78 * l__d__14) + l__v__17 * v77) * v69;
        local l__Magnitude__19 = v79.Magnitude;
        local v80;
        if l__Magnitude__19 > 1e-6 then
            v80 = CFrame.fromAxisAngle(v79.Unit, l__Magnitude__19);
        else
            v80 = CFrame.identity;
        end;
        v70 = v80 * l__g__15;
        v71 = (l__v__17 * (v75 - v78 * l__d__14) - v68 * (v78 * v65)) * v69;
    else
        local v81 = l__sqrt__6(l__d__14 * l__d__14 - 1);
        local v82 = -v65 * (l__d__14 - v81);
        local v83 = -v65 * (l__d__14 + v81);
        local v84 = (l__v__17 - v68 * v82) / (2 * v65 * v81);
        local v85 = (v68 - v84) * l__exp__2(v82 * p64);
        local v86 = v84 * l__exp__2(v83 * p64);
        local v87 = v85 + v86;
        local l__Magnitude__20 = v87.Magnitude;
        local v88;
        if l__Magnitude__20 > 1e-6 then
            v88 = CFrame.fromAxisAngle(v87.Unit, l__Magnitude__20);
        else
            v88 = CFrame.identity;
        end;
        v70 = v88 * l__g__15;
        v71 = v85 * v82 + v86 * v83;
    end;
    p63.p = v70;
    p63.v = v71;
    return v70;
end;
local u91 = {
    springType = u1.new,
    toIntermediate = function(p89) --[[ Name: toIntermediate, Line 353 ]]
        return { p89.X, p89.Y, p89.Z };
    end,
    fromIntermediate = function(p90) --[[ Name: fromIntermediate, Line 357 ]]
        return Vector3.new(p90[1], p90[2], p90[3]);
    end
};
local u92 = {};
u92.__index = u92;
function u92.new(p93, p94, p95, p96, _) --[[ Line: 367 ]]
    -- upvalues: u1 (copy), u91 (copy), u50 (copy), u92 (copy)
    local v97 = {
        rawGoal = p96,
        _position = u1.new(p93, p94, p95.Position, p96.Position, u91),
        _rotation = u50.new(p93, p94, p95.Rotation, p96.Rotation)
    };
    return setmetatable(v97, u92);
end;
function u92.setGoal(p98, p99) --[[ Line: 384 ]]
    p98.rawGoal = p99;
    p98._position:setGoal(p99.Position);
    p98._rotation:setGoal(p99.Rotation);
end;
function u92.setDampingRatio(p100, p101) --[[ Line: 390 ]]
    p100._position:setDampingRatio(p101);
    p100._rotation:setDampingRatio(p101);
end;
function u92.setFrequency(p102, p103) --[[ Line: 395 ]]
    p102._position:setFrequency(p103);
    p102._rotation:setFrequency(p103);
end;
function u92.canSleep(p104) --[[ Line: 400 ]]
    local v105 = p104._position:canSleep();
    if v105 then
        v105 = p104._rotation:canSleep();
    end;
    return v105;
end;
function u92.step(p106, p107) --[[ Line: 404 ]]
    local v108 = p106._position:step(p107);
    return p106._rotation:step(p107) + v108;
end;
local function u119(p109) --[[ Line: 423 ]]
    local l__R__21 = p109.R;
    local l__G__22 = p109.G;
    local l__B__23 = p109.B;
    local v110 = l__R__21 < 0.0404482362771076 and l__R__21 / 12.92 or 0.87941546140213 * (l__R__21 + 0.055) ^ 2.4;
    local v111 = l__G__22 < 0.0404482362771076 and l__G__22 / 12.92 or 0.87941546140213 * (l__G__22 + 0.055) ^ 2.4;
    local v112 = l__B__23 < 0.0404482362771076 and l__B__23 / 12.92 or 0.87941546140213 * (l__B__23 + 0.055) ^ 2.4;
    local v113 = 0.9257063972951867 * v110 - 0.8333736323779866 * v111 - 0.09209820666085898 * v112;
    local v114 = 0.2125862307855956 * v110 + 0.7151703037034108 * v111 + 0.0722004986433362 * v112;
    local v115 = 3.6590806972265884 * v110 + 11.442689580057424 * v111 + 4.114991502426484 * v112;
    local v116 = v114 > 0.008856451679035631 and 116 * v114 ^ 0.3333333333333333 - 16 or 903.296296296296 * v114;
    local v117, v118;
    if v115 > 1e-14 then
        v117 = v116 * v113 / v115;
        v118 = v116 * (9 * v114 / v115 - 0.46832);
    else
        v117 = -0.19783 * v116;
        v118 = -0.46832 * v116;
    end;
    return { v116, v117, v118 };
end;
local function u131(p120) --[[ Line: 452 ]]
    -- upvalues: l__min__5 (copy)
    local v121 = p120[1];
    if v121 < 0.0197955 then
        return Color3.new(0, 0, 0);
    end;
    local v122 = p120[2] / v121 + 0.19783;
    local v123 = p120[3] / v121 + 0.46832;
    local v124 = (v121 + 16) / 116;
    local v125 = v124 > 0.20689655172413793 and v124 * v124 * v124 or v124 * 0.12841854934601665 - 0.01771290335807126;
    local v126 = v125 * v122 / v123;
    local v127 = v125 * ((3 - v122 * 0.75) / v123 - 5);
    local v128 = v126 * 7.2914074 - v125 * 1.537208 - v127 * 0.4986286;
    local v129 = v126 * -2.180094 + v125 * 1.8757561 + v127 * 0.0415175;
    local v130 = v126 * 0.1253477 - v125 * 0.2040211 + v127 * 1.0569959;
    if v128 < 0 and (v128 < v129 and v128 < v130) then
        v129 = v129 - v128;
        v130 = v130 - v128;
        v128 = 0;
    elseif v129 < 0 and v129 < v130 then
        v128 = v128 - v129;
        v130 = v130 - v129;
        v129 = 0;
    elseif v130 < 0 then
        v128 = v128 - v130;
        v129 = v129 - v130;
        v130 = 0;
    end;
    return Color3.new(l__min__5(v128 < 0.0031306684425 and 12.92 * v128 or 1.055 * v128 ^ 0.4166666666666667 - 0.055, 1), l__min__5(v129 < 0.0031306684425 and 12.92 * v129 or 1.055 * v129 ^ 0.4166666666666667 - 0.055, 1), (l__min__5(v130 < 0.0031306684425 and 12.92 * v130 or 1.055 * v130 ^ 0.4166666666666667 - 0.055, 1)));
end;
local u148 = {
    boolean = {
        springType = u1.new,
        toIntermediate = function(p132) --[[ Name: toIntermediate, Line 498 ]]
            return { p132 and 1 or 0 };
        end,
        fromIntermediate = function(p133) --[[ Name: fromIntermediate, Line 502 ]]
            return p133[1] >= 0.5;
        end
    },
    number = {
        springType = u1.new,
        toIntermediate = function(p134) --[[ Name: toIntermediate, Line 510 ]]
            return { p134 };
        end,
        fromIntermediate = function(p135) --[[ Name: fromIntermediate, Line 514 ]]
            return p135[1];
        end
    },
    NumberRange = {
        springType = u1.new,
        toIntermediate = function(p136) --[[ Name: toIntermediate, Line 522 ]]
            return { p136.Min, p136.Max };
        end,
        fromIntermediate = function(p137) --[[ Name: fromIntermediate, Line 526 ]]
            return NumberRange.new(p137[1], p137[2]);
        end
    },
    UDim = {
        springType = u1.new,
        toIntermediate = function(p138) --[[ Name: toIntermediate, Line 534 ]]
            return { p138.Scale, p138.Offset };
        end,
        fromIntermediate = function(p139) --[[ Name: fromIntermediate, Line 538 ]]
            -- upvalues: l__round__7 (copy)
            return UDim.new(p139[1], (l__round__7(p139[2])));
        end
    },
    UDim2 = {
        springType = u1.new,
        toIntermediate = function(p140) --[[ Name: toIntermediate, Line 546 ]]
            local l__X__24 = p140.X;
            local l__Y__25 = p140.Y;
            return {
                l__X__24.Scale,
                l__X__24.Offset,
                l__Y__25.Scale,
                l__Y__25.Offset
            };
        end,
        fromIntermediate = function(p141) --[[ Name: fromIntermediate, Line 552 ]]
            -- upvalues: l__round__7 (copy)
            return UDim2.new(p141[1], l__round__7(p141[2]), p141[3], (l__round__7(p141[4])));
        end
    },
    Vector2 = {
        springType = u1.new,
        toIntermediate = function(p142) --[[ Name: toIntermediate, Line 560 ]]
            return { p142.X, p142.Y };
        end,
        fromIntermediate = function(p143) --[[ Name: fromIntermediate, Line 564 ]]
            return Vector2.new(p143[1], p143[2]);
        end
    },
    Vector3 = u91,
    Color3 = {
        springType = u1.new,
        toIntermediate = u119,
        fromIntermediate = u131
    },
    ColorSequence = {
        springType = u1.new,
        toIntermediate = function(p144) --[[ Name: toIntermediate, Line 581 ]]
            -- upvalues: u119 (ref)
            local l__Keypoints__26 = p144.Keypoints;
            local v145 = u119(l__Keypoints__26[1].Value);
            local v146 = u119(l__Keypoints__26[#l__Keypoints__26].Value);
            return {
                v145[1],
                v145[2],
                v145[3],
                v146[1],
                v146[2],
                v146[3]
            };
        end,
        fromIntermediate = function(p147) --[[ Name: fromIntermediate, Line 593 ]]
            -- upvalues: u131 (ref)
            return ColorSequence.new(u131({ p147[1], p147[2], p147[3] }), u131({ p147[4], p147[5], p147[6] }));
        end
    },
    CFrame = {
        springType = u92.new,
        toIntermediate = error,
        fromIntermediate = error
    }
};
local u155 = {
    Pivot = {
        class = "PVInstance",
        get = function(p149) --[[ Name: get, Line 619 ]]
            return p149:GetPivot();
        end,
        set = function(p150, p151) --[[ Name: set, Line 622 ]]
            p150:PivotTo(p151);
        end
    },
    Scale = {
        class = "Model",
        get = function(p152) --[[ Name: get, Line 628 ]]
            return p152:GetScale();
        end,
        set = function(p153, p154) --[[ Name: set, Line 631 ]]
            p153:ScaleTo(p154);
        end
    }
};
local u156 = {};
local u157 = {};
l__RunService__1.Heartbeat:Connect(function(p158) --[[ Line: 641 ]]
    -- upvalues: u156 (copy), u155 (copy), u157 (copy)
    for v159, v160 in u156 do
        for v161, v162 in v160 do
            local v163 = u155[v161];
            if v163 and v159:IsA(v163.class) then
                if v162:canSleep() then
                    v160[v161] = nil;
                    v163.set(v159, v162.rawGoal);
                else
                    v163.set(v159, v162:step(p158));
                end;
            elseif v162:canSleep() then
                v160[v161] = nil;
                v159[v161] = v162.rawGoal;
            else
                v159[v161] = v162:step(p158);
            end;
        end;
        if not next(v160) then
            u156[v159] = nil;
            local v164 = u157[v159];
            if v164 then
                u157[v159] = nil;
                for _, v165 in v164 do
                    task.spawn(v165);
                end;
            end;
        end;
    end;
end);
return table.freeze({
    target = function(p166, p167, p168, p169) --[[ Name: target, Line 690 ]]
        -- upvalues: u156 (copy), u155 (copy), u148 (copy)
        if not ("Instance"):find((typeof(p166))) then
            error(`bad argument #{1} to spr.target (Instance expected, got {typeof(p166)})`, 3);
        end;
        if not ("number"):find((typeof(p167))) then
            error(`bad argument #{2} to spr.target (number expected, got {typeof(p167)})`, 3);
        end;
        if not ("number"):find((typeof(p168))) then
            error(`bad argument #{3} to spr.target (number expected, got {typeof(p168)})`, 3);
        end;
        if not ("table"):find((typeof(p169))) then
            error(`bad argument #{4} to spr.target (table expected, got {typeof(p169)})`, 3);
        end;
        if p167 ~= p167 or p167 < 0 then
            error(("expected damping ratio >= 0; got %.2f"):format(p167), 2);
        end;
        if p168 ~= p168 or p168 < 0 then
            error(("expected undamped frequency >= 0; got %.2f"):format(p168), 2);
        end;
        local v170 = u156[p166];
        if not v170 then
            v170 = {};
            u156[p166] = v170;
        end;
        for v171, v172 in p169 do
            local v173 = u155[v171];
            local v174;
            if v173 and p166:IsA(v173.class) then
                v174 = v173.get(p166);
            else
                v174 = p166[v171];
            end;
            if typeof(v172) ~= typeof(v174) then
                error(`bad property {v171} to spr.target ({typeof(v174)} expected, got {typeof(v172)})`, 2);
            end;
            if p168 == (1 / 0) then
                p166[v171] = v172;
                v170[v171] = nil;
            else
                local v175 = v170[v171];
                if not v175 then
                    local v176 = u148[typeof(v172)];
                    if not v176 then
                        error("unsupported type: " .. typeof(v172), 2);
                    end;
                    v175 = v176.springType(p167, p168, v174, v172, v176);
                    v170[v171] = v175;
                end;
                v175:setGoal(v172);
                v175:setDampingRatio(p167);
                v175:setFrequency(p168);
            end;
        end;
        if not next(v170) then
            u156[p166] = nil;
        end;
    end,
    stop = function(p177, p178) --[[ Name: stop, Line 753 ]]
        -- upvalues: u156 (copy)
        if not ("Instance"):find((typeof(p177))) then
            error(`bad argument #{1} to spr.stop (Instance expected, got {typeof(p177)})`, 3);
        end;
        if not ("string|nil"):find((typeof(p178))) then
            error(`bad argument #{2} to spr.stop (string|nil expected, got {typeof(p178)})`, 3);
        end;
        if p178 then
            local v179 = u156[p177];
            if v179 then
                v179[p178] = nil;
            end;
        else
            u156[p177] = nil;
        end;
    end,
    completed = function(p180, p181) --[[ Name: completed, Line 769 ]]
        -- upvalues: u157 (copy)
        if not ("Instance"):find((typeof(p180))) then
            error(`bad argument #{1} to spr.completed (Instance expected, got {typeof(p180)})`, 3);
        end;
        if not ("function"):find((typeof(p181))) then
            error(`bad argument #{2} to spr.completed (function expected, got {typeof(p181)})`, 3);
        end;
        local v182 = u157[p180];
        if v182 then
            table.insert(v182, p181);
        else
            u157[p180] = { p181 };
        end;
    end
});