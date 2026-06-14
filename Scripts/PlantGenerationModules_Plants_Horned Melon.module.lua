-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, _) --[[ Name: InitPlant, Line 11 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local u3 = Random.new(p2);
        local _ = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local function u10(p4, p5, p6) --[[ Line: 28 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v7 = Instance.new("Part");
            local v8 = p4 or "Studs";
            v7.Parent = u1;
            v7.TopSurface = Enum.SurfaceType[v8];
            v7.BackSurface = Enum.SurfaceType[v8];
            v7.FrontSurface = Enum.SurfaceType[v8];
            v7.BottomSurface = Enum.SurfaceType[v8];
            v7.LeftSurface = Enum.SurfaceType[v8];
            v7.RightSurface = Enum.SurfaceType[v8];
            v7.Anchored = true;
            v7.CanCollide = false;
            v7.Transparency = 1;
            if p6 then
                v7.Shape = Enum.PartType[p6];
            end;
            if p5 then
                v7.MaterialVariant = p5;
                local v9 = l__MaterialService__1:FindFirstChild(p5, true);
                if not v9 then
                    return v7;
                end;
                v7.Material = v9.BaseMaterial;
            end;
            return v7;
        end;
        local u11 = u1:WaitForChild("2");
        local v12, v13, v14 = Color3.fromRGB(101, 182, 79):ToHSV();
        local v15 = 0.03 or 0.05;
        local v16 = v12 + u3:NextNumber(-v15, v15);
        u11.Color = Color3.fromHSV(v16, v13, v14);
        local v17 = u3:NextNumber(1, 3);
        u11.Position = u11.Position + Vector3.new(0, v17 / 2, 0);
        u11.Size = u11.Size + Vector3.new(0, v17, 0);
        local _ = l__Base__2.CFrame;
        local v18 = u3:NextInteger(2, 4);
        local u19 = nil;
        local u20 = 3;
        while u3:NextInteger(1, 4) == 1 and v18 < 20 do
            v18 = v18 + 1;
        end;
        local function v74(p21, p22, p23) --[[ Line: 82 ]]
            -- upvalues: u3 (copy), u19 (ref), u11 (copy), u20 (ref), u1 (copy), u10 (copy)
            local v24 = p21:GetPivot() * CFrame.new(0, p21.Size.Y / 2, 0);
            for v25 = 1, p22 do
                local v26 = script.Stud_Part:Clone();
                local v27 = 1.5 + u3:NextNumber(-0.8, 1.3);
                local l__Angles__3 = CFrame.Angles;
                local v28 = u3:NextNumber(-25, 25);
                local v29 = math.rad(v28);
                local v30 = u3:NextNumber(-15, 15);
                local v31 = math.rad(v30);
                local v32 = u3:NextNumber(-25, 10);
                local v33 = l__Angles__3(v29, v31, (math.rad(v32)));
                local l__new__4 = CFrame.new;
                local l__Position__5 = v24.Position;
                local v34 = u3:NextNumber(-15, 15);
                local v35 = u3:NextNumber(-15, 15);
                l__new__4(l__Position__5 + Vector3.new(v34, v35, u3:NextNumber(-15, 15)));
                local v36, v37, v38 = Color3.fromRGB(101, 182, 79):ToHSV();
                local v39 = 0.03 or 0.05;
                local v40 = v36 + u3:NextNumber(-v39, v39);
                v26.Color = Color3.fromHSV(v40, v37, v38);
                v26.Size = Vector3.new(0.5299999713897705, v27, 0.5299999713897705);
                local v41 = 0;
                if v25 == 1 then
                    local l__Angles__6 = CFrame.Angles;
                    local v42 = u3:NextNumber(-5, 5);
                    local v43 = math.rad(v42);
                    local v44 = math.rad(p23);
                    local v45 = u3:NextNumber(-25, -15);
                    v33 = l__Angles__6(v43, v44, (math.rad(v45)));
                else
                    v41 = u19.Size.Y;
                    v24 = u19:GetPivot();
                    if math.ceil(p22 / 2.5) <= v25 then
                        local l__Angles__7 = CFrame.Angles;
                        local v46 = u3:NextNumber(-10, 10);
                        local v47 = math.rad(v46);
                        local v48 = u3:NextNumber(-30, -10);
                        v33 = l__Angles__7(v47, 0, (math.rad(v48)));
                    end;
                    if v25 > 5 then
                        local l__Angles__8 = CFrame.Angles;
                        local v49 = u3:NextNumber(-15, 15);
                        local v50 = math.rad(v49);
                        local v51 = u3:NextNumber(-15, 15);
                        local v52 = math.rad(v51);
                        local v53 = u3:NextNumber(-5, 15);
                        v33 = l__Angles__8(v50, v52, (math.rad(v53)));
                    end;
                end;
                v26.CFrame = v24 * CFrame.new(0, v41 / 2.1, 0) * v33 * CFrame.new(0, v27 / 2.1, 0);
                if u11.Position.Y > v26.Position.Y then
                    local v54 = v24 * CFrame.new(0, v41 / 2.1, 0);
                    local v55 = u3:NextNumber(-0.2, 0.2);
                    local l__Unit__9 = Vector3.new(v55, 1, u3:NextNumber(-0.2, 0.2)).Unit;
                    local _, v56, _ = v33:ToEulerAnglesYXZ();
                    v26.CFrame = v54 * (CFrame.new(Vector3.new(0, 0, 0), l__Unit__9) * CFrame.Angles(0, v56, 0)) * CFrame.new(0, v27 / 2.1, 0);
                end;
                v26.Name = u20;
                v26.Parent = u1;
                if u3:NextInteger(1, 6) == 1 then
                    local v57 = script.Flower:Clone();
                    local v58 = v26:GetPivot();
                    local l__Angles__10 = CFrame.Angles;
                    local v59 = u3:NextInteger(0, 360);
                    v57:PivotTo(v58 * l__Angles__10(0, math.rad(v59), 1.5707963267948966));
                    for _, v60 in v57:GetChildren() do
                        v60.Name = tonumber(v60.Name) + u20;
                        v60.Parent = u1;
                    end;
                end;
                if u3:NextInteger(1, 15) == 1 then
                    local v61 = script.Leaf:Clone();
                    local v62 = v26:GetPivot();
                    local l__Angles__11 = CFrame.Angles;
                    local v63 = u3:NextInteger(0, 360);
                    local v64 = math.rad(v63);
                    local v65 = u3:NextInteger(60, 120);
                    v61:PivotTo(v62 * l__Angles__11(0, v64, (math.rad(v65))));
                    for _, v66 in v61:GetChildren() do
                        v66.Name = tonumber(v66.Name) + u20;
                        v66.Parent = u1;
                    end;
                end;
                u20 = u20 + 1;
                u19 = v26;
            end;
            local v67 = script.Leaf:Clone();
            local v68 = u19:GetPivot();
            local l__Angles__12 = CFrame.Angles;
            local v69 = u3:NextInteger(0, 360);
            local v70 = math.rad(v69);
            local v71 = u3:NextInteger(60, 120);
            v67:PivotTo(v68 * l__Angles__12(0, v70, (math.rad(v71))));
            for _, v72 in v67:GetChildren() do
                v72.Name = tonumber(v72.Name) + tonumber(u19.Name);
                v72.Parent = u1;
            end;
            local v73 = u10();
            v73.Size = Vector3.new(1, 1, 1);
            v73.CFrame = u19:GetPivot() * CFrame.new(0, u19.Size.Y / 2, 0);
            v73.Orientation = Vector3.new(0, 0, 180);
            v73.Parent = u1.FruitSpawnLocations;
            u19 = nil;
        end;
        for v75 = 1, v18 do
            local v76 = u3:NextInteger(3, 6);
            while u3:NextInteger(1, 8) == 1 and v76 < 13 do
                v76 = v76 + 1;
            end;
            v74(u11, math.floor(v76), 360 / v18 * v75 + u3:NextInteger(-15, 15));
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u77) --[[ Name: BeginPlantGrowth, Line 200 ]]
        local l__PrimaryPart__13 = u77.PrimaryPart;
        local u78 = {};
        for _, v79 in u77:GetDescendants() do
            local v80 = tonumber(v79.Name);
            if v79:IsA("BasePart") and v80 then
                local v81 = {
                    v79,
                    v79.Size,
                    l__PrimaryPart__13.CFrame:ToObjectSpace(v79.CFrame),
                    v80
                };
                table.insert(u78, v81);
                v79.CanCollide = false;
                v79.Transparency = 1;
            end;
        end;
        local function v88() --[[ Line: 218 ]]
            -- upvalues: u77 (copy), u78 (copy), l__PrimaryPart__13 (copy)
            local v82 = u77:GetAttribute("Age") or 0;
            for _, v83 in u78 do
                local v84 = v83[1];
                local v85 = v83[2];
                local v86 = v83[3];
                local v87 = math.min(v82 - v83[4], 1);
                if v87 > 0 then
                    v84.Size = Vector3.new(v85.X, v85.Y * v87, v85.Z);
                    v84.CFrame = l__PrimaryPart__13.CFrame * v86 * CFrame.new(0, (v84.Size.Y - v85.Y) / 2, 0);
                    v84.Transparency = v84:GetAttribute("OG_Transparency") or 0;
                    v84.CanCollide = true;
                else
                    v84.Transparency = 1;
                    v84.CanCollide = false;
                end;
            end;
        end;
        u77:GetAttributeChangedSignal("Age"):Connect(v88);
        v88();
    end,
    Extras = {}
};