-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, p3) --[[ Name: InitPlant, Line 11 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local u4 = Random.new(p2);
        local _ = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local v5 = p3 or 1;
        for _, v6 in pairs(u1:GetDescendants()) do
            if v6:IsA("BasePart") then
                if v6.Anchored == false then
                    v6:AddTag("OriginallyNotAnchored");
                end;
                v6.Anchored = true;
            end;
        end;
        local v7 = v5 * 1.33;
        local function u14(p8, p9, p10) --[[ Line: 38 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v11 = Instance.new("Part");
            local v12 = p8 or "Studs";
            v11.Parent = u1;
            v11.TopSurface = Enum.SurfaceType[v12];
            v11.BackSurface = Enum.SurfaceType[v12];
            v11.FrontSurface = Enum.SurfaceType[v12];
            v11.BottomSurface = Enum.SurfaceType[v12];
            v11.LeftSurface = Enum.SurfaceType[v12];
            v11.RightSurface = Enum.SurfaceType[v12];
            v11.Anchored = true;
            v11.CanCollide = false;
            v11.Transparency = 1;
            if p10 then
                v11.Shape = Enum.PartType[p10];
            end;
            if p9 then
                v11.MaterialVariant = p9;
                local v13 = l__MaterialService__1:FindFirstChild(p9, true);
                if not v13 then
                    return v11;
                end;
                v11.Material = v13.BaseMaterial;
            end;
            return v11;
        end;
        local u15 = Color3.fromRGB(68, 68, 68);
        local u16 = Color3.fromRGB(163, 62, 59);
        local v17 = u4:NextInteger(6, 10);
        local v18 = math.ceil(v7 * 2);
        local v19 = v17 + math.clamp(v18, 0, 20);
        local function v50(p20, p21, p22) --[[ Line: 74 ]]
            -- upvalues: u4 (copy), u15 (copy), u16 (copy), u14 (copy), u1 (copy)
            local v23 = p20:GetPivot() * CFrame.new(0, p20.Size.Y / 2, 0);
            local v24 = Instance.new("Model");
            local v25 = 0;
            for v26 = 1, p21 do
                local v27 = script.Stud_Part:Clone();
                local v28 = 4 + u4:NextNumber(-1.5, 1.5);
                local v29 = math.min(8, v25 * 0.15);
                local v30 = math.rad(v26 * 35 + p22);
                local v31 = math.rad((v26 + 1) * 35 + p22);
                local l__Position__3 = v23.Position;
                local v32 = math.cos(v30) * v29;
                local v33 = math.sin(v30) * v29;
                local v34 = l__Position__3 + Vector3.new(v32, v25, v33);
                v25 = v25 + v28;
                local v35 = math.min(8, v25 * 0.15);
                local l__Position__4 = v23.Position;
                local v36 = math.cos(v31) * v35;
                local v37 = math.sin(v31) * v35;
                local v38 = l__Position__4 + Vector3.new(v36, v25, v37);
                v27.Color = u15:Lerp(u16, (math.clamp(v26 / p21, 0, 1)));
                v27.Material = Enum.Material.Glacier;
                v27.MaterialVariant = "2022 Stud LavaCracks";
                v27.Size = Vector3.new(3, (v38 - v34).Magnitude * 1.12, 3);
                local v39 = v34:Lerp(v38, 0.5);
                v27.CFrame = CFrame.lookAt(v39, v38) * CFrame.Angles(1.5707963267948966, 0, 0);
                v27.CFrame = v27.CFrame * CFrame.Angles(3.141592653589793, 0, 0);
                v27.Name = v26;
                v27.Parent = v24;
                if v26 % 4 == 0 and v26 ~= p21 then
                    local v40 = u14();
                    local v41 = v27.CFrame * CFrame.new(0, 0, v27.Size.Z / 2.1);
                    local l__Angles__5 = CFrame.Angles;
                    local v42 = u4:NextInteger(50, 66);
                    local v43 = math.rad(v42);
                    local v44 = u4:NextInteger(-15, 15);
                    local v45 = math.rad(v44);
                    local v46 = u4:NextInteger(-15, 15);
                    v40:PivotTo(v41 * l__Angles__5(v43, v45, (math.rad(v46))));
                    v40.Parent = u1.FruitSpawnLocations;
                elseif v26 % 2 == 0 and v26 ~= p21 then
                    local v47 = v27:Clone();
                    v47.MaterialVariant = "2022 Weld";
                    v47.Color = Color3.fromRGB(68, 55, 55);
                    v47.Size = Vector3.new(v27.Size.X * 1.1, v27.Size.Y * 0.5, v27.Size.Z * 1.1);
                end;
                if v26 == p21 then
                    local v48 = script.Dragon:Clone();
                    v48:PivotTo(v27:GetPivot() * CFrame.new(0, v27.Size.Y / 2, 0));
                    for _, v49 in v48:GetDescendants() do
                        if tonumber(v49.Name) ~= nil then
                            v49.Name = tonumber(v49.Name) + v26;
                        end;
                    end;
                    v48.Parent = u1;
                end;
            end;
            v24.Parent = u1;
        end;
        while u4:NextInteger(1, 5) == 1 do
            v19 = v19 + u4:NextInteger(1, 3);
        end;
        while u4:NextInteger(1, 100) == 1 do
            v19 = v19 * 2;
            if u4:NextInteger(1, 4) == 1 then
                v19 = v19 * 2;
            end;
        end;
        v50(l__Base__2, math.floor(v19), 180);
        local v51 = v19 + math.random(-1, 1);
        while u4:NextInteger(1, 5) == 1 do
            v51 = v51 + u4:NextInteger(1, 3);
        end;
        v50(l__Base__2, math.floor(v51), 0);
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u52) --[[ Name: BeginPlantGrowth, Line 182 ]]
        local l__PrimaryPart__6 = u52.PrimaryPart;
        local u53 = {};
        for _, v54 in u52:GetDescendants() do
            local v55 = tonumber(v54.Name);
            if v54:IsA("BasePart") and v55 then
                local v56 = {};
                for _, v57 in v54:GetChildren() do
                    if v57:IsA("Decal") then
                        table.insert(v56, { v57, v57.Transparency });
                        v57.Transparency = 1;
                    end;
                end;
                local v58 = {
                    v54,
                    v54.Size,
                    l__PrimaryPart__6.CFrame:ToObjectSpace(v54.CFrame),
                    v55,
                    v56
                };
                table.insert(u53, v58);
                v54.CanCollide = false;
                v54.Transparency = 1;
            end;
        end;
        local function v74() --[[ Line: 210 ]]
            -- upvalues: u52 (copy), u53 (copy), l__PrimaryPart__6 (copy)
            local v59 = u52:GetAttribute("Age") or 0;
            for _, v60 in u53 do
                local v61 = v60[1];
                local v62 = v60[2];
                local v63 = v60[3];
                local v64 = v60[4];
                local v65 = v60[5];
                local v66 = math.min(v59 - v64, 1);
                if v66 > 0 then
                    v61.Size = Vector3.new(v62.X, v62.Y * v66, v62.Z);
                    v61.CFrame = l__PrimaryPart__6.CFrame * v63 * CFrame.new(0, (v61.Size.Y - v62.Y) / 2, 0);
                    v61.Transparency = v61:GetAttribute("OG_Transparency") or 0;
                    v61.CanCollide = true;
                    for _, v67 in v61:GetDescendants() do
                        if v67:IsA("ParticleEmitter") then
                            v67.Enabled = true;
                        end;
                    end;
                else
                    v61.Transparency = 1;
                    v61.CanCollide = false;
                    for _, v68 in v61:GetDescendants() do
                        if v68:IsA("ParticleEmitter") then
                            v68.Enabled = false;
                        end;
                    end;
                end;
                local v69 = v66 >= 1;
                for _, v70 in v65 do
                    v70[1].Transparency = v69 and v70[2] or 1;
                end;
            end;
            local v71 = u52:GetAttribute("Age");
            if math.round(v71) / u52:GetAttribute("MaxAge") >= 1 and not u52:GetAttribute("Setup") then
                for _, v72 in pairs(u52:GetDescendants()) do
                    if v72:IsA("BasePart") and v72:HasTag("OriginallyNotAnchored") then
                        v72.Anchored = false;
                    end;
                end;
                u52:SetAttribute("Setup", true);
                task.spawn(function() --[[ Line: 260 ]]
                    -- upvalues: u52 (ref)
                    if not u52:HasTag("InitializationComplete") then
                        repeat
                            task.wait(0.2);
                        until u52:HasTag("InitializationComplete");
                    end;
                    task.wait(1);
                    for _, v73 in u52:GetChildren() do
                        if v73.Name == "Dragon" and not v73:HasTag("DragonBreath") then
                            v73:AddTag("DragonBreath");
                        end;
                    end;
                end);
            end;
        end;
        u52:GetAttributeChangedSignal("Age"):Connect(v74);
        v74();
    end,
    Extras = {}
};