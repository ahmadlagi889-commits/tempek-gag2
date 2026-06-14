-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.5,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local v4 = Random.new(p2);
        local v5 = 1.6 * p3;
        local v6 = 0.6 * p3;
        local v7 = 0.18 * p3;
        local v8 = 0.7 * p3;
        local v9 = 0.4 * p3;
        local v10 = 0.1 * p3;
        local v11 = Color3.fromRGB(90, 60, 40);
        local v12 = Color3.fromRGB(70, 45, 30);
        local v13 = Color3.fromRGB(50, 170, 50);
        local v14 = Color3.fromRGB(35, 140, 35);
        local v15 = {
            Color3.fromRGB(200, 35, 35),
            Color3.fromRGB(170, 0, 0),
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(100, 170, 50),
            Color3.fromRGB(255, 0, 0)
        };
        local v16 = 0;
        local v17 = v4:NextInteger(1, 3);
        if v4:NextInteger(1, 5) == 1 then
            v17 = v4:NextInteger(4, 5);
        end;
        local v18, v19, v20 = v15[v17]:ToHSV();
        local v21 = v18 + v4:NextNumber(-0.02, 0.02);
        local v22 = v19 + v4:NextNumber(-0.1, 0.1);
        local v23 = math.clamp(v22, 0.5, 1);
        local v24 = v20 + v4:NextNumber(-0.1, 0.1);
        local v25 = math.clamp(v24, 0.6, 1);
        local v26 = Color3.fromHSV(v21 % 1, v23, v25);
        local v27 = v4:NextNumber(0.9, 1.1);
        local v28 = v5 * v27;
        local v29 = v5 * v27 * v4:NextNumber(0.88, 0.95);
        local v30 = Instance.new("Part");
        v30.Material = Enum.Material.Glacier;
        v30.MaterialVariant = "2022 Stud";
        v30.Anchored = true;
        v30.CanCollide = false;
        v30.Shape = Enum.PartType.Ball;
        v30.Size = Vector3.new(v28, v29, v28);
        v30.Color = v26;
        v30.Position = p1.PrimaryPart.Position + Vector3.new(0, -v29 / 2, 0);
        local v31 = v16 + 1;
        v30.Name = tostring(v31 + 1);
        v30.Parent = p1;
        local v32 = Instance.new("Part");
        v32.Material = Enum.Material.Glacier;
        v32.MaterialVariant = "2022 Stud";
        v32.Anchored = true;
        v32.CanCollide = false;
        v32.Shape = Enum.PartType.Block;
        v32.Size = Vector3.new(v7, v6, v7);
        v32.Color = v11:Lerp(v12, v4:NextNumber(0, 0.4));
        v32.Position = v30.Position + Vector3.new(0, v29 / 2 + v6 / 2 - 0.05, 0);
        v32.Name = tostring(v31);
        v32.Parent = p1;
        local v33 = v31 + 1;
        v30.Name = tostring(v33);
        local v34 = v33 + 1;
        local v35 = Instance.new("Part");
        v35.Material = Enum.Material.Glacier;
        v35.MaterialVariant = "2022 Stud";
        v35.Anchored = true;
        v35.CanCollide = false;
        v35.Shape = Enum.PartType.Block;
        v35.Size = Vector3.new(v7 * 1.3, v6 * 0.2, v7 * 1.3);
        v35.Color = v12;
        v35.Position = v32.Position + Vector3.new(0, v6 / 2 + v6 * 0.2 / 2, 0);
        v35.Name = tostring(v34);
        v35.Parent = p1;
        local v36 = v4:NextInteger(0, 360);
        local v37 = v4:NextInteger(35, 55);
        local v38 = Instance.new("Part");
        v38.Material = Enum.Material.Glacier;
        v38.MaterialVariant = "2022 Stud";
        v38.Anchored = true;
        v38.CanCollide = false;
        v38.Shape = Enum.PartType.Block;
        v38.Size = Vector3.new(v9, v8, v10);
        v38.Color = v13:Lerp(v14, v4:NextNumber(0, 0.3));
        v38.CFrame = CFrame.new(v32.Position + Vector3.new(0, v6 * 0.3, 0)) * CFrame.Angles(0, math.rad(v36), 0) * CFrame.Angles(math.rad(v37), 0, 0) * CFrame.new(0, v8 / 2, 0);
        local v39 = v34 + 1;
        v38.Name = tostring(v39);
        v38.Parent = p1;
        local v40 = Instance.new("Part");
        v40.Material = Enum.Material.Glacier;
        v40.MaterialVariant = "2022 Stud";
        v40.Anchored = true;
        v40.CanCollide = false;
        v40.Shape = Enum.PartType.Wedge;
        v40.Size = Vector3.new(v10, v8 * 0.4, v9);
        v40.Color = v38.Color;
        v40.CFrame = v38.CFrame * CFrame.new(0, v8 / 2 + v8 * 0.4 / 2, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        local v41 = v39 + 1;
        v40.Name = tostring(v41);
        v40.Parent = p1;
        local v42 = Instance.new("Part");
        v42.Size = Vector3.new(0.1, 0.1, 0.1);
        v42.Position = v30.Position + Vector3.new(0, v29 / 2 + 1, 0);
        v42.Anchored = true;
        v42.CanCollide = false;
        v42.Transparency = 1;
        v42:SetAttribute("DontShow", true);
        v42.Name = tostring(v41 + 1);
        v42.Parent = p1;
        p1:SetAttribute("CorePartName", "Apple");
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u43) --[[ Name: BeginFruitGrowth, Line 148 ]]
        local l__PrimaryPart__1 = u43.PrimaryPart;
        local u44 = {};
        for _, v45 in u43:GetDescendants() do
            local v46 = tonumber(v45.Name);
            if v45:IsA("BasePart") and v46 then
                local v47 = not v45:GetAttribute("DontShow");
                local v48 = {
                    part = v45,
                    maxSize = v45.Size,
                    centerOffset = l__PrimaryPart__1.CFrame:ToObjectSpace(v45.CFrame),
                    partAge = v46
                };
                table.insert(u44, v48);
                v45.CanCollide = false;
                if v47 then
                    v45.Transparency = 1;
                end;
            end;
        end;
        local function v56() --[[ Line: 171 ]]
            -- upvalues: u43 (copy), u44 (copy), l__PrimaryPart__1 (copy)
            local v49 = u43:GetAttribute("CorePartName");
            local v50 = u43:GetAttribute("Age") or 0;
            local v51 = u43:GetAttribute("MaxAge") or 1;
            local v52 = v50 / v51;
            for _, v53 in u44 do
                if not v53.part:GetAttribute("DontShow") then
                    local v54 = math.clamp((v52 - v53.partAge / v51) * v51, 0, 1);
                    if v54 > 0 then
                        local v55 = v53.maxSize * v54;
                        v53.part.Size = v55;
                        if v53.part.Name == v49 then
                            v53.part.CFrame = l__PrimaryPart__1.CFrame * v53.centerOffset * CFrame.new(0, (v53.maxSize.Y - v55.Y) / 2, 0);
                        else
                            v53.part.CFrame = l__PrimaryPart__1.CFrame * v53.centerOffset * CFrame.new(0, -((v53.maxSize.Y - v55.Y) / 2), 0);
                        end;
                        v53.part.Transparency = v53.part:GetAttribute("OG_Transparency") or 0;
                        v53.part.CanCollide = true;
                    else
                        v53.part.Transparency = 1;
                        v53.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u43:GetAttributeChangedSignal("Age"):Connect(v56);
        v56();
    end,
    OnFullyGrown = function(p57) --[[ Name: OnFullyGrown, Line 211 ]]
        local v58 = p57:GetAttribute("CorePartName");
        if v58 then
            local v59 = p57:FindFirstChild(v58);
            local v60 = v59 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v60 then
                local v61 = v60:Clone();
                v61.Name = "ProximityPrompt";
                v61.Parent = v59;
            end;
        end;
        p57:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Apple",
        Harvestable = true
    }
};