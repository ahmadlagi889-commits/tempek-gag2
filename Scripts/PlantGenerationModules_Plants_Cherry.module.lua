-- Decompiled with Potassium's decompiler.

local function u5(p1) --[[ Line: 2 ]]
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
    InitPlant = function(u6, p7, p8) --[[ Name: InitPlant, Line 19 ]]
        -- upvalues: u5 (copy)
        local v9 = p8 or 1;
        local v10 = Random.new(p7);
        local l__FruitSpawnLocations__1 = u6.FruitSpawnLocations;
        local l__Base__2 = u6.Base;
        local u11 = 0;
        local l__Stud_Part__3 = script.Stud_Part;
        local v12 = v10:NextInteger(4, 7);
        local v13 = 1 * (v9 * 0.25 + 0.75);
        local v14 = 3 * (v9 * 0.25 + 0.75);
        local v15 = 12 * (v9 * 0.25 + 0.75);
        local v16 = 1;
        if v10:NextInteger(1, 300) == 1 then
            v13 = v13 * 3;
            v14 = v14 * 3;
            v15 = v15 * 3;
            v12 = v12 * 3;
            v16 = v16 * 3;
        end;
        while v10:NextInteger(1, 30) == 1 do
            v15 = v15 + v10:NextInteger(4, 7);
            v12 = v12 + v10:NextInteger(4, 7);
            v16 = v16 + 0.25;
        end;
        local u17 = Color3.new(1, 0.92549, 0.631373);
        local v18 = {};
        local function v32(p19, p20, p21, p22, p23, p24, p25, p26, p27, p28) --[[ Line: 59 ]]
            -- upvalues: l__Stud_Part__3 (copy), u17 (copy), u11 (ref), u6 (copy)
            local v29 = {};
            if p28 then
                p19 = p19 * CFrame.Angles(0, math.rad(p28), 0);
            end;
            for v30 = 1, p21 do
                local v31 = l__Stud_Part__3:Clone();
                v31.Color = u17;
                v31.Size = Vector3.new(p22, p23, p22);
                u11 = u11 + 1;
                v31.Name = tostring(u11);
                v31.CFrame = p19 * CFrame.new(0, p20.Y / 2 + v31.Size.Y / 2, 0);
                v31.CFrame = v31.CFrame * CFrame.new(0, -v31.Size.Y / 2, 0) * CFrame.Angles(math.rad(p24), 0, (math.rad(p25))) * CFrame.new(0, v31.Size.Y / 2, 0);
                v31.Parent = u6;
                p19 = v31.CFrame;
                p20 = v31.Size;
                table.insert(v29, v31);
                if v30 == 1 then
                    p24 = p26;
                    p25 = p27;
                else
                    p24 = p24 + p26;
                    p25 = p25 + p27;
                end;
                p22 = p22 * 0.95;
                p23 = p23 * 0.95;
            end;
            return v29;
        end;
        local v33 = u11 + 1;
        local v34 = (v10:NextNumber() * 2 - 1) * 1.5;
        local v35 = (v10:NextNumber() * 2 - 1) * 1.5;
        local v36 = v32(l__Base__2.CFrame * CFrame.new(0, -l__Base__2.Size.Y / 2, 0), l__Base__2.Size, v15, v13, v14, v34, v35, v34 * 0.2, v35 * 0.2, nil);
        local v37 = u5(v36);
        local v38 = v33;
        for _ = 1, v12 do
            local v39 = v37[v10:NextInteger(1, #v37)];
            local v40 = v13 * 0.75;
            local v41 = v14 * 0.5;
            local v42 = v10:NextInteger(6, 10);
            local v43 = v10:NextInteger(40, 70) * (v10:NextInteger(0, 1) == 0 and -1 or 1);
            local v44 = v10:NextInteger(40, 70) * (v10:NextInteger(0, 1) == 0 and -1 or 1);
            local v45 = v10:NextInteger(-180, 180);
            local v46 = v32(v39.CFrame, v39.Size, v42, v40, v41, v43, v44, 2.5, 2.5, v45);
            if #v46 > 0 then
                table.insert(v18, v46[#v46]);
            end;
            local v47 = v10:NextInteger(1, 3);
            if #v46 > 2 then
                v46 = u5(v46);
            end;
            for _ = 1, v47 do
                if #v46 == 0 then
                    break;
                end;
                local v48 = v46[v10:NextInteger(1, #v46)];
                local v49 = v40 * 0.65;
                local v50 = v41 * 0.5;
                local v51 = v10:NextInteger(4, 6);
                local v52 = v10:NextInteger(35, 65) * (v10:NextInteger(0, 1) == 0 and -1 or 1);
                local v53 = v10:NextInteger(35, 65) * (v10:NextInteger(0, 1) == 0 and -1 or 1);
                local v54 = v10:NextInteger(-180, 180);
                local v55 = v32(v48.CFrame, v48.Size, v51, v49, v50, v52, v53, 2, 2, v54);
                if #v55 > 0 then
                    table.insert(v18, v55[#v55]);
                end;
            end;
        end;
        table.insert(v18, v36[#v36]);
        local v56 = {
            Color3.fromRGB(255, 133, 231),
            Color3.fromRGB(255, 174, 244),
            Color3.fromRGB(255, 98, 226),
            Color3.fromRGB(255, 169, 232)
        };
        for _, v57 in pairs(v18) do
            local v58 = script.Leaf_Part:Clone();
            local v59 = v10:NextInteger(5, 9) * 1.2;
            local v60 = v59 * (v10:NextInteger(6, 8) * 0.1) * 1.2;
            v58.Size = Vector3.new(v59 * (v9 * 0.1 + 0.9) * v16, v60 * (v9 * 0.1 + 0.9) * v16, v59 * (v9 * 0.1 + 0.9) * v16);
            v58.Color = v56[v10:NextInteger(1, #v56)];
            v58.Name = tostring(v38);
            v58.CFrame = v57.CFrame * CFrame.new(0, v58.Size.Y / 2, 0);
            local v61 = v10:NextInteger(-180, 180);
            v58.Orientation = Vector3.new(0, v61, 0);
            v58.Parent = u6;
            for _ = 1, 1 do
                local v62 = Instance.new("Part");
                v62.Transparency = 1;
                v62.Anchored = true;
                v62.CanCollide = false;
                v62.Size = Vector3.new(1, 1, 1);
                v62.Parent = l__FruitSpawnLocations__1;
                local v63 = RaycastParams.new();
                v63.FilterType = Enum.RaycastFilterType.Include;
                v63.FilterDescendantsInstances = { v58 };
                v63.IgnoreWater = true;
                local v64 = v10:NextNumber(0, 6.283185307179586);
                local v65 = -v10:NextNumber(0.15, 1);
                local v66 = math.sqrt(1 - v65 * v65);
                local v67 = math.cos(v64) * v66;
                local v68 = math.sin(v64) * v66;
                local v69 = Vector3.new(v67, v65, v68);
                local v70 = v58.Position + Vector3.new(v69.X * v58.Size.X * 0.6, v69.Y * v58.Size.Y * 1.2, v69.Z * v58.Size.Z * 0.6);
                local l__Unit__4 = (v58.Position - v70).Unit;
                local v71 = math.max(v58.Size.X, v58.Size.Y, v58.Size.Z) * 3;
                local v72 = workspace:Raycast(v70, l__Unit__4 * v71, v63);
                if v72 then
                    v62.Position = v72.Position + v72.Normal * 0.05;
                else
                    v62.Position = v58.Position;
                end;
            end;
            v33 = v38 + 0.25;
            v38 = v33;
        end;
        u6:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u73) --[[ Name: BeginPlantGrowth, Line 251 ]]
        local l__PrimaryPart__5 = u73.PrimaryPart;
        local u74 = {};
        for _, v75 in u73:GetDescendants() do
            local v76 = tonumber(v75.Name);
            if v75:IsA("BasePart") and v76 then
                local v77 = {
                    v75,
                    v75.Size,
                    l__PrimaryPart__5.CFrame:ToObjectSpace(v75.CFrame),
                    v76
                };
                table.insert(u74, v77);
                v75.CanCollide = false;
                v75.Transparency = 1;
            end;
        end;
        table.sort(u74, function(p78, p79) --[[ Line: 269 ]]
            return p78[4] < p79[4];
        end);
        local function v86() --[[ Line: 271 ]]
            -- upvalues: u73 (copy), u74 (copy), l__PrimaryPart__5 (copy)
            local v80 = u73:GetAttribute("Age") or 0;
            for _, v81 in u74 do
                local v82 = v81[1];
                local v83 = v81[2];
                local v84 = v81[3];
                local v85 = math.clamp(v80 - v81[4], 0, 1);
                if v85 > 0 then
                    v82.Size = Vector3.new(v83.X * v85, v83.Y * v85, v83.Z * v85);
                    v82.CFrame = l__PrimaryPart__5.CFrame * v84 * CFrame.new(0, (v82.Size.Y - v83.Y) / 2, 0);
                    v82.Transparency = v82:GetAttribute("OG_Transparency") or 0;
                    v82.CanCollide = true;
                else
                    v82.Transparency = 1;
                    v82.CanCollide = false;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u73:GetAttribute("playedSfx") and u73:GetAttribute("MaxAge") <= v80)) then
                u73:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u73:GetAttributeChangedSignal("Age"):Connect(v86);
        v86();
    end,
    Extras = {}
};