-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.06,
        BaseWeight = 0.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 8 ]]
        local v4 = Random.new(p2);
        local v5 = p1:FindFirstChild("1");
        v5.Name = "2";
        v5.CFrame = v5.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
        v5.CFrame = v5.CFrame * CFrame.Angles(0, 0, 1.5707963267948966);
        local v6 = 0.16 + p3 ^ 3 * 1e-6;
        local v7 = (2 + p3 * 0.25) * v6;
        local v8 = (3 + p3 * 5) * v6;
        local v9 = (2 + p3 * 0.25) * v6;
        local v10 = 0.5 * v6;
        local v11 = 0.25 * v6;
        v5.CFrame = v5.CFrame * CFrame.new(0, 0, -(v7 * 0.5));
        v5.Size = Vector3.new(v9, v10, v8);
        local v12 = v5:Clone();
        v12.Size = Vector3.new(v11, v7, v8);
        v12.CFrame = v5.CFrame * CFrame.new(v12.Size.X / 2 + v5.Size.X / 2, (v12.Size.Y - v5.Size.Y) / 2, 0);
        local v13 = 0 + 1;
        v12.Name = "3";
        v12.Parent = p1;
        local v14 = v5:Clone();
        v14.Size = Vector3.new(v11, v7, v8);
        v14.CFrame = v5.CFrame * CFrame.new(-(v14.Size.X / 2 + v5.Size.X / 2), (v14.Size.Y - v5.Size.Y) / 2, 0);
        local v15 = v13 + 1;
        v14.Name = "4";
        v14.Parent = p1;
        local v16 = v5:Clone();
        v16.Size = Vector3.new(v9, v7, v11);
        v16.CFrame = v5.CFrame * CFrame.new(0, (v16.Size.Y - v5.Size.Y) / 2, -(v16.Size.Z / 2 + v5.Size.Z / 2));
        local v17 = v15 + 1;
        v16.Name = "5";
        v16.Parent = p1;
        local v18 = v5:Clone();
        v18.Size = Vector3.new(v9, v7, v11);
        v18.CFrame = v5.CFrame * CFrame.new(0, (v18.Size.Y - v5.Size.Y) / 2, v18.Size.Z / 2 + v5.Size.Z / 2);
        local v19 = v17 + 1;
        v18.Name = "6";
        v18.Parent = p1;
        local v20 = v4:NextInteger(27, 34) * 0.01;
        local l__Size__1 = v5.Size;
        local v21 = math.round(l__Size__1.Z / l__Size__1.X);
        local v22 = math.max(1, v21);
        local v23 = l__Size__1.Z / v22;
        local v24 = l__Size__1.Z / 2;
        local v25 = v23;
        local v26 = 0;
        for v27 = 1, v22 do
            v26 = v26 + 1;
            local v28 = Instance.new("Part");
            v28.Shape = Enum.PartType.Ball;
            v28.Size = Vector3.new(v23, v23, v23);
            v28.Anchored = true;
            v28.CanCollide = false;
            v28.Material = v5.Material;
            v28.Color = v5.Color;
            local v29 = v26 * 0.1 % 2;
            local v30 = v29 <= 1 and v29 and v29 or 2 - v29;
            v28.Color = Color3.fromHSV(v20 - 0.025 + v30 * 0.025, 0.5 + v30 * 0.175, 0.5 + v30 * 0.25);
            v28.CFrame = v5.CFrame * CFrame.new(0, v23 / 2 - v5.Size.Y / 4, -v24 + v25 / 2 + (v27 - 1) * v25);
            v19 = v19 + 1;
            v28.Name = tostring(v19);
            v28.Parent = p1;
        end;
        for _, v31 in p1:GetDescendants() do
            if v31:IsA("BasePart") then
                v31.Anchored = true;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u32) --[[ Name: BeginFruitGrowth, Line 121 ]]
        local l__PrimaryPart__2 = u32.PrimaryPart;
        local u33 = {};
        for _, v34 in u32:GetDescendants() do
            local v35 = tonumber(v34.Name);
            if (v34:IsA("BasePart") or v34:IsA("UnionOperation")) and v35 then
                local v36 = not v34:GetAttribute("DontShow");
                local v37 = {
                    part = v34,
                    maxSize = v34.Size,
                    centerOffset = l__PrimaryPart__2.CFrame:ToObjectSpace(v34.CFrame),
                    partAge = v35
                };
                table.insert(u33, v37);
                v34.CanCollide = false;
                if v36 then
                    v34.Transparency = 1;
                end;
            end;
        end;
        local u38 = 0;
        for _, v39 in u33 do
            if not v39.part:GetAttribute("DontShow") then
                local l__Rotation__3 = v39.centerOffset.Rotation;
                local v40 = l__Rotation__3.XVector:Dot(Vector3.new(0, 0, 1));
                local v41 = math.abs(v40) * v39.maxSize.X / 2;
                local v42 = l__Rotation__3.YVector:Dot(Vector3.new(0, 0, 1));
                local v43 = v41 + math.abs(v42) * v39.maxSize.Y / 2;
                local v44 = l__Rotation__3.ZVector:Dot(Vector3.new(0, 0, 1));
                local v45 = v43 + math.abs(v44) * v39.maxSize.Z / 2;
                local v46 = v39.centerOffset.Position:Dot(Vector3.new(0, 0, 1)) + v45;
                u38 = math.max(u38, v46);
            end;
        end;
        local u47 = Vector3.new(0, 0, 0);
        local function v54() --[[ Line: 178 ]]
            -- upvalues: u32 (copy), u38 (ref), l__PrimaryPart__2 (copy), u47 (ref), u33 (copy)
            local v48 = (u32:GetAttribute("Age") or 0) / (u32:GetAttribute("MaxAge") or 1);
            local v49 = math.clamp(v48, 0, 1);
            local v50 = Vector3.new(0, 0, 1) * (u38 * (1 - v49));
            local v51 = l__PrimaryPart__2.CFrame * CFrame.new(-u47);
            local v52 = false;
            for _, v53 in u33 do
                if not v53.part:GetAttribute("DontShow") then
                    if v49 > 0 then
                        v53.part.Size = v53.maxSize * v49;
                        v53.part.CFrame = v51 * CFrame.new(v53.centerOffset.Position * v49 + v50) * v53.centerOffset.Rotation;
                        v53.part.Transparency = v53.part:GetAttribute("OG_Transparency") or 0;
                        v53.part.CanCollide = true;
                        v52 = true;
                    else
                        v53.part.Transparency = 1;
                        v53.part.CanCollide = false;
                    end;
                end;
            end;
            if v52 then
                u47 = v50;
            end;
        end;
        u32:GetAttributeChangedSignal("Age"):Connect(v54);
        v54();
    end,
    Extras = {
        FruitType = "Beanstalk",
        Harvestable = true
    }
};