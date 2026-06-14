-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 7
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__BackpackListener__3 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__Plants__4 = l__ReplicatedStorage__2.PlantGenerationModules.Plants;
local l__Fruits__5 = l__ReplicatedStorage__2.PlantGenerationModules.Fruits;
local l__Plants__6 = l__ReplicatedStorage__2.Assets.Plants;
local l__Fruits__7 = l__ReplicatedStorage__2.Assets.Fruits;
local l__POT__8 = l__ReplicatedStorage__2.Assets.POT;
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = CFrame.new(0, -0.5, 0.25) * CFrame.Angles(1.5707963267948966, 0, 0);
local function u9(p7) --[[ Line: 27 ]]
    for _, v8 in p7:GetDescendants() do
        if v8:IsA("BasePart") then
            v8.Anchored = true;
            v8.CanCollide = false;
            v8.CastShadow = false;
            v8.CanQuery = false;
            v8.CanTouch = false;
        end;
    end;
end;
local function u14(p10, p11) --[[ Line: 49 ]]
    for _, v12 in p11:GetDescendants() do
        if v12:IsA("BasePart") and v12 ~= p10 then
            local v13 = Instance.new("WeldConstraint");
            v13.Part0 = p10;
            v13.Part1 = v12;
            v13.Parent = v12;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 60 ]]
    -- upvalues: l__Plants__4 (copy), u2 (copy), l__Fruits__5 (copy)
    for _, v15 in l__Plants__4:GetChildren() do
        if v15:IsA("ModuleScript") then
            u2[`Plant_{v15.Name}`] = require(v15);
        end;
    end;
    for _, v16 in l__Fruits__5:GetChildren() do
        if v16:IsA("ModuleScript") then
            u2[`Fruit_{v16.Name}`] = require(v16);
        end;
    end;
end;
function v1.IsTrackedTool(_, p17) --[[ Line: 77 ]]
    return p17:GetAttribute("PottedPlant") == true;
end;
function v1.HasHandle(_, p18) --[[ Line: 82 ]]
    -- upvalues: u4 (copy)
    local v19 = u4[p18];
    local v20;
    if v19 == nil or v19.Pot == nil then
        v20 = false;
    else
        v20 = v19.Pot.Parent ~= nil;
    end;
    return v20;
end;
function v1.ClearHandle(_, p21) --[[ Line: 90 ]]
    -- upvalues: u4 (copy)
    local v22 = u4[p21];
    if v22 then
        v22.Cancelled = true;
        if v22.Pot and v22.Pot.Parent then
            v22.Pot:Destroy();
        end;
        if v22.PlantModel and v22.PlantModel.Parent then
            v22.PlantModel:Destroy();
        end;
        u4[p21] = nil;
    end;
end;
function v1.SpawnHandle(p23, u24, u25) --[[ Line: 104 ]]
    -- upvalues: u5 (copy), l__Plants__6 (copy), u2 (copy), l__Fruits__7 (copy), l__POT__8 (copy), u9 (copy), l__Players__1 (copy), u4 (copy), l__ReplicatedStorage__2 (copy), u14 (copy), l__LocalPlayer__9 (copy), u6 (copy)
    local v26, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36;
    local v37 = 0;
    while true do
        if v37 == 0 then
            v37 = -1;
            -- block 95
            if u5[u24] then
                return;
            end;
            u5[u24] = true;
            p23:ClearHandle(u24);
            local v38 = u24:GetAttribute("PlantName");
            local v39 = u24:GetAttribute("Seed");
            local v40 = u24:GetAttribute("Age") or 0;
            v29 = u24:GetAttribute("MaxAge") or 100;
            local v41 = u24:GetAttribute("SizeMultiplier") or 1;
            local v42 = u24:GetAttribute("Mutation");
            if not (v38 and v39) then
                u5[u24] = nil;
                return;
            end;
            local v43 = l__Plants__6:FindFirstChild(v38);
            local v44 = u2[`Plant_{v38}`];
            local v45;
            if v43 then
                v45 = false;
            else
                v43 = l__Fruits__7:FindFirstChild(v38);
                v44 = u2[`Fruit_{v38}`];
                v45 = true;
            end;
            if not (v43 and v44) then
                u5[u24] = nil;
                return;
            end;
            local v46 = u25:FindFirstChild("Right Arm") or u25:FindFirstChild("RightHand");
            if not v46 then
                u5[u24] = nil;
                return;
            end;
            local v47 = l__POT__8:Clone();
            v47.Name = "PottedPlantVisual";
            u9(v47);
            local v48 = v47:FindFirstChild("PlantRoot", true);
            if not v48 then
                v47:Destroy();
                u5[u24] = nil;
                return;
            end;
            v47:SetAttribute("Owner", l__Players__1:GetPlayerFromCharacter(u25) and (l__Players__1:GetPlayerFromCharacter(u25).UserId or 0) or 0);
            v47.Parent = game.Workspace.PottedPlantVisuals;
            local u49 = {
                Anchor = nil,
                PlantModel = nil,
                Cancelled = false,
                Pot = v47
            };
            u4[u24] = u49;
            v27 = function() --[[ Name: IsCancelledOrCleanup, Line 179 ]]
                -- upvalues: u49 (copy), u24 (copy), u25 (copy), u4 (ref), u5 (ref)
                if not u49.Cancelled and (u24.Parent == u25 and u25.Parent) then
                    return false;
                end;
                u49.Cancelled = true;
                if u49.Pot and u49.Pot.Parent then
                    u49.Pot:Destroy();
                end;
                if u49.PlantModel and u49.PlantModel.Parent then
                    u49.PlantModel:Destroy();
                end;
                if u4[u24] == u49 then
                    u4[u24] = nil;
                end;
                u5[u24] = nil;
                return true;
            end;
            v30 = v43:Clone();
            u49.PlantModel = v30;
            v30:SetAttribute("Age", v40);
            v30:SetAttribute("MaxAge", v29);
            if v42 and v42 ~= "" then
                v30:SetAttribute("Mutation", v42);
            end;
            u9(v30);
            v30:PivotTo(v48.WorldCFrame);
            (v45 and v44.InitFruit or v44.InitPlant)(v30, v39, v41);
            if v27() then
                return;
            end;
            v30.Parent = workspace;
            local v50 = 0;
            while true do
                v50 = v50 + task.wait();
                if v27() then
                    return;
                end;
                if v30:HasTag("InitializationComplete") or v50 > 5 then
                    break;
                end;
            end;
            (v45 and v44.BeginFruitGrowth or v44.BeginPlantGrowth)(v30);
            task.wait();
            if v27() then
                return;
            end;
            local l__Fruits__10 = l__ReplicatedStorage__2.Assets.Fruits;
            local v51 = v30:FindFirstChild("FruitSpawnLocations");
            local v52, v53, v54, v55;
            if not v51 then
                if v27() then
                    return;
                else
                    v30.Parent = v47;
                    v52 = v47.PrimaryPart;
                    if v52 then
                        for _, v59 in v47:GetDescendants() do
                            if v59:IsA("BasePart") then
                                v59.Anchored = false;
                                v59.CanCollide = false;
                                v59.CanQuery = false;
                                v59.CanTouch = false;
                                v59.Massless = true;
                            end;
                        end;
                        u14(v52, v47);
                        u14(v52, v30);
                        v53 = Instance.new("Part");
                        v53.Name = "Handle";
                        v53.Size = Vector3.new(1, 1, 1);
                        v53.Transparency = 1;
                        v53.CanCollide = false;
                        v53.CanQuery = false;
                        v53.CanTouch = false;
                        v53.Massless = true;
                        v53.Parent = u24;
                        v54 = Instance.new("WeldConstraint");
                        v54.Part0 = v53;
                        v54.Part1 = v46;
                        v54.Parent = v53;
                        v52.CFrame = v46.CFrame * CFrame.new(0, -2, 0.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
                        v55 = Instance.new("WeldConstraint");
                        v55.Part0 = v52;
                        v55.Part1 = v46;
                        v55.Parent = v52;
                        if l__Players__1:GetPlayerFromCharacter(u25) == l__LocalPlayer__9 then
                            u24.Grip = u6;
                        end;
                        u49.Anchor = v52;
                        u5[u24] = nil;
                        return;
                    else
                        v47:Destroy();
                        v30:Destroy();
                        if u4[u24] == u49 then
                            u4[u24] = nil;
                        end;
                        u5[u24] = nil;
                        return;
                    end;
                end;
            end;
            local v57 = v51:GetChildren();
            if #v57 <= 0 then
                if v27() then
                    return;
                else
                    v30.Parent = v47;
                    v52 = v47.PrimaryPart;
                    if v52 then
                        for _, v59 in v47:GetDescendants() do
                            if v59:IsA("BasePart") then
                                v59.Anchored = false;
                                v59.CanCollide = false;
                                v59.CanQuery = false;
                                v59.CanTouch = false;
                                v59.Massless = true;
                            end;
                        end;
                        u14(v52, v47);
                        u14(v52, v30);
                        v53 = Instance.new("Part");
                        v53.Name = "Handle";
                        v53.Size = Vector3.new(1, 1, 1);
                        v53.Transparency = 1;
                        v53.CanCollide = false;
                        v53.CanQuery = false;
                        v53.CanTouch = false;
                        v53.Massless = true;
                        v53.Parent = u24;
                        v54 = Instance.new("WeldConstraint");
                        v54.Part0 = v53;
                        v54.Part1 = v46;
                        v54.Parent = v53;
                        v52.CFrame = v46.CFrame * CFrame.new(0, -2, 0.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
                        v55 = Instance.new("WeldConstraint");
                        v55.Part0 = v52;
                        v55.Part1 = v46;
                        v55.Parent = v52;
                        if l__Players__1:GetPlayerFromCharacter(u25) == l__LocalPlayer__9 then
                            u24.Grip = u6;
                        end;
                        u49.Anchor = v52;
                        u5[u24] = nil;
                        return;
                    else
                        v47:Destroy();
                        v30:Destroy();
                        if u4[u24] == u49 then
                            u4[u24] = nil;
                        end;
                        u5[u24] = nil;
                        return;
                    end;
                end;
            end;
            v28 = l__Fruits__10:FindFirstChild(v38);
            v26 = u2[`Fruit_{v38}`];
            if not (v28 and v26) then
                if v27() then
                    return;
                else
                    v30.Parent = v47;
                    v52 = v47.PrimaryPart;
                    if v52 then
                        for _, v59 in v47:GetDescendants() do
                            if v59:IsA("BasePart") then
                                v59.Anchored = false;
                                v59.CanCollide = false;
                                v59.CanQuery = false;
                                v59.CanTouch = false;
                                v59.Massless = true;
                            end;
                        end;
                        u14(v52, v47);
                        u14(v52, v30);
                        v53 = Instance.new("Part");
                        v53.Name = "Handle";
                        v53.Size = Vector3.new(1, 1, 1);
                        v53.Transparency = 1;
                        v53.CanCollide = false;
                        v53.CanQuery = false;
                        v53.CanTouch = false;
                        v53.Massless = true;
                        v53.Parent = u24;
                        v54 = Instance.new("WeldConstraint");
                        v54.Part0 = v53;
                        v54.Part1 = v46;
                        v54.Parent = v53;
                        v52.CFrame = v46.CFrame * CFrame.new(0, -2, 0.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
                        v55 = Instance.new("WeldConstraint");
                        v55.Part0 = v52;
                        v55.Part1 = v46;
                        v55.Parent = v52;
                        if l__Players__1:GetPlayerFromCharacter(u25) == l__LocalPlayer__9 then
                            u24.Grip = u6;
                        end;
                        u49.Anchor = v52;
                        u5[u24] = nil;
                        return;
                    else
                        v47:Destroy();
                        v30:Destroy();
                        if u4[u24] == u49 then
                            u4[u24] = nil;
                        end;
                        u5[u24] = nil;
                        return;
                    end;
                end;
            end;
            local v60 = nil;
            local u61 = u24:GetAttribute("SavedFruitsJSON");
            local v62;
            if u61 and u61 ~= "" then
                local v63;
                v63, v62 = pcall(function() --[[ Line: 282 ]]
                    -- upvalues: u61 (copy)
                    return game:GetService("HttpService"):JSONDecode(u61);
                end);
                if v63 and v62 then
                    if #v62 <= 0 then
                        v62 = v60;
                    end;
                else
                    v62 = v60;
                end;
            else
                v62 = v60;
            end;
            if v62 then
                v32, v33, v31 = v62, nil, nil;
                v37 = 1;
                continue;
            end;
            local v64, v65, v66;
            v64, v65, v66 = v57, nil, nil;
            local v67, v68;
            if type(v64) == "function" then
                v67, v68 = v64(v65, v66);
            else
                v67, v68 = next(v64, v66);
            end;
            if v67 ~= nil then
                v66 = v67;
                while true do
                    local v69, v70;
                    local v71 = 0;
                    while true do
                        if v71 == 0 then
                            v71 = -1;
                            v26.BeginFruitGrowth(v69);
                            task.wait();
                            if v27() then
                                return;
                            end;
                            v69:PivotTo(v68.CFrame);
                            v69 = v28:Clone();
                            v69:SetAttribute("Age", v29);
                            v69:SetAttribute("MaxAge", v29);
                            v69.Parent = v30;
                            v26.InitFruit(v69, math.random(1, 999999), v41);
                            v70 = 0;
                            v71 = 1;
                            continue;
                        elseif v71 == 1 then
                            v71 = -1;
                            v70 = v70 + task.wait();
                            if v27() then
                                return;
                            end;
                            if v69:HasTag("InitializationComplete") or v70 > 5 then
                                continue;
                            else
                                v71 = 1;
                                continue;
                            end;
                            break;
                        else
                            break;
                        end;
                    end;
                end;
                v37 = 1;
                continue;
            else
                break;
            end;
        elseif v37 == 1 then
            v37 = -1;
            local v72;
            if type(v32) == "function" then
                v72, v35 = v32(v33, v31);
            else
                v72, v35 = next(v32, v31);
            end;
            if v72 ~= nil then
                v31 = v72;
                v34 = v28:Clone();
                v34:SetAttribute("Age", v29);
                v34:SetAttribute("MaxAge", v29);
                if v35.Mutation and v35.Mutation ~= "" then
                    v34:SetAttribute("Mutation", v35.Mutation);
                end;
                v34.Parent = v30;
                v26.InitFruit(v34, v35.Seed, v35.SizeMultiplier);
                v36 = 0;
                v37 = 3;
                continue;
            else
                break;
            end;
        elseif v37 == 2 then
            v37 = -1;
            v26.BeginFruitGrowth(v34);
            task.wait();
            if v27() then
                return;
            end;
            if v35.OvertimeGrowth and v35.OvertimeGrowth > 1 then
                v34:ScaleTo(v35.OvertimeGrowth);
            end;
            local v73;
            v34:PivotTo(v73.CFrame);
            v37 = 1;
            continue;
        elseif v37 == 3 then
            v37 = -1;
            v36 = v36 + task.wait();
            if v27() then
                return;
            end;
            if v34:HasTag("InitializationComplete") or v36 > 5 then
                v37 = 2;
                continue;
            else
                v37 = 3;
                continue;
            end;
            break;
        else
            break;
        end;
    end;
end;
function v1.UpdateToolState(p74, p75) --[[ Line: 418 ]]
    -- upvalues: u5 (copy), u4 (copy)
    if u5[p75] then
    else
        local v76 = u4[p75] and u4[p75].Character or p74:GetCharacterForTool(p75);
        if v76 then
            local v77 = p75.Parent == v76;
            local v78 = p74:HasHandle(p75);
            if v77 and not v78 then
                p74:SpawnHandle(p75, v76);
            else
                if not v77 and v78 then
                    p74:ClearHandle(p75);
                end;
            end;
        end;
    end;
end;
function v1.GetCharacterForTool(_, p79) --[[ Line: 435 ]]
    -- upvalues: l__Players__1 (copy)
    for _, v80 in l__Players__1:GetPlayers() do
        if v80.Character and p79:IsDescendantOf(v80.Character) then
            return v80.Character;
        end;
        if v80.Backpack and p79:IsDescendantOf(v80.Backpack) then
            return v80.Character;
        end;
    end;
    return nil;
end;
function v1.SetupTool(u81, u82, u83) --[[ Line: 448 ]]
    -- upvalues: u3 (copy)
    local u84 = {};
    local v85 = u82:GetPropertyChangedSignal("Parent");
    table.insert(u84, v85:Connect(function() --[[ Line: 452 ]]
        -- upvalues: u82 (copy), u81 (copy), u83 (copy)
        task.defer(function() --[[ Line: 453 ]]
            -- upvalues: u82 (ref), u81 (ref), u83 (ref)
            if u82 and u82.Parent then
                local v86 = u82.Parent == u83;
                local v87 = u81:HasHandle(u82);
                if v86 and not v87 then
                    u81:SpawnHandle(u82, u83);
                else
                    if not v86 and v87 then
                        u81:ClearHandle(u82);
                    end;
                end;
            else
                u81:ClearHandle(u82);
            end;
        end);
    end));
    table.insert(u84, u82.Destroying:Connect(function() --[[ Line: 469 ]]
        -- upvalues: u81 (copy), u82 (copy), u84 (copy), u3 (ref)
        u81:ClearHandle(u82);
        for _, v88 in u84 do
            v88:Disconnect();
        end;
        u3[u82] = nil;
    end));
    u3[u82] = u84;
    task.defer(function() --[[ Line: 478 ]]
        -- upvalues: u82 (copy), u83 (copy), u81 (copy)
        if u82 and u82.Parent == u83 then
            u81:SpawnHandle(u82, u83);
        end;
    end);
end;
function v1.SetupCharacter(u89, u90) --[[ Line: 486 ]]
    -- upvalues: l__Players__1 (copy)
    local v91 = l__Players__1:GetPlayerFromCharacter(u90);
    local function v93(p92) --[[ Line: 490 ]]
        -- upvalues: u89 (copy), u90 (copy)
        if p92:IsA("Tool") and u89:IsTrackedTool(p92) then
            u89:SetupTool(p92, u90);
        end;
    end;
    for _, v94 in u90:GetChildren() do
        if v94:IsA("Tool") and u89:IsTrackedTool(v94) then
            u89:SetupTool(v94, u90);
        end;
    end;
    u90.ChildAdded:Connect(v93);
    u90.ChildRemoved:Connect(function(p95) --[[ Line: 503 ]]
        -- upvalues: u89 (copy)
        if p95:IsA("Tool") then
            u89:ClearHandle(p95);
        end;
    end);
    if v91 and v91.Backpack then
        for _, v96 in v91.Backpack:GetChildren() do
            if v96:IsA("Tool") and u89:IsTrackedTool(v96) then
                u89:SetupTool(v96, u90);
            end;
        end;
    end;
end;
function v1.Start(u97) --[[ Line: 523 ]]
    -- upvalues: l__BackpackListener__3 (copy), l__Players__1 (copy)
    local function v103(u98) --[[ Line: 524 ]]
        -- upvalues: u97 (copy), l__BackpackListener__3 (ref)
        if u98.Character then
            u97:SetupCharacter(u98.Character);
        end;
        u98.CharacterAdded:Connect(function(p99) --[[ Line: 526 ]]
            -- upvalues: u97 (ref)
            u97:SetupCharacter(p99);
        end);
        l__BackpackListener__3.bind(u98, function(p100) --[[ Line: 532 ]]
            -- upvalues: u97 (ref), u98 (copy)
            local v101 = u97;
            local v102 = u98;
            if p100:IsA("Tool") then
                if v101:IsTrackedTool(p100) then
                    local l__Character__11 = v102.Character;
                    if l__Character__11 then
                        v101:SetupTool(p100, l__Character__11);
                    end;
                end;
            end;
        end);
    end;
    for _, v104 in l__Players__1:GetPlayers() do
        v103(v104);
    end;
    l__Players__1.PlayerAdded:Connect(v103);
end;
return v1;