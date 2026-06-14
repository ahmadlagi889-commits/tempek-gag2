-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.007,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, p3) --[[ Name: InitFruit, Line 8 ]]
        local v4 = Random.new(p2);
        local l__PrimaryPart__1 = u1.PrimaryPart;
        local u5 = (p3 or 1) * 0.75;
        local u6 = v4:NextInteger(3, 4);
        local u7 = 2 * u5;
        local u8 = v4:NextInteger(40, 50);
        local u9 = v4:NextInteger(65, 75);
        local u10 = v4:NextInteger(10, 20);
        local u11 = 0;
        local u12 = 0;
        local function v21(p13) --[[ Line: 26 ]]
            -- upvalues: u6 (copy), u9 (copy), u10 (copy), u8 (copy), u11 (ref), u12 (ref), u5 (ref), l__PrimaryPart__1 (copy), u7 (copy), u1 (copy)
            local v14 = (p13 - 1) / math.max(u6 - 1, 1);
            local v15 = u9 + (u10 - u9) * v14;
            local v16 = (p13 - 1) * u8;
            u11 = u11 + 1;
            u12 = u12 + 0.02;
            local v17 = Color3.fromHSV(0.8 - u12, 0.580392, 1);
            for v18 = 0, 3 do
                local v19 = v18 * 90 + v16;
                local v20 = script.Leaf:Clone();
                v20.Name = tostring(u11);
                v20.Size = Vector3.new(1 * u5, 5 * u5, 5 * u5);
                v20.CFrame = l__PrimaryPart__1.CFrame * CFrame.Angles(0, math.rad(v19), 0) * CFrame.new(0, 0, -u7) * CFrame.Angles(math.rad(v15 - 90), 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(0, v20.Size.Y / 2, 0);
                v20.Color = v17;
                v20.Parent = u1;
            end;
        end;
        v21(1);
        local v22 = v4:NextInteger(3, 5);
        local v23 = 4 * u5;
        local v24 = u11;
        for _ = 1, v22 do
            local v25 = script.Stud_Part:Clone();
            v25.Size = Vector3.new(v23, v23, v23);
            v25.Material = Enum.Material.Neon;
            v25.Shape = Enum.PartType.Ball;
            v25.CFrame = l__PrimaryPart__1.CFrame * CFrame.new(0, v25.Size.Y / 3 + l__PrimaryPart__1.Size.Y / 2, 0);
            v25.Transparency = 0.75;
            u11 = v24 + 1;
            v25.Name = tostring(u11);
            v25.Parent = u1;
            v23 = v23 * 1.075;
            v24 = u11;
        end;
        for v26 = 2, u6 do
            v21(v26);
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u27) --[[ Name: BeginFruitGrowth, Line 84 ]]
        local l__PrimaryPart__2 = u27.PrimaryPart;
        local u28 = {};
        for _, v29 in u27:GetDescendants() do
            local v30 = tonumber(v29.Name);
            if v29:IsA("BasePart") and v30 then
                local v31 = not v29:GetAttribute("DontShow");
                local v32 = l__PrimaryPart__2.CFrame:ToObjectSpace(v29.CFrame);
                local v33 = v32 * CFrame.new(0, -v29.Size.Y / 2, 0);
                local v34 = {};
                for _, v35 in v29:GetChildren() do
                    if v35:IsA("Texture") or v35:IsA("Decal") then
                        table.insert(v34, {
                            instance = v35,
                            originalTransparency = v35.Transparency
                        });
                        if v31 then
                            v35.Transparency = 1;
                        end;
                    end;
                end;
                local v36 = v29:GetAttribute("OG_Transparency");
                if v36 == nil then
                    v36 = v29.Transparency;
                end;
                local v37 = v29.Material == Enum.Material.Neon and 0.5 or v36;
                v29:SetAttribute("OG_Transparency", v37);
                table.insert(u28, {
                    part = v29,
                    maxSizeY = v29.Size.Y,
                    fullSize = v29.Size,
                    bottomCF = v33,
                    rotation = v32.Rotation,
                    partAge = v30,
                    originalTransparency = v37,
                    textures = v34
                });
                v29.CanCollide = false;
                if v31 then
                    v29.Transparency = 1;
                end;
            end;
        end;
        local function v47() --[[ Line: 133 ]]
            -- upvalues: u27 (copy), u28 (copy), l__PrimaryPart__2 (copy)
            local v38 = u27:GetAttribute("Age") or 0;
            local v39 = u27:GetAttribute("MaxAge") or 1;
            local v40 = v38 / v39;
            for _, v41 in u28 do
                if not v41.part:GetAttribute("DontShow") then
                    local v42 = math.clamp((v40 - v41.partAge / v39) * v39, 0, 1);
                    if v42 > 0 then
                        local v43 = v41.maxSizeY * v42;
                        v41.part.Size = Vector3.new(v41.fullSize.X, v43, v41.fullSize.Z);
                        local v44 = v41.bottomCF * CFrame.new(0, v43 / 2, 0);
                        v41.part.CFrame = l__PrimaryPart__2.CFrame * CFrame.new(v44.Position) * v41.rotation;
                        v41.part.Transparency = v41.originalTransparency;
                        v41.part.CanCollide = true;
                        for _, v45 in v41.textures do
                            v45.instance.Transparency = v45.originalTransparency;
                        end;
                    else
                        v41.part.Transparency = 1;
                        v41.part.CanCollide = false;
                        for _, v46 in v41.textures do
                            v46.instance.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u27:GetAttributeChangedSignal("Age"):Connect(v47);
        v47();
    end,
    OnFullyGrown = function(p48) --[[ Name: OnFullyGrown, Line 167 ]]
        local v49 = p48:GetAttribute("CorePartName");
        if v49 then
            local v50 = p48:FindFirstChild(v49);
            local v51 = v50 and game.ServerStorage:FindFirstChild("Collect_PROX_Flower");
            if v51 then
                local v52 = v51:Clone();
                v52.Name = "ProximityPrompt";
                v52.Parent = v50;
            end;
        end;
        p48:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Sunflower",
        Harvestable = true
    }
};