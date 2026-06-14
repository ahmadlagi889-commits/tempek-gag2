-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 9 ]]
        local l__MaterialService__1 = game:GetService("MaterialService");
        local u4 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Base__3 = u1.Base;
        local v5, v6 = Color3.fromRGB(51, 136, 5);
        local v7, v8, v9 = v5:ToHSV();
        local v10 = v6 or 0.05;
        local v11 = v7 + u4:NextNumber(-v10, v10);
        local v12 = math.clamp(v11, 0, 0.99);
        local u13 = Color3.fromHSV(v12, v8, v9);
        local function u20(p14, p15, p16) --[[ Line: 30 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (copy)
            local v17 = Instance.new("Part");
            local v18 = p14 or "Studs";
            v17.Parent = u1;
            v17.TopSurface = Enum.SurfaceType[v18];
            v17.BackSurface = Enum.SurfaceType[v18];
            v17.FrontSurface = Enum.SurfaceType[v18];
            v17.BottomSurface = Enum.SurfaceType[v18];
            v17.LeftSurface = Enum.SurfaceType[v18];
            v17.RightSurface = Enum.SurfaceType[v18];
            v17.Anchored = true;
            v17.CanCollide = false;
            v17.Transparency = 0;
            if p16 then
                v17.Shape = Enum.PartType[p16];
            end;
            if p15 then
                v17.MaterialVariant = p15;
                local v19 = l__MaterialService__1:FindFirstChild(p15, true);
                if not v19 then
                    return v17;
                end;
                v17.Material = v19.BaseMaterial;
            end;
            return v17;
        end;
        local function u27(p21, p22, p23) --[[ Line: 60 ]]
            -- upvalues: u20 (copy), u13 (copy), l__FruitSpawnLocations__2 (copy)
            local v24 = u20(nil, "2022 Inlet");
            v24.Size = Vector3.new(p22.X * 1.5, 0.5, p22.X * 1.5);
            v24.CFrame = p21;
            v24.Color = u13;
            v24.Name = p23 + 1;
            local v25 = u20(nil, "2022 Inlet");
            v25.Size = Vector3.new(p22.X * 1.5, 0.4, p22.X * 1.5);
            v25.CFrame = v24.CFrame * CFrame.Angles(0, 0.7853981633974483, 0);
            v25.Color = u13;
            v25.Name = p23 + 2;
            local v26 = u20();
            v26.Parent = l__FruitSpawnLocations__2;
            v26.Size = Vector3.new(1, 1, 1);
            v26.CFrame = v24.CFrame * CFrame.new(0, 0.25, 0);
            v26.Transparency = 1;
        end;
        local function v54(p28, p29, p30, p31) --[[ Line: 83 ]]
            -- upvalues: u20 (copy), u4 (copy), u13 (copy), u27 (copy), u1 (copy)
            for v32 = 1, p28 do
                local v33 = u20(nil, "2022 Inlet");
                v33.Size = p29;
                local l__Angles__4 = CFrame.Angles;
                local v34 = u4:NextNumber(-9, 9);
                local v35 = math.rad(v34);
                local v36 = u4:NextNumber(-9, 9);
                v33.CFrame = p30 * l__Angles__4(v35, 0.2617993877991494, (math.rad(v36))) * CFrame.new(0, p29.Y / 2.2, 0);
                v33.Color = u13;
                v33.Name = v32 + p31;
                if v32 > 1 and (v32 < p28 and u4:NextInteger(1, 2) == 1) then
                    local v37 = u4:NextInteger(1, 3);
                    local v38 = v33.CFrame * CFrame.new(0, -(v33.Size.Y / 2), 0);
                    local l__Angles__5 = CFrame.Angles;
                    local v39 = u4:NextNumber(-180, 180);
                    local v40 = v38 * l__Angles__5(0, math.rad(v39), 0);
                    local l__Angles__6 = CFrame.Angles;
                    local v41 = u4:NextNumber(20, 40);
                    local v42 = v40 * l__Angles__6(math.rad(v41), 0, 0);
                    for v43 = 1, v37 do
                        local v44 = u20(nil, "2022 Inlet");
                        v44.Size = Vector3.new(p29.X * 0.9, p29.Y * 0.6, p29.Z * 0.9);
                        local l__Angles__7 = CFrame.Angles;
                        local v45 = u4:NextNumber(10, 25);
                        v44.CFrame = v42 * l__Angles__7(math.rad(v45), 0, 0) * CFrame.new(0, v44.Size.Y / 2, 0);
                        v44.Name = v32 + p31 + v43;
                        v44.Color = u13;
                        v42 = v44.CFrame * CFrame.new(0, v44.Size.Y / 2, 0);
                        local l__CFrame__8 = v44.CFrame;
                        local l__Angles__9 = CFrame.Angles;
                        local v46 = u4:NextNumber(-25, 25);
                        v44.CFrame = l__CFrame__8 * l__Angles__9(0, math.rad(v46), 0);
                        if v43 == v37 then
                            u27(v42, v44.Size, v32 + p31 + v43);
                        end;
                    end;
                end;
                if u4:NextInteger(1, 3) == 1 then
                    local v47 = u20(nil, "2022 Inlet");
                    v47.Size = Vector3.new(p29.X * 0.8, p29.Y * 0.65, p29.Z * 0.8);
                    local v48 = v33.CFrame * CFrame.new(0, -(v33.Size.Y / 2), 0);
                    local l__Angles__10 = CFrame.Angles;
                    local v49 = u4:NextNumber(-180, 180);
                    local v50 = v48 * l__Angles__10(0, math.rad(v49), 0);
                    local l__Angles__11 = CFrame.Angles;
                    local v51 = u4:NextNumber(40, 55);
                    v47.CFrame = v50 * l__Angles__11(math.rad(v51), 0, 0) * CFrame.new(0, v47.Size.Y / 2, 0);
                    v47.Name = v32 + p31 + 1;
                    v47.Color = u13;
                    local v52 = script.FlowerPetal:Clone();
                    v52.Parent = u1;
                    v52:PivotTo(v47.CFrame * CFrame.new(0, v47.Size.Y / 2.5, 0) * CFrame.Angles(0.6108652381980153, 0, 0));
                    v52.Name = v32 + p31 + 2;
                end;
                p30 = v33.CFrame * CFrame.new(0, p29.Y / 2.2, 0);
                local l__CFrame__12 = v33.CFrame;
                local l__Angles__13 = CFrame.Angles;
                local v53 = u4:NextNumber(-25, 25);
                v33.CFrame = l__CFrame__12 * l__Angles__13(0, math.rad(v53), 0);
                if v32 == p28 then
                    u27(p30, v33.Size, v32 + p31);
                end;
            end;
        end;
        local v55 = u4:NextInteger(3, 5);
        local v56 = p3 or 1;
        for v57 = 1, v55 do
            local v58 = script.CurvedLeaf:Clone();
            v58.Parent = u1;
            local v59 = 360 / v55 * (v57 * u4:NextNumber(0.8, 1.2));
            local v60 = l__Base__3.CFrame * CFrame.Angles(0, math.rad(v59), 0);
            local l__Angles__14 = CFrame.Angles;
            local v61 = -u4:NextNumber(35, 55);
            v58:PivotTo(v60 * l__Angles__14(math.rad(v61), 0, 0));
            v58.Name = 1;
        end;
        local v62 = u4:NextNumber(0.45, 0.75) * (v56 * 0.5 + 0.5);
        local v63 = u4:NextNumber(2.9, 4) * (v56 * 0.5 + 0.5);
        local v64 = u4:NextInteger(3, 5) * v56;
        while u4:NextInteger(1, 30) == 1 do
            v64 = v64 * 2;
            while u4:NextInteger(1, 3) == 1 do
                v62 = v62 * 2;
                v63 = v63 * 2;
            end;
        end;
        v54(v64, Vector3.new(v62, v63, v62), l__Base__3.CFrame, 0, true);
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u65) --[[ Name: BeginPlantGrowth, Line 171 ]]
        local l__PrimaryPart__15 = u65.PrimaryPart;
        local u66 = {};
        for _, v67 in u65:GetDescendants() do
            local v68 = tonumber(v67.Name);
            if (v67:IsA("BasePart") or v67:IsA("MeshPart")) and v68 then
                local v69 = {
                    v67,
                    v67.Size,
                    l__PrimaryPart__15.CFrame:ToObjectSpace(v67.CFrame),
                    v68
                };
                table.insert(u66, v69);
                v67.CanCollide = false;
                v67.Transparency = 1;
            end;
        end;
        local function v76() --[[ Line: 189 ]]
            -- upvalues: u65 (copy), u66 (copy), l__PrimaryPart__15 (copy)
            local v70 = u65:GetAttribute("Age") or 0;
            for _, v71 in u66 do
                local v72 = v71[1];
                local v73 = v71[2];
                local v74 = v71[3];
                local v75 = math.min(v70 - v71[4], 1);
                if v75 > 0 then
                    v72.Size = Vector3.new(v73.X, v73.Y * v75, v73.Z);
                    v72.CFrame = l__PrimaryPart__15.CFrame * v74 * CFrame.new(0, (v72.Size.Y - v73.Y) / 2, 0);
                    v72.Transparency = v72:GetAttribute("OG_Transparency") or 0;
                    v72.CanCollide = true;
                else
                    v72.Transparency = 1;
                    v72.CanCollide = false;
                end;
            end;
        end;
        u65:GetAttributeChangedSignal("Age"):Connect(v76);
        v76();
    end,
    Extras = {}
};