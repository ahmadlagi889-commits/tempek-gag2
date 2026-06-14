-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.0513,
        BaseWeight = 2,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local u4 = Random.new(p2);
        local v5 = p3 * 0.25 + 0.75;
        local v6 = v5 + v5 ^ 3 * 0.00001;
        local u7 = 1 * (math.random(8, 12) * 0.1);
        local v8 = 2 * (math.random(8, 12) * 0.1);
        local v9 = 0.25 * (math.random(8, 12) * 0.1);
        local v10 = 5 * (math.random(8, 12) * 0.1);
        local v11 = Color3.fromRGB(76, 51, 34);
        local u12 = Vector3.new(0, 0, 0);
        local u13 = 0;
        local v14 = Instance.new("Part");
        v14.Material = Enum.Material.Glacier;
        v14.MaterialVariant = "2022 Stud";
        v14.Anchored = true;
        v14.CanCollide = false;
        v14.Size = Vector3.new(v9, v8, v9);
        v14.Color = v11;
        v14.Position = u1.PrimaryPart.Position + Vector3.new(0, v8 / 2, 0);
        local u15 = 0 + 1;
        v14.Name = tostring(u15);
        v14.Parent = u1;
        local function v31(p16, p17, p18, p19) --[[ Line: 49 ]]
            -- upvalues: u4 (copy), u7 (copy), u15 (ref), u1 (copy), u12 (ref), u13 (ref)
            local v20 = 6.283185307179586 / p18;
            for v21 = 1, p18 do
                local v22 = v20 * v21 + p19;
                local v23 = math.cos(v22) * p17;
                local v24 = math.sin(v22) * p17;
                local v25 = Instance.new("Part");
                v25.Material = Enum.Material.Glacier;
                v25.MaterialVariant = "2022 Stud";
                v25.Anchored = true;
                v25.CanCollide = false;
                v25.Shape = Enum.PartType.Ball;
                local v26 = u4:NextInteger(90, 110) * 0.01;
                v25.Size = Vector3.new(u7, u7, u7) * v26;
                local v27 = v23 + u4:NextInteger(-5, 5) * 0.01;
                local v28 = u4:NextInteger(-5, 5) * 0.01;
                local v29 = v24 + u4:NextInteger(-5, 5) * 0.01;
                v25.Position = p16 + Vector3.new(v27, v28, v29);
                local v30 = u4:NextInteger(70, 80) * 0.01;
                v25.Color = Color3.fromHSV(v30, 0.67, 1);
                u15 = u15 + 1;
                v25.Name = tostring(u15);
                v25.Parent = u1;
                u12 = u12 + v25.Position;
                u13 = u13 + 1;
            end;
        end;
        local v32 = v14.Position + Vector3.new(0, -v14.Size.Y / 2, 0);
        local v33 = u15;
        local v34 = u13;
        local v35 = u12;
        local v36 = 0;
        for v37 = v10 - 1, 0, -1 do
            local v38 = v37 * 0.25;
            local v39 = v37 + 4;
            local v40 = u4:NextInteger(-180, 180);
            local v41 = 1;
            while v38 * v41 >= 0.2 or v41 == 1 do
                if v39 * v41 >= 1 then
                    v31(v32 - Vector3.new(0, v36, 0), v38 * v41, math.floor(v39 * v41), v40);
                end;
                v41 = v41 * 0.4;
                if v41 < 0.4 then
                    break;
                end;
            end;
            v36 = v36 + u7 * 0.75;
        end;
        local v42 = Instance.new("Part");
        v42.Size = Vector3.new(0.1, 0.1, 0.1);
        v42.Position = Vector3.new(v14.Position.X, v35.Y / v34 + 2, v14.Position.Z);
        v42.Anchored = true;
        v42.CanCollide = false;
        v42.Transparency = 1;
        v42:SetAttribute("DontShow", true);
        u15 = v33 + 1;
        v42.Name = tostring(u15);
        v42.Parent = u1;
        u1:ScaleTo(v6);
        u1:SetAttribute("CorePartName", "Grape");
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u43) --[[ Name: BeginFruitGrowth, Line 126 ]]
        local l__PrimaryPart__1 = u43.PrimaryPart;
        local u44 = {};
        for _, v45 in u43:GetDescendants() do
            local v46 = tonumber(v45.Name);
            if v45:IsA("BasePart") and v46 then
                local v47 = not v45:GetAttribute("DontShow");
                local v48 = {
                    v45,
                    v45.Size,
                    l__PrimaryPart__1.CFrame:ToObjectSpace(v45.CFrame),
                    v46,
                    v45.Shape == Enum.PartType.Ball
                };
                table.insert(u44, v48);
                v45.CanCollide = false;
                if v47 then
                    v45.Transparency = 1;
                end;
            end;
        end;
        local function v59() --[[ Line: 151 ]]
            -- upvalues: u43 (copy), u44 (copy), l__PrimaryPart__1 (copy)
            local v49 = u43:GetAttribute("Age") or 0;
            local v50 = u43:GetAttribute("MaxAge") or 1;
            local v51 = v49 / v50;
            for _, v52 in u44 do
                local v53 = v52[1];
                local v54 = v52[2];
                local v55 = v52[3];
                local v56 = v52[4];
                local v57 = v52[5];
                if not v53:GetAttribute("DontShow") then
                    local v58 = math.min((v51 - v56 / v50) * v50, 1);
                    if v58 > 0 then
                        if v57 then
                            v53.Size = v54 * v58;
                            v53.CFrame = l__PrimaryPart__1.CFrame * v55;
                        else
                            v53.Size = Vector3.new(v54.X, v54.Y * v58, v54.Z);
                            v53.CFrame = l__PrimaryPart__1.CFrame * v55 * CFrame.new(0, (v53.Size.Y - v54.Y) / 2, 0);
                        end;
                        v53.Transparency = v53:GetAttribute("OG_Transparency") or 0;
                        v53.CanCollide = true;
                    else
                        v53.Transparency = 1;
                        v53.CanCollide = false;
                    end;
                end;
            end;
        end;
        u43:GetAttributeChangedSignal("Age"):Connect(v59);
        v59();
    end,
    OnFullyGrown = function(p60) --[[ Name: OnFullyGrown, Line 196 ]]
        local v61 = p60:GetAttribute("CorePartName");
        if v61 then
            local v62 = p60:FindFirstChild(v61);
            local v63 = v62 and game.ServerStorage:FindFirstChild("Collect_PROX_Grape");
            if v63 then
                local v64 = v63:Clone();
                v64.Name = "ProximityPrompt";
                v64.Parent = v62;
            end;
        end;
        p60:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Grape",
        Harvestable = true
    }
};