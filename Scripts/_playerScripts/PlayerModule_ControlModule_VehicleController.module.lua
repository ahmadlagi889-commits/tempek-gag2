-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 27 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.CONTROL_ACTION_PRIORITY = p2;
    v3.enabled = false;
    v3.vehicleSeat = nil;
    v3.throttle = 0;
    v3.steer = 0;
    v3.acceleration = 0;
    v3.decceleration = 0;
    v3.turningRight = 0;
    v3.turningLeft = 0;
    v3.vehicleMoveVector = Vector3.new(0, 0, 0);
    v3.autoPilot = {};
    v3.autoPilot.MaxSpeed = 0;
    v3.autoPilot.MaxSteeringAngle = 0;
    return v3;
end;
function u1.BindContextActions(u4) --[[ Line: 51 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    l__ContextActionService__1:BindActionAtPriority("throttleAccel", function(p5, p6, p7) --[[ Line: 53 ]]
        -- upvalues: u4 (copy)
        u4:OnThrottleAccel(p5, p6, p7);
        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonR2);
    l__ContextActionService__1:BindActionAtPriority("throttleDeccel", function(p8, p9, p10) --[[ Line: 57 ]]
        -- upvalues: u4 (copy)
        u4:OnThrottleDeccel(p8, p9, p10);
        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonL2);
    l__ContextActionService__1:BindActionAtPriority("arrowSteerRight", function(p11, p12, p13) --[[ Line: 62 ]]
        -- upvalues: u4 (copy)
        u4:OnSteerRight(p11, p12, p13);
        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Right);
    l__ContextActionService__1:BindActionAtPriority("arrowSteerLeft", function(p14, p15, p16) --[[ Line: 66 ]]
        -- upvalues: u4 (copy)
        u4:OnSteerLeft(p14, p15, p16);
        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Left);
end;
function u1.Enable(p17, p18, p19) --[[ Line: 72 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    if p18 == p17.enabled and p19 == p17.vehicleSeat then
    else
        p17.enabled = p18;
        p17.vehicleMoveVector = Vector3.new(0, 0, 0);
        if p18 then
            if p19 then
                p17.vehicleSeat = p19;
                p17:SetupAutoPilot();
                p17:BindContextActions();
            end;
        else
            l__ContextActionService__1:UnbindAction("throttleAccel");
            l__ContextActionService__1:UnbindAction("throttleDeccel");
            l__ContextActionService__1:UnbindAction("arrowSteerRight");
            l__ContextActionService__1:UnbindAction("arrowSteerLeft");
            p17.vehicleSeat = nil;
        end;
    end;
end;
function u1.OnThrottleAccel(p20, _, p21, _) --[[ Line: 98 ]]
    if p21 == Enum.UserInputState.End or p21 == Enum.UserInputState.Cancel then
        p20.acceleration = 0;
    else
        p20.acceleration = -1;
    end;
    p20.throttle = p20.acceleration + p20.decceleration;
end;
function u1.OnThrottleDeccel(p22, _, p23, _) --[[ Line: 107 ]]
    if p23 == Enum.UserInputState.End or p23 == Enum.UserInputState.Cancel then
        p22.decceleration = 0;
    else
        p22.decceleration = 1;
    end;
    p22.throttle = p22.acceleration + p22.decceleration;
end;
function u1.OnSteerRight(p24, _, p25, _) --[[ Line: 116 ]]
    if p25 == Enum.UserInputState.End or p25 == Enum.UserInputState.Cancel then
        p24.turningRight = 0;
    else
        p24.turningRight = 1;
    end;
    p24.steer = p24.turningRight + p24.turningLeft;
end;
function u1.OnSteerLeft(p26, _, p27, _) --[[ Line: 125 ]]
    if p27 == Enum.UserInputState.End or p27 == Enum.UserInputState.Cancel then
        p26.turningLeft = 0;
    else
        p26.turningLeft = -1;
    end;
    p26.steer = p26.turningRight + p26.turningLeft;
end;
function u1.Update(p28, p29, p30, _) --[[ Line: 135 ]]
    if p28.vehicleSeat then
        if p30 then
            local v31 = p29 + Vector3.new(p28.steer, 0, p28.throttle);
            p28.vehicleSeat.ThrottleFloat = -v31.Z;
            p28.vehicleSeat.SteerFloat = v31.X;
            return v31, true;
        else
            local v32 = p28.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(p29);
            p28.vehicleSeat.ThrottleFloat = p28:ComputeThrottle(v32);
            p28.vehicleSeat.SteerFloat = p28:ComputeSteer(v32);
            return Vector3.new(0, 0, 0), true;
        end;
    else
        return p29, false;
    end;
end;
function u1.ComputeThrottle(_, p33) --[[ Line: 161 ]]
    return p33 == Vector3.new(0, 0, 0) and 0 or -p33.Z;
end;
function u1.ComputeSteer(p34, p35) --[[ Line: 170 ]]
    return p35 == Vector3.new(0, 0, 0) and 0 or -math.atan2(-p35.x, -p35.z) * 57.29577951308232 / p34.autoPilot.MaxSteeringAngle;
end;
function u1.SetupAutoPilot(p36) --[[ Line: 179 ]]
    p36.autoPilot.MaxSpeed = p36.vehicleSeat.MaxSpeed;
    p36.autoPilot.MaxSteeringAngle = 35;
end;
return u1;