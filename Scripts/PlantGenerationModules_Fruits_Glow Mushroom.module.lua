-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.05,
        BaseWeight = 7,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, p3) --[[ Name: InitFruit, Line 10 ]]
        local l__MaterialService__1 = game:GetService("MaterialService");
        local v4 = p3 or 1;
        local u5 = Random.new(p2);
        local l__Base__2 = u1.Base;
        local u6 = Color3.fromRGB(180, 170, 158);
        local v7, v8, v9 = Color3.fromRGB(100, 0, 192):ToHSV();
        local v10 = 0.1 or 0.05;
        local v11 = v7 + u5:NextNumber(-v10, v10);
        local v12 = math.clamp(v11, 0, 0.99);
        local u13 = Color3.fromHSV(v12, v8, v9);
        local function u20(p14, p15, p16) --[[ Line: 31 ]]
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
        local function v39(p21, p22, p23, p24, _) --[[ Line: 61 ]]
            -- upvalues: u20 (copy), u5 (copy), u6 (copy), u1 (copy), u13 (copy)
            local l__Y__3 = p22.Y;
            local l__X__4 = p22.X;
            local v25 = l__Y__3;
            for v26 = 1, p21 do
                local v27 = u20(nil, "2022 Inlet");
                v27.Size = p22;
                local l__Angles__5 = CFrame.Angles;
                local v28 = u5:NextNumber(-6, 6);
                local v29 = math.rad(v28);
                local v30 = u5:NextNumber(-6, 6);
                v27.CFrame = p23 * l__Angles__5(v29, 0.2617993877991494, (math.rad(v30))) * CFrame.new(0, p22.Y / 2.2, 0);
                v27.Color = u6;
                v27.Name = tostring(v26 + p24);
                p23 = v27.CFrame * CFrame.new(0, p22.Y / 2.2, 0);
                l__Y__3 = math.clamp(l__Y__3 * 1.15, 0, v25 * 2);
                if v26 == p21 then
                    local v31 = script.MushroomTop:Clone();
                    v31.Parent = u1;
                    v31:ScaleTo((v26 == p21 and u5:NextNumber(0.65, 0.75) or u5:NextNumber(0.19, 0.27)) * (l__X__4 * 0.85));
                    v31:PivotTo(p23);
                    for _, v32 in v31:GetChildren() do
                        local v33 = tonumber(v32.Name);
                        if v33 then
                            if v33 > 1 then
                                v32.Color = u13;
                            end;
                            if v33 == 3 then
                                local l__CFrame__6 = v32.CFrame;
                                local l__Angles__7 = CFrame.Angles;
                                local v34 = u5:NextNumber(-10, 10);
                                v32.CFrame = l__CFrame__6 * l__Angles__7(0, math.rad(v34), 0);
                            end;
                            if v33 > 1 and v26 == p21 then
                                local v35 = 90;
                                for _ = 1, 2 do
                                    for _ = 1, u5:NextInteger(3, 6) do
                                        local v36 = u5:NextNumber(p22.X * 0.08, p22.X * 0.1);
                                        local v37 = u20();
                                        local v38 = {
                                            X = 0,
                                            Y = u5:NextNumber(-v32.Size.Y, v32.Size.Y) * 0.35,
                                            Z = u5:NextNumber(-v32.Size.Z, v32.Size.Z) * 0.3
                                        };
                                        v37.Material = Enum.Material.Neon;
                                        v37.Size = Vector3.new(v36, v32.Size.Z + 0.1, v36);
                                        v37.CFrame = v32.CFrame * CFrame.Angles(0, math.rad(v35), 0) * CFrame.new(v38.X, v38.Y, v38.Z) * CFrame.Angles(0, 0, 1.5707963267948966);
                                        v37.Color = Color3.fromRGB(180, 170, 158);
                                        v37.Name = v26 + p24 + v33 + 1;
                                    end;
                                    v35 = v35 * 2;
                                end;
                            end;
                            v32.Name = v33 + v26 + p24;
                            v32.Parent = u1;
                        end;
                    end;
                end;
                p22 = Vector3.new(p22.X * 0.75, l__Y__3, p22.Z * 0.75);
            end;
        end;
        local v40 = u5:NextNumber(1.1, 1.2) * v4;
        local v41 = u5:NextNumber(1.7, 1.8) * v4;
        local v42 = math.clamp(2 * v4, 2, 3);
        local v43 = math.floor(v42);
        local v44 = Vector3.new(v40, v41, v40);
        local l__CFrame__8 = l__Base__2.CFrame;
        local _ = 1 * v4;
        v39(v43, v44, l__CFrame__8, 0, true);
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u45) --[[ Name: BeginFruitGrowth, Line 148 ]]
        local l__PrimaryPart__9 = u45.PrimaryPart;
        local u46 = {};
        for _, v47 in u45:GetDescendants() do
            local v48 = tonumber(v47.Name);
            if (v47:IsA("BasePart") or v47:IsA("MeshPart")) and v48 then
                local v49 = not v47:GetAttribute("DontShow");
                local v50 = {};
                for _, v51 in v47:GetChildren() do
                    if v51:IsA("Decal") or v51:IsA("Texture") then
                        table.insert(v50, {
                            decal = v51,
                            originalTransparency = v51.Transparency
                        });
                        if v49 then
                            v51.Transparency = 1;
                        end;
                    end;
                end;
                local v52 = {
                    part = v47,
                    maxSize = v47.Size,
                    centerOffset = l__PrimaryPart__9.CFrame:ToObjectSpace(v47.CFrame),
                    partAge = v48,
                    decals = v50
                };
                table.insert(u46, v52);
                v47.CanCollide = false;
                if v49 then
                    v47.Transparency = 1;
                end;
            end;
        end;
        local function v61() --[[ Line: 183 ]]
            -- upvalues: u45 (copy), u46 (copy), l__PrimaryPart__9 (copy)
            local v53 = u45:GetAttribute("Age") or 0;
            local v54 = u45:GetAttribute("MaxAge") or 1;
            local v55 = v53 / v54;
            for _, v56 in u46 do
                if not v56.part:GetAttribute("DontShow") then
                    local v57 = math.clamp((v55 - v56.partAge / v54) * v54, 0, 1);
                    if v57 > 0 then
                        local v58 = v56.maxSize * v57;
                        v56.part.Size = v58;
                        v56.part.CFrame = l__PrimaryPart__9.CFrame * v56.centerOffset * CFrame.new(0, -((v56.maxSize.Y - v58.Y) / 2), 0);
                        v56.part.Transparency = v56.part:GetAttribute("OG_Transparency") or 0;
                        v56.part.CanCollide = true;
                        for _, v59 in v56.decals do
                            v59.decal.Transparency = v59.originalTransparency + (1 - v59.originalTransparency) * (1 - v57);
                        end;
                    else
                        v56.part.Transparency = 1;
                        v56.part.CanCollide = false;
                        for _, v60 in v56.decals do
                            v60.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u45:GetAttributeChangedSignal("Age"):Connect(v61);
        v61();
    end,
    OnFullyGrown = function(p62) --[[ Name: OnFullyGrown, Line 218 ]]
        local v63 = p62:GetAttribute("CorePartName");
        if v63 then
            local v64 = p62:FindFirstChild(v63);
            local v65 = v64 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v65 then
                local v66 = v65:Clone();
                v66.Name = "ProximityPrompt";
                v66.Parent = v64;
            end;
        end;
        p62:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Glow Mushroom",
        Harvestable = true
    }
};