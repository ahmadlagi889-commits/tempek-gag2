-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 6 ]]
        local v4 = Random.new(p2);
        local l__FruitSpawnLocations__1 = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local l__Stud_Part__3 = script.Stud_Part;
        local l__Position__4 = (l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0)).Position;
        local v5 = ((p3 or 1) * 0.5 + 0.5) * 0.7;
        local function v11(p6, p7, p8, p9) --[[ Line: 38 ]]
            -- upvalues: l__Stud_Part__3 (copy), u1 (copy)
            local v10 = l__Stud_Part__3:Clone();
            v10.Size = p6;
            v10.CFrame = p7;
            v10.Color = p9 or Color3.new(0.509804, 0.380392, 0.25098);
            v10.Anchored = true;
            v10.CanCollide = false;
            v10:SetAttribute("OG_Transparency", 0);
            v10.Name = tostring(p8);
            v10.Parent = u1;
            return v10;
        end;
        local v12 = 18 * v5;
        local v13 = 2.2 * v5;
        local v14 = 1.6 * v5;
        local v15 = 0.7 * v5;
        local v16 = 0 + 1;
        local v17 = 2.5 * v5;
        local v18 = 2.5 * v5;
        v11(Vector3.new(v18, v17, v18), CFrame.new(l__Position__4 + Vector3.new(0, v17 / 2, 0)), v16);
        local v19 = {};
        local v20 = 0;
        local v21 = {};
        local v22 = 0;
        local function v27(p23) --[[ Line: 18 ]]
            local v24 = 30 + p23:NextInteger(-10, 20);
            local v25 = 130 + p23:NextInteger(-20, 40);
            local v26 = 20 + p23:NextInteger(-10, 15);
            return Color3.fromRGB(v24, v25, v26);
        end;
        local v28 = {};
        for v29 = 0, 2 do
            for v30 = 0, 1 do
                local v31 = v29 / 3 * 3.141592653589793 * 2;
                local v32 = v31 + (v30 / 2 - 0.5) * 1.5 + (v4:NextNumber() - 0.5) * 0.4;
                local v33 = 6 + v4:NextNumber() * 5;
                local v34 = 1 + v4:NextNumber() * 0.4;
                local v35 = 0.15 + v4:NextNumber() * 0.1;
                local v36 = 0.8 + v4:NextNumber() * 1.2;
                local v37 = math.cos(v31) * v13 * 0.5;
                local v38 = v4:NextNumber() * 1;
                local v39 = math.sin(v31) * v13 * 0.5;
                local v40 = l__Position__4 + Vector3.new(v37, v38, v39);
                local v41 = math.floor(v33 * 0.3);
                local v42 = v41 < 2 and 2 or v41;
                local v43 = v4:NextNumber() * 100;
                local v44 = {};
                for v45 = 0, v42 do
                    local v46 = v45 / v42;
                    local v47 = v46 * v33;
                    local v48 = math.sin(v43) * 0.5 + 1.8;
                    local v49 = math.cos(v43 * 0.7) * 0.8 + 3.2;
                    local v50 = math.sin(v43 * 1.3) * 0.3 + 0.6;
                    local v51 = math.cos(v43 * 0.9) * 0.15 + 0.3;
                    local v52 = math.sin(v46 * 3.141592653589793 * v48 + v43) * v50 * v46 + math.sin(v46 * 3.141592653589793 * v49 + v43 * 2.1) * v51 * v46;
                    local v53 = v36 * (1 - v46) + math.sin(v46 * 3.141592653589793 * 1.5 + v43 * 0.5) * 0.15 * v46;
                    if v46 > 0.3 then
                        v53 = v53 - (v46 - 0.3) * 0.3;
                    end;
                    local v54 = math.max(v53, -0.15);
                    local v55 = v32 + 1.5707963267948966;
                    local v56 = math.cos(v32) * v47 + math.cos(v55) * v52;
                    local v57 = math.sin(v32) * v47 + math.sin(v55) * v52;
                    v44[v45 + 1] = v40 + Vector3.new(v56, v54, v57) * v5;
                end;
                local v58 = {};
                for v59 = 1, #v44 - 1 do
                    v58[v59] = (v34 + (v35 - v34) * ((v59 - 1) / (#v44 - 1))) * v5;
                end;
                table.insert(v19, {
                    points = v44,
                    widths = v58
                });
                if v20 < #v44 - 1 then
                    v20 = #v44 - 1;
                end;
                if v4:NextNumber() > 0.45 and #v44 > 4 then
                    local v60 = math.floor(#v44 * 0.45) + v4:NextInteger(0, (math.floor(#v44 * 0.2)));
                    local v61 = math.clamp(v60, 2, #v44 - 1);
                    local v62 = v32 + (v4:NextNumber() - 0.5) * 1.2;
                    local v63 = v33 * (0.25 + v4:NextNumber() * 0.25);
                    local v64 = v34 * 0.45;
                    local v65 = math.floor(v63 * 0.3);
                    local v66 = v65 < 2 and 2 or v65;
                    local v67 = v4:NextNumber() * 100;
                    local v68 = v44[v61];
                    local v69 = {};
                    for v70 = 0, v66 do
                        local v71 = v70 / v66;
                        local v72 = v71 * v63;
                        local v73 = math.sin(v67) * 0.5 + 1.8;
                        local v74 = math.cos(v67 * 0.7) * 0.8 + 3.2;
                        local v75 = math.sin(v67 * 1.3) * 0.3 + 0.6;
                        local v76 = math.cos(v67 * 0.9) * 0.15 + 0.3;
                        local v77 = math.sin(v71 * 3.141592653589793 * v73 + v67) * v75 * v71 + math.sin(v71 * 3.141592653589793 * v74 + v67 * 2.1) * v76 * v71;
                        local v78 = (1 - v71) * 0.1 + math.sin(v71 * 3.141592653589793 * 1.5 + v67 * 0.5) * 0.15 * v71;
                        if v71 > 0.3 then
                            v78 = v78 - (v71 - 0.3) * 0.3;
                        end;
                        local v79 = math.max(v78, -0.15);
                        local v80 = v62 + 1.5707963267948966;
                        local v81 = math.cos(v62) * v72 + math.cos(v80) * v77;
                        local v82 = math.sin(v62) * v72 + math.sin(v80) * v77;
                        v69[v70 + 1] = v68 + Vector3.new(v81, v79, v82) * v5;
                    end;
                    local v83 = {};
                    for v84 = 1, #v69 - 1 do
                        v83[v84] = (v64 + (v35 - v64) * ((v84 - 1) / (#v69 - 1))) * v5;
                    end;
                    table.insert(v21, {
                        points = v69,
                        widths = v83
                    });
                    if v22 < #v69 - 1 then
                        v22 = #v69 - 1;
                    end;
                end;
            end;
        end;
        for v85 = 1, v20 do
            v16 = v16 + 1;
            for _, v86 in v19 do
                if v85 <= #v86.points - 1 then
                    local v87 = v86.points[v85];
                    local v88 = v86.points[v85 + 1];
                    local v89 = v86.widths[v85];
                    local v90 = (v87 + v88) / 2;
                    local v91 = v88 - v87;
                    local l__Magnitude__5 = v91.Magnitude;
                    if l__Magnitude__5 >= 0.01 then
                        local l__Unit__6 = v91.Unit;
                        local v92 = Vector3.new(0, 0, 1);
                        local v93 = l__Unit__6:Dot(v92);
                        local l__Unit__7 = l__Unit__6:Cross(math.abs(v93) > 0.99 and Vector3.new(1, 0, 0) or v92).Unit;
                        local v94 = CFrame.fromMatrix(v90, l__Unit__7, l__Unit__6);
                        v11(Vector3.new(v89, l__Magnitude__5 + 0.05, v89), v94, v16, nil);
                    end;
                end;
            end;
        end;
        for v95 = 1, v22 do
            v16 = v16 + 1;
            for _, v96 in v21 do
                if v95 <= #v96.points - 1 then
                    local v97 = v96.points[v95];
                    local v98 = v96.points[v95 + 1];
                    local v99 = v96.widths[v95];
                    local v100 = (v97 + v98) / 2;
                    local v101 = v98 - v97;
                    local l__Magnitude__8 = v101.Magnitude;
                    if l__Magnitude__8 >= 0.01 then
                        local l__Unit__9 = v101.Unit;
                        local v102 = Vector3.new(0, 0, 1);
                        local v103 = l__Unit__9:Dot(v102);
                        local l__Unit__10 = l__Unit__9:Cross(math.abs(v103) > 0.99 and Vector3.new(1, 0, 0) or v102).Unit;
                        local v104 = CFrame.fromMatrix(v100, l__Unit__10, l__Unit__9);
                        v11(Vector3.new(v99, l__Magnitude__8 + 0.05, v99), v104, v16, nil);
                    end;
                end;
            end;
        end;
        local v105 = {};
        local v106 = {};
        local v107 = {};
        for v108 = 0, 2 do
            v105[v108] = {};
            local v109 = v108 / 3 * 3.141592653589793 * 2;
            for v110 = 0, 10 do
                local v111 = v110 / 10;
                local v112 = v111 * v12;
                local v113 = v109 + v111 * 3.141592653589793 * 2 * 1;
                local v114 = v13 * (1 - v111 * 0.4);
                local v115 = v105[v108];
                local v116 = {};
                local v117 = math.cos(v113) * v114;
                local v118 = math.sin(v113) * v114;
                v116.pos = l__Position__4 + Vector3.new(v117, v112, v118);
                v116.t = v111;
                v116.angle = v113;
                v115[v110] = v116;
            end;
        end;
        for v119 = 0, 10 do
            v16 = v16 + 1;
            if v119 < 4 then
                local v120 = v119 / 4;
                local v121 = v120 * v12;
                local v122 = (2 - v120 * 1) * v5;
                local v123 = v12 / 4 + 0.1;
                local v124 = l__Position__4 + Vector3.new(0, v121 + v123 / 2, 0);
                v11(Vector3.new(v122, v123, v122), CFrame.new(v124), v16);
            end;
            if v119 > 0 and v119 <= 10 then
                for v125 = 0, 2 do
                    local v126 = v105[v125][v119 - 1];
                    local v127 = v105[v125][v119];
                    local v128 = v14 + (v15 - v14) * v127.t;
                    local l__pos__11 = v126.pos;
                    local l__pos__12 = v127.pos;
                    local v129 = (l__pos__11 + l__pos__12) / 2;
                    local v130 = l__pos__12 - l__pos__11;
                    local l__Magnitude__13 = v130.Magnitude;
                    if l__Magnitude__13 >= 0.01 then
                        local l__Unit__14 = v130.Unit;
                        local v131 = Vector3.new(0, 0, 1);
                        local v132 = l__Unit__14:Dot(v131);
                        local l__Unit__15 = l__Unit__14:Cross(math.abs(v132) > 0.99 and Vector3.new(1, 0, 0) or v131).Unit;
                        local v133 = CFrame.fromMatrix(v129, l__Unit__15, l__Unit__14);
                        v11(Vector3.new(v128, l__Magnitude__13 + 0.05, v128), v133, v16, nil);
                    end;
                    if v127.t < 0.15 then
                        table.insert(v106, {
                            pos = v127.pos,
                            angle = v127.angle,
                            helix = v125
                        });
                    end;
                    if v127.t > 0.85 then
                        table.insert(v107, {
                            pos = v127.pos,
                            angle = v127.angle,
                            helix = v125
                        });
                    end;
                end;
            end;
        end;
        local v134 = 6 + v4:NextInteger(0, 3);
        local v135 = {};
        for v136 = 1, v134 do
            local v137 = v136 / v134 * 3.141592653589793 * 2 + (v4:NextNumber() - 0.5) * 0.4;
            local v138 = 30 + v4:NextNumber() * 30;
            local v139 = math.rad(v138);
            local v140 = (4 + v4:NextNumber() * 4) * v5;
            local v141 = (1 + v4:NextNumber() * 0.5) * v5;
            local v142 = (0.2 + v4:NextNumber() * 0.15) * v5;
            local v143 = v12 * (0.55 + v4:NextNumber() * 0.45);
            local v144 = math.cos(v137) * v13 * 0.4;
            local v145 = math.sin(v137) * v13 * 0.4;
            local v146 = Vector3.new(v144, 0, v145);
            local v147 = l__Position__4 + Vector3.new(0, v143, 0) + v146;
            local v148 = v4:NextNumber() * 100;
            for v149 = 1, 2 do
                local v150 = v149 / 2;
                local v151 = v140 / 2;
                local v152 = math.cos(v137);
                local v153 = math.sin(v137);
                local v154 = math.sin(v139) * (1 - v150 * 0.4);
                local v155 = math.sin(v150 * 3.141592653589793 * 2 + v148) * 0.2 * v150;
                local v156 = math.cos(v150 * 3.141592653589793 * 1.5 + v148 * 1.3) * 0.15 * v150;
                local v157 = v147 + Vector3.new(v152 + v155, v154, v153 + v156).Unit * v151 * v5;
                local v158 = v141 + (v142 - v141) * v150;
                v16 = v16 + 1;
                local v159 = (v147 + v157) / 2;
                local v160 = v157 - v147;
                local l__Magnitude__16 = v160.Magnitude;
                if l__Magnitude__16 >= 0.01 then
                    local l__Unit__17 = v160.Unit;
                    local v161 = Vector3.new(0, 0, 1);
                    local v162 = l__Unit__17:Dot(v161);
                    local l__Unit__18 = l__Unit__17:Cross(math.abs(v162) > 0.99 and Vector3.new(1, 0, 0) or v161).Unit;
                    local v163 = CFrame.fromMatrix(v159, l__Unit__18, l__Unit__17);
                    v11(Vector3.new(v158, l__Magnitude__16 + 0.05, v158), v163, v16, nil);
                end;
                if v150 > 0.3 and (v150 < 0.85 and v4:NextNumber() > 0.55) then
                    local v164 = v137 + (v4:NextNumber() - 0.5) * 1.2;
                    local v165 = 15 + v4:NextNumber() * 35;
                    local v166 = math.rad(v165);
                    local v167 = v140 * (0.3 + v4:NextNumber() * 0.3);
                    local v168 = v158 * 0.75;
                    v147 = v157;
                    for v169 = 1, 1 do
                        local v170 = v169 / 1;
                        local v171 = math.cos(v164) + math.sin(v170 * 3.141592653589793 + v148) * 0.15;
                        local v172 = math.sin(v166) * (1 - v170 * 0.5);
                        local v173 = math.sin(v164) + math.cos(v170 * 3.141592653589793 + v148) * 0.15;
                        local v174 = v157 + Vector3.new(v171, v172, v173).Unit * (v167 / 1) * v5;
                        local v175 = v168 + (v142 - v168) * v170;
                        v16 = v16 + 1;
                        local v176 = (v157 + v174) / 2;
                        local v177 = v174 - v157;
                        local l__Magnitude__19 = v177.Magnitude;
                        if l__Magnitude__19 >= 0.01 then
                            local l__Unit__20 = v177.Unit;
                            local v178 = Vector3.new(0, 0, 1);
                            local v179 = l__Unit__20:Dot(v178);
                            local l__Unit__21 = l__Unit__20:Cross(math.abs(v179) > 0.99 and Vector3.new(1, 0, 0) or v178).Unit;
                            local v180 = CFrame.fromMatrix(v176, l__Unit__21, l__Unit__20);
                            v11(Vector3.new(v175, l__Magnitude__19 + 0.05, v175), v180, v16, nil);
                        end;
                        v157 = v174;
                    end;
                    table.insert(v135, v157);
                else
                    v147 = v157;
                end;
            end;
            table.insert(v135, v147);
        end;
        for _, v181 in v135 do
            for _ = 1, 2 + v4:NextInteger(0, 2) do
                local v182 = (v4:NextNumber() - 0.5) * 6 * v5;
                local v183 = (v4:NextNumber() - 0.3) * 4 * v5;
                local v184 = (v4:NextNumber() - 0.5) * 6 * v5;
                local v185 = v181 + Vector3.new(v182, v183, v184);
                local v186 = (4 + v4:NextNumber() * 4) * v5;
                local v187 = (1.8 + v4:NextNumber() * 1.4) * v5;
                local v188 = CFrame.new(v185) * CFrame.Angles((v4:NextNumber() - 0.5) * 0.3, v4:NextNumber() * 3.141592653589793 * 2, (v4:NextNumber() - 0.5) * 0.3);
                v16 = v16 + 1;
                local v189 = v11(Vector3.new(v186, v187, v186), v188, v16, (v27(v4)));
                v189:SetAttribute("IsLeaf", true);
                table.insert(v28, v189);
            end;
        end;
        local v190 = l__Position__4 + Vector3.new(0, v12 * 1.05, 0);
        local v191 = 11 * v5;
        local v192 = 7 * v5;
        for _ = 1, 20 + v4:NextInteger(0, 10) do
            local v193 = v4:NextNumber() * 3.141592653589793 * 2;
            local v194 = v4:NextNumber() * 3.141592653589793 * 0.6;
            local v195 = v191 * (0.4 + v4:NextNumber() * 0.6);
            local v196 = math.cos(v193) * math.sin(v194) * v195;
            local v197 = math.cos(v194) * v192 * 0.5 + (v4:NextNumber() - 0.3) * 2.5 * v5;
            local v198 = math.sin(v193) * math.sin(v194) * v195;
            local v199 = v190 + Vector3.new(v196, v197, v198);
            local v200 = (4.5 + v4:NextNumber() * 5) * v5;
            local v201 = (1.5 + v4:NextNumber() * 1.8) * v5;
            local v202 = CFrame.new(v199) * CFrame.Angles((v4:NextNumber() - 0.5) * 0.4, v4:NextNumber() * 3.141592653589793 * 2, (v4:NextNumber() - 0.5) * 0.4);
            v16 = v16 + 1;
            local v203 = v11(Vector3.new(v200, v201, v200), v202, v16, (v27(v4)));
            v203:SetAttribute("IsLeaf", true);
            table.insert(v28, v203);
        end;
        for _, v204 in v28 do
            v204.CanCollide = true;
        end;
        local v205 = RaycastParams.new();
        v205.FilterType = Enum.RaycastFilterType.Include;
        v205.FilterDescendantsInstances = { u1 };
        local v206 = 8 + v4:NextInteger(0, 6);
        local v207 = l__Position__4.Y + v12 * 0.5;
        local v208 = v12 * 1.2;
        local v209 = 0;
        for _ = 1, v206 * 8 do
            if v206 <= v209 then
                break;
            end;
            local v210 = v4:NextNumber() * 3.141592653589793 * 2;
            local v211 = v191 * (0.2 + v4:NextNumber() * 0.8);
            local v212 = l__Position__4.X + math.cos(v210) * v211;
            local v213 = l__Position__4.Z + math.sin(v210) * v211;
            local v214 = Vector3.new(v212, v207, v213);
            local v215 = workspace:Raycast(v214, Vector3.new(0, v208, 0), v205);
            if v215 and (v215.Instance and v215.Instance:GetAttribute("IsLeaf")) then
                local v216 = v215.Instance.CFrame.Position - Vector3.new(0, v215.Instance.Size.Y / 2, 0);
                local v217 = false;
                for _, v218 in l__FruitSpawnLocations__1:GetChildren() do
                    if (v218.CFrame.Position - v216).Magnitude < 3 * v5 then
                        v217 = true;
                        break;
                    end;
                end;
                if not v217 then
                    local v219 = Instance.new("Part");
                    v219.Size = Vector3.new(1, 1, 1);
                    v219.Transparency = 1;
                    v219.Anchored = true;
                    v219.CanCollide = false;
                    v219.CFrame = CFrame.new(v216);
                    v219.Name = "Fruit_Spawn";
                    v219.Parent = l__FruitSpawnLocations__1;
                    v209 = v209 + 1;
                end;
            end;
        end;
        if v209 < 4 and #v28 > 0 then
            for _ = 1, math.min(6, #v28) do
                if v206 <= v209 then
                    break;
                end;
                local v220 = v28[v4:NextInteger(1, #v28)];
                local v221 = v220.CFrame.Position - Vector3.new(0, v220.Size.Y / 2, 0);
                local v222 = false;
                for _, v223 in l__FruitSpawnLocations__1:GetChildren() do
                    if (v223.CFrame.Position - v221).Magnitude < 3 * v5 then
                        v222 = true;
                        break;
                    end;
                end;
                if not v222 then
                    local v224 = Instance.new("Part");
                    v224.Size = Vector3.new(1, 1, 1);
                    v224.Transparency = 1;
                    v224.Anchored = true;
                    v224.CanCollide = false;
                    v224.CFrame = CFrame.new(v221);
                    v224.Name = "Fruit_Spawn";
                    v224.Parent = l__FruitSpawnLocations__1;
                    v209 = v209 + 1;
                end;
            end;
        end;
        for _, v225 in v28 do
            v225.CanCollide = false;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u226) --[[ Name: BeginPlantGrowth, Line 451 ]]
        local l__PrimaryPart__22 = u226.PrimaryPart;
        local u227 = {};
        for _, v228 in u226:GetDescendants() do
            local v229 = tonumber(v228.Name);
            if v228:IsA("BasePart") and v229 then
                local v230 = l__PrimaryPart__22.CFrame:ToObjectSpace(v228.CFrame);
                local v231 = v230 * CFrame.new(0, -v228.Size.Y / 2, 0);
                table.insert(u227, {
                    part = v228,
                    maxSizeY = v228.Size.Y,
                    fullSize = v228.Size,
                    bottomCF = v231,
                    rotation = v230.Rotation,
                    partAge = v229
                });
                v228.CanCollide = false;
                v228.Transparency = 1;
            end;
        end;
        local function v237() --[[ Line: 475 ]]
            -- upvalues: u226 (copy), u227 (copy), l__PrimaryPart__22 (copy)
            local v232 = u226:GetAttribute("Age") or 0;
            for _, v233 in u227 do
                local v234 = math.min(v232 - v233.partAge, 1);
                if v234 > 0 then
                    local v235 = v233.maxSizeY * v234;
                    v233.part.Size = Vector3.new(v233.fullSize.X, v235, v233.fullSize.Z);
                    local v236 = v233.bottomCF * CFrame.new(0, v235 / 2, 0);
                    v233.part.CFrame = l__PrimaryPart__22.CFrame * CFrame.new(v236.Position) * v233.rotation;
                    v233.part.Transparency = v233.part:GetAttribute("OG_Transparency") or 0;
                    v233.part.CanCollide = true;
                else
                    v233.part.Transparency = 1;
                    v233.part.CanCollide = false;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u226:GetAttribute("playedSfx") and u226:GetAttribute("MaxAge") <= v232)) then
                u226:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u226:GetAttributeChangedSignal("Age"):Connect(v237);
        v237();
    end,
    Extras = {}
};