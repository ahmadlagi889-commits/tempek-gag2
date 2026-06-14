-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.3,
        BaseWeight = 1,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 8 ]]
        Random.new(p2);
        local v4 = p3 * 0.5 + 0.5;
        local v5 = v4 + v4 ^ 3 * 1e-6;
        local v6 = script.Strawberry:Clone();
        local l__CFrame__1 = v6.PrimaryPart.CFrame;
        local l__CFrame__2 = p1.PrimaryPart.CFrame;
        for _, v7 in v6:GetChildren() do
            if v7:IsA("BasePart") then
                v7.CFrame = l__CFrame__2 * l__CFrame__1:ToObjectSpace(v7.CFrame);
            end;
        end;
        local l__PrimaryPart__3 = p1.PrimaryPart;
        v6.PrimaryPart:Destroy();
        for _, v8 in pairs(v6:GetChildren()) do
            if v8:IsA("BasePart") then
                if v8.BrickColor == BrickColor.new("Really red") then
                    v8:AddTag("Red");
                end;
                v8.Parent = p1;
            end;
        end;
        if v5 ~= 1 then
            local l__CFrame__4 = l__PrimaryPart__3.CFrame;
            for _, v9 in p1:GetDescendants() do
                if v9:IsA("BasePart") then
                    v9.Size = v9.Size * v5;
                    local v10 = l__CFrame__4:ToObjectSpace(v9.CFrame);
                    v9.CFrame = l__CFrame__4 * CFrame.new(v10.Position * v5) * v10.Rotation;
                end;
            end;
        end;
        p1:SetAttribute("CorePartName", "Strawberry");
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u11) --[[ Name: BeginFruitGrowth, Line 59 ]]
        local l__PrimaryPart__5 = u11.PrimaryPart;
        local u12 = {};
        for _, v13 in u11:GetDescendants() do
            local v14 = tonumber(v13.Name);
            if v13:IsA("BasePart") and v14 then
                local v15 = not v13:GetAttribute("DontShow");
                local v16 = {};
                for _, v17 in v13:GetDescendants() do
                    if v17:IsA("Decal") then
                        table.insert(v16, v17);
                        v17.Transparency = 1;
                    elseif v17:IsA("ImageLabel") then
                        table.insert(v16, v17);
                        v17.ImageTransparency = 1;
                    end;
                end;
                local v18 = {
                    part = v13,
                    maxSize = v13.Size,
                    centerOffset = l__PrimaryPart__5.CFrame:ToObjectSpace(v13.CFrame),
                    partAge = v14,
                    decorations = v16
                };
                table.insert(u12, v18);
                v13.CanCollide = false;
                if v15 then
                    v13.Transparency = 1;
                end;
            end;
        end;
        local function v28() --[[ Line: 92 ]]
            -- upvalues: u11 (copy), u12 (copy), l__PrimaryPart__5 (copy)
            local v19 = u11:GetAttribute("Age") or 0;
            local v20 = u11:GetAttribute("MaxAge") or 1;
            local v21 = v19 / v20;
            for _, v22 in u12 do
                if not v22.part:GetAttribute("DontShow") then
                    local v23 = math.clamp((v21 - v22.partAge / v20) * v20, 0, 1);
                    if v23 > 0 then
                        local v24 = v22.maxSize * v23;
                        v22.part.Size = v24;
                        local v25 = v22.centerOffset * CFrame.new(0, -((v22.maxSize.Y - v24.Y) / 2), 0);
                        v22.part.CFrame = l__PrimaryPart__5.CFrame * v25;
                        v22.part.Transparency = v22.part:GetAttribute("OG_Transparency") or 0;
                        v22.part.CanCollide = true;
                    else
                        v22.part.Transparency = 1;
                        v22.part.CanCollide = false;
                    end;
                    local v26 = v23 >= 1 and 0 or 1;
                    for _, v27 in v22.decorations do
                        if v27:IsA("Decal") then
                            v27.Transparency = v26;
                        else
                            v27.ImageTransparency = v26;
                        end;
                    end;
                end;
            end;
        end;
        u11:GetAttributeChangedSignal("Age"):Connect(v28);
        v28();
    end,
    OnFullyGrown = function(p29) --[[ Name: OnFullyGrown, Line 134 ]]
        local v30 = p29:GetAttribute("CorePartName");
        if v30 then
            local v31 = p29:FindFirstChild(v30);
            local v32 = v31 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v32 then
                local v33 = v32:Clone();
                v33.Name = "ProximityPrompt";
                v33.Parent = v31;
            end;
        end;
        p29:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Apple",
        Harvestable = true
    }
};