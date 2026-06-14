-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        local v4 = p3 or 1;
        local u5 = Random.new(p2);
        local l__FruitSpawnLocations__1 = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local l__Stud_Part__3 = script.Stud_Part;
        local v6, v7 = Color3.fromRGB(137, 191, 57);
        local v8, v9, v10 = v6:ToHSV();
        local v11 = v7 or 0.05;
        local v12 = v8 + u5:NextNumber(-v11, v11);
        local v13 = math.clamp(v12, 0.01, 0.99);
        local u14 = Color3.fromHSV(v13, v9, v10);
        local v15 = u5:NextNumber(2.3, 2.7) * (v4 * 0.25 + 0.75);
        local v16 = u5:NextNumber(3.25, 3.75) * (v4 * 0.25 + 0.75);
        local _ = 0 + 1;
        local u17 = l__Stud_Part__3:Clone();
        u17.Parent = u1;
        u17.Anchored = true;
        u17.CanCollide = false;
        u17.Transparency = 1;
        u17.Size = Vector3.new(v15, v16, v15);
        u17.CFrame = l__Base__2.CFrame * CFrame.new(0, v16 * u5:NextNumber(1.1, 1.5), 0);
        u17.Color = u14;
        local v18 = u17:Clone();
        v18.Parent = u1;
        v18.CFrame = u17.CFrame * CFrame.Angles(0, 0.7853981633974483, 0);
        v18.Size = Vector3.new(v18.Size.X, v18.Size.Y * 0.7, v18.Size.Z);
        local v19 = u5:NextInteger(3, (math.floor(5 + v4 * 2)));
        local function v37(p20, p21, p22, p23) --[[ Line: 68 ]]
            -- upvalues: u17 (copy), u5 (copy), l__Base__2 (copy), l__Stud_Part__3 (copy), u1 (copy), u14 (copy)
            local l__Y__4 = u17.Position.Y;
            local v24 = p20 * CFrame.Angles(3.141592653589793, 0, 0);
            local v25 = u5:NextNumber(0.8, 1) * p22;
            local v26 = u5:NextNumber(2.3, 2.85);
            local v27 = Vector3.new(v25, v26, v25);
            local v28 = 0;
            local v29 = {};
            local v30 = p23 or 0;
            while l__Base__2.Position.Y < l__Y__4 do
                local v31 = l__Stud_Part__3:Clone();
                v31.Parent = u1;
                v31.Anchored = true;
                v31.CanCollide = false;
                v31.Transparency = 1;
                local v32 = u5:NextNumber(p21[1], p21[2]);
                local v33 = math.rad(v32);
                if u5:NextInteger(1, 3) == 1 then
                    v33 = v33 * 2;
                end;
                if v28 == 1 and u5:NextNumber(1, 2) == 1 then
                    v33 = -v33;
                end;
                v28 = v28 + 1;
                v31.Size = v27;
                v31.CFrame = v24 * CFrame.Angles(0, 0, v33) * CFrame.new(0, v31.Size.Y / 2.3, 0);
                v31.Color = u14;
                v31.Name = tostring(v28 + v30);
                l__Y__4 = v31.Position.Y;
                v24 = v31.CFrame * CFrame.new(0, v31.Size.Y / 2.3, 0);
                local v34 = v27.X * u5:NextNumber(1.275, 1.45);
                local v35 = v27.Y * u5:NextNumber(1.05, 1.25);
                v27 = Vector3.new(v34, v35, v34);
                table.insert(v29, v31);
                local l__CFrame__5 = v31.CFrame;
                local l__Angles__6 = CFrame.Angles;
                local v36 = u5:NextNumber(-45, 45);
                v31.CFrame = l__CFrame__5 * l__Angles__6(0, math.rad(v36), 0);
            end;
            return v29, v28;
        end;
        local v38, v39 = v37(u17.CFrame * CFrame.new(0, -v16 / 2, 0), { -5, 5 }, 2);
        for _, v40 in v38 do
            local v41 = v39 - tonumber(v40.Name) + 1;
            v40.Name = tostring(v41);
            v40.CFrame = v40.CFrame * CFrame.Angles(3.141592653589793, 0, 0);
        end;
        for v42 = 1, v19 do
            local v43 = u17.CFrame * CFrame.new(0, -v16 * u5:NextNumber(-0.1, 0.3), 0);
            local l__Angles__7 = CFrame.Angles;
            local v44 = 360 / v19 * v42 + u5:NextNumber(-15, 15);
            local v45 = v43 * l__Angles__7(0, math.rad(v44), 0) * CFrame.new(u17.Size.X / 2.5, 0, 0);
            local l__Angles__8 = CFrame.Angles;
            local v46 = u5:NextNumber(42.5, 60);
            v37(v45 * l__Angles__8(0, 0, (math.rad(v46))), { 5, 11 }, 1, v39 + 1);
        end;
        u17.Name = tostring(v39 + 1);
        v18.Name = tostring(v39 + 1);
        u1:PivotTo(u1:GetPivot() * CFrame.new(0, 0.5, 0));
        local v47 = u5:NextInteger(1, (math.floor(2 + v4)));
        local v48 = Vector3.new(u17.Size.X * 0.875, u17.Size.Y * 0.85, u17.Size.Z * 0.875);
        local v49 = u17.CFrame * CFrame.new(0, u17.Size.Y / 2.3, 0);
        local v50 = nil;
        while u5:NextInteger(1, 6) == 1 do
            v47 = v47 + 1;
        end;
        for v51 = 1, v47 do
            local v52 = l__Stud_Part__3:Clone();
            v52.Parent = u1;
            v52.Anchored = true;
            v52.CanCollide = false;
            v52.Transparency = 1;
            v52.Size = v48;
            local l__Angles__9 = CFrame.Angles;
            local v53 = u5:NextNumber(-10, 10);
            local v54 = math.rad(v53);
            local v55 = u5:NextNumber(-25, 25);
            local v56 = math.rad(v55);
            local v57 = u5:NextNumber(-10, 10);
            v52.CFrame = v49 * l__Angles__9(v54, v56, (math.rad(v57))) * CFrame.new(0, v52.Size.Y / 2.3, 0);
            v52.Color = u14;
            v52.Name = tostring(v51 + v39 + 1);
            local v58 = v52:Clone();
            v58.Parent = u1;
            v58.CFrame = v52.CFrame * CFrame.Angles(0, 0.7853981633974483, 0);
            v58.Size = Vector3.new(v58.Size.X, v58.Size.Y * 0.7, v58.Size.Z);
            if v51 == 1 or u5:NextInteger(1, 4) == 1 then
                for v59 = 1, 2 do
                    local v60 = script.Leaf:Clone();
                    local v61 = v59 * 180 + u5:NextNumber(-35, 35) + v51 * 90;
                    v60.Parent = u1;
                    v60:ScaleTo(u5:NextNumber(0.85, 1.15) * (v4 * 0.15 + 0.85));
                    v60:PivotTo(v52.CFrame * CFrame.Angles(0, math.rad(v61), -1.3962634015954636));
                    for _, v62 in v60:GetChildren() do
                        if v62.Name == "1" or v62.Name == "2" then
                            v62.Color = u14;
                        else
                            v62.Color = Color3.fromHSV(v13, v9, v10 - 0.15);
                        end;
                        local v63 = tonumber(v62.Name);
                        if v63 then
                            v62.Name = tostring(v63 + v51 + v39 + 1);
                            v62.Parent = u1;
                        end;
                    end;
                end;
            end;
            local v64 = v48.X * 0.875;
            local v65 = u17.Size.Y * u5:NextNumber(0.875, 1.15);
            v48 = Vector3.new(v64, v65, v48.Z * 0.875);
            v49 = v52.CFrame * CFrame.new(0, v52.Size.Y / 2.3, 0);
            v50 = v52.CFrame * CFrame.new(0, v52.Size.Y / 2, 0);
        end;
        local v66 = u5:NextInteger(2, (math.floor(2 + v4)));
        local v67 = {};
        local v68 = nil;
        for v69 = 1, v66 do
            local v70 = l__Stud_Part__3:Clone();
            v70.Parent = u1;
            v70.Anchored = true;
            v70.CanCollide = false;
            v70.Transparency = 1;
            v70.Size = v48;
            local l__Angles__10 = CFrame.Angles;
            local v71 = u5:NextNumber(-3, 3);
            local v72 = math.rad(v71);
            local v73 = u5:NextNumber(-25, 25);
            local v74 = math.rad(v73);
            local v75 = u5:NextNumber(-3, 3);
            v70.CFrame = v49 * l__Angles__10(v72, v74, (math.rad(v75))) * CFrame.new(0, v70.Size.Y / 2.3, 0);
            v70.Color = u14;
            v70.Name = tostring(v69 + v39 + 1 + v47);
            table.insert(v67, v70);
            v49 = v70.CFrame * CFrame.new(0, v70.Size.Y / 2.3, 0);
            v68 = v70.CFrame * CFrame.new(0, v70.Size.Y / 2, 0);
        end;
        local l__Magnitude__11 = (v50.Position - v68.Position).Magnitude;
        for v76 = 1, 2 do
            local v77 = 360 / l__Magnitude__11;
            if v76 == 1 then
                v77 = v77 + 180;
            end;
            local v78 = math.floor(l__Magnitude__11);
            local v79 = v50;
            local v80 = 1;
            for v81 = 1, v78 do
                local l__new__12 = CFrame.new;
                local v82 = math.rad(v77);
                local v83 = math.cos(v82) * v15;
                local v84 = math.rad(v77);
                local v85 = v50 * l__new__12(v83, v80, math.sin(v84) * v15);
                local v86 = l__Stud_Part__3:Clone();
                v86.Parent = u1;
                v86.Anchored = true;
                v86.CanCollide = false;
                v86.Transparency = 1;
                local v87 = (v79.Position - v85.Position).Magnitude * 1.1;
                local v88 = v15 * 0.5;
                if v81 % 2 == 0 then
                    v88 = v15 * 0.4;
                end;
                if v81 == v78 then
                    v87 = v87 * 1.4;
                    v85 = v68;
                end;
                v86.Size = Vector3.new(v88, v87, v88);
                v86.CFrame = CFrame.lookAt(v79.Position, v85.Position) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, v87 / 2, 0);
                local v89;
                if v81 % 2 == 0 then
                    v89 = Color3.fromHSV(v13, v9, v10 - 0.15) or u14;
                else
                    v89 = u14;
                end;
                v86.Color = v89;
                v86.Name = tostring(v81 + v47 + v39 + 2);
                v80 = v80 + 1;
                v77 = v77 + 360 / v66 * 0.35;
                v79 = v85;
            end;
        end;
        local v90 = v66 + v39 + 2 + v47;
        local v91 = l__Stud_Part__3:Clone();
        v91.Parent = u1;
        v91.Anchored = true;
        v91.CanCollide = false;
        v91.Transparency = 1;
        v91.Size = Vector3.new(v48.X * 1.3, v48.Y * 0.75, v48.Z * 1.3);
        v91.CFrame = v68 * CFrame.new(0, v91.Size.Y / 2, 0);
        v91.Color = u14;
        v91.Name = tostring(v90);
        for v92 = 1, 4 do
            local v93 = v91.CFrame * CFrame.Angles(0, math.rad(v92 * 90), 0) * CFrame.new(0, 0, v91.Size.Z / 1.85);
            local v94 = l__Stud_Part__3:Clone();
            v94.Parent = u1;
            v94.Anchored = true;
            v94.CanCollide = false;
            v94.Transparency = 1;
            local v95 = u5:NextNumber(v91.Size.X * 0.65, v91.Size.X * 0.85);
            local v96 = v95 * u5:NextNumber(1, 1.5);
            v94.Size = Vector3.new(v95, v96, v95 * 0.425);
            local l__Angles__13 = CFrame.Angles;
            local v97 = u5:NextNumber(28, 43);
            v94.CFrame = v93 * l__Angles__13(math.rad(v97), 0, 0);
            v94.Color = u14;
            v94.Name = tostring(v90 + 1);
            local v98 = l__Stud_Part__3:Clone();
            v98.Parent = u1;
            v98.Anchored = true;
            v98.CanCollide = false;
            v98.Transparency = 1;
            local v99 = v94.Size.X * 0.8;
            local v100 = v94.Size.Y * u5:NextNumber(0.3, 0.45);
            v98.Size = Vector3.new(v99, v100, v94.Size.Z * 0.8);
            v98.CFrame = v94.CFrame * CFrame.new(0, v94.Size.Y / 2 + v98.Size.Y / 2.1, 0);
            v98.Color = Color3.fromHSV(v13, v9, v10 - 0.15);
            v98.Name = tostring(v90 + 2);
        end;
        local v101 = l__Stud_Part__3:Clone();
        v101.Parent = u1;
        v101.Anchored = true;
        v101.CanCollide = false;
        v101.Transparency = 1;
        v101.Size = Vector3.new(1, 1, 1);
        v101.CFrame = v91.CFrame * CFrame.new(0, v91.Size.Y / 2, 0);
        v101.Transparency = 1;
        v101.Parent = l__FruitSpawnLocations__1;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u102) --[[ Name: BeginPlantGrowth, Line 348 ]]
        local l__PrimaryPart__14 = u102.PrimaryPart;
        local u103 = {};
        for _, v104 in u102:GetDescendants() do
            local v105 = tonumber(v104.Name);
            if v104:IsA("BasePart") and v105 then
                local v106 = {
                    v104,
                    v104.Size,
                    l__PrimaryPart__14.CFrame:ToObjectSpace(v104.CFrame),
                    v105
                };
                table.insert(u103, v106);
                v104.CanCollide = false;
                v104.Transparency = 1;
            end;
        end;
        local function v113() --[[ Line: 366 ]]
            -- upvalues: u102 (copy), u103 (copy), l__PrimaryPart__14 (copy)
            local v107 = u102:GetAttribute("Age") or 0;
            u102:GetAttribute("MaxAge");
            for _, v108 in u103 do
                local v109 = v108[1];
                local v110 = v108[2];
                local v111 = v108[3];
                local v112 = math.min(v107 - v108[4], 1);
                if v112 > 0 then
                    v109.Size = Vector3.new(v110.X, v110.Y * v112, v110.Z);
                    v109.CFrame = l__PrimaryPart__14.CFrame * v111 * CFrame.new(0, (v109.Size.Y - v110.Y) / 2, 0);
                    v109.Transparency = v109:GetAttribute("OG_Transparency") or 0;
                    v109.CanCollide = true;
                else
                    v109.Transparency = 1;
                    v109.CanCollide = false;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u102:GetAttribute("playedSfx") and u102:GetAttribute("MaxAge") <= v107)) then
                u102:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u102:GetAttributeChangedSignal("Age"):Connect(v113);
        v113();
    end,
    Extras = {}
};