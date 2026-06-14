-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.06,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local v4 = Random.new(p2);
        local v5 = p1:FindFirstChild("1");
        v5.Name = "2";
        local v6 = 2 + p3 * 0.25;
        local v7 = 3 + p3 * 5;
        local v8 = 2 + p3 * 0.25;
        v5.CFrame = v5.CFrame * CFrame.new(0, -v7 / 2, 0);
        v5.Size = Vector3.new(v8, 0.5, v7);
        local v9 = v5:Clone();
        v9.Size = Vector3.new(0.25 * p3, v6, v7);
        v9.CFrame = v5.CFrame * CFrame.new(v9.Size.X / 2 + v5.Size.X / 2, (v9.Size.Y - v5.Size.Y) / 2, 0);
        local v10 = 0 + 1;
        v9.Name = "3";
        v9.Parent = p1;
        local v11 = v5:Clone();
        v11.Size = Vector3.new(0.25 * p3, v6, v7);
        v11.CFrame = v5.CFrame * CFrame.new(-(v11.Size.X / 2 + v5.Size.X / 2), (v11.Size.Y - v5.Size.Y) / 2, 0);
        local v12 = v10 + 1;
        v11.Name = "4";
        v11.Parent = p1;
        local v13 = v5:Clone();
        v13.Size = Vector3.new(v8, v6, 0.25 * p3);
        v13.CFrame = v5.CFrame * CFrame.new(0, (v13.Size.Y - v5.Size.Y) / 2, -(v13.Size.Z / 2 + v5.Size.Z / 2));
        local v14 = v12 + 1;
        v13.Name = "5";
        v13.Parent = p1;
        local v15 = v5:Clone();
        v15.Size = Vector3.new(v8, v6, 0.25 * p3);
        v15.CFrame = v5.CFrame * CFrame.new(0, (v15.Size.Y - v5.Size.Y) / 2, v15.Size.Z / 2 + v5.Size.Z / 2);
        local v16 = v14 + 1;
        v15.Name = "6";
        v15.Parent = p1;
        local v17 = v4:NextInteger(27, 34) * 0.01;
        local l__Size__1 = v5.Size;
        local v18 = math.round(l__Size__1.Z / l__Size__1.X);
        local v19 = math.max(1, v18);
        local v20 = l__Size__1.Z / v19;
        local v21 = l__Size__1.Z / 2;
        local v22 = v20;
        local v23 = 0;
        for v24 = 1, v19 do
            v23 = v23 + 1;
            local v25 = Instance.new("Part");
            v25.Shape = Enum.PartType.Ball;
            v25.Size = Vector3.new(v20, v20, v20);
            v25.Anchored = true;
            v25.CanCollide = false;
            v25.Material = v5.Material;
            v25.Color = v5.Color;
            local v26 = v23 * 0.1 % 2;
            local v27 = v26 <= 1 and v26 and v26 or 2 - v26;
            v25.Color = Color3.fromHSV(v17 - 0.025 + v27 * 0.025, 0.5 + v27 * 0.175, 0.5 + v27 * 0.25);
            v25.CFrame = v5.CFrame * CFrame.new(0, v20 / 2 - v5.Size.Y / 4, -v21 + v22 / 2 + (v24 - 1) * v22);
            v16 = v16 + 1;
            v25.Name = tostring(v16);
            v25.Parent = p1;
        end;
        v5.CFrame = v5.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
        v5.Size = Vector3.new(v5.Size.X, v5.Size.Z, v5.Size.Y);
        v5.CFrame = v5.CFrame * CFrame.Angles(0, 0, 3.141592653589793);
        for _, v28 in p1:GetDescendants() do
            if v28:IsA("BasePart") then
                v28.Anchored = true;
            end;
        end;
        p1:SetAttribute("CorePartName", "Beanstalk");
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u29) --[[ Name: BeginFruitGrowth, Line 121 ]]
        local l__PrimaryPart__2 = u29.PrimaryPart;
        local u30 = {};
        for _, v31 in u29:GetDescendants() do
            local v32 = tonumber(v31.Name);
            if (v31:IsA("BasePart") or v31:IsA("UnionOperation")) and v32 then
                local v33 = not v31:GetAttribute("DontShow");
                local v34 = {
                    part = v31,
                    maxSize = v31.Size,
                    centerOffset = l__PrimaryPart__2.CFrame:ToObjectSpace(v31.CFrame),
                    partAge = v32
                };
                table.insert(u30, v34);
                v31.CanCollide = false;
                if v33 then
                    v31.Transparency = 1;
                end;
            end;
        end;
        local function v38() --[[ Line: 144 ]]
            -- upvalues: u29 (copy), u30 (copy), l__PrimaryPart__2 (copy)
            local v35 = (u29:GetAttribute("Age") or 0) / (u29:GetAttribute("MaxAge") or 1);
            local v36 = math.clamp(v35, 0, 1);
            for _, v37 in u30 do
                if not v37.part:GetAttribute("DontShow") then
                    if v36 > 0 then
                        v37.part.Size = v37.maxSize * v36;
                        v37.part.CFrame = l__PrimaryPart__2.CFrame * CFrame.new(v37.centerOffset.Position * v36) * v37.centerOffset.Rotation;
                        v37.part.Transparency = v37.part:GetAttribute("OG_Transparency") or 0;
                        v37.part.CanCollide = true;
                    else
                        v37.part.Transparency = 1;
                        v37.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u29:GetAttributeChangedSignal("Age"):Connect(v38);
        v38();
    end,
    Extras = {
        FruitType = "Beanstalk",
        Harvestable = true
    }
};