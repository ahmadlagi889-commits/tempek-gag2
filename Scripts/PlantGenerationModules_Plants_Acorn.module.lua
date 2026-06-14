-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 9 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local u4 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Base__3 = u1.Base;
        local u5 = (p3 or 1) * 0.25 + 0.75;
        local v6, v7, v8 = Color3.fromRGB(120, 95, 80):ToHSV();
        local v9 = 0.03 or 0.05;
        local v10 = v6 + u4:NextNumber(-v9, v9);
        local u11 = Color3.fromHSV(v10, v7, v8);
        local u12 = Color3.fromRGB(45, 139, 48);
        local u13 = Color3.fromRGB(62, 162, 62);
        local v14, v15, v16 = u11:ToHSV();
        local v17 = Color3.fromHSV(v14 + 0, v15 + 0, v16 + -0.075);
        local function u24(p18, p19, p20) --[[ Line: 40 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v21 = Instance.new("Part");
            local v22 = p18 or "Studs";
            v21.Parent = u1;
            v21.TopSurface = Enum.SurfaceType[v22];
            v21.BackSurface = Enum.SurfaceType[v22];
            v21.FrontSurface = Enum.SurfaceType[v22];
            v21.BottomSurface = Enum.SurfaceType[v22];
            v21.LeftSurface = Enum.SurfaceType[v22];
            v21.RightSurface = Enum.SurfaceType[v22];
            v21.Anchored = true;
            v21.CanCollide = false;
            v21.Transparency = 1;
            if p20 then
                v21.Shape = Enum.PartType[p20];
            end;
            if p19 then
                v21.MaterialVariant = p19;
                local v23 = l__MaterialService__1:FindFirstChild(p19, true);
                if not v23 then
                    return v21;
                end;
                v21.Material = v23.BaseMaterial;
            end;
            return v21;
        end;
        local v25 = u4:NextNumber(4, 4.65) * u5;
        local v26 = u4:NextNumber(4.25, 5.25) * u5;
        local v27 = u4:NextInteger(5, 6) * u5;
        while u4:NextInteger(1, 4) == 1 and v27 < 10 do
            v27 = v27 + 1;
        end;
        local v28 = Vector3.new(v25, v26, v25);
        local l__CFrame__4 = l__Base__3.CFrame;
        local u29 = 1;
        local u30 = 1 * u5;
        local function u60(p31, p32, p33, p34) --[[ Line: 85 ]]
            -- upvalues: u4 (copy), u5 (ref), u24 (copy), u12 (copy), u13 (copy), l__FruitSpawnLocations__2 (copy)
            local v35 = u4:NextNumber(5.85, 7.25) * p33 * u5;
            local v36 = u24(nil, "2022 Weld");
            v36.Size = Vector3.new(v35, v35 * 0.8, v35);
            v36.CFrame = p31;
            v36.Orientation = Vector3.new(v36.Orientation.X * 0.2, v36.Orientation.Y, v36.Orientation.Z * 0.2);
            v36.CFrame = v36.CFrame * CFrame.new(0, v36.Size.Y * 0.35, 0);
            v36.Color = u4:NextInteger(1, 2) == 1 and u12 or u13;
            v36.Name = tostring(p32 + 1);
            for v37 = 1, 2 do
                local v38 = u24(nil, "2022 Weld");
                local v39 = v37 * 90;
                local v40 = v35 * 0.75;
                local v41 = v35 * 0.55;
                local v42 = v35 * u4:NextNumber(1.2, 1.35);
                v38.Size = Vector3.new(v40, v41, v42);
                local l__CFrame__5 = v36.CFrame;
                local l__Angles__6 = CFrame.Angles;
                local v43 = u4:NextNumber(-5, 5);
                local v44 = math.rad(v43);
                local v45 = math.rad(v39);
                local v46 = u4:NextNumber(-5, 5);
                v38.CFrame = l__CFrame__5 * l__Angles__6(v44, v45, (math.rad(v46)));
                v38.Color = u4:NextInteger(1, 2) == 1 and u12 or u13;
                v38.Name = tostring(p32 + 2);
            end;
            if u4:NextInteger(1, 3) == 1 or p34 then
                local v47 = u24(nil, "2022 Weld");
                v47.Size = Vector3.new(v35 * 0.75, v35 * 0.25, v35 * 0.75);
                local v48 = v36.CFrame * CFrame.new(0, v36.Size.Y / 2, 0);
                local l__Angles__7 = CFrame.Angles;
                local v49 = u4:NextNumber(-10, 10);
                local v50 = math.rad(v49);
                local v51 = u4:NextNumber(-10, 10);
                v47.CFrame = v48 * l__Angles__7(v50, math.rad(v51), 0);
                v47.Color = u4:NextInteger(1, 2) == 1 and u12 or u13;
                v47.Name = tostring(p32 + 2);
            end;
            if u4:NextInteger(1, 3) == 1 then
                for _ = 1, u4:NextInteger(1, 3) do
                    local v52 = u24(nil, "2022 Weld");
                    local v53 = u4:NextNumber(v35 * 0.65, v35 * 0.75);
                    local v54 = u4:NextNumber(-v35, v35) / 2.25;
                    local v55 = u4:NextNumber(-v35, v35) * 0.35;
                    local v56 = u4:NextNumber(-v35, v35) / 2.25;
                    v52.Size = Vector3.new(v53, v53 * 0.75, v53);
                    v52.CFrame = v36.CFrame * CFrame.new(v54, v55, v56);
                    v52.Color = u4:NextInteger(1, 2) == 1 and u12 or u13;
                    v52.Name = tostring(p32 + 2);
                end;
            end;
            if p34 then
            else
                for v57 = 1, 3 do
                    local v58 = u24();
                    local v59 = v57 * 120 + u4:NextNumber(-35, 35);
                    v58.Size = Vector3.new(1, 1, 1);
                    v58.CFrame = v36.CFrame * CFrame.Angles(0, math.rad(v59), 0) * CFrame.new(0, -v36.Size.Y / 2, v36.Size.Z * 0.35);
                    v58.Parent = l__FruitSpawnLocations__2;
                    v58.Transparency = 1;
                end;
            end;
        end;
        local function v72(p61, p62, p63) --[[ Line: 149 ]]
            -- upvalues: u29 (ref), u24 (copy), u4 (copy), u11 (copy), u60 (copy), u30 (ref)
            local v64 = 5;
            local l__Y__8 = p62.Y;
            if u29 > 3 then
                v64 = v64 - 1;
                if u29 > 5 then
                    v64 = v64 - 1;
                end;
            end;
            for v65 = 1, v64 do
                local v66 = u24();
                local v67 = u4:NextNumber(-25, -15);
                if v65 > 2 then
                    v67 = -v67;
                    if v65 == v64 then
                        v67 = v67 * 1.5;
                    end;
                end;
                v66.Size = p62;
                local l__Angles__9 = CFrame.Angles;
                local v68 = math.rad(v67);
                local v69 = u4:NextNumber(-10, 10);
                v66.CFrame = p61 * l__Angles__9(v68, 0, (math.rad(v69))) * CFrame.new(0, p62.Y / 2.2, 0);
                v66.Color = u11;
                v66.Name = tostring(p63 + v65);
                p61 = v66.CFrame * CFrame.new(0, p62.Y / 2.2, 0);
                local v70 = p62.X * 0.85;
                local v71 = l__Y__8 * u4:NextNumber(0.925, 1.05);
                p62 = Vector3.new(v70, v71, p62.Z * 0.85);
            end;
            u60(p61, p63 + v64, u30);
        end;
        local v73 = u30;
        for v74 = 1, v27 do
            local v75 = u24();
            v75.Size = v28;
            local l__Angles__10 = CFrame.Angles;
            local v76 = u4:NextNumber(-2, 2);
            local v77 = math.rad(v76);
            local v78 = u4:NextNumber(-2, 2);
            v75.CFrame = l__CFrame__4 * l__Angles__10(v77, 0, (math.rad(v78))) * CFrame.new(0, v28.Y / 2.2, 0);
            v75.Color = v17:Lerp(u11, (math.min((v74 - 1) / 3, 1)));
            v75.Name = tostring(v74);
            l__CFrame__4 = v75.CFrame * CFrame.new(0, v28.Y / 2.2, 0);
            local v79 = v28.Y * 1.075;
            if u4:NextInteger(1, 3) == 1 and v74 < v27 - 2 then
                local v80 = u24();
                v80.Size = Vector3.new(v28.X * 0.35, v28.Y * 1.25, v28.Z * 0.35);
                local l__CFrame__11 = v75.CFrame;
                local l__Angles__12 = CFrame.Angles;
                local v81 = u4:NextNumber(-180, 180);
                local v82 = l__CFrame__11 * l__Angles__12(0, math.rad(v81), 0) * CFrame.new(0, 0, -v75.Size.Z / 2);
                local l__Angles__13 = CFrame.Angles;
                local v83 = u4:NextNumber(-60, -40);
                v80.CFrame = v82 * l__Angles__13(math.rad(v83), 0, 0);
                v80.Color = u11;
                v80.Name = tostring(v74 + 1);
                u60(v80.CFrame * CFrame.new(0, v80.Size.Y / 2, 0), v74 + 1, 0.5, true);
            end;
            if v74 == 1 then
                v79 = v79 - 1 * u5;
                local v84 = u4:NextInteger(1, 4);
                for v85 = 1, v84 do
                    local v86 = u4:NextInteger(2, 4);
                    local v87 = 360 / v84 * v85 + u4:NextNumber(-20, 20);
                    local v88 = Vector3.new(v25 * 0.65, v25 * 0.725, v25 * 0.65);
                    local v89 = v75.CFrame * CFrame.new(0, v75.Size.Y * 0.25, 0) * CFrame.Angles(0, math.rad(v87), 1.5707963267948966) * CFrame.new(0, v25 * 0.3, 0);
                    for v90 = 1, v86 do
                        local v91 = u24();
                        local v92 = u4:NextNumber(47, 41);
                        if v90 > 1 then
                            v92 = u4:NextNumber(-20, -13);
                        end;
                        local v93 = v90 == 4 and 0 or v92;
                        v91.Size = v88;
                        local l__Angles__14 = CFrame.Angles;
                        local v94 = u4:NextNumber(-20, 20);
                        v91.CFrame = v89 * l__Angles__14(math.rad(v94), 0, (math.rad(v93))) * CFrame.new(0, v91.Size.Y / 2.2, 0);
                        v91.Color = v17;
                        v91.Name = tostring(v74 + v90);
                        v89 = v91.CFrame * CFrame.new(0, v91.Size.Y / 2.2, 0);
                        v88 = v88 * 0.85;
                    end;
                end;
            end;
            if u29 + 2 < v74 then
                u29 = v74;
                local v95 = u4:NextInteger(3, 5);
                for v96 = 1, v95 do
                    local v97 = 360 / v95 * v96 + u29 * u4:NextNumber(18, 25);
                    v72(v75.CFrame * CFrame.new(0, -v75.Size.Y * 0.65, 0) * CFrame.Angles(0, math.rad(v97), 0) * CFrame.Angles(-0.6108652381980153, 0, 0), v75.Size * 0.725, v74);
                end;
                u30 = v73 - 0.175;
                v73 = u30;
            end;
            v28 = Vector3.new(v28.X * 0.85, v79, v28.Z * 0.85);
        end;
        u60(l__CFrame__4, v27, u4:NextNumber(1.475, 1.725));
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u98) --[[ Name: BeginPlantGrowth, Line 264 ]]
        local l__PrimaryPart__15 = u98.PrimaryPart;
        local u99 = {};
        for _, v100 in u98:GetDescendants() do
            local v101 = tonumber(v100.Name);
            if v100:IsA("BasePart") and v101 then
                local v102 = {
                    v100,
                    v100.Size,
                    l__PrimaryPart__15.CFrame:ToObjectSpace(v100.CFrame),
                    v101
                };
                table.insert(u99, v102);
                v100.CanCollide = false;
                v100.Transparency = 1;
            end;
        end;
        local function v109() --[[ Line: 282 ]]
            -- upvalues: u98 (copy), u99 (copy), l__PrimaryPart__15 (copy)
            local v103 = u98:GetAttribute("Age") or 0;
            for _, v104 in u99 do
                local v105 = v104[1];
                local v106 = v104[2];
                local v107 = v104[3];
                local v108 = math.min(v103 - v104[4], 1);
                if v108 > 0 then
                    v105.Size = Vector3.new(v106.X, v106.Y * v108, v106.Z);
                    v105.CFrame = l__PrimaryPart__15.CFrame * v107 * CFrame.new(0, (v105.Size.Y - v106.Y) / 2, 0);
                    v105.Transparency = v105:GetAttribute("OG_Transparency") or 0;
                    v105.CanCollide = true;
                else
                    v105.Transparency = 1;
                    v105.CanCollide = false;
                end;
            end;
        end;
        u98:GetAttributeChangedSignal("Age"):Connect(v109);
        v109();
    end,
    Extras = {}
};