-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        local v4 = (p3 or 1) * 0.5 + 0.5;
        local v5 = Random.new(p2);
        local l__FruitSpawnLocations__1 = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local u6 = 0;
        local u7 = {};
        local u8 = {};
        local l__Cactus_Cylinder__3 = script.Cactus_Cylinder;
        local l__Cactus_Ball__4 = script.Cactus_Ball;
        local l__Cactus_Prickle__5 = script.Cactus_Prickle;
        if v5:NextNumber() < 0.08 then
            v5:NextNumber(2, 3);
        end;
        u1:SetAttribute("BigSpikes", false);
        local v9 = v5:NextInteger(4, 5);
        while v5:NextInteger(1, 100) == 1 do
            v9 = v9 * 2;
        end;
        local v10 = v5:NextInteger(20, 30) * 0.1 * (v4 * 0.1 + 1);
        local v11 = v5:NextInteger(20, 30) * 0.1 * (v4 * 0.1 + 1);
        local v12 = Vector3.new(v9, v10, v11);
        local function v15(p13, _) --[[ Line: 68 ]]
            -- upvalues: l__Cactus_Ball__4 (copy), u6 (ref), u1 (copy), u7 (copy)
            local l__Y__6 = p13.Size.Y;
            if p13.Size.Z < l__Y__6 then
                l__Y__6 = p13.Size.Z;
            end;
            local v14 = l__Cactus_Ball__4:Clone();
            v14.Size = Vector3.new(l__Y__6, l__Y__6, l__Y__6);
            v14.CFrame = p13.CFrame * CFrame.new(p13.Size.X / 2, 0, 0);
            u6 = u6 + 1;
            v14.Name = tostring(u6);
            v14.Parent = u1;
            table.insert(u7, v14);
            return v14;
        end;
        local v28, v29 = (function(p16, p17, p18, p19) --[[ Name: createChain, Line 83 ]]
            -- upvalues: l__Cactus_Cylinder__3 (copy), u6 (ref), u1 (copy), u7 (copy), u8 (copy), l__FruitSpawnLocations__1 (copy)
            local v20 = {};
            local v21 = p17.X / 2;
            local v22 = l__Cactus_Cylinder__3:Clone();
            v22.Size = p17;
            v22.CFrame = p18;
            u6 = u6 + 1;
            v22.Name = tostring(u6);
            v22.Parent = u1;
            table.insert(u7, v22);
            table.insert(u8, v22);
            if p19 then
                local v23 = script.Spawn_Object:Clone();
                v23.CFrame = v22.CFrame.Rotation + (v22.Position + Vector3.new(0, v22.Size.Y / 2, 0));
                v23.Parent = l__FruitSpawnLocations__1;
            end;
            v20[1] = v22;
            for v24 = 2, p16 do
                local v25 = CFrame.new(v21 * 2, 0, 0);
                local v26 = v22.CFrame * v25;
                v22 = l__Cactus_Cylinder__3:Clone();
                v22.Size = p17;
                v22.CFrame = v26;
                u6 = u6 + 1;
                v22.Name = tostring(u6);
                v22.Parent = u1;
                table.insert(u7, v22);
                table.insert(u8, v22);
                if p19 then
                    local v27 = script.Spawn_Object:Clone();
                    v27.CFrame = v22.CFrame * CFrame.new(0, 0, v22.Size.X / 3);
                    v27.Parent = l__FruitSpawnLocations__1;
                end;
                v20[v24] = v22;
            end;
            return v20, v22;
        end)(v5:NextInteger(2, 3) + v9 * 0.5, v12, l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0) * CFrame.Angles(0, 0, 1.5707963267948966), false);
        v15(v29, true);
        local v30 = (-1 / 0);
        local v31 = (1 / 0);
        for _, v32 in u8 do
            if v30 < v32.Position.Y then
                v30 = v32.Position.Y;
            end;
            if v32.Position.Y < v31 then
                v31 = v32.Position.Y;
            end;
        end;
        local _ = v30 - v31;
        local l__CFrame__7 = v28[1].CFrame;
        local v33 = (v29.Position - v28[1].Position).Magnitude + v12.X / 2;
        local v34 = math.clamp(v12.X * 0.75, 3, 10);
        local v35 = Vector3.new(v34, v12.Y, v12.Z);
        local v36 = v35.X / 2;
        local v37 = v33 - 5;
        local v38 = 5;
        local v39 = {};
        while true do
            local v40;
            if v38 > v37 then
                local v41 = math.floor(2 * v4 * 1);
                local v42 = math.floor(3 * v4 * 1);
                for _, v43 in u8 do
                    for v44 = 1, v5:NextInteger(v41, v42) do
                        if v44 % 2 ~= 0 then
                            local v45 = l__Cactus_Prickle__5:Clone();
                            v45.Size = Vector3.new((v43.Size.Y + 0.5) * 1, 0.125, 0.125);
                            local v46 = v43.CFrame * CFrame.new(v5:NextNumber(-v43.Size.X, v43.Size.X) * 0.5, 0, 0);
                            local l__Angles__8 = CFrame.Angles;
                            local v47 = v5:NextInteger(-180, 180);
                            v45.CFrame = v46 * l__Angles__8(math.rad(v47), 1.5707963267948966, 0);
                            v40 = u6 + 1;
                            v45.Name = tostring(v40);
                            v45.Parent = u1;
                            v45:AddTag("DetailPart");
                            v45:SetAttribute("Prickle", true);
                            u6 = v40;
                        end;
                    end;
                end;
                for _, v48 in l__FruitSpawnLocations__1:GetChildren() do
                    v48.CFrame = v48.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
                end;
                u1:AddTag("InitializationComplete");
                return;
            end;
            local v49 = nil;
            for _ = 1, 5 do
                local v50 = v5:NextInteger(-180, 180);
                local v51 = true;
                for _, v52 in v39 do
                    if math.abs(v52.dist - v38) < 8 and math.abs((v52.angle - v50 + 180) % 360 - 180) < 35 then
                        v51 = false;
                        break;
                    end;
                end;
                if v51 then
                    table.insert(v39, {
                        dist = v38,
                        angle = v50
                    });
                    v49 = v50;
                end;
            end;
            if v49 then
                local v53 = l__CFrame__7 * CFrame.new(v38, 0, 0) * CFrame.Angles(math.rad(v49), 1.5707963267948966, 0) * CFrame.new(v36, 0, 0);
                local _ = v35.X / 2;
                local v54 = l__Cactus_Cylinder__3:Clone();
                v54.Size = v35;
                v54.CFrame = v53;
                v40 = u6 + 1;
                v54.Name = tostring(v40);
                v54.Parent = u1;
                table.insert(u7, v54);
                table.insert(u8, v54);
                local v55 = script.Spawn_Object:Clone();
                v55.CFrame = v54.CFrame.Rotation + (v54.Position + Vector3.new(0, v54.Size.Y / 2, 0));
                v55.Parent = l__FruitSpawnLocations__1;
                ({})[1] = v54;
                v15(v54, true);
                local v56 = v54.CFrame * CFrame.new(v36, 0, v36) * CFrame.Angles(0, -1.5707963267948966, 0);
                local v57 = {};
                local v58 = v35.X / 2;
                local v59 = l__Cactus_Cylinder__3:Clone();
                v59.Size = v35;
                v59.CFrame = v56;
                v40 = v40 + 1;
                v59.Name = tostring(v40);
                v59.Parent = u1;
                table.insert(u7, v59);
                table.insert(u8, v59);
                v57[1] = v59;
                local v60 = CFrame.new(v58 * 2, 0, 0);
                local v61 = v59.CFrame * v60;
                local v62 = l__Cactus_Cylinder__3:Clone();
                v62.Size = v35;
                v62.CFrame = v61;
                v40 = v40 + 1;
                v62.Name = tostring(v40);
                v62.Parent = u1;
                table.insert(u7, v62);
                table.insert(u8, v62);
                v57[2] = v62;
                v15(v62, true);
                u6 = v40;
            end;
            v38 = v38 + v5:NextNumber(4, 7);
        end;
    end,
    BeginPlantGrowth = function(u63) --[[ Name: BeginPlantGrowth, Line 225 ]]
        local l__PrimaryPart__9 = u63.PrimaryPart;
        local u64 = {};
        for _, v65 in u63:GetDescendants() do
            local v66 = tonumber(v65.Name);
            if v65:IsA("BasePart") and v66 then
                local v67 = {
                    v65,
                    v65.Size,
                    l__PrimaryPart__9.CFrame:ToObjectSpace(v65.CFrame),
                    v66
                };
                table.insert(u64, v67);
                v65.CanCollide = false;
                v65.Transparency = 1;
            end;
        end;
        table.sort(u64, function(p68, p69) --[[ Line: 243 ]]
            return p68[4] < p69[4];
        end);
        local function v76() --[[ Line: 245 ]]
            -- upvalues: u63 (copy), u64 (copy), l__PrimaryPart__9 (copy)
            local v70 = u63:GetAttribute("Age") or 0;
            for _, v71 in u64 do
                local v72 = v71[1];
                local v73 = v71[2];
                local v74 = v71[3];
                local v75 = math.clamp(v70 - v71[4], 0, 1);
                if v75 > 0 then
                    v72.Size = Vector3.new(v73.X * v75, v73.Y, v73.Z);
                    v72.CFrame = l__PrimaryPart__9.CFrame * v74 * CFrame.new(-((v73.X - v72.Size.X) / 2), 0, 0);
                    v72.Transparency = v72:GetAttribute("OG_Transparency") or 0;
                    v72.CanCollide = true;
                else
                    v72.Transparency = 1;
                    v72.CanCollide = false;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u63:GetAttribute("playedSfx") and u63:GetAttribute("MaxAge") <= v70)) then
                u63:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u63:GetAttributeChangedSignal("Age"):Connect(v76);
        v76();
        local l__LocalPlayer__10 = game.Players.LocalPlayer;
        if l__LocalPlayer__10 then
            if u63:GetAttribute("UserId") == l__LocalPlayer__10.UserId then
            else
                local u77 = u63:GetAttribute("BigSpikes") and 10 or 5;
                local u78 = 0;
                local function v81(p79) --[[ Line: 285 ]]
                    -- upvalues: l__LocalPlayer__10 (copy), u78 (ref), u77 (copy)
                    local l__Parent__11 = p79.Parent;
                    if l__Parent__11 then
                        l__Parent__11 = p79.Parent:FindFirstChildOfClass("Humanoid");
                    end;
                    if l__Parent__11 and p79.Parent == l__LocalPlayer__10.Character then
                        local v80 = os.clock();
                        if v80 - u78 < 1 then
                        else
                            u78 = v80;
                            if l__Parent__11.Health > 1 then
                                l__Parent__11.Health = math.max(l__Parent__11.Health - u77, 0);
                            end;
                        end;
                    end;
                end;
                for _, v82 in u63:GetDescendants() do
                    if v82:IsA("BasePart") then
                        v82.Touched:Connect(v81);
                    end;
                end;
            end;
        end;
    end,
    Extras = {}
};