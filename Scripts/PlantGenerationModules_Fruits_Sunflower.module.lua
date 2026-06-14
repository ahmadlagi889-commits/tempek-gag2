-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.0061,
        BaseWeight = 6,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 9 ]]
        local v4 = Random.new(p2);
        local v5 = Color3.fromRGB(221, 126, 57);
        local v6 = Color3.fromRGB(246, 178, 10);
        local v7, v8, v9 = v5:ToHSV();
        local v10 = 0.02 or 0.05;
        local v11 = v7 + v4:NextNumber(-v10, v10);
        local v12 = math.clamp(v11, 0.01, 0.99);
        local v13 = Color3.fromHSV(v12, v8, v9);
        local v14, v15, v16 = v6:ToHSV();
        local v17 = 0.02 or 0.05;
        local v18 = v14 + v4:NextNumber(-v17, v17);
        local v19 = math.clamp(v18, 0.01, 0.99);
        local v20 = Color3.fromHSV(v19, v15, v16);
        local l__Middle__1 = p1.Middle;
        local v21 = l__Middle__1:GetPivot();
        local l__Angles__2 = CFrame.Angles;
        local v22 = v4:NextNumber(-180, 180);
        l__Middle__1:PivotTo(v21 * l__Angles__2(0, math.rad(v22), 0));
        local v23 = 0 + 1;
        l__Middle__1.Name = tostring(v23);
        local v24 = { p1:FindFirstChild("3"), p1:FindFirstChild("4") };
        local v25 = v24[2];
        for _, v26 in v24 do
            if v26 then
                local l__CFrame__3 = v26.CFrame;
                local l__Angles__4 = CFrame.Angles;
                local v27 = v4:NextNumber(-30, 30);
                v26.CFrame = l__CFrame__3 * l__Angles__4(0, math.rad(v27), 0);
                v23 = v23 + 1;
                v26.Name = tostring(v23);
            end;
        end;
        local l__Petal__5 = script.Petal;
        local v28 = v4:NextInteger(6, 8);
        local v29 = {};
        for v30 = 1, v28 do
            local v31 = l__Petal__5:Clone();
            local v32 = v25.CFrame * CFrame.Angles(0, math.rad(360 / v28 * v30), 0);
            local l__Angles__6 = CFrame.Angles;
            local v33 = v4:NextNumber(75, 110);
            v31:PivotTo(v32 * l__Angles__6(math.rad(v33), 0, 0) * CFrame.new(0, v25.Size.X / 2, 0));
            local l__TopPetal__7 = v31.TopPetal;
            local v34 = v31.TopPetal:GetPivot();
            local l__Angles__8 = CFrame.Angles;
            local v35 = v4:NextNumber(-25, 25);
            l__TopPetal__7:PivotTo(v34 * l__Angles__8(math.rad(v35), 0, 0));
            local v36 = v31:GetPivot();
            local v37 = {};
            for _, v38 in v31:GetDescendants() do
                if v38:IsA("BasePart") then
                    local v39 = {
                        part = v38,
                        dist = v36:ToObjectSpace(v38.CFrame).Position.Magnitude
                    };
                    table.insert(v37, v39);
                end;
            end;
            table.sort(v37, function(p40, p41) --[[ Line: 93 ]]
                return p40.dist < p41.dist;
            end);
            for v42, v43 in v37 do
                if not v29[v42] then
                    v29[v42] = {};
                end;
                v43.part.Parent = p1;
                table.insert(v29[v42], v43.part);
            end;
            v31:Destroy();
        end;
        for v44 = 1, #v29 do
            v23 = v23 + 1;
            for _, v45 in v29[v44] do
                v45.Name = tostring(v23);
            end;
        end;
        for _, v46 in p1:GetDescendants() do
            if v46:IsA("BasePart") then
                if v46.Color == Color3.fromRGB(246, 178, 10) then
                    v46.Color = v20;
                elseif v46.Color == Color3.fromRGB(221, 126, 57) then
                    v46.Color = v13;
                end;
                if v46.Parent ~= p1 then
                    v46.Parent = p1;
                end;
            end;
        end;
        local v47 = p3 * 0.5 + 0.5;
        p1:ScaleTo(v47 + v47 ^ 3 * 0.00005);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u48) --[[ Name: BeginFruitGrowth, Line 144 ]]
        local l__PrimaryPart__9 = u48.PrimaryPart;
        local u49 = {};
        for _, v50 in u48:GetDescendants() do
            local v51 = tonumber(v50.Name);
            if v50:IsA("BasePart") and v51 then
                local v52 = not v50:GetAttribute("DontShow");
                local v53 = l__PrimaryPart__9.CFrame:ToObjectSpace(v50.CFrame);
                local v54 = v53 * CFrame.new(0, -v50.Size.Y / 2, 0);
                table.insert(u49, {
                    part = v50,
                    maxSizeY = v50.Size.Y,
                    fullSize = v50.Size,
                    bottomCF = v54,
                    rotation = v53.Rotation,
                    partAge = v51
                });
                v50.CanCollide = false;
                if v52 then
                    v50.Transparency = 1;
                end;
            end;
        end;
        local function v62() --[[ Line: 177 ]]
            -- upvalues: u48 (copy), u49 (copy), l__PrimaryPart__9 (copy)
            local v55 = u48:GetAttribute("Age") or 0;
            local v56 = u48:GetAttribute("MaxAge") or 1;
            local v57 = v55 / v56;
            for _, v58 in u49 do
                if not v58.part:GetAttribute("DontShow") then
                    local v59 = math.clamp((v57 - v58.partAge / v56) * v56, 0, 1);
                    if v59 > 0 then
                        local v60 = v58.maxSizeY * v59;
                        v58.part.Size = Vector3.new(v58.fullSize.X, v60, v58.fullSize.Z);
                        local v61 = v58.bottomCF * CFrame.new(0, v60 / 2, 0);
                        v58.part.CFrame = l__PrimaryPart__9.CFrame * CFrame.new(v61.Position) * v58.rotation;
                        v58.part.Transparency = v58.part:GetAttribute("OG_Transparency") or 0;
                        v58.part.CanCollide = true;
                    else
                        v58.part.Transparency = 1;
                        v58.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u48:GetAttributeChangedSignal("Age"):Connect(v62);
        v62();
    end,
    OnFullyGrown = function(p63) --[[ Name: OnFullyGrown, Line 215 ]]
        local v64 = p63:GetAttribute("CorePartName");
        if v64 then
            local v65 = p63:FindFirstChild(v64);
            local v66 = v65 and game.ServerStorage:FindFirstChild("Collect_PROX_Flower");
            if v66 then
                local v67 = v66:Clone();
                v67.Name = "ProximityPrompt";
                v67.Parent = v65;
            end;
        end;
        p63:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Sunflower",
        Harvestable = true
    }
};