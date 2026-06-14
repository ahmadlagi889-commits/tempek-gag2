-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        GrowRate = 0.031,
        BaseWeight = 3,
        GrowTickTime = NumberRange.new(4.8, 6)
    },
    InitFruit = function(u1, p2, p3) --[[ Name: InitFruit, Line 8 ]]
        local v4 = Random.new(p2);
        local l__Stud_Part__1 = script.Stud_Part;
        local v5 = 1 * (p3 * 0.5 + 0.5);
        local v6 = 1 + p3 * 0.25;
        local v7 = Color3.new(0.654902, 0.47451, 0.294118);
        local v8 = l__Stud_Part__1:Clone();
        v8.Size = Vector3.new(v5, v6, v5);
        v8.CFrame = u1.PrimaryPart.CFrame * CFrame.new(0, -(u1.PrimaryPart.Size.Y / 2 + v8.Size.Y / 2), 0);
        local u9 = 0 + 1;
        v8.Color = v7;
        v8.Name = tostring(u9);
        v8.Parent = u1;
        local v10 = 1.5 + p3;
        local v11 = 0.75 * (p3 * 0.5 + 0.5);
        local v12 = 10 + (p3 * 0.1 - 0.9);
        local v13 = v10 * 0.4;
        local v14 = v10 * 1.35;
        local v15 = v10 * 0.95;
        local v16 = 1 * v12;
        local v17 = v4:NextNumber();
        local v18, v19;
        if v17 < 1e-7 then
            v18 = 0.92;
            v19 = 0.92;
        elseif v17 < 0.00001 then
            v18 = 0.6;
            v19 = 0.6;
        else
            local v20 = v4:NextNumber();
            if v20 < 0.6 then
                v18 = 0;
                v19 = 0.083;
            elseif v20 < 0.8 then
                v18 = 0.083;
                v19 = 0.166;
            elseif v20 < 0.95 then
                v18 = 0.166;
                v19 = 0.25;
            else
                v18 = 0.25;
                v19 = 0.333;
            end;
            local v21 = v4:NextInteger(1, 3);
            if v21 == 1 then
                local v22 = v19;
                v19 = v18;
                v18 = v22;
            elseif v21 ~= 2 then
                v18 = (v18 + v19) * 0.5;
                v19 = v18;
            end;
        end;
        local l__CFrame__2 = v8.CFrame;
        local l__Size__3 = v8.Size;
        for v23 = 1, v16 do
            local v24 = v23 / v16;
            local v25;
            if v24 <= 0.65 then
                v25 = v13 + (v14 - v13) * math.sin(v24 / 0.65 * 3.141592653589793 * 0.5);
            else
                local v26 = (v24 - 0.65) / 0.35;
                v25 = v14 - (v14 - v15) * (v26 * v26);
            end;
            local v27 = v11 * (0.3 + 0.6 * ((v25 - v13) / (v14 - v13)));
            local v28 = v19 + (v18 - v19) * v24;
            local v29 = l__Stud_Part__1:Clone();
            v29.Color = Color3.fromHSV(v28, 1, 1);
            v29.Size = Vector3.new(v25, v27, v25);
            u9 = u9 + 1;
            v29.Name = tostring(u9);
            v29.CFrame = l__CFrame__2 * CFrame.new(0, -(l__Size__3.Y / 2 + v29.Size.Y / 2), 0);
            v29.Parent = u1;
            l__CFrame__2 = v29.CFrame;
            l__Size__3 = v29.Size;
        end;
        local function v33(p30) --[[ Line: 115 ]]
            -- upvalues: u9 (ref), l__Stud_Part__1 (copy), u1 (copy)
            u9 = u9 + 1;
            local v31 = l__Stud_Part__1:Clone();
            v31.Size = Vector3.new(p30.Size.Z, p30.Size.Y * 0.5, p30.Size.X / 2);
            v31.Shape = Enum.PartType.Wedge;
            v31.CFrame = p30.CFrame * CFrame.new(-p30.Size.X / 4, -(p30.Size.Y / 2 + v31.Size.Y / 2), 0);
            v31.Parent = u1;
            v31.Color = p30.Color;
            v31.CFrame = v31.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
            v31.CFrame = v31.CFrame * CFrame.Angles(0, 0, 3.141592653589793);
            v31.Name = tostring(u9);
            local v32 = l__Stud_Part__1:Clone();
            v32.Size = Vector3.new(p30.Size.Z, p30.Size.Y * 0.5, p30.Size.X / 2);
            v32.Shape = Enum.PartType.Wedge;
            v32.CFrame = p30.CFrame * CFrame.new(p30.Size.X / 4, -(p30.Size.Y / 2 + v32.Size.Y / 2), 0);
            v32.Parent = u1;
            v32.Color = p30.Color;
            v32.CFrame = v32.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);
            v32.CFrame = v32.CFrame * CFrame.Angles(0, 0, 3.141592653589793);
            v32.Name = tostring(u9);
        end;
        local v34 = l__Stud_Part__1:Clone();
        local v35 = 3 + (p3 * 0.5 + 0.5);
        v34.Size = Vector3.new(v35, v35, v35 * 0.25);
        v34.CFrame = v8.CFrame * CFrame.new(0, v8.Size.Y / 2, 0);
        local l__CFrame__4 = v34.CFrame;
        local l__Angles__5 = CFrame.Angles;
        local v36 = v4:NextInteger(-180, 180);
        v34.CFrame = l__CFrame__4 * l__Angles__5(0, math.rad(v36), 0);
        local l__CFrame__6 = v34.CFrame;
        local l__Angles__7 = CFrame.Angles;
        local v37 = v4:NextInteger(47, 56);
        v34.CFrame = l__CFrame__6 * l__Angles__7(math.rad(v37), 0, 0);
        v34.CFrame = v34.CFrame * CFrame.new(0, -(v34.Size.Y / 2), 0);
        v34.Color = Color3.fromHSV(0.333333, 1, 0.666667);
        local v38 = u9 + 1;
        v34.Name = tostring(v38);
        v34.Parent = u1;
        v33(v34);
        u1:ScaleTo(p3 * 0.1 + 0.9);
        u1:AddTag("InitializationComplete");
    end,
    BeginFruitGrowth = function(u39) --[[ Name: BeginFruitGrowth, Line 163 ]]
        local l__PrimaryPart__8 = u39.PrimaryPart;
        local u40 = {};
        for _, v41 in u39:GetDescendants() do
            local v42 = tonumber(v41.Name);
            if v41:IsA("BasePart") and v42 then
                local v43 = not v41:GetAttribute("DontShow");
                local v44 = {
                    part = v41,
                    maxSize = v41.Size,
                    centerOffset = l__PrimaryPart__8.CFrame:ToObjectSpace(v41.CFrame),
                    partAge = v42
                };
                table.insert(u40, v44);
                v41.CanCollide = false;
                if v43 then
                    v41.Transparency = 1;
                end;
            end;
        end;
        local function v51() --[[ Line: 186 ]]
            -- upvalues: u39 (copy), u40 (copy), l__PrimaryPart__8 (copy)
            local v45 = u39:GetAttribute("Age") or 0;
            local v46 = u39:GetAttribute("MaxAge") or 1;
            local v47 = v45 / v46;
            for _, v48 in u40 do
                if not v48.part:GetAttribute("DontShow") then
                    local v49 = math.clamp((v47 - v48.partAge / v46) * v46, 0, 1);
                    if v49 > 0 then
                        v48.part.Size = v48.maxSize * v49;
                        local v50 = CFrame.new(0, v48.maxSize.Y / 2 * (1 - v49), 0);
                        v48.part.CFrame = l__PrimaryPart__8.CFrame * v48.centerOffset * v50;
                        v48.part.Transparency = v48.part:GetAttribute("OG_Transparency") or 0;
                        v48.part.CanCollide = true;
                    else
                        v48.part.Transparency = 1;
                        v48.part.CanCollide = false;
                    end;
                end;
            end;
        end;
        u39:GetAttributeChangedSignal("Age"):Connect(v51);
        v51();
    end,
    OnFullyGrown = function(p52) --[[ Name: OnFullyGrown, Line 218 ]]
        local v53 = p52:GetAttribute("CorePartName");
        if v53 then
            local v54 = p52:FindFirstChild(v53);
            local v55 = v54 and game.ServerStorage:FindFirstChild("Collect_PROX_Apple");
            if v55 then
                local v56 = v55:Clone();
                v56.Name = "ProximityPrompt";
                v56.Parent = v54;
            end;
        end;
        p52:AddTag("PlantGenerated");
    end,
    Extras = {
        FruitType = "Apple",
        Harvestable = true
    }
};