-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 6 ]]
        local v4 = Random.new(p2);
        local l__FruitSpawnLocations__1 = p1.FruitSpawnLocations;
        local l__Base__2 = p1.Base;
        local v5 = p3 or 1;
        local v6 = 0.75;
        while v4:NextInteger(1, 100) == 1 do
            v6 = v6 * 0.5;
        end;
        local v7 = v6 * (v5 * 0.05 + 0.95);
        while v4:NextInteger(1, 100) == 1 do
            v7 = v7 + 1;
        end;
        local v8 = v4:NextInteger(1, 1000) == 1;
        local v9 = 0;
        local l__Stud_Part__3 = script.Stud_Part;
        local v10 = l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0);
        local l__Size__4 = l__Base__2.Size;
        local v11 = math.round(v5 * 0.5) + 3;
        if v8 == true then
            v11 = v11 * 3;
        end;
        while v4:NextInteger(1, 50) == 1 do
            v11 = v11 + 1;
        end;
        while v4:NextInteger(1, 100) == 1 do
            v11 = v11 + v4:NextInteger(3, 4);
        end;
        local v12 = Color3.new(0.611765, 0.462745, 0.356863);
        local v13 = v4:NextInteger(90, 110) * 0.01;
        local _ = v4:NextInteger(90, 110) * 0.01;
        local v14 = v4:NextInteger(90, 110) * 0.01;
        local v15 = Color3.fromHSV(0.333333 * v13, 1, 0.666667 * v14);
        local v16 = 2 + v5 * 3;
        local v17 = 7;
        if v8 == true then
            v17 = v17 * 0.5;
            v16 = v16 * 0.5;
        end;
        while v4:NextInteger(1, 100) == 1 do
            v17 = v17 + 1;
        end;
        while v4:NextInteger(1, 100) == 1 do
            v17 = v17 + v4:NextInteger(1, 2);
            v16 = v16 + v4:NextInteger(1, 2);
            v11 = v11 + v4:NextInteger(1, 2);
        end;
        local v18 = nil;
        local v19 = v4:NextInteger(2, 7) - math.clamp(v5, 0, 3);
        local v20 = math.clamp(v19, 1, 7);
        local v21 = v4:NextInteger(2, 7) - math.clamp(v5, 0, 3);
        local v22 = math.clamp(v21, 1, 7);
        if v8 == true then
            v20 = v20 * 0.1;
            v22 = v22 * 0.1;
        end;
        if v4:NextInteger(0, 1) == 1 then
            v20 = -v20;
        end;
        if v4:NextInteger(1, 2) == 1 then
            v22 = -v22;
        end;
        local _ = v4:NextInteger(110, 120) * 0.01;
        local v23 = v4:NextInteger(80, 95) * 0.01;
        if v8 == true then
            v23 = v4:NextInteger(97, 99) * 0.01;
        end;
        if v8 == true then
            local v24 = v4:NextInteger(25, 45);
            local v25 = math.sign(v20);
            local v26 = v25 == 0 and 1 or v25;
            local v27 = (4 + v5) * v7;
            local v28 = v17 * 0.6 * v7;
            local v29 = l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0);
            local l__Position__5 = v29.Position;
            local v30 = v16;
            local v31 = v17;
            local v32 = 0;
            for v33 = 1, v11 do
                v9 = v9 + 1;
                if v16 * 0.1 < v30 then
                    v30 = v30 * v23;
                end;
                v31 = v31 + v17 * 0.5;
                local v34 = v33 / v11;
                local v35 = math.sin(v34 * 3.141592653589793);
                v32 = v32 + math.rad(v24) * v26 * v35;
                local v36 = v27 * v35 * (v34 * 0.5 + 1);
                local v37 = v33 * v28;
                local l__Position__6 = v29.Position;
                local v38 = math.cos(v32) * v36;
                local v39 = math.sin(v32) * v36;
                local v40 = l__Position__6 + Vector3.new(v38, v37, v39);
                local v41 = v40 - l__Position__5;
                local l__Magnitude__7 = v41.Magnitude;
                if l__Magnitude__7 < 1e-6 then
                    l__Position__5 = v40;
                else
                    local l__Unit__8 = v41.Unit;
                    local v42 = l__Unit__8:Cross(Vector3.new(0, 1, 0));
                    local v43 = v42.Magnitude < 1e-6 and Vector3.new(1, 0, 0) or v42.Unit;
                    local v44 = v43:Cross(l__Unit__8);
                    local v45 = CFrame.fromMatrix((l__Position__5 + v40) * 0.5, v43, l__Unit__8, v44);
                    v18 = l__Stud_Part__3:Clone();
                    v18.Size = Vector3.new(v30 * v7, l__Magnitude__7, v30 * v7);
                    v18.CFrame = v45;
                    v18.Color = v12;
                    v18.Name = tostring(v9);
                    v18.Parent = p1;
                    l__Position__5 = v40;
                end;
            end;
        else
            local v46 = v17;
            local v47 = v16;
            local v48 = 0;
            local v49 = 0;
            for v50 = 1, v11 do
                v18 = l__Stud_Part__3:Clone();
                v9 = v9 + 1;
                if v50 == 2 then
                    v48 = math.rad(v20);
                    v49 = math.rad(v22);
                end;
                if v16 * 0.1 < v47 then
                    v47 = v47 * v23;
                end;
                v46 = v46 + v17 * 0.5;
                v18.Size = Vector3.new(v47 * v7, v46 * v7, v47 * v7);
                v18.CFrame = v10 * CFrame.new(0, l__Size__4.Y / 2, 0) * CFrame.Angles(v48, 0, v49) * CFrame.new(0, v18.Size.Y / 2, 0);
                v18.Color = v12;
                v18.Name = tostring(v9);
                v18.Parent = p1;
                v10 = v18.CFrame;
                l__Size__4 = v18.Size;
            end;
        end;
        local v51 = v4:NextInteger(6, 7);
        local v52 = v4:NextInteger(5, 6) + math.round(v5 * 0.5);
        while v4:NextInteger(1, 100) == 1 do
            v51 = v51 + v4:NextInteger(1, 3);
        end;
        while v4:NextInteger(1, 100) == 1 do
            v52 = v52 + v4:NextInteger(3, 4);
        end;
        local v53 = 360 - 360 / v51;
        local v54 = math.clamp(15 - v5, 7, 15);
        for v55 = 1, v51 do
            local v56 = v18.CFrame * CFrame.new(0, v18.Size.Y / 2, 0);
            local v57 = CFrame.Angles(0, math.rad(v53 * v55), 0);
            local v58 = CFrame.Angles(0.7853981633974483, 0, 0);
            local v59 = v56 * v57 * v58;
            for v60 = 1, v52 do
                local v61 = l__Stud_Part__3:Clone();
                v61.Size = Vector3.new((5 + v5) * v7, (7 + v5) * v7, (2 + v5) * v7);
                v61.CFrame = v59 * CFrame.new(0, v61.Size.Y / 2, 0);
                v61.CFrame = v61.CFrame * CFrame.new(0, -v61.Size.Y / 2, 0) * CFrame.Angles(math.rad(v54), 0, 0) * CFrame.new(0, v61.Size.Y / 2, 0);
                v61.Name = tostring(v9 + v60);
                v61.Color = v15;
                v61.Parent = p1;
                v59 = v61.CFrame * CFrame.new(0, v61.Size.Y / 2, 0);
                local l__Size__9 = v61.Size;
                local l__CFrame__10 = v61.CFrame;
                local v62 = math.floor(l__Size__9.Y / 8);
                for v63 = 0, math.max(1, v62) - 1 do
                    local v64 = -l__Size__9.Y / 2 + v63 * 8 + 4;
                    local v65 = Instance.new("Part");
                    v65.Anchored = true;
                    v65.CanCollide = false;
                    v65.Transparency = 1;
                    v65.Size = Vector3.new(1, 1, 1);
                    v65.Parent = l__FruitSpawnLocations__1;
                    v65.Name = "SpawnPoint";
                    v65.CFrame = l__CFrame__10 * CFrame.new(0, v64, l__Size__9.Z / 2 + 1);
                end;
            end;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u66) --[[ Name: BeginPlantGrowth, Line 253 ]]
        local l__PrimaryPart__11 = u66.PrimaryPart;
        local u67 = {};
        local u68 = {};
        for _, v69 in u66:GetDescendants() do
            if v69:IsA("BasePart") and v69:HasTag("PlantTruss") then
                table.insert(u67, v69);
            else
                local v70 = tonumber(v69.Name);
                if v69:IsA("BasePart") and v70 then
                    local v71 = {
                        v69,
                        v69.Size,
                        l__PrimaryPart__11.CFrame:ToObjectSpace(v69.CFrame),
                        v70
                    };
                    table.insert(u68, v71);
                    v69.CanCollide = false;
                    v69.Transparency = 1;
                end;
            end;
        end;
        local function v81() --[[ Line: 276 ]]
            -- upvalues: u66 (copy), u68 (copy), l__PrimaryPart__11 (copy), u67 (copy)
            local v72 = u66:GetAttribute("Age") or 0;
            for _, v73 in u68 do
                local v74 = v73[1];
                local v75 = v73[2];
                local v76 = v73[3];
                local v77 = math.min(v72 - v73[4], 1);
                if v77 > 0 then
                    v74.Size = Vector3.new(v75.X, v75.Y * v77, v75.Z);
                    v74.CFrame = l__PrimaryPart__11.CFrame * v76 * CFrame.new(0, (v74.Size.Y - v75.Y) / 2, 0);
                    v74.Transparency = v74:GetAttribute("OG_Transparency") or 0;
                    v74.CanCollide = true;
                else
                    v74.Transparency = 1;
                    v74.CanCollide = false;
                end;
            end;
            for _, v78 in u67 do
                local v79 = v78:GetAttribute("LeafReference");
                local v80 = tonumber(v79);
                if v80 then
                    if math.min(v72 - v80, 1) >= 1 then
                        v78.Transparency = 1;
                        v78.CanCollide = true;
                    else
                        v78.Transparency = 1;
                        v78.CanCollide = false;
                    end;
                end;
            end;
        end;
        u66:GetAttributeChangedSignal("Age"):Connect(v81);
        v81();
    end,
    Extras = {}
};