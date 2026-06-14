-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("UserInputService");
local l__VRService__2 = game:GetService("VRService");
local l__UserGameSettings__3 = UserSettings():GetService("UserGameSettings");
local l__CommonUtils__4 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__ConnectionUtil__5 = require(l__CommonUtils__4:WaitForChild("ConnectionUtil"));
require(l__CommonUtils__4:WaitForChild("FlagUtil"));
local l__CameraUtils__6 = require(script.Parent:WaitForChild("CameraUtils"));
local l__ZoomController__7 = require(script.Parent:WaitForChild("ZoomController"));
local l__CameraToggleStateController__8 = require(script.Parent:WaitForChild("CameraToggleStateController"));
local l__CameraInput__9 = require(script.Parent:WaitForChild("CameraInput"));
local l__CameraUI__10 = require(script.Parent:WaitForChild("CameraUI"));
local l__LocalPlayer__11 = l__Players__1.LocalPlayer;
Vector2.new(0, 0);
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 70 ]]
    -- upvalues: u1 (copy), l__ConnectionUtil__5 (copy), l__LocalPlayer__11 (copy), l__UserGameSettings__3 (copy)
    local v2 = setmetatable({}, u1);
    v2._connections = l__ConnectionUtil__5.new();
    v2.gamepadZoomLevels = { 0, 10, 20 };
    v2.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    v2.cameraType = nil;
    v2.cameraMovementMode = nil;
    v2.lastCameraTransform = nil;
    v2.lastUserPanCamera = tick();
    v2.humanoidRootPart = nil;
    v2.humanoidCache = {};
    v2.lastSubject = nil;
    v2.lastSubjectPosition = Vector3.new(0, 5, 0);
    v2.lastSubjectCFrame = CFrame.new(v2.lastSubjectPosition);
    v2.currentSubjectDistance = math.clamp(12.5, l__LocalPlayer__11.CameraMinZoomDistance, l__LocalPlayer__11.CameraMaxZoomDistance);
    v2.inFirstPerson = false;
    v2.inMouseLockedMode = false;
    v2.resetCameraAngle = true;
    v2.enabled = false;
    v2.cameraChangedConn = nil;
    v2.shouldUseVRRotation = false;
    v2.VRRotationIntensityAvailable = false;
    v2.lastVRRotationIntensityCheckTime = 0;
    v2.lastVRRotationTime = 0;
    v2.vrRotateKeyCooldown = {};
    v2.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    v2.humanoidJumpOrigin = nil;
    v2.trackingHumanoid = nil;
    v2.cameraFrozen = false;
    v2.subjectStateChangedConn = nil;
    v2.gamepadZoomPressConnection = nil;
    v2.mouseLockOffset = Vector3.new(0, 0, 0);
    l__UserGameSettings__3:SetCameraYInvertVisible();
    l__UserGameSettings__3:SetGamepadCameraSensitivityVisible();
    return v2;
end;
function u1.GetModuleName(_) --[[ Line: 130 ]]
    return "BaseCamera";
end;
function u1._setUpConfigurations(u3) --[[ Line: 134 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    u3._connections:trackConnection("CHARACTER_ADDED", l__LocalPlayer__11.CharacterAdded:Connect(function(p4) --[[ Line: 135 ]]
        -- upvalues: u3 (copy)
        u3:OnCharacterAdded(p4);
    end));
    u3.humanoidRootPart = nil;
    u3._connections:trackConnection("CAMERA_MODE_CHANGED", l__LocalPlayer__11:GetPropertyChangedSignal("CameraMode"):Connect(function() --[[ Line: 140 ]]
        -- upvalues: u3 (copy)
        u3:OnPlayerCameraPropertyChange();
    end));
    u3._connections:trackConnection("CAMERA_MIN_DISTANCE_CHANGED", l__LocalPlayer__11:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() --[[ Line: 143 ]]
        -- upvalues: u3 (copy)
        u3:OnPlayerCameraPropertyChange();
    end));
    u3._connections:trackConnection("CAMERA_MAX_DISTANCE_CHANGED", l__LocalPlayer__11:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() --[[ Line: 146 ]]
        -- upvalues: u3 (copy)
        u3:OnPlayerCameraPropertyChange();
    end));
    u3:OnPlayerCameraPropertyChange();
end;
function u1.OnCharacterAdded(p5, _) --[[ Line: 152 ]]
    p5.resetCameraAngle = p5.resetCameraAngle or p5:GetEnabled();
    p5.humanoidRootPart = nil;
end;
function u1.GetHumanoidRootPart(p6) --[[ Line: 159 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    local v7 = (not p6.humanoidRootPart and l__LocalPlayer__11.Character and true or false) and l__LocalPlayer__11.Character:FindFirstChildOfClass("Humanoid");
    if v7 then
        p6.humanoidRootPart = v7.RootPart;
    end;
    return p6.humanoidRootPart;
end;
function u1.GetBodyPartToFollow(_, p8, _) --[[ Line: 171 ]]
    if p8:GetState() == Enum.HumanoidStateType.Dead then
        local l__Parent__12 = p8.Parent;
        if l__Parent__12 and l__Parent__12:IsA("Model") then
            return l__Parent__12:FindFirstChild("Head") or p8.RootPart;
        end;
    end;
    return p8.RootPart;
end;
function u1.GetSubjectCFrame(p9) --[[ Line: 183 ]]
    local l__lastSubjectCFrame__13 = p9.lastSubjectCFrame;
    local l__CurrentCamera__14 = workspace.CurrentCamera;
    if l__CurrentCamera__14 then
        l__CurrentCamera__14 = l__CurrentCamera__14.CameraSubject;
    end;
    if not l__CurrentCamera__14 then
        return l__lastSubjectCFrame__13;
    end;
    if l__CurrentCamera__14:IsA("Humanoid") then
        local v10 = l__CurrentCamera__14:GetState() == Enum.HumanoidStateType.Dead;
        local l__CameraOffset__15 = l__CurrentCamera__14.CameraOffset;
        if p9:GetIsMouseLocked() then
            l__CameraOffset__15 = Vector3.new();
        end;
        local l__RootPart__16 = l__CurrentCamera__14.RootPart;
        if v10 and (l__CurrentCamera__14.Parent and l__CurrentCamera__14.Parent:IsA("Model")) then
            l__RootPart__16 = l__CurrentCamera__14.Parent:FindFirstChild("Head") or l__RootPart__16;
        end;
        if l__RootPart__16 and l__RootPart__16:IsA("BasePart") then
            local v11;
            if l__CurrentCamera__14.RigType == Enum.HumanoidRigType.R15 then
                if l__CurrentCamera__14.AutomaticScalingEnabled then
                    v11 = Vector3.new(0, 1.5, 0);
                    local l__RootPart__17 = l__CurrentCamera__14.RootPart;
                    if l__RootPart__16 == l__RootPart__17 then
                        v11 = v11 + Vector3.new(0, (l__RootPart__17.Size.Y - 2) / 2, 0);
                    end;
                else
                    v11 = Vector3.new(0, 2, 0);
                end;
            else
                v11 = Vector3.new(0, 1.5, 0);
            end;
            l__lastSubjectCFrame__13 = l__RootPart__16.CFrame * CFrame.new((v10 and Vector3.new(0, 0, 0) or v11) + l__CameraOffset__15);
        end;
    elseif l__CurrentCamera__14:IsA("BasePart") then
        l__lastSubjectCFrame__13 = l__CurrentCamera__14.CFrame;
    elseif l__CurrentCamera__14:IsA("Model") then
        if l__CurrentCamera__14.PrimaryPart then
            l__lastSubjectCFrame__13 = l__CurrentCamera__14:GetPrimaryPartCFrame();
        else
            l__lastSubjectCFrame__13 = CFrame.new();
        end;
    end;
    if l__lastSubjectCFrame__13 then
        p9.lastSubjectCFrame = l__lastSubjectCFrame__13;
    end;
    return l__lastSubjectCFrame__13;
end;
function u1.GetSubjectVelocity(_) --[[ Line: 257 ]]
    local l__CurrentCamera__18 = workspace.CurrentCamera;
    if l__CurrentCamera__18 then
        l__CurrentCamera__18 = l__CurrentCamera__18.CameraSubject;
    end;
    if not l__CurrentCamera__18 then
        return Vector3.new(0, 0, 0);
    end;
    if l__CurrentCamera__18:IsA("BasePart") then
        return l__CurrentCamera__18.Velocity;
    end;
    if l__CurrentCamera__18:IsA("Humanoid") then
        local l__RootPart__19 = l__CurrentCamera__18.RootPart;
        if l__RootPart__19 then
            return l__RootPart__19.Velocity;
        end;
    else
        local v12 = l__CurrentCamera__18:IsA("Model") and l__CurrentCamera__18.PrimaryPart;
        if v12 then
            return v12.Velocity;
        end;
    end;
    return Vector3.new(0, 0, 0);
end;
function u1.GetSubjectRotVelocity(_) --[[ Line: 286 ]]
    local l__CurrentCamera__20 = workspace.CurrentCamera;
    if l__CurrentCamera__20 then
        l__CurrentCamera__20 = l__CurrentCamera__20.CameraSubject;
    end;
    if not l__CurrentCamera__20 then
        return Vector3.new(0, 0, 0);
    end;
    if l__CurrentCamera__20:IsA("BasePart") then
        return l__CurrentCamera__20.RotVelocity;
    end;
    if l__CurrentCamera__20:IsA("Humanoid") then
        local l__RootPart__21 = l__CurrentCamera__20.RootPart;
        if l__RootPart__21 then
            return l__RootPart__21.RotVelocity;
        end;
    else
        local v13 = l__CurrentCamera__20:IsA("Model") and l__CurrentCamera__20.PrimaryPart;
        if v13 then
            return v13.RotVelocity;
        end;
    end;
    return Vector3.new(0, 0, 0);
end;
function u1.StepZoom(p14) --[[ Line: 315 ]]
    -- upvalues: l__CameraInput__9 (copy), l__ZoomController__7 (copy)
    local l__currentSubjectDistance__22 = p14.currentSubjectDistance;
    local v15 = l__CameraInput__9.getZoomDelta();
    if math.abs(v15) > 0 then
        local v16;
        if v15 > 0 then
            v16 = math.max(l__currentSubjectDistance__22 + v15 * (l__currentSubjectDistance__22 * 0.5 + 1), p14.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v16 = math.max((l__currentSubjectDistance__22 + v15) / (1 - v15 * 0.5), 0.5);
        end;
        p14:SetCameraToSubjectDistance(v16 < p14.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v16);
    end;
    return l__ZoomController__7.GetZoomRadius();
end;
function u1.GetSubjectPosition(p17) --[[ Line: 340 ]]
    local l__lastSubjectPosition__23 = p17.lastSubjectPosition;
    local l__CurrentCamera__24 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__24 then
        l__CurrentCamera__24 = l__CurrentCamera__24.CameraSubject;
    end;
    if not l__CurrentCamera__24 then
        return nil;
    end;
    if l__CurrentCamera__24:IsA("Humanoid") then
        local v18 = l__CurrentCamera__24:GetState() == Enum.HumanoidStateType.Dead;
        local l__CameraOffset__25 = l__CurrentCamera__24.CameraOffset;
        if p17:GetIsMouseLocked() then
            l__CameraOffset__25 = Vector3.new();
        end;
        local l__RootPart__26 = l__CurrentCamera__24.RootPart;
        if v18 and (l__CurrentCamera__24.Parent and l__CurrentCamera__24.Parent:IsA("Model")) then
            l__RootPart__26 = l__CurrentCamera__24.Parent:FindFirstChild("Head") or l__RootPart__26;
        end;
        if l__RootPart__26 and l__RootPart__26:IsA("BasePart") then
            local v19;
            if l__CurrentCamera__24.RigType == Enum.HumanoidRigType.R15 then
                if l__CurrentCamera__24.AutomaticScalingEnabled then
                    v19 = Vector3.new(0, 1.5, 0);
                    if l__RootPart__26 == l__CurrentCamera__24.RootPart then
                        v19 = v19 + Vector3.new(0, l__CurrentCamera__24.RootPart.Size.Y / 2 - 1, 0);
                    end;
                else
                    v19 = Vector3.new(0, 2, 0);
                end;
            else
                v19 = Vector3.new(0, 1.5, 0);
            end;
            l__lastSubjectPosition__23 = l__RootPart__26.CFrame.p + l__RootPart__26.CFrame:vectorToWorldSpace((v18 and Vector3.new(0, 0, 0) or v19) + l__CameraOffset__25);
        end;
    elseif l__CurrentCamera__24:IsA("VehicleSeat") then
        l__lastSubjectPosition__23 = l__CurrentCamera__24.CFrame.p + l__CurrentCamera__24.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0));
    elseif l__CurrentCamera__24:IsA("SkateboardPlatform") then
        l__lastSubjectPosition__23 = l__CurrentCamera__24.CFrame.p + Vector3.new(0, 5, 0);
    elseif l__CurrentCamera__24:IsA("BasePart") then
        l__lastSubjectPosition__23 = l__CurrentCamera__24.CFrame.p;
    elseif l__CurrentCamera__24:IsA("Model") then
        if l__CurrentCamera__24.PrimaryPart then
            l__lastSubjectPosition__23 = l__CurrentCamera__24:GetPrimaryPartCFrame().p;
        else
            l__lastSubjectPosition__23 = l__CurrentCamera__24:GetModelCFrame().p;
        end;
    end;
    p17.lastSubject = l__CurrentCamera__24;
    p17.lastSubjectPosition = l__lastSubjectPosition__23;
    return l__lastSubjectPosition__23;
end;
function u1.OnCurrentCameraChanged(u20) --[[ Line: 418 ]]
    if u20.cameraSubjectChangedConn then
        u20.cameraSubjectChangedConn:Disconnect();
        u20.cameraSubjectChangedConn = nil;
    end;
    local l__CurrentCamera__27 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__27 then
        u20.cameraSubjectChangedConn = l__CurrentCamera__27:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 427 ]]
            -- upvalues: u20 (copy)
            u20:OnNewCameraSubject();
        end);
        u20:OnNewCameraSubject();
    end;
end;
function u1.OnPlayerCameraPropertyChange(p21) --[[ Line: 434 ]]
    p21:SetCameraToSubjectDistance(p21.currentSubjectDistance);
end;
function u1.InputTranslationToCameraAngleChange(_, p22, p23) --[[ Line: 439 ]]
    return p22 * p23;
end;
function u1.GamepadZoomPress(p24) --[[ Line: 445 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    local v25 = p24:GetCameraToSubjectDistance();
    local l__CameraMaxZoomDistance__28 = l__LocalPlayer__11.CameraMaxZoomDistance;
    for v26 = #p24.gamepadZoomLevels, 1, -1 do
        local v27 = p24.gamepadZoomLevels[v26];
        if l__CameraMaxZoomDistance__28 >= v27 then
            if v27 < l__LocalPlayer__11.CameraMinZoomDistance then
                v27 = l__LocalPlayer__11.CameraMinZoomDistance;
                if l__CameraMaxZoomDistance__28 == v27 then
                    break;
                end;
            end;
            if v27 + (l__CameraMaxZoomDistance__28 - v27) / 2 < v25 then
                p24:SetCameraToSubjectDistance(v27);
                return;
            end;
            l__CameraMaxZoomDistance__28 = v27;
        end;
    end;
    p24:SetCameraToSubjectDistance(p24.gamepadZoomLevels[#p24.gamepadZoomLevels]);
end;
function u1.Enable(p28, p29) --[[ Line: 482 ]]
    if p28.enabled ~= p29 then
        p28.enabled = p29;
        p28:OnEnabledChanged();
    end;
end;
function u1.OnEnabledChanged(u30) --[[ Line: 490 ]]
    -- upvalues: l__CameraInput__9 (copy), l__LocalPlayer__11 (copy)
    if u30.enabled then
        u30:_setUpConfigurations();
        l__CameraInput__9.setInputEnabled(true);
        u30.gamepadZoomPressConnection = l__CameraInput__9.gamepadZoomPress:Connect(function() --[[ Line: 496 ]]
            -- upvalues: u30 (copy)
            u30:GamepadZoomPress();
        end);
        if l__LocalPlayer__11.CameraMode == Enum.CameraMode.LockFirstPerson then
            u30.currentSubjectDistance = 0.5;
            if not u30.inFirstPerson then
                u30:EnterFirstPerson();
            end;
        end;
        if u30.cameraChangedConn then
            u30.cameraChangedConn:Disconnect();
            u30.cameraChangedConn = nil;
        end;
        u30.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 508 ]]
            -- upvalues: u30 (copy)
            u30:OnCurrentCameraChanged();
        end);
        u30:OnCurrentCameraChanged();
    else
        u30._connections:disconnectAll();
        l__CameraInput__9.setInputEnabled(false);
        if u30.gamepadZoomPressConnection then
            u30.gamepadZoomPressConnection:Disconnect();
            u30.gamepadZoomPressConnection = nil;
        end;
        u30:Cleanup();
    end;
end;
function u1.GetEnabled(p31) --[[ Line: 526 ]]
    return p31.enabled;
end;
function u1.Cleanup(p32) --[[ Line: 530 ]]
    -- upvalues: l__CameraUtils__6 (copy)
    if p32.subjectStateChangedConn then
        p32.subjectStateChangedConn:Disconnect();
        p32.subjectStateChangedConn = nil;
    end;
    if p32.cameraChangedConn then
        p32.cameraChangedConn:Disconnect();
        p32.cameraChangedConn = nil;
    end;
    p32.lastCameraTransform = nil;
    p32.lastSubjectCFrame = nil;
    l__CameraUtils__6.restoreMouseBehavior();
end;
function u1.UpdateMouseBehavior(p33) --[[ Line: 547 ]]
    -- upvalues: l__UserGameSettings__3 (copy), l__CameraUI__10 (copy), l__CameraInput__9 (copy), l__CameraToggleStateController__8 (copy), l__CameraUtils__6 (copy)
    if p33.isCameraToggle and l__UserGameSettings__3.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
        l__CameraUI__10.setCameraModeToastEnabled(true);
        l__CameraInput__9.enableCameraToggleInput();
        l__CameraToggleStateController__8(p33.inFirstPerson);
    else
        l__CameraUI__10.setCameraModeToastEnabled(false);
        l__CameraInput__9.disableCameraToggleInput();
        if p33.inFirstPerson or p33.inMouseLockedMode then
            l__CameraUtils__6.setRotationTypeOverride(Enum.RotationType.CameraRelative);
            l__CameraUtils__6.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);
        else
            l__CameraUtils__6.restoreRotationType();
            if l__CameraInput__9.getRotationActivated() then
                l__CameraUtils__6.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);
            else
                l__CameraUtils__6.restoreMouseBehavior();
            end;
        end;
    end;
end;
function u1.UpdateForDistancePropertyChange(p34) --[[ Line: 575 ]]
    p34:SetCameraToSubjectDistance(p34.currentSubjectDistance);
end;
function u1.SetCameraToSubjectDistance(p35, p36) --[[ Line: 581 ]]
    -- upvalues: l__LocalPlayer__11 (copy), l__ZoomController__7 (copy)
    local l__currentSubjectDistance__29 = p35.currentSubjectDistance;
    if l__LocalPlayer__11.CameraMode == Enum.CameraMode.LockFirstPerson then
        p35.currentSubjectDistance = 0.5;
        if not p35.inFirstPerson then
            p35:EnterFirstPerson();
        end;
    else
        local v37 = math.clamp(p36, l__LocalPlayer__11.CameraMinZoomDistance, l__LocalPlayer__11.CameraMaxZoomDistance);
        if v37 < 1 then
            p35.currentSubjectDistance = 0.5;
            if not p35.inFirstPerson then
                p35:EnterFirstPerson();
            end;
        else
            p35.currentSubjectDistance = v37;
            if p35.inFirstPerson then
                p35:LeaveFirstPerson();
            end;
        end;
    end;
    l__ZoomController__7.SetZoomParameters(p35.currentSubjectDistance, (math.sign(p36 - l__currentSubjectDistance__29)));
    return p35.currentSubjectDistance;
end;
function u1.SetCameraType(p38, p39) --[[ Line: 615 ]]
    p38.cameraType = p39;
end;
function u1.GetCameraType(p40) --[[ Line: 620 ]]
    return p40.cameraType;
end;
function u1.SetCameraMovementMode(p41, p42) --[[ Line: 625 ]]
    p41.cameraMovementMode = p42;
end;
function u1.GetCameraMovementMode(p43) --[[ Line: 629 ]]
    return p43.cameraMovementMode;
end;
function u1.SetIsMouseLocked(p44, p45) --[[ Line: 633 ]]
    p44.inMouseLockedMode = p45;
end;
function u1.GetIsMouseLocked(p46) --[[ Line: 637 ]]
    return p46.inMouseLockedMode;
end;
function u1.SetMouseLockOffset(p47, p48) --[[ Line: 641 ]]
    p47.mouseLockOffset = p48;
end;
function u1.GetMouseLockOffset(p49) --[[ Line: 645 ]]
    return p49.mouseLockOffset;
end;
function u1.InFirstPerson(p50) --[[ Line: 649 ]]
    return p50.inFirstPerson;
end;
function u1.EnterFirstPerson(p51) --[[ Line: 653 ]]
    p51.inFirstPerson = true;
    p51:UpdateMouseBehavior();
end;
function u1.LeaveFirstPerson(p52) --[[ Line: 658 ]]
    p52.inFirstPerson = false;
    p52:UpdateMouseBehavior();
end;
function u1.GetCameraToSubjectDistance(p53) --[[ Line: 664 ]]
    return p53.currentSubjectDistance;
end;
function u1.GetMeasuredDistanceToFocus(_) --[[ Line: 671 ]]
    local l__CurrentCamera__30 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__30 then
        return (l__CurrentCamera__30.CoordinateFrame.p - l__CurrentCamera__30.Focus.p).magnitude;
    else
        return nil;
    end;
end;
function u1.GetCameraLookVector(_) --[[ Line: 679 ]]
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
end;
function u1.CalculateNewLookCFrameFromArg(p54, p55, p56) --[[ Line: 683 ]]
    local v57 = p55 or p54:GetCameraLookVector();
    local v58 = math.asin(v57.Y);
    local v59 = math.clamp(p56.Y, v58 + -1.3962634015954636, v58 + 1.3962634015954636);
    local v60 = Vector2.new(p56.X, v59);
    local v61 = CFrame.new(Vector3.new(0, 0, 0), v57);
    return CFrame.Angles(0, -v60.X, 0) * v61 * CFrame.Angles(-v60.Y, 0, 0);
end;
function u1.CalculateNewLookVectorFromArg(p62, p63, p64) --[[ Line: 693 ]]
    return p62:CalculateNewLookCFrameFromArg(p63, p64).LookVector;
end;
function u1.CalculateNewLookVectorVRFromArg(p65, p66) --[[ Line: 698 ]]
    local l__unit__31 = ((p65:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local v67 = Vector2.new(p66.X, 0);
    local v68 = CFrame.new(Vector3.new(0, 0, 0), l__unit__31);
    return ((CFrame.Angles(0, -v67.X, 0) * v68 * CFrame.Angles(-v67.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit;
end;
function u1.GetHumanoid(p69) --[[ Line: 708 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    local v70 = l__LocalPlayer__11;
    if v70 then
        v70 = l__LocalPlayer__11.Character;
    end;
    if not v70 then
        return nil;
    end;
    local v71 = p69.humanoidCache[l__LocalPlayer__11];
    if v71 and v71.Parent == v70 then
        return v71;
    end;
    p69.humanoidCache[l__LocalPlayer__11] = nil;
    local v72 = v70:FindFirstChildOfClass("Humanoid");
    if v72 then
        p69.humanoidCache[l__LocalPlayer__11] = v72;
    end;
    return v72;
end;
function u1.GetHumanoidPartToFollow(_, p73, p74) --[[ Line: 726 ]]
    if p74 == Enum.HumanoidStateType.Dead then
        local l__Parent__32 = p73.Parent;
        if l__Parent__32 then
            return l__Parent__32:FindFirstChild("Head") or p73.Torso;
        else
            return p73.Torso;
        end;
    else
        return p73.Torso;
    end;
end;
function u1.OnNewCameraSubject(p75) --[[ Line: 740 ]]
    if p75.subjectStateChangedConn then
        p75.subjectStateChangedConn:Disconnect();
        p75.subjectStateChangedConn = nil;
    end;
end;
function u1.IsInFirstPerson(p76) --[[ Line: 747 ]]
    return p76.inFirstPerson;
end;
function u1.Update(_, _) --[[ Line: 751 ]]
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;
function u1.GetCameraHeight(p77) --[[ Line: 755 ]]
    -- upvalues: l__VRService__2 (copy)
    return (not l__VRService__2.VREnabled or p77.inFirstPerson) and 0 or 0.25881904510252074 * p77.currentSubjectDistance;
end;
return u1;