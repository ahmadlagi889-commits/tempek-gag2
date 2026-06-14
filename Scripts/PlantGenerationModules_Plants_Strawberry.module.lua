-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(p1, p2, p3) --[[ Name: InitPlant, Line 7 ]]
        local v4 = math.round((p3 or 1) * 10) * 0.1;
        local v5 = Random.new(p2);
        local l__FruitSpawnLocations__1 = p1.FruitSpawnLocations;
        local l__Base__2 = p1.Base;
        local l__Stud_Part__3 = script.Stud_Part;
        local v6 = Color3.new(0, 0.666667, 0);
        Color3.new(0.368627, 0.784314, 0.254902);
        local v7 = v5:NextInteger(1, 2);
        local v8 = 1;
        while v5:NextInteger(1, 3) == 1 do
            v7 = v7 + 1;
        end;
        if v5:NextInteger(1, 100) == 1 then
            v7 = v7 + v5:NextInteger(13, 15);
        end;
        local v9 = l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0);
        local l__Size__4 = l__Base__2.Size;
        for v10 = 1, v7 do
            local v11 = 0.25 * v4;
            local v12 = 1.5 * v4;
            local v13 = l__Stud_Part__3:Clone();
            v13.Color = v6;
            v13.Name = tostring(v8);
            v13.Size = Vector3.new(v11, v12, v11);
            v13.CFrame = v9 * CFrame.new(0, v13.Size.Y / 2, 0);
            local l__CFrame__5 = v13.CFrame;
            local l__Angles__6 = CFrame.Angles;
            local v14 = v5:NextInteger(-15, 15);
            local v15 = math.rad(v14);
            local v16 = v5:NextInteger(-15, 15);
            local v17 = math.rad(v16);
            local v18 = v5:NextInteger(-15, 15);
            v13.CFrame = l__CFrame__5 * l__Angles__6(v15, v17, (math.rad(v18)));
            v13.CFrame = v13.CFrame * CFrame.new(0, l__Size__4.Y / 2, 0);
            v13.CFrame = v13.CFrame * CFrame.Angles(0, math.rad(v10 * 5), 0);
            v13.Parent = p1;
            local v19 = v8 + 1;
            local v20 = l__Stud_Part__3:Clone();
            v20.Color = v6;
            v20.Name = tostring(v19);
            local v21 = v11 * 0.85;
            local v22 = v5:NextNumber(v12 / 4, v12 / 3.3);
            v20.Size = Vector3.new(v21, v22, v11 * 0.85);
            v20.CFrame = v13.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
            local l__CFrame__7 = v20.CFrame;
            local l__Angles__8 = CFrame.Angles;
            local v23 = v5:NextInteger(-15, 15);
            local v24 = math.rad(v23);
            local v25 = v5:NextInteger(-15, 15);
            local v26 = math.rad(v25);
            local v27 = v5:NextInteger(-15, 15);
            v20.CFrame = l__CFrame__7 * l__Angles__8(v24, v26, (math.rad(v27)));
            v20.CFrame = v20.CFrame * CFrame.new(0, v20.Size.Y / 2 + v13.Size.X / 2, 0);
            v20.Parent = p1;
            local v28 = l__Stud_Part__3:Clone();
            v28.Size = Vector3.new(1, 1, 1);
            v28.Parent = l__FruitSpawnLocations__1;
            v28.CFrame = v20.CFrame * CFrame.new(0, v20.Size.Y / 2, 0);
            v28.Transparency = 1;
            local v29 = v19 + 1;
            local v30 = l__Stud_Part__3:Clone();
            v30.Color = v6;
            v30.Name = tostring(v29);
            local v31 = v11 * 0.85;
            local v32 = v5:NextNumber(v12 / 4, v12 / 3.3);
            v30.Size = Vector3.new(v31, v32, v11 * 0.85);
            v30.CFrame = v13.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
            local l__CFrame__9 = v30.CFrame;
            local l__Angles__10 = CFrame.Angles;
            local v33 = v5:NextInteger(-15, 15);
            local v34 = math.rad(v33);
            local v35 = v5:NextInteger(-15, 15);
            local v36 = math.rad(v35);
            local v37 = v5:NextInteger(-15, 15);
            v30.CFrame = l__CFrame__9 * l__Angles__10(v34, v36, (math.rad(v37)));
            v30.CFrame = v30.CFrame * CFrame.new(0, v30.Size.Y / 2 + v13.Size.X / 2, 0);
            v30.Parent = p1;
            local v38 = l__Stud_Part__3:Clone();
            v38.Size = Vector3.new(1, 1, 1);
            v38.Parent = l__FruitSpawnLocations__1;
            v38.CFrame = v30.CFrame * CFrame.new(0, v30.Size.Y / 2, 0);
            v38.Transparency = 1;
            local v39 = script.Leaves:Clone();
            v39:PivotTo(v13.CFrame * CFrame.new(0, v13.Size.Y / 2, 0));
            v39:ScaleTo(v4);
            v39.PrimaryPart:Destroy();
            v8 = v29 + 1;
            for _, v40 in pairs(v39:GetChildren()) do
                v40.Parent = p1;
                v40.Name = tostring(v8);
            end;
            v9 = v13.CFrame;
            l__Size__4 = v13.Size;
        end;
        p1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u41) --[[ Name: BeginPlantGrowth, Line 109 ]]
        local l__PrimaryPart__11 = u41.PrimaryPart;
        local u42 = {};
        for _, v43 in u41:GetDescendants() do
            local v44 = tonumber(v43.Name);
            if v43:IsA("BasePart") and v44 then
                local v45 = {
                    v43,
                    v43.Size,
                    l__PrimaryPart__11.CFrame:ToObjectSpace(v43.CFrame),
                    v44
                };
                table.insert(u42, v45);
                v43.CanCollide = false;
                v43.Transparency = 1;
            end;
        end;
        local function v52() --[[ Line: 127 ]]
            -- upvalues: u41 (copy), u42 (copy), l__PrimaryPart__11 (copy)
            local v46 = u41:GetAttribute("Age") or 0;
            for _, v47 in u42 do
                local v48 = v47[1];
                local v49 = v47[2];
                local v50 = v47[3];
                local v51 = math.min(v46 - v47[4], 1);
                if v51 > 0 then
                    v48.Size = Vector3.new(v49.X, v49.Y * v51, v49.Z);
                    v48.CFrame = l__PrimaryPart__11.CFrame * v50 * CFrame.new(0, (v48.Size.Y - v49.Y) / 2, 0);
                    v48.Transparency = v48:GetAttribute("OG_Transparency") or 0;
                    v48.CanCollide = true;
                else
                    v48.Transparency = 1;
                    v48.CanCollide = false;
                end;
            end;
        end;
        u41:GetAttributeChangedSignal("Age"):Connect(v52);
        v52();
    end,
    Extras = {}
};