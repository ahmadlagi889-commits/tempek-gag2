-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 9 ]]
        local l__MaterialService__1 = game:GetService("MaterialService");
        local v4 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Base__3 = u1.Base;
        local v5 = (p3 or 1) * 0.25 + 0.75;
        local v6, v7 = Color3.fromRGB(51, 136, 5);
        local v8, v9, v10 = v6:ToHSV();
        local v11 = v7 or 0.05;
        local v12 = v8 + v4:NextNumber(-v11, v11);
        local v13 = math.clamp(v12, 0, 0.99);
        Color3.fromHSV(v13, v9, v10);
        local v14 = v4:NextInteger(9, 16);
        local function v37(p15) --[[ Line: 62 ]]
            -- upvalues: u1 (copy)
            local l__Size__4 = p15.Size;
            local l__CFrame__5 = p15.CFrame;
            local l__Y__6 = l__Size__4.Y;
            local v16 = math.ceil(l__Size__4.X / 2);
            local v17 = math.max(1, v16);
            local v18 = math.ceil(l__Size__4.Z / 2);
            local v19 = math.max(1, v18);
            local function v24(p20, p21) --[[ Line: 81 ]]
                local v22 = {};
                if p20 == 1 then
                    v22[1] = 0;
                    return v22;
                else
                    for v23 = 0, p20 - 1 do
                        v22[v23 + 1] = -p21 / 2 + 1 + v23 / (p20 - 1) * (p21 - 2);
                    end;
                    return v22;
                end;
            end;
            local v25 = v24(v17, l__Size__4.X);
            local v26 = v24(v19, l__Size__4.Z);
            for _, v27 in ipairs(v25) do
                local v28 = l__CFrame__5 * CFrame.new(v27, 0, l__Size__4.Z / 2 - 0.8);
                local v29 = Instance.new("TrussPart");
                v29.Anchored = true;
                v29.Size = Vector3.new(2, l__Y__6, 2);
                v29.CFrame = v28;
                v29:SetAttribute("TrunkReference", p15.Name);
                v29:AddTag("PlantTruss");
                v29.CanCollide = false;
                v29.Transparency = 1;
                v29.Parent = u1;
                local v30 = l__CFrame__5 * CFrame.new(v27, 0, -l__Size__4.Z / 2 + 0.8);
                local v31 = Instance.new("TrussPart");
                v31.Anchored = true;
                v31.Size = Vector3.new(2, l__Y__6, 2);
                v31.CFrame = v30;
                v31:SetAttribute("TrunkReference", p15.Name);
                v31:AddTag("PlantTruss");
                v31.CanCollide = false;
                v31.Transparency = 1;
                v31.Parent = u1;
            end;
            for _, v32 in ipairs(v26) do
                local v33 = l__CFrame__5 * CFrame.new(l__Size__4.X / 2 - 0.8, 0, v32);
                local v34 = Instance.new("TrussPart");
                v34.Anchored = true;
                v34.Size = Vector3.new(2, l__Y__6, 2);
                v34.CFrame = v33;
                v34:SetAttribute("TrunkReference", p15.Name);
                v34:AddTag("PlantTruss");
                v34.CanCollide = false;
                v34.Transparency = 1;
                v34.Parent = u1;
                local v35 = l__CFrame__5 * CFrame.new(-l__Size__4.X / 2 + 0.8, 0, v32);
                local v36 = Instance.new("TrussPart");
                v36.Anchored = true;
                v36.Size = Vector3.new(2, l__Y__6, 2);
                v36.CFrame = v35;
                v36:SetAttribute("TrunkReference", p15.Name);
                v36:AddTag("PlantTruss");
                v36.CanCollide = false;
                v36.Transparency = 1;
                v36.Parent = u1;
            end;
        end;
        local function v44(p38, p39, p40) --[[ Line: 32 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (copy)
            local v41 = Instance.new("Part");
            local v42 = p38 or "Studs";
            v41.Parent = u1;
            v41.TopSurface = Enum.SurfaceType[v42];
            v41.BackSurface = Enum.SurfaceType[v42];
            v41.FrontSurface = Enum.SurfaceType[v42];
            v41.BottomSurface = Enum.SurfaceType[v42];
            v41.LeftSurface = Enum.SurfaceType[v42];
            v41.RightSurface = Enum.SurfaceType[v42];
            v41.Anchored = true;
            v41.CanCollide = false;
            v41.Transparency = 0;
            if p40 then
                v41.Shape = Enum.PartType[p40];
            end;
            if p39 then
                v41.MaterialVariant = p39;
                local v43 = l__MaterialService__1:FindFirstChild(p39, true);
                if not v43 then
                    return v41;
                end;
                v41.Material = v43.BaseMaterial;
            end;
            return v41;
        end;
        while v4:NextInteger(1, 70) == 1 do
            v14 = v14 * 3;
        end;
        local v45 = v4:NextNumber(3, 4) * v5;
        local v46 = v4:NextNumber(1.5, 2) * v5;
        local v47 = Vector3.new(v45, v46, v45);
        local l__CFrame__7 = l__Base__3.CFrame;
        local v48 = v4:NextNumber(5, 8);
        local v49 = 360 * v4:NextNumber(1.85, 2.75) / v14;
        local v50, v51 = Color3.fromRGB(61, 146, 1);
        local v52, v53, v54 = v50:ToHSV();
        local v55 = v51 or 0.05;
        local v56 = v52 + v4:NextNumber(-v55, v55);
        local v57 = math.clamp(v56, 0, 0.99);
        local v58 = Color3.fromHSV(v57, v53, v54);
        local v59 = 0;
        while v4:NextInteger(1, 4) == 1 do
            v14 = v14 + v4:NextInteger(2, 4);
            if v14 > 25 then
                break;
            end;
        end;
        local l__CFrame__8 = l__Base__3.CFrame;
        local v60, v61 = Color3.fromRGB(137, 59, 13);
        local v62, v63, v64 = v60:ToHSV();
        local v65 = v61 or 0.05;
        local v66 = v62 + v4:NextNumber(-v65, v65);
        local v67 = math.clamp(v66, 0, 0.99);
        local v68 = Color3.fromHSV(v67, v63, v64);
        local v69, v70 = Color3.fromRGB(164, 96, 31);
        local v71, v72, v73 = v69:ToHSV();
        local v74 = v70 or 0.05;
        local v75 = v71 + v4:NextNumber(-v74, v74);
        local v76 = math.clamp(v75, 0, 0.99);
        local v77 = Color3.fromHSV(v76, v72, v73);
        local v78 = v14 / 2;
        for v79 = 1, v14 do
            local v80 = script.Trunk:Clone();
            v80.Parent = u1;
            v80.Size = v47;
            local l__Angles__9 = CFrame.Angles;
            local v81 = math.rad(v48);
            local v82 = v4:NextNumber(-4, 4);
            v80.CFrame = l__CFrame__7 * l__Angles__9(0, v81, (math.rad(v82))) * CFrame.new(0, v47.Y / 2.2, 0);
            v80.Name = v79;
            v80.Color = v68:Lerp(v77, 1 - math.abs((v79 - v78) / v78));
            v37(v80);
            local v83 = v47.X * 0.65;
            local l__new__10 = CFrame.new;
            local v84 = math.rad(v59);
            local v85 = math.cos(v84) * v83;
            local v86 = v47.Y / 2;
            local v87 = math.rad(v59);
            local v88 = l__CFrame__7 * l__new__10(v85, v86, math.sin(v87) * v83);
            local l__Magnitude__11 = (l__CFrame__8.Position - v88.Position).Magnitude;
            local v89 = v44(nil, "2022 Diamond Stud");
            local v90 = v4:NextNumber(0.7, 1.2) * v5;
            v89.Size = Vector3.new(v90, l__Magnitude__11 * 1.15, v90);
            v89.CFrame = CFrame.lookAt(l__CFrame__8.Position, v88.Position) * CFrame.new(0, 0, -l__Magnitude__11 / 2) * CFrame.Angles(-1.5707963267948966, 0, 0);
            v89.Color = v58;
            v89.Name = v79 + 1;
            l__CFrame__7 = v80.CFrame * CFrame.new(0, v47.Y / 2, 0);
            v59 = v59 + v49;
            if v79 == v14 then
                local v91 = v4:NextInteger(12, 14);
                l__CFrame__8 = v88;
                for v92 = 1, v91 do
                    local v93 = script.Leaf:Clone();
                    v93.Parent = u1;
                    local v94 = 360 / v91 * v92;
                    v93:ScaleTo(v4:NextNumber(0.85, 1.1) * v5);
                    local v95 = l__CFrame__7 * CFrame.Angles(0, math.rad(v94), 0) * CFrame.new(v47.X * 0.35, 0, 0);
                    local l__Angles__12 = CFrame.Angles;
                    local v96 = -v4:NextNumber(25, 40);
                    v93:PivotTo(v95 * l__Angles__12(0, 0, (math.rad(v96))));
                    for _, v97 in v93:GetChildren() do
                        if v97.Name == "FruitSpawn" then
                            v97.CFrame = v97.CFrame * CFrame.new(0, v4:NextNumber(-2, 2), 0);
                            v97.Parent = l__FruitSpawnLocations__2;
                        end;
                        local v98 = tonumber(v97.Name);
                        if v98 then
                            v97.Color = v58;
                            v97.Name = v98 + v79;
                            v97.Parent = u1;
                        end;
                    end;
                    v88 = l__CFrame__8;
                    l__CFrame__8 = v88;
                end;
            else
                l__CFrame__8 = v88;
            end;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u99) --[[ Name: BeginPlantGrowth, Line 197 ]]
        local l__PrimaryPart__13 = u99.PrimaryPart;
        local u100 = {};
        local u101 = {};
        for _, v102 in u99:GetDescendants() do
            if v102:IsA("BasePart") and v102:HasTag("PlantTruss") then
                table.insert(u100, v102);
            else
                local v103 = tonumber(v102.Name);
                if (v102:IsA("BasePart") or v102:IsA("MeshPart")) and v103 then
                    local v104 = {
                        v102,
                        v102.Size,
                        l__PrimaryPart__13.CFrame:ToObjectSpace(v102.CFrame),
                        v103
                    };
                    table.insert(u101, v104);
                    v102.CanCollide = false;
                    v102.Transparency = 1;
                end;
            end;
        end;
        local function v114() --[[ Line: 220 ]]
            -- upvalues: u99 (copy), u101 (copy), l__PrimaryPart__13 (copy), u100 (copy)
            local v105 = u99:GetAttribute("Age") or 0;
            for _, v106 in u101 do
                local v107 = v106[1];
                local v108 = v106[2];
                local v109 = v106[3];
                local v110 = math.min(v105 - v106[4], 1);
                if v110 > 0 then
                    v107.Size = Vector3.new(v108.X, v108.Y * v110, v108.Z);
                    v107.CFrame = l__PrimaryPart__13.CFrame * v109 * CFrame.new(0, (v107.Size.Y - v108.Y) / 2, 0);
                    v107.Transparency = v107:GetAttribute("OG_Transparency") or 0;
                    v107.CanCollide = true;
                else
                    v107.Transparency = 1;
                    v107.CanCollide = false;
                end;
            end;
            for _, v111 in u100 do
                local v112 = v111:GetAttribute("TrunkReference");
                local v113 = tonumber(v112);
                if v113 then
                    if math.min(v105 - v113, 1) >= 1 then
                        v111.CanCollide = true;
                    else
                        v111.CanCollide = false;
                    end;
                end;
            end;
        end;
        u99:GetAttributeChangedSignal("Age"):Connect(v114);
        v114();
    end,
    Extras = {}
};