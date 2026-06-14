-- Decompiled with Potassium's decompiler.

local l__BehaviorBase__1 = require(script.Parent.BehaviorBase);
local l__ServerScriptService__2 = game:GetService("ServerScriptService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Services__4 = l__ServerScriptService__2:WaitForChild("Services");
local l__DataService__5 = require(l__Services__4.DataService);
local l__ObjectPositionService__6 = require(l__Services__4.ObjectPositionService);
local l__PetData__7 = require(l__ReplicatedStorage__3.SharedData.PetData);
local l__PetSizes__8 = require(l__ReplicatedStorage__3.SharedData.PetSizes);
local l__PetTypes__9 = require(l__ReplicatedStorage__3.SharedData.PetTypes);
local l__RarityVisuals__10 = require(l__ReplicatedStorage__3.SharedModules.RarityVisuals);
local u1 = {};
for _, v2 in require(l__ReplicatedStorage__3.SharedModules.SeedData) do
    if type(v2) == "table" and type(v2.SeedName) == "string" then
        u1[v2.SeedName] = v2.Rarity or "Common";
    end;
end;
local u3 = nil;
local u4 = {
    Big = 1.3,
    Huge = 1.6
};
local u5 = setmetatable({}, {
    __index = l__BehaviorBase__1
});
u5.__index = u5;
u5.Name = "PickFruit";
local function u14(p6) --[[ Line: 83 ]]
    -- upvalues: l__DataService__5 (copy), u3 (ref), l__Services__4 (copy)
    local v7 = l__DataService__5:GetAllPlants(p6);
    if v7 then
        if not u3 then
            u3 = require(l__Services__4:WaitForChild("MonkeyService"));
        end;
        local v8 = u3;
        local v9 = {};
        for v10, v11 in pairs(v7) do
            if not v11.IsPotted then
                local l__Fruits__11 = v11.Fruits;
                if l__Fruits__11 then
                    for v12, v13 in pairs(l__Fruits__11) do
                        if type(v13) == "table" and (v13.Age and (v13.MaxAge and (v13.Age >= v13.MaxAge and not v8:IsFruitReserved(p6, v10, v12)))) then
                            table.insert(v9, {
                                PlantId = v10,
                                FruitId = v12,
                                PlantData = v11,
                                FruitData = v13
                            });
                        end;
                    end;
                end;
            end;
        end;
        if #v9 == 0 then
            return nil;
        else
            return v9[math.random(1, #v9)];
        end;
    else
        return nil;
    end;
end;
local function u16(p15) --[[ Line: 171 ]]
    p15:SetSlotAttribute("CarryingFruit", nil);
    p15:SetSlotAttribute("CarryingFruitSeed", nil);
    p15:SetSlotAttribute("CarryingFruitSize", nil);
    p15:SetSlotAttribute("CarryingFruitOvertimeGrowth", nil);
    p15:SetSlotAttribute("CarryingFruitMutation", nil);
end;
local function u67() --[[ Line: 179 ]]
    -- upvalues: u14 (copy), u3 (ref), l__Services__4 (copy), l__ObjectPositionService__6 (copy), l__DataService__5 (copy), u16 (copy), l__RarityVisuals__10 (copy), l__PetData__7 (copy), u1 (copy)
    return {
        Targeting = {
            Enter = function(p17) --[[ Name: Enter, Line 184 ]]
                -- upvalues: u14 (ref), u3 (ref), l__Services__4 (ref), l__ObjectPositionService__6 (ref)
                local v18 = u14(p17.Player);
                if v18 then
                    if not u3 then
                        u3 = require(l__Services__4:WaitForChild("MonkeyService"));
                    end;
                    if u3:TryReserve(p17.Player, v18.PlantId, v18.FruitId) then
                        p17.PlantId = v18.PlantId;
                        p17.FruitId = v18.FruitId;
                        p17.FruitName = v18.PlantData.PlantName;
                        p17.Reserved = true;
                        local v19 = l__ObjectPositionService__6:GetStoredFruitEntry(p17.Player, v18.FruitId);
                        if v19 then
                            v19 = v19.Position;
                        end;
                        if typeof(v19) == "Vector3" then
                            p17.FruitWorldPos = v19;
                            p17:TransitionTo("Outbound");
                        else
                            p17:Stop("NoFruitPosition");
                        end;
                    else
                        p17:Stop("Reserved");
                    end;
                else
                    p17:Stop("NoFruit");
                end;
            end
        },
        Outbound = {
            Enter = function(p20) --[[ Name: Enter, Line 215 ]]
                local l__FruitWorldPos__12 = p20.FruitWorldPos;
                local l__TravelSpeed__13 = p20.TravelSpeed;
                local v21 = p20.Control:GetSlotPosition();
                if v21 then
                    local l__Control__14 = p20.Control;
                    local v22 = Vector3.new(l__FruitWorldPos__12.X - v21.X, 0, l__FruitWorldPos__12.Z - v21.Z);
                    local v23;
                    if v22.Magnitude < 0.001 then
                        v23 = CFrame.new(l__FruitWorldPos__12);
                    else
                        v23 = CFrame.lookAt(l__FruitWorldPos__12, l__FruitWorldPos__12 + v22.Unit);
                    end;
                    l__Control__14:SetGoal(v23, l__TravelSpeed__13);
                end;
            end,
            Update = function(p24, _, _) --[[ Name: Update, Line 219 ]]
                -- upvalues: l__DataService__5 (ref)
                local l__Player__15 = p24.Player;
                local l__PlantId__16 = p24.PlantId;
                local l__FruitId__17 = p24.FruitId;
                local v25;
                if l__Player__15 and l__Player__15.Parent then
                    local v26 = l__DataService__5:GetFruit(l__Player__15, l__PlantId__16, l__FruitId__17);
                    if v26 and (v26.Age and v26.MaxAge) then
                        v25 = v26.Age >= v26.MaxAge;
                    else
                        v25 = false;
                    end;
                else
                    v25 = false;
                end;
                if v25 then
                    local l__FruitWorldPos__18 = p24.FruitWorldPos;
                    local l__TravelSpeed__19 = p24.TravelSpeed;
                    local v27 = p24.Control:GetSlotPosition();
                    if v27 then
                        local l__Control__20 = p24.Control;
                        local v28 = Vector3.new(l__FruitWorldPos__18.X - v27.X, 0, l__FruitWorldPos__18.Z - v27.Z);
                        local v29;
                        if v28.Magnitude < 0.001 then
                            v29 = CFrame.new(l__FruitWorldPos__18);
                        else
                            v29 = CFrame.lookAt(l__FruitWorldPos__18, l__FruitWorldPos__18 + v28.Unit);
                        end;
                        l__Control__20:SetGoal(v29, l__TravelSpeed__19);
                    end;
                    local l__FruitWorldPos__21 = p24.FruitWorldPos;
                    local v30 = p24.Control:GetSlotPosition();
                    local v31;
                    if v30 then
                        local v32 = l__FruitWorldPos__21.X - v30.X;
                        local v33 = l__FruitWorldPos__21.Z - v30.Z;
                        v31 = math.sqrt(v32 * v32 + v33 * v33);
                    else
                        v31 = (1 / 0);
                    end;
                    if v31 <= 3 then
                        p24:TransitionTo("Picking");
                    elseif p24:TimeInState() >= p24.LegTimeout then
                        p24:TransitionTo("Aborting");
                    end;
                else
                    p24:TransitionTo("Aborting");
                end;
            end
        },
        Picking = {
            Enter = function(p34) --[[ Name: Enter, Line 241 ]]
                local v35 = p34.Control:GetSlotPosition();
                if v35 then
                    local v36 = p34.Control:GetSlotPosition();
                    if not v36 then
                        return;
                    end;
                    local l__Control__22 = p34.Control;
                    local v37 = Vector3.new(v35.X - v36.X, 0, v35.Z - v36.Z);
                    local v38;
                    if v37.Magnitude < 0.001 then
                        v38 = CFrame.new(v35);
                    else
                        v38 = CFrame.lookAt(v35, v35 + v37.Unit);
                    end;
                    l__Control__22:SetGoal(v38, 0);
                end;
            end,
            Update = function(p39, _, _) --[[ Name: Update, Line 248 ]]
                -- upvalues: l__DataService__5 (ref), u3 (ref), l__Services__4 (ref)
                if p39:TimeInState() < p39.PickDuration then
                elseif p39.PickedUp then
                else
                    local l__Player__23 = p39.Player;
                    local l__PlantId__24 = p39.PlantId;
                    local l__FruitId__25 = p39.FruitId;
                    local v40;
                    if l__Player__23 and l__Player__23.Parent then
                        local v41 = l__DataService__5:GetFruit(l__Player__23, l__PlantId__24, l__FruitId__25);
                        if v41 and (v41.Age and v41.MaxAge) then
                            v40 = v41.Age >= v41.MaxAge;
                        else
                            v40 = false;
                        end;
                    else
                        v40 = false;
                    end;
                    if v40 then
                        local v42 = l__DataService__5:GetFruit(p39.Player, p39.PlantId, p39.FruitId);
                        if v42 then
                            p39.Control:SetSlotAttribute("CarryingFruitSeed", v42.Seed or 0);
                            p39.Control:SetSlotAttribute("CarryingFruitSize", v42.SizeMultiplier or 1);
                            p39.Control:SetSlotAttribute("CarryingFruitOvertimeGrowth", (math.max(v42.OvertimeGrowth or 1, 1)));
                            p39.Control:SetSlotAttribute("CarryingFruitMutation", v42.Mutation or "");
                            p39.Control:SetSlotAttribute("CarryingFruit", p39.FruitName);
                            if not u3 then
                                u3 = require(l__Services__4:WaitForChild("MonkeyService"));
                            end;
                            u3:MarkPickedUp(p39.Player, p39.PlantId, p39.FruitId);
                            p39.PickedUp = true;
                            p39:TransitionTo("Returning");
                        else
                            p39:TransitionTo("Aborting");
                        end;
                    else
                        p39:TransitionTo("Aborting");
                    end;
                end;
            end
        },
        Returning = {
            Update = function(p43, _, _) --[[ Name: Update, Line 281 ]]
                local l__Character__26 = p43.Player.Character;
                local v44;
                if l__Character__26 then
                    local v45 = l__Character__26:FindFirstChild("HumanoidRootPart");
                    if v45 and v45:IsA("BasePart") then
                        v44 = v45.Position;
                    else
                        v44 = nil;
                    end;
                else
                    v44 = nil;
                end;
                if v44 then
                    local l__TravelSpeed__27 = p43.TravelSpeed;
                    local v46 = p43.Control:GetSlotPosition();
                    if v46 then
                        local l__Control__28 = p43.Control;
                        local v47 = Vector3.new(v44.X - v46.X, 0, v44.Z - v46.Z);
                        local v48;
                        if v47.Magnitude < 0.001 then
                            v48 = CFrame.new(v44);
                        else
                            v48 = CFrame.lookAt(v44, v44 + v47.Unit);
                        end;
                        l__Control__28:SetGoal(v48, l__TravelSpeed__27);
                    end;
                    local v49 = p43.Control:GetSlotPosition();
                    local v50;
                    if v49 then
                        local v51 = v44.X - v49.X;
                        local v52 = v44.Z - v49.Z;
                        v50 = math.sqrt(v51 * v51 + v52 * v52);
                    else
                        v50 = (1 / 0);
                    end;
                    if v50 <= p43.DeliveryRadius then
                        p43:TransitionTo("Delivering");
                    elseif p43:TimeInState() >= p43.LegTimeout * 2 then
                        p43:TransitionTo("Aborting");
                    end;
                else
                    if p43:TimeInState() >= p43.LegTimeout * 2 then
                        p43:TransitionTo("Aborting");
                    end;
                end;
            end
        },
        Delivering = {
            Enter = function(p53) --[[ Name: Enter, Line 306 ]]
                -- upvalues: u3 (ref), l__Services__4 (ref), u16 (ref), l__RarityVisuals__10 (ref), l__PetData__7 (ref), u1 (ref)
                if not u3 then
                    u3 = require(l__Services__4:WaitForChild("MonkeyService"));
                end;
                local v54, v55 = u3:Commit(p53.Player, p53.PlantId, p53.FruitId);
                p53.Reserved = false;
                p53.PickedUp = false;
                u16(p53.Control);
                if v54 then
                    local l__RichText__29 = l__RarityVisuals__10.RichText;
                    local v56 = l__PetData__7.GetSpeciesDisplayName(p53.Species);
                    local v57 = l__PetData__7[p53.Species];
                    local v58 = l__RichText__29(v56, (type(v57) ~= "table" or type(v57.Rarity) ~= "string") and "Common" or v57.Rarity);
                    local v59 = l__RarityVisuals__10.RichText(tostring(p53.FruitName), u1[p53.FruitName] or "Common");
                    p53.Control:Notify((`Your {v58} brought you a {v59}!`));
                elseif v55 == "Full" then
                    p53.Control:Notify("Your Monkey couldn\'t deliver -- your inventory is full!");
                end;
                p53:Stop("Delivered");
            end
        },
        Aborting = {
            Enter = function(p60) --[[ Name: Enter, Line 329 ]]
                local l__Character__30 = p60.Player.Character;
                local v61;
                if l__Character__30 then
                    local v62 = l__Character__30:FindFirstChild("HumanoidRootPart");
                    if v62 and v62:IsA("BasePart") then
                        v61 = v62.Position;
                    else
                        v61 = nil;
                    end;
                else
                    v61 = nil;
                end;
                if v61 then
                    local l__TravelSpeed__31 = p60.TravelSpeed;
                    local v63 = p60.Control:GetSlotPosition();
                    if not v63 then
                        return;
                    end;
                    local l__Control__32 = p60.Control;
                    local v64 = Vector3.new(v61.X - v63.X, 0, v61.Z - v63.Z);
                    local v65;
                    if v64.Magnitude < 0.001 then
                        v65 = CFrame.new(v61);
                    else
                        v65 = CFrame.lookAt(v61, v61 + v64.Unit);
                    end;
                    l__Control__32:SetGoal(v65, l__TravelSpeed__31);
                end;
            end,
            Update = function(p66, _, _) --[[ Name: Update, Line 336 ]]
                if p66:TimeInState() >= p66.LegTimeout then
                    p66:Stop("Aborted");
                end;
            end
        }
    };
end;
function u5.new(p68) --[[ Line: 346 ]]
    -- upvalues: l__BehaviorBase__1 (copy), u5 (copy), l__PetSizes__8 (copy), u4 (copy), l__PetTypes__9 (copy), u67 (copy)
    local v69 = l__BehaviorBase__1.New(u5, p68);
    local v70 = v69.Config.TravelSpeed or 20;
    local l__Slot__33 = v69.Slot;
    local v71;
    if l__Slot__33 then
        v71 = 1;
        local v72 = l__PetSizes__8.Normalize(l__Slot__33:GetAttribute("PetSize"));
        if v72 and u4[v72] then
            v71 = v71 * u4[v72];
        end;
        if l__Slot__33:GetAttribute("PetType") == l__PetTypes__9.Rainbow then
            v71 = v71 * 1.15;
        end;
    else
        v71 = 1;
    end;
    v69.TravelSpeed = v70 * v71;
    v69.LegTimeout = v69.Config.LegTimeout or 20;
    v69.PickDuration = v69.Config.PickDuration or 1;
    v69.DeliveryRadius = v69.Config.DeliveryRadius or 8;
    v69.PlantId = nil;
    v69.FruitId = nil;
    v69.FruitName = nil;
    v69.FruitWorldPos = nil;
    v69.Reserved = false;
    v69.PickedUp = false;
    v69.States = u67();
    return v69;
end;
function u5.GetInitialState(_) --[[ Line: 365 ]]
    return "Targeting";
end;
function u5.GetChanceMultiplier(_, p73) --[[ Line: 375 ]]
    -- upvalues: u3 (ref), l__Services__4 (copy), l__PetSizes__8 (copy), l__PetTypes__9 (copy)
    if not u3 then
        u3 = require(l__Services__4:WaitForChild("MonkeyService"));
    end;
    local v74 = u3:GetChanceMultiplier();
    if p73 then
        local v75 = p73:GetAttribute("PetSize");
        local v76 = p73:GetAttribute("PetType");
        local l__GetBoostMultiplier__34 = l__PetSizes__8.GetBoostMultiplier;
        if type(v75) ~= "string" then
            v75 = nil;
        end;
        local v77 = v74 * l__GetBoostMultiplier__34(v75);
        local l__GetBoostMultiplier__35 = l__PetTypes__9.GetBoostMultiplier;
        if type(v76) ~= "string" then
            v76 = nil;
        end;
        v74 = v77 * l__GetBoostMultiplier__35(v76);
    end;
    return v74;
end;
function u5.CanStart(p78) --[[ Line: 387 ]]
    -- upvalues: u14 (copy)
    local l__Player__36 = p78.Player;
    if l__Player__36 and l__Player__36.Parent then
        if l__Player__36:GetAttribute("IsInOwnGarden") == true then
            return u14(l__Player__36) ~= nil;
        else
            return false;
        end;
    else
        return false;
    end;
end;
function u5.OnStop(p79, _) --[[ Line: 397 ]]
    -- upvalues: u16 (copy), u3 (ref), l__Services__4 (copy)
    if p79.Control then
        u16(p79.Control);
    end;
    if p79.Reserved and (p79.PlantId and p79.FruitId) then
        if not u3 then
            u3 = require(l__Services__4:WaitForChild("MonkeyService"));
        end;
        u3:Release(p79.Player, p79.PlantId, p79.FruitId);
        p79.Reserved = false;
    end;
end;
return u5;