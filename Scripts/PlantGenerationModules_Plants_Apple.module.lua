-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 6 ]]
        local v4 = p3 or 1;
        local v5 = Random.new(p2);
        local l__FruitSpawnLocations__1 = p1.FruitSpawnLocations;
        local l__Base__2 = p1.Base;
        local l__Stud_Part__3 = script.Stud_Part;
        local v6 = p1:GetAttribute("Mutation") ~= nil;
        local v7 = Color3.fromRGB(139, 90, 43);
        local v8 = 2 + v4;
        local v9 = l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0);
        local l__Size__4 = l__Base__2.Size;
        local v10 = 2 + (v4 * 0.5 + 0.5);
        local v11 = 7 + (v4 * 0.5 + 0.5);
        local v12 = v11;
        local v13 = v10;
        local v14 = 0;
        local v15 = 0.9;
        local v16 = {};
        local v17 = nil;
        local v18 = {};
        while v5:NextInteger(1, 200) == 1 do
            v8 = v8 * v5:NextInteger(7, 12);
            v10 = v10 * v5:NextInteger(5, 7);
            v15 = 0.95;
            while v5:NextInteger(1, 70) == 1 do
                v10 = v10 * v5:NextInteger(2, 3);
                v8 = v8 * v5:NextInteger(2, 3);
            end;
        end;
        for _ = 1, v8 do
            if v13 > 0.5 then
                v17 = l__Stud_Part__3:Clone();
                v17.Size = Vector3.new(v13, v12, v13);
                v17.CFrame = v9 * CFrame.new(0, v17.Size.Y / 2 + l__Size__4.Y / 2, 0);
                if not v6 then
                    v17.Color = v7;
                end;
                v17.Parent = p1;
                v14 = v14 + 1;
                v17.Name = tostring(v14);
                v9 = v17.CFrame;
                l__Size__4 = v17.Size;
                v13 = v13 * v15;
                v12 = v12 * v15;
                table.insert(v16, v17);
            end;
        end;
        table.insert(v18, v17);
        local v19 = v14 + 1;
        local _ = 7 + (v4 * 0.5 + 0.5);
        local v20 = 0;
        for _, v21 in pairs(v16) do
            v20 = v20 + 1;
            for _ = 1, v5:NextInteger(0, v21.Size.Y * 0.5) do
                local v22 = 0;
                local v23 = nil;
                while v23 == nil and v22 < 50 do
                    v22 = v22 + 1;
                    local v24 = v5:NextInteger(0, 360);
                    local v25 = math.clamp(v10 * 0.5, 0.1, v21.Size.X * 0.5);
                    local v26 = Vector3.new(v25, v11, v25);
                    local v27;
                    if v17 == v21 then
                        local v28 = v21.CFrame * CFrame.new(0, -v5:NextInteger(-v21.Size.Y * 3, v21.Size.Y * 10) * 0.04, 0);
                        local l__Angles__5 = CFrame.Angles;
                        local v29 = math.rad(v24);
                        local v30 = v5:NextInteger(45, 70);
                        v27 = v28 * l__Angles__5(0, v29, (math.rad(v30))) * CFrame.new(0, v26.Y / 2, 0);
                    else
                        local v31 = v21.CFrame * CFrame.new(0, -v5:NextInteger(-v21.Size.Y * 10, v21.Size.Y * 10) * 0.04, 0);
                        local l__Angles__6 = CFrame.Angles;
                        local v32 = math.rad(v24);
                        local v33 = v5:NextInteger(45, 70);
                        v27 = v31 * l__Angles__6(0, v32, (math.rad(v33))) * CFrame.new(0, v26.Y / 2, 0);
                    end;
                    local l__Position__7 = v27.Position;
                    local l__LookVector__8 = v27.LookVector;
                    local v34 = true;
                    for _, v35 in pairs(v18) do
                        if v35 ~= v17 and not table.find(v16, v35) then
                            local l__Magnitude__9 = (v35.Position - l__Position__7).Magnitude;
                            if l__Magnitude__9 < 5 then
                                v34 = false;
                                break;
                            end;
                            if l__Magnitude__9 < 10 then
                                local v36 = l__LookVector__8:Dot(v35.CFrame.LookVector);
                                local v37 = math.clamp(v36, -1, 1);
                                local v38 = math.acos(v37);
                                if math.deg(v38) < 20 then
                                    v34 = false;
                                    break;
                                end;
                            end;
                        end;
                    end;
                    if v34 then
                        v23 = l__Stud_Part__3:Clone();
                        v23.Size = v26;
                        v23.CFrame = v27;
                        v23.Name = tostring(v19);
                        if v17 == v21 and not v6 then
                            v23.Color = Color3.new(1, 1, 1);
                        end;
                        if not v6 then
                            v23.Color = v7;
                        end;
                        table.insert(v18, v23);
                        v23.Parent = p1;
                    end;
                end;
            end;
        end;
        local v39 = v19 + 1;
        local v40 = {};
        for _, v41 in pairs(v18) do
            local v42 = l__Stud_Part__3:Clone();
            v42.Shape = Enum.PartType.Ball;
            if v6 then
                v5:NextInteger(250, 375);
                v5:NextInteger(7, 12);
                v5:NextInteger(4, 7);
            else
                local l__fromHSV__10 = Color3.fromHSV;
                local v43 = v5:NextInteger(250, 375) * 0.001;
                local v44 = v5:NextInteger(7, 12);
                v42.Color = l__fromHSV__10(v43, math.clamp(v44, 7, 10) * 0.1, v5:NextInteger(4, 7) * 0.1);
            end;
            local v45 = 10 * (v4 * 0.1 + 0.9);
            local v46;
            if v17 == v41 then
                v46 = v45 * 1.5;
            else
                v46 = v45 * 0.75;
            end;
            v42.Size = Vector3.new(v46, v46, v46);
            v42.CFrame = v41.CFrame * CFrame.new(0, v41.Size.Y / 2 + v42.Size.Y / 2 - 1, 0);
            v42.Name = tostring(v39);
            v42.Parent = p1;
            table.insert(v40, v42);
        end;
        local v47 = RaycastParams.new();
        v47.FilterType = Enum.RaycastFilterType.Include;
        v47.FilterDescendantsInstances = { p1 };
        for _, v48 in pairs(v40) do
            local l__Position__11 = v48.Position;
            local v49 = v48.Size.X / 2;
            for _ = 1, math.round(v48.Size.X) * 0.5 do
                local v50 = v5:NextInteger(0, 360);
                local v51 = math.rad(v50);
                local v52 = v5:NextInteger(15, 165);
                local v53 = math.rad(v52);
                local v54 = math.sin(v53) * math.cos(v51);
                local v55 = math.cos(v53);
                local v56 = math.sin(v53) * math.sin(v51);
                local l__Unit__12 = Vector3.new(v54, v55, v56).Unit;
                local v57 = workspace:Raycast(l__Position__11 + l__Unit__12 * (v49 + 5), -l__Unit__12 * (v49 + 10), v47);
                if v57 and v57.Instance == v48 then
                    local v58 = Instance.new("Part");
                    v58.Size = Vector3.new(1, 1, 1);
                    v58.Transparency = 1;
                    v58.Anchored = true;
                    v58.CanCollide = false;
                    v58.Position = v57.Position;
                    v58.Name = "FruitSpawn";
                    v58.Parent = l__FruitSpawnLocations__1;
                end;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u59) --[[ Name: BeginPlantGrowth, Line 224 ]]
        local l__PrimaryPart__13 = u59.PrimaryPart;
        local u60 = {};
        local u61 = {};
        for _, v62 in u59:GetDescendants() do
            if v62:IsA("BasePart") and v62:HasTag("PlantTruss") then
                table.insert(u60, v62);
            else
                local v63 = tonumber(v62.Name);
                if v62:IsA("BasePart") and v63 then
                    local v64 = {
                        v62,
                        v62.Size,
                        l__PrimaryPart__13.CFrame:ToObjectSpace(v62.CFrame),
                        v63
                    };
                    table.insert(u61, v64);
                    v62.CanCollide = false;
                    v62.Transparency = 1;
                end;
            end;
        end;
        local function v74() --[[ Line: 247 ]]
            -- upvalues: u59 (copy), u61 (copy), l__PrimaryPart__13 (copy), u60 (copy)
            local v65 = u59:GetAttribute("Age") or 0;
            for _, v66 in u61 do
                local v67 = v66[1];
                local v68 = v66[2];
                local v69 = v66[3];
                local v70 = math.min(v65 - v66[4], 1);
                if v70 > 0 then
                    v67.Size = Vector3.new(v68.X, v68.Y * v70, v68.Z);
                    v67.CFrame = l__PrimaryPart__13.CFrame * v69 * CFrame.new(0, (v67.Size.Y - v68.Y) / 2, 0);
                    v67.Transparency = v67:GetAttribute("OG_Transparency") or 0;
                    v67.CanCollide = true;
                else
                    v67.Transparency = 1;
                    v67.CanCollide = false;
                end;
            end;
            for _, v71 in u60 do
                local v72 = v71:GetAttribute("TrunkReference");
                local v73 = tonumber(v72);
                if v73 then
                    if math.min(v65 - v73, 1) >= 1 then
                        v71.CanCollide = true;
                    else
                        v71.CanCollide = false;
                    end;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u59:GetAttribute("playedSfx") and u59:GetAttribute("MaxAge") <= v65)) then
                u59:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u59:GetAttributeChangedSignal("Age"):Connect(v74);
        v74();
    end,
    Extras = {}
};