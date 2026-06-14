-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.0064,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local v4 = Random.new(p2);
        local v5 = {
            Color3.fromRGB(179, 25, 25),
            Color3.fromRGB(179, 25, 25),
            Color3.fromRGB(255, 36, 36),
            Color3.fromRGB(234, 82, 82),
            Color3.fromRGB(134, 34, 34)
        };
        local v6 = v5[v4:NextInteger(1, #v5)];
        local v7 = v5[v4:NextInteger(1, #v5)];
        p1.Stem.m1:ScaleTo(v4:NextNumber(0.8, 1.22) * p3);
        local l__m1__1 = p1.Stem.m1;
        local v8 = p1.Stem.m1:GetPivot();
        local l__Angles__2 = CFrame.Angles;
        local v9 = v4:NextInteger(-25, 25);
        local v10 = math.rad(v9);
        local v11 = v4:NextInteger(-45, 45);
        local v12 = math.rad(v11);
        local v13 = v4:NextInteger(-25, 25);
        l__m1__1:PivotTo(v8 * l__Angles__2(v10, v12, (math.rad(v13))));
        p1.Stem.m1["4"].Color = v6;
        p1.Stem.m2:ScaleTo(v4:NextNumber(0.8, 1.22) * p3);
        local l__m2__3 = p1.Stem.m2;
        local v14 = p1.Stem.m2:GetPivot();
        local l__Angles__4 = CFrame.Angles;
        local v15 = v4:NextInteger(-25, 25);
        local v16 = math.rad(v15);
        local v17 = v4:NextInteger(-45, 45);
        local v18 = math.rad(v17);
        local v19 = v4:NextInteger(-25, 25);
        l__m2__3:PivotTo(v14 * l__Angles__4(v16, v18, (math.rad(v19))));
        p1.Stem.m2["4"].Color = v7;
        local l__Stem__5 = p1.Stem;
        local v20 = p1.Stem:GetPivot();
        local l__Angles__6 = CFrame.Angles;
        local v21 = v4:NextInteger(-33, 33);
        local v22 = math.rad(v21);
        local v23 = v4:NextInteger(-33, 33);
        local v24 = math.rad(v23);
        local v25 = v4:NextInteger(-33, 33);
        l__Stem__5:PivotTo(v20 * l__Angles__6(v22, v24, (math.rad(v25))));
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u26) --[[ Name: BeginFruitGrowth, Line 38 ]]
        local l__PrimaryPart__7 = u26.PrimaryPart;
        local u27 = {};
        for _, v28 in u26:GetDescendants() do
            local v29 = tonumber(v28.Name);
            if v28:IsA("BasePart") and v29 then
                local v30 = not v28:GetAttribute("DontShow");
                local v31 = {
                    part = v28,
                    maxSize = v28.Size,
                    centerOffset = l__PrimaryPart__7.CFrame:ToObjectSpace(v28.CFrame),
                    upVector = l__PrimaryPart__7.CFrame:VectorToObjectSpace(v28.CFrame.UpVector),
                    partAge = v29
                };
                table.insert(u27, v31);
                v28.CanCollide = false;
                if v30 then
                    v28.Transparency = 1;
                end;
            end;
        end;
        local function v38() --[[ Line: 62 ]]
            -- upvalues: u26 (copy), u27 (copy), l__PrimaryPart__7 (copy)
            local v32 = u26:GetAttribute("Age") or 0;
            local v33 = u26:GetAttribute("MaxAge") or 1;
            local v34 = v32 / v33;
            for _, v35 in u27 do
                if not v35.part:GetAttribute("DontShow") then
                    local v36 = math.clamp((v34 - (v35.partAge - 1) / v33) * v33, 0, 1);
                    if v36 > 0 then
                        v35.part.Size = v35.maxSize * v36;
                        local v37 = v35.part:GetAttribute("GrowUp") and -1 or 1;
                        v35.part.CFrame = l__PrimaryPart__7.CFrame * (v35.centerOffset + v35.upVector * (v35.maxSize.Y / 2 * (1 - v36)) * v37);
                        v35.part.Transparency = v35.part:GetAttribute("OG_Transparency") or 0;
                        v35.part.CanCollide = true;
                    else
                        v35.part.Transparency = 1;
                        v35.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u26:GetAttributeChangedSignal("Age"):Connect(v38);
        v38();
    end,
    OnFullyGrown = function(p39) --[[ Name: OnFullyGrown, Line 95 ]]
        local v40 = p39:GetAttribute("CorePartName");
        if v40 then
            local v41 = p39:FindFirstChild(v40);
            local v42 = v41 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v42 then
                local v43 = v42:Clone();
                v43.Name = "ProximityPrompt";
                v43.Parent = v41;
            end;
        end;
        p39:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Cherry",
        Harvestable = true
    }
};