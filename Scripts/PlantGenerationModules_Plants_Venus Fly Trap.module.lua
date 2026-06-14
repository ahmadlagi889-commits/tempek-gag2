-- Decompiled with Potassium's decompiler.

game:GetService("MaterialService");
local l__LeafMesh__1 = script.LeafMesh;
local l__SpikeMesh__2 = script.SpikeMesh;
local l__Head__3 = script.Head;
local _ = script.VenusClose;
local _ = script.VenusHead;
require(game.StarterPlayer.StarterPlayerScripts.Controllers.InverseKinematicsController);
local function u6(p1, p2, p3) --[[ Line: 13 ]]
    local v4 = Instance.new("Part");
    local v5 = p2 or "Studs";
    v4.Parent = p1;
    v4.TopSurface = Enum.SurfaceType[v5];
    v4.BackSurface = Enum.SurfaceType[v5];
    v4.FrontSurface = Enum.SurfaceType[v5];
    v4.BottomSurface = Enum.SurfaceType[v5];
    v4.LeftSurface = Enum.SurfaceType[v5];
    v4.RightSurface = Enum.SurfaceType[v5];
    v4.Anchored = true;
    v4.CanCollide = false;
    v4.Transparency = 1;
    if p3 then
        v4.MaterialVariant = p3;
    end;
    return v4;
end;
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u7, p8, p9) --[[ Name: InitPlant, Line 56 ]]
        -- upvalues: l__Head__3 (copy), u6 (copy), l__SpikeMesh__2 (copy), l__LeafMesh__1 (copy)
        local l__FruitSpawnLocations__4 = u7.FruitSpawnLocations;
        local l__Base__5 = u7.Base;
        local u10 = l__Head__3:Clone();
        local v11 = Random.new(p8):NextNumber(3, 5);
        local u12 = Color3.fromRGB(32, 103, 56);
        local u13 = p8;
        local u14 = 0;
        math.randomseed(u13);
        local u15 = math.random(35, 45);
        local u16 = math.random(1, 2) == 1 and 10 or -10;
        local u17 = 30;
        math.random(5, 8);
        local function u25(p18, p19, p20) --[[ Line: 98 ]]
            -- upvalues: u6 (ref), u13 (ref), u12 (copy), l__SpikeMesh__2 (ref), u7 (copy)
            local v21 = Instance.new("Model");
            v21.Name = "Spike";
            local v22 = u6(v21, nil, "Studs");
            local v23 = Random.new(u13):NextNumber(1.25, 3) * (p20 or 1);
            v22.Size = Vector3.new(v23 * 0.2, v23 * 0.2, v23 * 0.65);
            v22.CFrame = p18 * CFrame.Angles(1.5707963267948966, 0, 0);
            v22.Color = u12;
            v22.Name = p19;
            local v24 = l__SpikeMesh__2:Clone();
            v24.Parent = v21;
            v24.Anchored = true;
            v24.CanCollide = false;
            v24.Transparency = 1;
            v24.MaterialVariant = "Studs";
            v24.Name = p19 + 1;
            v24.Size = Vector3.new(v23 / 2, v23, v23 * 0.1);
            local l__CFrame__6 = v22.CFrame;
            local l__new__7 = CFrame.new;
            local l__Y__8 = v22.Size.Y;
            local l__Y__9 = v24.Size.Y;
            v24.CFrame = l__CFrame__6 * l__new__7(0, l__Y__9 + (l__Y__8 - l__Y__9) / 2, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
            v21.Parent = u7;
            return v21;
        end;
        local function u44(p26, p27) --[[ Line: 126 ]]
            -- upvalues: u14 (ref), u13 (ref), u6 (ref), u25 (copy), l__LeafMesh__1 (ref), u7 (copy)
            local l__RightVector__10 = p26.CFrame.RightVector;
            local v28 = p27 + 1;
            local v29 = 1;
            local v30 = {};
            for v31 = 1, 2 do
                u14 = u14 + 1;
                local v32 = math.clamp(u13 + u14, 1, 100) * 100;
                local v33 = u13;
                local v34 = u13 * math.random(1, (math.clamp(v32, 1, 10000)));
                u13 = math.clamp(v34, 1, 9100000000000);
                if u13 == v33 then
                    u13 = 3;
                end;
                math.randomseed(u13);
                local v35 = Instance.new("Model");
                local v36 = math.random(3, 4);
                local v37 = u6(v35, nil, "Studs");
                v37.Size = Vector3.new(p26.Size.X / 2, p26.Size.Y * 0.35, p26.Size.Z / 2);
                v37.CFrame = p26.CFrame * CFrame.new(-l__RightVector__10 * (p26.Size.Y * 0.35));
                v37.Color = p26.Color;
                v37.Name = v28;
                local l__CFrame__11 = v37.CFrame;
                if v29 == 1 then
                    l__CFrame__11 = l__CFrame__11 * CFrame.Angles(0, 3.141592653589793, 0);
                end;
                for v38 = 1, v36 do
                    local v39 = u6(v35, nil, "Studs");
                    v39.Size = Vector3.new((1 - v38 * 0.2) * 2, (1 - v38 * 0.2) * 1, (1 - v38 * 0.2) * 1);
                    v39.CFrame = l__CFrame__11 * CFrame.Angles(0, math.rad(v29 * 6 * v38), 0) * CFrame.new(v37.Size.X * 0.7, 0, 0);
                    v39.Color = p26.Color;
                    v39.Name = v28 + v38;
                    l__CFrame__11 = v39.CFrame;
                    if v29 == -1 then
                        v39.CFrame = v39.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
                    end;
                    if v38 == 2 then
                        local v40 = u25(v39.CFrame * CFrame.new(0, 0, v39.Size.Z / 2) * CFrame.Angles(0, 0, -1.5707963267948966), v28, v39.Size.Y * 0.65);
                        local v41 = Instance.new("ObjectValue");
                        v41.Parent = v39;
                        v41.Name = "Reference";
                        v41.Value = v40;
                    end;
                    v37 = v39;
                end;
                l__RightVector__10 = -l__RightVector__10;
                v29 = -v29;
                local v42 = l__LeafMesh__1:Clone();
                v42.Parent = v35;
                v42.Anchored = true;
                v42.CanCollide = false;
                v42.Transparency = 1;
                v42.MaterialVariant = "Weld 2x2 Plastic";
                v42.Name = v28 + v36 + 1;
                v42.CFrame = l__CFrame__11 * CFrame.Angles(0, 0, 1.5707963267948966);
                if v29 == -1 then
                    v42.CFrame = v42.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
                end;
                v42.CFrame = v42.CFrame * (CFrame.Angles(3.141592653589793, 0, 0) * CFrame.new(0, v42.Size.Y * 0.45, 0));
                v35.Parent = u7;
                local v43 = u6(v35, nil, "Studs");
                v43.Transparency = 1;
                v43.CFrame = v42.CFrame * CFrame.new(0, v42.Size.Y / 2, 0);
                v43.Size = Vector3.new(1, 1, 1);
                v43.Name = "EndJoint";
                v35.Name = "Leaf" .. v31;
                table.insert(v30, v35);
            end;
            return v30;
        end;
        local function u66(p45, p46, p47) --[[ Line: 228 ]]
            -- upvalues: u6 (ref), u7 (copy), u16 (ref), u15 (ref), u12 (copy), u17 (ref), u44 (copy), u25 (copy), u13 (ref), u66 (copy), u10 (copy), u14 (ref), l__FruitSpawnLocations__4 (copy)
            local v48 = u6(u7, nil, "Studs");
            local v49 = p47 * 0.03;
            if p47 == 4 then
                u16 = -u16;
            end;
            if p47 > 4.5 then
                v49 = v49 - p47 * 0.02;
            end;
            local v50 = p45 * CFrame.Angles(math.rad(u15), 0, 0);
            v48.Size = Vector3.new(p46.X * 0.85, p46.Y * 1.05, p46.Z * 0.85);
            v48.CFrame = v50 * CFrame.new(0, v48.Size.Y * (v48.Size.Y * 0.075), 0);
            v48.Color = Color3.new(u12.R + v49, u12.G + v49, u12.B + v49);
            u15 = u15 - u17;
            u17 = u17 - 6.5;
            v48.Name = p47;
            if p47 == 3 then
                for _, v51 in u44(v48, p47) do
                    local v52 = Instance.new("ObjectValue");
                    v52.Parent = v48;
                    v52.Name = "LeafStemReference";
                    v52.Value = v51;
                end;
            end;
            local v53 = p47 + 1;
            local v54 = v48.CFrame * CFrame.new(0, 0, v48.Size.Z / 2);
            local v55 = u25;
            local v56;
            if v53 == 5 then
                v56 = Random.new(u13):NextNumber(1.8, 2.1);
            else
                v56 = Random.new(u13):NextNumber(1.1, 1.4);
            end;
            local v57 = v55(v54, v53, v56);
            local v58 = Instance.new("ObjectValue");
            v58.Parent = v48;
            v58.Name = "Reference";
            v58.Value = v57;
            local v59 = v48.CFrame * CFrame.new(0, v48.Size.Y / 2, 0);
            if v53 < 7 then
                u66(v59, v48.Size, v53);
            else
                v48.Color = u12;
                u10:PivotTo(v59 * CFrame.Angles(0, 1.5707963267948966, 0));
                u10:ScaleTo(v48.Size.Y * Random.new(u13):NextNumber(0.165, 0.2));
                u10.Parent = u7;
                u10.Name = "PlantModel";
                for _, v60 in u10:GetDescendants() do
                    local v61 = tonumber(v60.Name);
                    if v61 then
                        v60.Name = v61 + v53 - 1;
                    end;
                    if v60.Name == "Teeth" then
                        u14 = u14 + 1;
                        local v62 = math.clamp(u13 + u14, 1, 100) * 100;
                        local v63 = u13;
                        local v64 = u13 * math.random(1, (math.clamp(v62, 1, 10000)));
                        u13 = math.clamp(v64, 1, 9100000000000);
                        if u13 == v63 then
                            u13 = 3;
                        end;
                        math.randomseed(u13);
                        v60:ScaleTo(Random.new(u13):NextNumber(0.65, 1.05));
                    end;
                end;
                local v65 = u10:FindFirstChild("Fruit_Spawn");
                if v65 then
                    v65.Parent = l__FruitSpawnLocations__4;
                end;
            end;
        end;
        local v67 = u6(u7, nil, "Studs");
        local v68 = Vector3.new(v11, v11, v11);
        v67.CFrame = l__Base__5.CFrame;
        v67.Size = v68;
        v67.Color = u12;
        v67.Name = 1;
        u66(v67.CFrame * CFrame.new(0, v11 / 2, 0), v68, 2);
        u7:ScaleTo((p9 or 1) * 0.25 + 0.75);
        u7:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u69) --[[ Name: BeginPlantGrowth, Line 329 ]]
        local l__PrimaryPart__12 = u69.PrimaryPart;
        local u70 = {};
        for _, v71 in u69:GetDescendants() do
            local v72 = tonumber(v71.Name);
            if v71:IsA("BasePart") and v72 then
                local v73 = {};
                for _, v74 in v71:GetChildren() do
                    if v74:IsA("Decal") or v74:IsA("Texture") then
                        table.insert(v73, {
                            decal = v74,
                            originalTransparency = v74.Transparency
                        });
                        v74.Transparency = 1;
                    end;
                end;
                local v75 = {
                    part = v71,
                    maxSize = v71.Size,
                    centerOffset = l__PrimaryPart__12.CFrame:ToObjectSpace(v71.CFrame),
                    partAge = v72,
                    decals = v73
                };
                table.insert(u70, v75);
                v71.CanCollide = false;
                v71.Transparency = 1;
            end;
        end;
        local function v82() --[[ Line: 359 ]]
            -- upvalues: u69 (copy), u70 (copy), l__PrimaryPart__12 (copy)
            local v76 = u69:GetAttribute("Age") or 0;
            for _, v77 in u70 do
                local v78 = math.min(v76 - v77.partAge, 1);
                if v78 > 0 then
                    local v79 = v77.maxSize.Y * v78;
                    v77.part.Size = Vector3.new(v77.maxSize.X, v79, v77.maxSize.Z);
                    v77.part.CFrame = l__PrimaryPart__12.CFrame * v77.centerOffset * CFrame.new(0, -((v77.maxSize.Y - v79) / 2), 0);
                    v77.part.Transparency = v77.part:GetAttribute("OG_Transparency") or 0;
                    v77.part.CanCollide = true;
                    for _, v80 in v77.decals do
                        v80.decal.Transparency = v80.originalTransparency + (1 - v80.originalTransparency) * (1 - v78);
                    end;
                else
                    v77.part.Transparency = 1;
                    v77.part.CanCollide = false;
                    for _, v81 in v77.decals do
                        v81.decal.Transparency = 1;
                    end;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u69:GetAttribute("SetupIK") and u69:GetAttribute("MaxAge") <= v76)) then
                u69:SetAttribute("SetupIK", true);
                task.delay(1, function() --[[ Line: 392 ]]
                    -- upvalues: u69 (ref)
                    u69:AddTag("VenusFlyTrap");
                end);
            end;
        end;
        u69:GetAttributeChangedSignal("Age"):Connect(v82);
        v82();
    end,
    Extras = {}
};