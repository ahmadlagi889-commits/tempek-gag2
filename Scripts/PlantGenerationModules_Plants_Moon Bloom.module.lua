-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 9 ]]
        local l__MaterialService__1 = game:GetService("MaterialService");
        local u4 = p3 or 1;
        local u5 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Base__3 = u1.Base;
        local v6, v7 = Color3.fromRGB(51, 136, 5);
        local v8, v9, v10 = v6:ToHSV();
        local v11 = v7 or 0.05;
        local v12 = v8 + u5:NextNumber(-v11, v11);
        local v13 = math.clamp(v12, 0, 0.99);
        Color3.fromHSV(v13, v9, v10);
        local function u21(p14, p15, p16) --[[ Line: 30 ]]
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
            for _, v19 in pairs(script:GetChildren()) do
                if v19:IsA("Texture") then
                    v19:Clone().Parent = v17;
                end;
            end;
            if p16 then
                v17.Shape = Enum.PartType[p16];
            end;
            if p15 then
                v17.MaterialVariant = p15;
                local v20 = l__MaterialService__1:FindFirstChild(p15, true);
                if not v20 then
                    return v17;
                end;
                v17.Material = v20.BaseMaterial;
            end;
            return v17;
        end;
        local v22 = u5:NextNumber(2.5, 2.9) * u4;
        local v23 = v22 * 0.85;
        local v24 = u5:NextInteger(6, 9);
        if u5:NextInteger(1, 12) == 1 then
            v24 = v24 + u5:NextInteger(4, 10);
        end;
        local v25 = Vector3.new(v22, v23, v22);
        local v26 = Vector3.new(v22 * 0.325, v23 * 1.15, v22 * 0.325);
        local l__CFrame__4 = l__Base__3.CFrame;
        local u27 = {
            Start = Color3.fromRGB(142, 176, 204),
            End = Color3.fromRGB(99, 255, 246)
        };
        local v28 = u5:NextNumber(3.75, 6.75);
        if u5:NextInteger(1, 15) == 1 then
            v28 = u5:NextNumber(6.5, 10);
        end;
        local v29 = u5:NextNumber(-180, 180);
        local l__identity__5 = CFrame.identity;
        local v30 = 450 / (v24 - 2);
        local v31 = u5:NextNumber(-180, 180);
        local v32 = Vector3.new(1.3, 0, 1.3) * u4;
        local v33 = Vector3.new(0.2, 0, 0.2) * u4;
        local function v50(p34, p35, p36) --[[ Line: 92 ]]
            -- upvalues: u5 (copy), u4 (ref), l__Base__3 (copy), u21 (copy), u27 (copy)
            local v37 = p34 * CFrame.Angles(3.141592653589793, 0, 0);
            local v38 = u5:NextNumber(0.8, 1) * u4;
            local v39 = u5:NextNumber(2, 2.7) * u4;
            local l__Y__6 = v37.Position.Y;
            local v40 = Vector3.new(v38, v39, v38);
            local v41 = 0;
            local v42 = {};
            while l__Base__3.Position.Y < l__Y__6 do
                local v43 = u21(nil, "2022 Stud Space");
                local v44 = u5:NextNumber(p35[1], p35[2]);
                local v45 = math.rad(v44);
                if u5:NextInteger(1, 3) == 1 then
                    v45 = v45 * 2;
                end;
                if v41 == 1 and u5:NextNumber(1, 2) == 1 then
                    v45 = -v45;
                end;
                v41 = v41 + 1;
                v43.Size = v40;
                v43.CFrame = v37 * CFrame.Angles(0, 0, v45) * CFrame.new(0, v43.Size.Y / 2.3, 0);
                v43.Color = u27.Start;
                v43.Name = v41 + 2;
                l__Y__6 = v43.Position.Y;
                v37 = v43.CFrame * CFrame.new(0, v43.Size.Y / 2.3, 0);
                local v46 = v40.X * u5:NextNumber(1.15, 1.325);
                local v47 = v40.Y * u5:NextNumber(1.05, 1.25);
                v40 = Vector3.new(v46, v47, v46);
                table.insert(v42, v43);
                local _ = v41 % 3 == 1;
            end;
            for _, v48 in v42 do
                local v49 = tonumber(v48.Name) / #v42;
                v48.Color = u27.Start:Lerp(p36, v49);
            end;
        end;
        for v51 = 1, v24 do
            local v52 = u21(nil, "2022 Stud Space");
            local v53 = v51 / v24;
            local v54 = {};
            local v55 = u5:NextNumber(-v28, v28);
            v54.X = math.rad(v55);
            local v56 = u5:NextNumber(-1.5, 1.5);
            v54.Y = math.rad(v56);
            local v57 = u5:NextNumber(-v28, v28);
            v54.Z = math.rad(v57);
            v52.Size = v25:Lerp(v26, v53);
            v52.CFrame = l__CFrame__4 * CFrame.Angles(v54.X, v54.Y, v54.Z) * CFrame.new(0, v52.Size.Y / 2.15, 0);
            v52.Color = u27.Start:Lerp(u27.End, v53);
            v52.Name = v51;
            if v51 >= 3 then
                local v58;
                if v51 == 3 then
                    v58 = v52.CFrame;
                else
                    v58 = l__identity__5;
                end;
                local v59 = v51 == 3 and v52.Size.X * 1.15 or v52.Size.X * 1.5;
                local v60 = v31 + v30 * (v51 - 2);
                local l__CFrame__7 = v52.CFrame;
                local l__new__8 = CFrame.new;
                local v61 = math.rad(v60);
                local v62 = math.cos(v61) * v59;
                local v63 = math.rad(v60);
                l__identity__5 = l__CFrame__7 * l__new__8(v62, 0, math.sin(v63) * v59);
                local l__Magnitude__9 = (v58.Position - l__identity__5.Position).Magnitude;
                local v64 = (v51 - 2) / v24;
                local v65 = u21(nil, "2022 Stud Space");
                v65.Size = v32:Lerp(v33, v64) + Vector3.new(0, 1, 0) * l__Magnitude__9;
                v65.CFrame = CFrame.lookAt(v58.Position, l__identity__5.Position) * CFrame.new(0, 0, -l__Magnitude__9 / 2) * CFrame.Angles(-1.5707963267948966, 0, 0);
                v65.Color = u27.Start:Lerp(u27.End, v64);
                v65.Name = v51 + 1;
            end;
            if v51 == 2 then
                local v66 = u5:NextInteger(3, 5);
                for v67 = 1, v66 do
                    local v68 = 360 / v66 * (v67 * u5:NextNumber(0.9, 1.1));
                    local v69 = v52.CFrame * CFrame.Angles(0, math.rad(v68), 0);
                    local l__Angles__10 = CFrame.Angles;
                    local v70 = u5:NextNumber(80, 90);
                    v50(v69 * l__Angles__10(0, 0, (math.rad(v70))), { 9, 18 }, v52.Color);
                    local v71 = script.Leaf:Clone();
                    v71.Parent = u1;
                    local v72 = l__Base__3.CFrame * CFrame.Angles(0, math.rad(v68 + 45), 0) * CFrame.new(0, 0, -v25.Z / 2);
                    local l__Angles__11 = CFrame.Angles;
                    local v73 = u5:NextNumber(-35, -60);
                    v71:PivotTo(v72 * l__Angles__11(math.rad(v73), 0, 0));
                    v71.Name = 1;
                end;
            end;
            if v51 > 2 and v51 < v24 then
                local v74 = script.BigLeaf:Clone();
                v74.Parent = u1;
                v74:ScaleTo(u4);
                local v75 = v52.CFrame * CFrame.Angles(0, math.rad(v29), 0);
                local l__Angles__12 = CFrame.Angles;
                local v76 = u5:NextNumber(-110, -125);
                v74:PivotTo(v75 * l__Angles__12(math.rad(v76), 0, 0) * CFrame.new(0, v52.Size.Z / 2.25, 0));
                v29 = v29 + u5:NextNumber(45, 115);
                for _, v77 in v74:GetChildren() do
                    local v78 = tonumber(v77.Name);
                    if v78 then
                        v77.Name = v78 + v51;
                        v77.Parent = u1;
                    end;
                end;
                v74:Destroy();
            end;
            l__CFrame__4 = v52.CFrame * CFrame.new(0, v52.Size.Y / 2.15, 0);
        end;
        local v79 = u21();
        for _, v80 in pairs(v79:GetChildren()) do
            v80:Destroy();
        end;
        v79.Size = Vector3.new(1, 1, 1);
        v79.CFrame = l__CFrame__4;
        v79.Parent = l__FruitSpawnLocations__2;
        v79.Transparency = 1;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u81) --[[ Name: BeginPlantGrowth, Line 241 ]]
        local l__PrimaryPart__13 = u81.PrimaryPart;
        local u82 = {};
        for _, v83 in u81:GetDescendants() do
            local v84 = tonumber(v83.Name);
            if (v83:IsA("BasePart") or v83:IsA("MeshPart")) and v84 then
                local v85 = not v83:GetAttribute("DontShow");
                local v86 = {};
                for _, v87 in v83:GetChildren() do
                    if v87:IsA("Decal") or v87:IsA("Texture") then
                        table.insert(v86, {
                            decal = v87,
                            originalTransparency = v87.Transparency
                        });
                        if v85 then
                            v87.Transparency = 1;
                        end;
                    end;
                end;
                local v88 = {
                    part = v83,
                    maxSize = v83.Size,
                    centerOffset = l__PrimaryPart__13.CFrame:ToObjectSpace(v83.CFrame),
                    partAge = v84,
                    decals = v86
                };
                table.insert(u82, v88);
                v83.CanCollide = false;
                if v85 then
                    v83.Transparency = 1;
                end;
            end;
        end;
        local function v97() --[[ Line: 276 ]]
            -- upvalues: u81 (copy), u82 (copy), l__PrimaryPart__13 (copy)
            local v89 = u81:GetAttribute("Age") or 0;
            local v90 = u81:GetAttribute("MaxAge") or 1;
            local v91 = v89 / v90;
            for _, v92 in u82 do
                if not v92.part:GetAttribute("DontShow") then
                    local v93 = math.clamp((v91 - v92.partAge / v90) * v90, 0, 1);
                    if v93 > 0 then
                        local v94 = v92.maxSize * v93;
                        v92.part.Size = v94;
                        v92.part.CFrame = l__PrimaryPart__13.CFrame * v92.centerOffset * CFrame.new(0, -((v92.maxSize.Y - v94.Y) / 2), 0);
                        v92.part.Transparency = v92.part:GetAttribute("OG_Transparency") or 0;
                        v92.part.CanCollide = true;
                        for _, v95 in v92.decals do
                            v95.decal.Transparency = v95.originalTransparency + (1 - v95.originalTransparency) * (1 - v93);
                        end;
                    else
                        v92.part.Transparency = 1;
                        v92.part.CanCollide = false;
                        for _, v96 in v92.decals do
                            v96.decal.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        u81:GetAttributeChangedSignal("Age"):Connect(v97);
        v97();
    end,
    Extras = {}
};