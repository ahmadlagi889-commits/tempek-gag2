-- Decompiled with Potassium's decompiler.

local l__MaterialService__1 = game:GetService("MaterialService");
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, _) --[[ Name: InitPlant, Line 11 ]]
        -- upvalues: l__MaterialService__1 (copy)
        local u3 = Random.new(p2);
        local _ = u1.FruitSpawnLocations;
        local l__Base__2 = u1.Base;
        local function u10(p4, p5, p6) --[[ Line: 26 ]]
            -- upvalues: u1 (copy), l__MaterialService__1 (ref)
            local v7 = Instance.new("Part");
            local v8 = p4 or "Studs";
            v7.Parent = u1;
            v7.TopSurface = Enum.SurfaceType[v8];
            v7.BackSurface = Enum.SurfaceType[v8];
            v7.FrontSurface = Enum.SurfaceType[v8];
            v7.BottomSurface = Enum.SurfaceType[v8];
            v7.LeftSurface = Enum.SurfaceType[v8];
            v7.RightSurface = Enum.SurfaceType[v8];
            v7.Anchored = true;
            v7.CanCollide = false;
            v7.Transparency = 1;
            if p6 then
                v7.Shape = Enum.PartType[p6];
            end;
            if p5 then
                v7.MaterialVariant = p5;
                local v9 = l__MaterialService__1:FindFirstChild(p5, true);
                if not v9 then
                    return v7;
                end;
                v7.Material = v9.BaseMaterial;
            end;
            return v7;
        end;
        local u11 = {
            Color3.fromRGB(23, 212, 255),
            Color3.fromRGB(255, 55, 255),
            Color3.fromRGB(43, 135, 255),
            Color3.fromRGB(158, 48, 255)
        };
        local _ = l__Base__2.CFrame;
        local u12 = 3;
        local u13 = nil;
        local u14 = Color3.fromRGB(0, 29, 79);
        local u15 = Color3.fromRGB(0, 87, 163);
        local function v49(p16, p17, _) --[[ Line: 74 ]]
            -- upvalues: u3 (copy), u14 (copy), u15 (copy), u13 (ref), u1 (copy), u11 (copy), u10 (copy), u12 (ref)
            local v18 = p16:GetPivot() * CFrame.new(0, p16.Size.Y / 2, 0);
            for v19 = 1, p17 do
                local v20 = script.Stud_Part:Clone();
                local v21 = 5 + u3:NextNumber(-2, 3);
                local l__Angles__3 = CFrame.Angles;
                local v22 = u3:NextNumber(-15, 15);
                local v23 = math.rad(v22);
                local v24 = u3:NextNumber(-15, 15);
                local v25 = math.rad(v24);
                local v26 = u3:NextNumber(-15, 15);
                local v27 = l__Angles__3(v23, v25, (math.rad(v26)));
                local l__new__4 = CFrame.new;
                local l__Position__5 = v18.Position;
                local v28 = u3:NextNumber(-15, 15);
                local v29 = u3:NextNumber(-15, 15);
                l__new__4(l__Position__5 + Vector3.new(v28, v29, u3:NextNumber(-15, 15)));
                v20.Color = u14:Lerp(u15, (math.clamp(v19 / p17, 0, 1)));
                v20.Size = Vector3.new(1.2999999523162842, v21, 1.2999999523162842);
                local v30;
                if u13 then
                    v30 = u13.Size.Y;
                    v18 = u13:GetPivot();
                else
                    v30 = 0;
                end;
                v20.CFrame = v18 * CFrame.new(0, v30 / 2.1, 0) * v27 * CFrame.new(0, v21 / 2.1, 0);
                v20.Name = v19;
                v20.Parent = u1;
                local v31 = v20:Clone();
                v31.Size = Vector3.new(v20.Size.X * 1.05, v20.Size.X * 1.05, v20.Size.X * 1.05);
                v31.Color = Color3.fromRGB(110, 72, 223);
                v31.Name = v19 + 1;
                v31.Parent = u1;
                if v19 == p17 then
                    local v32 = u3:NextNumber(4, 8);
                    for v33 = 1, v32 do
                        local v34 = script.Branch:Clone();
                        local v35 = v20:GetPivot() * CFrame.new(0, v20.Size.Y / 2, 0);
                        local l__Angles__6 = CFrame.Angles;
                        local v36 = 360 / v32 * v33 + u3:NextInteger(-15, 15);
                        local v37 = math.rad(v36);
                        local v38 = u3:NextInteger(5, 35);
                        v34:PivotTo(v35 * l__Angles__6(0, v37, (math.rad(v38))));
                        v34:ScaleTo(u3:NextNumber(0.8, 1.1));
                        v34[4].Color = u11[math.random(1, #u11)];
                        for _, v39 in v34:GetChildren() do
                            v39.Name = tonumber(v39.Name) + tonumber(v20.Name);
                            v39.Parent = u1;
                        end;
                        v34:Destroy();
                    end;
                    local v40 = u10();
                    v40.Size = Vector3.new(1, 1, 1);
                    v40.CFrame = v20:GetPivot() * CFrame.new(0, v20.Size.Y / 2, 0) * CFrame.Angles(3.141592653589793, 0, 0);
                    v40.Parent = u1.FruitSpawnLocations;
                else
                    local v41 = script.Leaf:Clone();
                    local v42 = v20:GetPivot();
                    local l__Angles__7 = CFrame.Angles;
                    local v43 = u3:NextInteger(-22, 22);
                    local v44 = math.rad(v43);
                    local v45 = u3:NextInteger(0, 360);
                    local v46 = math.rad(v45);
                    local v47 = u3:NextInteger(70, 100);
                    v41:PivotTo(v42 * l__Angles__7(v44, v46, (math.rad(v47))));
                    v41:ScaleTo(u3:NextNumber(0.7, 1.1));
                    for _, v48 in v41:GetChildren() do
                        v48.Name = tonumber(v48.Name) + tonumber(v20.Name);
                        v48.Parent = u1;
                    end;
                end;
                u12 = u12 + 1;
                u13 = v20;
            end;
            u13 = nil;
        end;
        local v50 = u3:NextInteger(6, 8);
        while u3:NextInteger(1, 30) == 1 do
            v50 = v50 + u3:NextInteger(7, 11);
            while u3:NextInteger(1, 10) == 1 do
                v50 = v50 * 2;
            end;
        end;
        v49(l__Base__2, math.floor(v50), l__Base__2:GetPivot());
        while u3:NextInteger(1, 30) == 1 do
            v49(l__Base__2, math.floor(v50), l__Base__2:GetPivot());
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u51) --[[ Name: BeginPlantGrowth, Line 188 ]]
        local l__PrimaryPart__8 = u51.PrimaryPart;
        local u52 = {};
        for _, v53 in u51:GetDescendants() do
            local v54 = tonumber(v53.Name);
            if v53:IsA("BasePart") and v54 then
                local v55 = {};
                for _, v56 in v53:GetChildren() do
                    if v56:IsA("Decal") then
                        table.insert(v55, { v56, v56.Transparency });
                        v56.Transparency = 1;
                    end;
                end;
                local v57 = {
                    v53,
                    v53.Size,
                    l__PrimaryPart__8.CFrame:ToObjectSpace(v53.CFrame),
                    v54,
                    v55
                };
                table.insert(u52, v57);
                v53.CanCollide = false;
                v53.Transparency = 1;
            end;
        end;
        local function v68() --[[ Line: 216 ]]
            -- upvalues: u51 (copy), u52 (copy), l__PrimaryPart__8 (copy)
            local v58 = u51:GetAttribute("Age") or 0;
            for _, v59 in u52 do
                local v60 = v59[1];
                local v61 = v59[2];
                local v62 = v59[3];
                local v63 = v59[4];
                local v64 = v59[5];
                local v65 = math.min(v58 - v63, 1);
                if v65 > 0 then
                    v60.Size = Vector3.new(v61.X, v61.Y * v65, v61.Z);
                    v60.CFrame = l__PrimaryPart__8.CFrame * v62 * CFrame.new(0, (v60.Size.Y - v61.Y) / 2, 0);
                    v60.Transparency = v60:GetAttribute("OG_Transparency") or 0;
                    v60.CanCollide = true;
                else
                    v60.Transparency = 1;
                    v60.CanCollide = false;
                end;
                local v66 = v65 >= 1;
                for _, v67 in v64 do
                    v67[1].Transparency = v66 and v67[2] or 1;
                end;
            end;
        end;
        u51:GetAttributeChangedSignal("Age"):Connect(v68);
        v68();
    end,
    Extras = {}
};