-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.0064,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        Random.new(p2);
        local l__Base__1 = p1.Base;
        local v4 = (p3 or 1) * 0.5;
        if v4 ~= 1 then
            local l__CFrame__2 = l__Base__1.CFrame;
            for _, v5 in p1:GetDescendants() do
                if v5:IsA("BasePart") then
                    v5.Size = v5.Size * v4;
                    local v6 = l__CFrame__2:ToObjectSpace(v5.CFrame);
                    v5.CFrame = l__CFrame__2 * CFrame.new(v6.Position * v4) * v6.Rotation;
                end;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u7) --[[ Name: BeginFruitGrowth, Line 35 ]]
        local l__PrimaryPart__3 = u7.PrimaryPart;
        local u8 = {};
        for _, v9 in u7:GetDescendants() do
            local v10 = tonumber(v9.Name);
            if v9:IsA("BasePart") and v10 then
                local v11 = not v9:GetAttribute("DontShow");
                local v12 = l__PrimaryPart__3.CFrame:ToObjectSpace(v9.CFrame);
                local v13 = v12 * CFrame.new(0, -v9.Size.Y / 2, 0);
                local v14 = {};
                for _, v15 in v9:GetChildren() do
                    if v15:IsA("Texture") or v15:IsA("Decal") then
                        table.insert(v14, {
                            obj = v15,
                            ogTransparency = v15.Transparency
                        });
                    end;
                end;
                table.insert(u8, {
                    part = v9,
                    maxSizeY = v9.Size.Y,
                    fullSize = v9.Size,
                    bottomCF = v13,
                    rotation = v12.Rotation,
                    partAge = v10,
                    textures = v14
                });
                v9.CanCollide = false;
                if v11 then
                    v9.Transparency = 1;
                    for _, v16 in v14 do
                        v16.obj.Transparency = 1;
                    end;
                end;
            end;
        end;
        local function v26() --[[ Line: 74 ]]
            -- upvalues: u7 (copy), u8 (copy), l__PrimaryPart__3 (copy)
            local v17 = u7:GetAttribute("Age") or 0;
            local v18 = u7:GetAttribute("MaxAge") or 1;
            local v19 = v17 / v18;
            for _, v20 in u8 do
                if not v20.part:GetAttribute("DontShow") then
                    local v21 = math.clamp((v19 - v20.partAge / v18) * v18, 0, 1);
                    if v21 > 0 then
                        local v22 = v20.maxSizeY * v21;
                        v20.part.Size = Vector3.new(v20.fullSize.X, v22, v20.fullSize.Z);
                        local v23 = v20.bottomCF * CFrame.new(0, v22 / 2, 0);
                        v20.part.CFrame = l__PrimaryPart__3.CFrame * CFrame.new(v23.Position) * v20.rotation;
                        v20.part.Transparency = v20.part:GetAttribute("OG_Transparency") or 0;
                        v20.part.CanCollide = true;
                        for _, v24 in v20.textures do
                            v24.obj.Transparency = v24.ogTransparency;
                        end;
                    else
                        v20.part.Transparency = 1;
                        v20.part.CanCollide = false;
                        for _, v25 in v20.textures do
                            v25.obj.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u7:GetAttributeChangedSignal("Age"):Connect(v26);
        v26();
    end,
    OnFullyGrown = function(p27) --[[ Name: OnFullyGrown, Line 107 ]]
        local v28 = p27:GetAttribute("CorePartName");
        if v28 then
            local v29 = p27:FindFirstChild(v28);
            local v30 = v29 and game.ServerStorage:FindFirstChild("Collect_PROX_Flower");
            if v30 then
                local v31 = v30:Clone();
                v31.Name = "ProximityPrompt";
                v31.Parent = v29;
            end;
        end;
        p27:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Pomegranate",
        Harvestable = true
    }
};