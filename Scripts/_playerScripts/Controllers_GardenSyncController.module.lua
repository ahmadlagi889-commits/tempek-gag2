-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = {};
local u13 = {};
local u14 = {};
local u15 = {};
local u16 = {};
local u17 = {};
local u18 = {};
local u19 = {};
local u20 = {};
local u21 = {};
local u22 = {};
local u23 = {};
local function u27(p24, ...) --[[ Line: 35 ]]
    local v25, v26 = pcall(p24, ...);
    if not v25 then
        warn((`[GardenSyncController] Garden sync callback errored: {v26}`));
    end;
end;
function v1.Init(_) --[[ Line: 46 ]] end;
function v1.Start(u28) --[[ Line: 49 ]]
    -- upvalues: l__Networking__3 (copy), l__Players__1 (copy)
    l__Networking__3.Garden.SyncAllGardens.OnClientEvent:Connect(function(p29) --[[ Line: 50 ]]
        -- upvalues: u28 (copy)
        u28:HandleGardensSync(p29);
    end);
    task.spawn(function() --[[ Line: 59 ]]
        -- upvalues: l__Networking__3 (ref)
        l__Networking__3.Garden.RequestGardens:Fire();
    end);
    l__Networking__3.Garden.PlantAdded.OnClientEvent:Connect(function(p30, p31, p32) --[[ Line: 63 ]]
        -- upvalues: u28 (copy)
        u28:HandlePlantAdded(tonumber(p30) or p30, p31, p32);
    end);
    l__Networking__3.Garden.PlantRemoved.OnClientEvent:Connect(function(p33, p34) --[[ Line: 67 ]]
        -- upvalues: u28 (copy)
        u28:HandlePlantRemoved(tonumber(p33) or p33, p34);
    end);
    l__Networking__3.Garden.PlantGrowthUpdated.OnClientEvent:Connect(function(p35, p36, p37, p38) --[[ Line: 71 ]]
        -- upvalues: u28 (copy)
        u28:HandlePlantGrowthUpdated(tonumber(p35) or p35, p36, p37, p38);
    end);
    l__Networking__3.Garden.PlantAgeSync.OnClientEvent:Connect(function(p39, p40) --[[ Line: 75 ]]
        -- upvalues: u28 (copy)
        u28:HandlePlantAgeSync(tonumber(p39) or p39, p40);
    end);
    l__Networking__3.Garden.SprinklerAdded.OnClientEvent:Connect(function(p41, p42, p43) --[[ Line: 79 ]]
        -- upvalues: u28 (copy)
        u28:HandleSprinklerAdded(tonumber(p41) or p41, p42, p43);
    end);
    l__Networking__3.Garden.SprinklerRemoved.OnClientEvent:Connect(function(p44, p45) --[[ Line: 83 ]]
        -- upvalues: u28 (copy)
        u28:HandleSprinklerRemoved(tonumber(p44) or p44, p45);
    end);
    l__Networking__3.Garden.RakeAdded.OnClientEvent:Connect(function(p46, p47, p48) --[[ Line: 87 ]]
        -- upvalues: u28 (copy)
        u28:HandleRakeAdded(tonumber(p46) or p46, p47, p48);
    end);
    l__Networking__3.Garden.RakeRemoved.OnClientEvent:Connect(function(p49, p50) --[[ Line: 91 ]]
        -- upvalues: u28 (copy)
        u28:HandleRakeRemoved(tonumber(p49) or p49, p50);
    end);
    l__Networking__3.Garden.FruitAdded.OnClientEvent:Connect(function(p51, p52, p53, p54) --[[ Line: 95 ]]
        -- upvalues: u28 (copy)
        u28:HandleFruitAdded(tonumber(p51) or p51, p52, p53, p54);
    end);
    l__Networking__3.Garden.FruitRemoved.OnClientEvent:Connect(function(p55, p56, p57) --[[ Line: 99 ]]
        -- upvalues: u28 (copy)
        u28:HandleFruitRemoved(tonumber(p55) or p55, p56, p57);
    end);
    l__Networking__3.Garden.FruitGrowthUpdated.OnClientEvent:Connect(function(p58, p59, p60, p61, p62) --[[ Line: 103 ]]
        -- upvalues: u28 (copy)
        u28:HandleFruitGrowthUpdated(tonumber(p58) or p58, p59, p60, p61, p62);
    end);
    l__Networking__3.Garden.FruitAgeSync.OnClientEvent:Connect(function(p63, p64, p65) --[[ Line: 107 ]]
        -- upvalues: u28 (copy)
        u28:HandleFruitAgeSync(tonumber(p63) or p63, p64, p65);
    end);
    l__Networking__3.Garden.FruitOvertimeGrowthUpdated.OnClientEvent:Connect(function(p66, p67, p68, p69) --[[ Line: 111 ]]
        -- upvalues: u28 (copy)
        u28:HandleFruitOvertimeGrowthUpdated(tonumber(p66) or p66, p67, p68, p69);
    end);
    l__Networking__3.Prop.PropPlaced.OnClientEvent:Connect(function(p70, p71, p72) --[[ Line: 115 ]]
        -- upvalues: u28 (copy)
        u28:HandlePropAdded(tonumber(p70) or p70, p71, p72);
    end);
    l__Networking__3.Prop.PropRemoved.OnClientEvent:Connect(function(p73, p74) --[[ Line: 119 ]]
        -- upvalues: u28 (copy)
        u28:HandlePropRemoved(tonumber(p73) or p73, p74);
    end);
    l__Networking__3.Prop.PropExtraDataUpdated.OnClientEvent:Connect(function(p75, p76, p77) --[[ Line: 123 ]]
        -- upvalues: u28 (copy)
        u28:HandlePropExtraDataUpdated(tonumber(p75) or p75, p76, p77);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p78) --[[ Line: 127 ]]
        -- upvalues: u28 (copy)
        u28:CleanupPlayerGarden(p78.UserId);
    end);
end;
function v1.OnPlantMutationUpdated(_, p79) --[[ Line: 132 ]]
    -- upvalues: l__Networking__3 (copy)
    l__Networking__3.Garden.PlantMutationUpdated.OnClientEvent:Connect(p79);
end;
function v1.OnFruitMutationUpdated(_, p80) --[[ Line: 136 ]]
    -- upvalues: l__Networking__3 (copy)
    l__Networking__3.Garden.FruitMutationUpdated.OnClientEvent:Connect(p80);
end;
local u81 = {};
local u82 = false;
local u83 = 0;
local u84 = 0;
local u85 = 0;
function v1.EnqueueSpawnEntries(p86, p87, p88) --[[ Line: 152 ]]
    -- upvalues: u82 (ref), l__LocalPlayer__4 (copy), u81 (copy), u83 (ref)
    if p88 == 0 then
    elseif p88 <= 5 and not u82 then
        for _, v89 in p87 do
            v89.fn();
        end;
    else
        local l__UserId__5 = l__LocalPlayer__4.UserId;
        for _, v90 in p87 do
            if v90.userId == l__UserId__5 then
                table.insert(u81, v90);
            end;
        end;
        for _, v91 in p87 do
            if v91.userId ~= l__UserId__5 then
                table.insert(u81, v91);
            end;
        end;
        u83 = u83 + p88;
        if u82 then
            l__LocalPlayer__4:SetAttribute("GardenLoadingTotal", u83);
        else
            p86:StartQueueProcessing();
        end;
    end;
end;
function v1.StartQueueProcessing(_) --[[ Line: 185 ]]
    -- upvalues: u82 (ref), l__LocalPlayer__4 (copy), u83 (ref), u85 (ref), u81 (copy), u84 (ref)
    u82 = true;
    task.spawn(function() --[[ Line: 188 ]]
        -- upvalues: l__LocalPlayer__4 (ref), u83 (ref), u85 (ref), u81 (ref), u84 (ref), u82 (ref)
        l__LocalPlayer__4:SetAttribute("GardenLoadingTotal", u83);
        l__LocalPlayer__4:SetAttribute("GardenLoadingProgress", 0);
        u85 = 0;
        local v92 = os.clock();
        while u85 < #u81 do
            u85 = u85 + 1;
            local v93 = u81[u85];
            v93.fn();
            u84 = u84 + v93.entityCount;
            local v94 = l__LocalPlayer__4:GetAttribute("LoadingScreenActive") == true and 0.04 or 0.004;
            if u85 < #u81 and v94 <= os.clock() - v92 then
                l__LocalPlayer__4:SetAttribute("GardenLoadingProgress", u84);
                l__LocalPlayer__4:SetAttribute("GardenLoadingTotal", u83);
                task.wait();
                v92 = os.clock();
            end;
        end;
        l__LocalPlayer__4:SetAttribute("GardenLoadingTotal", nil);
        l__LocalPlayer__4:SetAttribute("GardenLoadingProgress", nil);
        table.clear(u81);
        u82 = false;
        u83 = 0;
        u84 = 0;
        u85 = 0;
    end);
end;
function v1.IsLocalGardenLoaded(_) --[[ Line: 222 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u2 (copy), u82 (ref), u85 (ref), u81 (copy)
    local l__UserId__6 = l__LocalPlayer__4.UserId;
    if not u2[l__UserId__6] then
        return false;
    end;
    if not u82 then
        return true;
    end;
    for v95 = u85 + 1, #u81 do
        if u81[v95].userId == l__UserId__6 then
            return false;
        end;
    end;
    return true;
end;
function v1.WaitForLocalGardenLoaded(p96) --[[ Line: 238 ]]
    while not p96:IsLocalGardenLoaded() do
        task.wait();
    end;
end;
function v1.HandleGardensSync(p97, p98) --[[ Line: 244 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy), u5 (copy), u6 (copy), u27 (copy), u14 (copy), u19 (copy), u18 (copy), u10 (copy), u12 (copy), u21 (copy)
    local v99 = {};
    local v100 = 0;
    for v101, v102 in p98 do
        local u103 = tonumber(v101) or v101;
        if not u2[u103] then
            u2[u103] = {};
        end;
        if not u3[u103] then
            u3[u103] = {};
        end;
        if not u4[u103] then
            u4[u103] = {};
        end;
        if not u5[u103] then
            u5[u103] = {};
        end;
        if v102.Plants then
            for u104, u105 in v102.Plants do
                local v106 = u2[u103][u104];
                local v107 = v106 and (v106.Fruits or {}) or {};
                u2[u103][u104] = u105;
                if v106 then
                    for _, v108 in u19 do
                        task.spawn(u27, v108, u103, u104, u105);
                    end;
                    if u105.Fruits then
                        for u109, u110 in u105.Fruits do
                            if v107[u109] then
                                local v111 = v107[u109].OvertimeGrowth or 1;
                                local u112 = u110.OvertimeGrowth or 1;
                                if math.floor(v111 * 100) ~= math.floor(u112 * 100) then
                                    u2[u103][u104].Fruits[u109] = u110;
                                    table.insert(v99, {
                                        entityCount = 0,
                                        userId = u103,
                                        fn = function() --[[ Name: fn, Line 320 ]]
                                            -- upvalues: u18 (ref), u27 (ref), u103 (copy), u104 (copy), u109 (copy), u112 (copy)
                                            for _, v113 in u18 do
                                                task.spawn(u27, v113, u103, u104, u109, u112);
                                            end;
                                        end
                                    });
                                end;
                            else
                                v100 = v100 + 1;
                                table.insert(v99, {
                                    entityCount = 1,
                                    userId = u103,
                                    fn = function() --[[ Name: fn, Line 304 ]]
                                        -- upvalues: u14 (ref), u27 (ref), u103 (copy), u104 (copy), u109 (copy), u110 (copy)
                                        for _, v114 in u14 do
                                            task.spawn(u27, v114, u103, u104, u109, u110);
                                        end;
                                    end
                                });
                            end;
                        end;
                    end;
                else
                    local u115 = {};
                    if u105.Fruits then
                        for v116, v117 in u105.Fruits do
                            table.insert(u115, {
                                fruitId = v116,
                                fruitData = v117
                            });
                        end;
                    end;
                    local v118 = #u115 + 1;
                    v100 = v100 + v118;
                    table.insert(v99, {
                        userId = u103,
                        entityCount = v118,
                        fn = function() --[[ Name: fn, Line 282 ]]
                            -- upvalues: u6 (ref), u27 (ref), u103 (copy), u104 (copy), u105 (copy), u115 (copy), u14 (ref)
                            for _, v119 in u6 do
                                task.spawn(u27, v119, u103, u104, u105);
                            end;
                            for _, v120 in u115 do
                                for _, v121 in u14 do
                                    task.spawn(u27, v121, u103, u104, v120.fruitId, v120.fruitData);
                                end;
                            end;
                        end
                    });
                end;
            end;
        end;
        if v102.Sprinklers then
            for u122, u123 in v102.Sprinklers do
                if u3[u103][u122] then
                    u3[u103][u122] = u123;
                else
                    u3[u103][u122] = u123;
                    v100 = v100 + 1;
                    table.insert(v99, {
                        entityCount = 1,
                        userId = u103,
                        fn = function() --[[ Name: fn, Line 342 ]]
                            -- upvalues: u10 (ref), u27 (ref), u103 (copy), u122 (copy), u123 (copy)
                            for _, v124 in u10 do
                                task.spawn(u27, v124, u103, u122, u123);
                            end;
                        end
                    });
                end;
            end;
        end;
        if v102.Rakes then
            for u125, u126 in v102.Rakes do
                if u4[u103][u125] then
                    u4[u103][u125] = u126;
                else
                    u4[u103][u125] = u126;
                    v100 = v100 + 1;
                    table.insert(v99, {
                        entityCount = 1,
                        userId = u103,
                        fn = function() --[[ Name: fn, Line 362 ]]
                            -- upvalues: u12 (ref), u27 (ref), u103 (copy), u125 (copy), u126 (copy)
                            for _, v127 in u12 do
                                task.spawn(u27, v127, u103, u125, u126);
                            end;
                        end
                    });
                end;
            end;
        end;
        if v102.Props then
            for u128, u129 in v102.Props do
                if u5[u103][u128] then
                    u5[u103][u128] = u129;
                else
                    u5[u103][u128] = u129;
                    v100 = v100 + 1;
                    table.insert(v99, {
                        entityCount = 1,
                        userId = u103,
                        fn = function() --[[ Name: fn, Line 382 ]]
                            -- upvalues: u21 (ref), u27 (ref), u103 (copy), u128 (copy), u129 (copy)
                            for _, v130 in u21 do
                                task.spawn(u27, v130, u103, u128, u129);
                            end;
                        end
                    });
                end;
            end;
        end;
    end;
    p97:EnqueueSpawnEntries(v99, v100);
end;
function v1.HandlePlantAdded(_, p131, p132, p133) --[[ Line: 401 ]]
    -- upvalues: u2 (copy), u6 (copy), u27 (copy), u14 (copy)
    if not u2[p131] then
        u2[p131] = {};
    end;
    u2[p131][p132] = p133;
    for _, v134 in u6 do
        task.spawn(u27, v134, p131, p132, p133);
    end;
    if p133.Fruits then
        for v135, v136 in p133.Fruits do
            for _, v137 in u14 do
                task.spawn(u27, v137, p131, p132, v135, v136);
            end;
        end;
    end;
end;
function v1.HandlePlantRemoved(_, p138, p139) --[[ Line: 419 ]]
    -- upvalues: u2 (copy), u7 (copy), u27 (copy)
    if u2[p138] then
        u2[p138][p139] = nil;
    end;
    for _, v140 in u7 do
        task.spawn(u27, v140, p138, p139);
    end;
end;
function v1.HandlePlantGrowthUpdated(_, p141, p142, p143, p144) --[[ Line: 428 ]]
    -- upvalues: u2 (copy), u8 (copy), u27 (copy)
    if u2[p141] and u2[p141][p142] then
        u2[p141][p142].Age = p143;
    end;
    for _, v145 in u8 do
        task.spawn(u27, v145, p141, p142, p143, p144);
    end;
end;
function v1.HandlePlantAgeSync(_, p146, p147) --[[ Line: 438 ]]
    -- upvalues: u2 (copy), u9 (copy), u27 (copy)
    if not u2[p146] then
        u2[p146] = {};
    end;
    for v148, v149 in p147 do
        if u2[p146][v148] then
            u2[p146][v148].Age = v149;
        end;
    end;
    for _, v150 in u9 do
        task.spawn(u27, v150, p146, p147);
    end;
end;
function v1.HandleSprinklerAdded(_, p151, p152, p153) --[[ Line: 457 ]]
    -- upvalues: u3 (copy), u10 (copy), u27 (copy)
    if not u3[p151] then
        u3[p151] = {};
    end;
    u3[p151][p152] = p153;
    for _, v154 in u10 do
        task.spawn(u27, v154, p151, p152, p153);
    end;
end;
function v1.HandleSprinklerRemoved(_, p155, p156) --[[ Line: 467 ]]
    -- upvalues: u3 (copy), u11 (copy), u27 (copy)
    if u3[p155] then
        u3[p155][p156] = nil;
    end;
    for _, v157 in u11 do
        task.spawn(u27, v157, p155, p156);
    end;
end;
function v1.HandleRakeAdded(_, p158, p159, p160) --[[ Line: 479 ]]
    -- upvalues: u4 (copy), u12 (copy), u27 (copy)
    if not u4[p158] then
        u4[p158] = {};
    end;
    u4[p158][p159] = p160;
    for _, v161 in u12 do
        task.spawn(u27, v161, p158, p159, p160);
    end;
end;
function v1.HandleRakeRemoved(_, p162, p163) --[[ Line: 489 ]]
    -- upvalues: u4 (copy), u13 (copy), u27 (copy)
    if u4[p162] then
        u4[p162][p163] = nil;
    end;
    for _, v164 in u13 do
        task.spawn(u27, v164, p162, p163);
    end;
end;
function v1.HandlePropAdded(_, p165, p166, p167) --[[ Line: 501 ]]
    -- upvalues: u5 (copy), u21 (copy), u27 (copy)
    if not u5[p165] then
        u5[p165] = {};
    end;
    u5[p165][p166] = p167;
    for _, v168 in u21 do
        task.spawn(u27, v168, p165, p166, p167);
    end;
end;
function v1.HandlePropRemoved(_, p169, p170) --[[ Line: 511 ]]
    -- upvalues: u5 (copy), u22 (copy), u27 (copy)
    if u5[p169] then
        u5[p169][p170] = nil;
    end;
    for _, v171 in u22 do
        task.spawn(u27, v171, p169, p170);
    end;
end;
function v1.HandlePropExtraDataUpdated(_, p172, p173, p174) --[[ Line: 520 ]]
    -- upvalues: u5 (copy), u23 (copy), u27 (copy)
    if u5[p172] and u5[p172][p173] then
        u5[p172][p173].ExtraData = p174;
    end;
    for _, v175 in u23 do
        task.spawn(u27, v175, p172, p173, p174);
    end;
end;
function v1.HandleFruitAdded(_, p176, p177, p178, p179) --[[ Line: 532 ]]
    -- upvalues: u2 (copy), u14 (copy), u27 (copy)
    if not u2[p176] then
        u2[p176] = {};
    end;
    if not u2[p176][p177] then
        u2[p176][p177] = {};
    end;
    if not u2[p176][p177].Fruits then
        u2[p176][p177].Fruits = {};
    end;
    u2[p176][p177].Fruits[p178] = p179;
    for _, v180 in u14 do
        task.spawn(u27, v180, p176, p177, p178, p179);
    end;
end;
function v1.HandleFruitRemoved(_, p181, p182, p183) --[[ Line: 549 ]]
    -- upvalues: u2 (copy), u15 (copy), u27 (copy)
    if u2[p181] and (u2[p181][p182] and u2[p181][p182].Fruits) then
        u2[p181][p182].Fruits[p183] = nil;
    end;
    for _, v184 in u15 do
        task.spawn(u27, v184, p181, p182, p183);
    end;
end;
function v1.HandleFruitGrowthUpdated(_, p185, p186, p187, p188, p189) --[[ Line: 559 ]]
    -- upvalues: u2 (copy), u16 (copy), u27 (copy)
    if u2[p185] and (u2[p185][p186] and (u2[p185][p186].Fruits and u2[p185][p186].Fruits[p187])) then
        u2[p185][p186].Fruits[p187].Age = p188;
        u2[p185][p186].Fruits[p187].GrowRate = p189;
    end;
    for _, v190 in u16 do
        task.spawn(u27, v190, p185, p186, p187, p188, p189);
    end;
end;
function v1.HandleFruitAgeSync(_, p191, p192, p193) --[[ Line: 570 ]]
    -- upvalues: u2 (copy), u17 (copy), u27 (copy)
    if u2[p191] and (u2[p191][p192] and u2[p191][p192].Fruits) then
        for v194, v195 in p193 do
            if u2[p191][p192].Fruits[v194] then
                u2[p191][p192].Fruits[v194].Age = v195;
            end;
        end;
        for _, v196 in u17 do
            task.spawn(u27, v196, p191, p192, p193);
        end;
    end;
end;
function v1.HandleFruitOvertimeGrowthUpdated(_, p197, p198, p199, p200) --[[ Line: 584 ]]
    -- upvalues: u2 (copy), u18 (copy), u27 (copy)
    if u2[p197] and (u2[p197][p198] and (u2[p197][p198].Fruits and u2[p197][p198].Fruits[p199])) then
        u2[p197][p198].Fruits[p199].OvertimeGrowth = p200;
    end;
    for _, v201 in u18 do
        task.spawn(u27, v201, p197, p198, p199, p200);
    end;
end;
function v1.GetGarden(_, p202) --[[ Line: 597 ]]
    -- upvalues: u2 (copy)
    return u2[tonumber(p202) or p202] or {};
end;
function v1.GetPlant(_, p203, p204) --[[ Line: 601 ]]
    -- upvalues: u2 (copy)
    local v205 = tonumber(p203) or p203;
    if u2[v205] then
        return u2[v205][p204];
    else
        return nil;
    end;
end;
function v1.GetAllGardens(_) --[[ Line: 607 ]]
    -- upvalues: u2 (copy)
    return u2;
end;
function v1.GetSprinklers(_, p206) --[[ Line: 611 ]]
    -- upvalues: u3 (copy)
    return u3[tonumber(p206) or p206] or {};
end;
function v1.GetSprinkler(_, p207, p208) --[[ Line: 615 ]]
    -- upvalues: u3 (copy)
    local v209 = tonumber(p207) or p207;
    if u3[v209] then
        return u3[v209][p208];
    else
        return nil;
    end;
end;
function v1.GetAllSprinklers(_) --[[ Line: 621 ]]
    -- upvalues: u3 (copy)
    return u3;
end;
function v1.GetRakes(_, p210) --[[ Line: 625 ]]
    -- upvalues: u4 (copy)
    return u4[tonumber(p210) or p210] or {};
end;
function v1.GetRake(_, p211, p212) --[[ Line: 629 ]]
    -- upvalues: u4 (copy)
    local v213 = tonumber(p211) or p211;
    if u4[v213] then
        return u4[v213][p212];
    else
        return nil;
    end;
end;
function v1.GetAllRakes(_) --[[ Line: 635 ]]
    -- upvalues: u4 (copy)
    return u4;
end;
function v1.GetProps(_, p214) --[[ Line: 639 ]]
    -- upvalues: u5 (copy)
    return u5[tonumber(p214) or p214] or {};
end;
function v1.GetProp(_, p215, p216) --[[ Line: 643 ]]
    -- upvalues: u5 (copy)
    local v217 = tonumber(p215) or p215;
    if u5[v217] then
        return u5[v217][p216];
    else
        return nil;
    end;
end;
function v1.GetAllProps(_) --[[ Line: 649 ]]
    -- upvalues: u5 (copy)
    return u5;
end;
function v1.OnPlantAdded(_, u218) --[[ Line: 656 ]]
    -- upvalues: u6 (copy)
    table.insert(u6, u218);
    return function() --[[ Line: 658 ]]
        -- upvalues: u6 (ref), u218 (copy)
        local v219 = table.find(u6, u218);
        if v219 then
            table.remove(u6, v219);
        end;
    end;
end;
function v1.OnPlantVisualCheck(_, u220) --[[ Line: 666 ]]
    -- upvalues: u19 (copy)
    table.insert(u19, u220);
    return function() --[[ Line: 668 ]]
        -- upvalues: u19 (ref), u220 (copy)
        local v221 = table.find(u19, u220);
        if v221 then
            table.remove(u19, v221);
        end;
    end;
end;
function v1.OnFruitVisualCheck(_, u222) --[[ Line: 679 ]]
    -- upvalues: u20 (copy)
    table.insert(u20, u222);
    return function() --[[ Line: 681 ]]
        -- upvalues: u20 (ref), u222 (copy)
        local v223 = table.find(u20, u222);
        if v223 then
            table.remove(u20, v223);
        end;
    end;
end;
function v1.ReconcileLocalGarden(_) --[[ Line: 694 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u2 (copy), u19 (copy), u27 (copy), u20 (copy)
    local l__UserId__7 = l__LocalPlayer__4.UserId;
    local v224 = u2[l__UserId__7];
    if not v224 then
        return 0;
    end;
    local v225 = 0;
    for v226, v227 in v224 do
        v225 = v225 + 1;
        for _, v228 in u19 do
            task.spawn(u27, v228, l__UserId__7, v226, v227);
        end;
        if v227.Fruits then
            for v229, v230 in v227.Fruits do
                for _, v231 in u20 do
                    task.spawn(u27, v231, l__UserId__7, v226, v229, v230);
                end;
            end;
        end;
    end;
    return v225;
end;
function v1.OnPlantRemoved(_, u232) --[[ Line: 716 ]]
    -- upvalues: u7 (copy)
    table.insert(u7, u232);
    return function() --[[ Line: 718 ]]
        -- upvalues: u7 (ref), u232 (copy)
        local v233 = table.find(u7, u232);
        if v233 then
            table.remove(u7, v233);
        end;
    end;
end;
function v1.OnPlantGrowthUpdated(_, u234) --[[ Line: 726 ]]
    -- upvalues: u8 (copy)
    table.insert(u8, u234);
    return function() --[[ Line: 728 ]]
        -- upvalues: u8 (ref), u234 (copy)
        local v235 = table.find(u8, u234);
        if v235 then
            table.remove(u8, v235);
        end;
    end;
end;
function v1.OnPlantAgeSync(_, u236) --[[ Line: 736 ]]
    -- upvalues: u9 (copy)
    table.insert(u9, u236);
    return function() --[[ Line: 738 ]]
        -- upvalues: u9 (ref), u236 (copy)
        local v237 = table.find(u9, u236);
        if v237 then
            table.remove(u9, v237);
        end;
    end;
end;
function v1.OnSprinklerAdded(_, u238) --[[ Line: 746 ]]
    -- upvalues: u10 (copy)
    table.insert(u10, u238);
    return function() --[[ Line: 748 ]]
        -- upvalues: u10 (ref), u238 (copy)
        local v239 = table.find(u10, u238);
        if v239 then
            table.remove(u10, v239);
        end;
    end;
end;
function v1.OnSprinklerRemoved(_, u240) --[[ Line: 756 ]]
    -- upvalues: u11 (copy)
    table.insert(u11, u240);
    return function() --[[ Line: 758 ]]
        -- upvalues: u11 (ref), u240 (copy)
        local v241 = table.find(u11, u240);
        if v241 then
            table.remove(u11, v241);
        end;
    end;
end;
function v1.OnRakeAdded(_, u242) --[[ Line: 766 ]]
    -- upvalues: u12 (copy)
    table.insert(u12, u242);
    return function() --[[ Line: 768 ]]
        -- upvalues: u12 (ref), u242 (copy)
        local v243 = table.find(u12, u242);
        if v243 then
            table.remove(u12, v243);
        end;
    end;
end;
function v1.OnRakeRemoved(_, u244) --[[ Line: 776 ]]
    -- upvalues: u13 (copy)
    table.insert(u13, u244);
    return function() --[[ Line: 778 ]]
        -- upvalues: u13 (ref), u244 (copy)
        local v245 = table.find(u13, u244);
        if v245 then
            table.remove(u13, v245);
        end;
    end;
end;
function v1.OnPropAdded(_, u246) --[[ Line: 786 ]]
    -- upvalues: u21 (copy)
    table.insert(u21, u246);
    return function() --[[ Line: 788 ]]
        -- upvalues: u21 (ref), u246 (copy)
        local v247 = table.find(u21, u246);
        if v247 then
            table.remove(u21, v247);
        end;
    end;
end;
function v1.OnPropRemoved(_, u248) --[[ Line: 796 ]]
    -- upvalues: u22 (copy)
    table.insert(u22, u248);
    return function() --[[ Line: 798 ]]
        -- upvalues: u22 (ref), u248 (copy)
        local v249 = table.find(u22, u248);
        if v249 then
            table.remove(u22, v249);
        end;
    end;
end;
function v1.OnPropExtraDataUpdated(_, u250) --[[ Line: 806 ]]
    -- upvalues: u23 (copy)
    table.insert(u23, u250);
    return function() --[[ Line: 808 ]]
        -- upvalues: u23 (ref), u250 (copy)
        local v251 = table.find(u23, u250);
        if v251 then
            table.remove(u23, v251);
        end;
    end;
end;
function v1.OnFruitAdded(_, u252) --[[ Line: 816 ]]
    -- upvalues: u14 (copy)
    table.insert(u14, u252);
    return function() --[[ Line: 818 ]]
        -- upvalues: u14 (ref), u252 (copy)
        local v253 = table.find(u14, u252);
        if v253 then
            table.remove(u14, v253);
        end;
    end;
end;
function v1.OnFruitRemoved(_, u254) --[[ Line: 826 ]]
    -- upvalues: u15 (copy)
    table.insert(u15, u254);
    return function() --[[ Line: 828 ]]
        -- upvalues: u15 (ref), u254 (copy)
        local v255 = table.find(u15, u254);
        if v255 then
            table.remove(u15, v255);
        end;
    end;
end;
function v1.OnFruitGrowthUpdated(_, u256) --[[ Line: 836 ]]
    -- upvalues: u16 (copy)
    table.insert(u16, u256);
    return function() --[[ Line: 838 ]]
        -- upvalues: u16 (ref), u256 (copy)
        local v257 = table.find(u16, u256);
        if v257 then
            table.remove(u16, v257);
        end;
    end;
end;
function v1.OnFruitAgeSync(_, u258) --[[ Line: 846 ]]
    -- upvalues: u17 (copy)
    table.insert(u17, u258);
    return function() --[[ Line: 848 ]]
        -- upvalues: u17 (ref), u258 (copy)
        local v259 = table.find(u17, u258);
        if v259 then
            table.remove(u17, v259);
        end;
    end;
end;
function v1.OnFruitOvertimeGrowthUpdated(_, u260) --[[ Line: 856 ]]
    -- upvalues: u18 (copy)
    table.insert(u18, u260);
    return function() --[[ Line: 858 ]]
        -- upvalues: u18 (ref), u260 (copy)
        local v261 = table.find(u18, u260);
        if v261 then
            table.remove(u18, v261);
        end;
    end;
end;
function v1.CleanupPlayerGarden(p262, p263) --[[ Line: 869 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy), u5 (copy)
    local v264 = tonumber(p263) or p263;
    if u2[v264] then
        for v265 in u2[v264] do
            p262:HandlePlantRemoved(v264, v265);
        end;
        u2[v264] = nil;
    end;
    if u3[v264] then
        for v266 in u3[v264] do
            p262:HandleSprinklerRemoved(v264, v266);
        end;
        u3[v264] = nil;
    end;
    if u4[v264] then
        for v267 in u4[v264] do
            p262:HandleRakeRemoved(v264, v267);
        end;
        u4[v264] = nil;
    end;
    if u5[v264] then
        for v268 in u5[v264] do
            p262:HandlePropRemoved(v264, v268);
        end;
        u5[v264] = nil;
    end;
end;
return v1;