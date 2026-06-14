-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        local u4 = p3 or 1;
        local u5 = Random.new(p2);
        local l__FruitSpawnLocations__1 = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local l__Stud_Part__3 = script.Stud_Part;
        local _ = p2 + #u1:GetChildren() * u5:NextInteger(3, 90);
        local u6 = 1 * (u4 * 0.5 + 0.5);
        local u7 = 3 * (u4 * 0.5 + 0.5);
        while u5:NextInteger(1, 100) == 1 do
            u7 = u7 * 2;
        end;
        local v8 = Color3.fromRGB(36, 145, 36);
        local u9 = Color3.fromRGB(45, 165, 45);
        local u10 = l__Base__2.Position.Y - l__Base__2.Size.Y / 2 + 7;
        local u11 = {};
        local u12 = 0;
        local function u16(p13) --[[ Line: 33 ]]
            -- upvalues: l__Stud_Part__3 (copy), u1 (copy)
            local v14 = l__Stud_Part__3:Clone();
            local v15 = p13 or "Studs";
            v14.TopSurface = Enum.SurfaceType[v15];
            v14.BackSurface = Enum.SurfaceType[v15];
            v14.FrontSurface = Enum.SurfaceType[v15];
            v14.BottomSurface = Enum.SurfaceType[v15];
            v14.LeftSurface = Enum.SurfaceType[v15];
            v14.RightSurface = Enum.SurfaceType[v15];
            v14.Anchored = true;
            v14.CanCollide = false;
            v14.Transparency = 0;
            v14.Parent = u1;
            return v14;
        end;
        local function u24(p17, p18, p19, p20) --[[ Line: 52 ]]
            -- upvalues: u6 (copy), u7 (ref), l__Stud_Part__3 (copy), u12 (ref), u1 (copy)
            local v21 = Vector3.new(u6, u7, u6);
            local v22 = p17.CFrame * CFrame.new(0, p17.Size.Y / 2, 0) * CFrame.Angles(math.rad(p18), math.rad(p20), (math.rad(p19))) * CFrame.new(0, v21.Y / 2, 0);
            local v23 = l__Stud_Part__3:Clone();
            v23.Size = v21;
            v23.CFrame = v22;
            u12 = u12 + 1;
            v23.Name = tostring(u12);
            v23.Parent = u1;
            v23.Color = p17.Color;
            return v23;
        end;
        local function v33(p25, p26) --[[ Line: 71 ]]
            -- upvalues: u5 (copy), u24 (copy), u11 (copy)
            local v27 = 0;
            local v28 = 0;
            local v29 = u5:NextInteger(3, 20);
            if u5:NextInteger(1, 2) == 1 then
                v29 = -v29;
            end;
            local v30 = u5:NextInteger(-45, 45);
            local v31 = u5:NextInteger(-45, 45);
            while p26 > 0 do
                if v30 >= 1 and v27 < v30 then
                    v27 = v27 + 5;
                elseif v30 < 0 and v30 < v27 then
                    v27 = v27 - 5;
                end;
                if v31 >= 1 and v28 < v31 then
                    v28 = v28 + 5;
                elseif v31 < 0 and v31 < v28 then
                    v28 = v28 - 5;
                end;
                local v32 = u24(p25, v27, v28, v29);
                if v32 then
                    table.insert(u11, v32);
                else
                    v32 = p25;
                end;
                p26 = p26 - 1;
                p25 = v32;
            end;
        end;
        local function u38(p34, p35) --[[ Line: 105 ]]
            -- upvalues: u16 (copy), u9 (copy)
            for v36 = -1, 1, 2 do
                local v37 = u16("Weld");
                v37.Size = Vector3.new(p34.Size.Z, p34.Size.Y * 0.5, p34.Size.X / 2);
                v37.Shape = Enum.PartType.Wedge;
                v37.CFrame = p34.CFrame * CFrame.new(-v36 * p34.Size.X / 4, p34.Size.Y / 2 + p34.Size.Y * 0.5 / 2 - 0.025, 0) * CFrame.Angles(0, math.rad(v36 * 90), 0);
                v37.Color = u9;
                v37.Name = tostring(p35);
                v37:AddTag("DetailPart");
            end;
        end;
        local function v51(p39, p40) --[[ Line: 123 ]]
            -- upvalues: u4 (ref), u5 (copy), u16 (copy), u9 (copy), u38 (copy), l__FruitSpawnLocations__1 (copy), u10 (copy)
            local v41 = Vector3.new(1, 1, 0.1) * u4;
            local v42 = u5:NextInteger(1, 2) == 1 and 1 or -1;
            local v43 = u16("Weld");
            v43.Size = v41;
            v43.CFrame = p39.CFrame * CFrame.new(v42 * (p39.Size.X / 2 + v41.Y / 2 - 0.05), 0, 0);
            v43.CFrame = v43.CFrame * CFrame.Angles(0, 0, (math.rad(v42 * -90)));
            v43.Color = u9;
            v43.Name = tostring(p40);
            v43:AddTag("DetailPart");
            local v44 = u16("Weld");
            v44.Size = v41;
            local v45 = u5:NextInteger(25, 45);
            v44.CFrame = v43.CFrame * CFrame.new(0, v43.Size.Y / 2, 0) * CFrame.Angles(-math.rad(v45), 0, 0) * CFrame.new(0, v44.Size.Y / 2 - 0.025, 0);
            v44.Color = u9;
            v44.Name = tostring(p40);
            v44:AddTag("DetailPart");
            u38(v44, p40);
            local v46 = p39.CFrame - Vector3.new(0, 2, 0);
            local v47 = true;
            for _, v48 in pairs(l__FruitSpawnLocations__1:GetChildren()) do
                if (v48.Position - v46.Position).Magnitude < 4 then
                    v47 = false;
                end;
            end;
            if v47 == true and v46.Position.Y > u10 + 2 then
                local v49 = Instance.new("Part");
                v49.Size = Vector3.new(0.1, 0.1, 0.1) * u4;
                v49.Anchored = true;
                v49.CanCollide = false;
                v49.Transparency = 1;
                v49.Name = "Fruit_Spawn";
                v49.CFrame = v46;
                local v50 = u5:NextInteger(-180, 180);
                v49.Orientation = Vector3.new(0, v50, 0);
                v49.Parent = l__FruitSpawnLocations__1;
            end;
        end;
        u12 = 1;
        local v52 = u16("Weld");
        v52.Color = v8;
        v52.Size = Vector3.new(u6, u7, u6);
        v52.CFrame = l__Base__2.CFrame * CFrame.new(0, v52.Size.Y / 2, 0);
        v52.Name = tostring(u12);
        table.insert(u11, v52);
        local v53 = u5:NextInteger(5, 10);
        local v54 = u12;
        while u5:NextInteger(1, 100) == 1 do
            v53 = v53 * 2;
        end;
        local v55 = 0;
        while v53 > 0 do
            local v56 = u5:NextInteger(1, 2) == 1;
            v33(v52, (u5:NextInteger(2, 5)));
            if #u11 > 0 then
                v52 = u11[u5:NextInteger(1, #u11)];
            end;
            v53 = v53 - 1;
            if v56 then
                v55 = v55 + 1;
            end;
        end;
        local v57 = v54 + 1;
        while v55 > 0 do
            if #u11 > 0 then
                v51(u11[u5:NextInteger(1, #u11)], v57);
            end;
            v55 = v55 - 1;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u58) --[[ Name: BeginPlantGrowth, Line 230 ]]
        local l__PrimaryPart__4 = u58.PrimaryPart;
        local u59 = {};
        for _, v60 in u58:GetDescendants() do
            local v61 = tonumber(v60.Name);
            if v60:IsA("BasePart") and v61 then
                local v62 = v60:HasTag("DetailPart");
                local v63;
                if v62 then
                    v63 = nil;
                else
                    local v64 = v60.CFrame * CFrame.new(0, -v60.Size.Y / 2, 0);
                    v63 = l__PrimaryPart__4.CFrame:ToObjectSpace(v64);
                end;
                local v65 = {
                    part = v60,
                    maxSize = v60.Size,
                    bottomOffset = v63,
                    centerOffset = l__PrimaryPart__4.CFrame:ToObjectSpace(v60.CFrame),
                    partAge = v61,
                    isDetail = v62
                };
                table.insert(u59, v65);
                v60.CanCollide = false;
                v60.Transparency = 1;
            end;
        end;
        local function v69() --[[ Line: 260 ]]
            -- upvalues: u58 (copy), u59 (copy), l__PrimaryPart__4 (copy)
            local v66 = u58:GetAttribute("Age") or 0;
            for _, v67 in u59 do
                local v68 = math.clamp(v66 - v67.partAge, 0, 1);
                if v68 > 0 then
                    if v67.isDetail then
                        v67.part.Size = Vector3.new(v67.maxSize.X, v67.maxSize.Y * v68, v67.maxSize.Z);
                        v67.part.CFrame = l__PrimaryPart__4.CFrame * v67.centerOffset * CFrame.new(0, (v67.part.Size.Y - v67.maxSize.Y) / 2, 0);
                    else
                        v67.part.Size = Vector3.new(v67.maxSize.X, v67.maxSize.Y * v68, v67.maxSize.Z);
                        v67.part.CFrame = l__PrimaryPart__4.CFrame * v67.bottomOffset * CFrame.new(0, v67.part.Size.Y / 2, 0);
                    end;
                    v67.part.Transparency = v67.part:GetAttribute("OG_Transparency") or 0;
                    v67.part.CanCollide = true;
                else
                    v67.part.Transparency = 1;
                    v67.part.CanCollide = false;
                end;
            end;
        end;
        u58:GetAttributeChangedSignal("Age"):Connect(v69);
        v69();
    end,
    Extras = {}
};