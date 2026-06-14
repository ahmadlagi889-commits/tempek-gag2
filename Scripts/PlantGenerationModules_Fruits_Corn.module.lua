-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0444,
        BaseWeight = 3,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 10 ]]
        game:GetService("MaterialService");
        local v4 = (p3 or 1) * 0.5 + 0.5;
        local v5 = v4 + v4 ^ 3 * 1e-7;
        local v6 = Random.new(p2);
        local _ = p1.Base;
        local v7, v8 = Color3.fromRGB(51, 136, 5);
        local v9, v10, v11 = v7:ToHSV();
        local v12 = v8 or 0.05;
        local v13 = v9 + v6:NextNumber(-v12, v12);
        local v14 = math.clamp(v13, 0, 0.99);
        Color3.fromHSV(v14, v10, v11);
        local l__Corn__1 = p1.Corn;
        local v15, v16 = Color3.fromRGB(255, 243, 0);
        local v17, v18, v19 = v15:ToHSV();
        local v20 = v16 or 0.05;
        local v21 = v17 + v6:NextNumber(-v20, v20);
        local v22 = math.clamp(v21, 0, 0.99);
        local v23 = Color3.fromHSV(v22, v18, v19);
        if v6:NextInteger(1, 700) == 1 then
            v23 = Color3.new(0.666667, 0.333333, 1);
        end;
        if v6:NextInteger(1, 7000) == 1 then
            v23 = Color3.new(1, 1, 1);
        end;
        local v24 = p1["1"];
        local v25 = v6:NextInteger(3, 4);
        local v26 = l__Corn__1:GetPivot();
        local l__Angles__2 = CFrame.Angles;
        local v27 = v6:NextNumber(-5, 5);
        local v28 = math.rad(v27);
        local v29 = v6:NextNumber(-45, 45);
        l__Corn__1:PivotTo(v26 * l__Angles__2(v28, math.rad(v29), 0));
        for _, v30 in l__Corn__1:GetChildren() do
            local l__CFrame__3 = v30.CFrame;
            local l__Angles__4 = CFrame.Angles;
            local v31 = v6:NextNumber(-5, 5);
            v30.CFrame = l__CFrame__3 * l__Angles__4(0, math.rad(v31), 0);
            v30.Color = v23;
            v30.Parent = p1;
        end;
        for v32 = 1, v25 do
            local v33 = script.FlowerPetal:Clone();
            local v34 = 360 / v25 * (v32 * v6:NextNumber(0.8, 1.2));
            v33.Parent = p1;
            v33:PivotTo(v24.CFrame * CFrame.new(0, -v24.Size.Y / 2.25, 0) * CFrame.Angles(0, math.rad(v34), 0) * CFrame.Angles(1.3089969389957472, 0, 0));
            v33.Name = 2;
        end;
        l__Corn__1:Destroy();
        p1:ScaleTo(v5);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u35) --[[ Name: BeginFruitGrowth, Line 100 ]]
        local l__PrimaryPart__5 = u35.PrimaryPart;
        local u36 = {};
        for _, v37 in u35:GetDescendants() do
            local v38 = tonumber(v37.Name);
            if (v37:IsA("BasePart") or v37:IsA("MeshPart")) and v38 then
                local v39 = not v37:GetAttribute("DontShow");
                local v40 = {};
                for _, v41 in v37:GetChildren() do
                    if v41:IsA("Decal") or v41:IsA("Texture") then
                        table.insert(v40, {
                            decal = v41,
                            originalTransparency = v41.Transparency
                        });
                        if v39 then
                            v41.Transparency = 1;
                        end;
                    end;
                end;
                local v42 = {
                    part = v37,
                    maxSize = v37.Size,
                    centerOffset = l__PrimaryPart__5.CFrame:ToObjectSpace(v37.CFrame),
                    partAge = v38,
                    decals = v40
                };
                table.insert(u36, v42);
                v37.CanCollide = false;
                if v39 then
                    v37.Transparency = 1;
                end;
            end;
        end;
        local function v51() --[[ Line: 135 ]]
            -- upvalues: u35 (copy), u36 (copy), l__PrimaryPart__5 (copy)
            local v43 = u35:GetAttribute("Age") or 0;
            local v44 = u35:GetAttribute("MaxAge") or 1;
            local v45 = v43 / v44;
            for _, v46 in u36 do
                if not v46.part:GetAttribute("DontShow") then
                    local v47 = math.clamp((v45 - v46.partAge / v44) * v44, 0, 1);
                    if v47 > 0 then
                        local v48 = v46.maxSize * v47;
                        v46.part.Size = v48;
                        v46.part.CFrame = l__PrimaryPart__5.CFrame * v46.centerOffset * CFrame.new(0, -((v46.maxSize.Y - v48.Y) / 2), 0);
                        v46.part.Transparency = v46.part:GetAttribute("OG_Transparency") or 0;
                        v46.part.CanCollide = true;
                        for _, v49 in v46.decals do
                            v49.decal.Transparency = v49.originalTransparency + (1 - v49.originalTransparency) * (1 - v47);
                        end;
                    else
                        v46.part.Transparency = 1;
                        v46.part.CanCollide = false;
                        for _, v50 in v46.decals do
                            v50.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u35:GetAttributeChangedSignal("Age"):Connect(v51);
        v51();
    end,
    OnFullyGrown = function(p52) --[[ Name: OnFullyGrown, Line 170 ]]
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
        FruitType = "Corn",
        Harvestable = true
    }
};