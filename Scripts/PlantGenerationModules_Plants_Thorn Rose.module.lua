-- Decompiled with Potassium's decompiler.

local l__Thorn__1 = script.Thorn;
return {
    GrowData = {
        InheritPlantSizeMultiplier = 0.25
    },
    InitPlant = function(u1, p2, _) --[[ Name: InitPlant, Line 8 ]]
        -- upvalues: l__Thorn__1 (copy)
        local u3 = Random.new(p2);
        local l__FruitSpawnLocations__2 = u1.FruitSpawnLocations;
        local l__Base__3 = u1.Base;
        local l__Stud_Part__4 = script.Stud_Part;
        local v4 = Color3.fromRGB(34, 120, 42);
        local u5 = Color3.fromRGB(180, 35, 35);
        local u6 = { u1 };
        local v7 = RaycastParams.new();
        v7.FilterDescendantsInstances = u6;
        v7.FilterType = Enum.RaycastFilterType.Exclude;
        local l__Position__5 = (l__Base__3.CFrame * CFrame.new(0, l__Base__3.Size.Y / 2 + 0.5, 0)).Position;
        local v8 = Vector3.new(0, 1, 0);
        local l__Y__6 = l__Position__5.Y;
        local l__LookVector__7 = l__Base__3.CFrame.LookVector;
        local v9 = l__LookVector__7 - l__LookVector__7:Dot(v8) * v8;
        if v9.Magnitude < 0.01 then
            v9 = l__Base__3.CFrame.RightVector;
        end;
        local l__Unit__8 = v9.Unit;
        local v10 = {};
        local u11 = 0;
        local v12 = {};
        for v13 = -1, 1 do
            for v14 = -1, 1 do
                for v15 = -1, 1 do
                    if v13 ~= 0 or (v14 ~= 0 or v15 ~= 0) then
                        local l__Unit__9 = Vector3.new(v13, v14, v15).Unit;
                        table.insert(v10, l__Unit__9);
                    end;
                end;
            end;
        end;
        local v16 = {
            (Vector3.new(1, 2, 0)).Unit,
            (Vector3.new(-1, 2, 0)).Unit,
            (Vector3.new(0, 2, 1)).Unit,
            (Vector3.new(0, 2, -1)).Unit,
            (Vector3.new(1, 2, 1)).Unit,
            (Vector3.new(-1, 2, 1)).Unit,
            (Vector3.new(1, 2, -1)).Unit,
            (Vector3.new(-1, 2, -1)).Unit,
            (Vector3.new(1, 3, 0)).Unit,
            (Vector3.new(-1, 3, 0)).Unit,
            (Vector3.new(0, 3, 1)).Unit,
            (Vector3.new(0, 3, -1)).Unit,
            Vector3.new(0, 1, 0)
        };
        local function u25(p17, p18, p19, p20) --[[ Line: 104 ]]
            -- upvalues: u11 (ref), u3 (copy), l__Thorn__1 (ref), u5 (copy), u1 (copy), u6 (copy)
            u11 = u11 + 1;
            local v21 = u3:NextNumber(-p18.Z * 0.35, p18.Z * 0.35);
            local v22 = p17.Position + p17.LookVector * v21 + p19 * p20;
            local v23 = CFrame.lookAt(v22, v22 + p19, p17.LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0);
            local v24 = l__Thorn__1:Clone();
            v24.Size = v24.Size * 0.7;
            v24.CFrame = v23;
            v24.Color = u5;
            v24.Anchored = true;
            v24.CanCollide = false;
            v24.Transparency = 1;
            v24.Name = tostring(u11);
            v24.Parent = u1;
            table.insert(u6, v24);
        end;
        local function v28(p26, p27) --[[ Line: 128 ]]
            -- upvalues: u25 (copy)
            u25(p26, p27, p26.RightVector, p27.X / 2);
            u25(p26, p27, -p26.RightVector, p27.X / 2);
            u25(p26, p27, p26.UpVector, p27.Y / 2);
            u25(p26, p27, -p26.UpVector, p27.Y / 2);
        end;
        for v29 = 1, 40 do
            table.insert(v12, l__Position__5);
            if #v12 > 12 then
                table.remove(v12, 1);
            end;
            local v30 = v29;
            local v31 = u3:NextNumber(-0.7, 0.7);
            local l__Position__10 = (CFrame.fromAxisAngle(v8, v31) * CFrame.new(l__Unit__8)).Position;
            local v32 = l__Position__10 - l__Position__10:Dot(v8) * v8;
            if v32.Magnitude < 0.01 then
                v32 = v8:Cross(Vector3.new(1, 0, 0));
                if v32.Magnitude < 0.01 then
                    v32 = v8:Cross(Vector3.new(0, 0, 1));
                end;
            end;
            l__Unit__8 = v32.Unit;
            local v33 = l__Position__5 + v8 * 0.3;
            local v34 = v30;
            local v35 = {};
            for _, v36 in v10 do
                local v37;
                if v36.Magnitude < 0.01 then
                    v37 = nil;
                else
                    v37 = workspace:Raycast(v33, v36.Unit * 15, v7);
                end;
                if v37 then
                    table.insert(v35, v37);
                end;
            end;
            for _, v38 in v16 do
                local v39;
                if v38.Magnitude < 0.01 then
                    v39 = nil;
                else
                    v39 = workspace:Raycast(v33, v38.Unit * 15, v7);
                end;
                if v39 then
                    table.insert(v35, v39);
                end;
            end;
            local v40 = (-1 / 0);
            local v41 = nil;
            local v42 = nil;
            local v43 = nil;
            for _, v44 in v35 do
                local l__Normal__11 = v44.Normal;
                local v45 = v44.Position + l__Normal__11 * 0.5;
                local l__Magnitude__12 = (v45 - l__Position__5).Magnitude;
                if l__Magnitude__12 >= 0.3 then
                    local v46, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56;
                    if l__Magnitude__12 > 3.5999999999999996 then
                        v45 = l__Position__5 + (v44.Position - l__Position__5).Unit * 3;
                        local v57 = v45 + l__Normal__11 * 2;
                        local v58 = -l__Normal__11;
                        local v59;
                        if v58.Magnitude < 0.01 then
                            v59 = nil;
                        else
                            v59 = workspace:Raycast(v57, v58.Unit * 4, v7);
                        end;
                        if v59 then
                            v45 = v59.Position + v59.Normal * 0.5;
                            l__Normal__11 = v59.Normal;
                        end;
                        l__Magnitude__12 = (v45 - l__Position__5).Magnitude;
                        if l__Magnitude__12 >= 0.3 then
                            v46 = 1 - math.abs(l__Normal__11.Y);
                            v47 = (v45.Y - l__Position__5.Y) * 15 + v46 * 20 + (v45.Y - l__Y__6) * 2 + math.max(0, 15 - l__Magnitude__12) * 0.3;
                            v48 = v45 - l__Position__5;
                            if v48.Magnitude > 0.01 then
                                v47 = v47 + v48.Unit:Dot(l__Unit__8) * 2;
                            end;
                            v49 = v45;
                            v50 = 0;
                            for v62, v63 in v12 do
                                v51 = (v45 - v63).Magnitude;
                                if v51 < 8 then
                                    v50 = v50 + (8 - v51) * 5;
                                end;
                            end;
                            v52 = v47 - v50;
                            if v49.Y < l__Y__6 then
                                v52 = v52 - (l__Y__6 - v49.Y) * 5;
                            end;
                            if v40 < v52 then
                                v53 = Vector3.new(0, 1, 0) - (Vector3.new(0, 1, 0)):Dot(l__Normal__11) * l__Normal__11;
                                if v53.Magnitude < 0.01 then
                                    v53 = l__Normal__11:Cross(Vector3.new(1, 0, 0));
                                    if v53.Magnitude < 0.01 then
                                        v53 = l__Normal__11:Cross(Vector3.new(0, 0, 1));
                                    end;
                                end;
                                v43 = v53.Unit;
                                v54 = l__Unit__8 - l__Unit__8:Dot(l__Normal__11) * l__Normal__11;
                                if v54.Magnitude < 0.01 then
                                    v54 = l__Normal__11:Cross(Vector3.new(1, 0, 0));
                                    if v54.Magnitude < 0.01 then
                                        v54 = l__Normal__11:Cross(Vector3.new(0, 0, 1));
                                    end;
                                end;
                                v55 = v43 * 0.7 + v54.Unit * 0.3;
                                if v55.Magnitude > 0.01 then
                                    v56 = v55 - v55:Dot(l__Normal__11) * l__Normal__11;
                                    if v56.Magnitude < 0.01 then
                                        v56 = l__Normal__11:Cross(Vector3.new(1, 0, 0));
                                        if v56.Magnitude < 0.01 then
                                            v56 = l__Normal__11:Cross(Vector3.new(0, 0, 1));
                                        end;
                                    end;
                                    v43 = v56.Unit;
                                    v42 = l__Normal__11;
                                    v41 = v49;
                                    v40 = v52;
                                else
                                    v42 = l__Normal__11;
                                    v41 = v49;
                                    v40 = v52;
                                end;
                            end;
                        end;
                    else
                        v46 = 1 - math.abs(l__Normal__11.Y);
                        v47 = (v45.Y - l__Position__5.Y) * 15 + v46 * 20 + (v45.Y - l__Y__6) * 2 + math.max(0, 15 - l__Magnitude__12) * 0.3;
                        v48 = v45 - l__Position__5;
                        if v48.Magnitude > 0.01 then
                            v47 = v47 + v48.Unit:Dot(l__Unit__8) * 2;
                        end;
                        v49 = v45;
                        v50 = 0;
                        for v62, v63 in v12 do
                            v51 = (v45 - v63).Magnitude;
                            if v51 < 8 then
                                v50 = v50 + (8 - v51) * 5;
                            end;
                        end;
                        v52 = v47 - v50;
                        if v49.Y < l__Y__6 then
                            v52 = v52 - (l__Y__6 - v49.Y) * 5;
                        end;
                        if v40 < v52 then
                            v53 = Vector3.new(0, 1, 0) - (Vector3.new(0, 1, 0)):Dot(l__Normal__11) * l__Normal__11;
                            if v53.Magnitude < 0.01 then
                                v53 = l__Normal__11:Cross(Vector3.new(1, 0, 0));
                                if v53.Magnitude < 0.01 then
                                    v53 = l__Normal__11:Cross(Vector3.new(0, 0, 1));
                                end;
                            end;
                            v43 = v53.Unit;
                            v54 = l__Unit__8 - l__Unit__8:Dot(l__Normal__11) * l__Normal__11;
                            if v54.Magnitude < 0.01 then
                                v54 = l__Normal__11:Cross(Vector3.new(1, 0, 0));
                                if v54.Magnitude < 0.01 then
                                    v54 = l__Normal__11:Cross(Vector3.new(0, 0, 1));
                                end;
                            end;
                            v55 = v43 * 0.7 + v54.Unit * 0.3;
                            if v55.Magnitude > 0.01 then
                                v56 = v55 - v55:Dot(l__Normal__11) * l__Normal__11;
                                if v56.Magnitude < 0.01 then
                                    v56 = l__Normal__11:Cross(Vector3.new(1, 0, 0));
                                    if v56.Magnitude < 0.01 then
                                        v56 = l__Normal__11:Cross(Vector3.new(0, 0, 1));
                                    end;
                                end;
                                v43 = v56.Unit;
                                v42 = l__Normal__11;
                                v41 = v49;
                                v40 = v52;
                            else
                                v42 = l__Normal__11;
                                v41 = v49;
                                v40 = v52;
                            end;
                        end;
                    end;
                end;
            end;
            local v64;
            if v41 then
                v64 = l__Unit__8;
                l__Unit__8 = v43;
                v8 = v42;
            else
                for _, v65 in {
                    (l__Unit__8 - Vector3.new(0, 1, 0)).Unit,
                    Vector3.new(-0, -1, -0),
                    (l__Unit__8 * 0.5 - Vector3.new(0, 1, 0)).Unit,
                    (-l__Unit__8 * 0.5 - Vector3.new(0, 1, 0)).Unit,
                    (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 1.5707963267948966) * CFrame.new(l__Unit__8)).Position.Unit - Vector3.new(0, 0.5, 0),
                    (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -1.5707963267948966) * CFrame.new(l__Unit__8)).Position.Unit - Vector3.new(0, 0.5, 0)
                } do
                    if v65.Magnitude > 0.01 then
                        local v66 = l__Position__5 + v8 * 0.3;
                        local l__Unit__13 = v65.Unit;
                        local v67;
                        if l__Unit__13.Magnitude < 0.01 then
                            v67 = nil;
                        else
                            v67 = workspace:Raycast(v66, l__Unit__13.Unit * 30, v7);
                        end;
                        if v67 then
                            local v68 = v67.Position + v67.Normal * 0.5;
                            if (v68 - l__Position__5).Magnitude >= 0.3 then
                                v42 = v67.Normal;
                                local l__Normal__14 = v67.Normal;
                                local v69 = l__Unit__8 - l__Unit__8:Dot(l__Normal__14) * l__Normal__14;
                                if v69.Magnitude < 0.01 then
                                    v69 = l__Normal__14:Cross(Vector3.new(1, 0, 0));
                                    if v69.Magnitude < 0.01 then
                                        v69 = l__Normal__14:Cross(Vector3.new(0, 0, 1));
                                    end;
                                end;
                                v43 = v69.Unit;
                                v41 = v68;
                                break;
                            end;
                        end;
                    end;
                end;
                if v41 then
                    v64 = l__Unit__8;
                    l__Unit__8 = v43;
                    v8 = v42;
                else
                    v41 = l__Position__5 + Vector3.new(0, 3, 0);
                    v64 = l__Unit__8;
                    v8 = Vector3.new(0, 1, 0);
                end;
            end;
            local v70 = v41 - l__Position__5;
            if v70.Magnitude < 0.1 then
                v41 = l__Position__5 + v64 * 3;
                v70 = v41 - l__Position__5;
            end;
            local v71 = (l__Position__5 + v41) / 2;
            local v72 = l__Stud_Part__4:Clone();
            v72.Size = Vector3.new(1, 1, v70.Magnitude);
            v72.CFrame = CFrame.lookAt(v71, v41, v8);
            v72.Anchored = true;
            v72.CanCollide = false;
            v72.Transparency = 1;
            v72.Color = v4;
            v72.Name = tostring(v34);
            v72.Parent = u1;
            table.insert(u6, v72);
            v28(v72.CFrame, v72.Size);
            if u3:NextNumber() <= 0.1 then
                local v73 = v72.CFrame.Position + v72.CFrame.UpVector * (v72.Size.Y / 2 + 0.5);
                local v74 = Instance.new("Part");
                v74.Size = Vector3.new(1, 1, 1);
                v74.Transparency = 1;
                v74.Anchored = true;
                v74.CanCollide = false;
                v74.CFrame = CFrame.new(v73);
                v74.Name = "Fruit_Spawn";
                v74.Parent = l__FruitSpawnLocations__2;
            end;
            v7.FilterDescendantsInstances = u6;
            l__Position__5 = v41;
        end;
        u1:AddTag("InitializationComplete");
    end,
    BeginPlantGrowth = function(u75) --[[ Name: BeginPlantGrowth, Line 301 ]]
        local l__PrimaryPart__15 = u75.PrimaryPart;
        local u76 = {};
        for _, v77 in u75:GetDescendants() do
            local v78 = tonumber(v77.Name);
            if v77:IsA("BasePart") and v78 then
                local v79 = {};
                for _, v80 in v77:GetChildren() do
                    if v80:IsA("Decal") or v80:IsA("Texture") then
                        table.insert(v79, {
                            decal = v80,
                            originalTransparency = v80.Transparency
                        });
                        v80.Transparency = 1;
                    end;
                end;
                local v81 = {
                    part = v77,
                    maxSize = v77.Size,
                    centerOffset = l__PrimaryPart__15.CFrame:ToObjectSpace(v77.CFrame),
                    partAge = v78,
                    decals = v79
                };
                table.insert(u76, v81);
                v77.CanCollide = false;
                v77.Transparency = 1;
            end;
        end;
        local function v88() --[[ Line: 331 ]]
            -- upvalues: u75 (copy), u76 (copy), l__PrimaryPart__15 (copy)
            local v82 = u75:GetAttribute("Age") or 0;
            for _, v83 in u76 do
                local v84 = math.min(v82 - v83.partAge, 1);
                if v84 > 0 then
                    local v85 = v83.maxSize.Z * v84;
                    v83.part.Size = Vector3.new(v83.maxSize.X, v83.maxSize.Y, v85);
                    v83.part.CFrame = l__PrimaryPart__15.CFrame * v83.centerOffset * CFrame.new(0, 0, (v83.maxSize.Z - v85) / 2);
                    v83.part.Transparency = v83.part:GetAttribute("OG_Transparency") or 0;
                    v83.part.CanCollide = true;
                    for _, v86 in v83.decals do
                        v86.decal.Transparency = v86.originalTransparency + (1 - v86.originalTransparency) * (1 - v84);
                    end;
                else
                    v83.part.Transparency = 1;
                    v83.part.CanCollide = false;
                    for _, v87 in v83.decals do
                        v87.decal.Transparency = 1;
                    end;
                end;
            end;
            if game.Players.LocalPlayer and (game:GetService("RunService"):IsClient() and (not u75:GetAttribute("playedSfx") and u75:GetAttribute("MaxAge") <= v82)) then
                u75:SetAttribute("playedSfx", true);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Happy);
            end;
        end;
        u75:GetAttributeChangedSignal("Age"):Connect(v88);
        v88();
    end,
    Extras = {}
};