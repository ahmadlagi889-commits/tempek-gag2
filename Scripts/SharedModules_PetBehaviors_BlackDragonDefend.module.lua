-- Decompiled with Potassium's decompiler.

local l__BehaviorBase__1 = require(script.Parent.BehaviorBase);
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__PetTypes__3 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetTypes"));
local l__PetSizes__4 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetSizes"));
local l__Services__5 = game:GetService("ServerScriptService"):WaitForChild("Services");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {
    Big = 1.5,
    Huge = 2
};
local u6 = setmetatable({}, {
    __index = l__BehaviorBase__1
});
u6.__index = u6;
u6.Name = "BlackDragonDefend";
local function u15(p7, p8, p9) --[[ Line: 92 ]]
    local v10 = p7.Control:GetSlotPosition();
    if v10 then
        local v11 = (not p7.Module or (not p7.Module.IsFlying or type(p7.Module.AirHeight) ~= "number")) and 0 or p7.Module.AirHeight;
        local v12 = Vector3.new(p8.X, p8.Y - v11, p8.Z);
        p7.Control:SetSlotAttribute("Hovering", true);
        local l__Control__6 = p7.Control;
        local v13 = v12 - v10;
        local v14;
        if v13.Magnitude < 0.001 then
            v14 = CFrame.new(v12);
        else
            v14 = CFrame.lookAt(v12, v12 + v13.Unit);
        end;
        l__Control__6:SetGoal(v14, p9);
    end;
end;
local function u24(p16, p17, p18, p19) --[[ Line: 106 ]]
    local v20 = (not p16.Module or (not p16.Module.IsFlying or type(p16.Module.AirHeight) ~= "number")) and 0 or p16.Module.AirHeight;
    local v21 = Vector3.new(p17.X, p17.Y - v20, p17.Z);
    p16.Control:SetSlotAttribute("Hovering", true);
    local l__Control__7 = p16.Control;
    local v22 = p18 - v21;
    local v23;
    if v22.Magnitude < 0.001 then
        v23 = CFrame.new(p18);
    else
        v23 = CFrame.lookAt(p18, p18 + v22.Unit);
    end;
    l__Control__7:SetGoal(v23, p19);
end;
local function u30(p25, p26) --[[ Line: 141 ]]
    -- upvalues: u1 (ref), l__Services__5 (copy)
    if not p26 then
        return false;
    end;
    local l__Player__8 = p26.Player;
    if not (l__Player__8 and l__Player__8.Parent) then
        return false;
    end;
    if l__Player__8:GetAttribute("InSafeZone") == true then
        return false;
    end;
    if l__Player__8:GetAttribute("IsInOwnGarden") == true then
        return false;
    end;
    if not u1 then
        u1 = require(l__Services__5:WaitForChild("DragonDefenseService"));
    end;
    local v27 = u1;
    if v27 and v27:IsPlayerAtOwnPlot(l__Player__8) then
        return false;
    end;
    local l__Character__9 = l__Player__8.Character;
    if not l__Character__9 then
        return false;
    end;
    if not l__Character__9:FindFirstChild("HumanoidRootPart") then
        return false;
    end;
    local v28 = l__Character__9:FindFirstChildOfClass("Humanoid");
    if not v28 or v28.Health <= 0 then
        return false;
    end;
    if not p26.ShovelAggro then
        return l__Player__8:GetAttribute("CarryingStolenFruit") == true;
    end;
    if not u1 then
        u1 = require(l__Services__5:WaitForChild("DragonDefenseService"));
    end;
    local v29 = u1;
    if v29 then
        v29 = v29:GetDragonAggroTarget(p25.Player);
    end;
    return v29 == l__Player__8;
end;
local function u35(p31) --[[ Line: 170 ]]
    -- upvalues: u1 (ref), l__Services__5 (copy)
    if not u1 then
        u1 = require(l__Services__5:WaitForChild("DragonDefenseService"));
    end;
    local v32 = u1;
    if not v32 then
        return nil;
    end;
    local v33 = v32:GetDragonAggroTarget(p31.Player);
    if v33 then
        return {
            ShovelAggro = true,
            Player = v33
        };
    end;
    local v34 = v32:PickTargetFor(p31.Player);
    return v34 and v34.Player and {
        ShovelAggro = false,
        Player = v34.Player
    } or nil;
end;
local function u61() --[[ Line: 186 ]]
    -- upvalues: u35 (copy), u15 (copy), u30 (copy), u24 (copy), u2 (ref), l__Services__5 (copy)
    return {
        Acquire = {
            Enter = function(p36) --[[ Name: Enter, Line 190 ]]
                -- upvalues: u35 (ref)
                local v37 = u35(p36);
                if v37 then
                    p36.Target = v37;
                    p36:TransitionTo("Approach");
                else
                    p36:Stop("NoThreat");
                end;
            end
        },
        Approach = {
            Enter = function(p38) --[[ Name: Enter, Line 202 ]]
                -- upvalues: u15 (ref)
                local l__Target__10 = p38.Target;
                local v39;
                if l__Target__10 and l__Target__10.Player then
                    local l__Character__11 = l__Target__10.Player.Character;
                    if l__Character__11 then
                        local v40 = l__Character__11:FindFirstChild("HumanoidRootPart");
                        if v40 and v40:IsA("BasePart") then
                            v39 = v40.Position;
                        else
                            v39 = nil;
                        end;
                    else
                        v39 = nil;
                    end;
                else
                    v39 = nil;
                end;
                if v39 then
                    u15(p38, v39, p38.ApproachSpeed);
                end;
            end,
            Update = function(p41, p42, _) --[[ Name: Update, Line 207 ]]
                -- upvalues: u30 (ref), u15 (ref)
                if u30(p41, p41.Target) then
                    local l__Target__12 = p41.Target;
                    local v43;
                    if l__Target__12 and l__Target__12.Player then
                        local l__Character__13 = l__Target__12.Player.Character;
                        if l__Character__13 then
                            local v44 = l__Character__13:FindFirstChild("HumanoidRootPart");
                            if v44 and v44:IsA("BasePart") then
                                v43 = v44.Position;
                            else
                                v43 = nil;
                            end;
                        else
                            v43 = nil;
                        end;
                    else
                        v43 = nil;
                    end;
                    if v43 then
                        u15(p41, v43, p41.ApproachSpeed);
                        local v45 = p41.Control:GetSlotPosition();
                        if (not v45 and (1 / 0) or (v43 - v45).Magnitude) <= p41.StartBreathDistance then
                            if p41.BreathReadyAt <= p42 then
                                p41:TransitionTo("Breathe");
                            else
                                p41:TransitionTo("Cooldown");
                            end;
                        elseif p41:TimeInState() >= p41.ApproachLegTimeout then
                            p41:TransitionTo("Acquire");
                        end;
                    else
                        p41:TransitionTo("Return");
                    end;
                else
                    p41:TransitionTo("Return");
                end;
            end
        },
        Breathe = {
            Enter = function(p46) --[[ Name: Enter, Line 238 ]]
                local l__Target__14 = p46.Target;
                local v47;
                if l__Target__14 and l__Target__14.Player then
                    local l__Character__15 = l__Target__14.Player.Character;
                    if l__Character__15 then
                        local v48 = l__Character__15:FindFirstChild("HumanoidRootPart");
                        if v48 and v48:IsA("BasePart") then
                            v47 = v48.Position;
                        else
                            v47 = nil;
                        end;
                    else
                        v47 = nil;
                    end;
                else
                    v47 = nil;
                end;
                if v47 then
                    p46._BreathAnchor = p46.Control:GetSlotPosition() or v47;
                    p46._BreathFireAt = os.clock() + p46.BreathWindup;
                    p46._BreathEndsAt = p46._BreathFireAt + p46.BreathDuration;
                    p46._BreathFired = false;
                else
                    p46:TransitionTo("Return");
                end;
            end,
            Update = function(u49, p50, _) --[[ Name: Update, Line 251 ]]
                -- upvalues: u30 (ref), u24 (ref), u2 (ref), l__Services__5 (ref)
                if u30(u49, u49.Target) then
                    local l__Target__16 = u49.Target;
                    local v51;
                    if l__Target__16 and l__Target__16.Player then
                        local l__Character__17 = l__Target__16.Player.Character;
                        if l__Character__17 then
                            local v52 = l__Character__17:FindFirstChild("HumanoidRootPart");
                            if v52 and v52:IsA("BasePart") then
                                v51 = v52.Position;
                            else
                                v51 = nil;
                            end;
                        else
                            v51 = nil;
                        end;
                    else
                        v51 = nil;
                    end;
                    if v51 then
                        if (v51 - u49._BreathAnchor).Magnitude > u49.BreathLeash then
                            u49.BreathReadyAt = p50 + u49.BreathCooldown;
                            u49:TransitionTo("Approach");
                        else
                            u24(u49, u49._BreathAnchor, v51, u49.ApproachSpeed);
                            if not u49._BreathFired and u49._BreathFireAt <= p50 then
                                u49._BreathFired = true;
                                if not u2 then
                                    u2 = require(l__Services__5:WaitForChild("DragonFireService"));
                                end;
                                local u53 = u2;
                                if u53 then
                                    pcall(function() --[[ Line: 277 ]]
                                        -- upvalues: u53 (copy), u49 (copy)
                                        u53:StartBreath(u49.Slot, u49.Player, u49.Target.Player, u49.BreathDuration, u49.DmgMult);
                                    end);
                                end;
                            end;
                            if u49._BreathEndsAt <= p50 then
                                u49.BreathReadyAt = p50 + u49.BreathCooldown;
                                u49:TransitionTo("Cooldown");
                            end;
                        end;
                    else
                        u49:TransitionTo("Return");
                    end;
                else
                    u49:TransitionTo("Return");
                end;
            end
        },
        Cooldown = {
            Update = function(p54, p55, _) --[[ Name: Update, Line 292 ]]
                -- upvalues: u30 (ref), u15 (ref), u24 (ref)
                if u30(p54, p54.Target) then
                    local l__Target__18 = p54.Target;
                    local v56;
                    if l__Target__18 and l__Target__18.Player then
                        local l__Character__19 = l__Target__18.Player.Character;
                        if l__Character__19 then
                            local v57 = l__Character__19:FindFirstChild("HumanoidRootPart");
                            if v57 and v57:IsA("BasePart") then
                                v56 = v57.Position;
                            else
                                v56 = nil;
                            end;
                        else
                            v56 = nil;
                        end;
                    else
                        v56 = nil;
                    end;
                    if v56 then
                        local v58 = p54.Control:GetSlotPosition();
                        if (not v58 and (1 / 0) or (v56 - v58).Magnitude) > p54.StartBreathDistance then
                            u15(p54, v56, p54.ApproachSpeed);
                        else
                            u24(p54, p54.Control:GetSlotPosition() or v56, v56, p54.ApproachSpeed);
                        end;
                        if p54.BreathReadyAt <= p55 then
                            local v59 = p54.Control:GetSlotPosition();
                            if (not v59 and (1 / 0) or (v56 - v59).Magnitude) <= p54.BreathLeash then
                                p54:TransitionTo("Breathe");
                                return;
                            end;
                            p54:TransitionTo("Approach");
                        end;
                    else
                        p54:TransitionTo("Return");
                    end;
                else
                    p54:TransitionTo("Return");
                end;
            end
        },
        Return = {
            Enter = function(p60) --[[ Name: Enter, Line 326 ]]
                if p60.Control and p60.Control.SetSlotAttribute then
                    p60.Control:SetSlotAttribute("Hovering", nil);
                end;
                p60:Stop("Disengaged");
            end
        }
    };
end;
function u6.new(p62) --[[ Line: 336 ]]
    -- upvalues: l__BehaviorBase__1 (copy), u6 (copy), u4 (ref), u3 (ref), l__Services__5 (copy), l__PetSizes__4 (copy), u5 (copy), l__PetTypes__3 (copy), u2 (ref), u61 (copy)
    local v63 = l__BehaviorBase__1.New(u6, p62);
    local l__Player__20 = v63.Player;
    local l__PetId__21 = v63.PetId;
    if not u4 then
        u3 = require(l__Services__5:WaitForChild("DataService"));
        u4 = u3.GetPet;
    end;
    local v64 = u4(u3, l__Player__20, l__PetId__21);
    local v65;
    if v64 then
        v65 = v64.Size;
    else
        v65 = nil;
    end;
    local v66;
    if v64 then
        v66 = v64.Type;
    else
        v66 = nil;
    end;
    v63.ApproachSpeed = v63.Config.ApproachSpeed or 22;
    v63.BreathDuration = v63.Config.BreathDuration or 1.5;
    v63.BreathCooldown = v63.Config.BreathCooldown or 8;
    v63.ApproachLegTimeout = v63.Config.ApproachLegTimeout or 8;
    v63.BreathWindup = v63.Config.BreathWindup or 1.5;
    local v67 = l__PetSizes__4.Normalize(v65);
    v63.DmgMult = (v67 and (u5[v67] or 1) or 1) * l__PetTypes__3.GetBoostMultiplier(v66);
    if not u2 then
        u2 = require(l__Services__5:WaitForChild("DragonFireService"));
    end;
    local v68 = u2;
    if v68 then
        v63.StartBreathDistance = v68:GetStartBreathDistance(v65);
        v63.BreathLeash = v68:GetBreathLeash(v65);
    else
        v63.StartBreathDistance = 8;
        v63.BreathLeash = 40;
    end;
    v63.Target = nil;
    v63.BreathReadyAt = 0;
    v63._BreathAnchor = nil;
    v63._BreathFireAt = 0;
    v63._BreathEndsAt = 0;
    v63._BreathFired = false;
    v63.States = u61();
    return v63;
end;
function u6.GetInitialState(_) --[[ Line: 375 ]]
    return "Acquire";
end;
function u6.OnStop(p69, _) --[[ Line: 379 ]]
    if p69.Control and p69.Control.SetSlotAttribute then
        p69.Control:SetSlotAttribute("Hovering", nil);
    end;
end;
function u6.CanStart(p70) --[[ Line: 383 ]]
    -- upvalues: u35 (copy)
    local l__Player__22 = p70.Player;
    if l__Player__22 and l__Player__22.Parent then
        return u35(p70) ~= nil;
    else
        return false;
    end;
end;
return u6;