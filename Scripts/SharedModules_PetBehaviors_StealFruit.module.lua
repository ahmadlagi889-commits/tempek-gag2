-- Decompiled with Potassium's decompiler.

local l__BehaviorBase__1 = require(script.Parent.BehaviorBase);
local l__Players__2 = game:GetService("Players");
local l__HttpService__3 = game:GetService("HttpService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__Services__5 = game:GetService("ServerScriptService"):WaitForChild("Services");
local l__DataService__6 = require(l__Services__5.DataService);
local l__ShovelService__7 = require(l__Services__5.ShovelService);
local l__ObjectPositionService__8 = require(l__Services__5.ObjectPositionService);
local l__FruitHarvestService__9 = require(l__Services__5.FruitHarvestService);
local l__GardenZoneService__10 = require(l__Services__5.GardenZoneService);
local l__BadgesService__11 = require(l__Services__5.BadgesService);
local l__Fruits__12 = l__ReplicatedStorage__4:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits");
local l__PetData__13 = require(l__ReplicatedStorage__4.SharedData.PetData);
local l__RarityVisuals__14 = require(l__ReplicatedStorage__4.SharedModules.RarityVisuals);
local u1 = {};
for _, v2 in require(l__ReplicatedStorage__4.SharedModules.SeedData) do
    if type(v2) == "table" and type(v2.SeedName) == "string" then
        u1[v2.SeedName] = v2.Rarity or "Common";
    end;
end;
local u3 = setmetatable({}, {
    __index = l__BehaviorBase__1
});
u3.__index = u3;
u3.Name = "StealFruit";
local u4 = nil;
local u5 = nil;
local function u7(p6) --[[ Line: 127 ]]
    p6:SetSlotAttribute("CarryingFruit", nil);
    p6:SetSlotAttribute("CarryingFruitSeed", nil);
    p6:SetSlotAttribute("CarryingFruitSize", nil);
    p6:SetSlotAttribute("CarryingFruitOvertimeGrowth", nil);
    p6:SetSlotAttribute("CarryingFruitMutation", nil);
end;
local function u20(p8) --[[ Line: 136 ]]
    -- upvalues: l__ReplicatedStorage__4 (copy), l__Players__2 (copy), l__GardenZoneService__10 (copy), u4 (ref), l__Services__5 (copy), l__DataService__6 (copy)
    local v9 = l__ReplicatedStorage__4:FindFirstChild("Night");
    local v10;
    if v9 and v9:IsA("BoolValue") then
        v10 = v9.Value == true;
    else
        v10 = false;
    end;
    if v10 then
        local v11 = {};
        for _, v12 in pairs(l__Players__2:GetPlayers()) do
            if v12 ~= p8 and v12:HasTag("DataLoaded") then
                local v13 = v12:GetAttribute("PlotId");
                local v14;
                if type(v13) == "number" then
                    v14 = #l__GardenZoneService__10:GetPlayersInGarden(v13) == 0;
                else
                    v14 = false;
                end;
                if v14 then
                    if not u4 then
                        u4 = require(l__Services__5.PetBehaviorService);
                    end;
                    if not u4:IsVictimOnCooldown(p8.UserId, v12.UserId) then
                        local v15 = l__DataService__6:GetAllPlants(v12);
                        if v15 then
                            for v16, v17 in pairs(v15) do
                                if not v17.IsPotted then
                                    local l__Fruits__15 = v17.Fruits;
                                    if l__Fruits__15 then
                                        for v18, v19 in pairs(l__Fruits__15) do
                                            if type(v19) == "table" and (v19.Age and (v19.MaxAge and v19.Age >= v19.MaxAge)) then
                                                table.insert(v11, {
                                                    VictimPlayer = v12,
                                                    PlantId = v16,
                                                    PlantData = v17,
                                                    FruitId = v18,
                                                    FruitData = v19
                                                });
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        if #v11 == 0 then
            return nil;
        else
            return v11[math.random(1, #v11)];
        end;
    else
        return nil;
    end;
end;
local function u24(p21, p22) --[[ Line: 215 ]]
    if p22 then
        p22 = p22.Scarer;
    end;
    local v23 = p21.Species or "Pet";
    local l__Player__16 = p21.Player;
    if p22 and p22.Parent then
        p21.Control:NotifyPlayer(p22, "You shooed away " .. (l__Player__16 and (l__Player__16.Name or "a player") or "a player") .. "\'s " .. v23 .. "!");
    end;
    if l__Player__16 and (l__Player__16.Parent and p22 ~= l__Player__16) then
        p21.Control:Notify((p22 and p22.Name or "Someone") .. " shooed away your " .. v23 .. "!");
    end;
end;
local function u103() --[[ Line: 229 ]]
    -- upvalues: u20 (copy), l__ObjectPositionService__8 (copy), l__DataService__6 (copy), u24 (copy), l__Fruits__12 (copy), l__HttpService__3 (copy), l__ShovelService__7 (copy), u7 (copy), l__BadgesService__11 (copy), l__FruitHarvestService__9 (copy), l__RarityVisuals__14 (copy), l__PetData__13 (copy), u1 (copy), u4 (ref), l__Services__5 (copy)
    return {
        Targeting = {
            Enter = function(p25) --[[ Name: Enter, Line 235 ]]
                -- upvalues: u20 (ref), l__ObjectPositionService__8 (ref)
                local v26 = u20(p25.Player);
                if v26 then
                    p25.VictimPlayer = v26.VictimPlayer;
                    p25.VictimUserId = v26.VictimPlayer.UserId;
                    p25.PlantId = v26.PlantId;
                    p25.FruitId = v26.FruitId;
                    p25.FruitName = v26.PlantData.PlantName;
                    p25.FruitData = v26.FruitData;
                    local v27 = l__ObjectPositionService__8:GetStoredFruitEntry(v26.VictimPlayer, v26.FruitId);
                    local v28;
                    if v27 and typeof(v27.Position) == "Vector3" then
                        v28 = v27.Position;
                    else
                        v28 = nil;
                    end;
                    p25.FruitWorldPos = v28;
                    if p25.FruitWorldPos then
                        p25:TransitionTo("Outbound");
                    else
                        p25:Stop("NoFruitPosition");
                    end;
                else
                    p25:Stop("NoTarget");
                end;
            end
        },
        Outbound = {
            Enter = function(p29) --[[ Name: Enter, Line 261 ]]
                local l__FruitWorldPos__17 = p29.FruitWorldPos;
                local l__TravelSpeed__18 = p29.TravelSpeed;
                local v30 = p29.Control:GetSlotPosition();
                if v30 then
                    local v31 = Vector3.new(l__FruitWorldPos__17.X - v30.X, 0, l__FruitWorldPos__17.Z - v30.Z);
                    local v32;
                    if v31.Magnitude < 0.001 then
                        v32 = CFrame.new(l__FruitWorldPos__17);
                    else
                        v32 = CFrame.lookAt(l__FruitWorldPos__17, l__FruitWorldPos__17 + v31.Unit);
                    end;
                    p29.Control:SetGoal(v32, l__TravelSpeed__18);
                end;
            end,
            Update = function(p33, _, _) --[[ Name: Update, Line 265 ]]
                -- upvalues: l__DataService__6 (ref)
                local l__VictimPlayer__19 = p33.VictimPlayer;
                local l__PlantId__20 = p33.PlantId;
                local l__FruitId__21 = p33.FruitId;
                local v34;
                if l__VictimPlayer__19 and l__VictimPlayer__19.Parent then
                    local v35 = l__DataService__6:GetFruit(l__VictimPlayer__19, l__PlantId__20, l__FruitId__21);
                    if v35 and (v35.Age and v35.MaxAge) then
                        v34 = v35.Age >= v35.MaxAge;
                    else
                        v34 = false;
                    end;
                else
                    v34 = false;
                end;
                if v34 then
                    local l__FruitWorldPos__22 = p33.FruitWorldPos;
                    local l__TravelSpeed__23 = p33.TravelSpeed;
                    local v36 = p33.Control:GetSlotPosition();
                    if v36 then
                        local v37 = Vector3.new(l__FruitWorldPos__22.X - v36.X, 0, l__FruitWorldPos__22.Z - v36.Z);
                        local v38;
                        if v37.Magnitude < 0.001 then
                            v38 = CFrame.new(l__FruitWorldPos__22);
                        else
                            v38 = CFrame.lookAt(l__FruitWorldPos__22, l__FruitWorldPos__22 + v37.Unit);
                        end;
                        p33.Control:SetGoal(v38, l__TravelSpeed__23);
                    end;
                    local l__FruitWorldPos__24 = p33.FruitWorldPos;
                    local v39 = p33.Control:GetSlotPosition();
                    local v40;
                    if v39 then
                        local v41 = l__FruitWorldPos__24.X - v39.X;
                        local v42 = l__FruitWorldPos__24.Z - v39.Z;
                        v40 = math.sqrt(v41 * v41 + v42 * v42);
                    else
                        v40 = (1 / 0);
                    end;
                    if v40 <= 3 then
                        p33:TransitionTo("Stealing");
                    elseif p33:TimeInState() >= p33.LegTimeout then
                        p33:TransitionTo("Aborting");
                    end;
                else
                    p33:TransitionTo("Aborting");
                end;
            end,
            OnEvent = function(p43, p44, p45) --[[ Name: OnEvent, Line 288 ]]
                -- upvalues: u24 (ref)
                if p44 == "Scared" then
                    u24(p43, p45);
                    p43:TransitionTo("Aborting");
                end;
            end
        },
        Stealing = {
            Enter = function(p46) --[[ Name: Enter, Line 298 ]]
                local v47 = p46.Control:GetSlotPosition();
                if v47 then
                    local v48 = p46.Control:GetSlotPosition();
                    if not v48 then
                        return;
                    end;
                    local v49 = Vector3.new(v47.X - v48.X, 0, v47.Z - v48.Z);
                    local v50;
                    if v49.Magnitude < 0.001 then
                        v50 = CFrame.new(v47);
                    else
                        v50 = CFrame.lookAt(v47, v47 + v49.Unit);
                    end;
                    p46.Control:SetGoal(v50, 0);
                end;
            end,
            Update = function(p51, _, _) --[[ Name: Update, Line 306 ]]
                -- upvalues: l__DataService__6 (ref), l__Fruits__12 (ref), l__HttpService__3 (ref), l__ShovelService__7 (ref)
                if p51.VictimPlayer and p51.VictimPlayer.Parent then
                    if p51:TimeInState() < p51.StealDuration then
                    elseif p51.StealCommitInFlight then
                    else
                        p51.StealCommitInFlight = true;
                        local v52 = l__DataService__6:GetFruit(p51.VictimPlayer, p51.PlantId, p51.FruitId);
                        if v52 then
                            if v52.Age and (v52.MaxAge and v52.Age >= v52.MaxAge) then
                                local v53 = l__Fruits__12:FindFirstChild(p51.FruitName);
                                local v54;
                                if v53 then
                                    local v55, v56 = pcall(require, v53);
                                    v54 = v55 and (v56 and v56.GrowData) and (v56.GrowData.BaseWeight or 1) or 1;
                                else
                                    v54 = 1;
                                end;
                                local v57 = v52.SizeMultiplier or 1;
                                local v58 = v52.OvertimeGrowth or 1;
                                local v59 = v54 * v57 * math.max(v58, 1);
                                local v60 = {};
                                local v61;
                                if type(p51.FruitId) == "string" and p51.FruitId ~= "" then
                                    v61 = p51.FruitId;
                                else
                                    v61 = l__HttpService__3:GenerateGUID(false);
                                end;
                                v60.Id = v61;
                                v60.Seed = v52.Seed;
                                v60.Weight = v59;
                                v60.FruitName = p51.FruitName;
                                v60.SizeMultiplier = v57;
                                v60.OvertimeGrowth = v58;
                                v60.Mutation = v52.Mutation;
                                p51.HarvestedPayload = v60;
                                l__ShovelService__7:RemoveFruit(p51.VictimPlayer, p51.PlantId, p51.FruitId);
                                p51.Control:SetSlotAttribute("CarryingFruitSeed", v52.Seed or 0);
                                p51.Control:SetSlotAttribute("CarryingFruitSize", v57);
                                p51.Control:SetSlotAttribute("CarryingFruitOvertimeGrowth", v58);
                                p51.Control:SetSlotAttribute("CarryingFruitMutation", v52.Mutation or "");
                                p51.Control:SetSlotAttribute("CarryingFruit", p51.FruitName);
                                p51:TransitionTo("Returning");
                            else
                                p51:TransitionTo("Aborting");
                            end;
                        else
                            p51:TransitionTo("Aborting");
                        end;
                    end;
                else
                    p51:TransitionTo("Aborting");
                end;
            end,
            OnEvent = function(p62, p63, p64) --[[ Name: OnEvent, Line 361 ]]
                -- upvalues: u24 (ref)
                if p63 == "Scared" then
                    u24(p62, p64);
                    p62:TransitionTo("Aborting");
                end;
            end
        },
        Returning = {
            Enter = function(p65) --[[ Name: Enter, Line 371 ]]
                local v66 = p65.Player:GetAttribute("PlotId");
                local v67;
                if type(v66) == "number" then
                    local v68 = workspace:FindFirstChild("Gardens");
                    if v68 then
                        v67 = v68:FindFirstChild("Plot" .. tostring(v66));
                    else
                        v67 = nil;
                    end;
                else
                    v67 = nil;
                end;
                if v67 then
                    local v69 = v67:FindFirstChild("SpawnPoint");
                    p65.HomePos = v69 and v69.Position or v67:GetPivot().Position;
                    local l__HomePos__25 = p65.HomePos;
                    local l__TravelSpeed__26 = p65.TravelSpeed;
                    local v70 = p65.Control:GetSlotPosition();
                    if v70 then
                        local v71 = Vector3.new(l__HomePos__25.X - v70.X, 0, l__HomePos__25.Z - v70.Z);
                        local v72;
                        if v71.Magnitude < 0.001 then
                            v72 = CFrame.new(l__HomePos__25);
                        else
                            v72 = CFrame.lookAt(l__HomePos__25, l__HomePos__25 + v71.Unit);
                        end;
                        p65.Control:SetGoal(v72, l__TravelSpeed__26);
                    end;
                else
                    p65:TransitionTo("Aborting");
                end;
            end,
            Update = function(p73, _, _) --[[ Name: Update, Line 382 ]]
                local l__HomePos__27 = p73.HomePos;
                local l__TravelSpeed__28 = p73.TravelSpeed;
                local v74 = p73.Control:GetSlotPosition();
                if v74 then
                    local v75 = Vector3.new(l__HomePos__27.X - v74.X, 0, l__HomePos__27.Z - v74.Z);
                    local v76;
                    if v75.Magnitude < 0.001 then
                        v76 = CFrame.new(l__HomePos__27);
                    else
                        v76 = CFrame.lookAt(l__HomePos__27, l__HomePos__27 + v75.Unit);
                    end;
                    p73.Control:SetGoal(v76, l__TravelSpeed__28);
                end;
                local l__HomePos__29 = p73.HomePos;
                local v77 = p73.Control:GetSlotPosition();
                local v78;
                if v77 then
                    local v79 = l__HomePos__29.X - v77.X;
                    local v80 = l__HomePos__29.Z - v77.Z;
                    v78 = math.sqrt(v79 * v79 + v80 * v80);
                else
                    v78 = (1 / 0);
                end;
                if v78 <= p73.DeliveryRadius then
                    p73:TransitionTo("Delivering");
                elseif p73:TimeInState() >= p73.LegTimeout * 2 then
                    p73:TransitionTo("Aborting");
                end;
            end,
            OnEvent = function(p81, p82, p83) --[[ Name: OnEvent, Line 396 ]]
                -- upvalues: u7 (ref), u24 (ref)
                if p82 == "Scared" then
                    p81.HarvestedPayload = nil;
                    u7(p81.Control);
                    u24(p81, p83);
                    p81:TransitionTo("Aborting");
                end;
            end
        },
        Delivering = {
            Enter = function(p84) --[[ Name: Enter, Line 409 ]]
                -- upvalues: l__DataService__6 (ref), l__BadgesService__11 (ref), l__FruitHarvestService__9 (ref), l__RarityVisuals__14 (ref), l__PetData__13 (ref), u1 (ref), u7 (ref)
                if p84.HarvestedPayload and (p84.Player and p84.Player.Parent) then
                    l__DataService__6:AddHarvestedFruit(p84.Player, p84.HarvestedPayload);
                    l__BadgesService__11:OnFruitHarvested(p84.Player, p84.HarvestedPayload);
                    l__FruitHarvestService__9:refreshPlayerFruitTools(p84.Player, l__DataService__6:GetAllHarvestedFruits(p84.Player));
                    local v85 = p84.VictimPlayer and (p84.VictimPlayer.Name or "someone") or "someone";
                    local l__Slot__30 = p84.Slot;
                    if l__Slot__30 then
                        l__Slot__30 = p84.Slot:GetAttribute("PetSize");
                    end;
                    local l__RichText__31 = l__RarityVisuals__14.RichText;
                    local v86 = l__PetData__13.GetDisplayName(p84.Species, l__Slot__30);
                    local v87 = l__PetData__13[p84.Species];
                    local v88 = l__RichText__31(v86, (type(v87) ~= "table" or type(v87.Rarity) ~= "string") and "Common" or v87.Rarity);
                    local v89 = l__RarityVisuals__14.RichText(tostring(p84.FruitName), u1[p84.FruitName] or "Common");
                    p84.Control:Notify((`Your {v88} stole a {v89} from {v85}!`));
                end;
                u7(p84.Control);
                p84:Stop("Delivered");
            end
        },
        Aborting = {
            Enter = function(p90) --[[ Name: Enter, Line 429 ]]
                -- upvalues: u7 (ref), u4 (ref), l__Services__5 (ref)
                p90.HarvestedPayload = nil;
                u7(p90.Control);
                if p90.VictimUserId then
                    if not u4 then
                        u4 = require(l__Services__5.PetBehaviorService);
                    end;
                    u4:SetVictimCooldown(p90.Player.UserId, p90.VictimUserId, p90.VictimCooldown);
                end;
                local v91 = p90.Player:GetAttribute("PlotId");
                local v92;
                if type(v91) == "number" then
                    local v93 = workspace:FindFirstChild("Gardens");
                    if v93 then
                        v92 = v93:FindFirstChild("Plot" .. tostring(v91));
                    else
                        v92 = nil;
                    end;
                else
                    v92 = nil;
                end;
                local v94;
                if v92 then
                    v94 = v92:FindFirstChild("SpawnPoint");
                else
                    v94 = v92;
                end;
                p90.HomePos = v94 and v94.Position or (v92 and v92:GetPivot().Position or nil);
                if p90.HomePos then
                    local l__HomePos__32 = p90.HomePos;
                    local l__TravelSpeed__33 = p90.TravelSpeed;
                    local v95 = p90.Control:GetSlotPosition();
                    if not v95 then
                        return;
                    end;
                    local v96 = Vector3.new(l__HomePos__32.X - v95.X, 0, l__HomePos__32.Z - v95.Z);
                    local v97;
                    if v96.Magnitude < 0.001 then
                        v97 = CFrame.new(l__HomePos__32);
                    else
                        v97 = CFrame.lookAt(l__HomePos__32, l__HomePos__32 + v96.Unit);
                    end;
                    p90.Control:SetGoal(v97, l__TravelSpeed__33);
                end;
            end,
            Update = function(p98, _, _) --[[ Name: Update, Line 447 ]]
                if p98.HomePos then
                    local l__HomePos__34 = p98.HomePos;
                    local v99 = p98.Control:GetSlotPosition();
                    local v100;
                    if v99 then
                        local v101 = l__HomePos__34.X - v99.X;
                        local v102 = l__HomePos__34.Z - v99.Z;
                        v100 = math.sqrt(v101 * v101 + v102 * v102);
                    else
                        v100 = (1 / 0);
                    end;
                    if v100 <= 50 then
                        p98:Stop("Aborted");
                    elseif p98:TimeInState() >= p98.LegTimeout then
                        p98:Stop("Aborted");
                    end;
                else
                    p98:Stop("Aborted");
                end;
            end
        }
    };
end;
function u3.new(p104) --[[ Line: 469 ]]
    -- upvalues: l__BehaviorBase__1 (copy), u3 (copy), u103 (copy)
    local v105 = l__BehaviorBase__1.New(u3, p104);
    v105.TravelSpeed = v105.Config.TravelSpeed or 24;
    v105.LegTimeout = v105.Config.LegTimeout or 20;
    v105.StealDuration = v105.Config.StealDuration or 1;
    v105.DeliveryRadius = v105.Config.DeliveryRadius or 8;
    v105.VictimCooldown = v105.Config.VictimCooldown or 120;
    v105.VictimPlayer = nil;
    v105.VictimUserId = nil;
    v105.PlantId = nil;
    v105.FruitId = nil;
    v105.FruitName = nil;
    v105.FruitData = nil;
    v105.FruitWorldPos = nil;
    v105.HarvestedPayload = nil;
    v105.HomePos = nil;
    v105.States = u103();
    return v105;
end;
function u3.GetInitialState(_) --[[ Line: 501 ]]
    return "Targeting";
end;
function u3.CanStart(p106) --[[ Line: 506 ]]
    -- upvalues: l__ReplicatedStorage__4 (copy), u20 (copy)
    local l__Player__35 = p106.Player;
    if l__Player__35 and l__Player__35.Parent then
        local v107 = l__ReplicatedStorage__4:FindFirstChild("Night");
        local v108;
        if v107 and v107:IsA("BoolValue") then
            v108 = v107.Value == true;
        else
            v108 = false;
        end;
        if v108 then
            return u20(l__Player__35) ~= nil;
        else
            return false;
        end;
    else
        return false;
    end;
end;
function u3.OnStop(p109, _) --[[ Line: 516 ]]
    -- upvalues: u7 (copy), u5 (ref), l__Services__5 (copy)
    if p109.Control then
        u7(p109.Control);
    end;
    local l__Player__36 = p109.Player;
    local l__PetId__37 = p109.PetId;
    task.defer(function() --[[ Line: 528 ]]
        -- upvalues: l__Player__36 (copy), u5 (ref), l__Services__5 (ref), l__PetId__37 (copy)
        if l__Player__36 and l__Player__36.Parent then
            if not u5 then
                local v110, v111 = pcall(require, l__Services__5:FindFirstChild("WanderService"));
                if v110 then
                    u5 = v111;
                end;
            end;
            local v112 = u5;
            if v112 and v112.OnPetReleased then
                v112:OnPetReleased(l__Player__36, l__PetId__37);
            end;
        end;
    end);
end;
return u3;