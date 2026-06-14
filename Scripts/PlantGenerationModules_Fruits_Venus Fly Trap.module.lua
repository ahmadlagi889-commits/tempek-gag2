-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.0013,
        BaseWeight = 3,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local v4 = Random.new(p2);
        p1["1"].Color = Color3.fromHSV(v4:NextInteger(70, 90) * 0.01, 0.666667, 1);
        p1:ScaleTo(p3);
        p1:SetAttribute("CorePartName", "Venus Fly Trap");
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u5) --[[ Name: BeginFruitGrowth, Line 20 ]]
        local l__PrimaryPart__1 = u5.PrimaryPart;
        local u6 = {};
        for _, v7 in u5:GetDescendants() do
            local v8 = tonumber(v7.Name);
            if v7:IsA("BasePart") and v8 then
                local v9 = not v7:GetAttribute("DontShow");
                local v10 = {
                    part = v7,
                    maxSize = v7.Size,
                    centerOffset = l__PrimaryPart__1.CFrame:ToObjectSpace(v7.CFrame),
                    partAge = v8
                };
                table.insert(u6, v10);
                v7.CanCollide = false;
                if v9 then
                    v7.Transparency = 1;
                end;
            end;
        end;
        local function v16() --[[ Line: 43 ]]
            -- upvalues: u5 (copy), u6 (copy), l__PrimaryPart__1 (copy)
            local v11 = u5:GetAttribute("Age") or 0;
            local v12 = u5:GetAttribute("MaxAge") or 1;
            local v13 = v11 / v12;
            for _, v14 in u6 do
                if not v14.part:GetAttribute("DontShow") then
                    local v15 = math.clamp((v13 - v14.partAge / v12) * v12, 0, 1);
                    if v15 > 0 then
                        v14.part.Size = v14.maxSize * v15;
                        v14.part.CFrame = l__PrimaryPart__1.CFrame * v14.centerOffset;
                        v14.part.Transparency = v14.part:GetAttribute("OG_Transparency") or 0;
                        v14.part.CanCollide = true;
                    else
                        v14.part.Transparency = 1;
                        v14.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u5:GetAttributeChangedSignal("Age"):Connect(v16);
        v16();
    end,
    OnFullyGrown = function(p17) --[[ Name: OnFullyGrown, Line 72 ]]
        local v18 = p17:GetAttribute("CorePartName");
        if v18 then
            local v19 = p17:FindFirstChild(v18);
            local v20 = v19 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v20 then
                local v21 = v20:Clone();
                v21.Name = "ProximityPrompt";
                v21.Parent = v19;
            end;
        end;
        p17:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Venus Fly Trap",
        Harvestable = true
    }
};