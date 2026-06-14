-- Decompiled with Potassium's decompiler.

local l__BehaviorBase__1 = require(script.Parent.BehaviorBase);
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__SharedModules__3 = l__ReplicatedStorage__2:WaitForChild("SharedModules");
local l__Networking__4 = require(l__SharedModules__3.Networking);
local l__PetTypes__5 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetTypes"));
local l__PetSizes__6 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetSizes"));
local l__PetData__7 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetData"));
local l__Services__8 = game:GetService("ServerScriptService"):WaitForChild("Services");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {
    Big = 1.75,
    Huge = 2.5
};
local u6 = {
    Big = 1.5,
    Huge = 1.75
};
local u7 = setmetatable({}, {
    __mode = "k"
});
local u8 = setmetatable({}, {
    __mode = "k"
});
local u9 = setmetatable({}, {
    __index = l__BehaviorBase__1
});
u9.__index = u9;
u9.Name = "DefendGarden";
local function u18(p10, p11, p12) --[[ Line: 175 ]]
    local v13 = p10.Control:GetSlotPosition();
    if v13 then
        local v14 = (not p10.Module or (not p10.Module.IsFlying or type(p10.Module.AirHeight) ~= "number")) and 0 or p10.Module.AirHeight;
        local v15 = Vector3.new(p11.X, p11.Y - v14, p11.Z);
        p10.Control:SetSlotAttribute("Hovering", true);
        local l__Control__9 = p10.Control;
        local v16 = v15 - v13;
        local v17;
        if v16.Magnitude < 0.001 then
            v17 = CFrame.new(v15);
        else
            v17 = CFrame.lookAt(v15, v15 + v16.Unit);
        end;
        l__Control__9:SetGoal(v17, p12);
    end;
end;
local function u20(p19) --[[ Line: 201 ]]
    if p19 then
        if p19.Kind == "Player" and p19.Player then
            return "P:" .. tostring(p19.Player.UserId);
        elseif p19.Kind == "Raccoon" and (p19.RaccoonOwner and p19.RaccoonPetId) then
            return "R:" .. tostring(p19.RaccoonOwner.UserId) .. ":" .. tostring(p19.RaccoonPetId);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
local function u23(p21) --[[ Line: 214 ]]
    if p21 then
        if p21.Kind == "Player" and p21.Player then
            local l__Character__10 = p21.Player.Character;
            if l__Character__10 then
                local v22 = l__Character__10:FindFirstChild("HumanoidRootPart");
                if v22 and v22:IsA("BasePart") then
                    return v22.Position;
                else
                    return nil;
                end;
            else
                return nil;
            end;
        elseif p21.Kind == "Raccoon" and (p21.Slot and p21.Slot.Parent) then
            return p21.Slot.Position;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
local function u28(p24, p25) --[[ Line: 236 ]]
    -- upvalues: u1 (ref), l__Services__8 (copy)
    if p25 then
        if p25.Kind == "Player" then
            local l__Player__11 = p25.Player;
            if not (l__Player__11 and l__Player__11.Parent) then
                return false;
            end;
            if l__Player__11:GetAttribute("InSafeZone") == true then
                return false;
            end;
            local l__Character__12 = l__Player__11.Character;
            if not l__Character__12 then
                return false;
            end;
            if not l__Character__12:FindFirstChild("HumanoidRootPart") then
                return false;
            end;
            local v26 = l__Character__12:FindFirstChildOfClass("Humanoid");
            if not v26 or v26.Health <= 0 then
                return false;
            end;
            if p25.ShovelAggro then
                if not u1 then
                    u1 = require(l__Services__8:WaitForChild("BeeDefenseService"));
                end;
                local v27 = u1;
                if v27 then
                    v27 = v27:GetShovelAggroTarget(p24.Player);
                end;
                if v27 ~= l__Player__11 then
                    return false;
                end;
            end;
            return true;
        elseif p25.Kind == "Raccoon" then
            if p25.Slot and p25.Slot.Parent then
                if p25.Slot:GetAttribute("PetSpecies") == "Raccoon" then
                    return p25.Slot:GetAttribute("PetClaim") == "StealFruit";
                else
                    return false;
                end;
            else
                return false;
            end;
        else
            return false;
        end;
    else
        return false;
    end;
end;
local function u34(p29) --[[ Line: 268 ]]
    local v30 = nil;
    local v31 = p29.Player:GetAttribute("PlotId");
    if type(v31) == "number" then
        local v32 = workspace:FindFirstChild("Gardens");
        if v32 then
            v30 = v32:FindFirstChild("Plot" .. tostring(v31));
        end;
    end;
    if v30 then
        local v33 = v30:FindFirstChild("SpawnPoint");
        if v33 and v33:IsA("BasePart") then
            return v33.Position;
        elseif v30:IsA("Model") then
            return v30:GetPivot().Position;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
local function u55(u35, u36) --[[ Line: 289 ]]
    -- upvalues: u4 (ref), u3 (ref), l__Services__8 (copy), u1 (ref), l__PetSizes__6 (copy), u5 (copy), l__PetTypes__5 (copy), l__PetData__7 (copy), l__Networking__4 (copy)
    if u36 and u36.Parent then
        local l__Player__13 = u35.Player;
        local l__PetId__14 = u35.PetId;
        if not u4 then
            u3 = require(l__Services__8:WaitForChild("DataService"));
            u4 = u3.GetPet;
        end;
        local v37 = u4(u3, l__Player__13, l__PetId__14);
        local v38;
        if v37 then
            v38 = v37.Size;
        else
            v38 = nil;
        end;
        if not u1 then
            u1 = require(l__Services__8:WaitForChild("BeeDefenseService"));
        end;
        local v39 = u1;
        local u40;
        if v39 then
            local v41 = l__PetSizes__6.Normalize(v38);
            local v42 = v41 and (u5[v41] or 1) or 1;
            local l__GetBoostMultiplier__15 = l__PetTypes__5.GetBoostMultiplier;
            local v43;
            if v37 then
                v43 = v37.Type;
            else
                v43 = nil;
            end;
            u40 = v39:ApplyStingEffect(u36, v42 * l__GetBoostMultiplier__15(v43));
        else
            u40 = 0;
        end;
        local l__Slot__16 = u35.Slot;
        if l__Slot__16 then
            l__Slot__16 = u35.Slot:GetAttribute("PetSpecies");
        end;
        local u44 = (typeof(l__Slot__16) ~= "string" or l__Slot__16 == "") and "Bee" or l__PetData__7.GetDisplayName(l__Slot__16, v38);
        pcall(function() --[[ Line: 314 ]]
            -- upvalues: l__Networking__4 (ref), u36 (copy), u35 (copy), u44 (copy)
            l__Networking__4.Notification:FireClient(u36, (`{u35.Player.Name}'s {u44} stung you! You feel woozy...`));
        end);
        pcall(function() --[[ Line: 321 ]]
            -- upvalues: l__Networking__4 (ref), u36 (copy), u40 (ref)
            l__Networking__4.Bee.Sting:FireClient(u36, u40);
        end);
        local l__Character__17 = u36.Character;
        if l__Character__17 then
            local v45 = l__Character__17:FindFirstChild("HumanoidRootPart");
            if v45 and v45:IsA("BasePart") then
                local u46 = l__Character__17:FindFirstChildOfClass("Humanoid");
                local v47 = u35.Control:GetSlotPosition() or v45.Position;
                local v48 = v45.Position - v47;
                local v49 = Vector3.new(v48.X, 0, v48.Z);
                local v50;
                if v49.Magnitude < 0.001 then
                    local v51 = v45.CFrame.LookVector * -1;
                    local v52 = Vector3.new(v51.X, 0, v51.Z);
                    v50 = v52.Magnitude < 0.001 and Vector3.new(0, 0, -1) or v52.Unit;
                else
                    v50 = v49.Unit;
                end;
                if u46 then
                    u46.PlatformStand = true;
                    task.delay(0.5, function() --[[ Line: 352 ]]
                        -- upvalues: u46 (copy)
                        if u46 and u46.Parent then
                            u46.PlatformStand = false;
                        end;
                    end);
                end;
                local v53 = v50 * 6 + Vector3.new(0, 12, 0);
                local u54 = Instance.new("BodyVelocity");
                u54.MaxForce = Vector3.new(inf, inf, inf);
                u54.Velocity = v53;
                u54.Parent = v45;
                task.delay(0.3, function() --[[ Line: 365 ]]
                    -- upvalues: u54 (copy)
                    if u54 and u54.Parent then
                        u54:Destroy();
                    end;
                end);
            end;
        end;
    end;
end;
local function u65(u56, u57, p58) --[[ Line: 381 ]]
    -- upvalues: u20 (copy), u8 (copy), u1 (ref), l__Services__8 (copy), u55 (copy), u2 (ref)
    local v59 = u20(u57);
    if not v59 then
        return false;
    end;
    if u57.Kind ~= "Player" or not u57.Player then
        if u57.Kind ~= "Raccoon" or not (u57.RaccoonOwner and u57.RaccoonPetId) then
            return false;
        end;
        if not u2 then
            u2 = require(l__Services__8:WaitForChild("PetBehaviorService"));
        end;
        local u60 = u2;
        if u60 then
            pcall(function() --[[ Line: 409 ]]
                -- upvalues: u60 (copy), u57 (copy), u56 (copy)
                u60:OnPetScared(u57.RaccoonOwner, u57.RaccoonPetId, u56.Player);
            end);
        end;
        return true;
    end;
    local l__Player__18 = u57.Player;
    local v61 = u8[u56.Slot];
    local v62;
    if v61 then
        v62 = v61[v59];
    else
        v62 = nil;
    end;
    if v62 and p58 - v62 < u56.StingCooldown then
        return false;
    end;
    if not u1 then
        u1 = require(l__Services__8:WaitForChild("BeeDefenseService"));
    end;
    local v63 = u1;
    if v63 and v63:IsTargetStingInvulnerable(l__Player__18) then
        return false;
    end;
    local l__Slot__19 = u56.Slot;
    local v64 = u8[l__Slot__19];
    if not v64 then
        v64 = {};
        u8[l__Slot__19] = v64;
    end;
    v64[v59] = p58;
    if v63 then
        v63:MarkTargetStung(l__Player__18);
    end;
    u55(u56, l__Player__18);
    return true;
end;
local function u103() --[[ Line: 431 ]]
    -- upvalues: u1 (ref), l__Services__8 (copy), u7 (copy), u23 (copy), u18 (copy), u28 (copy), u65 (copy), u34 (copy)
    return {
        Acquire = {
            Enter = function(p66) --[[ Name: Enter, Line 438 ]]
                -- upvalues: u1 (ref), l__Services__8 (ref), u7 (ref)
                if not u1 then
                    u1 = require(l__Services__8:WaitForChild("BeeDefenseService"));
                end;
                local v67 = u1;
                if v67 then
                    local l__Slot__20 = p66.Slot;
                    local v68;
                    if l__Slot__20 then
                        local v69 = u7[l__Slot__20];
                        if v69 == nil then
                            v68 = false;
                        else
                            v68 = os.clock() < v69;
                        end;
                    else
                        v68 = false;
                    end;
                    local v70 = not v68 and v67:GetShovelAggroTarget(p66.Player);
                    if v70 then
                        local l__Slot__21 = p66.Slot;
                        local l__ShovelAggroCooldown__22 = p66.ShovelAggroCooldown;
                        if l__Slot__21 then
                            u7[l__Slot__21] = os.clock() + l__ShovelAggroCooldown__22;
                        end;
                        p66.Target = {
                            Kind = "Player",
                            ShovelAggro = true,
                            Player = v70
                        };
                        p66:TransitionTo("Dive");
                        return;
                    end;
                end;
                if v67 then
                    v67 = v67:PickTargetFor(p66.Player);
                end;
                if v67 then
                    p66.Target = v67;
                    p66:TransitionTo("Dive");
                else
                    p66:Stop("NoThreat");
                end;
            end
        },
        Dive = {
            Enter = function(p71) --[[ Name: Enter, Line 472 ]]
                -- upvalues: u23 (ref), u18 (ref)
                local v72 = u23(p71.Target);
                if v72 then
                    u18(p71, v72, p71.AttackSpeed);
                end;
            end,
            Update = function(p73, p74, _) --[[ Name: Update, Line 477 ]]
                -- upvalues: u28 (ref), u23 (ref), u18 (ref), u65 (ref)
                if u28(p73, p73.Target) then
                    local v75 = u23(p73.Target);
                    if v75 then
                        u18(p73, v75, p73.AttackSpeed);
                        local v76 = p73.Control:GetSlotPosition();
                        if (not v76 and (1 / 0) or (v75 - v76).Magnitude) <= p73.HitRadius then
                            u65(p73, p73.Target, p74);
                            p73:TransitionTo("Orbit");
                        elseif p73:TimeInState() >= p73.DiveLegTimeout then
                            p73:TransitionTo("Acquire");
                        end;
                    else
                        p73:TransitionTo("Acquire");
                    end;
                else
                    p73:TransitionTo("Acquire");
                end;
            end
        },
        Orbit = {
            Enter = function(p77) --[[ Name: Enter, Line 510 ]]
                -- upvalues: u23 (ref), u18 (ref)
                local v78 = u23(p77.Target);
                if v78 then
                    local v79 = math.random() * 3.141592653589793 * 2;
                    local v80 = p77.OrbitYMin + math.random() * (p77.OrbitYMax - p77.OrbitYMin);
                    p77._OrbitBaseY = v80;
                    local v81 = v80 + (math.random() * 2 - 1) * p77.OrbitYJitter;
                    local v82 = math.cos(v79) * p77.OrbitRadius;
                    local v83 = math.sin(v79) * p77.OrbitRadius;
                    u18(p77, v78 + Vector3.new(v82, v81, v83), p77.AttackSpeed);
                    p77._OrbitAngle = v79;
                    p77._OrbitDir = math.random() < 0.5 and 1 or -1;
                end;
            end,
            Update = function(p84, _, p85) --[[ Name: Update, Line 532 ]]
                -- upvalues: u23 (ref), u18 (ref), u1 (ref), l__Services__8 (ref), u7 (ref), u28 (ref)
                local v86 = u23(p84.Target);
                if v86 and p84._OrbitAngle then
                    p84._OrbitAngle = p84._OrbitAngle + p84._OrbitDir * 4 * p85;
                    local v87 = p84._OrbitBaseY + (math.random() * 2 - 1) * p84.OrbitYJitter;
                    local v88 = math.cos(p84._OrbitAngle) * p84.OrbitRadius;
                    local v89 = math.sin(p84._OrbitAngle) * p84.OrbitRadius;
                    u18(p84, v86 + Vector3.new(v88, v87, v89), p84.AttackSpeed);
                end;
                if p84:TimeInState() < p84.OrbitDuration then
                else
                    if not u1 then
                        u1 = require(l__Services__8:WaitForChild("BeeDefenseService"));
                    end;
                    local v90 = u1;
                    local l__Target__23 = p84.Target;
                    if l__Target__23 then
                        l__Target__23 = p84.Target.ShovelAggro;
                    end;
                    if v90 and not l__Target__23 then
                        local l__Slot__24 = p84.Slot;
                        local v91;
                        if l__Slot__24 then
                            local v92 = u7[l__Slot__24];
                            if v92 == nil then
                                v91 = false;
                            else
                                v91 = os.clock() < v92;
                            end;
                        else
                            v91 = false;
                        end;
                        local v93 = not v91 and v90:GetShovelAggroTarget(p84.Player);
                        if v93 then
                            local l__Slot__25 = p84.Slot;
                            local l__ShovelAggroCooldown__26 = p84.ShovelAggroCooldown;
                            if l__Slot__25 then
                                u7[l__Slot__25] = os.clock() + l__ShovelAggroCooldown__26;
                            end;
                            p84.Target = {
                                Kind = "Player",
                                ShovelAggro = true,
                                Player = v93
                            };
                            p84:TransitionTo("Dive");
                            return;
                        end;
                    end;
                    if l__Target__23 then
                        if u28(p84, p84.Target) then
                            p84:TransitionTo("Dive");
                        else
                            p84:TransitionTo("Return");
                        end;
                    else
                        if v90 then
                            v90 = v90:PickTargetFor(p84.Player);
                        end;
                        if v90 then
                            p84.Target = v90;
                            p84:TransitionTo("Dive");
                        else
                            p84:TransitionTo("Return");
                        end;
                    end;
                end;
            end
        },
        Return = {
            Enter = function(p94) --[[ Name: Enter, Line 599 ]]
                -- upvalues: u34 (ref)
                if p94.Control and p94.Control.SetSlotAttribute then
                    p94.Control:SetSlotAttribute("Hovering", nil);
                end;
                p94.HomePos = u34(p94);
                if p94.HomePos then
                    local l__HomePos__27 = p94.HomePos;
                    local l__ReturnSpeed__28 = p94.ReturnSpeed;
                    local v95 = p94.Control:GetSlotPosition();
                    if not v95 then
                        return;
                    end;
                    local l__Control__29 = p94.Control;
                    local v96 = l__HomePos__27 - v95;
                    local v97;
                    if v96.Magnitude < 0.001 then
                        v97 = CFrame.new(l__HomePos__27);
                    else
                        v97 = CFrame.lookAt(l__HomePos__27, l__HomePos__27 + v96.Unit);
                    end;
                    l__Control__29:SetGoal(v97, l__ReturnSpeed__28);
                end;
            end,
            Update = function(p98, _, _) --[[ Name: Update, Line 609 ]]
                if p98.HomePos then
                    local l__HomePos__30 = p98.HomePos;
                    local l__ReturnSpeed__31 = p98.ReturnSpeed;
                    local v99 = p98.Control:GetSlotPosition();
                    if v99 then
                        local l__Control__32 = p98.Control;
                        local v100 = l__HomePos__30 - v99;
                        local v101;
                        if v100.Magnitude < 0.001 then
                            v101 = CFrame.new(l__HomePos__30);
                        else
                            v101 = CFrame.lookAt(l__HomePos__30, l__HomePos__30 + v100.Unit);
                        end;
                        l__Control__32:SetGoal(v101, l__ReturnSpeed__31);
                    end;
                    local l__HomePos__33 = p98.HomePos;
                    local v102 = p98.Control:GetSlotPosition();
                    if (not v102 and (1 / 0) or (l__HomePos__33 - v102).Magnitude) <= p98.ReturnArriveRadius then
                        p98:Stop("Returned");
                    elseif p98:TimeInState() >= p98.ReturnLegTimeout then
                        p98:Stop("ReturnTimeout");
                    end;
                else
                    p98:Stop("NoHome");
                end;
            end
        }
    };
end;
function u9.new(p104) --[[ Line: 631 ]]
    -- upvalues: l__BehaviorBase__1 (copy), u9 (copy), u4 (ref), u3 (ref), l__Services__8 (copy), l__PetTypes__5 (copy), l__PetSizes__6 (copy), u6 (copy), u103 (copy)
    local v105 = l__BehaviorBase__1.New(u9, p104);
    local l__Player__34 = v105.Player;
    local l__PetId__35 = v105.PetId;
    if not u4 then
        u3 = require(l__Services__8:WaitForChild("DataService"));
        u4 = u3.GetPet;
    end;
    local v106 = u4(u3, l__Player__34, l__PetId__35);
    local l__GetBoostMultiplier__36 = l__PetTypes__5.GetBoostMultiplier;
    local v107;
    if v106 then
        v107 = v106.Type;
    else
        v107 = nil;
    end;
    local v108 = l__GetBoostMultiplier__36(v107);
    local v109;
    if v106 then
        v109 = v106.Size;
    else
        v109 = nil;
    end;
    local v110 = l__PetSizes__6.Normalize(v109);
    v105.AttackSpeed = (v105.Config.AttackSpeed or 27) * (v108 * (v110 and (u6[v110] or 1) or 1));
    v105.ReturnSpeed = v105.Config.ReturnSpeed or 27;
    v105.StingCooldown = v105.Config.StingCooldown or 10;
    v105.HitRadius = v105.Config.HitRadius or 3.5;
    v105.OrbitRadius = v105.Config.OrbitRadius or 9;
    v105.OrbitDuration = v105.Config.OrbitDuration or 0.8;
    v105.OrbitYJitter = v105.Config.OrbitYJitter or 1;
    v105.OrbitYMin = v105.Config.OrbitYMin or -1;
    v105.OrbitYMax = v105.Config.OrbitYMax or 5;
    v105.DiveLegTimeout = v105.Config.DiveLegTimeout or 2.5;
    v105.ReturnLegTimeout = v105.Config.ReturnLegTimeout or 6;
    v105.ReturnArriveRadius = v105.Config.ReturnArriveRadius or 6;
    v105.ShovelAggroCooldown = v105.Config.ShovelAggroCooldown or 10;
    v105.Target = nil;
    v105.HomePos = nil;
    v105._OrbitAngle = nil;
    v105._OrbitDir = 1;
    v105._OrbitBaseY = 0;
    v105.States = u103();
    return v105;
end;
function u9.GetInitialState(_) --[[ Line: 667 ]]
    return "Acquire";
end;
function u9.OnStop(p111, _) --[[ Line: 675 ]]
    if p111.Control and p111.Control.SetSlotAttribute then
        p111.Control:SetSlotAttribute("Hovering", nil);
    end;
end;
function u9.CanStart(p112) --[[ Line: 682 ]]
    -- upvalues: u1 (ref), l__Services__8 (copy), u7 (copy)
    local l__Player__37 = p112.Player;
    if not (l__Player__37 and l__Player__37.Parent) then
        return false;
    end;
    if not u1 then
        u1 = require(l__Services__8:WaitForChild("BeeDefenseService"));
    end;
    local v113 = u1;
    if not v113 then
        return false;
    end;
    local l__Slot__38 = p112.Slot;
    local v114;
    if l__Slot__38 then
        local v115 = u7[l__Slot__38];
        if v115 == nil then
            v114 = false;
        else
            v114 = os.clock() < v115;
        end;
    else
        v114 = false;
    end;
    return not v114 and v113:GetShovelAggroTarget(l__Player__37) and true or v113:PickTargetFor(l__Player__37) ~= nil;
end;
return u9;