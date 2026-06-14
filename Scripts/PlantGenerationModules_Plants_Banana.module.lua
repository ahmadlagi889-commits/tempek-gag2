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
        local u6;
        if u4 > 2 then
            u6 = u5:NextInteger(1, 5000) == 1;
        else
            u6 = false;
        end;
        if u6 then
            u1:AddTag("LoopyBanana");
        end;
        local u7 = u5:NextInteger(1, 5000) == 1;
        if u7 then
            u1:AddTag("SpiralBanana");
        end;
        local u8 = Vector3.new(2, 4.5, 2) * u4;
        local _ = l__Base__2.CFrame;
        local l__Base__3 = u1.Base;
        local u9 = Color3.fromRGB(149, 105, 80);
        local u10 = Color3.fromRGB(180, 195, 80);
        local function v75(p11, p12) --[[ Line: 73 ]]
            -- upvalues: u5 (copy), u8 (copy), u7 (copy), u9 (copy), u10 (copy), l__Base__3 (ref), l__Base__2 (copy), u1 (copy), u4 (ref), u6 (copy)
            local v13 = p11:GetPivot();
            local v14 = u5:NextInteger(-9, 9);
            local v15 = u5:NextInteger(-9, 9);
            for v16 = 1, p12 do
                local v17 = script.Stud_Part:Clone();
                local _ = (v16 - 1) / math.max(p12 - 1, 1);
                local v18 = math.clamp(u8.X - (v16 - 1) / (p12 - 1) * (u8.X / 3), 1, 10);
                local v19 = u5:NextNumber(-5, 5);
                local v20, v21, v22;
                if u7 then
                    v20 = (v16 - 1) / math.max(p12 - 1, 1) * 1.9 + 0.1;
                    v21 = 30;
                    v19 = 0;
                    v22 = 60;
                else
                    v22 = v15;
                    v21 = v14;
                    v20 = 1;
                end;
                local v23 = (u8.Y + u5:NextNumber(-2, 2)) * v20;
                local l__Angles__4 = CFrame.Angles;
                local v24 = v21 + u5:NextNumber(-2, 2);
                local v25 = math.rad(v24);
                local v26 = math.rad(v19);
                local v27 = v22 + u5:NextNumber(-2, 2);
                local v28 = l__Angles__4(v25, v26, (math.rad(v27)));
                local l__new__5 = CFrame.new;
                local l__Position__6 = v13.Position;
                local v29 = u5:NextNumber(-5, 5);
                local v30 = u5:NextNumber(-5, 5);
                l__new__5(l__Position__6 + Vector3.new(v29, v30, u5:NextNumber(-5, 5)));
                v17.Color = u9:Lerp(u10, (math.clamp(v16 / p12, 0, 1)));
                v17.Size = Vector3.new(v18, v23, v18);
                local v31 = 0;
                if l__Base__3 and l__Base__3 ~= l__Base__2 then
                    v31 = l__Base__3.Size.Y;
                    v13 = l__Base__3:GetPivot();
                elseif u7 then
                    local l__Angles__7 = CFrame.Angles;
                    local v32 = u5:NextNumber(0, 360);
                    v28 = l__Angles__7(0, math.rad(v32), 0) * CFrame.Angles(1.4835298641951802, 0, 0);
                else
                    local l__Angles__8 = CFrame.Angles;
                    local v33 = v21 + u5:NextNumber(-2, 2);
                    local v34 = math.rad(v33);
                    local v35 = u5:NextNumber(0, 360);
                    local v36 = math.rad(v35);
                    local v37 = v21 + u5:NextNumber(-2, 2);
                    v28 = l__Angles__8(v34, v36, (math.rad(v37)));
                end;
                v17.CFrame = v13 * CFrame.new(0, v31 / 2.1, 0) * v28 * CFrame.new(0, v23 / 2.1, 0);
                v17.Name = v16;
                v17.Parent = u1;
                if v16 == p12 then
                    local v38 = u5:NextNumber(3, 6);
                    while u5:NextInteger(1, 10) == 1 and v38 < 30 do
                        v38 = v38 + 1;
                    end;
                    for v39 = 1, v38 do
                        local v40 = script.SpawnWing:Clone();
                        local v41 = v17:GetPivot() * CFrame.new(0, v17.Size.Y / 2, 0);
                        local l__Angles__9 = CFrame.Angles;
                        local v42 = u5:NextInteger(-5, 5);
                        local v43 = math.rad(v42);
                        local v44 = 360 / v38 * v39 + u5:NextInteger(-15, 15);
                        local v45 = math.rad(v44);
                        local v46 = u5:NextInteger(-5, 5);
                        v40:PivotTo(v41 * l__Angles__9(v43, v45, (math.rad(v46))) * CFrame.Angles(0.8726646259971648, 0, 0));
                        v40:ScaleTo(u5:NextNumber(0.6, 1.1) * u4);
                        v40.FruitSpawn.Parent = u1.FruitSpawnLocations;
                        for _, v47 in v40:GetChildren() do
                            v47.Name = tonumber(v47.Name) + tonumber(v17.Name);
                            v47.Parent = u1;
                        end;
                        v40:Destroy();
                    end;
                end;
                if v16 == p12 then
                    local v48 = u5:NextNumber(3, 6);
                    for v49 = 1, v48 do
                        local v50 = u5:NextInteger(6, 8);
                        while u5:NextInteger(1, 6) == 1 and v50 < 30 do
                            v50 = v50 + 1;
                        end;
                        while u5:NextInteger(1, 1000) == 1 do
                            v50 = v50 * 2;
                        end;
                        local v51 = nil;
                        local v52 = u5:NextInteger(12, 19);
                        local v53 = u5:NextNumber(1, 2);
                        local v54 = u5:NextNumber(2.5, 3);
                        local v55 = Vector3.new(v53, v54, u5:NextNumber(4, 5.5)) * u4;
                        local v56 = v50 > 17 and 4 or (v50 > 12 and 7 or v52);
                        if u6 then
                            v50 = u5:NextInteger(22, 28);
                            v56 = math.ceil(400 / v50);
                        end;
                        for v57 = 1, v50 do
                            local v58 = script.Stud_Part:Clone();
                            v58.Color = Color3.fromRGB(126, 180, 40);
                            v58.Material = Enum.Material.Glacier;
                            v58.MaterialVariant = "2022 Weld";
                            local v59 = 1 - ((v57 - 1) / math.max(v50 - 1, 1)) ^ 1.15 * 0.7;
                            v58.Size = Vector3.new(v55.Z * v59, v55.Y, v55.X * v59);
                            local v60;
                            if v57 == 1 then
                                local v61 = v17.CFrame * CFrame.new(0, v17.Size.Y / 2, 0);
                                local l__Angles__10 = CFrame.Angles;
                                local v62 = u5:NextInteger(-7, 7);
                                local v63 = math.rad(v62);
                                local v64 = 360 / v48 * v49 + u5:NextInteger(-7, 7);
                                local v65 = math.rad(v64);
                                local v66 = u5:NextInteger(-7, 7);
                                local v67 = v61 * l__Angles__10(v63, v65, (math.rad(v66)));
                                local l__Angles__11 = CFrame.Angles;
                                local v68 = u5:NextInteger(55, 60);
                                v60 = v67 * l__Angles__11(math.rad(v68), 0, 0) * CFrame.new(0, v58.Size.Y / 2, 0);
                            else
                                local v69 = v51:GetPivot() * CFrame.new(0, v51.Size.Y / 2, 0);
                                local l__Angles__12 = CFrame.Angles;
                                local v70 = v56 + u5:NextNumber(-2, 2);
                                local v71 = math.rad(v70);
                                local v72 = u5:NextNumber(-5, 5);
                                local v73 = math.rad(v72);
                                local v74 = u5:NextNumber(-3, 3);
                                v60 = v69 * l__Angles__12(v71, v73, (math.rad(v74))) * CFrame.new(0, v58.Size.Y / 2, 0);
                            end;
                            if v57 == 1 then
                                v58.Size = v58.Size - Vector3.new(v58.Size.X / 1.5, 0, v58.Size.Z / 2);
                            end;
                            v58:PivotTo(v60);
                            v58.Name = v57 + p12;
                            v58.Parent = u1;
                            v51 = v58;
                        end;
                    end;
                end;
                l__Base__3 = v17;
            end;
            l__Base__3 = nil;
        end;
        local v76 = u5:NextInteger(4, 8);
        while u5:NextInteger(1, 8) == 1 do
            v76 = v76 + 1.5;
        end;
        if u5:NextInteger(1, 1000) == 1 then
            v76 = v76 * 2;
        end;
        if u7 then
            v76 = u5:NextInteger(15, 20);
        end;
        v75(l__Base__2, math.floor(v76), true);
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u77) --[[ Name: BeginPlantGrowth, Line 284 ]]
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
        local function v88() --[[ Line: 302 ]]
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