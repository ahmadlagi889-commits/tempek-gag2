-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, _) --[[ Name: InitPlant, Line 11 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local v3 = Random.new(p2);
        local _ = u1.FruitSpawnLocations;
        local v4 = u1.Base:GetPivot();
        local function v11(p5, p6, p7) --[[ Line: 28 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v8 = Instance.new("Part");
            local v9 = p5 or "Studs";
            v8.Parent = u1;
            v8.TopSurface = Enum.SurfaceType[v9];
            v8.BackSurface = Enum.SurfaceType[v9];
            v8.FrontSurface = Enum.SurfaceType[v9];
            v8.BottomSurface = Enum.SurfaceType[v9];
            v8.LeftSurface = Enum.SurfaceType[v9];
            v8.RightSurface = Enum.SurfaceType[v9];
            v8.Anchored = true;
            v8.CanCollide = false;
            v8.Transparency = 1;
            if p7 then
                v8.Shape = Enum.PartType[p7];
            end;
            if p6 then
                v8.MaterialVariant = p6;
                local v10 = l__MaterialService__1:FindFirstChild(p6, true);
                if not v10 then
                    return v8;
                end;
                v8.Material = v10.BaseMaterial;
            end;
            return v8;
        end;
        local v12 = v3:NextInteger(5, 12);
        for v13 = 1, v12 do
            local v14 = script.Leaf:Clone();
            v14:ScaleTo(v3:NextNumber(0.7, 1.25));
            local l__Angles__2 = CFrame.Angles;
            local v15 = v3:NextInteger(-3, 3);
            local v16 = math.rad(v15);
            local v17 = 360 / v12 * v13 + v3:NextInteger(-22, 22);
            local v18 = math.rad(v17);
            local v19 = v3:NextInteger(-16, -9);
            v14:PivotTo(v4 * l__Angles__2(v16, v18, (math.rad(v19))));
            for _, v20 in v14:GetChildren() do
                v20.Name = tonumber(v20.Name) + v13;
                v20.Parent = u1;
            end;
            v14:Destroy();
        end;
        local v21 = v3:NextInteger(2, 4);
        for v22 = 1, v21 do
            local v23 = script.Leaf:Clone();
            v23:ScaleTo(v3:NextNumber(0.6, 0.9));
            local l__Angles__3 = CFrame.Angles;
            local v24 = v3:NextInteger(-3, 3);
            local v25 = math.rad(v24);
            local v26 = 360 / v21 * v22 + v3:NextInteger(-45, 45);
            local v27 = math.rad(v26);
            local v28 = v3:NextInteger(-25, -15);
            v23:PivotTo(v4 * l__Angles__3(v25, v27, (math.rad(v28))));
            for _, v29 in v23:GetChildren() do
                v29.Name = tonumber(v29.Name) + v22;
                v29.Parent = u1;
            end;
            v23:Destroy();
        end;
        local v30 = v11();
        v30.Size = Vector3.new(1, 1, 1);
        v30.Position = v4.Position;
        v30.Parent = u1.FruitSpawnLocations;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u31) --[[ Name: BeginPlantGrowth, Line 117 ]]
        local l__PrimaryPart__4 = u31.PrimaryPart;
        local u32 = {};
        for _, v33 in u31:GetDescendants() do
            local v34 = tonumber(v33.Name);
            if v33:IsA("BasePart") and v34 then
                local v35 = {
                    v33,
                    v33.Size,
                    l__PrimaryPart__4.CFrame:ToObjectSpace(v33.CFrame),
                    v34
                };
                table.insert(u32, v35);
                v33.CanCollide = false;
                v33.Transparency = 1;
            end;
        end;
        local function v42() --[[ Line: 135 ]]
            -- upvalues: u31 (copy), u32 (copy), l__PrimaryPart__4 (copy)
            local v36 = u31:GetAttribute("Age") or 0;
            for _, v37 in u32 do
                local v38 = v37[1];
                local v39 = v37[2];
                local v40 = v37[3];
                local v41 = math.min(v36 - v37[4], 1);
                if v41 > 0 then
                    v38.Size = Vector3.new(v39.X, v39.Y * v41, v39.Z);
                    v38.CFrame = l__PrimaryPart__4.CFrame * v40 * CFrame.new(0, (v38.Size.Y - v39.Y) / 2, 0);
                    v38.Transparency = v38:GetAttribute("OG_Transparency") or 0;
                    v38.CanCollide = true;
                else
                    v38.Transparency = 1;
                    v38.CanCollide = false;
                end;
            end;
        end;
        u31:GetAttributeChangedSignal("Age"):Connect(v42);
        v42();
    end,
    Extras = {}
};