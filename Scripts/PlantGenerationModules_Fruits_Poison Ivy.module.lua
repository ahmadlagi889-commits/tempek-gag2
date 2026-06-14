-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0095,
        BaseWeight = 2.1,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, p3) --[[ Name: InitFruit, Line 10 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local v4 = p3 or 1;
        local v5 = Random.new(p2);
        local l__Base__2 = u1.Base;
        local v6 = Color3.fromRGB(74, 112, 33);
        local function v13(p7, p8, p9) --[[ Line: 26 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v10 = Instance.new("Part");
            local v11 = p7 or "Studs";
            v10.Parent = u1;
            v10.TopSurface = Enum.SurfaceType[v11];
            v10.BackSurface = Enum.SurfaceType[v11];
            v10.FrontSurface = Enum.SurfaceType[v11];
            v10.BottomSurface = Enum.SurfaceType[v11];
            v10.LeftSurface = Enum.SurfaceType[v11];
            v10.RightSurface = Enum.SurfaceType[v11];
            v10.Anchored = true;
            v10.CanCollide = false;
            v10.Transparency = 0;
            if p9 then
                v10.Shape = Enum.PartType[p9];
            end;
            if p8 then
                v10.MaterialVariant = p8;
                local v12 = l__MaterialService__1:FindFirstChild(p8, true);
                if not v12 then
                    return v10;
                end;
                v10.Material = v12.BaseMaterial;
            end;
            return v10;
        end;
        local v14 = v5:NextNumber(0.25, 0.35) * v4;
        local v15 = Vector3.new(v14, 1.8, v14);
        local l__CFrame__3 = l__Base__2.CFrame;
        local _ = 1 * v4;
        local v16 = 1.8;
        for v17 = 1, 2 do
            local v18 = v13(nil, "2022 Weld");
            v18.Size = v15;
            local l__Angles__4 = CFrame.Angles;
            local v19 = v5:NextNumber(-30, -15);
            local v20 = math.rad(v19);
            local v21 = v5:NextNumber(-6, 6);
            v18.CFrame = l__CFrame__3 * l__Angles__4(v20, 0, (math.rad(v21))) * CFrame.new(0, v15.Y / 2.2, 0);
            v18.Color = v6;
            v18.Name = tostring(v17);
            l__CFrame__3 = v18.CFrame * CFrame.new(0, v15.Y / 2.2, 0);
            v16 = math.clamp(v16 * 1.5, 0, 2.25);
            if v17 == 2 then
                local v22 = -90;
                for v23 = 1, 3 do
                    local v24 = script.Leaf:Clone();
                    v24.Parent = u1;
                    local v25 = v18.CFrame * CFrame.Angles(0, 3.141592653589793, (math.rad(v22))) * CFrame.new(0, v23 % 2 == 0 and (v18.Size.Y / 2.5 or 0) or 0, 0);
                    local l__Angles__5 = CFrame.Angles;
                    local v26 = v5:NextNumber(10, 25);
                    local v27 = math.rad(v26);
                    local v28 = v5:NextNumber(-10, 10);
                    v24:PivotTo(v25 * l__Angles__5(v27, 0, (math.rad(v28))));
                    v24.Size = v24.Size * v5:NextNumber(0.9, 1.05);
                    v24.Name = 3;
                    v24:AddTag("PoisonIvy");
                    v22 = v22 + 90;
                end;
            end;
            v15 = Vector3.new(v15.X * 0.85, v16, v15.Z * 0.85);
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u29) --[[ Name: BeginFruitGrowth, Line 100 ]]
        local l__PrimaryPart__6 = u29.PrimaryPart;
        local u30 = {};
        for _, v31 in u29:GetDescendants() do
            local v32 = tonumber(v31.Name);
            if v31:IsA("BasePart") and v32 then
                local v33 = not v31:GetAttribute("DontShow");
                local v34 = {};
                for _, v35 in v31:GetChildren() do
                    if v35:IsA("Decal") or v35:IsA("Texture") then
                        table.insert(v34, {
                            decal = v35,
                            originalTransparency = v35.Transparency
                        });
                        if v33 then
                            v35.Transparency = 1;
                        end;
                    end;
                end;
                local v36 = {
                    part = v31,
                    maxSize = v31.Size,
                    centerOffset = l__PrimaryPart__6.CFrame:ToObjectSpace(v31.CFrame),
                    partAge = v32,
                    decals = v34
                };
                table.insert(u30, v36);
                v31.CanCollide = false;
                if v33 then
                    v31.Transparency = 1;
                end;
            end;
        end;
        local function v45() --[[ Line: 135 ]]
            -- upvalues: u29 (copy), u30 (copy), l__PrimaryPart__6 (copy)
            local v37 = u29:GetAttribute("Age") or 0;
            local v38 = u29:GetAttribute("MaxAge") or 1;
            local v39 = v37 / v38;
            for _, v40 in u30 do
                if not v40.part:GetAttribute("DontShow") then
                    local v41 = math.clamp((v39 - v40.partAge / v38) * v38, 0, 1);
                    if v41 > 0 then
                        local v42 = v40.maxSize * v41;
                        v40.part.Size = v42;
                        v40.part.CFrame = l__PrimaryPart__6.CFrame * v40.centerOffset * CFrame.new(0, -((v40.maxSize.Y - v42.Y) / 2), 0);
                        v40.part.Transparency = v40.part:GetAttribute("OG_Transparency") or 0;
                        v40.part.CanCollide = true;
                        for _, v43 in v40.decals do
                            v43.decal.Transparency = v43.originalTransparency + (1 - v43.originalTransparency) * (1 - v41);
                        end;
                    else
                        v40.part.Transparency = 1;
                        v40.part.CanCollide = false;
                        for _, v44 in v40.decals do
                            v44.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u29:GetAttributeChangedSignal("Age"):Connect(v45);
        v45();
    end,
    OnFullyGrown = function(p46) --[[ Name: OnFullyGrown, Line 170 ]]
        local v47 = p46:GetAttribute("CorePartName");
        if v47 then
            local v48 = p46:FindFirstChild(v47);
            local v49 = v48 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v49 then
                local v50 = v49:Clone();
                v50.Name = "ProximityPrompt";
                v50.Parent = v48;
            end;
        end;
        p46:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Poison Ivy",
        Harvestable = true
    }
};