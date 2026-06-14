-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__GardenSyncController__4 = require(script.Parent.GardenSyncController);
local l__PlantVisualizerController__5 = require(script.Parent.PlantVisualizerController);
local l__Networking__6 = require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("Networking"));
require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("WeightFormat"));
local l__GrowEffects__7 = require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("GrowEffects"));
local l__PerfFlags__8 = require(l__ReplicatedStorage__2.SharedModules.Flags.PerfFlags);
local l__Environment__9 = require(l__ReplicatedStorage__2.SharedModules.Environment);
local l__LocalPlayer__10 = l__Players__1.LocalPlayer;
local l__Fruits__11 = l__ReplicatedStorage__2.Assets.Fruits;
local l__Fruits__12 = l__ReplicatedStorage__2.PlantGenerationModules.Fruits;
local l__Plants__13 = l__ReplicatedStorage__2.PlantGenerationModules.Plants;
local u2 = {};
local l__SellValueData__14 = require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("SellValueData"));
local l__MutationData__15 = require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("MutationData"));
require(l__ReplicatedStorage__2.SharedModules.CalculateStealDuration);
local l__CalculateOvertimeGrowth__16 = require(l__ReplicatedStorage__2.SharedModules.CalculateOvertimeGrowth);
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = false;
local u7 = {};
local u8 = {};
local u9 = {};
local function u13() --[[ Line: 39 ]]
    local v10, v11 = pcall(function() --[[ Line: 40 ]]
        return UserSettings().GameSettings;
    end);
    if not (v10 and v11) then
        return 30;
    end;
    local l__SavedQualityLevel__17 = v11.SavedQualityLevel;
    local v12 = nil;
    if typeof(l__SavedQualityLevel__17) == "EnumItem" then
        l__SavedQualityLevel__17 = l__SavedQualityLevel__17.Value;
    elseif type(l__SavedQualityLevel__17) ~= "number" then
        l__SavedQualityLevel__17 = v12;
    end;
    return type(l__SavedQualityLevel__17) == "number" and (l__SavedQualityLevel__17 == 0 and 30 or (l__SavedQualityLevel__17 >= 7 and 60 or (l__SavedQualityLevel__17 >= 4 and 25 or 30))) or 50;
end;
local v14 = 1 / l__PerfFlags__8.AgeUpdateMaxHz:Get();
local u15;
if l__GrowEffects__7.SmoothGrow then
    local v16 = u13();
    local v17 = v16 <= 0 and 0.02 or 1 / math.clamp(v16, 15, 60);
    u15 = math.max(v17, 0.1, v14);
else
    u15 = math.max(l__GrowEffects__7.GrowTick, 0.1, v14);
end;
local u18 = 0;
local u19 = 0;
local function u24(p20) --[[ Line: 131 ]]
    local l__PrimaryPart__18 = p20.PrimaryPart;
    local v21 = Vector3.new(0, 0, 0);
    local v22 = 0;
    for _, v23 in p20:GetDescendants() do
        if v23:IsA("BasePart") and (v23 ~= l__PrimaryPart__18 and v23.Transparency < 1) then
            v21 = v21 + v23.Position;
            v22 = v22 + 1;
        end;
    end;
    if v22 == 0 then
        return nil;
    else
        return v21 / v22;
    end;
end;
local function u30(u25, u26, u27, p28) --[[ Line: 145 ]]
    -- upvalues: l__LocalPlayer__10 (copy), u24 (copy), l__Networking__6 (copy), u30 (copy)
    if type(u25) == "string" and type(u26) == "string" then
        if tonumber(u27:GetAttribute("UserId")) == l__LocalPlayer__10.UserId then
            local v29 = u24(u27) or u27:GetPivot().Position;
            l__Networking__6.ObjectPositionService.CreateServerValue:Fire(u25, u26, v29);
            if not p28 then
                task.delay(3, function() --[[ Line: 154 ]]
                    -- upvalues: u27 (copy), u30 (ref), u25 (copy), u26 (copy)
                    if u27 and u27.Parent then
                        u30(u25, u26, u27, true);
                    end;
                end);
            end;
        end;
    end;
end;
local function u35(p31) --[[ Line: 175 ]]
    local v32 = p31:FindFirstChild("HarvestPart");
    if v32 and v32:IsA("BasePart") then
        return v32;
    end;
    local v33 = p31.PrimaryPart or p31:FindFirstChildWhichIsA("BasePart");
    if not v33 then
        return nil;
    end;
    local v34 = Instance.new("Part");
    v34.Name = "HarvestPart";
    v34.Size = Vector3.new(1, 1, 1);
    v34.Transparency = 1;
    v34.Anchored = true;
    v34.CanCollide = false;
    v34.CanTouch = false;
    v34.CanQuery = false;
    v34.CFrame = v33.CFrame;
    v34.Parent = p31;
    return v34;
end;
function v1.CalculateFruitWeight(_, p36) --[[ Line: 200 ]]
    -- upvalues: l__GardenSyncController__4 (copy), u4 (copy)
    local v37 = tonumber(p36:GetAttribute("UserId"));
    local v38 = p36:GetAttribute("PlantId");
    local v39 = p36:GetAttribute("FruitId");
    local v40 = p36:GetAttribute("CorePartName");
    if v37 and v38 then
        local v41 = l__GardenSyncController__4:GetPlant(v37, v38);
        if v41 and v41.PlantName then
            v40 = v41.PlantName;
        end;
    end;
    local v42 = p36:GetAttribute("SizeMulti") or 1;
    local v43 = 1;
    if v37 and (v38 and v39) then
        local v44 = l__GardenSyncController__4:GetPlant(v37, v38);
        local v45 = v44 and v44.Fruits;
        if v45 then
            v45 = v44.Fruits[v39];
        end;
        if v45 and v45.OvertimeGrowth then
            v43 = v45.OvertimeGrowth;
        end;
    end;
    local v46 = u4[v40];
    local v47 = v46 and v46.GrowData;
    if v47 then
        v47 = v46.GrowData.BaseWeight;
    end;
    if v47 then
        return v47 * v42 * v43;
    else
        return nil;
    end;
end;
local u48 = l__RunService__3:IsStudio() or l__Environment__9.env == "Dev";
local function u49(...) --[[ Line: 237 ]]
    -- upvalues: u48 (copy)
    if u48 then
        print("[PlantWeight]", ...);
    end;
end;
function v1.CalculatePlantWeight(_, p50) --[[ Line: 243 ]]
    -- upvalues: u49 (copy), l__GardenSyncController__4 (copy), u2 (copy), l__CalculateOvertimeGrowth__16 (copy)
    local v51 = tonumber(p50:GetAttribute("UserId"));
    local v52 = p50:GetAttribute("PlantId");
    if not v51 or type(v52) ~= "string" then
        u49("FAIL: missing UserId/PlantId attributes on", p50:GetFullName(), "UserId =", p50:GetAttribute("UserId"), "PlantId =", p50:GetAttribute("PlantId"));
        return nil;
    end;
    local v53 = l__GardenSyncController__4:GetPlant(v51, v52);
    if not (v53 and v53.PlantName) then
        u49("FAIL: GardenSyncController:GetPlant returned", v53 == nil and "nil" or "data with no PlantName", "for", v51, v52);
        return nil;
    end;
    local v54 = u2[v53.PlantName];
    local v55 = v54 and v54.GrowData;
    if v55 then
        v55 = v54.GrowData.BaseWeight;
    end;
    if not v55 then
        u49("FAIL:", v53.PlantName, v54 == nil and "has no Plants generation module" or "module has no GrowData.BaseWeight");
        return nil;
    end;
    local v56 = v53.SizeMultiplier or 1;
    local l__OvertimeGrowth__19 = v53.OvertimeGrowth;
    if type(l__OvertimeGrowth__19) ~= "number" or l__OvertimeGrowth__19 <= 0 then
        local l__FinishedGrowingAt__20 = v53.FinishedGrowingAt;
        if type(l__FinishedGrowingAt__20) == "number" and l__FinishedGrowingAt__20 > 0 then
            local v57 = l__CalculateOvertimeGrowth__16(os.time() - l__FinishedGrowingAt__20);
            l__OvertimeGrowth__19 = math.max(v57, 1);
        else
            l__OvertimeGrowth__19 = 1;
        end;
    end;
    local v58 = math.clamp(l__OvertimeGrowth__19, 1, 100);
    u49(("OK: %s base=%.1f size=%.2f overtime=%.2f -> %.1fg"):format(v53.PlantName, v55, v56, v58, v55 * v56 * v58));
    return v55 * v56 * v58;
end;
function v1.Init(_) --[[ Line: 308 ]]
    -- upvalues: l__Fruits__12 (copy), u4 (copy), l__Plants__13 (copy), u2 (copy)
    for _, v59 in l__Fruits__12:GetChildren() do
        if v59:IsA("ModuleScript") then
            u4[v59.Name] = require(v59);
        end;
    end;
    for _, v60 in l__Plants__13:GetChildren() do
        if v60:IsA("ModuleScript") then
            u2[v60.Name] = require(v60);
        end;
    end;
end;
function v1.UpdateFruitMutation(_, p61, p62, p63, p64) --[[ Line: 321 ]]
    -- upvalues: u6 (ref), u3 (copy)
    if u6 then
    else
        local v65 = u3[`{p61}_{p62}_{p63}`];
        if v65 then
            if p64 and p64 ~= "" then
                v65:SetAttribute("Mutation", p64);
            else
                v65:SetAttribute("Mutation", nil);
            end;
            local v66 = v65:FindFirstChild("HarvestPrompt", true) or v65:FindFirstChild("StealPrompt", true);
            if v66 then
                v66:IsA("ProximityPrompt");
            end;
        end;
    end;
end;
function v1.Start(u67) --[[ Line: 343 ]]
    -- upvalues: l__GardenSyncController__4 (copy), u3 (copy), u15 (ref), l__PerfFlags__8 (copy), l__GrowEffects__7 (copy), u13 (copy), l__RunService__3 (copy), u18 (ref), u19 (ref), u8 (copy), u9 (copy), u30 (copy)
    l__GardenSyncController__4:OnFruitMutationUpdated(function(p68, p69, p70, p71) --[[ Line: 344 ]]
        -- upvalues: u67 (copy)
        u67:UpdateFruitMutation(p68, p69, p70, p71);
    end);
    l__GardenSyncController__4:OnFruitAdded(function(p72, p73, p74, p75) --[[ Line: 348 ]]
        -- upvalues: u67 (copy)
        u67:SpawnFruitFromData(p72, p73, p74, p75);
    end);
    l__GardenSyncController__4:OnFruitVisualCheck(function(p76, p77, p78, p79) --[[ Line: 352 ]]
        -- upvalues: u3 (ref), u67 (copy)
        if not u3[`{p76}_{p77}_{p78}`] then
            u67:SpawnFruitFromData(p76, p77, p78, p79);
        end;
    end);
    l__GardenSyncController__4:OnFruitRemoved(function(p80, p81, p82) --[[ Line: 359 ]]
        -- upvalues: u67 (copy)
        u67:RemoveFruitById(p80, p81, p82);
    end);
    l__GardenSyncController__4:OnFruitGrowthUpdated(function(p83, p84, p85, p86, p87) --[[ Line: 363 ]]
        -- upvalues: u67 (copy)
        u67:UpdateFruitGrowthData(p83, p84, p85, p86, p87);
    end);
    l__GardenSyncController__4:OnFruitAgeSync(function(p88, p89, p90) --[[ Line: 367 ]]
        -- upvalues: u67 (copy)
        u67:SyncFruitAges(p88, p89, p90);
    end);
    l__GardenSyncController__4:OnFruitOvertimeGrowthUpdated(function(p91, p92, p93, p94) --[[ Line: 371 ]]
        -- upvalues: u67 (copy)
        u67:UpdateFruitOvertimeGrowth(p91, p92, p93, p94);
    end);
    local v95, v96 = pcall(function() --[[ Line: 375 ]]
        return UserSettings().GameSettings;
    end);
    if v95 and (v96 and v96.GetPropertyChangedSignal) then
        v96:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() --[[ Line: 379 ]]
            -- upvalues: u15 (ref), l__PerfFlags__8 (ref), l__GrowEffects__7 (ref), u13 (ref)
            local v97 = 1 / l__PerfFlags__8.AgeUpdateMaxHz:Get();
            local v98;
            if l__GrowEffects__7.SmoothGrow then
                local v99 = u13();
                local v100 = v99 <= 0 and 0.02 or 1 / math.clamp(v99, 15, 60);
                v98 = math.max(v100, 0.1, v97);
            else
                v98 = math.max(l__GrowEffects__7.GrowTick, 0.1, v97);
            end;
            u15 = v98;
        end);
    end;
    l__PerfFlags__8.AgeUpdateMaxHz.Changed:Connect(function() --[[ Line: 384 ]]
        -- upvalues: u15 (ref), l__PerfFlags__8 (ref), l__GrowEffects__7 (ref), u13 (ref)
        local v101 = 1 / l__PerfFlags__8.AgeUpdateMaxHz:Get();
        local v102;
        if l__GrowEffects__7.SmoothGrow then
            local v103 = u13();
            local v104 = v103 <= 0 and 0.02 or 1 / math.clamp(v103, 15, 60);
            v102 = math.max(v104, 0.1, v101);
        else
            v102 = math.max(l__GrowEffects__7.GrowTick, 0.1, v101);
        end;
        u15 = v102;
    end);
    l__RunService__3.Heartbeat:Connect(function(p105) --[[ Line: 388 ]]
        -- upvalues: u18 (ref), u19 (ref), u15 (ref), u67 (copy), u8 (ref), u9 (ref), u3 (ref), u30 (ref)
        debug.profilebegin("Controllers/FruitVisualizerController/Heartbeat");
        u18 = u18 + p105;
        u19 = u19 + p105;
        local v106 = 0;
        while u15 <= u18 and v106 < 5 do
            u18 = u18 - u15;
            u67:UpdateFruitAges(u15);
            v106 = v106 + 1;
        end;
        if u18 >= 1 then
            local v107 = math.min(u18, 5);
            u18 = 0;
            u67:UpdateFruitAges(v107);
        end;
        if u19 >= 0.5 then
            u19 = 0;
            for v108 in u8 do
                if not u9[v108] then
                    local v109 = u3[v108];
                    if v109 and v109.Parent then
                        u9[v108] = true;
                        u30(v109:GetAttribute("PlantId"), v109:GetAttribute("FruitId"), v109);
                    end;
                end;
            end;
        end;
        debug.profileend();
    end);
end;
function v1.AddFruitHarvestPrompt(_, p110, _, _) --[[ Line: 420 ]]
    -- upvalues: u35 (copy), l__LocalPlayer__10 (copy), l__SellValueData__14 (copy), l__MutationData__15 (copy)
    if p110:FindFirstChild("HarvestPrompt", true) then
    elseif p110:FindFirstChild("StealPrompt", true) then
    else
        local v111 = u35(p110);
        if v111 then
            local v112 = tonumber(p110:GetAttribute("UserId")) == l__LocalPlayer__10.UserId;
            local v113 = Instance.new("ProximityPrompt");
            v113.Style = Enum.ProximityPromptStyle.Custom;
            if v112 then
                v113.MaxActivationDistance = 10;
                v113.RequiresLineOfSight = false;
                v113.Enabled = true;
                v113.Name = "HarvestPrompt";
                v113.ActionText = "Harvest";
                v113.HoldDuration = 0;
                v113:AddTag("HarvestPrompt");
            else
                local v114 = p110:GetAttribute("CorePartName");
                local v115 = p110:GetAttribute("SizeMulti") or 1;
                local v116 = p110:GetAttribute("Mutation");
                local v117 = l__SellValueData__14[v114] or 100;
                local v118 = not v116 and 1 or l__MutationData__15.ReturnPriceMultiplier(v116);
                math.floor(v117 * v115 ^ 3 * v118);
                v113.Name = "StealPrompt";
                v113.ActionText = "Steal";
                v113:AddTag("StealPrompt");
                v113.HoldDuration = 0;
            end;
            v113.Parent = v111;
        end;
    end;
end;
function v1.RemoveFruitHarvestPrompt(_, p119) --[[ Line: 469 ]]
    local v120 = p119:FindFirstChild("HarvestPrompt", true) or p119:FindFirstChild("StealPrompt", true);
    if v120 then
        v120:Destroy();
    end;
end;
function v1.UpdateFruitAges(p121, p122) --[[ Line: 476 ]]
    -- upvalues: u6 (ref), u7 (copy), u3 (copy), l__PlantVisualizerController__5 (copy), u5 (copy), u8 (copy), u30 (copy)
    if u6 then
    else
        debug.profilebegin("Controllers/FruitVisualizerController/UpdateFruitAges/iterateGrowingFruits");
        for v123, _ in u7 do
            local v124 = u3[v123];
            if v124 and v124.Parent then
                local v125 = tonumber(v124:GetAttribute("UserId"));
                if not (v125 and l__PlantVisualizerController__5:HasOfflineCutsceneSnapshot(v125)) then
                    local v126 = u5[v123];
                    if v126 then
                        local v127 = v126.CurrentAge or 0;
                        local v128 = math.min(v127 + p122 * v126.GrowthRate, v126.MaxAge);
                        local v129 = v127 < v126.MaxAge;
                        local v130 = v126.MaxAge <= v128;
                        v126.CurrentAge = v128;
                        local _ = v126.MaxAge;
                        local _ = v126.OvertimeGrowth or 1;
                        v124:SetAttribute("Age", v128);
                        if v129 and v130 then
                            local v131 = v124:GetAttribute("FruitId");
                            local v132 = v124:GetAttribute("PlantId");
                            p121:AddFruitHarvestPrompt(v124, v132, v131);
                            u7[v123] = nil;
                            u8[v123] = true;
                            u30(v132, v131, v124);
                        end;
                    end;
                end;
            else
                u7[v123] = nil;
                u8[v123] = nil;
            end;
        end;
        debug.profileend();
    end;
end;
function v1.UpdateFruitGrowthData(p133, p134, p135, p136, p137, p138) --[[ Line: 520 ]]
    -- upvalues: u6 (ref), l__PlantVisualizerController__5 (copy), u5 (copy), u3 (copy), u7 (copy), u8 (copy)
    if u6 then
    elseif l__PlantVisualizerController__5:HasOfflineCutsceneSnapshot(p134) then
    else
        local v139 = `{p134}_{p135}_{p136}`;
        local v140 = u5[v139];
        if v140 then
            local v141 = v140.CurrentAge < v140.MaxAge;
            v140.GrowthRate = p138;
            local v142 = math.max(p137, v140.CurrentAge);
            local v143 = math.min(v142, v140.MaxAge);
            v140.CurrentAge = v143;
            local v144 = v140.MaxAge <= v143;
            local v145 = u3[v139];
            if v145 and v145.Parent then
                local _ = v140.MaxAge;
                local _ = v140.OvertimeGrowth or 1;
                v145:SetAttribute("Age", v143);
                if v141 and v144 then
                    p133:AddFruitHarvestPrompt(v145, p135, p136);
                end;
            end;
            local v146 = u5[v139];
            if v146 then
                local v147 = v146.CurrentAge or 0;
                local v148 = v146.MaxAge or 0;
                local v149;
                if v148 > 0 then
                    v149 = v148 <= v147;
                else
                    v149 = false;
                end;
                if v149 then
                    u7[v139] = nil;
                    u8[v139] = true;
                else
                    u8[v139] = nil;
                    u7[v139] = true;
                end;
            else
                u7[v139] = nil;
                u8[v139] = nil;
            end;
        end;
    end;
end;
function v1.SyncFruitAges(p150, p151, p152, p153) --[[ Line: 553 ]]
    -- upvalues: u6 (ref), l__PlantVisualizerController__5 (copy), u5 (copy), u3 (copy), u7 (copy), u8 (copy)
    if u6 then
    elseif l__PlantVisualizerController__5:HasOfflineCutsceneSnapshot(p151) then
    else
        for v154, v163 in p153 do
            local v156 = `{p151}_{p152}_{v154}`;
            local v157 = u5[v156];
            local v158 = u3[v156];
            if v157 then
                local v159 = v157.CurrentAge < v157.MaxAge;
                local v160 = math.max(v163, v157.CurrentAge);
                if v157.CurrentAge >= v157.MaxAge and v163 < v157.MaxAge then
                    v160 = v157.MaxAge;
                end;
                local v161 = math.min(v160, v157.MaxAge);
                local v162 = v157.MaxAge <= v161;
                v157.CurrentAge = v161;
                if v159 and (v162 and v158) then
                    p150:AddFruitHarvestPrompt(v158, p152, v154);
                end;
            end;
            if v158 then
                if v157 then
                    local v163 = v157.CurrentAge or v163;
                end;
                if v157 then
                    local _ = v157.MaxAge;
                    local _ = v157.MaxAge <= v163;
                    local _ = v157.OvertimeGrowth or 1;
                    v158:SetAttribute("Age", v163);
                else
                    v158:SetAttribute("Age", v163);
                end;
            end;
            local v164 = u5[v156];
            if v164 then
                local v165 = v164.CurrentAge or 0;
                local v166 = v164.MaxAge or 0;
                local v167;
                if v166 > 0 then
                    v167 = v166 <= v165;
                else
                    v167 = false;
                end;
                if v167 then
                    u7[v156] = nil;
                    u8[v156] = true;
                else
                    u8[v156] = nil;
                    u7[v156] = true;
                end;
            else
                u7[v156] = nil;
                u8[v156] = nil;
            end;
        end;
    end;
end;
function v1.GetPlantModel(_, p168, p169) --[[ Line: 593 ]]
    -- upvalues: l__PlantVisualizerController__5 (copy)
    local v170 = `{p168}_{p169}`;
    local v171 = l__PlantVisualizerController__5:GetPlantsFolder(p168);
    if v171 then
        return v171:FindFirstChild(v170);
    else
        return nil;
    end;
end;
function v1.WaitForPlantModel(_, p172, p173) --[[ Line: 601 ]]
    -- upvalues: l__PlantVisualizerController__5 (copy)
    local v174 = os.clock();
    local v175 = `{p172}_{p173}`;
    local v176 = nil;
    while os.clock() - v174 < 10 do
        v176 = l__PlantVisualizerController__5:GetPlantsFolder(p172);
        if v176 then
            break;
        end;
        task.wait();
    end;
    if v176 then
        local v177 = v176:FindFirstChild(v175);
        while not v177 and os.clock() - v174 < 10 do
            task.wait();
            v177 = v176:FindFirstChild(v175);
        end;
        if v177 then
            while not v177:HasTag("InitializationComplete") and os.clock() - v174 < 10 do
                task.wait();
            end;
            if v177:HasTag("InitializationComplete") then
                while v177:GetAttribute("PlantGrowthReady") ~= true and os.clock() - v174 < 10 do
                    task.wait();
                end;
                if v177:GetAttribute("PlantGrowthReady") == true then
                    return v177;
                else
                    return nil;
                end;
            else
                return nil;
            end;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.SpawnFruitFromData(p178, p179, p180, p181, p182) --[[ Line: 633 ]]
    -- upvalues: u3 (copy), u6 (ref), l__GardenSyncController__4 (copy), u4 (copy), l__Fruits__11 (copy), l__PlantVisualizerController__5 (copy), u5 (copy), l__Networking__6 (copy), u7 (copy), u8 (copy), u30 (copy)
    local v183 = `{p179}_{p180}_{p181}`;
    if u3[v183] then
        if u6 then
            return;
        end;
        p178:RemoveFruitById(p179, p180, p181);
    end;
    local v184 = p178:WaitForPlantModel(p179, p180);
    if v184 then
        local v185 = l__GardenSyncController__4:GetPlant(p179, p180);
        if v185 then
            local l__PlantName__21 = v185.PlantName;
            if l__PlantName__21 then
                local v186 = u4[l__PlantName__21];
                if v186 then
                    local v187 = v184:FindFirstChild("FruitSpawnLocations");
                    if v187 then
                        local v188 = v187:GetChildren()[p182.SpawnLocationIndex];
                        if v188 and v188:IsA("BasePart") then
                            local v189 = l__Fruits__11:FindFirstChild(l__PlantName__21);
                            if v189 then
                                local v190 = v189:Clone();
                                v190.Name = v183;
                                v190:SetAttribute("FruitId", p181);
                                v190:SetAttribute("PlantId", p180);
                                v190:SetAttribute("UserId", p179);
                                v190:SetAttribute("MaxAge", p182.MaxAge);
                                v190:SetAttribute("SizeMulti", p182.SizeMultiplier or 1);
                                v190:SetAttribute("CorePartName", l__PlantName__21);
                                local v191 = v184:FindFirstChild("Fruits");
                                if not v191 then
                                    v191 = Instance.new("Folder");
                                    v191.Name = "Fruits";
                                    v191.Parent = v184;
                                end;
                                local v192 = p182.Age or 0;
                                local v193 = p182.GrowRate or 0.025;
                                local v194 = p182.OvertimeGrowth or 1;
                                local v195 = l__PlantVisualizerController__5:GetOfflineCutsceneOldFruitAge(p179, p180, p181);
                                local v196 = v195 ~= nil;
                                if not v196 then
                                    v195 = v192;
                                end;
                                u5[v183] = {
                                    CurrentAge = v195,
                                    GrowthRate = v193,
                                    MaxAge = p182.MaxAge,
                                    OvertimeGrowth = v194,
                                    _syncedAge = v192
                                };
                                v190:SetAttribute("Age", v195);
                                v190:SetAttribute("Mutation", p182.Mutation);
                                v190:PivotTo(v188.CFrame);
                                v186.InitFruit(v190, p182.Seed, p182.SizeMultiplier or 1);
                                l__Networking__6.ObjectPositionService.CreateServerValue:Fire(p180, p181, v188.Position);
                                repeat
                                    task.wait();
                                until v190:HasTag("InitializationComplete");
                                v186.BeginFruitGrowth(v190);
                                v190.Parent = v191;
                                if v196 then
                                    v190:SetAttribute("Age", v195);
                                    u5[v183].CurrentAge = v195;
                                end;
                                u3[v183] = v190;
                                local v197 = u5[v183];
                                if v197 then
                                    local v198 = v197.CurrentAge or 0;
                                    local v199 = v197.MaxAge or 0;
                                    local v200;
                                    if v199 > 0 then
                                        v200 = v199 <= v198;
                                    else
                                        v200 = false;
                                    end;
                                    if v200 then
                                        u7[v183] = nil;
                                        u8[v183] = true;
                                    else
                                        u8[v183] = nil;
                                        u7[v183] = true;
                                    end;
                                else
                                    u7[v183] = nil;
                                    u8[v183] = nil;
                                end;
                                local v201 = u5[v183];
                                if v201 then
                                    v192 = v201.CurrentAge or v192;
                                end;
                                local v202 = v201 and v201.MaxAge or p182.MaxAge;
                                if v201 then
                                    local _ = v201.OvertimeGrowth;
                                end;
                                if not v196 and v202 <= v192 then
                                    p178:AddFruitHarvestPrompt(v190, p180, p181);
                                    u30(p180, p181, v190);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function v1.RemoveFruitById(_, p203, p204, p205) --[[ Line: 732 ]]
    -- upvalues: u3 (copy), u5 (copy), u7 (copy), u8 (copy), u9 (copy)
    local v206 = `{p203}_{p204}_{p205}`;
    local v207 = u3[v206];
    if v207 then
        v207:Destroy();
        u3[v206] = nil;
        u5[v206] = nil;
        u7[v206] = nil;
        u8[v206] = nil;
        u9[v206] = nil;
    end;
end;
function v1.UpdateFruitOvertimeGrowth(_, p208, p209, p210, p211) --[[ Line: 746 ]]
    -- upvalues: u6 (ref), u5 (copy)
    if u6 then
    else
        local v212 = u5[`{p208}_{p209}_{p210}`];
        if v212 then
            v212.OvertimeGrowth = p211;
        end;
    end;
end;
function v1.SetOfflineCutsceneState(p213, p214) --[[ Line: 760 ]]
    -- upvalues: u6 (ref)
    u6 = p214;
    if not p214 then
        p213:AddMissingPrompts();
    end;
end;
function v1.AddMissingPrompts(p215) --[[ Line: 767 ]]
    -- upvalues: u3 (copy), u5 (copy)
    for v216, v217 in u3 do
        if v217 and (v217.Parent and not (v217:FindFirstChild("HarvestPrompt", true) or v217:FindFirstChild("StealPrompt", true))) then
            local v218 = u5[v216];
            if v218 and v218.CurrentAge >= v218.MaxAge then
                local v219 = v217:GetAttribute("PlantId");
                local v220 = v217:GetAttribute("FruitId");
                if v219 and v220 then
                    p215:AddFruitHarvestPrompt(v217, v219, v220);
                end;
            end;
        end;
    end;
end;
function v1.GetSpawnedFruit(_, p221, p222, p223) --[[ Line: 785 ]]
    -- upvalues: u3 (copy)
    return u3[`{p221}_{p222}_{p223}`];
end;
function v1.GetFruitGrowthData(_, p224, p225, p226) --[[ Line: 790 ]]
    -- upvalues: u5 (copy)
    return u5[`{p224}_{p225}_{p226}`];
end;
function v1.FixFruitAgeAfterFailedCutscene(p227, p228, p229, p230, p231) --[[ Line: 795 ]]
    -- upvalues: u3 (copy), u5 (copy)
    local v232 = `{p228}_{p229}_{p230}`;
    local v233 = u3[v232];
    local v234 = u5[v232];
    if v233 and (v234 and p231.Age) then
        v233:SetAttribute("Age", p231.Age);
        v234.CurrentAge = p231.Age;
        if p231.OvertimeGrowth then
            v234.OvertimeGrowth = p231.OvertimeGrowth;
        end;
        if p231.Age >= p231.MaxAge then
            p227:AddFruitHarvestPrompt(v233, p229, p230);
        end;
    end;
end;
return v1;