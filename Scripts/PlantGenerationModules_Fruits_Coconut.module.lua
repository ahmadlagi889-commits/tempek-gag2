-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.0333,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        Random.new(p2);
        local v4 = p1.PrimaryPart or p1.Part;
        local l__CFrame__1 = v4.CFrame;
        for _, v5 in ipairs(p1:GetDescendants()) do
            if v5:IsA("BasePart") then
                v5.Size = v5.Size * p3;
                if v5 ~= v4 then
                    local v6 = l__CFrame__1:ToObjectSpace(v5.CFrame);
                    v5.CFrame = l__CFrame__1 * (CFrame.new(v6.Position * p3) * (v6 - v6.Position));
                end;
            elseif v5:IsA("SpecialMesh") or v5:IsA("DataModelMesh") then
                v5.Scale = v5.Scale * p3;
            end;
        end;
        for _, v7 in ipairs(p1:GetDescendants()) do
            if v7:IsA("Attachment") then
                v7.Position = v7.Position * p3;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u8) --[[ Name: BeginFruitGrowth, Line 41 ]]
        local l__PrimaryPart__2 = u8.PrimaryPart;
        local u9 = {};
        for _, v10 in u8:GetDescendants() do
            local v11 = tonumber(v10.Name);
            if v10:IsA("BasePart") and v11 then
                local v12 = not v10:GetAttribute("DontShow");
                local v13 = {
                    part = v10,
                    maxSize = v10.Size,
                    centerOffset = l__PrimaryPart__2.CFrame:ToObjectSpace(v10.CFrame),
                    partAge = v11
                };
                table.insert(u9, v13);
                v10.CanCollide = false;
                if v12 then
                    v10.Transparency = 1;
                end;
            end;
        end;
        local function v19() --[[ Line: 64 ]]
            -- upvalues: u8 (copy), u9 (copy), l__PrimaryPart__2 (copy)
            local v14 = u8:GetAttribute("Age") or 0;
            local v15 = u8:GetAttribute("MaxAge") or 1;
            local v16 = v14 / v15;
            for _, v17 in u9 do
                if not v17.part:GetAttribute("DontShow") then
                    local v18 = math.clamp((v16 - v17.partAge / v15) * v15, 0, 1);
                    if v18 > 0 then
                        v17.part.Size = v17.maxSize * v18;
                        v17.part.CFrame = l__PrimaryPart__2.CFrame * v17.centerOffset;
                        v17.part.Transparency = v17.part:GetAttribute("OG_Transparency") or 0;
                        v17.part.CanCollide = true;
                    else
                        v17.part.Transparency = 1;
                        v17.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u8:GetAttributeChangedSignal("Age"):Connect(v19);
        v19();
    end,
    OnFullyGrown = function(p20) --[[ Name: OnFullyGrown, Line 93 ]]
        local v21 = p20:GetAttribute("CorePartName");
        if v21 then
            local v22 = p20:FindFirstChild(v21);
            local v23 = v22 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v23 then
                local v24 = v23:Clone();
                v24.Name = "ProximityPrompt";
                v24.Parent = v22;
            end;
        end;
        p20:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Apple",
        Harvestable = true
    }
};