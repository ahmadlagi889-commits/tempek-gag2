-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        local v4 = p3 or 1;
        local v5 = Random.new(p2);
        local v6 = v5:NextInteger(5, 7) * v4;
        local l__PrimaryPart__1 = p1.PrimaryPart;
        local v7 = 2 * v4;
        local v8 = 5;
        local v9 = 1;
        while v8 >= 1 do
            task.wait();
            v8 = v8 - 1;
            local v10 = Instance.new("Part");
            v10.Anchored = true;
            v10.CanCollide = false;
            v10.Size = Vector3.new(v7, v6, v7);
            v9 = v9 + 1;
            v10.Name = tostring(v9);
            v10.CFrame = l__PrimaryPart__1.CFrame * CFrame.new(0, l__PrimaryPart__1.Size.Y / 2 + v10.Size.Y / 2, 0);
            v10.Parent = p1;
            local l__FruitSpawnLocations__2 = p1.FruitSpawnLocations;
            local v11 = Instance.new("Part");
            v11.Parent = l__FruitSpawnLocations__2;
            v11.Anchored = true;
            v11.CanCollide = false;
            v11.Size = Vector3.new(0.5, 0.5, 0.5);
            v11.CFrame = v10.CFrame * CFrame.new(-(v10.Size.X / 2 + v11.Size.X / 2), v5:NextInteger(-v10.Size.Y / 2, v10.Size.Y / 2), 0);
            v7 = v7 * 0.8;
            l__PrimaryPart__1 = v10;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u12) --[[ Name: BeginPlantGrowth, Line 39 ]]
        local l__PrimaryPart__3 = u12.PrimaryPart;
        local u13 = {};
        for _, v14 in u12:GetDescendants() do
            local v15 = tonumber(v14.Name);
            if v14:IsA("BasePart") and v15 then
                local v16 = {
                    v14,
                    v14.Size,
                    l__PrimaryPart__3.CFrame:ToObjectSpace(v14.CFrame),
                    v15
                };
                table.insert(u13, v16);
                v14.CanCollide = false;
                v14.Transparency = 1;
            end;
        end;
        local function v23() --[[ Line: 57 ]]
            -- upvalues: u12 (copy), u13 (copy), l__PrimaryPart__3 (copy)
            local v17 = u12:GetAttribute("Age") or 0;
            for _, v18 in u13 do
                local v19 = v18[1];
                local v20 = v18[2];
                local v21 = v18[3];
                local v22 = math.min(v17 - v18[4], 1);
                if v22 > 0 then
                    v19.Size = Vector3.new(v20.X, v20.Y * v22, v20.Z);
                    v19.CFrame = l__PrimaryPart__3.CFrame * v21 * CFrame.new(0, (v19.Size.Y - v20.Y) / 2, 0);
                    v19.Transparency = v19:GetAttribute("OG_Transparency") or 0;
                    v19.CanCollide = true;
                else
                    v19.Transparency = 1;
                    v19.CanCollide = false;
                end;
            end;
        end;
        u12:GetAttributeChangedSignal("Age"):Connect(v23);
        v23();
    end,
    Extras = {}
};