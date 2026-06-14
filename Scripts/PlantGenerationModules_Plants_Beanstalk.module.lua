-- Decompiled with Potassium's decompiler.

local u1 = game.ReplicatedStorage.Assets["Meshes/BeanStalkMesh"];
local l__Stud_Part__1 = script.Stud_Part;
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u2, p3, p4) --[[ Name: InitPlant, Line 9 ]]
        -- upvalues: u1 (copy), l__Stud_Part__1 (copy)
        local v5 = p4 or 1;
        local v6 = Random.new(p3);
        local l__FruitSpawnLocations__2 = u2.FruitSpawnLocations;
        local l__Base__3 = u2.Base;
        local l__CollectionService__4 = game:GetService("CollectionService");
        local v7 = 3 * v5 * v6:NextInteger(7, 14) * 0.1;
        local v8 = 2 * v5 * v6:NextInteger(7, 14) * 0.1;
        local v9 = v5 * v6:NextInteger(7, 14) * 0.1;
        local v10 = math.clamp(v9, 1, (1 / 0));
        local v11 = math.sqrt(v10) * 30;
        local u12 = 0;
        while v6:NextInteger(1, 10) == 1 do
            v11 = v11 + 5;
        end;
        local v13 = 3 * v6:NextInteger(7, 14) * 0.1;
        local v14 = l__Base__3.CFrame * CFrame.new(0, -l__Base__3.Size.Y / 2, 0);
        local v15 = 3 * v6:NextInteger(7, 14) * 0.1 * v5;
        local v16 = v6:NextInteger(950, 995) * 0.001;
        local v17 = 0;
        local v18 = {};
        for v19 = 1, v11 do
            u12 = u12 + 1;
            v7 = v7 * v16;
            v8 = v8 * v16;
            local v20 = v19 * 0.1 % 2;
            local v21 = v20 <= 1 and v20 and v20 or 2 - v20;
            v17 = v17 + 10;
            local v22 = math.rad(v17);
            local _ = v7 / 2;
            local v23 = CFrame.new(math.cos(v22) * v15, 0, math.sin(v22) * v15);
            local v24 = u1:Clone();
            v24.Size = Vector3.new(v7 * 2, v8 * 1.25, v7 * 2);
            v24.Color = Color3.fromHSV(0.24500000000000002 + v21 * 0.025, 0.5 + v21 * 0.175, 0.5 + v21 * 0.25);
            v24.CFrame = v14 * v23 * CFrame.new(0, v24.Size.Y / 2, 0);
            v24.Name = tostring(u12);
            v24.Parent = u2;
            if u12 % 2 == 0 then
                table.insert(v18, v24);
            end;
            local v25 = v14 * CFrame.new(0, v8, 0);
            local v26 = v21 * 2;
            local v27 = v21 * 2;
            v14 = v25 * CFrame.Angles(math.rad(-1 + v26), math.rad(v13), (math.rad(-1 + v27)));
        end;
        local function v31(p28) --[[ Line: 73 ]]
            -- upvalues: u12 (ref), l__Stud_Part__1 (ref), u2 (copy), l__CollectionService__4 (copy)
            u12 = u12 + 1;
            local v29 = l__Stud_Part__1:Clone();
            v29.Anchored = true;
            v29.Shape = Enum.PartType.Wedge;
            v29.Size = Vector3.new(p28.Size.Z, p28.Size.Y * 0.5, p28.Size.X / 2);
            v29.CFrame = p28.CFrame * CFrame.new(-p28.Size.X / 4, -(p28.Size.Y / 2 + v29.Size.Y / 2), 0);
            v29.CFrame = v29.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
            v29.CFrame = v29.CFrame * CFrame.Angles(0, 0, 3.141592653589793);
            v29.Color = p28.Color;
            v29.Name = tostring(u12);
            v29.Parent = u2;
            l__CollectionService__4:AddTag(v29, "DetailPart");
            local v30 = l__Stud_Part__1:Clone();
            v30.Shape = Enum.PartType.Wedge;
            v30.Size = Vector3.new(p28.Size.Z, p28.Size.Y * 0.5, p28.Size.X / 2);
            v30.CFrame = p28.CFrame * CFrame.new(p28.Size.X / 4, -(p28.Size.Y / 2 + v30.Size.Y / 2), 0);
            v30.CFrame = v30.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);
            v30.CFrame = v30.CFrame * CFrame.Angles(0, 0, 3.141592653589793);
            v30.Color = p28.Color;
            v30.Name = tostring(u12);
            v30.Parent = u2;
            l__CollectionService__4:AddTag(v30, "DetailPart");
        end;
        for v32 = #v18, 1, -1 do
            local v33 = v18[v32];
            local v34 = u12 + 1;
            local v35 = v33.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
            local l__Angles__5 = CFrame.Angles;
            local v36 = v6:NextInteger(-180, 180);
            local v37 = v35 * l__Angles__5(0, 0, (math.rad(v36)));
            local l__Angles__6 = CFrame.Angles;
            local v38 = -v6:NextInteger(30, 45);
            local v39 = v37 * l__Angles__6(math.rad(v38), 0, 0);
            local l__Magnitude__7 = v33.Size.Magnitude;
            local v40 = l__Stud_Part__1:Clone();
            v40.Color = v33.Color;
            local v41 = 1 * (l__Magnitude__7 * 0.2);
            local v42 = v6:NextInteger(17, 21) * 0.1 * (l__Magnitude__7 * 0.34);
            v40.Size = Vector3.new(v41, v42, 2);
            v40.CFrame = v39 * CFrame.new(0, v40.Size.Y / 2, 0);
            v40.Name = tostring(v34);
            v40.Parent = u2;
            v34 = v34 + 1;
            local v43 = v6:NextInteger(27, 30) * 0.1;
            local v44 = l__Stud_Part__1:Clone();
            v44.Color = v33.Color;
            v44.Size = Vector3.new(v43 * (l__Magnitude__7 * 0.2), v43 * (l__Magnitude__7 * 0.2), 2);
            v44.CFrame = v40.CFrame * CFrame.new(0, v40.Size.Y / 2 + v44.Size.Y / 2, 0) * CFrame.Angles(3.141592653589793, 0, 0);
            v44.Name = tostring(v34);
            v44.Parent = u2;
            l__CollectionService__4:AddTag(v44, "DetailPart");
            v31(v44);
            v44.CFrame = v44.CFrame * CFrame.Angles(3.141592653589793, 0, 0);
            local v45 = l__Stud_Part__1:Clone();
            v45.CanCollide = false;
            v45.Transparency = 1;
            v45.Size = Vector3.new(0.1, 0.1, 0.1);
            v45.CFrame = CFrame.new((v44.CFrame * CFrame.new(0, 0, v44.Size.Z / 2)).Position) * CFrame.Angles(-1.5707963267948966, 0, 0);
            v45.Orientation = Vector3.new(v45.Orientation.X, -v40.Orientation.Y, v45.Orientation.Z);
            v45.Parent = l__FruitSpawnLocations__2;
            v45.Name = "FruitSpawn";
            u12 = v34;
        end;
        u2:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u46) --[[ Name: BeginPlantGrowth, Line 155 ]]
        local l__PrimaryPart__8 = u46.PrimaryPart;
        local u47 = {};
        for _, v48 in u46:GetDescendants() do
            local v49 = tonumber(v48.Name);
            if v48:IsA("BasePart") and v49 then
                local v50 = {
                    v48,
                    v48.Size,
                    l__PrimaryPart__8.CFrame:ToObjectSpace(v48.CFrame),
                    v49
                };
                table.insert(u47, v50);
                v48.CanCollide = false;
                v48.Transparency = 1;
            end;
        end;
        local function v57() --[[ Line: 171 ]]
            -- upvalues: u46 (copy), u47 (copy), l__PrimaryPart__8 (copy)
            local v51 = u46:GetAttribute("Age") or 0;
            for _, v52 in u47 do
                local v53 = v52[1];
                local v54 = v52[2];
                local v55 = v52[3];
                local v56 = math.min(v51 - v52[4], 1);
                if v56 > 0 then
                    v53.Size = Vector3.new(v54.X, v54.Y * v56, v54.Z);
                    v53.CFrame = l__PrimaryPart__8.CFrame * v55 * CFrame.new(0, (v53.Size.Y - v54.Y) / 2, 0);
                    v53.Transparency = v53:GetAttribute("OG_Transparency") or 0;
                    v53.CanCollide = true;
                else
                    v53.Transparency = 1;
                    v53.CanCollide = false;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u46:GetAttribute("playedSfx") and u46:GetAttribute("MaxAge") <= v51)) then
                u46:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u46:GetAttributeChangedSignal("Age"):Connect(v57);
        v57();
    end,
    Extras = {}
};