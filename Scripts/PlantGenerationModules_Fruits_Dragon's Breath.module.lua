-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0078,
        BaseWeight = 7.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 13 ]]
        Random.new(p2);
        local _ = p1.PrimaryPart;
        local v4 = p3 * 0.2 + 0.8;
        p1:ScaleTo(v4 + v4 ^ 4 * 0.01);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u5) --[[ Name: BeginFruitGrowth, Line 28 ]]
        local l__PrimaryPart__1 = u5.PrimaryPart;
        local u6 = {};
        for _, v7 in u5:GetDescendants() do
            local v8 = tonumber(v7.Name);
            if v7:IsA("BasePart") and v8 then
                local v9 = not v7:GetAttribute("DontShow");
                local v10 = {};
                for _, v11 in v7:GetChildren() do
                    if v11:IsA("Decal") or v11:IsA("Texture") then
                        table.insert(v10, {
                            decal = v11,
                            originalTransparency = v11.Transparency
                        });
                        if v9 then
                            v11.Transparency = 1;
                        end;
                    end;
                end;
                local v12 = {
                    part = v7,
                    maxSize = v7.Size,
                    centerOffset = l__PrimaryPart__1.CFrame:ToObjectSpace(v7.CFrame),
                    partAge = v8,
                    decals = v10
                };
                table.insert(u6, v12);
                v7.CanCollide = false;
                if v9 then
                    v7.Transparency = 1;
                end;
            end;
        end;
        local function v21() --[[ Line: 63 ]]
            -- upvalues: u5 (copy), u6 (copy), l__PrimaryPart__1 (copy)
            local v13 = u5:GetAttribute("Age") or 0;
            local v14 = u5:GetAttribute("MaxAge") or 1;
            local v15 = v13 / v14;
            for _, v16 in u6 do
                if not v16.part:GetAttribute("DontShow") then
                    local v17 = math.clamp((v15 - v16.partAge / v14) * v14, 0, 1);
                    if v17 > 0 then
                        local v18 = v16.maxSize * v17;
                        v16.part.Size = v18;
                        v16.part.CFrame = l__PrimaryPart__1.CFrame * v16.centerOffset * CFrame.new(0, -((v16.maxSize.Y - v18.Y) / 2), 0);
                        v16.part.Transparency = v16.part:GetAttribute("OG_Transparency") or 0;
                        v16.part.CanCollide = true;
                        for _, v19 in v16.decals do
                            v19.decal.Transparency = v19.originalTransparency + (1 - v19.originalTransparency) * (1 - v17);
                        end;
                    else
                        v16.part.Transparency = 1;
                        v16.part.CanCollide = false;
                        for _, v20 in v16.decals do
                            v20.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u5:GetAttributeChangedSignal("Age"):Connect(v21);
        v21();
    end,
    OnFullyGrown = function(p22) --[[ Name: OnFullyGrown, Line 98 ]]
        local v23 = p22:GetAttribute("CorePartName");
        if v23 then
            local v24 = p22:FindFirstChild(v23);
            local v25 = v24 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v25 then
                local v26 = v25:Clone();
                v26.Name = "ProximityPrompt";
                v26.Parent = v24;
            end;
        end;
        p22:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};