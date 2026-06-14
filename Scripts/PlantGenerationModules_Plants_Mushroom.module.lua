-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25,
        BaseWeight = 5
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        local v4 = Random.new(p2);
        local l__Base__1 = p1.Base;
        local v5 = 1;
        local l__Stud_Part__2 = script.Stud_Part;
        local _ = script.MushroomTop;
        local v6 = 0.5 + (p3 or 1) * 0.5;
        local v7 = 2 + v6 * 0.5;
        local v8 = 7 + v6;
        local v9 = 2 + v6;
        local v10 = 1;
        if v4:NextInteger(1, 5000) == 1 then
            v10 = v10 * 2;
            while v4:NextInteger(1, 3) == 1 do
                v10 = v10 * 2;
            end;
        end;
        local v11 = v9 * v10;
        local v12 = l__Base__1.CFrame * CFrame.new(0, -l__Base__1.Size.Y / 2, 0);
        local l__Size__3 = l__Base__1.Size;
        local v13 = false;
        local v14 = nil;
        for _ = 1, 2 do
            for _ = 1, v7 do
                v14 = l__Stud_Part__2:Clone();
                v14.Size = Vector3.new(v8 * 0.75, v11 * 0.75, v8 * 0.75);
                v14.Color = Color3.new(1, 1, 1);
                v14.Name = tostring(v5);
                v14.CFrame = v12 * CFrame.new(0, v14.Size.Y / 2 + l__Size__3.Y / 2, 0);
                if v13 == false then
                    v8 = v8 * 0.75;
                    v11 = v11 * 1.25;
                else
                    v8 = v8 * 1.25;
                    v11 = v11 * 0.75;
                end;
                v14.Parent = p1;
                v12 = v14.CFrame;
                l__Size__3 = v14.Size;
                v5 = v5 + 1;
            end;
            v13 = not v13;
        end;
        local v15 = Color3.fromHSV(v4:NextInteger(0, 20) * 0.05, 1, 0.9);
        local v16 = script.MushroomTop:Clone();
        v16:ScaleTo(v6 * 1.5 ^ math.log(v10, 2));
        v16:PivotTo(v14.CFrame * CFrame.new(0, v14.Size.Y / 2 + v16.PrimaryPart.Size.Y / 2 + 0.01, 0) * CFrame.Angles(0, 0, 3.141592653589793));
        for _, v17 in pairs(v16:GetDescendants()) do
            if v17:IsA("BasePart") then
                v17.AssemblyLinearVelocity = Vector3.new(0, 170 * v6, 0);
            end;
        end;
        local v18 = {};
        for _, v19 in pairs(v16:GetChildren()) do
            if v19 ~= v16.PRIMARY and v19:IsA("BasePart") then
                v19:SetAttribute("IsMushroomCap", true);
                table.insert(v18, v19);
            end;
        end;
        while #v18 > 0 do
            v5 = v5 + 1;
            local v20 = (-1 / 0);
            local v21 = nil;
            for _, v22 in pairs(v18) do
                if v20 < v22.Position.Y then
                    v20 = v22.Position.Y;
                    v21 = v22;
                end;
            end;
            if v21 then
                v21.Name = tostring(v5);
                v21.Parent = p1;
                local v23 = table.find(v18, v21);
                if v23 then
                    table.remove(v18, v23);
                end;
            end;
        end;
        for _, v24 in p1:GetChildren() do
            if v24:IsA("BasePart") and v24:GetAttribute("IsMushroomCap") then
                v24.CanCollide = false;
                v24:AddTag("MushroomCap");
            end;
        end;
        v16:Destroy();
        if v4:NextInteger(1, 100) == 1 then
            v15 = Color3.new(0, 0, 0);
        end;
        if v4:NextInteger(1, 100) == 1 then
            for _, v25 in pairs(p1:GetChildren()) do
                if v25:IsA("BasePart") and v25.BrickColor == BrickColor.new("Bright red") then
                    v25.Color = v15;
                    v25.Material = Enum.Material.Neon;
                end;
            end;
        elseif v4:NextInteger(1, 10000) == 1 then
            for _, v26 in pairs(p1:GetChildren()) do
                if v26:IsA("BasePart") and v26.BrickColor == BrickColor.new("Bright red") then
                    v26.Color = v15;
                    v26.Material = Enum.Material.ForceField;
                end;
            end;
        else
            for _, v27 in pairs(p1:GetChildren()) do
                if v27:IsA("BasePart") and v27.BrickColor == BrickColor.new("Bright red") then
                    v27.Color = v15;
                end;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u28) --[[ Name: BeginPlantGrowth, Line 151 ]]
        local l__PrimaryPart__4 = u28.PrimaryPart;
        local u29 = {};
        for _, v30 in u28:GetDescendants() do
            local v31 = tonumber(v30.Name);
            if v30:IsA("BasePart") and v31 then
                local v32 = {
                    v30,
                    v30.Size,
                    l__PrimaryPart__4.CFrame:ToObjectSpace(v30.CFrame),
                    v31
                };
                table.insert(u29, v32);
                v30.CanCollide = false;
                v30.Transparency = 1;
            end;
        end;
        local function v42() --[[ Line: 167 ]]
            -- upvalues: u28 (copy), u29 (copy), l__PrimaryPart__4 (copy)
            local v33 = u28:GetAttribute("Age") or 0;
            local v34 = u28:GetAttribute("MaxAge") or 1;
            local v35 = v33 / v34;
            for _, v36 in u29 do
                local v37 = v36[1];
                local v38 = v36[2];
                local v39 = v36[3];
                local v40 = math.min((v35 - v36[4] / v34) * v34, 1);
                if v40 > 0 then
                    v37.Size = Vector3.new(v38.X, v38.Y * v40, v38.Z);
                    v37.CFrame = l__PrimaryPart__4.CFrame * v39 * CFrame.new(0, (v37.Size.Y - v38.Y) / 2, 0);
                    v37.Transparency = v37:GetAttribute("OG_Transparency") or 0;
                    if v37:GetAttribute("NoCanCollide") == nil then
                        v37.CanCollide = true;
                        v37.CanTouch = true;
                    end;
                    if v37:FindFirstChild("Decal") and v40 >= 1 then
                        for _, v41 in v37:GetChildren() do
                            if v41:IsA("Decal") then
                                v41.Transparency = 0.4;
                            end;
                        end;
                    end;
                else
                    v37.Transparency = 1;
                    v37.CanCollide = false;
                    v37.CanTouch = false;
                end;
            end;
        end;
        u28:GetAttributeChangedSignal("Age"):Connect(v42);
        v42();
    end
};