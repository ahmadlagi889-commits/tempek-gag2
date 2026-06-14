-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0119,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 13 ]]
        local v4 = Random.new(p2);
        local _ = p3 * 0.2;
        local v5 = p1.Base:GetPivot();
        local v6, v7 = Color3.fromRGB(109, 209, 73);
        local v8, v9, v10 = v6:ToHSV();
        local v11 = v7 or 0.05;
        local v12 = (v8 + v4:NextNumber(-v11, v11)) % 1;
        local v13 = Color3.fromHSV(v12, math.clamp(v9, 0, 1), (math.clamp(v10, 0, 1)));
        local v14, v15 = Color3.fromRGB(242, 255, 102);
        local v16, v17, v18 = v14:ToHSV();
        local v19 = v15 or 0.05;
        local v20 = (v16 + v4:NextNumber(-v19, v19)) % 1;
        local v21 = Color3.fromHSV(v20, math.clamp(v17, 0, 1), (math.clamp(v18, 0, 1)));
        local v22 = v4:NextInteger(6, 10);
        while v4:NextInteger(1, 4) == 1 do
            v22 = v22 + 1;
        end;
        local v23 = v4:NextNumber(-6, 6);
        local v24 = math.rad(v23);
        local v25 = v4:NextNumber(-6, 6);
        local v26 = math.rad(v25);
        local l__Angles__1 = CFrame.Angles;
        local v27 = v4:NextNumber(-10, 10);
        local v28 = math.rad(v27);
        local v29 = v4:NextNumber(1, 360);
        local v30 = math.rad(v29);
        local v31 = v4:NextNumber(-10, 10);
        local v32 = v5 * l__Angles__1(v28, v30, (math.rad(v31)));
        local v33 = 60;
        local v34 = false;
        for v35 = 1, v33 do
            if v35 > 25 and v34 == false then
                v24 = -v24;
                v26 = -v26;
                v34 = true;
            end;
            local v36 = script.Layer:Clone();
            v36.Parent = workspace;
            local v37 = (v35 - 1) / (v33 - 1);
            v36:ScaleTo(0.9 + -0.55 * v37);
            local v38 = v13:Lerp(v21, v37);
            for _, v39 in v36:GetDescendants() do
                if v39:IsA("BasePart") then
                    v39.Color = v38;
                end;
            end;
            v36:PivotTo(v32);
            v32 = v36:GetPivot() * CFrame.new(0, 2 * v36:GetScale(), 0) * CFrame.Angles(v24, 0, v26);
            for _, v40 in v36:GetChildren() do
                if v40:IsA("BasePart") then
                    local v41 = tonumber(v40.Name) + v35;
                    v40.Name = tostring(v41);
                    v40.Parent = p1;
                end;
            end;
            v36:Destroy();
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u42) --[[ Name: BeginFruitGrowth, Line 104 ]]
        local l__PrimaryPart__2 = u42.PrimaryPart;
        local u43 = {};
        for _, v44 in u42:GetDescendants() do
            local v45 = tonumber(v44.Name);
            if v44:IsA("BasePart") and v45 then
                local v46 = not v44:GetAttribute("DontShow");
                local v47 = {
                    part = v44,
                    maxSize = v44.Size,
                    centerOffset = l__PrimaryPart__2.CFrame:ToObjectSpace(v44.CFrame),
                    partAge = v45
                };
                table.insert(u43, v47);
                v44.CanCollide = false;
                if v46 then
                    v44.Transparency = 1;
                end;
            end;
        end;
        local function v54() --[[ Line: 125 ]]
            -- upvalues: u42 (copy), u43 (copy), l__PrimaryPart__2 (copy)
            local v48 = u42:GetAttribute("Age") or 0;
            local v49 = u42:GetAttribute("MaxAge") or 1;
            local v50 = v48 / v49;
            for _, v51 in u43 do
                if not v51.part:GetAttribute("DontShow") then
                    local v52 = math.clamp((v50 - v51.partAge / v49) * v49, 0, 1);
                    if v52 > 0 then
                        local v53 = v51.maxSize * v52;
                        v51.part.Size = v53;
                        v51.part.CFrame = l__PrimaryPart__2.CFrame * v51.centerOffset * CFrame.new(0, -((v51.maxSize.Y - v53.Y) / 2), 0);
                        v51.part.Transparency = v51.part:GetAttribute("OG_Transparency") or 0;
                        v51.part.CanCollide = true;
                    else
                        v51.part.Transparency = 1;
                        v51.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u42:GetAttributeChangedSignal("Age"):Connect(v54);
        v54();
    end,
    OnFullyGrown = function(p55) --[[ Name: OnFullyGrown, Line 157 ]]
        local v56 = p55:GetAttribute("CorePartName");
        if v56 then
            local v57 = p55:FindFirstChild(v56);
            local v58 = v57 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v58 then
                local v59 = v58:Clone();
                v59.Name = "ProximityPrompt";
                v59.Parent = v57;
            end;
        end;
        p55:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};