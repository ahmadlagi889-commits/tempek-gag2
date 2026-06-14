-- Decompiled with Potassium's decompiler.

function RoundSize(p1)
    return math.round(p1 * 100) * 0.01;
end;
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(p2, p3, p4) --[[ Name: InitPlant, Line 11 ]]
        local v5 = Random.new(p3);
        local l__FruitSpawnLocations__1 = p2.FruitSpawnLocations;
        local l__Base__2 = p2.Base;
        local v6 = p4 or 1;
        while v5:NextInteger(1, 200) == 1 do
            v6 = v6 * v5:NextInteger(3, 4);
            while v5:NextInteger(1, 50) == 1 do
                v6 = v6 * v5:NextInteger(3, 4);
            end;
        end;
        local v7 = v5:NextInteger(1, 100) == 1;
        local l__Part__3 = script.Part;
        Color3.new(0, 0.666667, 0);
        Color3.new(0.368627, 0.784314, 0.254902);
        local v8 = v5:NextInteger(2, 3) + v6 * 0.25;
        local v9 = {};
        table.insert(v9, 2 * (v6 * 0.25 + 0.75));
        table.insert(v9, 3 * (v6 * 0.25 + 0.75));
        table.insert(v9, 4 * (v6 * 0.25 + 0.75));
        table.insert(v9, 5 * (v6 * 0.25 + 0.75));
        local v10 = 0;
        for v11 = #v9, 2, -1 do
            local v12 = v5:NextInteger(1, v11);
            local v13 = v9[v12];
            local v14 = v9[v11];
            v9[v11] = v13;
            v9[v12] = v14;
        end;
        local v15 = math.min(v8, #v9);
        local _ = l__Base__2.CFrame;
        local l__CFrame__4 = l__Base__2.CFrame;
        local v16 = {};
        for v17 = 1, v15 do
            local v18 = v9[v17];
            local v19 = v18 * 0.75;
            local v20 = l__Part__3:Clone();
            v20.Size = Vector3.new(v18, v19, v18);
            v10 = v10 + 1;
            v20.Name = tostring(v10);
            v20.CFrame = l__CFrame__4 * CFrame.new(v5:NextInteger(-v18 / 2, v18 / 2), v20.Size.Y / 4, v5:NextInteger(-v18 / 2, v18 / 2));
            v20.Parent = p2;
            table.insert(v16, v20);
            local _ = v20.CFrame;
        end;
        if v7 then
            p2:AddTag("StackedBlueberry");
            local v21 = v16[1];
            for _, v22 in v16 do
                if v22.Size.X > v21.Size.X then
                    v21 = v22;
                end;
            end;
            for v23 = 1, 50 do
                if v23 > 1 and v5:NextInteger(1, 3) ~= 1 then
                    break;
                end;
                local l__X__5 = v21.Size.X;
                local l__Y__6 = v21.Size.Y;
                local v24 = v6 * 0.25 + 0.5;
                local v25 = v5:NextNumber(2, 5) * v24;
                local v26 = v25 * 0.75;
                local v27 = v5:NextNumber(-0.15, 0.15) * l__X__5;
                local v28 = v5:NextNumber(-0.15, 0.15) * l__X__5;
                local v29 = l__Part__3:Clone();
                v29.Size = Vector3.new(v25, v26, v25);
                v10 = v10 + 1;
                v29.Name = tostring(v10);
                v29.CFrame = v21.CFrame * CFrame.new(v27, l__Y__6 / 2 + v26 / 2, v28);
                v29.Parent = p2;
                table.insert(v16, v29);
                local _ = v29.CFrame;
                v21 = v29;
            end;
        end;
        local v30 = RaycastParams.new();
        v30.FilterType = Enum.RaycastFilterType.Include;
        v30.FilterDescendantsInstances = { p2 };
        for _, v31 in pairs(v16) do
            local l__Position__7 = v31.Position;
            local v32 = v31.Size.X / 2;
            for _ = 1, math.round(v31.Size.X) * 0.5 do
                local v33 = v5:NextInteger(0, 360);
                local v34 = math.rad(v33);
                local v35 = v5:NextInteger(15, 165);
                local v36 = math.rad(v35);
                local v37 = math.sin(v36) * math.cos(v34);
                local v38 = math.cos(v36);
                local v39 = math.sin(v36) * math.sin(v34);
                local l__Unit__8 = Vector3.new(v37, v38, v39).Unit;
                local v40 = workspace:Raycast(l__Position__7 + l__Unit__8 * (v32 + 5), -l__Unit__8 * (v32 + 10), v30);
                if v40 and v40.Instance == v31 then
                    local v41 = Instance.new("Part");
                    v41.Size = Vector3.new(1, 1, 1);
                    v41.Transparency = 1;
                    v41.Anchored = true;
                    v41.CanCollide = false;
                    v41.Position = v40.Position;
                    v41.Name = "FruitSpawn";
                    v41.Parent = l__FruitSpawnLocations__1;
                end;
            end;
        end;
        p2:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u42) --[[ Name: BeginPlantGrowth, Line 168 ]]
        local l__PrimaryPart__9 = u42.PrimaryPart;
        local u43 = {};
        for _, v44 in u42:GetDescendants() do
            local v45 = tonumber(v44.Name);
            if v44:IsA("BasePart") and v45 then
                local v46 = {
                    v44,
                    v44.Size,
                    l__PrimaryPart__9.CFrame:ToObjectSpace(v44.CFrame),
                    v45
                };
                table.insert(u43, v46);
                v44.CanCollide = false;
                v44.Transparency = 1;
            end;
        end;
        local function v53() --[[ Line: 186 ]]
            -- upvalues: u42 (copy), u43 (copy), l__PrimaryPart__9 (copy)
            local v47 = u42:GetAttribute("Age") or 0;
            for _, v48 in u43 do
                local v49 = v48[1];
                local v50 = v48[2];
                local v51 = v48[3];
                local v52 = math.min(v47 - v48[4], 1);
                if v52 > 0 then
                    v49.Size = Vector3.new(v50.X, v50.Y * v52, v50.Z);
                    v49.CFrame = l__PrimaryPart__9.CFrame * v51 * CFrame.new(0, (v49.Size.Y - v50.Y) / 2, 0);
                    v49.Transparency = v49:GetAttribute("OG_Transparency") or 0;
                    v49.CanCollide = true;
                else
                    v49.Transparency = 1;
                    v49.CanCollide = false;
                end;
            end;
        end;
        u42:GetAttributeChangedSignal("Age"):Connect(v53);
        v53();
    end,
    Extras = {}
};