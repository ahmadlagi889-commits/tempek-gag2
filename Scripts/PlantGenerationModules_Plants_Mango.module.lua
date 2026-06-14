-- Decompiled with Potassium's decompiler.

local function u5(p1) --[[ Line: 1 ]]
    local v2 = #p1;
    local v3 = {};
    for v4 = math.floor(v2 * 0.25) + 1, math.ceil(v2 * 0.75) do
        table.insert(v3, p1[v4]);
    end;
    return v3;
end;
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u6, p7, p8) --[[ Name: InitPlant, Line 18 ]]
        -- upvalues: u5 (copy)
        local u9 = p8 or 1;
        local u10 = Random.new(p7);
        local l__FruitSpawnLocations__1 = u6.FruitSpawnLocations;
        local l__Base__2 = u6.Base;
        local u11 = l__Base__2.Position.Y - l__Base__2.Size.Y / 2;
        local u12 = 0;
        local l__Stud_Part__3 = script.Stud_Part;
        local v13 = u10:NextInteger(1, 2);
        if u10:NextInteger(1, 10) == 1 then
            while u10:NextInteger(1, 3) == 1 do
                v13 = v13 + 1;
            end;
        end;
        local u14 = 3 + u9;
        local u15 = 0.3 + u9 * 0.25;
        local u16 = 3 + u9 * 0.5;
        while u10:NextInteger(1, 100) == 1 do
            u16 = u16 + 2;
        end;
        while u10:NextInteger(1, 100) == 1 do
            u15 = u15 + 1;
        end;
        local u17 = 7 * (u9 * 0.25 + 0.75);
        if u10:NextInteger(1, 300) == 1 then
            while u10:NextInteger(1, 2) == 1 do
                u17 = u17 * 2;
            end;
        end;
        local u18 = u10:NextInteger(90, 110) * 0.015;
        while u10:NextInteger(1, 500) == 1 do
            u18 = u18 * 2;
        end;
        local u19 = 4;
        while u10:NextInteger(1, 100) == 1 do
            u19 = u19 + 1;
        end;
        local u20 = {};
        local u21 = 0;
        local u22 = 0;
        local u23 = 0;
        local function u49(p24, p25) --[[ Line: 78 ]]
            -- upvalues: u16 (ref), u14 (copy), u9 (ref), u17 (ref), u10 (copy), u21 (ref), u23 (ref), u22 (ref), l__Stud_Part__3 (copy), u15 (ref), u12 (ref), u11 (copy), u6 (copy), u18 (ref), u20 (copy), u5 (ref), u19 (ref), u49 (copy)
            if u16 > u14 * (0.6 - math.clamp(u9 * 0.1, 0.1, 0.5)) and u17 > 0 then
                local v26 = u10:NextNumber() * 2 - 1;
                local v27 = u10:NextNumber() * 2 - 1;
                if math.sign(u21) == math.sign(v26) then
                    v26 = -v26;
                end;
                u23 = u23 + 1;
                if math.sign(u22) == math.sign(v27) then
                    v27 = -v27;
                end;
                u21 = v26;
                u22 = v27;
                local v28 = {};
                u17 = u17 - 0.5;
                local v29 = v26;
                local v30 = v27;
                local v31 = nil;
                for _ = 1, u17 do
                    v31 = l__Stud_Part__3:Clone();
                    v31.Color = Color3.new(0.509804, 0.372549, 0.235294);
                    v31.Size = Vector3.new(u15, u16, u15);
                    u12 = u12 + 1;
                    v31.Name = tostring(u12);
                    v31.CFrame = p24 * CFrame.new(0, p25.Y / 2 + v31.Size.Y / 2, 0);
                    v31.CFrame = v31.CFrame * CFrame.new(0, -v31.Size.Y / 2, 0) * CFrame.Angles(math.rad(v26), 0, (math.rad(v30))) * CFrame.new(0, v31.Size.Y / 2, 0);
                    if v31.Position.Y - v31.Size.Y / 2 < u11 then
                        v26 = -v26;
                        v30 = -v30;
                        v29 = -v29;
                        v27 = -v27;
                        v31.CFrame = p24 * CFrame.new(0, p25.Y / 2 + v31.Size.Y / 2, 0);
                        v31.CFrame = v31.CFrame * CFrame.new(0, -v31.Size.Y / 2, 0) * CFrame.Angles(math.rad(v26), 0, (math.rad(v30))) * CFrame.new(0, v31.Size.Y / 2, 0);
                    end;
                    v31.Parent = u6;
                    p24 = v31.CFrame;
                    p25 = v31.Size;
                    v26 = v26 + math.clamp(v29, -0.01, 0.01) * 200 * (1 / (u9 * 0.25 + 0.75)) * u18;
                    v30 = v30 + math.clamp(v27, -0.01, 0.01) * 200 * (1 / (u9 * 0.25 + 0.75)) * u18;
                    table.insert(v28, v31);
                end;
                if v31 then
                    table.insert(u20, v31);
                end;
                u16 = u16 * 0.9;
                u15 = u15 * 0.9;
                local v32 = u5(v28);
                local v33 = u19;
                while v33 >= 1 do
                    v33 = v33 - 1;
                    local u34 = v32[math.random(1, #v32)];
                    if u19 - 1 <= v33 then
                        task.spawn(function() --[[ Line: 131 ]]
                            -- upvalues: u49 (ref), u34 (copy), u10 (ref)
                            local v43 = u49;
                            local l__CFrame__6 = u34.CFrame;
                            local l__Angles__7 = CFrame.Angles;
                            local v44 = u10:NextInteger(-25, 25);
                            local v45 = math.rad(v44);
                            local v46 = u10:NextInteger(-25, 25);
                            local v47 = math.rad(v46);
                            local v48 = u10:NextInteger(-25, 25);
                            v43(l__CFrame__6 * l__Angles__7(v45, v47, (math.rad(v48))), u34.Size);
                        end);
                    else
                        local v41 = u10;
                        local v42 = math.round(u14 / u16);
                        if v41:NextInteger(1, (math.max(1, v42))) == 1 then
                            task.spawn(function() --[[ Line: 131 ]]
                                -- upvalues: u49 (ref), u34 (copy), u10 (ref)
                                local v43 = u49;
                                local l__CFrame__6 = u34.CFrame;
                                local l__Angles__7 = CFrame.Angles;
                                local v44 = u10:NextInteger(-25, 25);
                                local v45 = math.rad(v44);
                                local v46 = u10:NextInteger(-25, 25);
                                local v47 = math.rad(v46);
                                local v48 = u10:NextInteger(-25, 25);
                                v43(l__CFrame__6 * l__Angles__7(v45, v47, (math.rad(v48))), u34.Size);
                            end);
                        end;
                    end;
                end;
            end;
        end;
        local v50 = u12 + 1;
        u49(l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0), l__Base__2.Size);
        local v51 = v50;
        local v52 = 1;
        while u10:NextInteger(1, 3) == 1 do
            v52 = v52 + 0.1;
        end;
        for _, v53 in pairs(u20) do
            local v54 = script.Leaf_Part:Clone();
            local v55 = u10:NextInteger(11, 15);
            local v56 = v55 * (u10:NextInteger(7, 9) * 0.1);
            v54.Size = Vector3.new(v55 * (u9 * 0.25 + 0.75) * v52, v56 * (u9 * 0.25 + 0.75) * v52, v55 * (u9 * 0.25 + 0.75) * v52);
            v54.Color = Color3.fromHSV(u10:NextInteger(0, 160) * 0.001, 1, 1);
            v54.Name = tostring(v51);
            v54.CFrame = v53.CFrame * CFrame.new(0, v54.Size.Y / 2, 0);
            local v57 = u10:NextInteger(-180, 180);
            v54.Orientation = Vector3.new(0, v57, 0);
            v54.Parent = u6;
            for _ = 1, 1 do
                local v58 = Instance.new("Part");
                v58.Transparency = 1;
                v58.Anchored = true;
                v58.CanCollide = false;
                v58.Size = Vector3.new(1, 1, 1);
                v58.Parent = l__FruitSpawnLocations__1;
                v58.CFrame = v54.CFrame * CFrame.new(u10:NextInteger(-v54.Size.X, v54.Size.X) * 0.25, -v54.Size.Y / 2, u10:NextInteger(-v54.Size.Z, v54.Size.Z) * 0.25);
            end;
            v50 = v51 + 0.25;
            v51 = v50;
        end;
        u6:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u59) --[[ Name: BeginPlantGrowth, Line 175 ]]
        local l__PrimaryPart__8 = u59.PrimaryPart;
        local u60 = {};
        for _, v61 in u59:GetDescendants() do
            local v62 = tonumber(v61.Name);
            if v61:IsA("BasePart") and v62 then
                local v63 = {
                    v61,
                    v61.Size,
                    l__PrimaryPart__8.CFrame:ToObjectSpace(v61.CFrame),
                    v62
                };
                table.insert(u60, v63);
                v61.CanCollide = false;
                v61.Transparency = 1;
            end;
        end;
        table.sort(u60, function(p64, p65) --[[ Line: 194 ]]
            return p64[4] < p65[4];
        end);
        local function v72() --[[ Line: 196 ]]
            -- upvalues: u59 (copy), u60 (copy), l__PrimaryPart__8 (copy)
            local v66 = u59:GetAttribute("Age") or 0;
            for _, v67 in u60 do
                local v68 = v67[1];
                local v69 = v67[2];
                local v70 = v67[3];
                local v71 = math.clamp(v66 - v67[4], 0, 1);
                if v71 > 0 then
                    v68.Size = Vector3.new(v69.X * v71, v69.Y * v71, v69.Z * v71);
                    v68.CFrame = l__PrimaryPart__8.CFrame * v70 * CFrame.new(0, (v68.Size.Y - v69.Y) / 2, 0);
                    v68.Transparency = v68:GetAttribute("OG_Transparency") or 0;
                    v68.CanCollide = true;
                else
                    v68.Transparency = 1;
                    v68.CanCollide = false;
                end;
            end;
        end;
        u59:GetAttributeChangedSignal("Age"):Connect(v72);
        v72();
    end,
    Extras = {}
};