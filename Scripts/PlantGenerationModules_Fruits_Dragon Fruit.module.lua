-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
local function u6(p1, p2) --[[ Line: 3 ]]
    if p2 == 1 then
    else
        local v3 = p1:GetPivot();
        for _, v4 in p1:GetDescendants() do
            if v4:IsA("BasePart") then
                v4.Size = v4.Size * p2;
                local v5 = v3:ToObjectSpace(v4.CFrame);
                v4.CFrame = v3 * CFrame.new(v5.Position * p2) * v5.Rotation;
            elseif v4:IsA("Attachment") then
                v4.Position = v4.Position * p2;
            elseif v4:IsA("SpecialMesh") then
                v4.Scale = v4.Scale * p2;
                v4.Offset = v4.Offset * p2;
            elseif v4:IsA("Weld") or v4:IsA("Motor6D") then
                v4.C0 = CFrame.new(v4.C0.Position * p2) * v4.C0.Rotation;
                v4.C1 = CFrame.new(v4.C1.Position * p2) * v4.C1.Rotation;
            end;
        end;
    end;
end;
return {
    GrowData = {
        GrowRate = 0.0061,
        BaseWeight = 3,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p7, p8, p9) --[[ Name: InitFruit, Line 31 ]]
        -- upvalues: u6 (copy)
        game:GetService("MaterialService");
        local v10 = (p9 or 1) * 0.5 + 0.5;
        local v11 = v10 + v10 ^ 3 * 0.00001;
        local v12 = Random.new(p8);
        local _ = p7.Base;
        local v13, v14 = Color3.fromRGB(51, 136, 5);
        local v15, v16, v17 = v13:ToHSV();
        local v18 = v14 or 0.05;
        local v19 = v15 + v12:NextNumber(-v18, v18);
        local v20 = math.clamp(v19, 0, 0.99);
        Color3.fromHSV(v20, v16, v17);
        local v21 = p7["3"];
        local l__CFrame__1 = v21.CFrame;
        local l__Angles__2 = CFrame.Angles;
        local v22 = v12:NextNumber(-180, 180);
        v21.CFrame = l__CFrame__1 * l__Angles__2(0, math.rad(v22), 0);
        for v23 = 1, 4 do
            local v24 = v23 * 90;
            local v25 = p7["1"];
            local v26 = script.Leaf:Clone();
            v26.Parent = p7;
            local v27 = v25.CFrame * CFrame.Angles(0, math.rad(v24), 0) * CFrame.new(0, -v25.Size.Y * 0.35, -v25.Size.Z / 2.5);
            local l__Angles__3 = CFrame.Angles;
            local v28 = v12:NextNumber(45, 70);
            local v29 = math.rad(v28);
            local v30 = v12:NextNumber(-10, 10);
            v26:PivotTo(v27 * l__Angles__3(v29, 0, (math.rad(v30))));
            v26.Name = 2;
        end;
        for v31 = 1, 4 do
            local v32 = 90 * (v31 * v12:NextNumber(0.8, 1.2));
            local v33 = p7["2"];
            local v34 = script.SmallLeaf:Clone();
            v34.Parent = p7;
            local v35 = v33.CFrame * CFrame.Angles(0, math.rad(v32), 0) * CFrame.new(0, v33.Size.Y * 0.4, -v33.Size.Z / 2.5);
            local l__Angles__4 = CFrame.Angles;
            local v36 = v12:NextNumber(15, 30);
            local v37 = math.rad(v36);
            local v38 = v12:NextNumber(-10, 10);
            v34:PivotTo(v35 * l__Angles__4(v37, 0, (math.rad(v38))));
            v34.Name = 3;
        end;
        local v39 = v12:NextInteger(2, 4);
        for v40 = 1, v39 do
            local v41 = script.SpikeLeaf:Clone();
            v41.Parent = p7;
            local v42 = 360 / v39 * (v40 * v12:NextNumber(0.8, 1.2));
            local v43 = p7["2"];
            v41.Name = 4;
            v41.Size = v41.Size * v12:NextNumber(0.7, 1.1);
            local v44 = v43.CFrame * CFrame.Angles(0, math.rad(v42), 0);
            local l__Angles__5 = CFrame.Angles;
            local v45 = v12:NextNumber(15, 25);
            v41.CFrame = v44 * l__Angles__5(math.rad(v45), 0, 0) * CFrame.new(0, v43.Size.Y / 2.25 + v41.Size.Y / 2, 0);
        end;
        u6(p7, v11);
        p7:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u46) --[[ Name: BeginFruitGrowth, Line 130 ]]
        local l__PrimaryPart__6 = u46.PrimaryPart;
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
                    centerOffset = l__PrimaryPart__6.CFrame:ToObjectSpace(v48.CFrame),
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
        local function v62() --[[ Line: 165 ]]
            -- upvalues: u46 (copy), u47 (copy), l__PrimaryPart__6 (copy)
            local v54 = u46:GetAttribute("Age") or 0;
            local v55 = u46:GetAttribute("MaxAge") or 1;
            local v56 = v54 / v55;
            for _, v57 in u47 do
                if not v57.part:GetAttribute("DontShow") then
                    local v58 = math.clamp((v56 - v57.partAge / v55) * v55, 0, 1);
                    if v58 > 0 then
                        local v59 = v57.maxSize * v58;
                        v57.part.Size = v59;
                        v57.part.CFrame = l__PrimaryPart__6.CFrame * v57.centerOffset * CFrame.new(0, -((v57.maxSize.Y - v59.Y) / 2), 0);
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
    OnFullyGrown = function(p63) --[[ Name: OnFullyGrown, Line 200 ]]
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