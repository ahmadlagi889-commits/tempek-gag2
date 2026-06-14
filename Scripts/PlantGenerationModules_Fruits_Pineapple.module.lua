-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.01,
        BaseWeight = 5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 8 ]]
        local v4 = Random.new(p2);
        local l__PrimaryPart__1 = p1.PrimaryPart;
        local v5 = (p3 or 1) - 0.25;
        p1["1"].Color = Color3.fromHSV(v4:NextInteger(125, 165) * 0.001, 1, 1);
        if v5 ~= 1 then
            local l__CFrame__2 = l__PrimaryPart__1.CFrame;
            for _, v6 in p1:GetDescendants() do
                if v6:IsA("BasePart") then
                    v6.Size = v6.Size * v5;
                    local v7 = l__CFrame__2:ToObjectSpace(v6.CFrame);
                    v6.CFrame = l__CFrame__2 * CFrame.new(v7.Position * v5) * v7.Rotation;
                end;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u8) --[[ Name: BeginFruitGrowth, Line 35 ]]
        local l__PrimaryPart__3 = u8.PrimaryPart;
        local u9 = {};
        for _, v10 in u8:GetDescendants() do
            local v11 = tonumber(v10.Name);
            if v10:IsA("BasePart") and v11 then
                local v12 = not v10:GetAttribute("DontShow");
                local v13 = l__PrimaryPart__3.CFrame:ToObjectSpace(v10.CFrame);
                local v14 = v13 * CFrame.new(0, -v10.Size.Y / 2, 0);
                local v15 = {};
                for _, v16 in v10:GetChildren() do
                    if v16:IsA("Texture") or v16:IsA("Decal") then
                        table.insert(v15, {
                            instance = v16,
                            originalTransparency = v16.Transparency
                        });
                        if v12 then
                            v16.Transparency = 1;
                        end;
                    end;
                end;
                local v17 = v10:GetAttribute("OG_Transparency");
                if v17 == nil then
                    v17 = v10.Transparency;
                end;
                local v18 = v10.Material == Enum.Material.Neon and 0.5 or v17;
                v10:SetAttribute("OG_Transparency", v18);
                table.insert(u9, {
                    part = v10,
                    maxSizeY = v10.Size.Y,
                    fullSize = v10.Size,
                    bottomCF = v14,
                    rotation = v13.Rotation,
                    partAge = v11,
                    originalTransparency = v18,
                    textures = v15
                });
                v10.CanCollide = false;
                if v12 then
                    v10.Transparency = 1;
                end;
            end;
        end;
        local function v28() --[[ Line: 84 ]]
            -- upvalues: u8 (copy), u9 (copy), l__PrimaryPart__3 (copy)
            local v19 = u8:GetAttribute("Age") or 0;
            local v20 = u8:GetAttribute("MaxAge") or 1;
            local v21 = v19 / v20;
            for _, v22 in u9 do
                if not v22.part:GetAttribute("DontShow") then
                    local v23 = math.clamp((v21 - v22.partAge / v20) * v20, 0, 1);
                    if v23 > 0 then
                        local v24 = v22.maxSizeY * v23;
                        v22.part.Size = Vector3.new(v22.fullSize.X, v24, v22.fullSize.Z);
                        local v25 = v22.bottomCF * CFrame.new(0, v24 / 2, 0);
                        v22.part.CFrame = l__PrimaryPart__3.CFrame * CFrame.new(v25.Position) * v22.rotation;
                        v22.part.Transparency = v22.originalTransparency;
                        v22.part.CanCollide = true;
                        for _, v26 in v22.textures do
                            v26.instance.Transparency = v26.originalTransparency;
                        end;
                    else
                        v22.part.Transparency = 1;
                        v22.part.CanCollide = false;
                        for _, v27 in v22.textures do
                            v27.instance.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u8:GetAttributeChangedSignal("Age"):Connect(v28);
        v28();
    end,
    Extras = {
        FruitType = "Sunflower",
        Harvestable = true
    }
};