-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 11 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local u4 = p3 or 1;
        local u5 = Random.new(p2);
        local _ = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local function v12(p6, p7, p8) --[[ Line: 26 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v9 = Instance.new("Part");
            local v10 = p6 or "Studs";
            v9.Parent = u1;
            v9.TopSurface = Enum.SurfaceType[v10];
            v9.BackSurface = Enum.SurfaceType[v10];
            v9.FrontSurface = Enum.SurfaceType[v10];
            v9.BottomSurface = Enum.SurfaceType[v10];
            v9.LeftSurface = Enum.SurfaceType[v10];
            v9.RightSurface = Enum.SurfaceType[v10];
            v9.Anchored = true;
            v9.CanCollide = false;
            v9.Transparency = 1;
            if p8 then
                v9.Shape = Enum.PartType[p8];
            end;
            if p7 then
                v9.MaterialVariant = p7;
                local v11 = l__MaterialService__1:FindFirstChild(p7, true);
                if not v11 then
                    return v9;
                end;
                v9.Material = v11.BaseMaterial;
            end;
            return v9;
        end;
        local v13 = u5:NextInteger(1, 2) * (u4 * 0.5 + 0.5);
        local v14 = u5:NextInteger(3, 5) * (u4 * 0.5 + 0.5);
        local v15 = u5:NextInteger(4, 8);
        local v16 = 3;
        while u5:NextInteger(1, (math.round(50 / u4))) == 1 do
            v15 = v15 * u5:NextInteger(2, 3);
            v16 = v16 * u5:NextInteger(2, 3);
            while u5:NextInteger(1, 2) == 1 do
                v13 = v13 * 1.5;
                v14 = v14 * 1.5;
            end;
        end;
        local u17 = Vector3.new(v13, v14, v13);
        local _ = l__Base__2.CFrame;
        local u18 = 1;
        local u19 = nil;
        local u20 = 0;
        local u21 = {};
        local u22 = {};
        local function v75(p23, p24, p25) --[[ Line: 85 ]]
            -- upvalues: u17 (copy), u19 (ref), u5 (copy), u20 (ref), u18 (ref), u1 (copy), u21 (copy), u22 (copy), u4 (ref)
            local v26 = p23:GetPivot();
            for v27 = 1, p24 do
                local v28 = script.Stud_Part:Clone();
                local v29 = math.clamp(u17.X - v27 * 0.015, 1, 10);
                if u19 then
                    v29 = math.clamp(u19.Size.X - v27 * 0.03, 1, 10);
                elseif p25 == nil then
                    v29 = math.clamp(p23.Size.X - v27 * 0.03, 1, 10);
                end;
                local v30;
                if p25 then
                    v30 = u17.Y + u5:NextNumber(-3.4, 3);
                else
                    v30 = u17.Y + u5:NextNumber(-3.4, 1.5);
                end;
                local l__Angles__3 = CFrame.Angles;
                local v31 = u5:NextNumber(-15, 15);
                local v32 = math.rad(v31);
                local v33 = u5:NextNumber(-20, 20);
                local v34 = math.rad(v33);
                local v35 = u5:NextNumber(-15, 15);
                local v36 = l__Angles__3(v32, v34, (math.rad(v35)));
                local l__new__4 = CFrame.new;
                local l__Position__5 = v26.Position;
                local v37 = u5:NextNumber(-15, 15);
                local v38 = u5:NextNumber(-15, 15);
                l__new__4(l__Position__5 + Vector3.new(v37, v38, u5:NextNumber(-15, 15)));
                local v39, v40, v41 = Color3.fromRGB(101, 165, 38):ToHSV();
                local v42 = 0.03 or 0.05;
                local v43 = v39 + u5:NextNumber(-v42, v42);
                v28.Color = Color3.fromHSV(v43, v40, v41);
                v28.Size = Vector3.new(v29, v30, v29);
                local v44 = 0;
                if u19 then
                    v44 = u19.Size.Y;
                    v26 = u19:GetPivot();
                    if v27 == math.ceil(p24 / 2) then
                        local l__Angles__6 = CFrame.Angles;
                        local v45 = u5:NextNumber(-15, 15);
                        local v46 = math.rad(v45);
                        local v47 = u5:NextNumber(20, 20);
                        local v48 = math.rad(v47);
                        local v49 = u5:NextNumber(-15, 15);
                        v36 = l__Angles__6(v46, v48, (math.rad(v49)));
                    end;
                else
                    local l__Angles__7 = CFrame.Angles;
                    local v50 = u5:NextNumber(-45, 45);
                    local v51 = math.rad(v50);
                    local v52 = u5:NextNumber(0, 360);
                    local v53 = math.rad(v52);
                    local v54 = u5:NextNumber(-45, 45);
                    v36 = l__Angles__7(v51, v53, (math.rad(v54)));
                end;
                if p25 then
                    local l__Angles__8 = CFrame.Angles;
                    local v55 = u5:NextNumber(-3, 3);
                    local v56 = math.rad(v55);
                    local v57 = u5:NextNumber(3, 3);
                    local v58 = math.rad(v57);
                    local v59 = u5:NextNumber(-3, 3);
                    v36 = l__Angles__8(v56, v58, (math.rad(v59)));
                    u20 = u20 + 1;
                end;
                v28.CFrame = v26 * CFrame.new(0, v44 / 2.1, 0) * v36 * CFrame.new(0, v30 / 2.1, 0);
                v28.Name = u18;
                v28.Parent = u1;
                u18 = u18 + 1;
                if p24 - 2 <= v27 then
                    table.insert(u21, v28);
                elseif u18 < p24 * 0.85 then
                    table.insert(u22, v28);
                end;
                if v27 == p24 then
                    local v60 = u5:NextNumber(2, 4);
                    for v61 = 1, v60 do
                        local v62 = script.Leaf:Clone();
                        local v63 = v28:GetPivot() * CFrame.new(0, v28.Size.Y / 2, 0);
                        local l__Angles__9 = CFrame.Angles;
                        local v64 = u5:NextInteger(-5, 20);
                        local v65 = math.rad(v64);
                        local v66 = 360 / v60 * v61 + u5:NextInteger(-15, 15);
                        local v67 = math.rad(v66);
                        local v68 = u5:NextInteger(-5, 20);
                        v62:PivotTo(v63 * l__Angles__9(v65, v67, (math.rad(v68))));
                        local v69 = v62["1"];
                        local v70, v71, v72 = Color3.fromRGB(101, 165, 38):ToHSV();
                        local v73 = 0.03 or 0.05;
                        local v74 = v70 + u5:NextNumber(-v73, v73);
                        v69.Color = Color3.fromHSV(v74, v71, v72);
                        v62:ScaleTo(u5:NextNumber(0.6, 1.1) * (u4 * 0.5 + 0.5));
                        v69.Name = tostring(u18);
                        u18 = u18 + 1;
                        v69.Parent = u1;
                        v62:Destroy();
                    end;
                end;
                u19 = v28;
            end;
            u19 = nil;
        end;
        v75(l__Base__2, math.floor(v15), true);
        math.ceil(u20 / 5);
        local v76 = u18;
        local v77 = 0;
        while v16 > 0 do
            v16 = v16 - 1;
            local v78 = u5:NextInteger(3, 8);
            while u5:NextInteger(1, 5) == 1 do
                v78 = v78 + 1;
            end;
            v75(u22[u5:NextInteger(1, #u22)], v78);
            v77 = v77 + 1;
        end;
        local v79 = math.ceil(v76 / 7);
        while u5:NextInteger(1, 10) == 1 do
            v79 = v79 + 1;
        end;
        for _ = 1, v79 do
            local v80 = v12();
            v80.Size = Vector3.new(1, 1, 1);
            local v81 = u21[u5:NextInteger(1, #u21)];
            v80.CFrame = v81:GetPivot() * CFrame.new(0, u5:NextNumber(-v81.Size.Y / 2, v81.Size.Y / 2), 0);
            v80.Orientation = Vector3.new(0, 0, 180);
            v80.Parent = u1.FruitSpawnLocations;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u82) --[[ Name: BeginPlantGrowth, Line 205 ]]
        local l__PrimaryPart__10 = u82.PrimaryPart;
        local u83 = {};
        for _, v84 in u82:GetDescendants() do
            local v85 = tonumber(v84.Name);
            if v84:IsA("BasePart") and v85 then
                local v86 = {
                    v84,
                    v84.Size,
                    l__PrimaryPart__10.CFrame:ToObjectSpace(v84.CFrame),
                    v85
                };
                table.insert(u83, v86);
                v84.CanCollide = false;
                v84.Transparency = 1;
            end;
        end;
        local function v93() --[[ Line: 223 ]]
            -- upvalues: u82 (copy), u83 (copy), l__PrimaryPart__10 (copy)
            local v87 = u82:GetAttribute("Age") or 0;
            for _, v88 in u83 do
                local v89 = v88[1];
                local v90 = v88[2];
                local v91 = v88[3];
                local v92 = math.min(v87 - v88[4], 1);
                if v92 > 0 then
                    v89.Size = Vector3.new(v90.X, v90.Y * v92, v90.Z);
                    v89.CFrame = l__PrimaryPart__10.CFrame * v91 * CFrame.new(0, (v89.Size.Y - v90.Y) / 2, 0);
                    v89.Transparency = v89:GetAttribute("OG_Transparency") or 0;
                    v89.CanCollide = true;
                else
                    v89.Transparency = 1;
                    v89.CanCollide = false;
                end;
            end;
        end;
        u82:GetAttributeChangedSignal("Age"):Connect(v93);
        v93();
    end,
    Extras = {}
};