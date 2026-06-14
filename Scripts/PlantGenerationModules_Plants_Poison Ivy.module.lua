-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 9 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local v4 = p3 or 1;
        local u5 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Base__3 = u1.Base;
        if v4 < 4 then
            v4 = v4 * 0.5 + 0.5;
        end;
        local u6 = Color3.fromRGB(74, 112, 33);
        local function u13(p7, p8, p9) --[[ Line: 30 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v10 = Instance.new("Part");
            local v11 = p7 or "Studs";
            v10.Parent = u1;
            v10.TopSurface = Enum.SurfaceType[v11];
            v10.BackSurface = Enum.SurfaceType[v11];
            v10.FrontSurface = Enum.SurfaceType[v11];
            v10.BottomSurface = Enum.SurfaceType[v11];
            v10.LeftSurface = Enum.SurfaceType[v11];
            v10.RightSurface = Enum.SurfaceType[v11];
            v10.Anchored = true;
            v10.CanCollide = false;
            v10.Transparency = 0;
            if p9 then
                v10.Shape = Enum.PartType[p9];
            end;
            if p8 then
                v10.MaterialVariant = p8;
                local v12 = l__MaterialService__1:FindFirstChild(p8, true);
                if not v12 then
                    return v10;
                end;
                v10.Material = v12.BaseMaterial;
            end;
            return v10;
        end;
        local v14 = v4 > 2 and v4 < 4 and 0.925 or (v4 > 4 and 0.95 or 0.85);
        local v15 = u5:NextNumber(1.3, 1.6) * v4;
        local v16 = u5:NextInteger(5, 7) * v4;
        local v17 = u5:NextInteger(4, 5);
        local u18 = Vector3.new(v15, v15, v15);
        local l__CFrame__4 = l__Base__3.CFrame;
        local _ = 1 * v4;
        local function u26(p19, p20) --[[ Line: 81 ]]
            -- upvalues: u5 (copy), u1 (copy)
            local l__Size__5 = p19.Size;
            local v21 = math.min(l__Size__5.X, l__Size__5.Y, l__Size__5.Z);
            local v22 = u5:NextNumber(1, 4) * 90;
            local v23 = u5:NextNumber(75, 105);
            local v24 = script.Spike.Size * (v21 * u5:NextNumber(0.75, 0.9));
            local v25 = script.Spike:Clone();
            v25.Parent = u1;
            v25.Name = p20 + 1;
            v25.Size = v24;
            v25.CFrame = p19.CFrame * CFrame.Angles(0, math.rad(v22), (math.rad(v23))) * CFrame.new(0, l__Size__5.Z / 2 + v24.Y / 2.2, 0);
        end;
        local function v43(p27, p28) --[[ Line: 96 ]]
            -- upvalues: u5 (copy), u18 (ref), l__CFrame__4 (ref), u13 (copy), u6 (copy), u26 (copy), l__FruitSpawnLocations__2 (copy)
            local v29 = u5:NextInteger(2, 3);
            local v30 = u18 * 0.8;
            local v31 = u5:NextNumber(1, 2) * (p28 * 90);
            local v32 = u5:NextNumber(60, 75);
            local v33 = l__CFrame__4 * CFrame.Angles(0, math.rad(v31), (math.rad(v32)));
            for v34 = 1, v29 do
                local v35 = u13(nil, "2022 Weld");
                v35.Size = v30;
                local l__Angles__6 = CFrame.Angles;
                local v36 = u5:NextNumber(-12, 12);
                local v37 = math.rad(v36);
                local v38 = u5:NextNumber(-12, 12);
                v35.CFrame = v33 * l__Angles__6(v37, 0.2617993877991494, (math.rad(v38))) * CFrame.new(0, v30.Y / 2.2, 0);
                v35.Color = u6;
                v35.Name = tostring(v34 + p28);
                if u5:NextInteger(1, 3) == 1 then
                    u26(v35, v34 + p28);
                end;
                v33 = v35.CFrame * CFrame.new(0, u18.Y / 2.2, 0);
                if v34 ~= v29 then
                    local v39 = u13();
                    local v40 = v34 % 2 == 0 and 90 or -90;
                    v39.Parent = l__FruitSpawnLocations__2;
                    v39.Name = "FruitSpawn";
                    v39.Size = Vector3.new(1, 1, 1);
                    v39.CFrame = v33;
                    v39.Orientation = v39.Orientation + Vector3.new(-90, v40, u5:NextNumber(5, 15));
                    v39.Transparency = 1;
                end;
                local v41 = v30.X * 0.85;
                local v42 = p27.Size.Y * u5:NextNumber(0.8, 1.1);
                v30 = Vector3.new(v41, v42, v30.Z * 0.85);
            end;
        end;
        local v44 = l__CFrame__4;
        local v45 = u18;
        local v46 = v15;
        for v47 = 1, v16 do
            local v48 = u13(nil, "2022 Weld");
            v48.Size = v45;
            local l__Angles__7 = CFrame.Angles;
            local v49 = u5:NextNumber(-6, 6);
            local v50 = math.rad(v49);
            local v51 = u5:NextNumber(-6, 6);
            v48.CFrame = v44 * l__Angles__7(v50, 0.2617993877991494, (math.rad(v51))) * CFrame.new(0, v45.Y / 2.2, 0);
            v48.Color = u6;
            v48.Name = tostring(v47);
            l__CFrame__4 = v48.CFrame * CFrame.new(0, v45.Y / 2.2, 0);
            v15 = math.clamp(v15 * 1.15, 0, v46 * 2);
            if u5:NextInteger(1, 3) == 1 then
                u26(v48, v47);
            end;
            if v47 > 2 and (u5:NextInteger(1, 2) == 1 or (v47 == v16 or v47 == 3)) then
                v43(v48, v47);
            end;
            u18 = Vector3.new(v45.X * v14, v15, v45.Z * v14);
            v44 = l__CFrame__4;
            v45 = u18;
        end;
        for v52 = 1, v17 do
            local v53 = u13(nil, "2022 Weld");
            v53.Size = v45;
            local l__Angles__8 = CFrame.Angles;
            local v54 = u5:NextNumber(-6, 6);
            local v55 = math.rad(v54);
            local v56 = u5:NextNumber(-45, -30);
            v53.CFrame = v44 * l__Angles__8(v55, 0, (math.rad(v56))) * CFrame.Angles(0, 0.2617993877991494, 0) * CFrame.new(0, v45.Y / 2.2, 0);
            v53.Color = u6;
            v53.Name = tostring(v52 + v16);
            l__CFrame__4 = v53.CFrame * CFrame.new(0, v45.Y / 2.2, 0);
            v15 = math.clamp(v15 * 0.9, v46 / 2, (1 / 0));
            if u5:NextInteger(1, 3) == 1 then
                u26(v53, v52 + v16);
            end;
            u18 = Vector3.new(v45.X * 0.9, v15, v45.Z * 0.9);
            v44 = l__CFrame__4;
            v45 = u18;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u57) --[[ Name: BeginPlantGrowth, Line 179 ]]
        local l__PrimaryPart__9 = u57.PrimaryPart;
        local u58 = {};
        for _, v59 in u57:GetDescendants() do
            local v60 = tonumber(v59.Name);
            if v59:IsA("BasePart") and v60 then
                local v61 = {
                    v59,
                    v59.Size,
                    l__PrimaryPart__9.CFrame:ToObjectSpace(v59.CFrame),
                    v60
                };
                table.insert(u58, v61);
                v59.CanCollide = false;
                v59.Transparency = 1;
            end;
        end;
        local function v68() --[[ Line: 197 ]]
            -- upvalues: u57 (copy), u58 (copy), l__PrimaryPart__9 (copy)
            local v62 = u57:GetAttribute("Age") or 0;
            for _, v63 in u58 do
                local v64 = v63[1];
                local v65 = v63[2];
                local v66 = v63[3];
                local v67 = math.min(v62 - v63[4], 1);
                if v67 > 0 then
                    v64.Size = Vector3.new(v65.X, v65.Y * v67, v65.Z);
                    v64.CFrame = l__PrimaryPart__9.CFrame * v66 * CFrame.new(0, (v64.Size.Y - v65.Y) / 2, 0);
                    v64.Transparency = v64:GetAttribute("OG_Transparency") or 0;
                    v64.CanCollide = true;
                else
                    v64.Transparency = 1;
                    v64.CanCollide = false;
                end;
            end;
        end;
        u57:GetAttributeChangedSignal("Age"):Connect(v68);
        v68();
    end,
    Extras = {}
};