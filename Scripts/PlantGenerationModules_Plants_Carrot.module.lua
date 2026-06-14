-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25,
        BaseWeight = 0.8
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 8 ]]
        local v4 = Random.new(p2);
        local v5 = p1.PrimaryPart or p1:FindFirstChild("Base");
        local v6 = p3 or 1;
        for _, v7 in ipairs(p1:GetDescendants()) do
            if v7:IsA("BasePart") and v7 ~= v5 then
                v7.Size = v7.Size * v6;
                local v8 = v5.CFrame:ToObjectSpace(v7.CFrame);
                v7.CFrame = v5.CFrame * CFrame.new(v8.Position * v6) * v8.Rotation;
            end;
        end;
        local v9 = Color3.fromHSV(0.1 + 0.03 * ((v4:NextInteger(1, 10) - 0.1) * 0.1), 1, 1);
        if v4:NextInteger(1, 100) == 1 then
            v9 = Color3.new(1, 1, 0);
        end;
        if v4:NextInteger(1, 1000) == 1 then
            v9 = Color3.new(0, 0.333333, 1);
        end;
        if v4:NextInteger(1, 10000) == 1 then
            v9 = Color3.new(1, 0.333333, 1);
        end;
        if v4:NextInteger(1, 100000) == 1 then
            v9 = Color3.new(1, 1, 1);
        end;
        if v4:NextInteger(1, 1000000) == 1 then
            v9 = Color3.new(0, 0, 0);
        end;
        for _, v10 in pairs(p1:GetChildren()) do
            if v10.Name == "1" or v10.Name == "2" then
                v10.Color = v9;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u11) --[[ Name: BeginPlantGrowth, Line 66 ]]
        local l__PrimaryPart__1 = u11.PrimaryPart;
        local u12 = {};
        for _, v13 in u11:GetDescendants() do
            local v14 = tonumber(v13.Name);
            if v13:IsA("BasePart") and v14 then
                local v15 = {
                    part = v13,
                    maxSize = v13.Size,
                    offset = l__PrimaryPart__1.CFrame:ToObjectSpace(v13.CFrame),
                    partAge = v14
                };
                table.insert(u12, v15);
                v13.CanCollide = false;
                v13.Transparency = 1;
            end;
        end;
        local function v22() --[[ Line: 86 ]]
            -- upvalues: u11 (copy), u12 (copy), l__PrimaryPart__1 (copy)
            local v16 = u11:GetAttribute("Age") or 0;
            local v17 = u11:GetAttribute("MaxAge") or 1;
            local v18 = v16 / v17;
            for _, v19 in u12 do
                local l__part__2 = v19.part;
                local l__maxSize__3 = v19.maxSize;
                local l__offset__4 = v19.offset;
                local v20 = math.min((v18 - v19.partAge / v17) * v17, 1);
                if v20 > 0 then
                    l__part__2.Size = Vector3.new(l__maxSize__3.X, l__maxSize__3.Y * v20, l__maxSize__3.Z);
                    l__part__2.CFrame = l__PrimaryPart__1.CFrame * l__offset__4 * CFrame.new(0, (l__part__2.Size.Y - l__maxSize__3.Y) / 2, 0);
                    l__part__2.Transparency = l__part__2:GetAttribute("OG_Transparency") or 0;
                    l__part__2.CanCollide = true;
                    if l__part__2:FindFirstChild("Decal") and v20 >= 1 then
                        for _, v21 in l__part__2:GetChildren() do
                            if v21:IsA("Decal") then
                                v21.Transparency = 0.4;
                            end;
                        end;
                    end;
                else
                    l__part__2.Transparency = 1;
                    l__part__2.CanCollide = false;
                end;
            end;
        end;
        u11:GetAttributeChangedSignal("Age"):Connect(v22);
        v22();
    end
};