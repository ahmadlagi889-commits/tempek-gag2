-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 4
};
local l__Players__1 = game:GetService("Players");
local l__ProximityPromptService__2 = game:GetService("ProximityPromptService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__GardenSyncController__5 = require(script.Parent.GardenSyncController);
local l__OfflineGrowthAnimationController__6 = require(script.Parent.OfflineGrowthAnimationController);
local l__SeedData__7 = require(l__ReplicatedStorage__3.SharedModules.SeedData);
local l__PlantLifecycleHandler__8 = require(script.Parent.PlantLifecycleHandler);
local l__Networking__9 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("Networking"));
require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("SellValueData"));
local l__GrowRateData__10 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("GrowRateData"));
local l__GrowEffects__11 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("GrowEffects"));
local l__PerfFlags__12 = require(l__ReplicatedStorage__3.SharedModules.Flags.PerfFlags);
local u2 = nil;
require(l__ReplicatedStorage__3.SharedModules.CalculateStealDuration);
local l__LocalPlayer__13 = l__Players__1.LocalPlayer;
local l__Gardens__14 = workspace:WaitForChild("Gardens");
local l__Plants__15 = l__ReplicatedStorage__3.PlantGenerationModules.Plants;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = false;
local u10 = {};
local u11 = 0;
local u12 = {};
local u13 = nil;
local function u17() --[[ Line: 64 ]]
    local v14, v15 = pcall(function() --[[ Line: 65 ]]
        return UserSettings().GameSettings;
    end);
    if not (v14 and v15) then
        return 30;
    end;
    local l__SavedQualityLevel__16 = v15.SavedQualityLevel;
    local v16 = nil;
    if typeof(l__SavedQualityLevel__16) == "EnumItem" then
        l__SavedQualityLevel__16 = l__SavedQualityLevel__16.Value;
    elseif type(l__SavedQualityLevel__16) ~= "number" then
        l__SavedQualityLevel__16 = v16;
    end;
    return type(l__SavedQualityLevel__16) == "number" and (l__SavedQualityLevel__16 == 0 and 30 or (l__SavedQualityLevel__16 >= 7 and 60 or (l__SavedQualityLevel__16 >= 4 and 25 or 30))) or 50;
end;
local v18 = 1 / l__PerfFlags__12.AgeUpdateMaxHz:Get();
local u19;
if l__GrowEffects__11.SmoothGrow then
    local v20 = u17();
    local v21 = v20 <= 0 and 0.02 or 1 / math.clamp(v20, 15, 60);
    u19 = math.max(v21, 0.1, v18);
else
    u19 = math.max(l__GrowEffects__11.GrowTick, 0.1, v18);
end;
local u22 = 0;
local function u29(p23, p24, p25, p26) --[[ Line: 125 ]]
    -- upvalues: l__GrowEffects__11 (copy)
    if l__GrowEffects__11.InitialScale == 1 then
        p23:SetAttribute("Age", p24);
    else
        p23:SetAttribute("Age", p24);
        local v27 = p26 and 1 or l__GrowEffects__11.GetGrowthScale(p24, p25);
        local v28 = v27 - p23:GetScale();
        if math.abs(v28) > 0.0001 then
            p23:ScaleTo(v27);
        end;
    end;
end;
local function u34(p30) --[[ Line: 165 ]]
    local v31 = p30:FindFirstChild("HarvestPart");
    if v31 and v31:IsA("BasePart") then
        return v31;
    end;
    local v32 = p30.PrimaryPart or p30:FindFirstChildWhichIsA("BasePart");
    if not v32 then
        return nil;
    end;
    local v33 = Instance.new("Part");
    v33.Name = "HarvestPart";
    v33.Size = Vector3.new(1, 1, 1);
    v33.Transparency = 1;
    v33.Anchored = true;
    v33.CanCollide = false;
    v33.CanTouch = false;
    v33.CanQuery = false;
    v33.CFrame = v32.CFrame;
    v33.Parent = p30;
    return v33;
end;
function v1.AddGrowPrompt(_, p35) --[[ Line: 185 ]]
    -- upvalues: u34 (copy)
    if p35:FindFirstChild("GrowPrompt", true) then
    else
        local v36 = u34(p35);
        if v36 then
            local v37 = Instance.new("ProximityPrompt");
            v37.Name = "GrowPrompt";
            v37.ActionText = "Grow Plant🌱";
            v37.MaxActivationDistance = 10;
            v37.RequiresLineOfSight = false;
            v37.HoldDuration = 0;
            v37.Enabled = true;
            v37.Style = Enum.ProximityPromptStyle.Custom;
            v37:AddTag("GrowPrompt");
            v37.Parent = v36;
        end;
    end;
end;
function v1.RemoveGrowPrompt(_, p38) --[[ Line: 203 ]]
    local v39 = p38:FindFirstChild("GrowPrompt", true);
    if v39 then
        v39:Destroy();
    end;
end;
local function u58(p40, u41) --[[ Line: 235 ]]
    -- upvalues: u2 (ref)
    return {
        oldPlants = p40.oldPlants,
        newPlants = p40.newPlants,
        effectiveGrowthTime = p40.effectiveGrowthTime,
        actualOfflineTime = p40.actualOfflineTime,
        skipCamera = p40.skipCamera == true,
        skipUI = p40.skipUI == true,
        skipLighting = p40.skipLighting == true,
        skipMusicDuck = p40.skipMusicDuck == true,
        skipSFX = p40.skipSFX == true,
        outlineGrowthPlants = p40.outlineGrowthPlants == true,
        targetUserId = p40.targetUserId,
        tweenCameraRestore = p40.tweenCameraRestore == true,
        getSpawnPoint = function(p42) --[[ Name: getSpawnPoint, Line 265 ]]
            -- upvalues: u41 (copy)
            return u41:GetSpawnPoint(p42);
        end,
        getSpawnedPlant = function(p43, p44) --[[ Name: getSpawnedPlant, Line 266 ]]
            -- upvalues: u41 (copy)
            return u41:GetSpawnedPlant(p43, p44);
        end,
        getPlantGrowthData = function(p45, p46) --[[ Name: getPlantGrowthData, Line 267 ]]
            -- upvalues: u41 (copy)
            return u41:GetPlantGrowthData(p45, p46);
        end,
        isSingleHarvestPlant = function(p47) --[[ Name: isSingleHarvestPlant, Line 268 ]]
            -- upvalues: u41 (copy)
            return u41:IsSingleHarvestPlant(p47);
        end,
        addPlantHarvestPrompt = function(p48) --[[ Name: addPlantHarvestPrompt, Line 269 ]]
            -- upvalues: u41 (copy)
            u41:AddHarvestPrompt(p48);
        end,
        getSpawnedFruit = function(p49, p50, p51) --[[ Name: getSpawnedFruit, Line 270 ]]
            -- upvalues: u2 (ref)
            if u2 then
                return u2:GetSpawnedFruit(p49, p50, p51);
            else
                return nil;
            end;
        end,
        getFruitGrowthData = function(p52, p53, p54) --[[ Name: getFruitGrowthData, Line 274 ]]
            -- upvalues: u2 (ref)
            if u2 then
                return u2:GetFruitGrowthData(p52, p53, p54);
            else
                return nil;
            end;
        end,
        addFruitHarvestPrompt = function(p55, p56, p57) --[[ Name: addFruitHarvestPrompt, Line 278 ]]
            -- upvalues: u2 (ref)
            if u2 then
                u2:AddFruitHarvestPrompt(p55, p56, p57);
            end;
        end
    };
end;
local function u70(p59, p60) --[[ Line: 286 ]]
    -- upvalues: l__LocalPlayer__13 (copy), u3 (copy), u6 (copy), u2 (ref)
    for v61, v62 in p60 do
        local v63 = `{l__LocalPlayer__13.UserId}_{v61}`;
        local v64 = u3[v63];
        local v65 = u6[v63];
        if v64 and (v65 and v62.Age) then
            v64:SetAttribute("Age", v62.Age);
            v65.CurrentAge = v62.Age;
            if v62.Age >= v62.MaxAge and p59:IsSingleHarvestPlant(v62.PlantName) then
                p59:AddHarvestPrompt(v64);
            end;
        end;
    end;
    if u2 then
        for v66, v67 in p60 do
            if v67.Fruits then
                for v68, v69 in v67.Fruits do
                    u2:FixFruitAgeAfterFailedCutscene(l__LocalPlayer__13.UserId, v66, v68, v69);
                end;
            end;
        end;
    end;
end;
local function u74() --[[ Line: 339 ]]
    -- upvalues: l__LocalPlayer__13 (copy), l__GardenSyncController__5 (copy), u3 (copy)
    while l__LocalPlayer__13:GetAttribute("LoadingScreenActive") == true do
        task.wait();
    end;
    local l__UserId__17 = l__LocalPlayer__13.UserId;
    for _ = 1, 8 do
        local v71 = 0;
        local v72 = false;
        for v73 in l__GardenSyncController__5:GetGarden(l__UserId__17) do
            v71 = v71 + 1;
            if not u3[`{l__UserId__17}_{v73}`] then
                v72 = true;
            end;
        end;
        if v71 > 0 and not v72 then
            return;
        end;
        l__GardenSyncController__5:ReconcileLocalGarden();
        task.wait(0.5);
    end;
end;
local function u80(p75) --[[ Line: 370 ]]
    -- upvalues: l__LocalPlayer__13 (copy), l__Networking__9 (copy), u10 (copy), l__ProximityPromptService__2 (copy), l__OfflineGrowthAnimationController__6 (copy), u58 (copy), u70 (copy), u74 (copy)
    repeat
        task.wait();
    until l__LocalPlayer__13:HasTag("DataLoaded");
    local v76 = os.clock();
    while l__LocalPlayer__13:GetAttribute("OfflineGrowthProcessed") ~= true and os.clock() - v76 < 10 do
        task.wait();
    end;
    local v77;
    if l__LocalPlayer__13:GetAttribute("OfflineGrowthProcessed") == true then
        v77 = l__Networking__9.Garden.RequestOfflineGrowthData:Fire();
        if v77 and v77.processed then
            v77 = nil;
        end;
    else
        v77 = nil;
    end;
    local v78 = v77 and (v77.oldPlants and v77.newPlants);
    if v78 then
        v78 = next(v77.newPlants) ~= nil;
    end;
    local v79;
    if v77 then
        v79 = (v77.actualOfflineTime or 0) >= 30;
    else
        v79 = v77;
    end;
    if v78 and v79 then
        u10[l__LocalPlayer__13.UserId] = v77.oldPlants;
    end;
    while l__LocalPlayer__13:GetAttribute("LoadingScreenActive") == true do
        task.wait();
    end;
    if v78 and v79 then
        p75:SetOfflineCutsceneState(true);
        l__ProximityPromptService__2.Enabled = false;
        u10[l__LocalPlayer__13.UserId] = v77.oldPlants;
        if not l__OfflineGrowthAnimationController__6:PlayOfflineCutscene((u58(v77, p75))) then
            u70(p75, v77.newPlants);
        end;
    end;
    l__ProximityPromptService__2.Enabled = true;
    p75:SetOfflineCutsceneState(false);
    u10[l__LocalPlayer__13.UserId] = nil;
    l__Networking__9.Garden.RequestGardens:Fire();
    u74();
end;
local function u85(p81) --[[ Line: 452 ]]
    -- upvalues: u11 (ref), l__Networking__9 (copy), u10 (copy), l__LocalPlayer__13 (copy), l__ProximityPromptService__2 (copy), l__OfflineGrowthAnimationController__6 (copy), u58 (copy), u70 (copy)
    u11 = u11 + 1;
    local v82 = l__Networking__9.Garden.RequestGrowAllData:Fire();
    if v82 and v82.oldPlants and (v82.newPlants and next(v82.newPlants)) then
        local v83 = v82.playCutscene == true;
        local v84 = v82.skipUI == true and true or v82.skipCamera == true;
        u10[l__LocalPlayer__13.UserId] = v82.oldPlants;
        p81:SetOfflineCutsceneState(true);
        l__Networking__9.Garden.RequestGardens:Fire();
        if v83 then
            if v84 then
                l__ProximityPromptService__2.Enabled = true;
            else
                l__ProximityPromptService__2.Enabled = false;
            end;
            v82.tweenCameraRestore = true;
            if not l__OfflineGrowthAnimationController__6:PlayOfflineCutscene((u58(v82, p81))) then
                u70(p81, v82.newPlants);
            end;
        else
            u70(p81, v82.newPlants);
        end;
        p81:SetOfflineCutsceneState(false);
        u10[l__LocalPlayer__13.UserId] = nil;
        l__ProximityPromptService__2.Enabled = true;
        l__Networking__9.Garden.RequestGardens:Fire();
    else
        p81:SetOfflineCutsceneState(false);
        u10[l__LocalPlayer__13.UserId] = nil;
        l__ProximityPromptService__2.Enabled = true;
        l__Networking__9.Garden.RequestGardens:Fire();
    end;
end;
function v1.FormatTimeRemaining(_, p86) --[[ Line: 507 ]]
    if p86 <= 0 then
        return "Done!";
    else
        local v87 = math.floor(p86 / 3600);
        local v88 = math.floor(p86 % 3600 / 60);
        local v89 = math.floor(p86 % 60);
        if v87 > 0 then
            return string.format("%dh %dm", v87, v88);
        elseif v88 > 0 then
            return string.format("%dm %ds", v88, v89);
        else
            return string.format("%ds", v89);
        end;
    end;
end;
function v1.Init(_) --[[ Line: 518 ]]
    -- upvalues: l__Plants__15 (copy), u4 (copy), l__SeedData__7 (copy), u5 (copy), u2 (ref)
    for _, v90 in l__Plants__15:GetChildren() do
        if v90:IsA("ModuleScript") then
            u4[v90.Name] = require(v90);
        end;
    end;
    for _, v91 in l__SeedData__7 do
        u5[v91.SeedName] = v91;
    end;
    task.defer(function() --[[ Line: 527 ]]
        -- upvalues: u2 (ref)
        u2 = require(script.Parent.FruitVisualizerController);
    end);
end;
function v1.UpdatePlantMutation(_, p92, p93, p94) --[[ Line: 532 ]]
    -- upvalues: u9 (ref), u3 (copy)
    if u9 then
    else
        local v95 = u3[`{p92}_{p93}`];
        if v95 then
            if p94 and p94 ~= "" then
                v95:SetAttribute("Mutation", p94);
                return;
            end;
            v95:SetAttribute("Mutation", nil);
        end;
    end;
end;
function v1.Start(u96) --[[ Line: 545 ]]
    -- upvalues: l__GardenSyncController__5 (copy), u3 (copy), l__Networking__9 (copy), l__PlantLifecycleHandler__8 (copy), u19 (ref), l__PerfFlags__12 (copy), l__GrowEffects__11 (copy), u17 (copy), l__RunService__4 (copy), u22 (ref), u2 (ref), u80 (copy), u11 (ref), l__ProximityPromptService__2 (copy), u10 (copy), l__LocalPlayer__13 (copy), u85 (copy), l__OfflineGrowthAnimationController__6 (copy), u58 (copy)
    l__GardenSyncController__5:OnPlantMutationUpdated(function(p97, p98, p99) --[[ Line: 546 ]]
        -- upvalues: u96 (copy)
        u96:UpdatePlantMutation(p97, p98, p99);
    end);
    l__GardenSyncController__5:OnPlantAdded(function(p100, p101, p102) --[[ Line: 549 ]]
        -- upvalues: u96 (copy)
        u96:SpawnPlantFromData(p100, p101, p102);
    end);
    l__GardenSyncController__5:OnPlantVisualCheck(function(p103, p104, p105) --[[ Line: 552 ]]
        -- upvalues: u3 (ref), u96 (copy)
        if not u3[`{p103}_{p104}`] then
            u96:SpawnPlantFromData(p103, p104, p105);
        end;
    end);
    l__GardenSyncController__5:OnPlantRemoved(function(p106, p107) --[[ Line: 558 ]]
        -- upvalues: u96 (copy)
        u96:RemovePlantById(p106, p107);
    end);
    l__GardenSyncController__5:OnPlantGrowthUpdated(function(p108, p109, p110, p111) --[[ Line: 561 ]]
        -- upvalues: u96 (copy)
        u96:UpdatePlantGrowthData(p108, p109, p110, p111);
    end);
    l__GardenSyncController__5:OnPlantAgeSync(function(p112, p113) --[[ Line: 564 ]]
        -- upvalues: u96 (copy)
        u96:SyncPlantAges(p112, p113);
    end);
    l__Networking__9.Garden.PlantLifecycleUpdated.OnClientEvent:Connect(function(p114, p115, p116, p117) --[[ Line: 568 ]]
        -- upvalues: u3 (ref), l__PlantLifecycleHandler__8 (ref)
        local v118 = u3[tostring(p114) .. "_" .. p115];
        local v119;
        if v118 then
            v119 = v118:GetAttribute("Mutation") or nil;
        else
            v119 = nil;
        end;
        l__PlantLifecycleHandler__8:RegisterPlantModel(p114, p115, p116, p117, v118, v119);
    end);
    local v120, v121 = pcall(function() --[[ Line: 575 ]]
        return UserSettings().GameSettings;
    end);
    if v120 and (v121 and v121.GetPropertyChangedSignal) then
        v121:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() --[[ Line: 577 ]]
            -- upvalues: u19 (ref), l__PerfFlags__12 (ref), l__GrowEffects__11 (ref), u17 (ref)
            local v122 = 1 / l__PerfFlags__12.AgeUpdateMaxHz:Get();
            local v123;
            if l__GrowEffects__11.SmoothGrow then
                local v124 = u17();
                local v125 = v124 <= 0 and 0.02 or 1 / math.clamp(v124, 15, 60);
                v123 = math.max(v125, 0.1, v122);
            else
                v123 = math.max(l__GrowEffects__11.GrowTick, 0.1, v122);
            end;
            u19 = v123;
        end);
    end;
    l__PerfFlags__12.AgeUpdateMaxHz.Changed:Connect(function() --[[ Line: 582 ]]
        -- upvalues: u19 (ref), l__PerfFlags__12 (ref), l__GrowEffects__11 (ref), u17 (ref)
        local v126 = 1 / l__PerfFlags__12.AgeUpdateMaxHz:Get();
        local v127;
        if l__GrowEffects__11.SmoothGrow then
            local v128 = u17();
            local v129 = v128 <= 0 and 0.02 or 1 / math.clamp(v128, 15, 60);
            v127 = math.max(v129, 0.1, v126);
        else
            v127 = math.max(l__GrowEffects__11.GrowTick, 0.1, v126);
        end;
        u19 = v127;
    end);
    l__RunService__4.Heartbeat:Connect(function(p130) --[[ Line: 586 ]]
        -- upvalues: u22 (ref), u19 (ref), u96 (copy)
        debug.profilebegin("Controllers/PlantVisualizerController/Heartbeat");
        u22 = u22 + p130;
        local v131 = 0;
        while u19 <= u22 and v131 < 5 do
            u22 = u22 - u19;
            u96:UpdatePlantAges(u19);
            v131 = v131 + 1;
        end;
        if u22 >= 1 then
            local v132 = math.min(u22, 5);
            u22 = 0;
            u96:UpdatePlantAges(v132);
        end;
        debug.profileend();
    end);
    u2 = require(script.Parent.FruitVisualizerController);
    u96:SetOfflineCutsceneState(false);
    task.spawn(u80, u96);
    l__Networking__9.Garden.GrowAllStarting.OnClientEvent:Connect(function() --[[ Line: 608 ]]
        -- upvalues: u96 (copy), u11 (ref), l__ProximityPromptService__2 (ref), u10 (ref), l__LocalPlayer__13 (ref), l__Networking__9 (ref)
        local u133 = u96;
        u11 = u11 + 1;
        local u134 = u11;
        u133:SetOfflineCutsceneState(true);
        l__ProximityPromptService__2.Enabled = false;
        task.delay(30, function() --[[ Line: 441 ]]
            -- upvalues: u11 (ref), u134 (copy), u133 (copy), u10 (ref), l__LocalPlayer__13 (ref), l__ProximityPromptService__2 (ref), l__Networking__9 (ref)
            if u11 == u134 then
                u133:SetOfflineCutsceneState(false);
                u10[l__LocalPlayer__13.UserId] = nil;
                l__ProximityPromptService__2.Enabled = true;
                l__Networking__9.Garden.RequestGardens:Fire();
            end;
        end);
    end);
    l__Networking__9.Garden.GrowAllComplete.OnClientEvent:Connect(function() --[[ Line: 612 ]]
        -- upvalues: u85 (ref), u96 (copy)
        task.spawn(u85, u96);
    end);
    l__Networking__9.Garden.GrowAllStartingForObserver.OnClientEvent:Connect(function(p135, p136) --[[ Line: 619 ]]
        -- upvalues: l__LocalPlayer__13 (ref), u10 (ref)
        if typeof(p135) == "number" and type(p136) == "table" then
            if p135 == l__LocalPlayer__13.UserId then
            else
                u10[p135] = p136;
            end;
        end;
    end);
    l__Networking__9.Garden.GrowAllCompleteForObserver.OnClientEvent:Connect(function(u137, u138, p139) --[[ Line: 629 ]]
        -- upvalues: l__LocalPlayer__13 (ref), u10 (ref), l__OfflineGrowthAnimationController__6 (ref), u58 (ref), u96 (copy), u2 (ref)
        if typeof(u137) == "number" then
            if u137 == l__LocalPlayer__13.UserId then
            elseif type(u138) == "table" and next(u138) ~= nil then
                local u140 = u10[u137];
                if type(u140) == "table" then
                    local u141 = type(p139) ~= "table" and {} or p139;
                    task.spawn(function() --[[ Line: 651 ]]
                        -- upvalues: u140 (copy), u138 (copy), u141 (copy), u137 (copy), l__OfflineGrowthAnimationController__6 (ref), u58 (ref), u96 (ref), u2 (ref), u10 (ref)
                        local u142 = {
                            effectiveGrowthTime = 86400,
                            actualOfflineTime = 86400,
                            oldPlants = u140,
                            newPlants = u138,
                            skipCamera = u141.skipCamera == true,
                            skipUI = u141.skipUI == true,
                            skipLighting = u141.skipLighting == true,
                            skipMusicDuck = u141.skipMusicDuck == true,
                            skipSFX = u141.skipSFX == true,
                            targetUserId = u137
                        };
                        local v143, _ = pcall(function() --[[ Line: 664 ]]
                            -- upvalues: l__OfflineGrowthAnimationController__6 (ref), u58 (ref), u142 (copy), u96 (ref)
                            l__OfflineGrowthAnimationController__6:PlayOfflineCutscene((u58(u142, u96)));
                        end);
                        if not v143 and u2 then
                            for v144, v145 in u138 do
                                if v145.Fruits then
                                    for v146, v147 in v145.Fruits do
                                        u2:FixFruitAgeAfterFailedCutscene(u137, v144, v146, v147);
                                    end;
                                end;
                            end;
                        end;
                        u10[u137] = nil;
                    end);
                end;
            else
                u10[u137] = nil;
            end;
        end;
    end);
end;
function v1.GetPlayerPlot(_, p148) --[[ Line: 694 ]]
    -- upvalues: l__Players__1 (copy), l__Gardens__14 (copy)
    local v149 = l__Players__1:GetPlayerByUserId(p148);
    if v149 then
        local v150 = v149:GetAttribute("PlotId");
        if not v150 then
            for _ = 1, 50 do
                task.wait(0.1);
                local v151 = l__Players__1:GetPlayerByUserId(p148);
                if not v151 then
                    return nil;
                end;
                v150 = v151:GetAttribute("PlotId");
                if v150 then
                    break;
                end;
            end;
        end;
        if v150 then
            return l__Gardens__14:WaitForChild("Plot" .. v150, 10);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.GetSpawnPoint(p152, p153) --[[ Line: 718 ]]
    local v154 = p152:GetPlayerPlot(p153);
    if v154 then
        return v154:WaitForChild("SpawnPoint", 10);
    else
        return nil;
    end;
end;
function v1.GetPlantsFolder(p155, p156) --[[ Line: 724 ]]
    local v157 = p155:GetPlayerPlot(p156);
    if v157 then
        return v157:WaitForChild("Plants", 10);
    else
        return nil;
    end;
end;
function v1.GetSeedData(_, p158) --[[ Line: 730 ]]
    -- upvalues: u5 (copy)
    return u5[p158];
end;
function v1.GetOfflineCutsceneOldPlantAge(_, p159, p160) --[[ Line: 734 ]]
    -- upvalues: u10 (copy)
    local v161 = u10[p159];
    if v161 then
        local v162 = v161[p160];
        if v162 and typeof(v162.Age) == "number" then
            return v162.Age;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.GetOfflineCutsceneOldFruitAge(_, p163, p164, p165) --[[ Line: 742 ]]
    -- upvalues: u10 (copy)
    local v166 = u10[p163];
    if not v166 then
        return nil;
    end;
    local v167 = v166[p164];
    if v167 then
        v167 = v167.Fruits;
    end;
    if v167 then
        v167 = v167[p165];
    end;
    return (not v167 or typeof(v167.Age) ~= "number") and 0 or v167.Age;
end;
function v1.HasOfflineCutsceneSnapshot(_, p168) --[[ Line: 761 ]]
    -- upvalues: u10 (copy)
    return u10[p168] ~= nil;
end;
function v1.IsSingleHarvestPlant(p169, p170) --[[ Line: 765 ]]
    local v171 = p169:GetSeedData(p170);
    if v171 then
        return v171.IsSingleHarvest == true;
    else
        return false;
    end;
end;
function v1.AddHarvestPrompt(_, p172) --[[ Line: 771 ]]
    -- upvalues: u34 (copy), l__LocalPlayer__13 (copy)
    if p172:FindFirstChild("HarvestPrompt", true) then
    elseif p172:FindFirstChild("StealPrompt", true) then
    else
        local v173 = u34(p172);
        if v173 then
            local v174 = tonumber(p172:GetAttribute("UserId")) == l__LocalPlayer__13.UserId;
            local v175 = Instance.new("ProximityPrompt");
            v175.MaxActivationDistance = 10;
            v175.RequiresLineOfSight = false;
            v175.Enabled = true;
            v175.Style = Enum.ProximityPromptStyle.Custom;
            if v174 then
                v175.Name = "HarvestPrompt";
                v175.ActionText = "Harvest";
                v175.HoldDuration = 0;
                v175:AddTag("HarvestPrompt");
            else
                p172:GetAttribute("SeedName");
                v175.Name = "StealPrompt";
                v175.ActionText = "Steal";
                v175:AddTag("StealPrompt");
                v175.HoldDuration = 0;
            end;
            v175.Parent = v173;
        end;
    end;
end;
local l__GrowSFX__18 = game.SoundService.SFX.GrowSFX;
local u176 = {
    {
        Range = 3,
        SFX = l__GrowSFX__18.Small,
        VolumeRange = {
            Lowest = 0,
            Highest = 3
        },
        VolumeRangeSFX = {
            Lowest = 0.02,
            Highest = 0.07
        }
    },
    {
        Range = 40,
        SFX = l__GrowSFX__18.Medium,
        VolumeRange = {
            Lowest = 3,
            Highest = 40
        },
        VolumeRangeSFX = {
            Lowest = 0.07,
            Highest = 0.125
        }
    },
    {
        Range = (1 / 0),
        SFX = l__GrowSFX__18.Large,
        VolumeRange = {
            Lowest = 40,
            Highest = 100
        },
        VolumeRangeSFX = {
            Lowest = 0.125,
            Highest = 0.5
        }
    }
};
local _ = game.ReplicatedStorage.PlantGenerationModules.Plants;
local l__TweenService__19 = game:GetService("TweenService");
local u177 = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
function v1.AddGrowthSFX(_, p178, p179) --[[ Line: 858 ]]
    -- upvalues: u176 (copy), l__GrowRateData__10 (copy), l__TweenService__19 (copy), u177 (copy)
    if not p178.PrimaryPart then
        return;
    end;
    if p178.PrimaryPart:FindFirstChild("GrowSFX") then
        return;
    end;
    local _, v180 = p178:GetBoundingBox();
    local l__Magnitude__20 = v180.Magnitude;
    local v181 = nil;
    local v182 = 0;
    for _, v183 in u176 do
        if l__Magnitude__20 <= v183.Range then
            local l__Lowest__21 = v183.VolumeRange.Lowest;
            local l__Highest__22 = v183.VolumeRange.Highest;
            local l__Lowest__23 = v183.VolumeRangeSFX.Lowest;
            local l__Highest__24 = v183.VolumeRangeSFX.Highest;
            v182 = l__Lowest__23 + (l__Lowest__21 >= l__Highest__22 and 0 or math.clamp((l__Magnitude__20 - l__Lowest__21) / (l__Highest__22 - l__Lowest__21), 0, 1)) * (l__Highest__24 - l__Lowest__23);
            v181 = v183.SFX;
            break;
        end;
    end;
    if v181 then
        local v184 = l__GrowRateData__10[p179.SeedName];
        local v185 = math.clamp(0.7 + (v184 and v184.GrowRate or 0.2) * 3, 0.7, 1.3);
        local v186 = v181:Clone();
        v186.Name = "GrowSFX";
        v186.Looped = true;
        v186.Playing = true;
        v186.Volume = 0;
        local v187 = l__TweenService__19:Create(v186, u177, {
            Volume = v182 * math.random(9, 11) * 0.1
        });
        v187:Play();
        game.Debris:AddItem(v187, u177.Time);
        v186.RollOffMaxDistance = math.sqrt(v182 * 100) * 10 * math.random(9, 11) * 0.1;
        v186.PlaybackSpeed = v185 * (math.random(9, 11) * 0.1);
        v186.Parent = p178.PrimaryPart;
    end;
end;
function v1.RemoveGrowthSFX(_, p188) --[[ Line: 907 ]]
    -- upvalues: l__TweenService__19 (copy), u177 (copy)
    local v189 = p188:FindFirstChild("GrowSFX", true);
    if v189 then
        if v189:HasTag("Removing") then
        else
            v189:AddTag("Removing");
            local v190 = l__TweenService__19:Create(v189, u177, {
                Volume = 0
            });
            v190:Play();
            game.Debris:AddItem(v190, u177.Time);
            game.Debris:AddItem(v189, u177.Time);
        end;
    end;
end;
function v1.RemoveHarvestPrompt(_, p191) --[[ Line: 918 ]]
    local v192 = p191:FindFirstChild("HarvestPrompt", true);
    if v192 then
        v192:Destroy();
    end;
end;
function v1.CreateDebugGui(_, p193, _) --[[ Line: 923 ]]
    local v194 = Instance.new("BillboardGui");
    v194.Name = "DebugGui";
    v194.Size = UDim2.new(0, 250, 0, 60);
    v194.StudsOffset = Vector3.new(0, 3, 0);
    v194.AlwaysOnTop = true;
    v194.Parent = p193;
    v194.Enabled = false;
    local v195 = Instance.new("TextLabel");
    v195.Size = UDim2.new(1, 0, 1, 0);
    v195.BackgroundColor3 = Color3.new(0, 0, 0);
    v195.BackgroundTransparency = 0.5;
    v195.TextColor3 = Color3.new(1, 1, 1);
    v195.TextScaled = true;
    v195.Font = Enum.Font.SourceSansBold;
    v195.Parent = v194;
end;
function v1._StepPlantVisual(p196, p197, p198, p199) --[[ Line: 944 ]]
    -- upvalues: u3 (copy), u10 (copy), u6 (copy), u29 (copy), u12 (copy)
    local v200 = u3[p197];
    if not (v200 and v200.Parent) then
        u12[p197] = nil;
        if v200 then
            p196:RemoveGrowthSFX(v200);
        end;
        return true;
    end;
    if p199 then
        local v201 = tonumber(v200:GetAttribute("UserId"));
        if v201 and u10[v201] then
            return false;
        end;
    end;
    local v202 = u6[p197];
    if v202 then
        local v203 = v202.CurrentAge or 0;
        local v204 = math.min(v203 + p198 * v202.StableGrowthAmount, v202.MaxAge);
        local v205 = v203 < v202.MaxAge;
        local v206 = v202.MaxAge <= v204;
        v202.CurrentAge = v204;
        u29(v200, v204, v202.MaxAge, v206);
        if v205 and v206 then
            u12[p197] = nil;
            p196:RemoveGrowPrompt(v200);
            local v207 = v200:GetAttribute("SeedName");
            p196:RemoveGrowthSFX(v200);
            if p196:IsSingleHarvestPlant(v207) then
                p196:AddHarvestPrompt(v200);
            end;
            return true;
        end;
        local v208 = v200:FindFirstChild("DebugGui");
        local v209 = v208 and (v208:IsA("BillboardGui") and v208:FindFirstChildOfClass("TextLabel"));
        if v209 then
            v209.Text = string.format("%.2f/%.0f | %s\nRate: %.2f/s", v204, v202.MaxAge, p196:FormatTimeRemaining(v202.StableGrowthAmount > 0 and ((v202.MaxAge - v204) / v202.StableGrowthAmount or 0) or 0), v202.StableGrowthAmount);
        end;
    end;
    return false;
end;
function v1.UpdatePlantAges(p210, p211) --[[ Line: 998 ]]
    -- upvalues: u9 (ref), u10 (copy), u12 (copy), u6 (copy), u13 (ref), l__PerfFlags__12 (copy)
    if u9 then
        return;
    end;
    local v212 = next(u10) ~= nil;
    debug.profilebegin("Controllers/PlantVisualizerController/UpdatePlantAges/accumulate");
    local v213 = 0;
    for v214 in u12 do
        local v215 = u6[v214];
        if v215 then
            v215._pendingDt = (v215._pendingDt or 0) + p211;
        end;
        v213 = v213 + 1;
    end;
    debug.profileend();
    if v213 == 0 then
        u13 = nil;
        return;
    end;
    debug.profilebegin("Controllers/PlantVisualizerController/UpdatePlantAges/iterateGrowingPlants");
    local v216 = l__PerfFlags__12.PlantVisualizerBudget:Get();
    local v217 = math.floor(v216);
    local v218 = math.min(v217, v213);
    local v219 = u13;
    if v219 ~= nil and not u12[v219] then
        v219 = nil;
    end;
    local v220 = 0;
    while v220 < v218 do
        local v221 = next(u12, v219);
        if v221 == nil then
            v221 = next(u12, nil);
            if v221 == nil then
                break;
            end;
        end;
        local v222 = u6[v221];
        local v223 = v222 and (v222._pendingDt or 0) or 0;
        if v222 then
            v222._pendingDt = 0;
        end;
        p210:_StepPlantVisual(v221, v223, v212);
        v220 = v220 + 1;
        v219 = v221;
    end;
    u13 = v219;
    debug.profileend();
end;
function v1.UpdatePlantGrowthData(p224, p225, p226, p227, p228) --[[ Line: 1061 ]]
    -- upvalues: u9 (ref), u10 (copy), u6 (copy), u7 (copy), u3 (copy), u29 (copy), u12 (copy)
    if u9 then
    elseif u10[p225] then
    else
        local v229 = `{p225}_{p226}`;
        local v230 = u6[v229];
        if v230 then
            local v231 = v230.CurrentAge < v230.MaxAge;
            local v232 = math.max(v230.CurrentAge or 0, p227);
            local v233 = v230.MaxAge <= v232;
            v230.StableGrowthAmount = p228;
            v230.CurrentAge = v232;
            local v234 = u3[v229];
            if v234 then
                if v234.Parent then
                    u29(v234, v232, v230.MaxAge, v233);
                end;
                if v231 and v233 then
                    local v235 = v234:GetAttribute("SeedName");
                    p224:RemoveGrowPrompt(v234);
                    p224:RemoveGrowthSFX(v234);
                    if p224:IsSingleHarvestPlant(v235) then
                        p224:AddHarvestPrompt(v234);
                    end;
                end;
            end;
            local v236 = u6[v229];
            if v236 then
                local v237 = v236.MaxAge or 0;
                if v237 > 0 and v237 <= (v236.CurrentAge or 0) then
                    u12[v229] = nil;
                else
                    u12[v229] = true;
                end;
            else
                u12[v229] = nil;
            end;
        else
            u7[v229] = {
                Age = p227,
                StableGrowthAmount = p228
            };
        end;
    end;
end;
function v1.SyncPlantAges(p238, p239, p240) --[[ Line: 1103 ]]
    -- upvalues: u9 (ref), u10 (copy), u6 (copy), u3 (copy), u8 (copy), u29 (copy), u12 (copy)
    if u9 then
    elseif u10[p239] then
    else
        for v241, v249 in p240 do
            local v243 = `{p239}_{v241}`;
            local v244 = u6[v243];
            local v245 = u3[v243];
            if v244 and v245 then
                local v246 = v244.CurrentAge < v244.MaxAge;
                local v247 = math.max(v244.CurrentAge or 0, v249);
                if v244.CurrentAge >= v244.MaxAge and v249 < v244.MaxAge then
                    v247 = v244.MaxAge;
                end;
                v244.CurrentAge = v247;
                if v246 and v244.MaxAge <= v247 then
                    local v248 = v245:GetAttribute("SeedName");
                    p238:RemoveGrowPrompt(v245);
                    p238:RemoveGrowthSFX(v245);
                    if p238:IsSingleHarvestPlant(v248) then
                        p238:AddHarvestPrompt(v245);
                    end;
                end;
                if v244.CurrentAge >= v244.MaxAge and v249 < v244.MaxAge then
                    local v249 = v244.MaxAge or v249;
                end;
                u29(v245, v249, v244.MaxAge, v244.MaxAge <= v249);
                local v250 = u6[v243];
                if v250 then
                    local v251 = v250.MaxAge or 0;
                    if v251 > 0 and v251 <= (v250.CurrentAge or 0) then
                        u12[v243] = nil;
                    else
                        u12[v243] = true;
                    end;
                else
                    u12[v243] = nil;
                end;
            else
                u8[v243] = math.max(u8[v243] or 0, v249);
            end;
        end;
    end;
end;
function v1.SpawnPlantFromData(p252, p253, p254, p255) --[[ Line: 1145 ]]
    -- upvalues: u3 (copy), u4 (copy), u7 (copy), l__GrowRateData__10 (copy), u8 (copy), u6 (copy), l__GrowEffects__11 (copy), l__PlantLifecycleHandler__8 (copy), u12 (copy), l__ReplicatedStorage__3 (copy), l__LocalPlayer__13 (copy), u9 (ref), u10 (copy)
    local v256 = `{p253}_{p254}`;
    if u3[v256] then
        p252:RemovePlantById(p253, p254);
    end;
    local v257 = p252:GetSpawnPoint(p253);
    if v257 then
        local v258 = p252:GetPlantsFolder(p253);
        if v258 then
            local l__PlantName__25 = p255.PlantName;
            if l__PlantName__25 then
                local v259 = Vector3.new(p255.Positions.PosX, p255.Positions.PosY, p255.Positions.PosZ);
                local l__Rotation__26 = p255.Positions.Rotation;
                local v260 = v257.CFrame:PointToWorldSpace(v259);
                local v261 = CFrame.new(Vector3.new(0, 0, 0)) * CFrame.Angles(0, math.rad(l__Rotation__26), 0);
                local _, v262, _ = v257.CFrame:ToWorldSpace(v261):ToEulerAnglesYXZ();
                local v263 = CFrame.new(v260) * CFrame.Angles(0, v262, 0);
                local v264 = u4[l__PlantName__25];
                local v265 = p252:GetSeedData(l__PlantName__25);
                if not v264 then
                    return error((`[{script.Name}] Missing Generation Module for {l__PlantName__25}`));
                end;
                local v266 = v265.PlantModel:Clone();
                v266.Name = v256;
                v266:SetAttribute("PlantId", p254);
                v266:SetAttribute("UserId", p253);
                v266:SetAttribute("SeedName", l__PlantName__25);
                v266:SetAttribute("MaxAge", p255.MaxAge);
                if p255.PlantedAt then
                    v266:SetAttribute("PlantedAt", p255.PlantedAt);
                end;
                v266.Parent = v258;
                v266:PivotTo(v263);
                local v267 = p255.Age or 0;
                local v268 = u7[v256];
                local v269 = l__GrowRateData__10[l__PlantName__25];
                if v269 then
                    v269 = l__GrowRateData__10[l__PlantName__25].GrowRate;
                end;
                local v270 = v268 and v268.StableGrowthAmount or (v269 or 0.2);
                local v271;
                if v268 and v268.Age ~= nil then
                    v271 = math.max(v267, v268.Age);
                else
                    v271 = v267;
                end;
                if u8[v256] ~= nil then
                    v271 = math.max(v271, u8[v256]);
                end;
                local v272 = p252:GetOfflineCutsceneOldPlantAge(p253, p254);
                if typeof(v272) ~= "number" then
                    v272 = v271;
                end;
                u6[v256] = {
                    CurrentAge = v272,
                    StableGrowthAmount = v270,
                    MaxAge = p255.MaxAge,
                    _syncedAge = v267
                };
                u7[v256] = nil;
                u8[v256] = nil;
                p252:CreateDebugGui(v266, v256);
                v266:SetAttribute("Age", v272);
                v266:SetAttribute("Mutation", p255.Mutation);
                v264.InitPlant(v266, p255.Seed or 0, p255.SizeMultiplier or 1);
                u3[v256] = v266;
                if not v266:HasTag("InitializationComplete") then
                    repeat
                        task.wait();
                    until v266:HasTag("InitializationComplete");
                end;
                v264.BeginPlantGrowth(v266);
                v266:SetAttribute("PlantGrowthReady", true);
                if l__GrowEffects__11.InitialScale ~= 1 and v272 < p255.MaxAge then
                    local v273 = l__GrowEffects__11.GetGrowthScale(v272, p255.MaxAge);
                    if math.abs(v273 - 1) > 0.0001 then
                        v266:ScaleTo(v273);
                    end;
                end;
                l__PlantLifecycleHandler__8:RegisterPlantModel(p253, p254, l__PlantName__25, p255.PrimeStartedAt, v266, p255.Mutation, p255.ReviveProgress);
                local v274 = u6[v256];
                if v274 then
                    local v275 = v274.MaxAge or 0;
                    if v275 > 0 and v275 <= (v274.CurrentAge or 0) then
                        u12[v256] = nil;
                    else
                        u12[v256] = true;
                    end;
                else
                    u12[v256] = nil;
                end;
                if p255.IsPotted then
                    local v276 = l__ReplicatedStorage__3.Assets.POT:Clone();
                    v276.Name = "PotVisual";
                    v276:ScaleTo(p255.SizeMultiplier or 1);
                    for _, v277 in pairs(v276:GetDescendants()) do
                        if v277:IsA("BasePart") then
                            v277.Anchored = true;
                            v277.CanCollide = true;
                            v277.CanQuery = true;
                        end;
                    end;
                    local _, v278 = v276:GetBoundingBox();
                    local v279 = v276:GetPivot();
                    v276:PivotTo(CFrame.new(v263.Position.X, v263.Position.Y + (v279.Position.Y - (v279.Position.Y - v278.Y / 2)), v263.Position.Z) * CFrame.Angles(0, v262, 0));
                    v276.Parent = workspace;
                    local v280 = v276:FindFirstChild("PlantRoot", true);
                    if v280 then
                        local v281 = v280.WorldPosition.Y - v263.Position.Y;
                        v266:PivotTo(v266:GetPivot() * CFrame.new(0, v281, 0));
                    end;
                    v276.Parent = v266;
                    local l__PrimaryPart__27 = v276.PrimaryPart;
                    if l__PrimaryPart__27 then
                        local v282 = Instance.new("ProximityPrompt");
                        v282.Name = "PickUpPottedPlantPrompt";
                        v282.ActionText = "Pick Up";
                        v282.ObjectText = l__PlantName__25 .. " [Potted]";
                        v282.HoldDuration = 1;
                        v282.KeyboardKeyCode = Enum.KeyCode.Q;
                        v282.MaxActivationDistance = 10;
                        v282.RequiresLineOfSight = false;
                        v282.Style = Enum.ProximityPromptStyle.Custom;
                        v282:AddTag("PickUpPottedPlantPrompt");
                        v282.Parent = l__PrimaryPart__27;
                        if tonumber(p253) ~= l__LocalPlayer__13.UserId then
                            v282.Enabled = false;
                        end;
                    end;
                end;
                local v283 = u6[v256];
                if v283 then
                    v272 = v283.CurrentAge or v272;
                end;
                if not (u9 or u10[p253]) then
                    if p255.MaxAge <= v272 then
                        if p252:IsSingleHarvestPlant(l__PlantName__25) then
                            p252:AddHarvestPrompt(v266);
                        end;
                    else
                        p252:AddGrowthSFX(v266, v265);
                    end;
                end;
            end;
        end;
    end;
end;
function v1.RemovePlantById(_, p284, p285) --[[ Line: 1338 ]]
    -- upvalues: u3 (copy), l__PlantLifecycleHandler__8 (copy), u6 (copy), u7 (copy), u8 (copy), u12 (copy)
    local v286 = p284 .. "_" .. p285;
    local v287 = u3[v286];
    if v287 then
        l__PlantLifecycleHandler__8:UnregisterPlantModel(p284, p285);
        v287:Destroy();
        u3[v286] = nil;
        u6[v286] = nil;
        u7[v286] = nil;
        u8[v286] = nil;
        u12[v286] = nil;
    end;
end;
function v1.SetOfflineCutsceneState(p288, p289) --[[ Line: 1352 ]]
    -- upvalues: u9 (ref), u10 (copy), l__LocalPlayer__13 (copy), u2 (ref)
    u9 = p289;
    if not p289 then
        u10[l__LocalPlayer__13.UserId] = nil;
        p288:AddMissingPrompts();
    end;
    if u2 then
        u2:SetOfflineCutsceneState(p289);
    end;
end;
function v1.GetOfflineCutsceneState(_) --[[ Line: 1367 ]]
    -- upvalues: u9 (ref)
    return u9;
end;
function v1.AddMissingPrompts(p290) --[[ Line: 1371 ]]
    -- upvalues: u3 (copy), u6 (copy), u12 (copy)
    for v291, v292 in u3 do
        if v292 and v292.Parent then
            local v293 = u6[v291];
            if v293 and v293.CurrentAge >= v293.MaxAge then
                u12[v291] = nil;
                p290:RemoveGrowPrompt(v292);
                p290:RemoveGrowthSFX(v292);
                if not v292:FindFirstChild("HarvestPrompt", true) and (not v292:FindFirstChild("StealPrompt", true) and p290:IsSingleHarvestPlant((v292:GetAttribute("SeedName")))) then
                    p290:AddHarvestPrompt(v292);
                end;
            end;
        end;
    end;
end;
function v1.GetSpawnedPlant(_, p294, p295) --[[ Line: 1393 ]]
    -- upvalues: u3 (copy)
    return u3[`{p294}_{p295}`];
end;
function v1.GetPlantGrowthData(_, p296, p297) --[[ Line: 1397 ]]
    -- upvalues: u6 (copy)
    return u6[`{p296}_{p297}`];
end;
return v1;