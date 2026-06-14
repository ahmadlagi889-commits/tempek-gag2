-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 4
};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__SoundService__4 = game:GetService("SoundService");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__ContextActionService__6 = game:GetService("ContextActionService");
local l__HapticService__7 = game:GetService("HapticService");
local l__Debris__8 = game:GetService("Debris");
local l__CollectionService__9 = game:GetService("CollectionService");
local l__LocalPlayer__10 = l__Players__1.LocalPlayer;
local l__ReplicatedStorage__11 = game:GetService("ReplicatedStorage");
local l__LightingController__12 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
local l__GrowEffects__13 = require(l__ReplicatedStorage__11:WaitForChild("SharedModules"):WaitForChild("GrowEffects"));
local l__MusicTracks__14 = l__SoundService__4:WaitForChild("MusicTracks");
local u2 = {
    Normal = l__SoundService__4:WaitForChild("SFX"):WaitForChild("OfflineGrowthNormal"),
    Intense = l__SoundService__4:WaitForChild("SFX"):WaitForChild("OfflineGrowthIntense")
};
function v1.CalculateCutsceneDuration(_, p3) --[[ Line: 96 ]]
    local v4 = 0;
    local v5 = 0;
    for _, v6 in p3 do
        local v7 = v6.maxAge or 0;
        if v7 > 0 then
            v4 = v4 + math.max(v6.newAge - v6.oldAge, 0) / v7;
            v5 = v5 + 1;
        end;
        for _, v8 in v6.fruits do
            local v9 = v8.maxAge or 0;
            if v9 > 0 then
                v4 = v4 + math.max(v8.newAge - v8.oldAge, 0) / v9;
                v5 = v5 + 1;
            end;
        end;
    end;
    return v5 == 0 and 5 or math.clamp(v4 / v5, 0, 1) * 5 + 5;
end;
function v1.BuildGrowthChanges(_, p10, p11) --[[ Line: 127 ]]
    local v12 = {};
    local v13 = {};
    for v14, v15 in p11 do
        local v16 = p10[v14];
        local v17 = {
            plantId = v14,
            plantName = v15.PlantName,
            oldAge = v16 and (v16.Age or 0) or 0,
            newAge = v15.Age or 0,
            maxAge = v15.MaxAge or 0,
            fruits = {}
        };
        local v18 = v16 and (v16.Fruits or {}) or {};
        local v19 = {};
        for v20, v21 in v15.Fruits or {} do
            local v22 = v18[v20];
            local v23 = {
                fruitId = v20,
                oldAge = v22 and (v22.Age or 0) or 0,
                newAge = v21.Age or 0,
                oldOvertimeGrowth = v22 and (v22.OvertimeGrowth or 1) or 1,
                newOvertimeGrowth = v21.OvertimeGrowth or 1,
                maxAge = v21.MaxAge or 0
            };
            table.insert(v17.fruits, v23);
            v19[v20] = v23;
        end;
        table.insert(v12, v17);
        v13[v14] = {
            plant = v17,
            fruitsById = v19
        };
    end;
    return v12, v13;
end;
function v1.HasMeaningfulGrowthChanges(_, p24) --[[ Line: 174 ]]
    for _, v25 in p24 do
        local v26 = v25.oldAge or 0;
        if math.abs((v25.newAge or v26) - v26) > 0.0001 then
            return true;
        end;
        for _, v27 in v25.fruits do
            local v28 = v27.oldAge or 0;
            if math.abs((v27.newAge or v28) - v28) > 0.0001 then
                return true;
            end;
            local v29 = v27.oldOvertimeGrowth or 1;
            local v30 = v27.newOvertimeGrowth or v29;
            local v31 = math.abs(v29);
            local v32 = math.max(v31, 0.0001);
            if math.abs(v30 - v29) / v32 > 0.05 then
                return true;
            end;
        end;
    end;
    return false;
end;
function v1.ClassifyGrowthIntensity(p33, p34) --[[ Line: 204 ]]
    if not p33:HasMeaningfulGrowthChanges(p34) then
        return "Normal";
    end;
    local v35 = 0;
    local v36 = 0;
    for _, v37 in p34 do
        local v38 = v37.maxAge or 0;
        if v38 > 0 then
            v35 = v35 + math.max(v37.newAge - v37.oldAge, 0) / v38;
            v36 = v36 + 1;
        end;
        for _, v39 in v37.fruits do
            local v40 = v39.maxAge or 0;
            if v40 > 0 then
                v35 = v35 + math.max(v39.newAge - v39.oldAge, 0) / v40;
                v36 = v36 + 1;
            end;
        end;
    end;
    return v36 == 0 and "Normal" or (math.clamp(v35 / v36, 0, 1) >= 0.35 and "Intense" or "Normal");
end;
function v1.DuckMusic(_, p41) --[[ Line: 242 ]]
    -- upvalues: l__MusicTracks__14 (copy), l__TweenService__3 (copy), l__Debris__8 (copy)
    local v42 = TweenInfo.new(p41 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v43 = {};
    for _, v44 in l__MusicTracks__14:GetDescendants() do
        if v44:IsA("Sound") and v44.IsPlaying then
            v43[v44] = v44.Volume;
            local v45 = l__TweenService__3:Create(v44, v42, {
                Volume = 0.2
            });
            v45:Play();
            l__Debris__8:AddItem(v45, v42.Time);
        end;
    end;
    return v43;
end;
function v1.RestoreMusic(_, p46, p47) --[[ Line: 264 ]]
    -- upvalues: l__TweenService__3 (copy), l__Debris__8 (copy)
    local v48 = TweenInfo.new(p47 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    for v49, v50 in p46 do
        if v49 and v49.Parent then
            local v51 = l__TweenService__3:Create(v49, v48, {
                Volume = v50
            });
            v51:Play();
            l__Debris__8:AddItem(v51, v48.Time);
        end;
    end;
end;
function v1.StartGrowthSound(_, p52) --[[ Line: 282 ]]
    -- upvalues: u2 (copy)
    if not (p52 and u2[p52]) then
        return nil;
    end;
    local v53 = u2[p52];
    v53.Looped = true;
    v53.Volume = 0.35;
    v53:Play();
    return v53;
end;
function v1.StopGrowthSound(_, u54, p55) --[[ Line: 297 ]]
    -- upvalues: l__TweenService__3 (copy), l__Debris__8 (copy)
    if u54 then
        local v56 = p55 or 1;
        if v56 > 0 then
            local v57 = TweenInfo.new(v56, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v58 = l__TweenService__3:Create(u54, v57, {
                Volume = 0
            });
            v58:Play();
            l__Debris__8:AddItem(v58, v57.Time);
            v58.Completed:Once(function() --[[ Line: 309 ]]
                -- upvalues: u54 (copy)
                u54:Stop();
                u54.Looped = false;
                u54.Volume = 2;
            end);
        else
            u54:Stop();
            u54.Looped = false;
        end;
    end;
end;
function v1.ZeroAllPlantAndFruitAges(_, p59, p60, p61, p62, p63, p64) --[[ Line: 320 ]]
    local v65 = os.clock();
    local v66 = 0;
    for _, v67 in p60 do
        local v68 = p61(p59, v67.plantId);
        local v69 = p62(p59, v67.plantId);
        if v68 and v69 then
            local v70 = v67.oldAge or 0;
            v68:SetAttribute("Age", v70);
            v69.CurrentAge = v70;
        end;
        if p63 and p64 then
            for _, v71 in v67.fruits do
                local v72 = p63(p59, v67.plantId, v71.fruitId);
                local v73 = p64(p59, v67.plantId, v71.fruitId);
                if v72 and v73 then
                    local v74 = v71.oldAge or 0;
                    v72:SetAttribute("Age", v74);
                    v73.CurrentAge = v74;
                end;
            end;
        end;
        v66 = v66 + 1;
        if v66 >= 10 and os.clock() - v65 >= 0.004 then
            task.wait();
            v65 = os.clock();
            v66 = 0;
        end;
    end;
end;
function v1.ApplyFinalGrowthState(_, p75, p76, p77, p78, p79, p80, p81, p82, p83) --[[ Line: 361 ]]
    local v84 = os.clock();
    local v85 = 0;
    for _, v86 in p76 do
        local v87 = p77(p75, v86.plantId);
        local v88 = p78(p75, v86.plantId);
        if v87 and v88 then
            v87:SetAttribute("Age", v86.newAge);
            v88.CurrentAge = v86.newAge;
            v88._syncedAge = nil;
            if (v86.maxAge or 0) <= v86.newAge then
                local v89 = v87:GetAttribute("SeedName");
                if v89 and p79(v89) then
                    p80(v87);
                end;
            end;
        end;
        if p81 and (p82 and p83) then
            for _, v90 in v86.fruits do
                local v91 = p81(p75, v86.plantId, v90.fruitId);
                local v92 = p82(p75, v86.plantId, v90.fruitId);
                if v91 and v92 then
                    v91:SetAttribute("Age", v90.newAge);
                    v92.CurrentAge = v90.newAge;
                    v92.OvertimeGrowth = v90.newOvertimeGrowth;
                    v92._syncedAge = nil;
                    if (v90.maxAge or 0) <= v90.newAge then
                        p83(v91, v86.plantId, v90.fruitId);
                    end;
                end;
            end;
        end;
        v85 = v85 + 1;
        if v85 >= 10 and os.clock() - v84 >= 0.004 then
            task.wait();
            v84 = os.clock();
            v85 = 0;
        end;
    end;
end;
function v1.AttachModelsToGrowthChanges(_, p93, p94, p95, p96) --[[ Line: 421 ]]
    for _, v97 in p94 do
        v97.model = p95(p93, v97.plantId);
        if p96 then
            for _, v98 in v97.fruits do
                v98.model = p96(p93, v97.plantId, v98.fruitId);
            end;
        end;
    end;
end;
function v1.AreGrowthVisualsReady(_, p99, p100, p101, p102, p103, p104) --[[ Line: 438 ]]
    local v105 = false;
    for _, v106 in p100 do
        local v107 = p101(p99, v106.plantId);
        local v108 = p102(p99, v106.plantId);
        if v107 or v108 then
            if not (v107 and (v108 and v107.Parent)) then
                return false;
            end;
            if not v107:HasTag("InitializationComplete") then
                return false;
            end;
            v105 = true;
        end;
        if p103 and p104 then
            for _, v109 in v106.fruits do
                local v110 = p103(p99, v106.plantId, v109.fruitId);
                local v111 = p104(p99, v106.plantId, v109.fruitId);
                if v110 or v111 then
                    if not (v110 and (v111 and v110.Parent)) then
                        return false;
                    end;
                    if not v110:HasTag("InitializationComplete") then
                        return false;
                    end;
                    v105 = true;
                end;
            end;
        end;
    end;
    return v105;
end;
function v1.WaitForGrowthVisualsReady(p112, p113, p114, p115, p116, p117, p118) --[[ Line: 481 ]]
    -- upvalues: l__RunService__2 (copy)
    local v119 = os.clock();
    local v120 = 0;
    while os.clock() - v119 < 20 do
        v120 = v120 + 1;
        if v120 % 3 == 0 and p112:AreGrowthVisualsReady(p113, p114, p115, p116, p117, p118) then
            return true;
        end;
        l__RunService__2.Heartbeat:Wait();
    end;
    return false;
end;
function v1.TweenAgeAttribute(_, p121, p122, p123, p124, p125) --[[ Line: 512 ]]
    -- upvalues: l__TweenService__3 (copy), l__RunService__2 (copy)
    if p121 then
        local v126 = p125 or {};
        local v127 = v126.easingStyle or Enum.EasingStyle.Quad;
        local v128 = v126.easingDirection or Enum.EasingDirection.Out;
        local l__cancelPredicate__15 = v126.cancelPredicate;
        local l__onStep__16 = v126.onStep;
        if p122 == nil then
            local v129 = p121:GetAttribute("Age");
            p122 = typeof(v129) ~= "number" and 0 or v129;
        end;
        if p124 <= 0 then
            p121:SetAttribute("Age", p123);
            if l__onStep__16 then
                l__onStep__16(p123, 1);
            end;
            return true;
        else
            local v130 = os.clock();
            while not (l__cancelPredicate__15 and l__cancelPredicate__15()) do
                if not p121.Parent then
                    return false;
                end;
                local v131 = (os.clock() - v130) / p124;
                local v132 = math.clamp(v131, 0, 1);
                local v133 = l__TweenService__3:GetValue(v132, v127, v128);
                local v134 = p122 + (p123 - p122) * v133;
                p121:SetAttribute("Age", v134);
                if l__onStep__16 then
                    l__onStep__16(v134, v133);
                end;
                if v132 >= 1 then
                    return true;
                end;
                l__RunService__2.Heartbeat:Wait();
            end;
            return false;
        end;
    else
        return false;
    end;
end;
function v1.TweenModelScale(_, p135, p136, p137, p138, p139) --[[ Line: 576 ]]
    -- upvalues: l__TweenService__3 (copy), l__RunService__2 (copy)
    if p135 then
        local v140 = p139 or {};
        local v141 = v140.easingStyle or Enum.EasingStyle.Quad;
        local v142 = v140.easingDirection or Enum.EasingDirection.Out;
        local l__cancelPredicate__17 = v140.cancelPredicate;
        local l__onStep__18 = v140.onStep;
        local v143 = math.max(p136 == nil and 1 or p136, 0.001);
        local v144 = math.max(p137, 0.001);
        if p138 <= 0 then
            p135:ScaleTo(v144);
            if l__onStep__18 then
                l__onStep__18(v144, 1);
            end;
            return true;
        else
            local v145 = os.clock();
            while not (l__cancelPredicate__17 and l__cancelPredicate__17()) do
                if not p135.Parent then
                    return false;
                end;
                local v146 = (os.clock() - v145) / p138;
                local v147 = math.clamp(v146, 0, 1);
                local v148 = l__TweenService__3:GetValue(v147, v141, v142);
                local v149 = v143 + (v144 - v143) * v148;
                p135:ScaleTo(v149);
                if l__onStep__18 then
                    l__onStep__18(v149, v148);
                end;
                if v147 >= 1 then
                    return true;
                end;
                l__RunService__2.Heartbeat:Wait();
            end;
            return false;
        end;
    else
        return false;
    end;
end;
function v1.RunBatchedAgeTweens(_, p150, p151, p152, p153, p154) --[[ Line: 637 ]]
    -- upvalues: l__GrowEffects__13 (copy), l__TweenService__3 (copy), l__RunService__2 (copy)
    if #p150 == 0 then
        return;
    end;
    local v155 = l__GrowEffects__13.InitialScale ~= 1;
    if p151 <= 0 then
        for _, v156 in p150 do
            if v156.model and v156.model.Parent then
                if v155 then
                    local v157 = v156.model:GetScale() - 1;
                    if math.abs(v157) > 0.0001 then
                        v156.model:ScaleTo(1);
                    end;
                end;
                v156.model:SetAttribute("Age", v156.endAge);
                if v155 then
                    local v158 = v156.maxAge or 0;
                    if v158 > 0 then
                        local v159 = l__GrowEffects__13.GetGrowthScale(v156.endAge, v158);
                        if math.abs(v159 - 1) > 0.0001 then
                            v156.model:ScaleTo(v159);
                        end;
                    end;
                end;
            end;
        end;
        return;
    end;
    local v160 = os.clock();
    local v161 = 0;
    while true do
        if p154 and p154() then
            return;
        end;
        local v162 = (os.clock() - v160) / p151;
        local v163 = math.clamp(v162, 0, 1);
        local v164 = l__TweenService__3:GetValue(v163, p152, p153);
        local v165 = os.clock();
        local v166 = math.min(8, #p150);
        for v167 = 1, v166 do
            local v168 = p150[(v161 + v167 - 1) % #p150 + 1];
            if v168.model and v168.model.Parent then
                local v169 = v168.startAge + (v168.endAge - v168.startAge) * v164;
                if v155 then
                    local v170 = v168.model:GetScale() - 1;
                    if math.abs(v170) > 0.0001 then
                        v168.model:ScaleTo(1);
                    end;
                end;
                v168.model:SetAttribute("Age", v169);
                if v155 then
                    local v171 = v168.maxAge or 0;
                    if v171 > 0 then
                        local v172 = l__GrowEffects__13.GetGrowthScale(v169, v171);
                        if math.abs(v172 - 1) > 0.0001 then
                            v168.model:ScaleTo(v172);
                        end;
                    end;
                end;
            end;
            if os.clock() - v165 >= 0.004 then
                v166 = v167;
                break;
            end;
        end;
        v161 = (v161 + v166) % #p150;
        if v163 >= 1 then
            for _, v173 in p150 do
                if v173.model and v173.model.Parent then
                    if v155 then
                        local v174 = v173.model:GetScale() - 1;
                        if math.abs(v174) > 0.0001 then
                            v173.model:ScaleTo(1);
                        end;
                    end;
                    v173.model:SetAttribute("Age", v173.endAge);
                    if v155 then
                        local v175 = v173.maxAge or 0;
                        if v175 > 0 then
                            local v176 = l__GrowEffects__13.GetGrowthScale(v173.endAge, v175);
                            if math.abs(v176 - 1) > 0.0001 then
                                v173.model:ScaleTo(v176);
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
        l__RunService__2.Heartbeat:Wait();
    end;
end;
function v1.AnimateOfflineGrowthAge(p177, p178, p179) --[[ Line: 740 ]]
    local v180 = p179.animationDuration or 0;
    local l__isSkipRequested__19 = p179.isSkipRequested;
    local v181 = {};
    local v182 = {};
    for _, v183 in p178 do
        if v183.model then
            v183.model:SetAttribute("Age", v183.oldAge or 0);
        end;
        local v184 = v183.oldAge or 0;
        local v185 = v183.newAge or v184;
        if v183.model and v185 - v184 > 0.0001 then
            table.insert(v181, {
                model = v183.model,
                startAge = v184,
                endAge = v185,
                maxAge = v183.maxAge
            });
        end;
        for _, v186 in v183.fruits do
            if v186.model then
                v186.model:SetAttribute("Age", v186.oldAge or 0);
            end;
            local v187 = v186.maxAge or 0;
            local v188 = v186.oldAge or 0;
            local v189 = v186.newAge or v188;
            if v186.model and v189 - v188 > 0.0001 then
                table.insert(v182, {
                    model = v186.model,
                    startAge = v188,
                    endAge = v189,
                    maxAge = v187
                });
            end;
        end;
    end;
    local v190 = #v181 > 0;
    local v191 = #v182 > 0;
    local v192 = 0;
    if v190 then
        v192 = v192 + 0.5;
    end;
    if v191 then
        v192 = v192 + 0.5;
    end;
    if v192 <= 0 then
        return true;
    end;
    local v193 = v190 and (v180 * (0.5 / v192) or 0) or 0;
    local v194 = v191 and v180 * (0.5 / v192) or 0;
    if v190 then
        p177:RunBatchedAgeTweens(v181, v193, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, l__isSkipRequested__19);
    end;
    if l__isSkipRequested__19 and l__isSkipRequested__19() then
        return false;
    end;
    if v191 then
        p177:RunBatchedAgeTweens(v182, v194, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, l__isSkipRequested__19);
    end;
    return true;
end;
function v1.PlayOfflineCutscene(u195, p196) --[[ Line: 825 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__UserInputService__5 (copy), l__TweenService__3 (copy), l__CollectionService__9 (copy), l__HapticService__7 (copy), l__RunService__2 (copy), l__ContextActionService__6 (copy), l__LightingController__12 (copy)
    local l__oldPlants__20 = p196.oldPlants;
    local l__newPlants__21 = p196.newPlants;
    local l__effectiveGrowthTime__22 = p196.effectiveGrowthTime;
    local l__actualOfflineTime__23 = p196.actualOfflineTime;
    local l__getSpawnPoint__24 = p196.getSpawnPoint;
    local l__getSpawnedPlant__25 = p196.getSpawnedPlant;
    local l__getPlantGrowthData__26 = p196.getPlantGrowthData;
    local l__isSingleHarvestPlant__27 = p196.isSingleHarvestPlant;
    local l__addPlantHarvestPrompt__28 = p196.addPlantHarvestPrompt;
    local l__getSpawnedFruit__29 = p196.getSpawnedFruit;
    local l__getFruitGrowthData__30 = p196.getFruitGrowthData;
    local l__addFruitHarvestPrompt__31 = p196.addFruitHarvestPrompt;
    local v197 = p196.skipCamera == true;
    local v198 = p196.skipUI == true;
    local v199 = p196.skipLighting == true;
    local v200 = p196.skipMusicDuck == true;
    local v201 = p196.tweenCameraRestore == true;
    local v202 = p196.skipSFX == true;
    local v203 = p196.outlineGrowthPlants == true;
    local u204 = p196.targetUserId or l__LocalPlayer__10.UserId;
    local v205 = u204 == l__LocalPlayer__10.UserId;
    if v205 then
        l__LocalPlayer__10:SetAttribute("OfflineCutscenePlaying", true);
    end;
    local u206, u207 = u195:BuildGrowthChanges(l__oldPlants__20, l__newPlants__21);
    if #u206 == 0 then
        if v205 then
            l__LocalPlayer__10:SetAttribute("OfflineCutscenePlaying", false);
        end;
        return true;
    end;
    local u208 = {};
    if v203 then
        for _, v209 in u206 do
            if v209.model and v209.model.Parent then
                local v210 = Instance.new("Highlight");
                v210.Name = "GrowthOutline";
                v210.Adornee = v209.model;
                v210.FillColor = Color3.fromRGB(120, 255, 120);
                v210.FillTransparency = 0.6;
                v210.OutlineColor = Color3.fromRGB(180, 255, 180);
                v210.OutlineTransparency = 0;
                v210.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                v210.Parent = v209.model;
                table.insert(u208, v210);
            end;
        end;
    end;
    local function v212() --[[ Line: 902 ]]
        -- upvalues: u208 (copy)
        for _, v211 in u208 do
            if v211 and v211.Parent then
                v211:Destroy();
            end;
        end;
        table.clear(u208);
    end;
    if not u195:WaitForGrowthVisualsReady(u204, u206, l__getSpawnedPlant__25, l__getPlantGrowthData__26, l__getSpawnedFruit__29, l__getFruitGrowthData__30) then
        v212();
        if v205 then
            l__LocalPlayer__10:SetAttribute("OfflineCutscenePlaying", false);
        end;
        return false;
    end;
    local l__OfflineAnimation__32 = l__LocalPlayer__10.PlayerGui:WaitForChild("OfflineAnimation");
    if not v198 then
        local l__BottomBar__33 = l__OfflineAnimation__32.BottomBar;
        local l__TopBar__34 = l__OfflineAnimation__32.TopBar;
        l__BottomBar__33.AnchorPoint = Vector2.new(0, 0);
        l__BottomBar__33.Size = UDim2.new(1, 0, 0.141, 0);
        l__BottomBar__33.BackgroundTransparency = 0;
        l__TopBar__34.AnchorPoint = Vector2.new(0, 1);
        l__TopBar__34.Size = UDim2.new(1, 0, 0.141, 0);
        l__TopBar__34.BackgroundTransparency = 0;
        local v213 = l__BottomBar__33:FindFirstChild("Date");
        local v214 = l__BottomBar__33:FindFirstChild("Time");
        local v215 = l__BottomBar__33:FindFirstChild("HTSLabel");
        local v216 = l__TopBar__34:FindFirstChild("Title");
        if v213 then
            v213.Visible = true;
        end;
        if v214 then
            v214.Visible = true;
        end;
        if v215 and v215:IsA("TextLabel") then
            v215.Visible = true;
            local v217 = l__UserInputService__5:GetLastInputType();
            if (v217 == Enum.UserInputType.Gamepad1 or (v217 == Enum.UserInputType.Gamepad2 or v217 == Enum.UserInputType.Gamepad3)) and true or v217 == Enum.UserInputType.Gamepad4 then
                v215.Text = `Hold ({l__UserInputService__5:GetStringForKeyCode(Enum.KeyCode.ButtonA):find("Cross", 1, true) ~= nil and "X" or "A"}) to skip`;
            else
                v215.Text = "Hold to skip";
            end;
        end;
        if v216 then
            v216.Visible = true;
        end;
        task.wait(0.5);
        l__TweenService__3:Create(l__OfflineAnimation__32.BottomBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            AnchorPoint = Vector2.new(0, 1)
        }):Play();
        l__TweenService__3:Create(l__OfflineAnimation__32.TopBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            AnchorPoint = Vector2.new(0, 0)
        }):Play();
    end;
    local u218 = u195:CalculateCutsceneDuration(u206);
    local l__CurrentCamera__35 = workspace.CurrentCamera;
    local l__CameraType__36 = l__CurrentCamera__35.CameraType;
    local l__CameraSubject__37 = l__CurrentCamera__35.CameraSubject;
    local l__CFrame__38 = l__CurrentCamera__35.CFrame;
    local l__Character__39 = l__LocalPlayer__10.Character;
    if l__Character__39 then
        l__Character__39 = l__Character__39:FindFirstChild("HumanoidRootPart");
    end;
    local v219;
    if l__Character__39 and l__Character__39:IsA("BasePart") then
        v219 = l__Character__39.CFrame;
    else
        v219 = nil;
    end;
    local v220 = l__getSpawnPoint__24(u204);
    if not v220 then
        if not v198 then
            l__TweenService__3:Create(l__OfflineAnimation__32.BottomBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            l__TweenService__3:Create(l__OfflineAnimation__32.TopBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;
        v212();
        if v205 then
            l__LocalPlayer__10:SetAttribute("OfflineCutscenePlaying", false);
        end;
        return false;
    end;
    local v221 = nil;
    local v222;
    if v220 and not v197 then
        v222 = v220.Parent:FindFirstChild("Signs");
        if v222 then
            v222.Parent = nil;
        else
            v222 = v221;
        end;
    else
        v222 = v221;
    end;
    local u223 = {};
    local u224 = {};
    local u225 = {};
    local function u228(u226) --[[ Line: 1041 ]]
        -- upvalues: u223 (copy), l__LocalPlayer__10 (ref), u225 (copy), u224 (copy)
        if u223[u226] == nil then
            if u226:IsDescendantOf(l__LocalPlayer__10.PlayerGui) then
                u223[u226] = u226.Enabled;
                if u226.Enabled ~= false then
                    u225[u226] = true;
                    u226.Enabled = false;
                end;
                u224[u226] = u226:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1048 ]]
                    -- upvalues: u225 (ref), u226 (copy), u223 (ref)
                    if u225[u226] then
                        u225[u226] = nil;
                    else
                        u223[u226] = u226.Enabled;
                        if u226.Enabled then
                            local v227 = u226;
                            if v227.Enabled == false then
                                return;
                            end;
                            u225[v227] = true;
                            v227.Enabled = false;
                        end;
                    end;
                end);
            end;
        end;
    end;
    local v229;
    if v197 then
        v229 = nil;
    else
        for _, v230 in l__CollectionService__9:GetTagged("OverheadUITag") do
            if v230:IsA("BillboardGui") then
                u228(v230);
            end;
        end;
        v229 = l__CollectionService__9:GetInstanceAddedSignal("OverheadUITag"):Connect(function(p231) --[[ Line: 1069 ]]
            -- upvalues: u228 (copy)
            if p231:IsA("BillboardGui") then
                u228(p231);
            end;
        end);
    end;
    local v232 = l__OfflineAnimation__32.BottomBar:FindFirstChild("Date");
    local v233 = l__OfflineAnimation__32.BottomBar:FindFirstChild("Time");
    local v234 = l__OfflineAnimation__32.TopBar:FindFirstChild("Title");
    local l__StarterGui__40 = game:GetService("StarterGui");
    local v235 = {};
    if not v198 then
        for _, v236 in l__LocalPlayer__10.PlayerGui:GetChildren() do
            if v236:IsA("ScreenGui") and v236.Name ~= "OfflineAnimation" then
                v235[v236] = v236.Enabled;
                v236.Enabled = false;
            end;
        end;
        l__StarterGui__40:SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
        l__StarterGui__40:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        l__StarterGui__40:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    end;
    local v237 = os.time() - l__actualOfflineTime__23;
    local v238 = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    };
    local v239, v240, v241, v242, v243;
    if v197 then
        v239 = nil;
        v240 = nil;
        v241 = nil;
        v242 = nil;
        v243 = nil;
    else
        v239 = 4.2;
        local u244 = 20;
        local u245 = 200;
        local u246 = 1.3;
        local u247 = 1.8;
        local u248 = 0.075;
        local u249 = 0.55;
        local u250 = 1.25;
        local u251 = 2.2;
        local u252 = 2.4;
        local u253 = 2.1;
        local u254 = 2;
        local u255 = 18;
        local u256 = 2;
        local u257 = 7;
        local l__LookVector__41 = v220.CFrame.LookVector;
        local v258 = Vector3.new(l__LookVector__41.X, 0, l__LookVector__41.Z);
        local l__Unit__42 = (v258.Magnitude < 0.01 and Vector3.new(0, 0, -1) or v258).Unit;
        local l__Unit__43 = l__Unit__42:Cross(Vector3.new(0, 1, 0)).Unit;
        local l__Position__44 = v220.Position;
        local u259 = l__Position__44 + l__Unit__42 * 10;
        local u260 = 0;
        local u261 = 24;
        local u262 = {};
        local u263 = 0;
        v242 = function(p264, p265, p266, p267) --[[ Line: 1165 ]]
            -- upvalues: u263 (ref), u207 (copy), l__getSpawnedPlant__25 (copy), u204 (copy), l__Position__44 (copy), u262 (copy), l__Unit__43 (ref), l__Unit__42 (ref), u246 (ref), u244 (ref), u245 (ref), u259 (ref), u251 (ref), u260 (ref), u253 (ref), u261 (ref), u252 (ref), u249 (ref), u248 (ref), u250 (ref), u256 (ref), u257 (ref), u254 (ref), u255 (ref), u247 (ref)
            u263 = u263 + 1;
            local v268 = u263 <= 1 and true or u263 % 10 == 0;
            local v269 = -1;
            local v270 = (1 / 0);
            local v271 = (-1 / 0);
            local v272 = (1 / 0);
            local v273 = (-1 / 0);
            local v274 = (1 / 0);
            local v275 = (-1 / 0);
            local v276 = 0;
            local v277 = 0;
            local v278 = nil;
            for v279, v280 in u207 do
                local l__plant__45 = v280.plant;
                local u281 = l__getSpawnedPlant__25(u204, v279);
                if u281 and u281.Parent then
                    if v268 then
                        local v282, v283, v284 = pcall(function() --[[ Line: 1187 ]]
                            -- upvalues: u281 (copy)
                            return u281:GetBoundingBox();
                        end);
                        if v282 and (v283 and v284) and ((v283.Position - l__Position__44).Magnitude <= 200 and v284.Magnitude <= 400) then
                            local v285 = u281:GetScale();
                            local v286 = math.max(v285, 0.001);
                            if v286 < 1 then
                                v284 = v284 / v286;
                            end;
                            u262[v279] = {
                                cframe = v283,
                                size = v284
                            };
                        end;
                    end;
                    local v287 = u262[v279];
                    if v287 then
                        local v288 = math.max(l__plant__45.newAge - l__plant__45.oldAge, 0);
                        for _, v289 in l__plant__45.fruits do
                            v288 = v288 + math.max(v289.newAge - v289.oldAge, 0);
                        end;
                        local l__Position__46 = v287.cframe.Position;
                        local v290 = v287.size * 0.5;
                        local v291 = l__Position__46 - l__Position__44;
                        local v292 = v291:Dot(l__Unit__43);
                        local v293 = v291:Dot(l__Unit__42);
                        local v294 = math.abs(l__Unit__43.X) * v290.X + math.abs(l__Unit__43.Z) * v290.Z;
                        local v295 = math.abs(l__Unit__42.X) * v290.X + math.abs(l__Unit__42.Z) * v290.Z;
                        v270 = math.min(v270, v292 - v294);
                        v271 = math.max(v271, v292 + v294);
                        v272 = math.min(v272, v293 - v295);
                        v273 = math.max(v273, v293 + v295);
                        v274 = math.min(v274, l__Position__46.Y - v290.Y);
                        v275 = math.max(v275, l__Position__46.Y + v290.Y);
                        v276 = v276 + 1;
                        v277 = math.max(v277, v287.size.Y * 0.35);
                        if v269 < v288 then
                            v278 = {
                                pos = l__Position__46,
                                size = v287.size,
                                radius = v287.size.Magnitude * 0.5,
                                growth = v288
                            };
                            v269 = v288;
                        end;
                    end;
                end;
            end;
            local v296 = l__Position__44 + l__Unit__42 * 10;
            local v297;
            if v276 > 0 then
                v296 = l__Position__44 + l__Unit__43 * ((v270 + v271) * 0.5) + l__Unit__42 * ((v272 + v273) * 0.5) + Vector3.new(0, (v274 + v275) * 0.5 - l__Position__44.Y, 0);
                local v298 = (v271 - v270) * 0.5;
                local v299 = (v275 - v274) * 0.5;
                local v300 = (v273 - v272) * 0.5;
                local l__CurrentCamera__47 = workspace.CurrentCamera;
                local v301 = math.rad(l__CurrentCamera__47.FieldOfView * 0.5);
                local v302 = l__CurrentCamera__47.ViewportSize.X / math.max(l__CurrentCamera__47.ViewportSize.Y, 1);
                local v303 = math.tan(v301) * v302;
                local v304 = math.atan(v303);
                local v305 = math.max(v304, 0.1);
                local v306 = v298 / math.tan(v305);
                local v307 = math.max(v301, 0.1);
                local v308 = v299 / math.tan(v307);
                local v309 = (math.max(v306, v308, 5) + v300) * u246;
                v297 = math.clamp(v309, u244, u245);
            else
                v297 = u244;
            end;
            local v310;
            if v278 then
                v310 = v278.pos or v296;
            else
                v310 = v296;
            end;
            local v311 = v296:Lerp(v310, (1 - math.abs(0.5 - p265) * 2) * 0.15 + 0.15);
            local v312 = u259;
            local v313 = u251;
            local v314 = math.max(p267, 0.016666666666666666);
            u259 = v312:Lerp(v311, 1 - math.exp(-v313 * v314));
            local v315 = u260;
            local v316 = v277 - u260;
            local v317 = u253;
            local v318 = math.max(p267, 0.016666666666666666);
            u260 = v315 + v316 * (1 - math.exp(-v317 * v318));
            local v319 = u261;
            local v320 = v297 - u261;
            local v321 = u252;
            local v322 = math.max(p267, 0.016666666666666666);
            u261 = v319 + v320 * (1 - math.exp(-v321 * v322));
            local v323 = math.sin(p266 * u249) * u248;
            local l__Unit__48 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v323):VectorToWorldSpace(l__Unit__42).Unit;
            local v324 = l__Unit__43 * (math.sin(p266 * u249 * 0.6) * u250);
            local v325 = math.clamp(u256 + (u257 - u256) * p264 + u260 * 0.12, u254, u255);
            local v326 = math.clamp(u247 - u260 * 0.08, 0.35, u247);
            local v327 = u259 - l__Unit__48 * u261 + Vector3.new(0, v325, 0) + v324;
            local v328 = u259 + Vector3.new(0, v326, 0);
            return CFrame.new(v327, v328);
        end;
        l__CurrentCamera__35.CameraType = Enum.CameraType.Scriptable;
        v241 = v242(0, 0, 0, 0.016666666666666666);
        l__CurrentCamera__35.CFrame = v241;
        v243 = l__Unit__42;
        v240 = u259;
    end;
    local l__Lighting__49 = game:GetService("Lighting");
    local l__ClockTime__50 = l__Lighting__49.ClockTime;
    local v329 = math.min(l__actualOfflineTime__23 / 3600, 120);
    u195:ZeroAllPlantAndFruitAges(u204, u206, l__getSpawnedPlant__25, l__getPlantGrowthData__26, l__getSpawnedFruit__29, l__getFruitGrowthData__30);
    u195:AttachModelsToGrowthChanges(u204, u206, l__getSpawnedPlant__25, l__getSpawnedFruit__29);
    local v330 = u195:ClassifyGrowthIntensity(u206);
    local v331 = v200 and {} or u195:DuckMusic();
    local u332;
    if v202 then
        u332 = nil;
    else
        u332 = u195:StartGrowthSound(v330);
    end;
    local v333 = os.clock();
    local u334;
    if u332 then
        u334 = true;
        task.spawn(function() --[[ Line: 1342 ]]
            -- upvalues: l__HapticService__7 (ref), u334 (ref), u332 (copy), l__RunService__2 (ref)
            local v335 = 0;
            local v336 = (-1 / 0);
            local v337 = os.clock();
            local v338 = 0;
            local u339 = false;
            local u340 = false;
            pcall(function() --[[ Line: 1354 ]]
                -- upvalues: u339 (ref), l__HapticService__7 (ref), u340 (ref)
                u339 = l__HapticService__7:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small);
                u340 = l__HapticService__7:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large);
            end);
            local v341 = u340;
            local v342 = u339;
            while u334 and (u332 and u332.IsPlaying) do
                local v343 = os.clock();
                math.max(v343 - v337, 0.004166666666666667);
                local l__PlaybackLoudness__51 = u332.PlaybackLoudness;
                if v338 < l__PlaybackLoudness__51 then
                    v338 = l__PlaybackLoudness__51;
                end;
                local v344 = math.clamp(l__PlaybackLoudness__51 / 10, 0, 1) ^ 5;
                if v344 >= 0.05 and v343 - v336 >= 0.3 then
                    v335 = math.clamp(v344 * 2, 0, 1);
                    v336 = v343;
                end;
                local v345 = v335 * math.exp(-(v343 - v336) * 8) * 0.6;
                local u346 = math.min(v345, 0.6);
                if v342 then
                    pcall(function() --[[ Line: 1388 ]]
                        -- upvalues: l__HapticService__7 (ref), u346 (copy)
                        l__HapticService__7:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, u346);
                    end);
                end;
                if v341 then
                    pcall(function() --[[ Line: 1393 ]]
                        -- upvalues: l__HapticService__7 (ref), u346 (copy)
                        l__HapticService__7:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, u346 * 0.4);
                    end);
                end;
                if v336 == v343 then
                    local u347 = math.clamp(v335 * 0.6 * 1.5, 0, 1);
                    task.spawn(function() --[[ Line: 1402 ]]
                        -- upvalues: u347 (copy)
                        local v349, u350 = pcall(function() --[[ Line: 1403 ]]
                            -- upvalues: u347 (ref)
                            local v348 = Instance.new("HapticEffect");
                            v348.Type = Enum.HapticEffectType.Custom;
                            v348:SetWaveformKeys({ FloatCurveKey.new(0, 0, Enum.KeyInterpolationMode.Linear), FloatCurveKey.new(27.5, u347, Enum.KeyInterpolationMode.Linear), FloatCurveKey.new(110, 0, Enum.KeyInterpolationMode.Linear) });
                            v348.Parent = workspace;
                            return v348;
                        end);
                        if v349 and u350 then
                            u350.Ended:Connect(function() --[[ Line: 1415 ]]
                                -- upvalues: u350 (copy)
                                u350:Destroy();
                            end);
                            pcall(function() --[[ Line: 1418 ]]
                                -- upvalues: u350 (copy)
                                u350:Play();
                            end);
                        end;
                    end);
                end;
                l__RunService__2.Heartbeat:Wait();
                v337 = v343;
            end;
            pcall(function() --[[ Line: 1334 ]]
                -- upvalues: l__HapticService__7 (ref)
                l__HapticService__7:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0);
                l__HapticService__7:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0);
            end);
        end);
    end;
    local v351 = 0;
    local u352 = 0;
    local u353 = 0;
    local u354 = false;
    local u355 = false;
    local u356 = nil;
    local u357 = false;
    local v358 = {};
    local v359, v360;
    if v198 then
        v359 = nil;
        v360 = false;
    else
        local u361 = Instance.new("Frame");
        u361.Name = "HoldProgressBar";
        u361.AnchorPoint = Vector2.new(0, 0);
        u361.Position = UDim2.new(0, 0, 0, 0);
        u361.Size = UDim2.new(0, 0, 0, 4);
        u361.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        u361.BackgroundTransparency = 0.2;
        u361.BorderSizePixel = 0;
        u361.ZIndex = l__OfflineAnimation__32.BottomBar.ZIndex + 1;
        u361.Parent = l__OfflineAnimation__32.BottomBar;
        local function u362() --[[ Line: 1478 ]]
            -- upvalues: u356 (ref), u361 (ref), l__TweenService__3 (ref)
            u356 = nil;
            if u361 then
                l__TweenService__3:Create(u361, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 0, 0, 4)
                }):Play();
            end;
        end;
        table.insert(v358, l__UserInputService__5.InputBegan:Connect(function(p363, _) --[[ Line: 1491 ]]
            -- upvalues: u356 (ref)
            if p363.UserInputType == Enum.UserInputType.MouseButton1 and true or p363.UserInputType == Enum.UserInputType.Touch then
                u356 = os.clock();
            end;
        end));
        table.insert(v358, l__UserInputService__5.InputEnded:Connect(function(p364, _) --[[ Line: 1497 ]]
            -- upvalues: u362 (copy)
            if p364.UserInputType == Enum.UserInputType.MouseButton1 and true or p364.UserInputType == Enum.UserInputType.Touch then
                u362();
            end;
        end));
        l__ContextActionService__6:BindActionAtPriority("OfflineCutsceneSkipHold", function(_, p365, _) --[[ Line: 1508 ]]
            -- upvalues: u356 (ref), u362 (copy)
            if p365 == Enum.UserInputState.Begin then
                u356 = os.clock();
            elseif p365 == Enum.UserInputState.End or p365 == Enum.UserInputState.Cancel then
                u362();
            end;
            return Enum.ContextActionResult.Pass;
        end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonA, Enum.KeyCode.ButtonR2);
        v359 = u361;
        v360 = true;
    end;
    task.spawn(function() --[[ Line: 1524 ]]
        -- upvalues: u195 (copy), u206 (copy), l__effectiveGrowthTime__22 (copy), l__actualOfflineTime__23 (copy), u218 (copy), u207 (copy), u353 (ref), u352 (ref), u357 (ref), u355 (ref), u354 (ref)
        local v366, v367 = pcall(function() --[[ Line: 1525 ]]
            -- upvalues: u195 (ref), u206 (ref), l__effectiveGrowthTime__22 (ref), l__actualOfflineTime__23 (ref), u218 (ref), u207 (ref), u353 (ref), u352 (ref), u357 (ref)
            return u195:AnimateOfflineGrowthAge(u206, {
                effectiveGrowthTime = l__effectiveGrowthTime__22,
                actualOfflineTime = l__actualOfflineTime__23,
                animationDuration = u218,
                changesByPlantId = u207,
                getAlpha = function() --[[ Name: getAlpha, Line 1531 ]]
                    -- upvalues: u353 (ref)
                    return u353;
                end,
                getRawAlpha = function() --[[ Name: getRawAlpha, Line 1532 ]]
                    -- upvalues: u352 (ref)
                    return u352;
                end,
                isSkipRequested = function() --[[ Name: isSkipRequested, Line 1533 ]]
                    -- upvalues: u357 (ref)
                    return u357;
                end
            });
        end);
        if v366 then
            u355 = v367 == true;
        else
            u355 = false;
        end;
        u354 = true;
    end);
    while true do
        local v368 = os.clock() - v333;
        local v369 = math.clamp(v368 / u218, 0, 1);
        local v370 = v369 < 0.5 and v369 * 2 * v369 or 1 - (v369 * -2 + 2) ^ 3 / 2;
        if not v199 then
            l__Lighting__49.ClockTime = (l__ClockTime__50 + v329 * v370) % 24;
        end;
        if u332 and u332.IsPlaying then
            u332.Volume = v369 ^ 1.6 * 2.25 + 0.35;
        end;
        local v371, v372;
        if v198 then
            v371 = v369;
            v372 = v370;
        else
            if v232 and v233 then
                local v373 = os.date("*t", v237 + l__actualOfflineTime__23 * v370);
                local v374 = v238[v373.month];
                local l__day__52 = v373.day;
                v232.Text = string.format("%s %d%s %d", v374, v373.day, (l__day__52 == 1 or (l__day__52 == 21 or l__day__52 == 31)) and "st" or ((l__day__52 == 2 or l__day__52 == 22) and "nd" or ((l__day__52 == 3 or l__day__52 == 23) and "rd" or "th")), v373.year);
                local v375 = v373.hour % 12;
                v233.Text = string.format("%d:%02d %s", v375 == 0 and 12 or v375, v373.min, v373.hour >= 12 and "PM" or "AM");
            end;
            v371 = v369;
            v372 = v370;
            for v376 in v235 do
                if v376:IsA("ScreenGui") then
                    v376.Enabled = false;
                end;
            end;
        end;
        if not v197 then
            l__CurrentCamera__35.CameraType = Enum.CameraType.Scriptable;
            v241 = v241:Lerp(v242(v372, v371, v368, v351), (math.clamp(v239 * ((1 - v371) * 0.45 + 0.55) * v351, 0, 0.12)));
            l__CurrentCamera__35.CFrame = v241;
        end;
        if not v198 and u356 then
            local v377 = (os.clock() - u356) / 1;
            local v378 = math.clamp(v377, 0, 1);
            if v359 then
                v359.Size = UDim2.new(v378, 0, 0, 4);
            end;
            u357 = v378 >= 1 and true or u357;
        end;
        if u357 or u354 and (u355 and u218 <= v368) then
            break;
        end;
        v351 = l__RunService__2.Heartbeat:Wait();
    end;
    for _, v379 in v358 do
        v379:Disconnect();
    end;
    if v360 then
        l__ContextActionService__6:UnbindAction("OfflineCutsceneSkipHold");
    end;
    u334 = false;
    pcall(function() --[[ Line: 1334 ]]
        -- upvalues: l__HapticService__7 (ref)
        l__HapticService__7:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0);
        l__HapticService__7:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0);
    end);
    if u357 then
        u195:StopGrowthSound(u332, 0);
        u195:RestoreMusic(v331, 0.3);
    else
        u195:StopGrowthSound(u332, 1.5);
        u195:RestoreMusic(v331, 1.5);
    end;
    if v359 then
        v359:Destroy();
    end;
    if not (v197 or u357) then
        local v380 = os.clock();
        while os.clock() - v380 < 2 do
            local v381 = (os.clock() - v380) / 2;
            local v382 = math.clamp(v381, 0, 1);
            l__TweenService__3:GetValue(v382, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v383 = v242(1, 1, os.clock() - v333, v351);
            v241 = v241:Lerp(v383:Lerp(CFrame.new(v383.Position + Vector3.new(0, -1.25, 0) + v243 * 2, v240 + Vector3.new(0, 0.55, 0)), v382), (math.clamp(3.2 * v351, 0, 0.1)));
            l__CurrentCamera__35.CFrame = v241;
            v351 = l__RunService__2.Heartbeat:Wait();
        end;
    end;
    if v222 then
        v222.Parent = v220.Parent;
    end;
    if v229 then
        v229:Disconnect();
    end;
    for v384, v385 in u223 do
        local v386 = u224[v384];
        if v386 then
            v386:Disconnect();
            u224[v384] = nil;
        end;
        u225[v384] = nil;
        if v384.Parent then
            v384.Enabled = v385;
        end;
    end;
    table.clear(u223);
    if not v198 then
        if v232 then
            v232.Visible = false;
        end;
        if v233 then
            v233.Visible = false;
        end;
        if v234 then
            v234.Visible = false;
        end;
        local v387 = l__OfflineAnimation__32.BottomBar:FindFirstChild("HTSLabel");
        if v387 then
            v387.Visible = false;
        end;
        l__TweenService__3:Create(l__OfflineAnimation__32.BottomBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 0.5)
        }):Play();
        l__TweenService__3:Create(l__OfflineAnimation__32.TopBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 0.5)
        }):Play();
        task.wait(0.5);
    end;
    if not v199 then
        l__LightingController__12:SetImmediate({
            ClockTime = l__LightingController__12:GetCurrentTarget().ClockTime
        });
    end;
    if not v198 then
        l__StarterGui__40:SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
        l__StarterGui__40:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        for v388, v389 in v235 do
            v388.Enabled = v389;
        end;
    end;
    if not u354 then
        while not u354 do
            l__RunService__2.Heartbeat:Wait();
        end;
    end;
    u195:ApplyFinalGrowthState(u204, u206, l__getSpawnedPlant__25, l__getPlantGrowthData__26, l__isSingleHarvestPlant__27, l__addPlantHarvestPrompt__28, l__getSpawnedFruit__29, l__getFruitGrowthData__30, l__addFruitHarvestPrompt__31);
    if not v197 then
        if v201 then
            local l__CFrame__53 = l__CurrentCamera__35.CFrame;
            local v390;
            if v219 then
                v390 = v219:ToObjectSpace(l__CFrame__38);
            else
                v390 = nil;
            end;
            local v391 = os.clock();
            while true do
                local v392 = (os.clock() - v391) / 0.3;
                local v393 = math.clamp(v392, 0, 1);
                local v394 = l__TweenService__3:GetValue(v393, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                local l__Character__54 = l__LocalPlayer__10.Character;
                if l__Character__54 then
                    l__Character__54 = l__Character__54:FindFirstChild("HumanoidRootPart");
                end;
                local v395;
                if l__Character__54 and (l__Character__54:IsA("BasePart") and v390) then
                    v395 = l__Character__54.CFrame * v390;
                else
                    v395 = l__CFrame__38;
                end;
                l__CurrentCamera__35.CFrame = l__CFrame__53:Lerp(v395, v394);
                if v393 >= 1 then
                    break;
                end;
                l__RunService__2.Heartbeat:Wait();
            end;
            l__CurrentCamera__35.CameraType = l__CameraType__36;
            l__CurrentCamera__35.CameraSubject = l__CameraSubject__37;
        else
            l__CurrentCamera__35.CameraType = l__CameraType__36;
            l__CurrentCamera__35.CameraSubject = l__CameraSubject__37;
            l__CurrentCamera__35.CFrame = l__CFrame__38;
        end;
    end;
    if not v198 then
        l__TweenService__3:Create(l__OfflineAnimation__32.BottomBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        l__TweenService__3:Create(l__OfflineAnimation__32.TopBar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;
    v212();
    if v205 then
        l__LocalPlayer__10:SetAttribute("OfflineCutscenePlaying", false);
    end;
    return true;
end;
return v1;