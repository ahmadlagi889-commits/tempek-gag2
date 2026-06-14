-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 11 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local v4 = (p3 or 1) + 1;
        local u5 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local _ = u1.Base;
        local u6 = 1 * v4;
        local u7 = 0.35 * v4;
        local v8 = u5:NextInteger(5, 7);
        local function v37(p9) --[[ Line: 62 ]]
            -- upvalues: u1 (copy), u6 (copy), u7 (copy), u5 (copy), l__FruitSpawnLocations__2 (copy)
            local l__Segment__3 = u1.Segment;
            l__Segment__3:ScaleTo(u6);
            local v10 = l__Segment__3;
            for v11 = 1, p9 do
                local v12 = math.lerp(u6, u7, v11 / p9);
                local v13 = l__Segment__3:Clone();
                v13:ScaleTo(v12);
                local l__Y__4 = v10:FindFirstChildWhichIsA("Part").Size.Y;
                v13:PivotTo(v10:GetPivot() * CFrame.new(0, l__Y__4, 0));
                local v14 = v13:GetPivot();
                local l__Angles__5 = CFrame.Angles;
                local v15 = u5:NextInteger(-15, 15);
                local v16 = math.rad(v15);
                local v17 = u5:NextInteger(-15, 15);
                local v18 = math.rad(v17);
                local v19 = u5:NextInteger(-15, 15);
                v13:PivotTo(v14 * l__Angles__5(v16, v18, (math.rad(v19))));
                v13.Parent = u1;
                for _, v20 in v13:GetDescendants() do
                    if v20.Name == "3" and u5:NextInteger(1, 2) == 1 then
                        v20.Color = Color3.fromRGB(79, 186, 37);
                    end;
                    if v20:IsA("Model") then
                        local v21 = v20:GetPivot();
                        local l__Angles__6 = CFrame.Angles;
                        local v22 = u5:NextInteger(-10, 10);
                        local v23 = math.rad(v22);
                        local v24 = u5:NextInteger(-10, 10);
                        local v25 = math.rad(v24);
                        local v26 = u5:NextInteger(-10, 10);
                        v20:PivotTo(v21 * l__Angles__6(v23, v25, (math.rad(v26))));
                    end;
                end;
                for _, v27 in v13:GetDescendants() do
                    if tonumber(v27.Name) then
                        v27.Name = tonumber(v27.Name) + v11;
                    end;
                end;
                for _, v28 in pairs(v13:GetDescendants()) do
                    if v28.Name == "Spawn" then
                        v28.Parent = l__FruitSpawnLocations__2;
                    end;
                end;
                v10 = v13;
            end;
            local l__top__7 = u1.top;
            l__top__7:PivotTo(v10:GetPivot() * CFrame.new(0, v10:FindFirstChildWhichIsA("Part").Size.Y, 0));
            l__top__7:ScaleTo(v10:GetScale() * 2);
            for _, v29 in l__top__7:GetDescendants() do
                if v29.Name == "2" and u5:NextInteger(1, 2) == 1 then
                    v29.Color = Color3.fromRGB(79, 186, 37);
                end;
                if v29:IsA("Model") then
                    local v30 = v29:GetPivot();
                    local l__Angles__8 = CFrame.Angles;
                    local v31 = u5:NextInteger(-10, 10);
                    local v32 = math.rad(v31);
                    local v33 = u5:NextInteger(-10, 10);
                    local v34 = math.rad(v33);
                    local v35 = u5:NextInteger(-10, 10);
                    v29:PivotTo(v30 * l__Angles__8(v32, v34, (math.rad(v35))));
                end;
            end;
            for _, v36 in l__top__7:GetDescendants() do
                if tonumber(v36.Name) then
                    v36.Name = tonumber(v36.Name) + p9 + 1;
                end;
            end;
        end;
        while u5:NextInteger(1, 100) == 1 do
            v8 = v8 * 2;
        end;
        local v38 = v8 * math.clamp(v4 / 2, 1, 100);
        local v39 = math.clamp(v38, 0.5, 100);
        v37((math.floor(v39)));
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u40) --[[ Name: BeginPlantGrowth, Line 144 ]]
        local l__PrimaryPart__9 = u40.PrimaryPart;
        local u41 = {};
        for _, v42 in u40:GetDescendants() do
            local v43 = tonumber(v42.Name);
            if v42:IsA("BasePart") and v43 then
                local v44 = {};
                for _, v45 in v42:GetChildren() do
                    if v45:IsA("Decal") then
                        table.insert(v44, { v45, v45.Transparency });
                        v45.Transparency = 1;
                    end;
                end;
                local v46 = {
                    v42,
                    v42.Size,
                    l__PrimaryPart__9.CFrame:ToObjectSpace(v42.CFrame),
                    v43,
                    v44
                };
                table.insert(u41, v46);
                v42.CanCollide = false;
                v42.Transparency = 1;
            end;
        end;
        local function v57() --[[ Line: 172 ]]
            -- upvalues: u40 (copy), u41 (copy), l__PrimaryPart__9 (copy)
            local v47 = u40:GetAttribute("Age") or 0;
            for _, v48 in u41 do
                local v49 = v48[1];
                local v50 = v48[2];
                local v51 = v48[3];
                local v52 = v48[4];
                local v53 = v48[5];
                local v54 = math.min(v47 - v52, 1);
                if v54 > 0 then
                    v49.Size = Vector3.new(v50.X, v50.Y * v54, v50.Z);
                    v49.CFrame = l__PrimaryPart__9.CFrame * v51 * CFrame.new(0, (v49.Size.Y - v50.Y) / 2, 0);
                    v49.Transparency = v49:GetAttribute("OG_Transparency") or 0;
                    v49.CanCollide = true;
                else
                    v49.Transparency = 1;
                    v49.CanCollide = false;
                end;
                local v55 = v54 >= 1;
                for _, v56 in v53 do
                    v56[1].Transparency = v55 and v56[2] or 1;
                end;
            end;
        end;
        u40:GetAttributeChangedSignal("Age"):Connect(v57);
        v57();
    end,
    Extras = {}
};