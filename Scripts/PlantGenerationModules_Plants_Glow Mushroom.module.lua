-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 9 ]]
        local l__MaterialService__1 = game:GetService("MaterialService");
        local v4 = p3 or 1;
        local u5 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Base__3 = u1.Base;
        local u6 = Color3.fromRGB(180, 170, 158);
        local v7, v8, v9 = Color3.fromRGB(100, 0, 192):ToHSV();
        local v10 = 0.1 or 0.05;
        local v11 = v7 + u5:NextNumber(-v10, v10);
        local v12 = math.clamp(v11, 0, 0.99);
        local u13 = Color3.fromHSV(v12, v8, v9);
        local function u20(p14, p15, p16) --[[ Line: 31 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (copy)
            local v17 = Instance.new("Part");
            local v18 = p14 or "Studs";
            v17.Parent = u1;
            v17.TopSurface = Enum.SurfaceType[v18];
            v17.BackSurface = Enum.SurfaceType[v18];
            v17.FrontSurface = Enum.SurfaceType[v18];
            v17.BottomSurface = Enum.SurfaceType[v18];
            v17.LeftSurface = Enum.SurfaceType[v18];
            v17.RightSurface = Enum.SurfaceType[v18];
            v17.Anchored = true;
            v17.CanCollide = false;
            v17.Transparency = 0;
            if p16 then
                v17.Shape = Enum.PartType[p16];
            end;
            if p15 then
                v17.MaterialVariant = p15;
                local v19 = l__MaterialService__1:FindFirstChild(p15, true);
                if not v19 then
                    return v17;
                end;
                v17.Material = v19.BaseMaterial;
            end;
            return v17;
        end;
        local u21 = 0.8;
        local function u48(p22, p23, p24, p25, p26) --[[ Line: 63 ]]
            -- upvalues: u20 (copy), u5 (copy), u6 (copy), l__FruitSpawnLocations__2 (copy), u1 (copy), u13 (copy), u48 (copy), u21 (ref)
            local l__Y__4 = p23.Y;
            local v27 = l__Y__4;
            for v28 = 1, p22 do
                local v29 = u20(nil, "2022 Inlet");
                v29.Size = p23;
                local l__Angles__5 = CFrame.Angles;
                local v30 = u5:NextNumber(-6, 6);
                local v31 = math.rad(v30);
                local v32 = u5:NextNumber(-6, 6);
                v29.CFrame = p24 * l__Angles__5(v31, 0.2617993877991494, (math.rad(v32))) * CFrame.new(0, p23.Y / 2.2, 0);
                v29.Color = u6;
                v29.Name = tostring(v28 + p25);
                if p26 and v28 ~= p22 then
                    local v33 = u20();
                    v33.Parent = l__FruitSpawnLocations__2;
                    local v34 = v29.CFrame * CFrame.new(0, p23.Y / 2, 0);
                    local l__Angles__6 = CFrame.Angles;
                    local v35 = u5:NextNumber(-180, 180);
                    v33.CFrame = v34 * l__Angles__6(0, math.rad(v35), 0.7853981633974483);
                    v33.Size = Vector3.new(1, 1, 1);
                    v33.Transparency = 1;
                end;
                p24 = v29.CFrame * CFrame.new(0, p23.Y / 2.2, 0);
                l__Y__4 = math.clamp(l__Y__4 * 1.15, 0, v27 * 2);
                if u5:NextInteger(1, 4) == 1 or v28 == p22 then
                    local v36 = script.MushroomTop:Clone();
                    v36.Parent = u1;
                    v36:ScaleTo((v28 == p22 and u5:NextNumber(0.65, 0.75) or u5:NextNumber(0.19, 0.27)) * p23.X);
                    v36:PivotTo(p24);
                    if v28 ~= p22 then
                        v36["3"]:Destroy();
                    end;
                    for _, v37 in v36:GetChildren() do
                        local v38 = tonumber(v37.Name);
                        if v38 then
                            if v38 > 1 then
                                v37.Color = u13;
                            end;
                            if v38 == 3 then
                                local l__CFrame__7 = v37.CFrame;
                                local l__Angles__8 = CFrame.Angles;
                                local v39 = u5:NextNumber(-10, 10);
                                v37.CFrame = l__CFrame__7 * l__Angles__8(0, math.rad(v39), 0);
                            end;
                            if v38 > 1 and v28 == p22 then
                                local v40 = 90;
                                for _ = 1, 2 do
                                    for _ = 1, u5:NextInteger(3, 6) do
                                        local v41 = u5:NextNumber(p23.X * 0.15, p23.X * 0.2);
                                        local v42 = u20();
                                        local v43 = {
                                            X = 0,
                                            Y = u5:NextNumber(-v37.Size.Y, v37.Size.Y) * 0.35,
                                            Z = u5:NextNumber(-v37.Size.Z, v37.Size.Z) * 0.3
                                        };
                                        v42.Material = Enum.Material.Neon;
                                        v42.Size = Vector3.new(v41, v37.Size.Z + 0.2, v41);
                                        v42.CFrame = v37.CFrame * CFrame.Angles(0, math.rad(v40), 0) * CFrame.new(v43.X, v43.Y, v43.Z) * CFrame.Angles(0, 0, 1.5707963267948966);
                                        v42.Color = Color3.fromRGB(180, 170, 158);
                                        v42.Name = v28 + p25 + v38 + 1;
                                    end;
                                    v40 = v40 * 2;
                                end;
                            end;
                            v37.Name = v38 + v28 + p25;
                            v37.Parent = u1;
                        end;
                    end;
                end;
                if u5:NextInteger(1, 5) == 1 and (p26 and v28 ~= p22) then
                    local v44 = u48;
                    local v45 = u5:NextInteger(2, 3);
                    local v46 = Vector3.new(p23.X, p23.Y * 0.75, p23.Z) * 0.7;
                    local l__Angles__9 = CFrame.Angles;
                    local v47 = u5:NextNumber(-180, 180);
                    v44(v45, v46, p24 * l__Angles__9(0, math.rad(v47), 0.7853981633974483), v28);
                end;
                p23 = Vector3.new(p23.X * u21, l__Y__4, p23.Z * u21);
            end;
        end;
        local v49 = u5:NextNumber(1.9, 2.3) * v4;
        local v50 = u5:NextNumber(4.5, 6) * v4;
        local v51 = u5:NextInteger(3, 4);
        while u5:NextInteger(1, 100) == 1 do
            v51 = v51 * 2;
            v49 = v49 * 2;
            u21 = 0.9;
        end;
        local v52 = Vector3.new(v49, v50, v49);
        local l__CFrame__10 = l__Base__3.CFrame;
        local _ = 1 * v4;
        u48(v51, v52, l__CFrame__10, 0, true);
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u53) --[[ Name: BeginPlantGrowth, Line 173 ]]
        local l__PrimaryPart__11 = u53.PrimaryPart;
        local u54 = {};
        for _, v55 in u53:GetDescendants() do
            local v56 = tonumber(v55.Name);
            if (v55:IsA("BasePart") or v55:IsA("MeshPart")) and v56 then
                local v57 = {
                    v55,
                    v55.Size,
                    l__PrimaryPart__11.CFrame:ToObjectSpace(v55.CFrame),
                    v56
                };
                table.insert(u54, v57);
                v55.CanCollide = false;
                v55.Transparency = 1;
            end;
        end;
        local function v64() --[[ Line: 191 ]]
            -- upvalues: u53 (copy), u54 (copy), l__PrimaryPart__11 (copy)
            local v58 = u53:GetAttribute("Age") or 0;
            for _, v59 in u54 do
                local v60 = v59[1];
                local v61 = v59[2];
                local v62 = v59[3];
                local v63 = math.min(v58 - v59[4], 1);
                if v63 > 0 then
                    v60.Size = Vector3.new(v61.X, v61.Y * v63, v61.Z);
                    v60.CFrame = l__PrimaryPart__11.CFrame * v62 * CFrame.new(0, (v60.Size.Y - v61.Y) / 2, 0);
                    v60.Transparency = v60:GetAttribute("OG_Transparency") or 0;
                    v60.CanCollide = true;
                else
                    v60.Transparency = 1;
                    v60.CanCollide = false;
                end;
            end;
        end;
        u53:GetAttributeChangedSignal("Age"):Connect(v64);
        v64();
    end,
    Extras = {}
};