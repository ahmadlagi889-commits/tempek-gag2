-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0047,
        BaseWeight = 9,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 10 ]]
        game:GetService("MaterialService");
        local v4 = p3 or 1;
        local v5 = Random.new(p2);
        local _ = p1.Base;
        local v6, v7 = Color3.fromRGB(51, 136, 5);
        local v8, v9, v10 = v6:ToHSV();
        local v11 = v7 or 0.05;
        local v12 = v8 + v5:NextNumber(-v11, v11);
        local v13 = math.clamp(v12, 0, 0.99);
        Color3.fromHSV(v13, v9, v10);
        local l__Moon__1 = p1.Moon;
        local l__Leaves__2 = p1.Leaves;
        local l__Anthers__3 = p1.Anthers;
        local v14 = Color3.fromRGB(255, 255, 255);
        if v5:NextInteger(1, 3) == 1 then
            v14 = v5:NextInteger(1, 2) == 1 and Color3.fromRGB(35, 55, 163) or Color3.fromRGB(34, 180, 248);
        end;
        for _, v15 in l__Moon__1:GetChildren() do
            v15.Color = v14;
            v15.Parent = p1;
        end;
        l__Moon__1:Destroy();
        for _, v16 in l__Leaves__2:GetChildren() do
            if v16:IsA("Model") then
                local v17 = v16:GetPivot();
                local l__Angles__4 = CFrame.Angles;
                local v18 = v5:NextNumber(-10, 10);
                local v19 = math.rad(v18);
                local v20 = v5:NextNumber(-10, 10);
                v16:PivotTo(v17 * l__Angles__4(v19, 0, (math.rad(v20))));
                for _, v21 in v16:GetChildren() do
                    v21.Parent = p1;
                end;
                v16:Destroy();
            else
                local v22 = v16:GetPivot();
                local l__Angles__5 = CFrame.Angles;
                local v23 = v5:NextNumber(-6, 6);
                local v24 = math.rad(v23);
                local v25 = v5:NextNumber(-20, 20);
                v16:PivotTo(v22 * l__Angles__5(v24, 0, (math.rad(v25))));
                v16.Parent = p1;
            end;
        end;
        for _, v26 in l__Anthers__3:GetChildren() do
            local v27 = v26:GetPivot();
            local l__Angles__6 = CFrame.Angles;
            local v28 = v5:NextNumber(-10, 10);
            local v29 = math.rad(v28);
            local v30 = v5:NextNumber(-15, 25);
            v26:PivotTo(v27 * l__Angles__6(v29, 0, (math.rad(v30))));
            for _, v31 in v26:GetChildren() do
                v31.Parent = p1;
            end;
        end;
        local v32 = v5:NextInteger(2, 4);
        local v33 = p1["1"];
        for v34 = 1, v32 do
            local v35 = script.Leaf:Clone();
            v35.Parent = p1;
            local v36 = 45 + 360 / v32 * (v34 * v5:NextNumber(0.9, 1, 1));
            local v37 = v33.CFrame * CFrame.new(0, v33.Size.Y / 2.5, 0);
            local l__Angles__7 = CFrame.Angles;
            local v38 = math.rad(v36);
            local v39 = v5:NextNumber(97.5, 110);
            v35:PivotTo(v37 * l__Angles__7(0, v38, (math.rad(v39))));
            v35.Name = 2;
        end;
        l__Anthers__3:Destroy();
        local v40 = v5:NextNumber(-0.1, 0.1);
        for _, v41 in p1:GetChildren() do
            if tonumber(v41.Name) and v41.Color ~= Color3.fromRGB(255, 255, 255) then
                local v42, v43, v44 = v41.Color:ToHSV();
                v41.Color = Color3.fromHSV(v42 + v40, v43, v44);
            end;
        end;
        local v45 = v4 * 0.25 + 0.75;
        p1:ScaleTo(v45 + v45 ^ 3 * 1e-6);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u46) --[[ Name: BeginFruitGrowth, Line 144 ]]
        local l__PrimaryPart__8 = u46.PrimaryPart;
        local u47 = {};
        for _, v48 in u46:GetDescendants() do
            local v49 = tonumber(v48.Name);
            if (v48:IsA("BasePart") or v48:IsA("MeshPart")) and v49 then
                local v50 = not v48:GetAttribute("DontShow");
                local v51 = {};
                for _, v52 in v48:GetChildren() do
                    if v52:IsA("Decal") or v52:IsA("Texture") then
                        table.insert(v51, {
                            decal = v52,
                            originalTransparency = v52.Transparency
                        });
                        if v50 then
                            v52.Transparency = 1;
                        end;
                    end;
                end;
                local v53 = {
                    part = v48,
                    maxSize = v48.Size,
                    centerOffset = l__PrimaryPart__8.CFrame:ToObjectSpace(v48.CFrame),
                    partAge = v49,
                    decals = v51
                };
                table.insert(u47, v53);
                v48.CanCollide = false;
                if v50 then
                    v48.Transparency = 1;
                end;
            end;
        end;
        local function v62() --[[ Line: 179 ]]
            -- upvalues: u46 (copy), u47 (copy), l__PrimaryPart__8 (copy)
            local v54 = u46:GetAttribute("Age") or 0;
            local v55 = u46:GetAttribute("MaxAge") or 1;
            local v56 = v54 / v55;
            for _, v57 in u47 do
                if not v57.part:GetAttribute("DontShow") then
                    local v58 = math.clamp((v56 - v57.partAge / v55) * v55, 0, 1);
                    if v58 > 0 then
                        local v59 = v57.maxSize * v58;
                        v57.part.Size = v59;
                        v57.part.CFrame = l__PrimaryPart__8.CFrame * v57.centerOffset * CFrame.new(0, -((v57.maxSize.Y - v59.Y) / 2), 0);
                        v57.part.Transparency = v57.part:GetAttribute("OG_Transparency") or 0;
                        v57.part.CanCollide = true;
                        for _, v60 in v57.decals do
                            v60.decal.Transparency = v60.originalTransparency + (1 - v60.originalTransparency) * (1 - v58);
                        end;
                    else
                        v57.part.Transparency = 1;
                        v57.part.CanCollide = false;
                        for _, v61 in v57.decals do
                            v61.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u46:GetAttributeChangedSignal("Age"):Connect(v62);
        v62();
    end,
    OnFullyGrown = function(p63) --[[ Name: OnFullyGrown, Line 214 ]]
        local v64 = p63:GetAttribute("CorePartName");
        if v64 then
            local v65 = p63:FindFirstChild(v64);
            local v66 = v65 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v66 then
                local v67 = v66:Clone();
                v67.Name = "ProximityPrompt";
                v67.Parent = v65;
            end;
        end;
        p63:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Corn",
        Harvestable = true
    }
};