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
local u6 = {
    Big = 1.5,
    Huge = 1.8
};
local u7 = setmetatable({}, {
    __index = l__BehaviorBase__1
});
u7.__index = u7;
u7.Name = "IceSerpentDefend";
local function u16(p8, p9, p10) --[[ Line: 125 ]]
    local v11 = p8.Control:GetSlotPosition();
    if v11 then
        local v12 = (not p8.Module or (not p8.Module.IsFlying or type(p8.Module.AirHeight) ~= "number")) and 0 or p8.Module.AirHeight;
        local v13 = Vector3.new(p9.X, v11.Y - v12, p9.Z);
        p8.Control:SetSlotAttribute("Hovering", true);
        local l__Control__6 = p8.Control;
        local v14 = v13 - v11;
        local v15;
        if v14.Magnitude < 0.001 then
            v15 = CFrame.new(v13);
        else
            v15 = CFrame.lookAt(v13, v13 + v14.Unit);
        end;
        l__Control__6:SetGoal(v15, p10);
    end;
end;
local function u25(p17, p18, p19, p20) --[[ Line: 144 ]]
    local v21 = (not p17.Module or (not p17.Module.IsFlying or type(p17.Module.AirHeight) ~= "number")) and 0 or p17.Module.AirHeight;
    local v22 = Vector3.new(p18.X, p18.Y - v21, p18.Z);
    local v23 = p19 - p18;
    local v24 = v23.Magnitude <= 0.001 and Vector3.new(0, 0, -1) or v23.Unit;
    p17.Control:SetSlotAttribute("Hovering", true);
    p17.Control:SetGoal(CFrame.lookAt(v22, v22 + v24), p20);
end;
local function u37(p26, p27, p28, p29, p30) --[[ Line: 170 ]]
    local v31 = (not p26.Module or (not p26.Module.IsFlying or type(p26.Module.AirHeight) ~= "number")) and 0 or p26.Module.AirHeight;
    local v32 = Vector3.new(p28.X - p27.X, 0, p28.Z - p27.Z);
    local l__Magnitude__7 = v32.Magnitude;
    local v33 = p27 + (l__Magnitude__7 <= 0.001 and Vector3.new(0, 0, -1) or v32.Unit) * (math.min(4, l__Magnitude__7 * 0.5) * p29);
    local v34 = Vector3.new(v33.X, p27.Y - v31, v33.Z);
    local v35 = p28 - v33;
    local v36 = v35.Magnitude <= 0.001 and Vector3.new(0, 0, -1) or v35.Unit;
    p26.Control:SetSlotAttribute("Hovering", true);
    p26.Control:SetGoal(CFrame.lookAt(v34, v34 + v36), p30);
end;
local function u40(p38) --[[ Line: 221 ]]
    if p38 and p38.Player then
        local l__Character__8 = p38.Player.Character;
        if l__Character__8 then
            local v39 = l__Character__8:FindFirstChild("UpperTorso") or (l__Character__8:FindFirstChild("Torso") or l__Character__8:FindFirstChild("HumanoidRootPart"));
            if v39 and v39:IsA("BasePart") then
                return v39.Position;
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
local function u45(p41, p42) --[[ Line: 235 ]]
    -- upvalues: u1 (ref), l__Services__5 (copy)
    if not p42 then
        return false;
    end;
    local l__Player__9 = p42.Player;
    if not (l__Player__9 and l__Player__9.Parent) then
        return false;
    end;
    if l__Player__9:GetAttribute("InSafeZone") == true then
        return false;
    end;
    if l__Player__9:GetAttribute("IsInOwnGarden") == true then
        return false;
    end;
    local l__Character__10 = l__Player__9.Character;
    if not l__Character__10 then
        return false;
    end;
    if not l__Character__10:FindFirstChild("HumanoidRootPart") then
        return false;
    end;
    local v43 = l__Character__10:FindFirstChildOfClass("Humanoid");
    if not v43 or v43.Health <= 0 then
        return false;
    end;
    if not p42.ShovelAggro then
        return l__Player__9:GetAttribute("CarryingStolenFruit") == true;
    end;
    if not u1 then
        u1 = require(l__Services__5:WaitForChild("DragonDefenseService"));
    end;
    local v44 = u1;
    if v44 then
        v44 = v44:GetDragonAggroTarget(p41.Player);
    end;
    return v44 == l__Player__9;
end;
local function u50(p46) --[[ Line: 259 ]]
    -- upvalues: u1 (ref), l__Services__5 (copy)
    if not u1 then
        u1 = require(l__Services__5:WaitForChild("DragonDefenseService"));
    end;
    local v47 = u1;
    if not v47 then
        return nil;
    end;
    local v48 = v47:GetDragonAggroTarget(p46.Player);
    if v48 then
        return {
            ShovelAggro = true,
            Player = v48
        };
    end;
    local v49 = v47:PickTargetFor(p46.Player);
    return v49 and v49.Player and {
        ShovelAggro = false,
        Player = v49.Player
    } or nil;
end;
local function u90() --[[ Line: 275 ]]
    -- upvalues: u50 (copy), u16 (copy), u45 (copy), u40 (copy), u37 (copy), u2 (ref), l__Services__5 (copy), u25 (copy)
    return {
        Acquire = {
            Enter = function(p51) --[[ Name: Enter, Line 279 ]]
                -- upvalues: u50 (ref)
                local v52 = u50(p51);
                if v52 then
                    p51.Target = v52;
                    p51:TransitionTo("Approach");
                else
                    p51:Stop("NoThreat");
                end;
            end
        },
        Approach = {
            Enter = function(p53) --[[ Name: Enter, Line 291 ]]
                -- upvalues: u16 (ref)
                local l__Target__11 = p53.Target;
                local v54;
                if l__Target__11 and l__Target__11.Player then
                    local l__Character__12 = l__Target__11.Player.Character;
                    if l__Character__12 then
                        local v55 = l__Character__12:FindFirstChild("HumanoidRootPart");
                        if v55 and v55:IsA("BasePart") then
                            v54 = v55.Position;
                        else
                            v54 = nil;
                        end;
                    else
                        v54 = nil;
                    end;
                else
                    v54 = nil;
                end;
                if v54 then
                    u16(p53, v54, p53.ApproachSpeed);
                end;
            end,
            Update = function(p56, p57, _) --[[ Name: Update, Line 296 ]]
                -- upvalues: u45 (ref), u16 (ref)
                if u45(p56, p56.Target) then
                    local l__Target__13 = p56.Target;
                    local v58;
                    if l__Target__13 and l__Target__13.Player then
                        local l__Character__14 = l__Target__13.Player.Character;
                        if l__Character__14 then
                            local v59 = l__Character__14:FindFirstChild("HumanoidRootPart");
                            if v59 and v59:IsA("BasePart") then
                                v58 = v59.Position;
                            else
                                v58 = nil;
                            end;
                        else
                            v58 = nil;
                        end;
                    else
                        v58 = nil;
                    end;
                    if v58 then
                        u16(p56, v58, p56.ApproachSpeed);
                        local v60 = p56.Control:GetSlotPosition();
                        local v61;
                        if v60 then
                            local v62 = v58.X - v60.X;
                            local v63 = v58.Z - v60.Z;
                            v61 = math.sqrt(v62 * v62 + v63 * v63) <= 10;
                        else
                            v61 = false;
                        end;
                        if v61 then
                            if p56.BreathReadyAt <= p57 then
                                p56:TransitionTo("Breathe");
                            else
                                p56:TransitionTo("Cooldown");
                            end;
                        elseif p56:TimeInState() >= p56.ApproachLegTimeout then
                            p56:TransitionTo("Acquire");
                        end;
                    else
                        p56:TransitionTo("Return");
                    end;
                else
                    p56:TransitionTo("Return");
                end;
            end
        },
        Breathe = {
            Enter = function(p64) --[[ Name: Enter, Line 327 ]]
                local l__Target__15 = p64.Target;
                local v65;
                if l__Target__15 and l__Target__15.Player then
                    local l__Character__16 = l__Target__15.Player.Character;
                    if l__Character__16 then
                        local v66 = l__Character__16:FindFirstChild("HumanoidRootPart");
                        if v66 and v66:IsA("BasePart") then
                            v65 = v66.Position;
                        else
                            v65 = nil;
                        end;
                    else
                        v65 = nil;
                    end;
                else
                    v65 = nil;
                end;
                if v65 then
                    p64._BreathAnchor = p64.Control:GetSlotPosition() or v65;
                    p64._BreathLastPos = v65;
                    p64._BreathStartAt = os.clock();
                    p64._BreathFireAt = p64._BreathStartAt + p64.BreathWindup;
                    p64._BreathEndsAt = p64._BreathFireAt + p64.BreathDuration;
                    p64._BreathFired = false;
                else
                    p64:TransitionTo("Return");
                end;
            end,
            Update = function(u67, p68, _) --[[ Name: Update, Line 342 ]]
                -- upvalues: u40 (ref), u45 (ref), u37 (ref), u2 (ref), l__Services__5 (ref)
                local v69 = u40(u67.Target);
                local l__Target__17 = u67.Target;
                local v70;
                if l__Target__17 and l__Target__17.Player then
                    local l__Character__18 = l__Target__17.Player.Character;
                    if l__Character__18 then
                        local v71 = l__Character__18:FindFirstChild("HumanoidRootPart");
                        if v71 and v71:IsA("BasePart") then
                            v70 = v71.Position;
                        else
                            v70 = nil;
                        end;
                    else
                        v70 = nil;
                    end;
                else
                    v70 = nil;
                end;
                if v69 then
                    u67._BreathLastPos = v69;
                end;
                local l___BreathFired__19 = u67._BreathFired;
                if l___BreathFired__19 then
                    l___BreathFired__19 = p68 < u67._BreathEndsAt;
                end;
                if not l___BreathFired__19 then
                    if not u45(u67, u67.Target) then
                        u67:TransitionTo("Return");
                        return;
                    end;
                    if not v70 then
                        u67:TransitionTo("Return");
                        return;
                    end;
                    if (v70 - u67._BreathAnchor).Magnitude > u67.BreathLeash then
                        u67.BreathReadyAt = p68 + u67.BreathCooldown;
                        u67:TransitionTo("Approach");
                        return;
                    end;
                end;
                local v72 = v69 or (u67._BreathLastPos or u67._BreathAnchor);
                local v73 = math.max(0.001, u67._BreathEndsAt - u67._BreathStartAt);
                local v74 = math.clamp((p68 - u67._BreathStartAt) / v73, 0, 1) * 3.141592653589793;
                local v75 = math.sin(v74);
                u37(u67, u67._BreathAnchor, v72, v75, u67.ApproachSpeed);
                if not u67._BreathFired and u67._BreathFireAt <= p68 then
                    u67._BreathFired = true;
                    if not u2 then
                        u2 = require(l__Services__5:WaitForChild("IceSerpentFireService"));
                    end;
                    local u76 = u2;
                    if u76 then
                        pcall(function() --[[ Line: 385 ]]
                            -- upvalues: u76 (copy), u67 (copy)
                            u76:StartBreath(u67.Slot, u67.Player, u67.Target.Player, u67.BreathDuration, u67.DmgMult, u67.FreezeMult);
                        end);
                    end;
                end;
                if u67._BreathEndsAt <= p68 then
                    u67.BreathReadyAt = p68 + u67.BreathCooldown;
                    u67:TransitionTo("Cooldown");
                end;
            end
        },
        Cooldown = {
            Update = function(p77, p78, _) --[[ Name: Update, Line 400 ]]
                -- upvalues: u45 (ref), u16 (ref), u25 (ref)
                if u45(p77, p77.Target) then
                    local l__Target__20 = p77.Target;
                    local v79;
                    if l__Target__20 and l__Target__20.Player then
                        local l__Character__21 = l__Target__20.Player.Character;
                        if l__Character__21 then
                            local v80 = l__Character__21:FindFirstChild("HumanoidRootPart");
                            if v80 and v80:IsA("BasePart") then
                                v79 = v80.Position;
                            else
                                v79 = nil;
                            end;
                        else
                            v79 = nil;
                        end;
                    else
                        v79 = nil;
                    end;
                    if v79 then
                        local v81 = p77.Control:GetSlotPosition();
                        local v82;
                        if v81 then
                            local v83 = v79.X - v81.X;
                            local v84 = v79.Z - v81.Z;
                            v82 = math.sqrt(v83 * v83 + v84 * v84) <= 10;
                        else
                            v82 = false;
                        end;
                        if v82 then
                            u25(p77, p77.Control:GetSlotPosition() or v79, v79, p77.ApproachSpeed);
                        else
                            u16(p77, v79, p77.ApproachSpeed);
                        end;
                        if p77.BreathReadyAt <= p78 then
                            local v85 = p77.Control:GetSlotPosition();
                            local v86;
                            if v85 then
                                local v87 = v79.X - v85.X;
                                local v88 = v79.Z - v85.Z;
                                v86 = math.sqrt(v87 * v87 + v88 * v88) <= 10;
                            else
                                v86 = false;
                            end;
                            if v86 then
                                p77:TransitionTo("Breathe");
                                return;
                            end;
                            p77:TransitionTo("Approach");
                        end;
                    else
                        p77:TransitionTo("Return");
                    end;
                else
                    p77:TransitionTo("Return");
                end;
            end
        },
        Return = {
            Enter = function(p89) --[[ Name: Enter, Line 434 ]]
                if p89.Control and p89.Control.SetSlotAttribute then
                    p89.Control:SetSlotAttribute("Hovering", nil);
                end;
                p89:Stop("Disengaged");
            end
        }
    };
end;
function u7.new(p91) --[[ Line: 444 ]]
    -- upvalues: l__BehaviorBase__1 (copy), u7 (copy), u4 (ref), u3 (ref), l__Services__5 (copy), l__PetSizes__4 (copy), u5 (copy), l__PetTypes__3 (copy), u6 (copy), u2 (ref), u90 (copy)
    local v92 = l__BehaviorBase__1.New(u7, p91);
    local l__Player__22 = v92.Player;
    local l__PetId__23 = v92.PetId;
    if not u4 then
        u3 = require(l__Services__5:WaitForChild("DataService"));
        u4 = u3.GetPet;
    end;
    local v93 = u4(u3, l__Player__22, l__PetId__23);
    local v94;
    if v93 then
        v94 = v93.Size;
    else
        v94 = nil;
    end;
    local v95;
    if v93 then
        v95 = v93.Type;
    else
        v95 = nil;
    end;
    v92.ApproachSpeed = v92.Config.ApproachSpeed or 22;
    v92.BreathDuration = v92.Config.BreathDuration or 1.5;
    v92.BreathCooldown = v92.Config.BreathCooldown or 8;
    v92.ApproachLegTimeout = v92.Config.ApproachLegTimeout or 8;
    v92.BreathWindup = v92.Config.BreathWindup or 1;
    local v96 = l__PetSizes__4.Normalize(v94);
    v92.DmgMult = (v96 and (u5[v96] or 1) or 1) * l__PetTypes__3.GetBoostMultiplier(v95);
    local v97 = l__PetSizes__4.Normalize(v94);
    v92.FreezeMult = (v97 and (u6[v97] or 1) or 1) * (v95 == l__PetTypes__3.Rainbow and 1.25 or 1);
    if not u2 then
        u2 = require(l__Services__5:WaitForChild("IceSerpentFireService"));
    end;
    local v98 = u2;
    if v98 then
        v92.StartBreathDistance = v98:GetStartBreathDistance(v94);
        v92.BreathLeash = v98:GetBreathLeash(v94);
    else
        v92.StartBreathDistance = 8;
        v92.BreathLeash = 40;
    end;
    v92.Target = nil;
    v92.BreathReadyAt = 0;
    v92._BreathAnchor = nil;
    v92._BreathLastPos = nil;
    v92._BreathStartAt = 0;
    v92._BreathFireAt = 0;
    v92._BreathEndsAt = 0;
    v92._BreathFired = false;
    v92.States = u90();
    return v92;
end;
function u7.GetInitialState(_) --[[ Line: 488 ]]
    return "Acquire";
end;
function u7.OnStop(p99, _) --[[ Line: 492 ]]
    if p99.Control and p99.Control.SetSlotAttribute then
        p99.Control:SetSlotAttribute("Hovering", nil);
    end;
end;
function u7.CanStart(p100) --[[ Line: 496 ]]
    -- upvalues: u50 (copy)
    local l__Player__24 = p100.Player;
    if l__Player__24 and l__Player__24.Parent then
        return u50(p100) ~= nil;
    else
        return false;
    end;
end;
return u7;