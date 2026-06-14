-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0413,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, p3) --[[ Name: InitFruit, Line 13 ]]
        local u4 = Random.new(p2);
        local _ = p3 * 0.2;
        local v5 = {
            Color3.fromRGB(255, 237, 38),
            Color3.fromRGB(255, 201, 24),
            Color3.fromRGB(228, 255, 92),
            Color3.fromRGB(255, 219, 75),
            Color3.fromRGB(255, 234, 0)
        };
        local v6 = v5[math.random(1, #v5)];
        local v7 = v5[math.random(1, #v5)];
        local u8 = nil;
        while v6 == v7 do
            v7 = v5[math.random(1, #v5)];
        end;
        local v9 = u4:NextInteger(7, 9) + p3;
        local v10 = u1.Base:GetPivot();
        local l__Angles__1 = CFrame.Angles;
        local v11 = u4:NextInteger(-90, 90);
        (function(p12, p13) --[[ Name: generateTrunk, Line 46 ]]
            -- upvalues: u4 (copy), u8 (ref), u1 (copy)
            for v14 = 1, p13 do
                local v15 = script.Part:Clone();
                local v16 = (v14 - 1) / math.max(p13 - 1, 1) * 3.141592653589793;
                local v17 = (math.sin(v16) * 0.7 + 0.30000000000000004) * 1.75;
                local v18 = math.clamp(v17, 0.15, 10) * u4:NextNumber(0.9, 1.1);
                local l__Angles__2 = CFrame.Angles;
                local v19 = u4:NextNumber(5, 7);
                local v20 = math.rad(v19);
                local v21 = u4:NextNumber(-5, 5);
                local v22 = math.rad(v21);
                local v23 = u4:NextNumber(5, 7);
                local v24 = l__Angles__2(v20, v22, (math.rad(v23)));
                local v25;
                if u8 then
                    v25 = u8.Size.Y;
                    p12 = u8:GetPivot();
                else
                    v25 = 0;
                end;
                local v26 = 1 + u4:NextNumber(-0.5, 0.5);
                v15.Size = Vector3.new(v18, v26, v18);
                v15.CFrame = p12 * CFrame.new(0, v25 / 3, 0) * v24 * CFrame.new(0, v26 / 3, 0);
                v15.Name = v14 + 2;
                v15.Parent = u1;
                v15.Color = Color3.fromRGB(255, 247, 0);
                if v14 == 1 or v14 == p13 then
                    v15.Color = Color3.fromRGB(184, 139, 84);
                    v15.Material = Enum.Material.Glacier;
                    v15.MaterialVariant = "2022 Weld";
                else
                    local _ = (v14 - 2) / math.max(p13 - 1 - 2, 1);
                    v15.Color = Color3.fromRGB(255, 255, 0);
                end;
                u8 = v15;
            end;
            u8 = nil;
        end)(v10 * l__Angles__1(3.141592653589793, math.rad(v11), 0), v9);
        local v27 = p3 * 0.5 + 0.5;
        u1:ScaleTo(v27 + v27 ^ 3 * 0.00001);
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u28) --[[ Name: BeginFruitGrowth, Line 113 ]]
        local l__PrimaryPart__3 = u28.PrimaryPart;
        local u29 = {};
        for _, v30 in u28:GetDescendants() do
            local v31 = tonumber(v30.Name);
            if v30:IsA("BasePart") and v31 then
                local v32 = not v30:GetAttribute("DontShow");
                local v33 = {
                    part = v30,
                    maxSize = v30.Size,
                    centerOffset = l__PrimaryPart__3.CFrame:ToObjectSpace(v30.CFrame),
                    partAge = v31
                };
                table.insert(u29, v33);
                v30.CanCollide = false;
                if v32 then
                    v30.Transparency = 1;
                end;
            end;
        end;
        local function v40() --[[ Line: 134 ]]
            -- upvalues: u28 (copy), u29 (copy), l__PrimaryPart__3 (copy)
            local v34 = u28:GetAttribute("Age") or 0;
            local v35 = u28:GetAttribute("MaxAge") or 1;
            local v36 = v34 / v35;
            for _, v37 in u29 do
                if not v37.part:GetAttribute("DontShow") then
                    local v38 = math.clamp((v36 - v37.partAge / v35) * v35, 0, 1);
                    if v38 > 0 then
                        local v39 = v37.maxSize * v38;
                        v37.part.Size = v39;
                        v37.part.CFrame = l__PrimaryPart__3.CFrame * v37.centerOffset * CFrame.new(0, -((v37.maxSize.Y - v39.Y) / 2), 0);
                        v37.part.Transparency = v37.part:GetAttribute("OG_Transparency") or 0;
                        v37.part.CanCollide = true;
                    else
                        v37.part.Transparency = 1;
                        v37.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u28:GetAttributeChangedSignal("Age"):Connect(v40);
        v40();
    end,
    OnFullyGrown = function(p41) --[[ Name: OnFullyGrown, Line 166 ]]
        local v42 = p41:GetAttribute("CorePartName");
        if v42 then
            local v43 = p41:FindFirstChild(v42);
            local v44 = v43 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v44 then
                local v45 = v44:Clone();
                v45.Name = "ProximityPrompt";
                v45.Parent = v43;
            end;
        end;
        p41:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};