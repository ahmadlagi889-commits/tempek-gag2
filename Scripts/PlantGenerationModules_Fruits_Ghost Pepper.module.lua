-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0088,
        BaseWeight = 7.5,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, p3) --[[ Name: InitFruit, Line 13 ]]
        local u4 = Random.new(p2);
        local _ = p3 * 0.2;
        local v5 = {
            Color3.fromRGB(184, 41, 12),
            Color3.fromRGB(184, 62, 6),
            Color3.fromRGB(207, 28, 28),
            Color3.fromRGB(124, 37, 16)
        };
        local u6 = v5[u4:NextInteger(1, #v5)];
        local u7 = nil;
        local function v34(p8, p9) --[[ Line: 38 ]]
            -- upvalues: u4 (copy), u6 (copy), u7 (ref), u1 (copy)
            for v10 = 1, p9 do
                local v11 = script.Part:Clone();
                local v12 = math.clamp(2.5 - v10 * 0.1, 1, 10) * u4:NextNumber(0.9, 1.1);
                local l__Angles__1 = CFrame.Angles;
                local v13 = u4:NextNumber(5, 15);
                local v14 = math.rad(v13);
                local v15 = u4:NextNumber(-5, 5);
                local v16 = math.rad(v15);
                local v17 = u4:NextNumber(5, 15);
                local v18 = l__Angles__1(v14, v16, (math.rad(v17)));
                local v19, v20, v21 = u6:ToHSV();
                local v22 = 0.025 or 0.05;
                local v23 = (v19 + u4:NextNumber(-v22, v22)) % 1;
                v11.Color = Color3.fromHSV(v23, math.clamp(v20, 0, 1), (math.clamp(v21, 0, 1)));
                v11.Size = Vector3.new(v12, 1.5, v12);
                local v24;
                if u7 then
                    v24 = u7.Size.Y;
                    p8 = u7:GetPivot();
                else
                    v24 = 0;
                end;
                local v25 = 1.5 + u4:NextNumber(-0.5, 0.5);
                v11.CFrame = p8 * CFrame.new(0, v24 / 3, 0) * v18 * CFrame.new(0, v25 / 3, 0);
                v11.Name = v10 + 2;
                v11.Parent = u1;
                if v10 == math.floor(p9 / 2) then
                    local v26 = script.PixelGradient:Clone();
                    v26.Parent = v11;
                    v26.Enabled = true;
                end;
                if u7 then
                    local v27 = u7;
                    local v28 = u7:GetPivot();
                    local l__Angles__2 = CFrame.Angles;
                    local v29 = u4:NextInteger(-20, 20);
                    local v30 = math.rad(v29);
                    local v31 = u4:NextInteger(-20, 20);
                    local v32 = math.rad(v31);
                    local v33 = u4:NextInteger(-20, 20);
                    v27:PivotTo(v28 * l__Angles__2(v30, v32, (math.rad(v33))));
                end;
                v11:AddTag("GhostPepper");
                u7 = v11;
            end;
            u7 = nil;
        end;
        local v35 = u4:NextInteger(6, 10);
        while u4:NextInteger(1, 6) == 1 do
            v35 = v35 + 1;
        end;
        local v36 = u1["2"]:GetPivot();
        local l__Angles__3 = CFrame.Angles;
        local v37 = u4:NextInteger(1, 360);
        v34(v36 * l__Angles__3(0, math.rad(v37), 0), v35);
        u1:ScaleTo(p3);
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u38) --[[ Name: BeginFruitGrowth, Line 86 ]]
        local l__PrimaryPart__4 = u38.PrimaryPart;
        local u39 = {};
        for _, v40 in u38:GetDescendants() do
            local v41 = tonumber(v40.Name);
            if v40:IsA("BasePart") and v41 then
                local v42 = not v40:GetAttribute("DontShow");
                local v43 = {
                    part = v40,
                    maxSize = v40.Size,
                    centerOffset = l__PrimaryPart__4.CFrame:ToObjectSpace(v40.CFrame),
                    partAge = v41
                };
                table.insert(u39, v43);
                v40.CanCollide = false;
                if v42 then
                    v40.Transparency = 1;
                end;
            end;
        end;
        local function v50() --[[ Line: 107 ]]
            -- upvalues: u38 (copy), u39 (copy), l__PrimaryPart__4 (copy)
            local v44 = u38:GetAttribute("Age") or 0;
            local v45 = u38:GetAttribute("MaxAge") or 1;
            local v46 = v44 / v45;
            for _, v47 in u39 do
                if not v47.part:GetAttribute("DontShow") then
                    local v48 = math.clamp((v46 - v47.partAge / v45) * v45, 0, 1);
                    if v48 > 0 then
                        local v49 = v47.maxSize * v48;
                        v47.part.Size = v49;
                        v47.part.CFrame = l__PrimaryPart__4.CFrame * v47.centerOffset * CFrame.new(0, -((v47.maxSize.Y - v49.Y) / 2), 0);
                        v47.part.Transparency = v47.part:GetAttribute("OG_Transparency") or 0;
                        v47.part.CanCollide = true;
                    else
                        v47.part.Transparency = 1;
                        v47.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u38:GetAttributeChangedSignal("Age"):Connect(v50);
        v50();
    end,
    OnFullyGrown = function(p51) --[[ Name: OnFullyGrown, Line 139 ]]
        local v52 = p51:GetAttribute("CorePartName");
        if v52 then
            local v53 = p51:FindFirstChild(v52);
            local v54 = v53 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v54 then
                local v55 = v54:Clone();
                v55.Name = "ProximityPrompt";
                v55.Parent = v53;
            end;
        end;
        p51:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};