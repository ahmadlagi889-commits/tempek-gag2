-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.1167,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local v4 = Random.new(p2);
        local v5 = p3 * 0.75 + 0.25;
        local v6 = v5 + v5 ^ 3 * 5e-7;
        local v7 = 1.6 * v6;
        local v8 = 0.6 * v6;
        local v9 = 0.18 * v6;
        local v10 = 0.7 * v6;
        local v11 = 0.4 * v6;
        local v12 = 0.1 * v6;
        local v13 = Color3.fromRGB(90, 60, 40);
        local v14 = Color3.fromRGB(70, 45, 30);
        local v15 = Color3.fromRGB(50, 170, 50);
        local v16 = Color3.fromRGB(35, 140, 35);
        local v17 = {
            Color3.fromRGB(200, 35, 35),
            Color3.fromRGB(170, 0, 0),
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(100, 170, 50),
            Color3.fromRGB(255, 0, 0)
        };
        local v18 = 0;
        local v19 = v4:NextInteger(1, 3);
        if v4:NextInteger(1, 5) == 1 then
            v19 = v4:NextInteger(4, 5);
        end;
        local v20, v21, v22 = v17[v19]:ToHSV();
        local v23 = v20 + v4:NextNumber(-0.02, 0.02);
        local v24 = v21 + v4:NextNumber(-0.1, 0.1);
        local v25 = math.clamp(v24, 0.5, 1);
        local v26 = v22 + v4:NextNumber(-0.1, 0.1);
        local v27 = math.clamp(v26, 0.6, 1);
        local v28 = Color3.fromHSV(v23 % 1, v25, v27);
        local v29 = v4:NextNumber(0.9, 1.1);
        local v30 = v7 * v29;
        local v31 = v7 * v29 * v4:NextNumber(0.88, 0.95);
        local v32 = Instance.new("Part");
        v32.Material = Enum.Material.Glacier;
        v32.MaterialVariant = "2022 Stud";
        v32.Anchored = true;
        v32.CanCollide = false;
        v32.Shape = Enum.PartType.Ball;
        v32.Size = Vector3.new(v30, v31, v30);
        v32.Color = v28;
        v32.Position = p1.PrimaryPart.Position + Vector3.new(0, -v31 / 2, 0);
        local v33 = v18 + 1;
        v32.Name = tostring(v33 + 1);
        v32.Parent = p1;
        local v34 = Instance.new("Part");
        v34.Material = Enum.Material.Glacier;
        v34.MaterialVariant = "2022 Stud";
        v34.Anchored = true;
        v34.CanCollide = false;
        v34.Shape = Enum.PartType.Block;
        v34.Size = Vector3.new(v9, v8, v9);
        v34.Color = v13:Lerp(v14, v4:NextNumber(0, 0.4));
        v34.Position = v32.Position + Vector3.new(0, v31 / 2 + v8 / 2 - 0.05, 0);
        v34.Name = tostring(v33);
        v34.Parent = p1;
        local v35 = v33 + 1;
        v32.Name = tostring(v35);
        local v36 = v35 + 1;
        local v37 = Instance.new("Part");
        v37.Material = Enum.Material.Glacier;
        v37.MaterialVariant = "2022 Stud";
        v37.Anchored = true;
        v37.CanCollide = false;
        v37.Shape = Enum.PartType.Block;
        v37.Size = Vector3.new(v9 * 1.3, v8 * 0.2, v9 * 1.3);
        v37.Color = v14;
        v37.Position = v34.Position + Vector3.new(0, v8 / 2 + v8 * 0.2 / 2, 0);
        v37.Name = tostring(v36);
        v37.Parent = p1;
        local v38 = v4:NextInteger(0, 360);
        local v39 = v4:NextInteger(35, 55);
        local v40 = Instance.new("Part");
        v40.Material = Enum.Material.Glacier;
        v40.MaterialVariant = "2022 Stud";
        v40.Anchored = true;
        v40.CanCollide = false;
        v40.Shape = Enum.PartType.Block;
        v40.Size = Vector3.new(v11, v10, v12);
        v40.Color = v15:Lerp(v16, v4:NextNumber(0, 0.3));
        v40.CFrame = CFrame.new(v34.Position + Vector3.new(0, v8 * 0.3, 0)) * CFrame.Angles(0, math.rad(v38), 0) * CFrame.Angles(math.rad(v39), 0, 0) * CFrame.new(0, v10 / 2, 0);
        local v41 = v36 + 1;
        v40.Name = tostring(v41);
        v40.Parent = p1;
        local v42 = Instance.new("Part");
        v42.Material = Enum.Material.Glacier;
        v42.MaterialVariant = "2022 Stud";
        v42.Anchored = true;
        v42.CanCollide = false;
        v42.Shape = Enum.PartType.Wedge;
        v42.Size = Vector3.new(v12, v10 * 0.4, v11);
        v42.Color = v40.Color;
        v42.CFrame = v40.CFrame * CFrame.new(0, v10 / 2 + v10 * 0.4 / 2, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        local v43 = v41 + 1;
        v42.Name = tostring(v43);
        v42.Parent = p1;
        local v44 = Instance.new("Part");
        v44.Size = Vector3.new(0.1, 0.1, 0.1);
        v44.Position = v32.Position + Vector3.new(0, v31 / 2 + 1, 0);
        v44.Anchored = true;
        v44.CanCollide = false;
        v44.Transparency = 1;
        v44:SetAttribute("DontShow", true);
        v44.Name = tostring(v43 + 1);
        v44.Parent = p1;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u45) --[[ Name: BeginFruitGrowth, Line 151 ]]
        local l__PrimaryPart__1 = u45.PrimaryPart;
        local u46 = {};
        for _, v47 in u45:GetDescendants() do
            local v48 = tonumber(v47.Name);
            if v47:IsA("BasePart") and v48 then
                local v49 = not v47:GetAttribute("DontShow");
                local v50 = {
                    part = v47,
                    maxSize = v47.Size,
                    centerOffset = l__PrimaryPart__1.CFrame:ToObjectSpace(v47.CFrame),
                    partAge = v48
                };
                table.insert(u46, v50);
                v47.CanCollide = false;
                if v49 then
                    v47.Transparency = 1;
                end;
            end;
        end;
        local function v58() --[[ Line: 174 ]]
            -- upvalues: u45 (copy), u46 (copy), l__PrimaryPart__1 (copy)
            local v51 = u45:GetAttribute("CorePartName");
            local v52 = u45:GetAttribute("Age") or 0;
            local v53 = u45:GetAttribute("MaxAge") or 1;
            local v54 = v52 / v53;
            for _, v55 in u46 do
                if not v55.part:GetAttribute("DontShow") then
                    local v56 = math.clamp((v54 - v55.partAge / v53) * v53, 0, 1);
                    if v56 > 0 then
                        local v57 = v55.maxSize * v56;
                        v55.part.Size = v57;
                        if v55.part.Name == v51 then
                            v55.part.CFrame = l__PrimaryPart__1.CFrame * v55.centerOffset * CFrame.new(0, (v55.maxSize.Y - v57.Y) / 2, 0);
                        else
                            v55.part.CFrame = l__PrimaryPart__1.CFrame * v55.centerOffset * CFrame.new(0, -((v55.maxSize.Y - v57.Y) / 2), 0);
                        end;
                        v55.part.Transparency = v55.part:GetAttribute("OG_Transparency") or 0;
                        v55.part.CanCollide = true;
                    else
                        v55.part.Transparency = 1;
                        v55.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u45:GetAttributeChangedSignal("Age"):Connect(v58);
        v58();
    end,
    OnFullyGrown = function(p59) --[[ Name: OnFullyGrown, Line 214 ]]
        local v60 = p59:GetAttribute("CorePartName");
        if v60 then
            local v61 = p59:FindFirstChild(v60);
            local v62 = v61 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v62 then
                local v63 = v62:Clone();
                v63.Name = "ProximityPrompt";
                v63.Parent = v61;
            end;
        end;
        p59:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Apple",
        Harvestable = true
    }
};