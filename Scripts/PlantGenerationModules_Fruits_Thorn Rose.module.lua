-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.5,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, _, p2) --[[ Name: InitFruit, Line 9 ]]
        p1:ScaleTo(p2);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u3) --[[ Name: BeginFruitGrowth, Line 16 ]]
        local l__PrimaryPart__1 = u3.PrimaryPart;
        local u4 = {};
        for _, v5 in u3:GetDescendants() do
            local v6 = tonumber(v5.Name);
            if v5:IsA("BasePart") and v6 then
                local v7 = not v5:GetAttribute("DontShow");
                local v8 = {
                    part = v5,
                    maxSize = v5.Size,
                    centerOffset = l__PrimaryPart__1.CFrame:ToObjectSpace(v5.CFrame),
                    partAge = v6
                };
                table.insert(u4, v8);
                v5.CanCollide = false;
                if v7 then
                    v5.Transparency = 1;
                end;
            end;
        end;
        local function v15() --[[ Line: 37 ]]
            -- upvalues: u3 (copy), u4 (copy), l__PrimaryPart__1 (copy)
            local v9 = u3:GetAttribute("Age") or 0;
            local v10 = u3:GetAttribute("MaxAge") or 1;
            local v11 = v9 / v10;
            for _, v12 in u4 do
                if not v12.part:GetAttribute("DontShow") then
                    local v13 = math.clamp((v11 - v12.partAge / v10) * v10, 0, 1);
                    if v13 > 0 then
                        local v14 = v12.maxSize * v13;
                        v12.part.Size = v14;
                        v12.part.CFrame = l__PrimaryPart__1.CFrame * v12.centerOffset * CFrame.new(0, -((v12.maxSize.Y - v14.Y) / 2), 0);
                        v12.part.Transparency = v12.part:GetAttribute("OG_Transparency") or 0;
                        v12.part.CanCollide = true;
                    else
                        v12.part.Transparency = 1;
                        v12.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u3:GetAttributeChangedSignal("Age"):Connect(v15);
        v15();
    end,
    OnFullyGrown = function(p16) --[[ Name: OnFullyGrown, Line 69 ]]
        local v17 = p16:GetAttribute("CorePartName");
        if v17 then
            local v18 = p16:FindFirstChild(v17);
            local v19 = v18 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v19 then
                local v20 = v19:Clone();
                v20.Name = "ProximityPrompt";
                v20.Parent = v18;
            end;
        end;
        p16:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Thorn Rose",
        Harvestable = true
    }
};