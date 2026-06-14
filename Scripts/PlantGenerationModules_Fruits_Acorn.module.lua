-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        BaseWeight = 1.5,
        GrowRate = 0.0058,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 69 ]]
        local v4 = Random.new(p2);
        local _ = 5 * p3;
        local v5, v6, v7 = Color3.fromRGB(165, 138, 105):ToHSV();
        local v8 = 0.025 or 0.05;
        local v9 = v5 + v4:NextNumber(-v8, v8);
        local v10 = Color3.fromHSV(v9, v6, v7);
        local v11 = p1:FindFirstChild("1");
        local v12 = p1:FindFirstChild("2");
        if v11 and v12 then
            local v13 = v4:NextNumber(0.25, 0.4);
            v11.Size = Vector3.new(v13, 0.85, v13);
            v11.CFrame = v12.CFrame * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, 0.425 + v12.Size.Y / 2, 0) * CFrame.Angles(0, 0, 3.141592653589793);
        end;
        for _, v14 in p1:GetChildren() do
            if v14:IsA("BasePart") then
                local v15 = tonumber(v14.Name);
                if v15 then
                    local l__CFrame__1 = v14.CFrame;
                    local l__Angles__2 = CFrame.Angles;
                    local v16 = v4:NextNumber(-10, 10);
                    v14.CFrame = l__CFrame__1 * l__Angles__2(0, math.rad(v16), 0);
                    if v15 > 3 then
                        v14.Color = v10;
                    end;
                end;
            end;
        end;
        local v17 = (p3 * 0.5 + 0.3) ^ 1.25;
        p1:ScaleTo(v17 + v17 ^ 6 * 0.0001);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u18) --[[ Name: BeginFruitGrowth, Line 113 ]]
        local l__PrimaryPart__3 = u18.PrimaryPart;
        local u19 = {};
        for _, v20 in u18:GetDescendants() do
            local v21 = tonumber(v20.Name);
            if v20:IsA("BasePart") and v21 then
                local v22 = not v20:GetAttribute("DontShow");
                local v23 = {
                    part = v20,
                    maxSize = v20.Size,
                    centerOffset = l__PrimaryPart__3.CFrame:ToObjectSpace(v20.CFrame),
                    partAge = v21
                };
                table.insert(u19, v23);
                v20.CanCollide = false;
                if v22 then
                    v20.Transparency = 1;
                end;
            end;
        end;
        local function v30() --[[ Line: 134 ]]
            -- upvalues: u18 (copy), u19 (copy), l__PrimaryPart__3 (copy)
            local v24 = u18:GetAttribute("Age") or 0;
            local v25 = u18:GetAttribute("MaxAge") or 1;
            local v26 = v24 / v25;
            for _, v27 in u19 do
                if not v27.part:GetAttribute("DontShow") then
                    local v28 = math.clamp((v26 - v27.partAge / v25) * v25, 0, 1);
                    if v28 > 0 then
                        local v29 = v27.maxSize * v28;
                        v27.part.Size = v29;
                        v27.part.CFrame = l__PrimaryPart__3.CFrame * v27.centerOffset * CFrame.new(0, -((v27.maxSize.Y - v29.Y) / 2), 0);
                        v27.part.Transparency = v27.part:GetAttribute("OG_Transparency") or 0;
                        v27.part.CanCollide = true;
                    else
                        v27.part.Transparency = 1;
                        v27.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u18:GetAttributeChangedSignal("Age"):Connect(v30);
        v30();
    end,
    OnFullyGrown = function(p31) --[[ Name: OnFullyGrown, Line 166 ]]
        local v32 = p31:GetAttribute("CorePartName");
        if v32 then
            local v33 = p31:FindFirstChild(v32);
            local v34 = v33 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v34 then
                local v35 = v34:Clone();
                v35.Name = "ProximityPrompt";
                v35.Parent = v33;
            end;
        end;
        p31:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};