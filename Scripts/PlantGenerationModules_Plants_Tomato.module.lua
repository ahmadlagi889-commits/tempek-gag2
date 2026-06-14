-- Decompiled with Potassium's decompiler.

return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 6 ]]
        local u4, u5, u6, v7, u8, v9, v10, v11, v12, v13, v14;
        local v15 = 0;
        while true do
            if v15 == 0 then
                v15 = -1;
                -- block 43
                u6 = Random.new(p2);
                v7 = u1.Base;
                local l__Stud_Part__1 = script.Stud_Part;
                local u16 = u1:FindFirstChild("FruitSpawnLocations");
                local v17 = u6:NextInteger(7, 11) + p3 * 10;
                local v18 = math.round(v17 / 1.5);
                v10 = math.max(1, v18);
                local u19 = Color3.fromRGB(70, 170, 70);
                local _ = Enum.Material.Wood;
                local u20 = Color3.fromRGB(70, 170, 70);
                local l__CFrame__2 = v7.CFrame;
                local l__Angles__3 = CFrame.Angles;
                local v21 = u6:NextInteger(-180, 180);
                v7.CFrame = l__CFrame__2 * l__Angles__3(0, math.rad(v21), 0);
                local v22 = v7.CFrame * CFrame.new(0, -v7.Size.Y / 2, 0);
                local l__Position__4 = v22.Position;
                u8 = v22.UpVector;
                while u6:NextInteger(1, 100) == 1 do
                    v17 = v17 * 2;
                end;
                local v23 = v22 - l__Position__4;
                u4 = l__Position__4;
                local v24 = {};
                local u25 = {};
                local function u40(p26, p27, p28) --[[ Line: 87 ]]
                    -- upvalues: u6 (copy), u20 (copy), l__Stud_Part__1 (copy), u1 (copy)
                    local v29 = u6:NextInteger(5, 10) * 0.015;
                    local v30 = Vector3.new(v29, 1, 1);
                    local v31 = u20;
                    local v32 = l__Stud_Part__1:Clone();
                    v32.Size = v30;
                    v32.Color = v31;
                    v32.Material = Enum.Material.Plastic;
                    v32.MaterialVariant = "Studs";
                    v32.Name = p27;
                    v32.Parent = u1;
                    v32:AddTag("DetailPart");
                    local v33 = u6:NextInteger(-30, 30);
                    local v34 = p28 + math.rad(v33);
                    local v35 = p26.Size.X / 2 + v32.Size.X / 2;
                    local v36 = math.cos(v34) * v35;
                    local v37 = math.sin(v34) * v35;
                    local v38 = Vector3.new(v36, 0, v37);
                    v32.CFrame = p26.CFrame + v38;
                    local v39 = -math.deg(v34);
                    v32.Orientation = Vector3.new(0, v39, 30);
                    v32.CFrame = v32.CFrame * CFrame.Angles(0, 0, 1.5707963267948966);
                    v32.CFrame = v32.CFrame * CFrame.new(0, 0.2, v32.Size.Z / 2);
                    v32.CFrame = v32.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
                    return v32;
                end;
                for v41 = 1, v10 do
                    local v42 = math.clamp((v41 - 1) / 6, 0, 1) * 0.2617993877991494;
                    local v43 = v23 * CFrame.Angles(0, (v41 - 1) * 0.7853981633974483 * -1, 0) * CFrame.Angles(v42, 0, 0);
                    local v44 = CFrame.new(l__Position__4) * v43;
                    local v45 = tostring(v41);
                    local v46 = l__Stud_Part__1:Clone();
                    v46.Size = Vector3.new(0.5, 1.5, 0.5);
                    v46.Color = u19;
                    v46.Material = Enum.Material.Plastic;
                    v46.MaterialVariant = "Studs";
                    v46.Name = v45;
                    v46.Parent = u1;
                    v46.CFrame = v44 * CFrame.new(0, 0.75, 0);
                    v24[v41] = v46.CFrame.Position;
                    u25[v41] = v46;
                    l__Position__4 = (v44 * CFrame.new(0, 1.5, 0)).Position;
                end;
                local v47 = (1 / 0);
                local v48 = (-1 / 0);
                local function u68(p49, p50, p51, p52, p53) --[[ Line: 137 ]]
                    -- upvalues: u4 (copy), u8 (copy), u19 (copy), l__Stud_Part__1 (copy), u1 (copy)
                    local v54 = p49 - u4;
                    local v55 = v54 - u8 * v54:Dot(u8);
                    local v56;
                    if v55.Magnitude < 0.05 then
                        local v57 = u8;
                        local v58 = v57:Cross(Vector3.new(1, 0, 0));
                        if v58.Magnitude < 0.05 then
                            v58 = v57:Cross(Vector3.new(0, 0, 1));
                        end;
                        v56 = v58.Unit;
                    else
                        v56 = v55.Unit;
                    end;
                    local v59 = CFrame.fromAxisAngle(u8, (math.rad(p52))) * v56;
                    local v60 = math.rad(p51);
                    local l__Unit__5 = (u8 * math.cos(v60) + v59 * math.sin(v60)).Unit;
                    local v61 = p49 + v59 * 0.25;
                    local v62 = u8;
                    local v63 = l__Unit__5:Dot(v62);
                    if math.abs(v63) > 0.99 then
                        local v64 = l__Unit__5:Cross(Vector3.new(1, 0, 0));
                        if v64.Magnitude < 0.05 then
                            v64 = l__Unit__5:Cross(Vector3.new(0, 0, 1));
                        end;
                        v62 = v64.Unit;
                    end;
                    local l__Unit__6 = v62:Cross(l__Unit__5).Unit;
                    local l__Unit__7 = l__Unit__6:Cross(l__Unit__5).Unit;
                    local v65 = CFrame.fromMatrix(v61, l__Unit__6, l__Unit__5, l__Unit__7);
                    local v66 = u19;
                    local v67 = l__Stud_Part__1:Clone();
                    v67.Size = p50;
                    v67.Color = v66;
                    v67.Material = Enum.Material.Plastic;
                    v67.MaterialVariant = "Studs";
                    v67.Name = p53;
                    v67.Parent = u1;
                    v67.CFrame = v65 * CFrame.new(0, p50.Y / 2, 0);
                    return v65, v59;
                end;
                for v69 = 1, v10 do
                    local l__Y__8 = v24[v69].Y;
                    v47 = math.min(v47, l__Y__8);
                    v48 = math.max(v48, l__Y__8);
                end;
                local v70 = v48 - v47;
                local v71 = v47 + v70 * 0.15;
                local v72 = v48 - v70 * 0.15;
                v9 = {};
                for v73 = 1, v10 do
                    local v74 = v24[v73];
                    if v71 <= v74.Y and v74.Y <= v72 then
                        table.insert(v9, {
                            index = v73,
                            pos = v74
                        });
                    end;
                end;
                u5 = {};
                local v75, v76, v77;
                v75, v76, v77 = ipairs(v9);
                v11 = function(p78) --[[ Name: spawnBranch, Line 205 ]]
                    -- upvalues: u6 (copy), u68 (copy), u40 (copy), u25 (copy), u16 (copy), u5 (copy)
                    local v79 = 4 * u6:NextNumber(0.6, 1.3);
                    local v80 = 60 + u6:NextNumber(-20, 15);
                    local v81 = 20 + u6:NextNumber(-45, 45);
                    local v82 = Vector3.new(0.5, v79, 0.5);
                    local v83 = tostring(p78.index + 0.5);
                    local v84, v85 = u68(p78.pos, v82, v80, v81, v83);
                    local v86 = math.atan2(v85.Z, v85.X);
                    u40(u25[p78.index], tostring(p78.index + 0.75), v86);
                    if u16 then
                        local l__Position__9 = (v84 * CFrame.new(0, v82.Y * 0.5, 0)).Position;
                        local v87 = Instance.new("Part");
                        v87.Size = Vector3.new(0.5, 0.5, 0.5);
                        v87.Transparency = 1;
                        v87.CanCollide = false;
                        v87.Anchored = true;
                        v87.CFrame = CFrame.new(l__Position__9 - Vector3.new(0, 0.5, 0));
                        v87.Name = "FruitSpawn_" .. v83;
                        v87.Parent = u16;
                    end;
                    table.insert(u5, p78.pos);
                end;
                local v88, v89;
                if type(v75) == "function" then
                    v88, v89 = v75(v76, v77);
                else
                    v88, v89 = next(v75, v77);
                end;
                if v88 ~= nil then
                    v77 = v88;
                    v15 = 1;
                    continue;
                else
                    break;
                end;
            elseif v15 == 1 then
                v15 = -1;
                v12 = false;
                v15 = 2;
                continue;
            elseif v15 == 2 then
                v15 = -1;
                if v12 or #v9 * 2 <= v13 then
                    v11(v14);
                    v15 = 4;
                    continue;
                end;
                v15 = 5;
                continue;
            elseif v15 == 3 then
                v15 = -1;
                v12 = true;
                v15 = 2;
                continue;
            elseif v15 == 4 then
                v15 = -1;
                if #u5 >= 1 or #v9 <= 0 then
                    if not u1.PrimaryPart then
                        u1.PrimaryPart = v7;
                    end;
                    local v90 = tostring(v10);
                    local v91 = v10 * 1.5;
                    local v92 = math.ceil(v91 / 10);
                    local v93 = math.max(1, v92);
                    local v94 = v91 / v93;
                    for v95 = 1, v93 do
                        local v96 = Instance.new("TrussPart");
                        v96.Anchored = true;
                        v96.Size = Vector3.new(2, v94, 2);
                        v96.CFrame = CFrame.new(u4 + u8 * ((v95 - 0.5) * v94));
                        v96:SetAttribute("TrunkReference", v90);
                        v96:AddTag("PlantTruss");
                        v96.CanCollide = false;
                        v96.Transparency = 1;
                        v96.Parent = u1;
                    end;
                    u1:AddTag("InitializationComplete");
                    return;
                end;
                v13 = 0;
                v15 = 5;
                continue;
            elseif v15 == 5 then
                v15 = -1;
                v14 = v9[u6:NextInteger(1, #v9)];
                v13 = v13 + 1;
                local l__pos__10 = v14.pos;
                for _, v97 in ipairs(u5) do
                    if (v97 - l__pos__10).Magnitude < 5 then
                        v15 = 1;
                        break;
                    end;
                end;
                if v15 ~= 5 then
                    continue;
                end;
                v15 = 3;
                continue;
            else
                break;
            end;
        end;
    end,
    BeginPlantGrowth = function(u98) --[[ Name: BeginPlantGrowth, Line 276 ]]
        local l__PrimaryPart__11 = u98.PrimaryPart;
        local u99 = {};
        local u100 = {};
        for _, v101 in u98:GetDescendants() do
            if v101:IsA("BasePart") and v101:HasTag("PlantTruss") then
                table.insert(u99, v101);
            else
                local v102 = tonumber(v101.Name);
                if v101:IsA("BasePart") and v102 then
                    local v103 = {
                        v101,
                        v101.Size,
                        l__PrimaryPart__11.CFrame:ToObjectSpace(v101.CFrame),
                        v102
                    };
                    table.insert(u100, v103);
                    v101.CanCollide = false;
                    v101.Transparency = 1;
                end;
            end;
        end;
        table.sort(u100, function(p104, p105) --[[ Line: 298 ]]
            return p104[4] < p105[4];
        end);
        local function v115() --[[ Line: 300 ]]
            -- upvalues: u98 (copy), u100 (copy), l__PrimaryPart__11 (copy), u99 (copy)
            local v106 = u98:GetAttribute("Age") or 0;
            for _, v107 in u100 do
                local v108 = v107[1];
                local v109 = v107[2];
                local v110 = v107[3];
                local v111 = math.min(v106 - v107[4], 1);
                if v111 > 0 then
                    v108.Size = Vector3.new(v109.X, v109.Y * v111, v109.Z);
                    v108.CFrame = l__PrimaryPart__11.CFrame * v110 * CFrame.new(0, (v108.Size.Y - v109.Y) / 2, 0);
                    v108.Transparency = v108:GetAttribute("OG_Transparency") or 0;
                    v108.CanCollide = true;
                else
                    v108.Transparency = 1;
                    v108.CanCollide = false;
                end;
            end;
            for _, v112 in u99 do
                local v113 = v112:GetAttribute("TrunkReference");
                local v114 = tonumber(v113);
                if v114 then
                    if math.min(v106 - v114, 1) >= 1 then
                        v112.CanCollide = true;
                    else
                        v112.CanCollide = false;
                    end;
                end;
            end;
        end;
        u98:GetAttributeChangedSignal("Age"):Connect(v115);
        v115();
    end,
    Extras = {}
};