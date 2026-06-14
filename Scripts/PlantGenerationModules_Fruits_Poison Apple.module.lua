-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.0023,
        BaseWeight = 2.25,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 8 ]]
        local v4 = Random.new(p2);
        local v5, v6 = Color3.fromRGB(0, 159, 13);
        local v7, v8, v9 = v5:ToHSV();
        local v10 = v6 or 0.05;
        local v11 = v7 + v4:NextNumber(-v10, v10);
        local v12 = Color3.fromHSV(v11, v8, v9);
        local v13, v14 = Color3.fromRGB(149, 99, 171);
        local v15, v16, v17 = v13:ToHSV();
        local v18 = v14 or 0.05;
        local v19 = v15 + v4:NextNumber(-v18, v18);
        local v20 = Color3.fromHSV(v19, v16, v17);
        local v21 = p1:FindFirstChild("Leaf");
        if v21 then
            local v22 = v21:GetPivot();
            local l__Angles__1 = CFrame.Angles;
            local v23 = v4:NextNumber(-180, 180);
            v21:PivotTo(v22 * l__Angles__1(math.rad(v23), 0, 0));
            if v4:NextInteger(1, 6) == 1 then
                v21:Destroy();
            else
                v21.Name = "2";
            end;
        end;
        local v24 = p1:FindFirstChild("1");
        if v24 then
            local l__CFrame__2 = v24.CFrame;
            local l__Angles__3 = CFrame.Angles;
            local v25 = v4:NextNumber(-180, 180);
            local v26 = math.rad(v25);
            local v27 = v4:NextNumber(-5, 5);
            v24.CFrame = l__CFrame__2 * l__Angles__3(0, v26, (math.rad(v27)));
        end;
        for _, v28 in p1:GetChildren() do
            if v28:IsA("BasePart") or v28:IsA("MeshPart") then
                local l__CFrame__4 = v28.CFrame;
                local l__Angles__5 = CFrame.Angles;
                local v29 = v4:NextNumber(-5, 5);
                v28.CFrame = l__CFrame__4 * l__Angles__5(0, math.rad(v29), 0);
                if v28.Color == Color3.fromRGB(0, 159, 13) then
                    v28.Color = v12;
                end;
                if v28.Color == Color3.fromRGB(149, 99, 171) then
                    v28.Color = v20;
                end;
                if v28:FindFirstChild("Decal") then
                    for _, v30 in v28:GetChildren() do
                        if v30:IsA("Decal") then
                            v30.Color3 = v20;
                        end;
                    end;
                end;
            end;
        end;
        p1:ScaleTo(p3);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u31) --[[ Name: BeginFruitGrowth, Line 56 ]]
        local l__PrimaryPart__6 = u31.PrimaryPart;
        local u32 = {};
        for _, v33 in u31:GetDescendants() do
            local v34 = tonumber(v33.Name);
            if v33:IsA("BasePart") and v34 then
                local v35 = not v33:GetAttribute("DontShow");
                local v36 = {};
                for _, v37 in v33:GetChildren() do
                    if v37:IsA("Decal") or v37:IsA("Texture") then
                        table.insert(v36, {
                            decal = v37,
                            originalTransparency = v37.Transparency
                        });
                        if v35 then
                            v37.Transparency = 1;
                        end;
                    end;
                end;
                local v38 = {
                    part = v33,
                    maxSize = v33.Size,
                    centerOffset = l__PrimaryPart__6.CFrame:ToObjectSpace(v33.CFrame),
                    partAge = v34,
                    decals = v36
                };
                table.insert(u32, v38);
                v33.CanCollide = false;
                if v35 then
                    v33.Transparency = 1;
                end;
            end;
        end;
        local function v47() --[[ Line: 91 ]]
            -- upvalues: u31 (copy), u32 (copy), l__PrimaryPart__6 (copy)
            local v39 = u31:GetAttribute("Age") or 0;
            local v40 = u31:GetAttribute("MaxAge") or 1;
            local v41 = v39 / v40;
            for _, v42 in u32 do
                if not v42.part:GetAttribute("DontShow") then
                    local v43 = math.clamp((v41 - v42.partAge / v40) * v40, 0, 1);
                    if v43 > 0 then
                        local v44 = v42.maxSize * v43;
                        v42.part.Size = v44;
                        v42.part.CFrame = l__PrimaryPart__6.CFrame * v42.centerOffset * CFrame.new(0, -((v42.maxSize.Y - v44.Y) / 2), 0);
                        v42.part.Transparency = v42.part:GetAttribute("OG_Transparency") or 0;
                        v42.part.CanCollide = true;
                        for _, v45 in v42.decals do
                            v45.decal.Transparency = v45.originalTransparency + (1 - v45.originalTransparency) * (1 - v43);
                        end;
                    else
                        v42.part.Transparency = 1;
                        v42.part.CanCollide = false;
                        for _, v46 in v42.decals do
                            v46.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u31:GetAttributeChangedSignal("Age"):Connect(v47);
        v47();
    end,
    OnFullyGrown = function(p48) --[[ Name: OnFullyGrown, Line 126 ]]
        local v49 = p48:GetAttribute("CorePartName");
        if v49 then
            local v50 = p48:FindFirstChild(v49);
            local v51 = v50 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v51 then
                local v52 = v51:Clone();
                v52.Name = "ProximityPrompt";
                v52.Parent = v50;
            end;
        end;
        p48:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Fruit",
        Harvestable = true
    }
};