-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.03,
        BaseWeight = 1.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 13 ]]
        local v4 = Random.new(p2);
        local _ = p3 * 0.2;
        local l__PrimaryPart__1 = p1.PrimaryPart;
        local v5 = v4:NextNumber(3, 4);
        for v6 = 1, v5 do
            local v7 = script.Layer1:Clone();
            local v8 = l__PrimaryPart__1:GetPivot();
            local l__Angles__2 = CFrame.Angles;
            local v9 = 360 / v5 * v6 + v4:NextInteger(-15, 15);
            local v10 = v8 * l__Angles__2(0, math.rad(v9), 0);
            local l__Angles__3 = CFrame.Angles;
            local v11 = 177 + v4:NextInteger(-4, 4);
            v7:PivotTo(v10 * l__Angles__3(math.rad(v11), 0, 0));
            local v12 = v7["1"];
            v7:ScaleTo(v4:NextNumber(0.9, 1.1));
            v12.Name = tonumber(v12.Name) + v6;
            v12.Parent = p1;
            v7:Destroy();
        end;
        local v13 = v4:NextNumber(4, 5);
        for v14 = 1, v13 do
            local v15 = script.Layer2:Clone();
            local v16 = l__PrimaryPart__1:GetPivot();
            local l__Angles__4 = CFrame.Angles;
            local v17 = 360 / v13 * v14 + v4:NextInteger(-15, 15);
            local v18 = v16 * l__Angles__4(0, math.rad(v17), 0);
            local l__Angles__5 = CFrame.Angles;
            local v19 = 190 + v4:NextInteger(-4, 4);
            v15:PivotTo(v18 * l__Angles__5(math.rad(v19), 0, 0));
            local v20 = v15["1"];
            v15:ScaleTo(v4:NextNumber(0.9, 1.1));
            v20.Name = tonumber(v20.Name) + v14 + 1;
            v20.Parent = p1;
            v15:Destroy();
        end;
        local v21 = v4:NextNumber(5, 6);
        for v22 = 1, v21 do
            local v23 = script.Layer3:Clone();
            local v24 = l__PrimaryPart__1:GetPivot();
            local l__Angles__6 = CFrame.Angles;
            local v25 = 360 / v21 * v22 + v4:NextInteger(-15, 15);
            local v26 = v24 * l__Angles__6(0, math.rad(v25), 0);
            local l__Angles__7 = CFrame.Angles;
            local v27 = 205 + v4:NextInteger(-4, 4);
            v23:PivotTo(v26 * l__Angles__7(math.rad(v27), 0, 0));
            local v28 = v23["1"];
            v23:ScaleTo(v4:NextNumber(0.9, 1.1));
            v28.Name = tonumber(v28.Name) + v22 + 2;
            v28.Parent = p1;
            v23:Destroy();
        end;
        local v29 = v4:NextNumber(3, 4);
        for v30 = 1, v29 do
            local v31 = script.Layer4:Clone();
            local v32 = l__PrimaryPart__1:GetPivot();
            local l__Angles__8 = CFrame.Angles;
            local v33 = 360 / v29 * v30 + v4:NextInteger(-15, 15);
            local v34 = v32 * l__Angles__8(0, math.rad(v33), 0);
            local l__Angles__9 = CFrame.Angles;
            local v35 = 236 + v4:NextInteger(-4, 4);
            v31:PivotTo(v34 * l__Angles__9(math.rad(v35), 0, 0));
            local v36 = v31["1"];
            v31:ScaleTo(v4:NextNumber(0.8, 1));
            v36.Name = tonumber(v36.Name) + v30 + 3;
            v36.Parent = p1;
            v31:Destroy();
        end;
        local v37 = v4:NextNumber(3, 4);
        for v38 = 1, v37 do
            local v39 = script.Layer5:Clone();
            local v40 = l__PrimaryPart__1:GetPivot();
            local l__Angles__10 = CFrame.Angles;
            local v41 = 360 / v37 * v38 + v4:NextInteger(-15, 15);
            local v42 = v40 * l__Angles__10(0, math.rad(v41), 0);
            local l__Angles__11 = CFrame.Angles;
            local v43 = 255 + v4:NextInteger(-4, 4);
            v39:PivotTo(v42 * l__Angles__11(math.rad(v43), 0, 0));
            local v44 = v39["1"];
            v39:ScaleTo(v4:NextNumber(0.8, 1));
            v44.Name = tonumber(v44.Name) + v38 + 4;
            v44.Parent = p1;
            v39:Destroy();
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u45) --[[ Name: BeginFruitGrowth, Line 117 ]]
        local l__PrimaryPart__12 = u45.PrimaryPart;
        local u46 = {};
        for _, v47 in u45:GetDescendants() do
            local v48 = tonumber(v47.Name);
            if v47:IsA("BasePart") and v48 then
                local v49 = not v47:GetAttribute("DontShow");
                local v50 = {};
                for _, v51 in v47:GetChildren() do
                    if v51:IsA("Decal") or v51:IsA("Texture") then
                        table.insert(v50, {
                            decal = v51,
                            originalTransparency = v51.Transparency
                        });
                        if v49 then
                            v51.Transparency = 1;
                        end;
                    end;
                end;
                local v52 = {
                    part = v47,
                    maxSize = v47.Size,
                    centerOffset = l__PrimaryPart__12.CFrame:ToObjectSpace(v47.CFrame),
                    partAge = v48,
                    decals = v50
                };
                table.insert(u46, v52);
                v47.CanCollide = false;
                if v49 then
                    v47.Transparency = 1;
                end;
            end;
        end;
        local function v61() --[[ Line: 152 ]]
            -- upvalues: u45 (copy), u46 (copy), l__PrimaryPart__12 (copy)
            local v53 = u45:GetAttribute("Age") or 0;
            local v54 = u45:GetAttribute("MaxAge") or 1;
            local v55 = v53 / v54;
            for _, v56 in u46 do
                if not v56.part:GetAttribute("DontShow") then
                    local v57 = math.clamp((v55 - v56.partAge / v54) * v54, 0, 1);
                    if v57 > 0 then
                        local v58 = v56.maxSize * v57;
                        v56.part.Size = v58;
                        v56.part.CFrame = l__PrimaryPart__12.CFrame * v56.centerOffset * CFrame.new(0, -((v56.maxSize.Y - v58.Y) / 2), 0);
                        v56.part.Transparency = v56.part:GetAttribute("OG_Transparency") or 0;
                        v56.part.CanCollide = true;
                        for _, v59 in v56.decals do
                            v59.decal.Transparency = v59.originalTransparency + (1 - v59.originalTransparency) * (1 - v57);
                        end;
                    else
                        v56.part.Transparency = 1;
                        v56.part.CanCollide = false;
                        for _, v60 in v56.decals do
                            v60.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u45:GetAttributeChangedSignal("Age"):Connect(v61);
        v61();
    end,
    OnFullyGrown = function(p62) --[[ Name: OnFullyGrown, Line 187 ]]
        local v63 = p62:GetAttribute("CorePartName");
        if v63 then
            local v64 = p62:FindFirstChild(v63);
            local v65 = v64 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v65 then
                local v66 = v65:Clone();
                v66.Name = "ProximityPrompt";
                v66.Parent = v64;
            end;
        end;
        p62:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};