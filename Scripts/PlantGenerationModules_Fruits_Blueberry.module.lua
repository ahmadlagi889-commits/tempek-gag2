-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.2308,
        BaseWeight = 1.15,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 8 ]]
        Random.new(p2);
        local v4 = p3 * 0.5 + 0.5;
        local v5 = v4 + v4 ^ 3 * 0.00001;
        local v6 = script.Blueberry:Clone();
        v6:PivotTo(p1.PrimaryPart.CFrame);
        v6:ScaleTo(v5);
        v6.PrimaryPart = nil;
        for _, v7 in pairs(v6:GetChildren()) do
            if v7:IsA("BasePart") then
                v7:AddTag("Blue");
                v7.Parent = p1;
            end;
        end;
        p1:SetAttribute("CorePartName", "Blueberry");
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u8) --[[ Name: BeginFruitGrowth, Line 30 ]]
        local l__PrimaryPart__1 = u8.PrimaryPart;
        local u9 = {};
        for _, v10 in u8:GetDescendants() do
            local v11 = tonumber(v10.Name);
            if v10:IsA("BasePart") and v11 then
                local v12 = not v10:GetAttribute("DontShow");
                local v13 = {
                    part = v10,
                    maxSize = v10.Size,
                    centerOffset = l__PrimaryPart__1.CFrame:ToObjectSpace(v10.CFrame),
                    partAge = v11
                };
                table.insert(u9, v13);
                v10.CanCollide = false;
                if v12 then
                    v10.Transparency = 1;
                end;
            end;
        end;
        local function v21() --[[ Line: 53 ]]
            -- upvalues: u8 (copy), u9 (copy), l__PrimaryPart__1 (copy)
            local v14 = u8:GetAttribute("Age") or 0;
            local v15 = u8:GetAttribute("MaxAge") or 1;
            local v16 = v14 / v15;
            for _, v17 in u9 do
                if not v17.part:GetAttribute("DontShow") then
                    local v18 = math.clamp((v16 - v17.partAge / v15) * v15, 0, 1);
                    if v18 > 0 then
                        local v19 = v17.maxSize * v18;
                        v17.part.Size = v19;
                        local v20 = v17.centerOffset * CFrame.new(0, -((v17.maxSize.Y - v19.Y) / 2), 0);
                        v17.part.CFrame = l__PrimaryPart__1.CFrame * v20;
                        v17.part.Transparency = v17.part:GetAttribute("OG_Transparency") or 0;
                        v17.part.CanCollide = true;
                    else
                        v17.part.Transparency = 1;
                        v17.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u8:GetAttributeChangedSignal("Age"):Connect(v21);
        v21();
    end,
    OnFullyGrown = function(p22) --[[ Name: OnFullyGrown, Line 93 ]]
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
        FruitType = "Apple",
        Harvestable = true
    }
};