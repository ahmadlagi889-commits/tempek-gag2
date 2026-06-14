-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
local function u8(p1, p2, p3, p4) --[[ Line: 13 ]]
    -- upvalues: l__MaterialService__1 (copy)
    local v5 = Instance.new("Part");
    local v6 = p2 or "Studs";
    v5.Parent = p1;
    v5.TopSurface = Enum.SurfaceType[v6];
    v5.BackSurface = Enum.SurfaceType[v6];
    v5.FrontSurface = Enum.SurfaceType[v6];
    v5.BottomSurface = Enum.SurfaceType[v6];
    v5.LeftSurface = Enum.SurfaceType[v6];
    v5.RightSurface = Enum.SurfaceType[v6];
    v5.Anchored = true;
    v5.CanCollide = false;
    v5.Transparency = 0;
    if p4 then
        v5.Shape = Enum.PartType[p4];
    end;
    if p3 then
        v5.MaterialVariant = p3;
        local v7 = l__MaterialService__1:FindFirstChild(p3, true);
        if not v7 then
            return v5;
        end;
        v5.Material = v7.BaseMaterial;
    end;
    return v5;
end;
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u9, p10, p11) --[[ Name: InitPlant, Line 57 ]]
        -- upvalues: u8 (copy)
        local v12 = p11 or 1;
        local u13 = Random.new(p10);
        local l__FruitSpawnLocations__2 = u9.FruitSpawnLocations;
        local l__Base__3 = u9.Base;
        local l__Leaf__4 = script.Leaf;
        local l__GoopEnd__5 = script.GoopEnd;
        local v14, v15, v16 = Color3.fromRGB(89, 67, 49):ToHSV();
        local v17 = 0.015 or 0.05;
        local v18 = v14 + u13:NextNumber(-v17, v17);
        local u19 = Color3.fromHSV(v18, v15, v16);
        local v20, v21, v22 = Color3.fromRGB(126, 62, 255):ToHSV();
        local v23 = 0.04 or 0.05;
        local v24 = v20 + u13:NextNumber(-v23, v23);
        local u25 = Color3.fromHSV(v24, v21, v22);
        local v26, v27, v28 = Color3.fromRGB(120, 50, 160):ToHSV();
        local v29 = 0.04 or 0.05;
        local v30 = v26 + u13:NextNumber(-v29, v29);
        local u31 = Color3.fromHSV(v30, v27, v28);
        local v32, v33 = Color3.fromRGB(170, 85, 255);
        local v34, v35, v36 = v32:ToHSV();
        local v37 = v33 or 0.05;
        local v38 = v34 + u13:NextNumber(-v37, v37);
        local v39 = Color3.fromHSV(v38, v35, v36);
        local v40 = u13:NextNumber(4, 5) * (v12 * 0.25 + 0.75);
        local v41 = u13:NextNumber(4.25, 5) * (v12 * 0.25 + 0.75);
        local v42 = u13:NextInteger(5, 8);
        local u43 = 1;
        while u13:NextInteger(1, 30) == 1 do
            v42 = v42 + u13:NextInteger(7, 12);
            u43 = u43 + 0.5;
        end;
        local v44 = u13:NextInteger(1, 6) == 1;
        local v45 = Vector3.new(v40, v41, v40);
        local l__CFrame__6 = l__Base__3.CFrame;
        local function u73(p46, p47, p48) --[[ Line: 91 ]]
            -- upvalues: l__Leaf__4 (copy), u9 (copy), u13 (copy), u43 (ref), u25 (copy), u31 (copy), l__FruitSpawnLocations__2 (copy)
            local v49 = l__Leaf__4:Clone();
            v49.Parent = u9;
            local v50 = u13:NextNumber(7, 13) * p48 * u43;
            local v51 = u13:NextNumber(4, 7) * p48 * u43;
            local v52 = u13:NextNumber(7, 13) * p48 * u43;
            v49.Size = Vector3.new(v50, v51, v52);
            v49.CFrame = p46 * CFrame.new(u13:NextNumber(-v49.Size.X, v49.Size.X) * 0.25, v49.Size.Y / 2.25, u13:NextNumber(-v49.Size.Z, v49.Size.Z) * 0.25);
            v49.Name = p47 + 1;
            v49.Color = u25;
            local v53 = u13:NextInteger(2, 4);
            local v54 = l__Leaf__4:Clone();
            v54.Parent = u9;
            local v55 = v49.Size.X * 0.75;
            local v56 = v49.Size.Y * u13:NextNumber(0.75, 1);
            v54.Size = Vector3.new(v55, v56, v49.Size.Z * 0.75);
            local v57 = v49.CFrame * CFrame.new(0, v49.Size.Y / 2.2 + v54.Size.Y / 2.2, 0);
            local l__Angles__7 = CFrame.Angles;
            local v58 = u13:NextNumber(-5, 5);
            local v59 = math.rad(v58);
            local v60 = u13:NextNumber(-5, 5);
            v54.CFrame = v57 * l__Angles__7(0, v59, (math.rad(v60)));
            v54.Name = p47 + 2;
            v54.Color = u25;
            for v61 = 1, v53 do
                local v62 = l__Leaf__4:Clone();
                local v63 = u13:NextNumber(0.5, v49.Size.X) * 0.6;
                local v64 = u13:NextNumber(0, v49.Size.Y) * 0.6;
                local v65 = u13:NextNumber(0.5, v49.Size.Z) * 0.6;
                if v61 % 2 == 0 then
                    v63 = -v63;
                    if u13:NextInteger(1, 2) == 1 then
                        v65 = -v65;
                    end;
                end;
                v62.Parent = u9;
                local v66 = v49.Size.X * u13:NextNumber(0.65, 0.85);
                local v67 = v49.Size.Y * u13:NextNumber(0.75, 1.4);
                local v68 = v49.Size.X * u13:NextNumber(0.65, 0.85);
                v62.Size = Vector3.new(v66, v67, v68);
                v62.CFrame = v49.CFrame * CFrame.new(v63, v64, v65);
                v62.Name = p47 + 2;
                local v69;
                if v61 % 2 == 0 then
                    v69 = u31;
                else
                    v69 = u25;
                end;
                v62.Color = v69;
            end;
            for _ = 1, u13:NextInteger(2, 3) do
                local v70 = u9;
                local v71 = Instance.new("Part");
                local v72 = nil or "Studs";
                v71.Parent = v70;
                v71.TopSurface = Enum.SurfaceType[v72];
                v71.BackSurface = Enum.SurfaceType[v72];
                v71.FrontSurface = Enum.SurfaceType[v72];
                v71.BottomSurface = Enum.SurfaceType[v72];
                v71.LeftSurface = Enum.SurfaceType[v72];
                v71.RightSurface = Enum.SurfaceType[v72];
                v71.Anchored = true;
                v71.CanCollide = false;
                v71.Transparency = 0;
                v71.Size = Vector3.new(1, 1, 1);
                v71.CFrame = v49.CFrame * CFrame.new(u13:NextNumber(-v49.Size.X, v49.Size.X) * 0.4, -v49.Size.Y / 2, u13:NextNumber(-v49.Size.Z, v49.Size.Z) * 0.4);
                v71.Parent = l__FruitSpawnLocations__2;
                v71.Transparency = 1;
            end;
        end;
        local function v84(p74, p75, p76, p77) --[[ Line: 145 ]]
            -- upvalues: u13 (copy), u8 (ref), u9 (copy), u19 (copy), u73 (copy)
            local v78 = u13:NextInteger(2, 3);
            local l__Angles__8 = CFrame.Angles;
            local v79 = u13:NextNumber(45, 70);
            local v80 = p74 * l__Angles__8(0, 0, (math.rad(v79)));
            for v81 = 1, v78 do
                local v82 = u8(u9, nil, "Studs 2x2 Plastic");
                v82.Size = p75;
                local l__Angles__9 = CFrame.Angles;
                local v83 = u13:NextNumber(-25, -10);
                v82.CFrame = v80 * l__Angles__9(0, 0, (math.rad(v83))) * CFrame.new(0, p75.Y / 2.15, 0);
                v82.Color = u19;
                v82.Name = p76 + v81;
                v80 = v82.CFrame * CFrame.new(0, p75.Y / 2.15, 0);
                p75 = p75 * 0.85;
                if v81 == v78 then
                    u73(CFrame.new(v80.Position) * CFrame.Angles(0, math.rad(v82.Orientation.Y), 0), v81 + p76, p77 or 1);
                end;
            end;
        end;
        local v85 = {};
        for v86 = 1, v42 do
            local v87 = u8(u9, nil, "Studs 2x2 Plastic");
            local v88 = u13:NextNumber(-5, 5);
            local v89 = u13:NextNumber(-5, 5);
            if v44 then
                v88 = u13:NextNumber(-15, 15);
                v89 = u13:NextNumber(-15, 15);
            end;
            if v86 == 1 then
                v89 = 0;
                v88 = 0;
            end;
            v87.Size = v45;
            v87.CFrame = l__CFrame__6 * CFrame.Angles(math.rad(v88), 0, (math.rad(v89))) * CFrame.new(0, v45.Y / 2.2, 0);
            v87.Color = u19;
            v87.Name = v86;
            if v86 < v42 then
                table.insert(v85, v87);
            else
                local v90 = u13:NextInteger(2, 4);
                for v91 = 1, v90 do
                    local v92 = 360 / v90 * v91 + u13:NextNumber(-20, 20);
                    v84(v87.CFrame * CFrame.new(0, v45.Y / 2.2, 0) * CFrame.Angles(0, math.rad(v92), 0), Vector3.new(v87.Size.X * 0.7, v87.Size.Y * 0.8, v87.Size.Z * 0.7), v86, 1.25);
                end;
            end;
            if u13:NextInteger(1, 3) == 1 then
                local v93 = u8(u9, nil, "Stripes");
                local v94 = u13:NextNumber(1.5, 3.5);
                v93.Size = Vector3.new(0.15, v94, 0.15);
                local v95 = CFrame.new(v87.CFrame.Position) * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, v87.Size.X / 2 + v93.Size.Y / 2, 0);
                local l__Angles__10 = CFrame.Angles;
                local v96 = u13:NextNumber(-30, 30);
                v93.CFrame = v95 * l__Angles__10(0, math.rad(v96), 0);
                v93.Color = v39;
                v93.Name = v86 + 1;
                local v97 = l__GoopEnd__5:Clone();
                v97.Parent = u9;
                v97:PivotTo(v93.CFrame * CFrame.new(0, v93.Size.Y / 2, 0));
                for _, v98 in v97:GetChildren() do
                    v98.Name = tonumber(v98.Name) + v86 + 1;
                    v98.Parent = u9;
                end;
            end;
            l__CFrame__6 = v87.CFrame * CFrame.new(0, v45.Y / 2.2, 0);
            local v99 = math.clamp(v45.X * 0.875, 1, v40);
            local v100 = v45.Y * 1.05;
            local v101 = v41 + u13:NextNumber(0.75, 1.1);
            local v102 = math.clamp(v100, 0, v101);
            local v103 = math.clamp(v45.Z * 0.875, 1, v40);
            v45 = Vector3.new(v99, v102, v103);
        end;
        for v104 = 1, 2 do
            local v105 = 360 / v42;
            if v104 == 1 then
                v105 = v105 + 180;
            end;
            local l__CFrame__11 = l__Base__3.CFrame;
            local l__new__12 = CFrame.new;
            local v106 = math.rad(v105);
            local v107 = math.cos(v106) * v40;
            local v108 = math.sin(v105);
            local v109 = l__CFrame__11 * l__new__12(v107, 0, math.rad(v108) * v40);
            for v110, v111 in v85 do
                local l__CFrame__13 = v111.CFrame;
                local l__new__14 = CFrame.new;
                local v112 = math.rad(v105);
                local v113 = math.cos(v112) * v40;
                local v114 = math.rad(v105);
                local v115 = l__CFrame__13 * l__new__14(v113, 0, math.sin(v114) * v40);
                local v116 = u8(u9, nil, "Studs 2x2 Plastic");
                local v117 = (v109.Position - v115.Position).Magnitude * 1.1;
                v116.Size = Vector3.new(v40 * 0.6, v40 * 0.6, v117);
                v116.CFrame = CFrame.lookAt(v109.Position, v115.Position) * CFrame.new(0, 0, -v117 / 2);
                v116.Color = u19;
                v116.Name = v110;
                v116:SetAttribute("GrowSide", true);
                if v110 == 2 then
                    local v118 = Vector3.new(v40 * 0.55, v117, v40 * 0.55);
                    local v119 = v116.CFrame * CFrame.Angles(-0.4363323129985824, 0, 1.5707963267948966) * CFrame.new(0, 0, u13:NextNumber(-v111.Size.Z, v111.Size.Z) * 0.3);
                    for v120 = 1, 2 do
                        local v121 = u8(u9, nil, "Studs 2x2 Plastic");
                        v121.Size = v118;
                        local l__Angles__15 = CFrame.Angles;
                        local v122 = u13:NextNumber(25, 35);
                        v121.CFrame = v119 * l__Angles__15(0, 0, (math.rad(v122))) * CFrame.new(0, v121.Size.Y / 2.25, 0);
                        v121.Color = u19;
                        v121.Name = v120 + 2;
                        v119 = v121.CFrame * CFrame.new(0, v121.Size.Y / 2.25, 0);
                        v118 = v118 * 0.85;
                        local l__CFrame__16 = v121.CFrame;
                        local l__Angles__17 = CFrame.Angles;
                        local v123 = u13:NextNumber(-25, 25);
                        v121.CFrame = l__CFrame__16 * l__Angles__17(0, math.rad(v123), 0);
                    end;
                end;
                v105 = v105 + 360 / v42;
                if v110 == #v85 then
                    local v124 = u13:NextInteger(2, 3);
                    local v125 = v116.CFrame * CFrame.new(0, 0, -v116.Size.Z / 2) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0);
                    v109 = v115;
                    for v126 = 1, v124 do
                        local v127 = 360 / v124 * v126 + u13:NextNumber(-20, 20);
                        v84(v125 * CFrame.Angles(0, math.rad(v127), 0), Vector3.new(v116.Size.X * 0.7, v116.Size.Z * 0.8, v116.Size.Y * 0.7), v110, 0.85);
                        v115 = v109;
                        v109 = v115;
                    end;
                else
                    v109 = v115;
                end;
            end;
        end;
        u9:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u128) --[[ Name: BeginPlantGrowth, Line 294 ]]
        local l__PrimaryPart__18 = u128.PrimaryPart;
        local u129 = {};
        for _, v130 in u128:GetDescendants() do
            local v131 = tonumber(v130.Name);
            if v130:IsA("BasePart") and v131 then
                local v132 = {};
                for _, v133 in v130:GetChildren() do
                    if v133:IsA("Decal") or v133:IsA("Texture") then
                        table.insert(v132, {
                            decal = v133,
                            originalTransparency = v133.Transparency
                        });
                        v133.Transparency = 1;
                    end;
                end;
                local v134 = {
                    part = v130,
                    maxSize = v130.Size,
                    centerOffset = l__PrimaryPart__18.CFrame:ToObjectSpace(v130.CFrame),
                    partAge = v131,
                    decals = v132,
                    growSide = v130:GetAttribute("GrowSide") == true
                };
                table.insert(u129, v134);
                v130.CanCollide = false;
                v130.Transparency = 1;
            end;
        end;
        local function v142() --[[ Line: 326 ]]
            -- upvalues: u128 (copy), u129 (copy), l__PrimaryPart__18 (copy)
            local v135 = u128:GetAttribute("Age") or 0;
            for _, v136 in u129 do
                local v137 = math.min(v135 - v136.partAge, 1);
                if v137 > 0 then
                    if v136.growSide then
                        local v138 = v136.maxSize.Z * v137;
                        v136.part.Size = Vector3.new(v136.maxSize.X, v136.maxSize.Y, v138);
                        v136.part.CFrame = l__PrimaryPart__18.CFrame * v136.centerOffset * CFrame.new(0, 0, (v136.maxSize.Z - v138) / 2);
                    else
                        local v139 = v136.maxSize.Y * v137;
                        v136.part.Size = Vector3.new(v136.maxSize.X, v139, v136.maxSize.Z);
                        v136.part.CFrame = l__PrimaryPart__18.CFrame * v136.centerOffset * CFrame.new(0, -((v136.maxSize.Y - v139) / 2), 0);
                    end;
                    v136.part.Transparency = v136.part:GetAttribute("OG_Transparency") or 0;
                    v136.part.CanCollide = true;
                    for _, v140 in v136.decals do
                        v140.decal.Transparency = v140.originalTransparency + (1 - v140.originalTransparency) * (1 - v137);
                    end;
                else
                    v136.part.Transparency = 1;
                    v136.part.CanCollide = false;
                    for _, v141 in v136.decals do
                        v141.decal.Transparency = 1;
                    end;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u128:GetAttribute("playedSfx") and u128:GetAttribute("MaxAge") <= v135)) then
                u128:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u128:GetAttributeChangedSignal("Age"):Connect(v142);
        v142();
    end,
    Extras = {}
};