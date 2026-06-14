-- Decompiled with Potassium's decompiler.

local v1 = {};
v1.__index = v1;
v1.Name = "BehaviorBase";
function v1.New(p2, p3) --[[ Line: 9 ]]
    local v4 = setmetatable({}, p2);
    v4.Player = p3.Player;
    v4.PetId = p3.PetId;
    v4.Slot = p3.Slot;
    v4.Species = p3.Species;
    v4.Module = p3.Module;
    v4.Config = p3.Config or {};
    v4.Control = p3.Control;
    v4.State = nil;
    v4.StateEnteredAt = 0;
    v4.StartedAt = 0;
    v4.Done = false;
    v4.StopReason = nil;
    v4.States = v4.States or {};
    return v4;
end;
function v1.CanStart(_) --[[ Line: 37 ]]
    return true;
end;
function v1.GetInitialState(_) --[[ Line: 42 ]]
    return nil;
end;
function v1.Start(p5) --[[ Line: 47 ]]
    p5.StartedAt = os.clock();
    p5.Done = false;
    p5.StopReason = nil;
    if p5.Slot then
        p5.Slot:SetAttribute("PetClaim", p5.Name);
    end;
    local v6 = p5:GetInitialState();
    if v6 then
        p5:TransitionTo(v6);
    end;
end;
function v1.Update(p7, p8, p9) --[[ Line: 65 ]]
    if p7.Done then
    elseif p7.Slot and p7.Slot.Parent then
        if p7.Player and p7.Player.Parent then
            local l__State__1 = p7.State;
            if l__State__1 then
                l__State__1 = p7.States[p7.State];
            end;
            if l__State__1 and l__State__1.Update then
                l__State__1.Update(p7, p8, p9);
            end;
        else
            p7:Stop("PlayerLeft");
        end;
    else
        p7:Stop("SlotGone");
    end;
end;
function v1.TransitionTo(p10, p11) --[[ Line: 87 ]]
    local l__State__2 = p10.State;
    if l__State__2 then
        l__State__2 = p10.States[p10.State];
    end;
    if l__State__2 and l__State__2.Exit then
        l__State__2.Exit(p10);
    end;
    p10.State = p11;
    p10.StateEnteredAt = os.clock();
    local v12 = p10.States[p11];
    if v12 and v12.Enter then
        v12.Enter(p10);
    end;
end;
function v1.TimeInState(p13) --[[ Line: 103 ]]
    return os.clock() - p13.StateEnteredAt;
end;
function v1.Stop(p14, p15) --[[ Line: 108 ]]
    if p14.Done then
    else
        p14.Done = true;
        p14.StopReason = p15 or "Unknown";
        local l__State__3 = p14.State;
        if l__State__3 then
            l__State__3 = p14.States[p14.State];
        end;
        if l__State__3 and l__State__3.Exit then
            l__State__3.Exit(p14);
        end;
        if p14.OnStop then
            p14:OnStop(p14.StopReason);
        end;
        if p14.Control and p14.Control.ClearGoal then
            p14.Control:ClearGoal();
        end;
        if p14.Slot and p14.Slot.Parent then
            p14.Slot:SetAttribute("PetClaim", nil);
        end;
    end;
end;
function v1.OnEvent(p16, p17, p18) --[[ Line: 136 ]]
    local l__State__4 = p16.State;
    if l__State__4 then
        l__State__4 = p16.States[p16.State];
    end;
    if l__State__4 and l__State__4.OnEvent then
        l__State__4.OnEvent(p16, p17, p18);
    end;
end;
function v1.IsDone(p19) --[[ Line: 147 ]]
    return p19.Done;
end;
return v1;