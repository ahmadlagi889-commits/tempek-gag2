-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__ProximityPromptService__2 = game:GetService("ProximityPromptService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
game:GetService("TweenService");
local l__Networking__5 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("Networking"));
local l__Environment__6 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("Environment"));
local l__Gardens__7 = workspace:WaitForChild("Gardens");
require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("SellValueData"));
local l__FruitValueCalc__8 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("FruitValueCalc"));
require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("MutationData"));
local l__Fruits__9 = l__ReplicatedStorage__3:WaitForChild("Assets"):WaitForChild("Fruits");
local l__Plants__10 = l__ReplicatedStorage__3:WaitForChild("Assets"):WaitForChild("Plants");
local l__Fruits__11 = l__ReplicatedStorage__3:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits");
l__ReplicatedStorage__3:WaitForChild("PlantGenerationModules"):WaitForChild("Plants");
require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("SeedData"));
local l__PlantVisualizerController__12 = require(script.Parent.PlantVisualizerController);
require(game.ReplicatedStorage.ClientModules.Effects.ChunkDebris);
local l__LocalPlayer__13 = l__Players__1.LocalPlayer;
local u2 = l__RunService__4:IsStudio() or l__Environment__6.env == "Dev";
local function u3(...) --[[ Line: 51 ]]
    -- upvalues: u2 (copy)
    if u2 then
        print("[StealStack]", ...);
    end;
end;
local function u4(...) --[[ Line: 57 ]]
    -- upvalues: u2 (copy)
    if u2 then
        warn("[StealStack]", ...);
    end;
end;
local l__Debris__14 = game:GetService("Debris");
local l__Assets__15 = l__ReplicatedStorage__3:WaitForChild("Assets");
local u5 = 0;
local function u11(p6, p7) --[[ Line: 79 ]]
    -- upvalues: u5 (ref), l__Assets__15 (copy), l__Debris__14 (copy)
    if u5 >= 12 then
    else
        local v8 = (p7 == nil and 1 or p7) * 0.5;
        local u9 = l__Assets__15.PopVFXModel:Clone();
        u9:ScaleTo(v8);
        if u9:IsA("Model") then
            u9:PivotTo(CFrame.new(p6));
        elseif u9:IsA("BasePart") then
            u9.CFrame = CFrame.new(p6);
        end;
        u9.Parent = workspace;
        u5 = u5 + 1;
        u9.Destroying:Connect(function() --[[ Line: 98 ]]
            -- upvalues: u5 (ref)
            u5 = math.max(0, u5 - 1);
        end);
        task.spawn(function() --[[ Line: 101 ]]
            -- upvalues: u9 (copy)
            task.wait();
            if u9 and u9.Parent then
                for _, v10 in u9:GetDescendants() do
                    if v10:IsA("ParticleEmitter") then
                        v10:Emit(v10:GetAttribute("EmitCount") or 1);
                    end;
                end;
            end;
        end);
        l__Debris__14:AddItem(u9, 5);
    end;
end;
local u12 = nil;
local u13 = nil;
local u14 = false;
local u15 = nil;
local u16 = nil;
local u17 = {};
local u18 = {};
local u19 = {};
local u20 = {};
local u21 = {};
local u22 = nil;
local u23 = nil;
local function u29(p24, p25) --[[ Line: 156 ]]
    -- upvalues: u2 (copy), u4 (copy)
    for _, v26 in p24:GetDescendants() do
        if v26:IsA("BasePart") then
            v26:SetAttribute("_AllowQuery", p25 or nil);
            v26.CanQuery = p25;
        end;
    end;
    if u2 and p25 then
        local v27 = 0;
        for _, v28 in p24:GetDescendants() do
            if v28:IsA("BasePart") and v28.CanQuery ~= true then
                v27 = v27 + 1;
            end;
        end;
        if v27 > 0 then
            u4(("setModelQueryEnabled: %d part(s) in %s had CanQuery reverted to false! Raycasts will miss them."):format(v27, p24:GetFullName()));
        end;
    end;
end;
local u30 = {};
local function u33(p31) --[[ Line: 193 ]]
    -- upvalues: u30 (copy), u4 (copy)
    local v32 = 0;
    while u30[p31] do
        v32 = v32 + task.wait();
        if v32 > 10 then
            u4("acquirePlacementLock: waited >10s for", p31.Name, "- breaking lock (previous placement likely errored)");
            break;
        end;
    end;
    u30[p31] = true;
end;
local u34 = false;
local u35 = nil;
local function u43(p36, p37, p38) --[[ Line: 278 ]]
    -- upvalues: l__Gardens__7 (copy)
    for _, v39 in l__Gardens__7:GetChildren() do
        local v40 = v39:FindFirstChild("Plants");
        if v40 then
            local v41 = v40:FindFirstChild(p36 .. "_" .. p37);
            if v41 then
                local v42 = v41:FindFirstChild("Fruits");
                if v42 then
                    return v42:FindFirstChild(p36 .. "_" .. p37 .. "_" .. p38);
                end;
            end;
        end;
    end;
    return nil;
end;
local function u48() --[[ Line: 361 ]]
    -- upvalues: l__LocalPlayer__13 (copy), u22 (ref), u23 (ref)
    local l__Character__16 = l__LocalPlayer__13.Character;
    if l__Character__16 then
        local v44 = l__Character__16:FindFirstChildOfClass("Humanoid");
        if v44 then
            local v45 = v44:FindFirstChildOfClass("Animator");
            if v45 then
                if not u22 then
                    local v46 = Instance.new("Animation");
                    v46.AnimationId = "rbxassetid://86868346180508";
                    u22 = v45:LoadAnimation(v46);
                    u22.Looped = true;
                    u22.Priority = Enum.AnimationPriority.Action4;
                end;
                if not u23 then
                    local v47 = Instance.new("Animation");
                    v47.AnimationId = "rbxassetid://119994994979267";
                    u23 = v45:LoadAnimation(v47);
                    u23.Priority = Enum.AnimationPriority.Action4;
                    u23.Looped = false;
                end;
                if u23.IsPlaying then
                    u23:Stop(0);
                end;
                u23:Play();
                if not u22.IsPlaying then
                    u22:Play(0.6);
                end;
            end;
        end;
    end;
end;
local function u102(p49, u50, u51, u52, _, u53) --[[ Line: 411 ]]
    -- upvalues: l__Players__1 (copy), l__LocalPlayer__13 (copy), u34 (ref), l__Fruits__9 (copy), l__Plants__10 (copy), u4 (copy), u20 (copy), l__ReplicatedStorage__3 (copy), u21 (copy), u33 (copy), u3 (copy), u29 (copy), l__FruitValueCalc__8 (copy), u48 (copy), u30 (copy)
    local u54 = l__Players__1:GetPlayerByUserId(p49);
    if u54 and u54.Character then
        if u54 == l__LocalPlayer__13 and not u34 then
            u34 = true;
            local v55 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
            local v56 = v55;
            if v56 then
                v56 = v55:FindFirstChild("BackpackGui");
            end;
            if v56 then
                v56.Enabled = false;
            end;
            local l__Character__17 = l__LocalPlayer__13.Character;
            local v57 = l__Character__17 and l__Character__17:FindFirstChildOfClass("Humanoid");
            if v57 then
                v57:UnequipTools();
            end;
        end;
        local v58 = l__Fruits__9:FindFirstChild(u50);
        local u59;
        if v58 then
            u59 = false;
        else
            v58 = l__Plants__10:FindFirstChild(u50);
            u59 = true;
        end;
        if v58 then
            local u60 = v58:Clone();
            local function u62(u61) --[[ Line: 434 ]]
                if u61:GetAttribute("_StealLocked") then
                else
                    u61:SetAttribute("_StealLocked", true);
                    u61.CanCollide = false;
                    u61.CanQuery = false;
                    u61.CanTouch = false;
                    u61.Massless = true;
                    u61:GetPropertyChangedSignal("CanCollide"):Connect(function() --[[ Line: 443 ]]
                        -- upvalues: u61 (copy)
                        if u61.CanCollide then
                            u61.CanCollide = false;
                        end;
                    end);
                    u61:GetPropertyChangedSignal("CanQuery"):Connect(function() --[[ Line: 450 ]]
                        -- upvalues: u61 (copy)
                        if u61.CanQuery and not u61:GetAttribute("_AllowQuery") then
                            u61.CanQuery = false;
                        end;
                    end);
                    u61:GetPropertyChangedSignal("CanTouch"):Connect(function() --[[ Line: 455 ]]
                        -- upvalues: u61 (copy)
                        if u61.CanTouch then
                            u61.CanTouch = false;
                        end;
                    end);
                end;
            end;
            u60.DescendantAdded:Connect(function(p63) --[[ Line: 460 ]]
                -- upvalues: u62 (copy)
                if p63:IsA("BasePart") then
                    u62(p63);
                end;
            end);
            for _, v64 in u60:GetDescendants() do
                if v64:IsA("BasePart") then
                    u62(v64);
                end;
            end;
            task.spawn(function() --[[ Line: 472 ]]
                -- upvalues: u20 (ref), u50 (copy), l__ReplicatedStorage__3 (ref), u4 (ref), u53 (copy), u60 (copy), u59 (ref), u51 (copy), u52 (copy), u21 (ref), u54 (copy), u33 (ref), u3 (ref), u29 (ref), l__LocalPlayer__13 (ref), l__FruitValueCalc__8 (ref), u48 (ref), u30 (ref)
                local v65 = u20[u50];
                if not v65 then
                    local v66 = l__ReplicatedStorage__3.PlantGenerationModules.Plants:FindFirstChild(u50);
                    if v66 then
                        v65 = require(v66);
                    end;
                end;
                if v65 then
                    if u53 and u53 ~= "" then
                        u60:SetAttribute("Mutation", u53);
                    end;
                    if u59 then
                        v65.InitPlant(u60, u51, u52);
                    else
                        v65.InitFruit(u60, u51, u52);
                    end;
                    repeat
                        task.wait();
                    until u60:HasTag("InitializationComplete");
                    if not u21[u54] then
                        u21[u54] = {};
                    end;
                    local l__PrimaryPart__18 = u60.PrimaryPart;
                    if not l__PrimaryPart__18 then
                        l__PrimaryPart__18 = u60:FindFirstChild("FruitAnchor", true) or (u60:FindFirstChild("Base", true) or u60:FindFirstChildWhichIsA("BasePart", true));
                        if not l__PrimaryPart__18 then
                            u4("addStolenFruitVisual: fruit", u50, "has no usable PrimaryPart, destroying");
                            u60:Destroy();
                            return;
                        end;
                        u60.PrimaryPart = l__PrimaryPart__18;
                    end;
                    u33(u54);
                    local v100, v101 = pcall(function() --[[ Line: 523 ]]
                        -- upvalues: u3 (ref), u50 (ref), u54 (ref), u21 (ref), u29 (ref), u60 (ref), l__PrimaryPart__18 (ref), u4 (ref), l__LocalPlayer__13 (ref), l__FruitValueCalc__8 (ref), u52 (ref), u53 (ref), u48 (ref)
                        u3(("Placing \'%s\' for %s (stack size before: %d)"):format(u50, u54.Name, #u21[u54]));
                        u29(u60, true);
                        local v67 = (1 / 0);
                        for _, v68 in u60:GetDescendants() do
                            if v68:IsA("BasePart") and v68.Transparency < 1 then
                                local v69 = v68.Position.Y - v68.Size.Y / 2;
                                if v69 < v67 then
                                    v67 = v69;
                                end;
                            end;
                        end;
                        if v67 == (1 / 0) then
                            v67 = l__PrimaryPart__18.Position.Y - l__PrimaryPart__18.Size.Y / 2;
                        end;
                        local v70 = CFrame.new(l__PrimaryPart__18.Position.X, l__PrimaryPart__18.Position.Y - 100, l__PrimaryPart__18.Position.Z);
                        u60.Parent = workspace;
                        local v71 = RaycastParams.new();
                        v71.FilterDescendantsInstances = { u60 };
                        v71.FilterType = Enum.RaycastFilterType.Include;
                        local v72 = workspace:Raycast(v70.Position, Vector3.new(0, 300, 0), v71);
                        local v73 = CFrame.new(l__PrimaryPart__18.Position.X, v67, l__PrimaryPart__18.Position.Z);
                        if v72 and v72.Instance then
                            v73 = CFrame.new(v72.Position);
                            u3(("Bottom raycast hit \'%s\' at Y=%.2f"):format(v72.Instance.Name, v72.Position.Y));
                        else
                            u4(("Bottom raycast MISSED for \'%s\' - falling back to iterated lowestY=%.2f. If this happens often, the fruit\'s parts aren\'t queryable."):format(u50, v67));
                        end;
                        u29(u60, false);
                        local v74 = Instance.new("Part");
                        v74.Name = "FruitAnchor";
                        v74.Size = Vector3.new(0.01, 0.01, 0.01);
                        v74.Transparency = 1;
                        v74.CanCollide = false;
                        v74.CanQuery = false;
                        v74.CanTouch = false;
                        v74.Massless = true;
                        v74.CFrame = v73;
                        v74.Parent = u60;
                        u60.PrimaryPart = v74;
                        for _, v75 in u60:GetDescendants() do
                            if v75:IsA("BasePart") then
                                v75.Anchored = false;
                                v75.CanCollide = false;
                                v75.CanTouch = false;
                                v75.Massless = true;
                            end;
                        end;
                        for _, v76 in u60:GetDescendants() do
                            if v76:IsA("BasePart") and v76 ~= v74 then
                                local v77 = Instance.new("WeldConstraint");
                                v77.Part0 = v74;
                                v77.Part1 = v76;
                                v77.Parent = v76;
                            end;
                        end;
                        if not u54.Character:FindFirstChild("Head") then
                            u60:Destroy();
                            return;
                        end;
                        local v78 = u54.Character:FindFirstChild("HumanoidRootPart");
                        if not v78 then
                            u60:Destroy();
                            return;
                        end;
                        local v79 = u21[u54];
                        local v80 = v78.CFrame * CFrame.new(0, 0, -2);
                        if v79 and #v79 ~= 0 then
                            local l__X__19 = v80.Position.X;
                            local l__Z__20 = v80.Position.Z;
                            local v81 = {};
                            for _, v82 in v79 do
                                if v82.model and v82.model.Parent then
                                    table.insert(v81, v82.model);
                                    u29(v82.model, true);
                                end;
                            end;
                            u3(("Stacking on top of %d carried model(s)"):format(#v81));
                            task.wait();
                            local v83 = RaycastParams.new();
                            v83.FilterDescendantsInstances = v81;
                            v83.FilterType = Enum.RaycastFilterType.Include;
                            local v84 = v78.Position.Y + 200;
                            local v85 = 0;
                            local v86 = (-1 / 0);
                            local v87 = nil;
                            for v88 = 0, 4 do
                                for v89 = 0, 4 do
                                    local v90 = l__X__19 - 2 + v88 * 1;
                                    local v91 = l__Z__20 - 2 + v89 * 1;
                                    local v92 = Vector3.new(v90, v84, v91);
                                    for _ = 1, 20 do
                                        local v93 = workspace:Raycast(v92, Vector3.new(0, -400, 0), v83);
                                        if not v93 then
                                            break;
                                        end;
                                        if v93.Instance.Transparency < 1 then
                                            v85 = v85 + 1;
                                            if v86 < v93.Position.Y then
                                                v86 = v93.Position.Y;
                                                v87 = v93.Instance;
                                            end;
                                            break;
                                        end;
                                        v92 = Vector3.new(v90, v93.Position.Y - 0.01, v91);
                                    end;
                                end;
                            end;
                            for _, v94 in v81 do
                                u29(v94, false);
                            end;
                            if v86 > (-1 / 0) then
                                u3(("Grid raycast: %d/%d columns hit. Highest surface: \'%s\' at Y=%.2f"):format(v85, 25, v87 and v87.Name or "?", v86));
                                v74.CFrame = CFrame.new(l__X__19, v86, l__Z__20);
                            else
                                u4(("Grid raycast hit NOTHING above the stack for \'%s\' (stack size %d). Using fallback Y=%.2f. Check that the carried fruits\' parts have CanQuery enabled during the raycast."):format(u50, #v81, v78.Position.Y + 0.5));
                                v74.CFrame = CFrame.new(l__X__19, v78.Position.Y + 0.5, l__Z__20);
                            end;
                        else
                            v74.CFrame = v80;
                            u3(("First fruit in stack -> placed at base ref Y=%.2f"):format(v80.Position.Y));
                        end;
                        local v95 = Instance.new("WeldConstraint");
                        v95.Parent = v74;
                        v95.Part0 = v74;
                        v95.Part1 = v78;
                        table.insert(u21[u54], {
                            model = u60,
                            stealer = u54
                        });
                        u60.Parent = u54.Character;
                        u3(("Placed \'%s\' at Y=%.2f (stack size now: %d)"):format(u50, v74.Position.Y, #u21[u54]));
                        if u54 == l__LocalPlayer__13 then
                            local v96 = tonumber(l__LocalPlayer__13:GetAttribute("StolenCarryValue")) or 0;
                            local v97 = #u21[u54] == 1 and 0 or v96;
                            local v98, v99 = pcall(l__FruitValueCalc__8, u50, u52, u53, l__LocalPlayer__13, nil);
                            if v98 and type(v99) == "number" then
                                v97 = v97 + v99;
                            else
                                u4("FruitValueCalc failed for", u50, "-", v99);
                            end;
                            l__LocalPlayer__13:SetAttribute("StolenCarryValue", v97);
                            u48();
                        end;
                    end);
                    u30[u54] = nil;
                    if not v100 then
                        u4("Placement errored for", u50, "-", v101);
                        if u60 and u60.Parent then
                            u60:Destroy();
                        end;
                    end;
                else
                    u4("addStolenFruitVisual: no generation module for", u50);
                end;
            end);
        else
            u4("addStolenFruitVisual: no asset found for", u50);
        end;
    end;
end;
local u103 = {};
local u104 = false;
local function u119(p105) --[[ Line: 802 ]]
    -- upvalues: l__Players__1 (copy), u21 (copy), u103 (copy), u104 (ref), l__RunService__4 (copy), l__LocalPlayer__13 (copy), u22 (ref), u23 (ref), u34 (ref)
    local v106 = l__Players__1:GetPlayerByUserId(p105);
    if v106 then
        if p105 == l__LocalPlayer__13.UserId then
            if u22 and u22.IsPlaying then
                u22:Stop();
            end;
            if u23 and u23.IsPlaying then
                u23:Stop(0.3);
            end;
            if u34 then
                u34 = false;
                local v107 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
                if v107 then
                    v107 = v107:FindFirstChild("BackpackGui");
                end;
                if v107 then
                    v107.Enabled = true;
                end;
            end;
        end;
        local v108 = u21[v106];
        if v108 then
            for _, v109 in v108 do
                if v109.model and v109.model.Parent then
                    local l__model__21 = v109.model;
                    if l__model__21.Parent then
                        l__model__21.Parent = nil;
                    end;
                    table.insert(u103, l__model__21);
                    if not u104 then
                        u104 = true;
                        task.defer(function() --[[ Line: 785 ]]
                            -- upvalues: u103 (ref), l__RunService__4 (ref), u104 (ref)
                            local v110 = 0;
                            while true do
                                if v110 == 0 then
                                    v110 = -1;
                                    if #u103 <= 0 then
                                        u104 = false;
                                        return;
                                    end;
                                    local v111 = os.clock();
                                    while true do
                                        local v112 = table.remove(u103);
                                        if v112 then
                                            v112:Destroy();
                                        end;
                                        if #u103 == 0 or os.clock() - v111 >= 0.004 then
                                            if #u103 > 0 then
                                                l__RunService__4.Heartbeat:Wait();
                                            end;
                                            v110 = 0;
                                            break;
                                        end;
                                    end;
                                    if v110 ~= 0 then
                                        continue;
                                    end;
                                    break;
                                else
                                    break;
                                end;
                            end;
                        end);
                    end;
                end;
            end;
            u21[v106] = nil;
        end;
    else
        for v113, v114 in u21 do
            if v113.UserId == p105 then
                for _, v115 in v114 do
                    if v115.model and v115.model.Parent then
                        local l__model__22 = v115.model;
                        if l__model__22.Parent then
                            l__model__22.Parent = nil;
                        end;
                        table.insert(u103, l__model__22);
                        if not u104 then
                            u104 = true;
                            task.defer(function() --[[ Line: 785 ]]
                                -- upvalues: u103 (ref), l__RunService__4 (ref), u104 (ref)
                                local v116 = 0;
                                while true do
                                    if v116 == 0 then
                                        v116 = -1;
                                        if #u103 <= 0 then
                                            u104 = false;
                                            return;
                                        end;
                                        local v117 = os.clock();
                                        while true do
                                            local v118 = table.remove(u103);
                                            if v118 then
                                                v118:Destroy();
                                            end;
                                            if #u103 == 0 or os.clock() - v117 >= 0.004 then
                                                if #u103 > 0 then
                                                    l__RunService__4.Heartbeat:Wait();
                                                end;
                                                v116 = 0;
                                                break;
                                            end;
                                        end;
                                        if v116 ~= 0 then
                                            continue;
                                        end;
                                        break;
                                    else
                                        break;
                                    end;
                                end;
                            end);
                        end;
                    end;
                end;
                u21[v113] = nil;
                return;
            end;
        end;
    end;
end;
local function u136(p120, p121, p122) --[[ Line: 836 ]]
    -- upvalues: l__PlantVisualizerController__12 (copy), u43 (copy), u19 (copy)
    local v123;
    if p122 == "" or p122 == nil then
        v123 = l__PlantVisualizerController__12:GetSpawnedPlant(p120, p121);
    else
        v123 = u43(p120, p121, p122);
    end;
    if v123 then
        local u124 = {};
        local function u130(u125, u126, p127) --[[ Line: 850 ]]
            -- upvalues: u124 (copy)
            local v128, v129 = pcall(function() --[[ Line: 851 ]]
                -- upvalues: u125 (copy), u126 (copy)
                return u125[u126];
            end);
            if v128 then
                table.insert(u124, {
                    instance = u125,
                    property = u126,
                    original = v129
                });
                u125[u126] = p127;
            end;
        end;
        local u131;
        if v123:IsA("Model") then
            u131 = v123.PrimaryPart or nil;
        else
            u131 = nil;
        end;
        local function v133(p132) --[[ Line: 859 ]]
            -- upvalues: u131 (copy), u130 (copy)
            if p132.Name == "HarvestPart" then
            elseif p132:HasTag("MutationVFX") then
            elseif p132:IsA("BasePart") then
                if p132 == u131 then
                else
                    u130(p132, "Transparency", 1);
                    u130(p132, "CanCollide", false);
                end;
            elseif p132:IsA("Decal") or p132:IsA("Texture") then
                u130(p132, "Transparency", 1);
            elseif p132:IsA("ParticleEmitter") or (p132:IsA("Beam") or p132:IsA("Trail")) then
                u130(p132, "Enabled", false);
            elseif p132:IsA("Light") then
                u130(p132, "Enabled", false);
            else
                if p132:IsA("SurfaceGui") or p132:IsA("BillboardGui") then
                    u130(p132, "Enabled", false);
                end;
            end;
        end;
        if v123:IsA("BasePart") then
            v133(v123);
        end;
        for _, v134 in v123:GetDescendants() do
            v133(v134);
        end;
        u19[v123] = u124;
        for _, v135 in v123:GetDescendants() do
            if v135:IsA("ProximityPrompt") then
                v135:Destroy();
            end;
        end;
    end;
end;
local function u144(p137, p138, p139) --[[ Line: 895 ]]
    -- upvalues: l__PlantVisualizerController__12 (copy), u43 (copy), u19 (copy)
    local v140;
    if p139 == "" or p139 == nil then
        v140 = l__PlantVisualizerController__12:GetSpawnedPlant(p137, p138);
    else
        v140 = u43(p137, p138, p139);
    end;
    if v140 then
        local v141 = u19[v140];
        if v141 then
            for _, u142 in v141 do
                local l__instance__23 = u142.instance;
                if l__instance__23 and l__instance__23.Parent then
                    pcall(function() --[[ Line: 911 ]]
                        -- upvalues: l__instance__23 (copy), u142 (copy)
                        l__instance__23[u142.property] = u142.original;
                    end);
                end;
            end;
            u19[v140] = nil;
        end;
        local v143 = v140:FindFirstChild("StolenBillboard");
        if v143 then
            v143:Destroy();
        end;
        if p139 == "" or p139 == nil then
            l__PlantVisualizerController__12:AddHarvestPrompt(v140);
        end;
    end;
end;
local function u151(p145) --[[ Line: 930 ]]
    -- upvalues: u43 (copy), u19 (copy), u103 (copy), u104 (ref), l__RunService__4 (copy)
    for _, v146 in p145 do
        local v147 = u43(v146.OwnerUserId, v146.PlantId, v146.FruitId);
        if v147 then
            u19[v147] = nil;
            if v147.Parent then
                v147.Parent = nil;
            end;
            table.insert(u103, v147);
            if not u104 then
                u104 = true;
                task.defer(function() --[[ Line: 785 ]]
                    -- upvalues: u103 (ref), l__RunService__4 (ref), u104 (ref)
                    local v148 = 0;
                    while true do
                        if v148 == 0 then
                            v148 = -1;
                            if #u103 <= 0 then
                                u104 = false;
                                return;
                            end;
                            local v149 = os.clock();
                            while true do
                                local v150 = table.remove(u103);
                                if v150 then
                                    v150:Destroy();
                                end;
                                if #u103 == 0 or os.clock() - v149 >= 0.004 then
                                    if #u103 > 0 then
                                        l__RunService__4.Heartbeat:Wait();
                                    end;
                                    v148 = 0;
                                    break;
                                end;
                            end;
                            if v148 ~= 0 then
                                continue;
                            end;
                            break;
                        else
                            break;
                        end;
                    end;
                end);
            end;
        end;
    end;
end;
local function u156() --[[ Line: 940 ]]
    -- upvalues: u14 (ref), u12 (ref), u13 (ref), l__Networking__5 (copy), u16 (ref), u15 (ref), u35 (ref), l__LocalPlayer__13 (copy), u21 (copy), u34 (ref), u23 (ref)
    u14 = true;
    local u152 = u12;
    u12 = nil;
    u13 = nil;
    if u152 and u152:IsDescendantOf(workspace) then
        u152.Enabled = false;
        task.defer(function() --[[ Line: 947 ]]
            -- upvalues: u152 (copy)
            if u152 and u152:IsDescendantOf(workspace) then
                u152.Enabled = true;
            end;
        end);
    end;
    l__Networking__5.Steal.CancelSteal:Fire();
    if u16 then
        u16:Disconnect();
        u16 = nil;
    end;
    u15 = nil;
    if not u35 then
        u35 = require(l__LocalPlayer__13.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
    end;
    u35:Enable();
    local v153 = u21[l__LocalPlayer__13];
    local v154;
    if v153 == nil then
        v154 = false;
    else
        v154 = #v153 > 0;
    end;
    if not v154 then
        if u34 then
            u34 = false;
            local v155 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
            if v155 then
                v155 = v155:FindFirstChild("BackpackGui");
            end;
            if v155 then
                v155.Enabled = true;
            end;
        end;
        if u23 and u23.IsPlaying then
            u23:Stop(0.3);
        end;
    end;
end;
local function u162() --[[ Line: 976 ]]
    -- upvalues: u15 (ref), l__LocalPlayer__13 (copy), u156 (copy), u16 (ref), l__RunService__4 (copy)
    local l__Character__24 = l__LocalPlayer__13.Character;
    local v157;
    if l__Character__24 then
        local v158 = l__Character__24:FindFirstChild("HumanoidRootPart");
        if v158 then
            v157 = v158.Position;
        else
            v157 = nil;
        end;
    else
        v157 = nil;
    end;
    u15 = v157;
    if u15 then
        if u16 then
            u16:Disconnect();
        end;
        local u159 = os.clock();
        u16 = l__RunService__4.Heartbeat:Connect(function() --[[ Line: 992 ]]
            -- upvalues: l__LocalPlayer__13 (ref), u156 (ref), u159 (copy), u15 (ref)
            debug.profilebegin("Controllers/StealController/MoveCheck");
            local l__Character__25 = l__LocalPlayer__13.Character;
            local v160;
            if l__Character__25 then
                local v161 = l__Character__25:FindFirstChild("HumanoidRootPart");
                if v161 then
                    v160 = v161.Position;
                else
                    v160 = nil;
                end;
            else
                v160 = nil;
            end;
            if v160 then
                if os.clock() - u159 < 0.6 then
                    u15 = v160;
                    debug.profileend();
                else
                    if (v160 - u15).Magnitude > 5 then
                        u156();
                    end;
                    debug.profileend();
                end;
            else
                u156();
                debug.profileend();
            end;
        end);
    else
        u156();
    end;
end;
local function u166(p163) --[[ Line: 1018 ]]
    -- upvalues: l__LocalPlayer__13 (copy), u17 (copy)
    if p163 == l__LocalPlayer__13 then
    else
        local v164 = u17[p163];
        if v164 and v164.Parent then
        else
            if v164 then
                u17[p163] = nil;
            end;
            local l__Character__26 = p163.Character;
            if l__Character__26 then
                local v165 = Instance.new("Highlight");
                v165.Name = "StealHighlight";
                v165.FillColor = Color3.new(1, 0, 0);
                v165.OutlineColor = Color3.new(1, 0, 0);
                v165.FillTransparency = 0.5;
                v165.OutlineTransparency = 1;
                v165.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                v165.Parent = l__Character__26;
                u17[p163] = v165;
            end;
        end;
    end;
end;
local l__StealSFX__27 = game.SoundService.SFX.StealSFX;
function v1.Init(_) --[[ Line: 1060 ]]
    -- upvalues: l__ProximityPromptService__2 (copy), u14 (ref), l__LocalPlayer__13 (copy), l__StealSFX__27 (copy), u12 (ref), u13 (ref), l__ReplicatedStorage__3 (copy), u35 (ref), u34 (ref), l__Networking__5 (copy), u162 (copy), u16 (ref), u15 (ref), u21 (copy), u23 (ref), u166 (copy), u17 (copy), u18 (copy), u136 (copy), u144 (copy), u151 (copy), u102 (copy), u119 (copy), u11 (copy), l__Players__1 (copy), u30 (copy), l__RunService__4 (copy), u22 (ref)
    l__ProximityPromptService__2.PromptButtonHoldBegan:Connect(function(u167, p168) --[[ Line: 1061 ]]
        -- upvalues: u14 (ref), l__LocalPlayer__13 (ref), l__StealSFX__27 (ref), u12 (ref), u13 (ref), l__ReplicatedStorage__3 (ref), u35 (ref), u34 (ref), l__Networking__5 (ref), u162 (ref), u16 (ref), u15 (ref), u21 (ref), u23 (ref)
        u14 = false;
        if u167:HasTag("StealPrompt") then
            if p168 == l__LocalPlayer__13 then
                local l__Parent__28 = u167.Parent;
                if l__Parent__28 then
                    local v169 = l__Parent__28:FindFirstAncestorWhichIsA("Model");
                    if v169 then
                        if u167.HoldDuration > 0 then
                            require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("Bamboo can\'t be stolen!");
                        else
                            local v170 = tonumber(v169:GetAttribute("UserId"));
                            local v171 = v169:GetAttribute("PlantId");
                            local v172 = v169:GetAttribute("FruitId");
                            l__StealSFX__27.TimePosition = 0;
                            l__StealSFX__27.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                            l__StealSFX__27.Playing = true;
                            if v170 and v171 then
                                u12 = u167;
                                u13 = v169;
                                local v173 = l__ReplicatedStorage__3:FindFirstChild("Night");
                                if v173 and v173.Value == true then
                                    if not u35 then
                                        u35 = require(l__LocalPlayer__13.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
                                    end;
                                    u35:Disable();
                                    if not u34 then
                                        u34 = true;
                                        local v174 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
                                        if v174 then
                                            v174 = v174:FindFirstChild("BackpackGui");
                                        end;
                                        if v174 then
                                            v174.Enabled = false;
                                        end;
                                        local l__Character__29 = l__LocalPlayer__13.Character;
                                        local v175 = l__Character__29 and l__Character__29:FindFirstChildOfClass("Humanoid");
                                        if v175 then
                                            v175:UnequipTools();
                                        end;
                                    end;
                                    l__Networking__5.Steal.BeginSteal:Fire(v170, v171, v172 or "");
                                    u162();
                                    task.spawn(function() --[[ Line: 1124 ]]
                                        -- upvalues: u13 (ref)
                                        u13:GetPivot();
                                        local v176, v177 = u13:GetBoundingBox();
                                        local v178 = Instance.new("Part");
                                        v178.Size = v177;
                                        v178.CFrame = v176;
                                        v178.Anchored = true;
                                        v178.Transparency = 1;
                                        v178.CanCollide = false;
                                        v178.CanQuery = false;
                                        local v179 = game.ReplicatedStorage.Assets.ShakeParticle:Clone();
                                        v179.Parent = v178;
                                        v178.Parent = workspace.Temporary;
                                        local v180 = u13:GetPivot();
                                        game.Debris:AddItem(v178, 2);
                                        local v181 = u13;
                                        local v182 = Vector3.new();
                                        local v183 = 0;
                                        while u13 ~= nil do
                                            local v184 = game:GetService("RunService").Heartbeat:Wait();
                                            v183 = v183 + v184;
                                            local v185 = math.clamp(v183 / 0.7, 0, 1);
                                            v178.CFrame = v176;
                                            if u13.PrimaryPart and u13.PrimaryPart.Anchored == true then
                                                v182 = v182:Lerp(Random.new():NextUnitVector() * 0.4 * v185, v184 * 12);
                                                u13:PivotTo(v180 * CFrame.new(v182));
                                            end;
                                        end;
                                        v179.Enabled = false;
                                        v181:PivotTo(v180);
                                    end);
                                    u167.Destroying:Connect(function() --[[ Line: 1179 ]]
                                        -- upvalues: u12 (ref), u167 (copy), u13 (ref), u16 (ref), u15 (ref), l__Networking__5 (ref), u35 (ref), l__LocalPlayer__13 (ref), u21 (ref), u34 (ref), u23 (ref)
                                        if u12 == u167 then
                                            u12 = nil;
                                            u13 = nil;
                                            if u16 then
                                                u16:Disconnect();
                                                u16 = nil;
                                            end;
                                            u15 = nil;
                                            l__Networking__5.Steal.CancelSteal:Fire();
                                            if not u35 then
                                                u35 = require(l__LocalPlayer__13.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
                                            end;
                                            u35:Enable();
                                            local v186 = u21[l__LocalPlayer__13];
                                            local v187;
                                            if v186 == nil then
                                                v187 = false;
                                            else
                                                v187 = #v186 > 0;
                                            end;
                                            if not v187 then
                                                if u34 then
                                                    u34 = false;
                                                    local v188 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
                                                    if v188 then
                                                        v188 = v188:FindFirstChild("BackpackGui");
                                                    end;
                                                    if v188 then
                                                        v188.Enabled = true;
                                                    end;
                                                end;
                                                if u23 and u23.IsPlaying then
                                                    u23:Stop(0.3);
                                                end;
                                            end;
                                        end;
                                    end);
                                else
                                    require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("You can only steal at night!");
                                    u12 = nil;
                                    u13 = nil;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
    l__ProximityPromptService__2.PromptButtonHoldEnded:Connect(function(u189, p190) --[[ Line: 1205 ]]
        -- upvalues: l__LocalPlayer__13 (ref), u12 (ref), u13 (ref), u16 (ref), u15 (ref), l__Networking__5 (ref), u35 (ref), u23 (ref), u21 (ref), u34 (ref)
        if u189:HasTag("StealPrompt") then
            if p190 == l__LocalPlayer__13 then
                task.defer(function() --[[ Line: 1210 ]]
                    -- upvalues: u12 (ref), u189 (copy), u13 (ref), u16 (ref), u15 (ref), l__Networking__5 (ref), u35 (ref), l__LocalPlayer__13 (ref), u23 (ref), u21 (ref), u34 (ref)
                    if u12 == u189 then
                        u12 = nil;
                        u13 = nil;
                        if u16 then
                            u16:Disconnect();
                            u16 = nil;
                        end;
                        u15 = nil;
                        l__Networking__5.Steal.CancelSteal:Fire();
                        if not u35 then
                            u35 = require(l__LocalPlayer__13.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
                        end;
                        u35:Enable();
                        if u23 and u23.IsPlaying then
                            u23:Stop(0.3);
                        end;
                        local v191 = u21[l__LocalPlayer__13];
                        local v192;
                        if v191 == nil then
                            v192 = false;
                        else
                            v192 = #v191 > 0;
                        end;
                        if not v192 then
                            if not u34 then
                                return;
                            end;
                            u34 = false;
                            local v193 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
                            if v193 then
                                v193 = v193:FindFirstChild("BackpackGui");
                            end;
                            if v193 then
                                v193.Enabled = true;
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end);
    l__ProximityPromptService__2.PromptTriggered:Connect(function(p194, p195) --[[ Line: 1239 ]]
        -- upvalues: l__LocalPlayer__13 (ref), u14 (ref), l__ReplicatedStorage__3 (ref), u12 (ref), u13 (ref), u16 (ref), u15 (ref), u21 (ref), u34 (ref), l__Networking__5 (ref), u35 (ref)
        if p194:HasTag("StealPrompt") then
            if p195 == l__LocalPlayer__13 then
                if p194.HoldDuration > 0 then
                    require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("Bamboo can\'t be stolen!");
                    u14 = false;
                else
                    local v196 = l__ReplicatedStorage__3:FindFirstChild("Night");
                    if v196 and v196.Value == true then
                        if p194.HoldDuration == 0 then
                            local l__Parent__30 = p194.Parent;
                            if l__Parent__30 then
                                local v197 = l__Parent__30:FindFirstAncestorWhichIsA("Model");
                                if v197 then
                                    local v198 = tonumber(v197:GetAttribute("UserId"));
                                    local v199 = v197:GetAttribute("PlantId");
                                    local v200 = v197:GetAttribute("FruitId");
                                    if v198 and v199 then
                                        l__Networking__5.Steal.BeginSteal:Fire(v198, v199, v200 or "");
                                        l__Networking__5.Steal.CompleteSteal:Fire();
                                    end;
                                end;
                            end;
                        elseif u12 == p194 and not u14 then
                            if u16 then
                                u16:Disconnect();
                                u16 = nil;
                            end;
                            u15 = nil;
                            u12 = nil;
                            u13 = nil;
                            if not u35 then
                                u35 = require(l__LocalPlayer__13.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
                            end;
                            u35:Enable();
                            l__Networking__5.Steal.CompleteSteal:Fire();
                        else
                            u14 = false;
                        end;
                    else
                        require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("You can only steal at night!");
                        u12 = nil;
                        u13 = nil;
                        u14 = false;
                        if u16 then
                            u16:Disconnect();
                            u16 = nil;
                        end;
                        u15 = nil;
                        local v201 = u21[l__LocalPlayer__13];
                        local v202;
                        if v201 == nil then
                            v202 = false;
                        else
                            v202 = #v201 > 0;
                        end;
                        if not v202 then
                            if not u34 then
                                return;
                            end;
                            u34 = false;
                            local v203 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
                            if v203 then
                                v203 = v203:FindFirstChild("BackpackGui");
                            end;
                            if v203 then
                                v203.Enabled = true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
    l__Networking__5.Steal.StealStarted.OnClientEvent:Connect(function(p204) --[[ Line: 1334 ]]
        -- upvalues: u166 (ref)
        if p204 and p204:IsA("Player") then
            u166(p204);
        end;
    end);
    l__Networking__5.Steal.StealCancelled.OnClientEvent:Connect(function(p205) --[[ Line: 1340 ]]
        -- upvalues: u17 (ref), u18 (ref)
        if p205 and p205:IsA("Player") then
            local v206 = u17[p205];
            if v206 then
                v206:Destroy();
                u17[p205] = nil;
            end;
            local v207 = u18[p205];
            if v207 then
                task.cancel(v207);
                u18[p205] = nil;
            end;
        end;
    end);
    l__Networking__5.Steal.MarkFruitStolen.OnClientEvent:Connect(u136);
    l__Networking__5.Steal.RestoreFruitAppearance.OnClientEvent:Connect(u144);
    l__Networking__5.Steal.DeleteFruitModels.OnClientEvent:Connect(u151);
    l__Networking__5.Steal.AddStolenFruitVisual.OnClientEvent:Connect(u102);
    l__Networking__5.Steal.ClearStolenFruitVisuals.OnClientEvent:Connect(u119);
    l__Networking__5.Steal.PopVFX.OnClientEvent:Connect(function(p208, p209) --[[ Line: 1353 ]]
        -- upvalues: u11 (ref)
        u11(p208, p209);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p210) --[[ Line: 1359 ]]
        -- upvalues: u17 (ref), u18 (ref), u119 (ref), u30 (ref)
        local v211 = u17[p210];
        if v211 then
            v211:Destroy();
            u17[p210] = nil;
        end;
        local v212 = u18[p210];
        if v212 then
            task.cancel(v212);
            u18[p210] = nil;
        end;
        u119(p210.UserId);
        u30[p210] = nil;
    end);
    l__RunService__4.Heartbeat:Connect(function() --[[ Line: 1365 ]]
        -- upvalues: u34 (ref), l__LocalPlayer__13 (ref)
        debug.profilebegin("Controllers/StealController/Heartbeat");
        if u34 then
            local l__Character__31 = l__LocalPlayer__13.Character;
            local v213 = l__Character__31 and (l__Character__31:FindFirstChildWhichIsA("Tool") and l__Character__31:FindFirstChildOfClass("Humanoid"));
            if v213 then
                v213:UnequipTools();
            end;
        end;
        debug.profileend();
    end);
    l__LocalPlayer__13.CharacterAdded:Connect(function() --[[ Line: 1383 ]]
        -- upvalues: u22 (ref), u34 (ref), l__LocalPlayer__13 (ref)
        u22 = nil;
        if u34 then
            if not u34 then
                return;
            end;
            u34 = false;
            local v214 = l__LocalPlayer__13:FindFirstChild("PlayerGui");
            if v214 then
                v214 = v214:FindFirstChild("BackpackGui");
            end;
            if v214 then
                v214.Enabled = true;
            end;
        end;
    end);
end;
function v1.Start(_) --[[ Line: 1393 ]]
    -- upvalues: l__Fruits__11 (copy), u20 (copy)
    for _, v215 in l__Fruits__11:GetChildren() do
        if v215:IsA("ModuleScript") then
            u20[v215.Name] = require(v215);
        end;
    end;
end;
return v1;