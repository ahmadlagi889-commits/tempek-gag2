-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        local v4 = Random.new(p2);
        local _ = p1.FruitSpawnLocations;
        local l__Base__1 = p1.Base;
        local v5 = 0.75 + (p3 or 1) * 0.25;
        local v6 = 4 * v5;
        local v7 = 5 * v5;
        local v8 = 0.3 * v5;
        local l__CFrame__2 = l__Base__1.CFrame;
        local l__Size__3 = l__Base__1.Size;
        local v9 = 0;
        local v10 = {};
        for _ = 1, 1000 do
            if v6 > 1.5 then
                v9 = v9 + 1;
                v6 = v6 - v8;
                v7 = v7 - v8 * 0.5;
                local v11 = game.ReplicatedStorage.Assets.Stud_Part:Clone();
                v11.Size = Vector3.new(v6, v7, v6);
                v11.CFrame = l__CFrame__2 * CFrame.new(0, l__Size__3.Y / 2 + v11.Size.Y / 2, 0);
                v11.Anchored = true;
                v11.CanCollide = false;
                v11.Color = Color3.new(0.27451, 0.180392, 0.0627451);
                v11.Name = tostring(v9);
                l__CFrame__2 = v11.CFrame;
                l__Size__3 = v11.Size;
                v11.Parent = p1;
                table.insert(v10, v11);
            end;
        end;
        local v12 = 0;
        local v13 = 0;
        local v14 = {};
        for _, v15 in pairs(v10) do
            local v16 = math.sqrt(v15.Size.X * 15);
            local v17 = math.round(v16);
            v12 = v12 + 1;
            for v18 = 1, v17 do
                v9 = v9 + 1;
                local v19 = 360 / v17 * v18;
                local v20 = v15:Clone();
                v20.Size = Vector3.new(v15.Size.X * 0.5, v15.Size.Y, v15.Size.X * 0.5);
                if v13 < v20.Size.X then
                    v13 = v20.Size.X;
                end;
                local l__CFrame__4 = v15.CFrame;
                local l__Angles__5 = CFrame.Angles;
                local v21 = math.rad(v19 + v12 * 5);
                local v22 = v4:NextInteger(-20, 20);
                local v23 = l__CFrame__4 * l__Angles__5(0, v21, (math.rad(v22)));
                local l__Angles__6 = CFrame.Angles;
                local v24 = 90 - v12 * 10 + v4:NextInteger(-10, 10) * (v12 * 0.5 + 1);
                local v25 = math.clamp(v24, 5, 90);
                v20.CFrame = v23 * l__Angles__6(math.rad(v25), 0, 0) * CFrame.new(0, v20.Size.Y / 2, 0);
                v20.Name = tostring(v9);
                v20.Anchored = true;
                v20.Parent = p1;
                table.insert(v14, v20);
            end;
        end;
        local v26 = (1 / 0);
        local v27 = (-1 / 0);
        for _, v28 in pairs(v14) do
            if v28.Position.Y < v26 then
                v26 = v28.Position.Y;
            end;
            if v27 < v28.Position.Y then
                v27 = v28.Position.Y;
            end;
        end;
        for _, v29 in pairs(v14) do
            v9 = v9 + 1;
            local v30 = v29.Size.X * 3 + 1;
            local v31 = math.clamp(1 + v29.Size.X * 0.25, 1, 3);
            local v32 = 0.3 + (v27 == v26 and 0.5 or (v29.Position.Y - v26) / (v27 - v26)) * 0.5;
            for _ = 1, v31 do
                local v33 = v29:Clone();
                v33.Size = Vector3.new(v30, v30, v30);
                v33.Name = tostring(v9);
                v33.Color = Color3.fromHSV(0.333333, 0.876921, v32);
                v33.Parent = p1;
                v33.CFrame = v29.CFrame * CFrame.new(0, v29.Size.Y / 2 + v33.Size.Y / 2, 0);
                local v34 = v4:NextInteger(0, 360);
                local v35 = v4:NextInteger(0, 360);
                v33.Orientation = Vector3.new(v34, v35, v4:NextInteger(0, 360));
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u36) --[[ Name: BeginPlantGrowth, Line 106 ]]
        local l__PrimaryPart__7 = u36.PrimaryPart;
        local u37 = {};
        for _, v38 in u36:GetDescendants() do
            local v39 = tonumber(v38.Name);
            if v38:IsA("BasePart") and v39 then
                local v40 = {
                    v38,
                    v38.Size,
                    l__PrimaryPart__7.CFrame:ToObjectSpace(v38.CFrame),
                    v39
                };
                table.insert(u37, v40);
                v38.CanCollide = false;
                v38.Transparency = 1;
            end;
        end;
        local function v47() --[[ Line: 124 ]]
            -- upvalues: u36 (copy), u37 (copy), l__PrimaryPart__7 (copy)
            local v41 = u36:GetAttribute("Age") or 0;
            for _, v42 in u37 do
                local v43 = v42[1];
                local v44 = v42[2];
                local v45 = v42[3];
                local v46 = math.min(v41 - v42[4], 1);
                if v46 > 0 then
                    v43.Size = Vector3.new(v44.X, v44.Y * v46, v44.Z);
                    v43.CFrame = l__PrimaryPart__7.CFrame * v45 * CFrame.new(0, (v43.Size.Y - v44.Y) / 2, 0);
                    v43.Transparency = v43:GetAttribute("OG_Transparency") or 0;
                    v43.CanCollide = true;
                else
                    v43.Transparency = 1;
                    v43.CanCollide = false;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u36:GetAttribute("playedSfx") and u36:GetAttribute("MaxAge") <= v41)) then
                u36:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u36:GetAttributeChangedSignal("Age"):Connect(v47);
        v47();
    end,
    Extras = {}
};