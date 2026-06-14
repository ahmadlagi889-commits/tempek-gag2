-- Decompiled with Potassium's decompiler.

local l__VRService__1 = game:GetService("VRService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__RunService__3 = game:GetService("RunService");
local l__Players__4 = game:GetService("Players");
local l__PathfindingService__5 = game:GetService("PathfindingService");
local l__ContextActionService__6 = game:GetService("ContextActionService");
local l__StarterGui__7 = game:GetService("StarterGui");
local l__CommonUtils__8 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__9 = require(l__CommonUtils__8:WaitForChild("FlagUtil"));
local u1 = nil;
local l__LocalPlayer__10 = l__Players__4.LocalPlayer;
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Exclude;
local u3 = l__FlagUtil__9.getUserFlag("UserRaycastUpdateAPI2");
local u4 = Instance.new("BindableEvent");
u4.Name = "MovementUpdate";
u4.Parent = script;
coroutine.wrap(function() --[[ Line: 54 ]]
    -- upvalues: u1 (ref)
    local l__PathDisplay__11 = script.Parent:WaitForChild("PathDisplay");
    if l__PathDisplay__11 then
        u1 = require(l__PathDisplay__11);
    end;
end)();
local l__BaseCharacterController__12 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u5 = setmetatable({}, l__BaseCharacterController__12);
u5.__index = u5;
function u5.new(p6) --[[ Line: 67 ]]
    -- upvalues: l__BaseCharacterController__12 (copy), u5 (copy)
    local v7 = l__BaseCharacterController__12.new();
    local v8 = setmetatable(v7, u5);
    v8.CONTROL_ACTION_PRIORITY = p6;
    v8.navigationRequestedConn = nil;
    v8.heartbeatConn = nil;
    v8.currentDestination = nil;
    v8.currentPath = nil;
    v8.currentPoints = nil;
    v8.currentPointIdx = 0;
    v8.expectedTimeToNextPoint = 0;
    v8.timeReachedLastPoint = tick();
    v8.moving = false;
    v8.isJumpBound = false;
    v8.moveLatch = false;
    v8.userCFrameEnabledConn = nil;
    return v8;
end;
function u5.SetLaserPointerMode(_, u9) --[[ Line: 92 ]]
    -- upvalues: l__StarterGui__7 (copy)
    pcall(function() --[[ Line: 93 ]]
        -- upvalues: l__StarterGui__7 (ref), u9 (copy)
        l__StarterGui__7:SetCore("VRLaserPointerMode", u9);
    end);
end;
function u5.GetLocalHumanoid(_) --[[ Line: 98 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local l__Character__13 = l__LocalPlayer__10.Character;
    if l__Character__13 then
        for _, v10 in pairs(l__Character__13:GetChildren()) do
            if v10:IsA("Humanoid") then
                return v10;
            end;
        end;
        return nil;
    end;
end;
function u5.HasBothHandControllers(_) --[[ Line: 112 ]]
    -- upvalues: l__VRService__1 (copy)
    local v11 = l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand);
    if v11 then
        v11 = l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);
    end;
    return v11;
end;
function u5.HasAnyHandControllers(_) --[[ Line: 116 ]]
    -- upvalues: l__VRService__1 (copy)
    return l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or l__VRService__1:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);
end;
function u5.IsMobileVR(_) --[[ Line: 120 ]]
    -- upvalues: l__UserInputService__2 (copy)
    return l__UserInputService__2.TouchEnabled;
end;
function u5.HasGamepad(_) --[[ Line: 124 ]]
    -- upvalues: l__UserInputService__2 (copy)
    return l__UserInputService__2.GamepadEnabled;
end;
function u5.ShouldUseNavigationLaser(p12) --[[ Line: 128 ]]
    if p12:IsMobileVR() then
        return true;
    elseif p12:HasBothHandControllers() then
        return false;
    else
        return p12:HasAnyHandControllers() and true or not p12:HasGamepad();
    end;
end;
function u5.StartFollowingPath(p13, p14) --[[ Line: 150 ]]
    -- upvalues: u4 (copy)
    currentPath = p14;
    currentPoints = currentPath:GetPointCoordinates();
    currentPointIdx = 1;
    moving = true;
    timeReachedLastPoint = tick();
    local v15 = p13:GetLocalHumanoid();
    if v15 and (v15.Torso and #currentPoints >= 1) then
        expectedTimeToNextPoint = (currentPoints[1] - v15.Torso.Position).magnitude / v15.WalkSpeed;
    end;
    u4:Fire("targetPoint", p13.currentDestination);
end;
function u5.GoToPoint(p16, p17) --[[ Line: 167 ]]
    -- upvalues: u4 (copy)
    currentPath = true;
    currentPoints = { p17 };
    currentPointIdx = 1;
    moving = true;
    local v18 = p16:GetLocalHumanoid();
    local v19 = (v18.Torso.Position - p17).magnitude / v18.WalkSpeed;
    timeReachedLastPoint = tick();
    expectedTimeToNextPoint = v19;
    u4:Fire("targetPoint", p17);
end;
function u5.StopFollowingPath(p20) --[[ Line: 183 ]]
    currentPath = nil;
    currentPoints = nil;
    currentPointIdx = 0;
    moving = false;
    p20.moveVector = Vector3.new(0, 0, 0);
end;
function u5.TryComputePath(_, p21, p22) --[[ Line: 191 ]]
    -- upvalues: l__PathfindingService__5 (copy)
    local v23 = nil;
    local v24 = 0;
    while not v23 and v24 < 5 do
        v23 = l__PathfindingService__5:ComputeSmoothPathAsync(p21, p22, 200);
        v24 = v24 + 1;
        if v23.Status == Enum.PathStatus.ClosestNoPath or v23.Status == Enum.PathStatus.ClosestOutOfRange then
            return nil;
        end;
        if v23 and v23.Status == Enum.PathStatus.FailStartNotEmpty then
            p21 = p21 + (p22 - p21).Unit;
            v23 = nil;
        end;
        if v23 and v23.Status == Enum.PathStatus.FailFinishNotEmpty then
            p22 = p22 + Vector3.new(0, 1, 0);
            v23 = nil;
        end;
    end;
    return v23;
end;
function u5.OnNavigationRequest(p25, p26, _) --[[ Line: 218 ]]
    -- upvalues: u1 (ref)
    local l__Position__14 = p26.Position;
    local l__currentDestination__15 = p25.currentDestination;
    local l__x__16 = l__Position__14.x;
    local v27;
    if l__x__16 == l__x__16 and l__x__16 ~= (1 / 0) then
        v27 = l__x__16 ~= (-1 / 0);
    else
        v27 = false;
    end;
    if v27 then
        local l__y__17 = l__Position__14.y;
        if l__y__17 == l__y__17 and l__y__17 ~= (1 / 0) then
            v27 = l__y__17 ~= (-1 / 0);
        else
            v27 = false;
        end;
        if v27 then
            local l__z__18 = l__Position__14.z;
            if l__z__18 == l__z__18 and l__z__18 ~= (1 / 0) then
                v27 = l__z__18 ~= (-1 / 0);
            else
                v27 = false;
            end;
        end;
    end;
    if v27 then
        p25.currentDestination = l__Position__14;
        local v28 = p25:GetLocalHumanoid();
        if v28 and v28.Torso then
            local l__Position__19 = v28.Torso.Position;
            if (p25.currentDestination - l__Position__19).magnitude < 12 then
                p25:GoToPoint(p25.currentDestination);
            else
                if l__currentDestination__15 and (p25.currentDestination - l__currentDestination__15).magnitude <= 4 then
                    if moving then
                        p25.currentPoints[#currentPoints] = p25.currentDestination;
                        return;
                    end;
                    p25:GoToPoint(p25.currentDestination);
                else
                    local v29 = p25:TryComputePath(l__Position__19, p25.currentDestination);
                    if v29 then
                        p25:StartFollowingPath(v29);
                        if u1 then
                            u1.setCurrentPoints(p25.currentPoints);
                            u1.renderPath();
                        end;
                    else
                        p25:StopFollowingPath();
                        if u1 then
                            u1.clearRenderedPath();
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u5.OnJumpAction(p30, _, p31, _) --[[ Line: 264 ]]
    if p31 == Enum.UserInputState.Begin then
        p30.isJumping = true;
    end;
    return Enum.ContextActionResult.Sink;
end;
function u5.BindJumpAction(u32, p33) --[[ Line: 270 ]]
    -- upvalues: l__ContextActionService__6 (copy)
    if p33 then
        if not u32.isJumpBound then
            u32.isJumpBound = true;
            l__ContextActionService__6:BindActionAtPriority("VRJumpAction", function() --[[ Line: 274 ]]
                -- upvalues: u32 (copy)
                return u32:OnJumpAction();
            end, false, u32.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA);
        end;
    elseif u32.isJumpBound then
        u32.isJumpBound = false;
        l__ContextActionService__6:UnbindAction("VRJumpAction");
    end;
end;
function u5.ControlCharacterGamepad(p34, _, p35, p36) --[[ Line: 285 ]]
    -- upvalues: u1 (ref), u4 (copy)
    if p36.KeyCode == Enum.KeyCode.Thumbstick1 then
        if p35 ~= Enum.UserInputState.Cancel then
            if p35 == Enum.UserInputState.End then
                p34.moveVector = Vector3.new(0, 0, 0);
                if p34:ShouldUseNavigationLaser() then
                    p34:BindJumpAction(false);
                    p34:SetLaserPointerMode("Navigation");
                end;
                if p34.moveLatch then
                    p34.moveLatch = false;
                    u4:Fire("offtrack");
                end;
            else
                p34:StopFollowingPath();
                if u1 then
                    u1.clearRenderedPath();
                end;
                if p34:ShouldUseNavigationLaser() then
                    p34:BindJumpAction(true);
                    p34:SetLaserPointerMode("Hidden");
                end;
                if p36.Position.magnitude > 0.22 then
                    p34.moveVector = Vector3.new(p36.Position.X, 0, -p36.Position.Y);
                    if p34.moveVector.magnitude > 0 then
                        p34.moveVector = p34.moveVector.unit * math.min(1, p36.Position.magnitude);
                    end;
                    p34.moveLatch = true;
                end;
            end;
            return Enum.ContextActionResult.Sink;
        end;
        p34.moveVector = Vector3.new(0, 0, 0);
    end;
end;
function u5.OnHeartbeat(p37, p38) --[[ Line: 328 ]]
    -- upvalues: u1 (ref), u3 (copy), u2 (copy), u4 (copy)
    local l__moveVector__20 = p37.moveVector;
    local v39 = p37:GetLocalHumanoid();
    if v39 and v39.Torso then
        if p37.moving and p37.currentPoints then
            local l__Position__21 = v39.Torso.Position;
            local v40 = (currentPoints[1] - l__Position__21) * Vector3.new(1, 0, 1);
            local l__magnitude__22 = v40.magnitude;
            local v41 = v40 / l__magnitude__22;
            if l__magnitude__22 < 1 then
                local v42 = currentPoints[1];
                local v43 = 0;
                for v44, v45 in pairs(currentPoints) do
                    if v44 ~= 1 then
                        v43 = v43 + (v45 - v42).magnitude / v39.WalkSpeed;
                        v42 = v45;
                    end;
                end;
                table.remove(currentPoints, 1);
                currentPointIdx = currentPointIdx + 1;
                if #currentPoints == 0 then
                    p37:StopFollowingPath();
                    if u1 then
                        u1.clearRenderedPath();
                    end;
                    return;
                end;
                if u1 then
                    u1.setCurrentPoints(currentPoints);
                    u1.renderPath();
                end;
                expectedTimeToNextPoint = (currentPoints[1] - l__Position__21).magnitude / v39.WalkSpeed;
                timeReachedLastPoint = tick();
            else
                if u3 then
                    u2.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
                    local v46 = workspace:Raycast(l__Position__21 - Vector3.new(0, 1, 0), v41 * 3, u2);
                    if v46 then
                        local v47 = workspace:Raycast(v46.Position + v41 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0), u2).Position.Y - l__Position__21.Y;
                        if v47 < 6 and v47 > -2 then
                            v39.Jump = true;
                        end;
                    end;
                else
                    local v48 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
                    local v49 = Ray.new(l__Position__21 - Vector3.new(0, 1, 0), v41 * 3);
                    local v50, v51, _ = workspace:FindPartOnRayWithIgnoreList(v49, v48);
                    if v50 then
                        local v52 = Ray.new(v51 + v41 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0));
                        local _, v53, _ = workspace:FindPartOnRayWithIgnoreList(v52, v48);
                        local v54 = v53.Y - l__Position__21.Y;
                        if v54 < 6 and v54 > -2 then
                            v39.Jump = true;
                        end;
                    end;
                end;
                if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
                    p37:StopFollowingPath();
                    if u1 then
                        u1.clearRenderedPath();
                    end;
                    u4:Fire("offtrack");
                end;
                l__moveVector__20 = p37.moveVector:Lerp(v41, p38 * 10);
            end;
        end;
        local l__x__23 = l__moveVector__20.x;
        local v55;
        if l__x__23 == l__x__23 and l__x__23 ~= (1 / 0) then
            v55 = l__x__23 ~= (-1 / 0);
        else
            v55 = false;
        end;
        if v55 then
            local l__y__24 = l__moveVector__20.y;
            if l__y__24 == l__y__24 and l__y__24 ~= (1 / 0) then
                v55 = l__y__24 ~= (-1 / 0);
            else
                v55 = false;
            end;
            if v55 then
                local l__z__25 = l__moveVector__20.z;
                if l__z__25 == l__z__25 and l__z__25 ~= (1 / 0) then
                    v55 = l__z__25 ~= (-1 / 0);
                else
                    v55 = false;
                end;
            end;
        end;
        if v55 then
            p37.moveVector = l__moveVector__20;
        end;
    end;
end;
function u5.OnUserCFrameEnabled(p56) --[[ Line: 426 ]]
    if p56:ShouldUseNavigationLaser() then
        p56:BindJumpAction(false);
        p56:SetLaserPointerMode("Navigation");
    else
        p56:BindJumpAction(true);
        p56:SetLaserPointerMode("Hidden");
    end;
end;
function u5.Enable(u57, p58) --[[ Line: 436 ]]
    -- upvalues: l__VRService__1 (copy), l__RunService__3 (copy), l__ContextActionService__6 (copy)
    u57.moveVector = Vector3.new(0, 0, 0);
    u57.isJumping = false;
    if p58 then
        u57.navigationRequestedConn = l__VRService__1.NavigationRequested:Connect(function(p59, p60) --[[ Line: 442 ]]
            -- upvalues: u57 (copy)
            u57:OnNavigationRequest(p59, p60);
        end);
        u57.heartbeatConn = l__RunService__3.Heartbeat:Connect(function(p61) --[[ Line: 443 ]]
            -- upvalues: u57 (copy)
            u57:OnHeartbeat(p61);
        end);
        l__ContextActionService__6:BindAction("MoveThumbstick", function(p62, p63, p64) --[[ Line: 445 ]]
            -- upvalues: u57 (copy)
            return u57:ControlCharacterGamepad(p62, p63, p64);
        end, false, u57.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1);
        l__ContextActionService__6:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
        u57.userCFrameEnabledConn = l__VRService__1.UserCFrameEnabled:Connect(function() --[[ Line: 449 ]]
            -- upvalues: u57 (copy)
            u57:OnUserCFrameEnabled();
        end);
        u57:OnUserCFrameEnabled();
        l__VRService__1:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick);
        l__VRService__1:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY);
        u57.enabled = true;
    else
        u57:StopFollowingPath();
        l__ContextActionService__6:UnbindAction("MoveThumbstick");
        l__ContextActionService__6:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
        u57:BindJumpAction(false);
        u57:SetLaserPointerMode("Disabled");
        if u57.navigationRequestedConn then
            u57.navigationRequestedConn:Disconnect();
            u57.navigationRequestedConn = nil;
        end;
        if u57.heartbeatConn then
            u57.heartbeatConn:Disconnect();
            u57.heartbeatConn = nil;
        end;
        if u57.userCFrameEnabledConn then
            u57.userCFrameEnabledConn:Disconnect();
            u57.userCFrameEnabledConn = nil;
        end;
        u57.enabled = false;
    end;
end;
return u5;