-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.4067,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 13 ]]
        local v4 = Random.new(p2);
        local _ = p3 * 0.2;
        local v5 = p1.Base:GetPivot();
        local v6 = {
            Color3.fromRGB(254, 98, 165),
            Color3.fromRGB(160, 93, 254),
            Color3.fromRGB(254, 146, 92),
            Color3.fromRGB(108, 254, 225)
        };
        local v7, v8, v9 = v6[v4:NextInteger(1, #v6)]:ToHSV();
        local v10 = 0.1 or 0.05;
        local v11 = (v7 + v4:NextNumber(-v10, v10)) % 1;
        local v12 = Color3.fromHSV(v11, math.clamp(v8, 0, 1), (math.clamp(v9, 0, 1)));
        local v13 = v4:NextInteger(5, 9);
        for v14 = 1, v13 do
            local v15 = script.Petal:Clone();
            v15:ScaleTo(v4:NextNumber(1.2, 1.5));
            local l__Angles__1 = CFrame.Angles;
            local v16 = v4:NextInteger(-3, 3);
            local v17 = math.rad(v16);
            local v18 = 360 / v13 * v14 + v4:NextInteger(-9, 9);
            local v19 = math.rad(v18);
            local v20 = v4:NextInteger(-15, -10);
            v15:PivotTo(v5 * l__Angles__1(v17, v19, (math.rad(v20))));
            for _, v21 in v15:GetChildren() do
                v21.Name = tonumber(v21.Name) + v14;
                local v22 = nil or 1;
                if v21:IsA("BasePart") then
                    local _, _, v23 = v21.Color:ToHSV();
                    local v24, v25 = v12:ToHSV();
                    v21.Color = Color3.fromHSV(v24, v25 * v22, v23);
                end;
                v21.Parent = p1;
            end;
            v15:Destroy();
        end;
        local v26 = v4:NextInteger(3, 6);
        for v27 = 1, v26 do
            local v28 = script.Petal:Clone();
            v28:ScaleTo(v4:NextNumber(0.94, 1.2));
            local l__Angles__2 = CFrame.Angles;
            local v29 = v4:NextInteger(-3, 3);
            local v30 = math.rad(v29);
            local v31 = 360 / v26 * v27 + v4:NextInteger(-9, 9);
            local v32 = math.rad(v31);
            local v33 = v4:NextInteger(-50, -40);
            v28:PivotTo(v5 * l__Angles__2(v30, v32, (math.rad(v33))));
            for _, v34 in v28:GetChildren() do
                v34.Name = tonumber(v34.Name) + v27;
                local v35 = nil or 1;
                if v34:IsA("BasePart") then
                    local _, _, v36 = v34.Color:ToHSV();
                    local v37, v38 = v12:ToHSV();
                    v34.Color = Color3.fromHSV(v37, v38 * v35, v36);
                end;
                v34.Parent = p1;
            end;
            v28:Destroy();
        end;
        p1:ScaleTo(p3);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u39) --[[ Name: BeginFruitGrowth, Line 104 ]]
        local l__PrimaryPart__3 = u39.PrimaryPart;
        local u40 = {};
        for _, v41 in u39:GetDescendants() do
            local v42 = tonumber(v41.Name);
            if v41:IsA("BasePart") and v42 then
                local v43 = not v41:GetAttribute("DontShow");
                local v44 = {
                    part = v41,
                    maxSize = v41.Size,
                    centerOffset = l__PrimaryPart__3.CFrame:ToObjectSpace(v41.CFrame),
                    partAge = v42
                };
                table.insert(u40, v44);
                v41.CanCollide = false;
                if v43 then
                    v41.Transparency = 1;
                end;
            end;
        end;
        local function v51() --[[ Line: 125 ]]
            -- upvalues: u39 (copy), u40 (copy), l__PrimaryPart__3 (copy)
            local v45 = u39:GetAttribute("Age") or 0;
            local v46 = u39:GetAttribute("MaxAge") or 1;
            local v47 = v45 / v46;
            for _, v48 in u40 do
                if not v48.part:GetAttribute("DontShow") then
                    local v49 = math.clamp((v47 - v48.partAge / v46) * v46, 0, 1);
                    if v49 > 0 then
                        local v50 = v48.maxSize * v49;
                        v48.part.Size = v50;
                        v48.part.CFrame = l__PrimaryPart__3.CFrame * v48.centerOffset * CFrame.new(0, -((v48.maxSize.Y - v50.Y) / 2), 0);
                        v48.part.Transparency = v48.part:GetAttribute("OG_Transparency") or 0;
                        v48.part.CanCollide = true;
                    else
                        v48.part.Transparency = 1;
                        v48.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u39:GetAttributeChangedSignal("Age"):Connect(v51);
        v51();
    end,
    OnFullyGrown = function(p52) --[[ Name: OnFullyGrown, Line 157 ]]
        local v53 = p52:GetAttribute("CorePartName");
        if v53 then
            local v54 = p52:FindFirstChild(v53);
            local v55 = v54 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v55 then
                local v56 = v55:Clone();
                v56.Name = "ProximityPrompt";
                v56.Parent = v54;
            end;
        end;
        p52:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};