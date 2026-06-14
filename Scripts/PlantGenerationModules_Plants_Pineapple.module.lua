-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 6 ]]
        local v4 = p3 or 1;
        local u5 = Random.new(p2);
        local l__PrimaryPart__1 = u1.PrimaryPart;
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Stud_Part__3 = script.Stud_Part;
        local v6 = 4 + v4;
        local u7 = u5:NextInteger(4, 11);
        local u8 = Color3.new(0, 0.666667, 0);
        local u9 = 0;
        local function v15(p10, p11, p12) --[[ Line: 26 ]]
            -- upvalues: u8 (copy), u7 (ref), u1 (copy), u9 (ref)
            local v13 = 1;
            for _ = 1, p11 do
                local v14 = script.Stud_Part:Clone();
                v14.Name = tostring(v13);
                v14.Size = p12;
                v14.Color = u8;
                v14.CFrame = p10 * CFrame.new(0, v14.Size.Y / 2 + p12.Y / 2, 0) * CFrame.new(0, -v14.Size.Y / 2, 0) * CFrame.Angles(math.rad(u7), 0, 0) * CFrame.new(0, v14.Size.Y / 2, 0);
                v14.Parent = u1;
                p10 = v14.CFrame;
                p12 = v14.Size;
                v13 = v13 + 1;
                if u9 < v13 then
                    u9 = v13;
                end;
            end;
        end;
        local v16 = (360 + 360 / v6) / v6;
        local v17 = u5:NextInteger(1, 10) == 1 and 3 or 1.25;
        local v18 = Vector3.new(v17, 0.5 + v4 * 0.2, 1);
        local v19 = 1;
        if u5:NextInteger(1, 10) == 1 then
            v19 = v19 + 1;
        end;
        local v20 = -u5:NextInteger(13, 15);
        local v21, u22, v23;
        if u5:NextInteger(1, 700) == 1 then
            v21 = u7;
            u22 = u9;
            v23 = 2;
            while u5:NextInteger(1, 500) == 1 do
                v23 = v23 * 2;
            end;
        else
            v21 = u7;
            u22 = u9;
            v23 = 1;
        end;
        if v23 > 1 then
            u7 = v21 / (v23 * 1.5);
        end;
        for v24 = 0, v19 do
            for v25 = 1, v6 do
                local v26 = v16 * v25;
                local v27 = l__PrimaryPart__1.CFrame * CFrame.new(0, -l__PrimaryPart__1.Size.Y / 2, 0) * CFrame.new(0, -v18.Y / 2, 0) * CFrame.Angles(0, math.rad(v26 + v24 * 90), 0);
                local l__Angles__4 = CFrame.Angles;
                local v28 = u5:NextInteger(7, 15) + v20 * v24;
                v15(v27 * l__Angles__4(math.rad(v28), 0, 0), v23 * 11, v18);
            end;
        end;
        local function v37(p29, p30, p31) --[[ Line: 91 ]]
            -- upvalues: u22 (ref), u5 (copy), u8 (copy), u1 (copy), l__Stud_Part__3 (copy), l__FruitSpawnLocations__2 (copy)
            local v32 = u22;
            local v33 = u5:NextInteger(-5, 5);
            local v34 = u5:NextInteger(-5, 5);
            local v35 = nil;
            for _ = 1, p31 do
                v35 = script.Stud_Part:Clone();
                v35.Name = tostring(v32);
                v35.Size = p29;
                v35.Color = u8;
                v35.CFrame = p30 * CFrame.new(0, v35.Size.Y / 2 + p29.Y / 2, 0) * CFrame.new(0, -v35.Size.Y / 2, 0) * CFrame.Angles(math.rad(v33), 0, (math.rad(v34))) * CFrame.new(0, v35.Size.Y / 2, 0);
                v35.Name = tostring(v32);
                v35.Parent = u1;
                p30 = v35.CFrame;
                p29 = v35.Size;
                v32 = v32 + 1;
                if u22 < v32 then
                    u22 = v32;
                end;
            end;
            local v36 = l__Stud_Part__3:Clone();
            v36.Size = Vector3.new(1, 1, 1);
            v36.Transparency = 1;
            v36.CanCollide = false;
            v36.CFrame = v35.CFrame * CFrame.new(0, v35.Size.Y / 2, 0) * CFrame.new(0, v36.Size.Y / 2, 0);
            v36.Parent = l__FruitSpawnLocations__2;
        end;
        if u5:NextInteger(1, 10) == 1 then
            local v38 = u5:NextInteger(2, 5);
            local v39 = (360 + 360 / v38) / v38;
            for v40 = 1, v38 do
                local v41 = v39 * v40;
                local v42 = u5:NextInteger(3, 5);
                local v43 = Vector3.new(2, v42, 2);
                local v44 = l__PrimaryPart__1.CFrame * CFrame.new(0, -l__PrimaryPart__1.Size.Y / 2, 0) * CFrame.new(0, -v43.Y / 2, 0) * CFrame.Angles(0, math.rad(v41), 0);
                local l__Angles__5 = CFrame.Angles;
                local v45 = u5:NextInteger(1, 3);
                v37(v43, v44 * l__Angles__5(math.rad(v45), 0, 0), u5:NextInteger(3, 4));
            end;
        else
            local v46 = l__Stud_Part__3:Clone();
            v46.Parent = u1;
            v46.Size = Vector3.new(2, 7 + v4, 2);
            v46.CFrame = l__PrimaryPart__1.CFrame * CFrame.new(0, -l__PrimaryPart__1.Size.Y / 2, 0) * CFrame.new(0, v46.Size.Y / 2, 0);
            v46.Name = tostring(u22);
            v46.Color = Color3.new(0, 0.666667, 0);
            v46.Parent = u1;
            local v47 = l__Stud_Part__3:Clone();
            v47.Size = Vector3.new(1, 1, 1);
            v47.Transparency = 1;
            v47.CanCollide = false;
            v47.CFrame = v46.CFrame * CFrame.new(0, v46.Size.Y / 2, 0) * CFrame.new(0, v47.Size.Y / 2, 0);
            v47.Parent = l__FruitSpawnLocations__2;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u48) --[[ Name: BeginPlantGrowth, Line 169 ]]
        local l__PrimaryPart__6 = u48.PrimaryPart;
        local u49 = {};
        for _, v50 in u48:GetDescendants() do
            local v51 = tonumber(v50.Name);
            if v50:IsA("BasePart") and v51 then
                local v52 = {
                    v50,
                    v50.Size,
                    l__PrimaryPart__6.CFrame:ToObjectSpace(v50.CFrame),
                    v51
                };
                table.insert(u49, v52);
                v50.CanCollide = false;
                v50.Transparency = 1;
            end;
        end;
        table.sort(u49, function(p53, p54) --[[ Line: 188 ]]
            return p53[4] < p54[4];
        end);
        local function v61() --[[ Line: 190 ]]
            -- upvalues: u48 (copy), u49 (copy), l__PrimaryPart__6 (copy)
            local v55 = u48:GetAttribute("Age") or 0;
            for _, v56 in u49 do
                local v57 = v56[1];
                local v58 = v56[2];
                local v59 = v56[3];
                local v60 = math.clamp(v55 - v56[4], 0, 1);
                if v60 > 0 then
                    v57.Size = Vector3.new(v58.X, v58.Y * v60, v58.Z);
                    v57.CFrame = l__PrimaryPart__6.CFrame * v59 * CFrame.new(0, (v57.Size.Y - v58.Y) / 2, 0);
                    v57.Transparency = v57:GetAttribute("OG_Transparency") or 0;
                    v57.CanCollide = true;
                else
                    v57.Transparency = 1;
                    v57.CanCollide = false;
                end;
            end;
        end;
        u48:GetAttributeChangedSignal("Age"):Connect(v61);
        v61();
    end,
    Extras = {}
};