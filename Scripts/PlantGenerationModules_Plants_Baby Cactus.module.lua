-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 11 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local v4 = Random.new(p2);
        local _ = u1.FruitSpawnLocations;
        local v5 = u1.Base:GetPivot();
        local function v12(p6, p7, p8) --[[ Line: 28 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v9 = Instance.new("Part");
            local v10 = p6 or "Studs";
            v9.Parent = u1;
            v9.TopSurface = Enum.SurfaceType[v10];
            v9.BackSurface = Enum.SurfaceType[v10];
            v9.FrontSurface = Enum.SurfaceType[v10];
            v9.BottomSurface = Enum.SurfaceType[v10];
            v9.LeftSurface = Enum.SurfaceType[v10];
            v9.RightSurface = Enum.SurfaceType[v10];
            v9.Anchored = true;
            v9.CanCollide = false;
            v9.Transparency = 1;
            if p8 then
                v9.Shape = Enum.PartType[p8];
            end;
            if p7 then
                v9.MaterialVariant = p7;
                local v11 = l__MaterialService__1:FindFirstChild(p7, true);
                if not v11 then
                    return v9;
                end;
                v9.Material = v11.BaseMaterial;
            end;
            return v9;
        end;
        local v13 = v4:NextNumber(-2, 2);
        local v14 = p3 or 1;
        while v4:NextInteger(1, 5) == 1 do
            v13 = v13 + 0.2;
        end;
        local v15 = v4:NextInteger(5, 7);
        for v16 = 1, v15 do
            local v17 = script.Limb:Clone();
            for _, v18 in v17:GetChildren() do
                local v19, v20, v21 = v18.Color:ToHSV();
                local v22 = 0.03 or 0.05;
                local v23 = v19 + v4:NextNumber(-v22, v22);
                v18.Color = Color3.fromHSV(v23, v20, v21);
                v18.Size = v18.Size + Vector3.new(0, 0, v13);
            end;
            v17:ScaleTo(v4:NextNumber(0.96, 1.03));
            local v24 = v5 * CFrame.new(0, v17["2"].Size.Z / 2, 0);
            local l__Angles__2 = CFrame.Angles;
            local v25 = v4:NextInteger(-3, 3);
            local v26 = math.rad(v25);
            local v27 = 360 / v15 * v16 + v4:NextInteger(-15, 15);
            local v28 = math.rad(v27);
            local v29 = v4:NextInteger(-3, 3);
            v17:PivotTo(v24 * l__Angles__2(v26, v28, (math.rad(v29))));
            for _, v30 in v17:GetChildren() do
                v30.Name = tonumber(v30.Name) + v16;
                v30.Parent = u1;
            end;
            v17:Destroy();
        end;
        local v31 = v12();
        v31.Size = Vector3.new(1, 1, 1);
        v31.Position = u1["3"].Position + Vector3.new(0, u1["3"].Size.Z / 2, 0);
        v31.Parent = u1.FruitSpawnLocations;
        u1:ScaleTo(v14 * 0.5 + 0.5);
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u32) --[[ Name: BeginPlantGrowth, Line 105 ]]
        local l__PrimaryPart__3 = u32.PrimaryPart;
        local u33 = {};
        for _, v34 in u32:GetDescendants() do
            local v35 = tonumber(v34.Name);
            if v34:IsA("BasePart") and v35 then
                local v36 = {
                    v34,
                    v34.Size,
                    l__PrimaryPart__3.CFrame:ToObjectSpace(v34.CFrame),
                    v35
                };
                table.insert(u33, v36);
                v34.CanCollide = false;
                v34.Transparency = 1;
            end;
        end;
        local function v43() --[[ Line: 123 ]]
            -- upvalues: u32 (copy), u33 (copy), l__PrimaryPart__3 (copy)
            local v37 = u32:GetAttribute("Age") or 0;
            for _, v38 in u33 do
                local v39 = v38[1];
                local v40 = v38[2];
                local v41 = v38[3];
                local v42 = math.min(v37 - v38[4], 1);
                if v42 > 0 then
                    v39.Size = Vector3.new(v40.X, v40.Y * v42, v40.Z);
                    v39.CFrame = l__PrimaryPart__3.CFrame * v41 * CFrame.new(0, (v39.Size.Y - v40.Y) / 2, 0);
                    v39.Transparency = v39:GetAttribute("OG_Transparency") or 0;
                    v39.CanCollide = true;
                else
                    v39.Transparency = 1;
                    v39.CanCollide = false;
                end;
            end;
        end;
        u32:GetAttributeChangedSignal("Age"):Connect(v43);
        v43();
    end,
    Extras = {}
};