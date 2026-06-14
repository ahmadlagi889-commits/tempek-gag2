-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25,
        BaseWeight = 5
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 8 ]]
        local v4 = Random.new(p2);
        local l__Base__1 = p1.Base;
        local l__Stud_Part__2 = script.Stud_Part;
        local v5 = p3 or 1;
        local v6 = l__Stud_Part__2:Clone();
        v6.Color = Color3.new(0, 0.666667, 0);
        local v7 = v4:NextInteger(2, 3);
        v6.Size = Vector3.new(1, v7, 1) * v5;
        v6.CFrame = l__Base__1.CFrame * CFrame.new(0, v6.Size.Y / 2, 0);
        v6.Name = "1";
        v6.Parent = p1;
        local v8 = l__Stud_Part__2:Clone();
        v8.Color = Color3.new(1, 1, 0);
        v8.Size = Vector3.new(1, 1, 1) * v5;
        v8.CFrame = v6.CFrame * CFrame.new(0, v6.Size.Y / 2 + v8.Size.Y / 2, 0);
        v8.Name = "2";
        v8.Parent = p1;
        local v9 = Random.new(v4:NextInteger(1, 100000000));
        local v10 = Color3.fromHSV(v9:NextInteger(1, 100) * 0.01, 1, 1);
        if v9:NextInteger(1, 1000) == 1 then
            v10 = Color3.fromHSV(0, 0, 0);
        end;
        if v9:NextInteger(1, 1000) == 1 then
            v10 = Color3.fromHSV(0, 0, 1);
        end;
        local v11 = {};
        local v12 = l__Stud_Part__2:Clone();
        v12.Color = v10;
        v12.Size = Vector3.new(1, 1, 1) * v5;
        v12.CFrame = v8.CFrame * CFrame.new(v8.Size.X / 2 + v12.Size.X / 2, 0, 0);
        v12.CFrame = v12.CFrame * CFrame.Angles(0, 0, -1.5707963267948966);
        v12.Name = "3";
        v12.Parent = p1;
        table.insert(v11, v12);
        local v13 = l__Stud_Part__2:Clone();
        v13.Color = v10;
        v13.Size = Vector3.new(1, 1, 1) * v5;
        v13.CFrame = v8.CFrame * CFrame.new(-(v8.Size.X / 2 + v13.Size.X / 2), 0, 0);
        v13.CFrame = v13.CFrame * CFrame.Angles(0, 0, 1.5707963267948966);
        v13.Name = "3";
        v13.Parent = p1;
        table.insert(v11, v13);
        local v14 = l__Stud_Part__2:Clone();
        v14.Color = v10;
        v14.Size = Vector3.new(1, 1, 1) * v5;
        v14.CFrame = v8.CFrame * CFrame.new(0, 0, -(v8.Size.Z / 2 + v14.Size.Z / 2));
        v14.CFrame = v14.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
        v14.Name = "3";
        v14.Parent = p1;
        table.insert(v11, v14);
        local v15 = l__Stud_Part__2:Clone();
        v15.Color = v10;
        v15.Size = Vector3.new(1, 1, 1) * v5;
        v15.CFrame = v8.CFrame * CFrame.new(0, 0, v8.Size.Z / 2 + v15.Size.Z / 2);
        v15.CFrame = v15.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
        v15.Name = "3";
        v15.Parent = p1;
        table.insert(v11, v15);
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u16) --[[ Name: BeginPlantGrowth, Line 79 ]]
        local l__PrimaryPart__3 = u16.PrimaryPart;
        local u17 = {};
        for _, v18 in u16:GetDescendants() do
            local v19 = tonumber(v18.Name);
            if v18:IsA("BasePart") and v19 then
                local v20 = {
                    v18,
                    v18.Size,
                    l__PrimaryPart__3.CFrame:ToObjectSpace(v18.CFrame),
                    v19
                };
                table.insert(u17, v20);
                v18.CanCollide = false;
                v18.Transparency = 1;
            end;
        end;
        local function v30() --[[ Line: 97 ]]
            -- upvalues: u16 (copy), u17 (copy), l__PrimaryPart__3 (copy)
            local v21 = u16:GetAttribute("Age") or 0;
            local v22 = u16:GetAttribute("MaxAge") or 1;
            local v23 = v21 / v22;
            for _, v24 in u17 do
                local v25 = v24[1];
                local v26 = v24[2];
                local v27 = v24[3];
                local v28 = math.min((v23 - v24[4] / v22) * v22, 1);
                if v28 > 0 then
                    v25.Size = Vector3.new(v26.X, v26.Y * v28, v26.Z);
                    v25.CFrame = l__PrimaryPart__3.CFrame * v27 * CFrame.new(0, (v25.Size.Y - v26.Y) / 2, 0);
                    v25.Transparency = v25:GetAttribute("OG_Transparency") or 0;
                    v25.CanCollide = true;
                    if v25:FindFirstChild("Decal") and v28 >= 1 then
                        for _, v29 in v25:GetChildren() do
                            if v29:IsA("Decal") then
                                v29.Transparency = 0.4;
                            end;
                        end;
                    end;
                else
                    v25.Transparency = 1;
                    v25.CanCollide = false;
                end;
            end;
        end;
        u16:GetAttributeChangedSignal("Age"):Connect(v30);
        v30();
    end
};