-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        GrowRate = 0.0333,
        BaseWeight = 1.125,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(p1, p2, p3) --[[ Name: InitFruit, Line 13 ]]
        local v4 = Random.new(p2);
        local v5 = p3 * 0.2;
        local v6 = v4:NextNumber(0.1, 1);
        while v4:NextInteger(1, 7) == 1 do
            v6 = v6 + 0.12;
        end;
        local _ = v6 / 2;
        for _, v7 in p1:GetChildren() do
            if v7:GetAttribute("Offset") then
                v7.CFrame = v7.CFrame * CFrame.new(0, v6, 0);
            end;
            if v7:GetAttribute("Scale") then
                v7.Size = v7.Size + Vector3.new(0, v6, 0);
                v7.CFrame = v7.CFrame * CFrame.new(0, v5, 0);
            end;
        end;
        local v8 = p1:WaitForChild("3"):GetPivot();
        local l__Y__1 = p1:WaitForChild("3").Size.Y;
        local v9 = script.SideSpikes:Clone();
        local l__Angles__2 = CFrame.Angles;
        local v10 = 90 * v4:NextInteger(0, 3);
        v9:PivotTo(v8 * l__Angles__2(0, math.rad(v10), 0));
        for _, v11 in v9:GetChildren() do
            v11.Parent = p1;
        end;
        v9:Destroy();
        local v12 = script.SideSpikes:Clone();
        local l__Angles__3 = CFrame.Angles;
        local v13 = 90 * v4:NextInteger(0, 3);
        v12:PivotTo(v8 * l__Angles__3(0, math.rad(v13), 0) * CFrame.new(0, l__Y__1 / 2.5, 0));
        for _, v14 in v12:GetChildren() do
            v14.Parent = p1;
        end;
        v12:Destroy();
        local v15 = script.SideSpikes:Clone();
        local l__Angles__4 = CFrame.Angles;
        local v16 = 90 * v4:NextInteger(0, 3);
        v15:PivotTo(v8 * l__Angles__4(0, math.rad(v16), 0) * CFrame.new(0, -l__Y__1 / 2.5, 0));
        for _, v17 in v15:GetChildren() do
            v17.Parent = p1;
        end;
        v15:Destroy();
        p1:ScaleTo(p3);
        p1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u18) --[[ Name: BeginFruitGrowth, Line 59 ]]
        local l__PrimaryPart__5 = u18.PrimaryPart;
        local u19 = {};
        for _, v20 in u18:GetDescendants() do
            local v21 = tonumber(v20.Name);
            if v20:IsA("BasePart") and v21 then
                local v22 = not v20:GetAttribute("DontShow");
                local v23 = {
                    part = v20,
                    maxSize = v20.Size,
                    centerOffset = l__PrimaryPart__5.CFrame:ToObjectSpace(v20.CFrame),
                    partAge = v21
                };
                table.insert(u19, v23);
                v20.CanCollide = false;
                if v22 then
                    v20.Transparency = 1;
                end;
            end;
        end;
        local function v30() --[[ Line: 80 ]]
            -- upvalues: u18 (copy), u19 (copy), l__PrimaryPart__5 (copy)
            local v24 = u18:GetAttribute("Age") or 0;
            local v25 = u18:GetAttribute("MaxAge") or 1;
            local v26 = v24 / v25;
            for _, v27 in u19 do
                if not v27.part:GetAttribute("DontShow") then
                    local v28 = math.clamp((v26 - v27.partAge / v25) * v25, 0, 1);
                    if v28 > 0 then
                        local v29 = v27.maxSize * v28;
                        v27.part.Size = v29;
                        v27.part.CFrame = l__PrimaryPart__5.CFrame * v27.centerOffset * CFrame.new(0, -((v27.maxSize.Y - v29.Y) / 2), 0);
                        v27.part.Transparency = v27.part:GetAttribute("OG_Transparency") or 0;
                        v27.part.CanCollide = true;
                    else
                        v27.part.Transparency = 1;
                        v27.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u18:GetAttributeChangedSignal("Age"):Connect(v30);
        v30();
    end,
    OnFullyGrown = function(p31) --[[ Name: OnFullyGrown, Line 112 ]]
        local v32 = p31:GetAttribute("CorePartName");
        if v32 then
            local v33 = p31:FindFirstChild(v32);
            local v34 = v33 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v34 then
                local v35 = v34:Clone();
                v35.Name = "ProximityPrompt";
                v35.Parent = v33;
            end;
        end;
        p31:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Acorn",
        Harvestable = true
    }
};