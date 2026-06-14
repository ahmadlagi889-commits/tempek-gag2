-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__GuiService__4 = game:GetService("GuiService");
local l__Workspace__5 = game:GetService("Workspace");
local l__UserGameSettings__6 = UserSettings():GetService("UserGameSettings");
local l__VRService__7 = game:GetService("VRService");
script.Parent:WaitForChild("CommonUtils");
local l__Keyboard__8 = require(script:WaitForChild("Keyboard"));
local l__Gamepad__9 = require(script:WaitForChild("Gamepad"));
local l__DynamicThumbstick__10 = require(script:WaitForChild("DynamicThumbstick"));
local v2, v3 = pcall(function() --[[ Line: 41 ]]
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
local u4 = v2 and v3;
local l__TouchThumbstick__11 = require(script:WaitForChild("TouchThumbstick"));
local l__ClickToMoveController__12 = require(script:WaitForChild("ClickToMoveController"));
local l__TouchJump__13 = require(script:WaitForChild("TouchJump"));
local l__VehicleController__14 = require(script:WaitForChild("VehicleController"));
local l__Value__15 = Enum.ContextActionPriority.Medium.Value;
local u5 = {
    [Enum.TouchMovementMode.DPad] = l__DynamicThumbstick__10,
    [Enum.DevTouchMovementMode.DPad] = l__DynamicThumbstick__10,
    [Enum.TouchMovementMode.Thumbpad] = l__DynamicThumbstick__10,
    [Enum.DevTouchMovementMode.Thumbpad] = l__DynamicThumbstick__10,
    [Enum.TouchMovementMode.Thumbstick] = l__TouchThumbstick__11,
    [Enum.DevTouchMovementMode.Thumbstick] = l__TouchThumbstick__11,
    [Enum.TouchMovementMode.DynamicThumbstick] = l__DynamicThumbstick__10,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = l__DynamicThumbstick__10,
    [Enum.TouchMovementMode.ClickToMove] = l__ClickToMoveController__12,
    [Enum.DevTouchMovementMode.ClickToMove] = l__ClickToMoveController__12,
    [Enum.TouchMovementMode.Default] = l__DynamicThumbstick__10,
    [Enum.ComputerMovementMode.Default] = l__Keyboard__8,
    [Enum.ComputerMovementMode.KeyboardMouse] = l__Keyboard__8,
    [Enum.DevComputerMovementMode.KeyboardMouse] = l__Keyboard__8,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = l__ClickToMoveController__12,
    [Enum.DevComputerMovementMode.ClickToMove] = l__ClickToMoveController__12
};
function u1.new() --[[ Line: 84 ]]
    -- upvalues: u1 (copy), l__Players__1 (copy), l__VehicleController__14 (copy), l__Value__15 (copy), l__RunService__2 (copy), l__UserGameSettings__6 (copy), l__GuiService__4 (copy), l__UserInputService__3 (copy)
    local u6 = setmetatable({}, u1);
    u6.controllers = {};
    u6.activeControlModule = nil;
    u6.activeController = nil;
    u6.touchJumpController = nil;
    u6.moveFunction = l__Players__1.LocalPlayer.Move;
    u6.humanoid = nil;
    u6.controlsEnabled = true;
    u6.humanoidSeatedConn = nil;
    u6.vehicleController = nil;
    u6.touchControlFrame = nil;
    u6.currentTorsoAngle = 0;
    u6.inputMoveVector = Vector3.new(0, 0, 0);
    u6.vehicleController = l__VehicleController__14.new(l__Value__15);
    l__Players__1.LocalPlayer.CharacterAdded:Connect(function(p7) --[[ Line: 109 ]]
        -- upvalues: u6 (copy)
        u6:OnCharacterAdded(p7);
    end);
    l__Players__1.LocalPlayer.CharacterRemoving:Connect(function(p8) --[[ Line: 110 ]]
        -- upvalues: u6 (copy)
        u6:OnCharacterRemoving(p8);
    end);
    if l__Players__1.LocalPlayer.Character then
        u6:OnCharacterAdded(l__Players__1.LocalPlayer.Character);
    end;
    l__RunService__2:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p9) --[[ Line: 115 ]]
        -- upvalues: u6 (copy)
        u6:OnRenderStepped(p9);
    end);
    l__UserGameSettings__6:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() --[[ Line: 119 ]]
        -- upvalues: u6 (copy)
        u6:UpdateMovementMode();
    end);
    l__Players__1.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() --[[ Line: 122 ]]
        -- upvalues: u6 (copy)
        u6:UpdateMovementMode();
    end);
    l__UserGameSettings__6:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() --[[ Line: 126 ]]
        -- upvalues: u6 (copy)
        u6:UpdateMovementMode();
    end);
    l__Players__1.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() --[[ Line: 129 ]]
        -- upvalues: u6 (copy)
        u6:UpdateMovementMode();
    end);
    u6.playerGui = nil;
    u6.touchGui = nil;
    u6.playerGuiAddedConn = nil;
    l__GuiService__4:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() --[[ Line: 138 ]]
        -- upvalues: u6 (copy)
        u6:UpdateMovementMode();
        u6:UpdateActiveControlModuleEnabled();
    end);
    l__UserInputService__3:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 143 ]]
        -- upvalues: u6 (copy)
        u6:UpdateMovementMode();
    end);
    u6.playerGui = l__Players__1.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    if not u6.playerGui then
        u6.playerGuiAddedConn = l__Players__1.LocalPlayer.ChildAdded:Connect(function(p10) --[[ Line: 149 ]]
            -- upvalues: u6 (copy)
            if p10:IsA("PlayerGui") then
                u6.playerGui = p10;
                u6.playerGuiAddedConn:Disconnect();
                u6.playerGuiAddedConn = nil;
                u6:UpdateMovementMode();
            end;
        end);
    end;
    u6:UpdateMovementMode();
    return u6;
end;
function u1.GetMoveVector(p11) --[[ Line: 167 ]]
    return not p11.activeController and Vector3.new(0, 0, 0) or p11.activeController:GetMoveVector();
end;
function u1.GetEstimatedVRTorsoFrame(p12) --[[ Line: 187 ]]
    -- upvalues: l__VRService__7 (copy)
    local v13 = l__VRService__7:GetUserCFrame(Enum.UserCFrame.Head);
    local _, v14, _ = v13:ToEulerAnglesYXZ();
    local v15 = -v14;
    if l__VRService__7:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and l__VRService__7:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local v16 = l__VRService__7:GetUserCFrame(Enum.UserCFrame.LeftHand);
        local v17 = l__VRService__7:GetUserCFrame(Enum.UserCFrame.RightHand);
        local v18 = v13.Position - v16.Position;
        local v19 = v13.Position - v17.Position;
        local v20 = -math.atan2(v18.X, v18.Z);
        local v21 = (-math.atan2(v19.X, v19.Z) - v20 + 12.566370614359172) % 6.283185307179586;
        if v21 > 3.141592653589793 then
            v21 = v21 - 6.283185307179586;
        end;
        local v22 = (v20 + v21 / 2 + 12.566370614359172) % 6.283185307179586;
        if v22 > 3.141592653589793 then
            v22 = v22 - 6.283185307179586;
        end;
        local v23 = (v15 - p12.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;
        if v23 > 3.141592653589793 then
            v23 = v23 - 6.283185307179586;
        end;
        local v24 = (v22 - p12.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;
        if v24 > 3.141592653589793 then
            v24 = v24 - 6.283185307179586;
        end;
        local v25;
        if v24 > -1.5707963267948966 then
            v25 = v24 < 1.5707963267948966;
        else
            v25 = false;
        end;
        if not v25 then
            v24 = v23;
        end;
        local v26 = math.min(v24, v23);
        local v27 = math.max(v24, v23);
        local v28 = 0;
        if v26 > 0 then
            v27 = v26;
        elseif v27 >= 0 then
            v27 = v28;
        end;
        p12.currentTorsoAngle = v27 + p12.currentTorsoAngle;
    else
        p12.currentTorsoAngle = v15;
    end;
    return CFrame.new(v13.Position) * CFrame.fromEulerAnglesYXZ(0, -p12.currentTorsoAngle, 0);
end;
function u1.GetActiveController(p29) --[[ Line: 231 ]]
    return p29.activeController;
end;
function u1.UpdateActiveControlModuleEnabled(u30) --[[ Line: 236 ]]
    -- upvalues: l__Players__1 (copy), l__UserInputService__3 (copy), l__ClickToMoveController__12 (copy), l__TouchThumbstick__11 (copy), l__DynamicThumbstick__10 (copy), l__TouchJump__13 (copy), l__GuiService__4 (copy)
    local function v31() --[[ Line: 249 ]]
        -- upvalues: u30 (copy), l__UserInputService__3 (ref), l__ClickToMoveController__12 (ref), l__TouchThumbstick__11 (ref), l__DynamicThumbstick__10 (ref), l__TouchJump__13 (ref), l__Players__1 (ref)
        if u30.touchControlFrame and (l__UserInputService__3.PreferredInput == Enum.PreferredInput.Touch and (u30.activeControlModule == l__ClickToMoveController__12 or (u30.activeControlModule == l__TouchThumbstick__11 or u30.activeControlModule == l__DynamicThumbstick__10))) then
            if not u30.controllers[l__TouchJump__13] then
                u30.controllers[l__TouchJump__13] = l__TouchJump__13.new();
            end;
            u30.touchJumpController = u30.controllers[l__TouchJump__13];
            u30.touchJumpController:Enable(true, u30.touchControlFrame);
        elseif u30.touchJumpController then
            u30.touchJumpController:Enable(false);
        end;
        if u30.activeControlModule == l__ClickToMoveController__12 then
            u30.activeController:Enable(true, l__Players__1.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, u30.touchJumpController);
        elseif u30.touchControlFrame then
            u30.activeController:Enable(true, u30.touchControlFrame);
        else
            u30.activeController:Enable(true);
        end;
    end;
    if u30.activeController then
        if u30.controlsEnabled then
            if l__GuiService__4.TouchControlsEnabled or (l__UserInputService__3.PreferredInput ~= Enum.PreferredInput.Touch or u30.activeControlModule ~= l__ClickToMoveController__12 and (u30.activeControlModule ~= l__TouchThumbstick__11 and u30.activeControlModule ~= l__DynamicThumbstick__10)) then
                v31();
            else
                u30.activeController:Enable(false);
                if u30.touchJumpController then
                    u30.touchJumpController:Enable(false);
                end;
                if u30.moveFunction then
                    u30.moveFunction(l__Players__1.LocalPlayer, Vector3.new(0, 0, 0), true);
                end;
            end;
        else
            u30.activeController:Enable(false);
            if u30.touchJumpController then
                u30.touchJumpController:Enable(false);
            end;
            if u30.moveFunction then
                u30.moveFunction(l__Players__1.LocalPlayer, Vector3.new(0, 0, 0), true);
            end;
        end;
    end;
end;
function u1.Enable(p32, p33) --[[ Line: 307 ]]
    local v34 = p33 == nil and true or p33;
    if p32.controlsEnabled == v34 then
    else
        p32.controlsEnabled = v34;
        if p32.activeController then
            p32:UpdateActiveControlModuleEnabled();
        end;
    end;
end;
function u1.Disable(p35) --[[ Line: 322 ]]
    p35:Enable(false);
end;
function u1.SelectComputerMovementModule(_) --[[ Line: 328 ]]
    -- upvalues: l__UserInputService__3 (copy), l__Players__1 (copy), l__Gamepad__9 (copy), l__Keyboard__8 (copy), l__UserGameSettings__6 (copy), l__ClickToMoveController__12 (copy), u5 (copy)
    if l__UserInputService__3.KeyboardEnabled or l__UserInputService__3.GamepadEnabled then
        local v36 = nil;
        local l__DevComputerMovementMode__16 = l__Players__1.LocalPlayer.DevComputerMovementMode;
        if l__DevComputerMovementMode__16 == Enum.DevComputerMovementMode.UserChoice then
            if l__UserInputService__3.PreferredInput == Enum.PreferredInput.Gamepad then
                v36 = l__Gamepad__9;
            elseif l__UserInputService__3.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
                v36 = l__Keyboard__8;
            end;
            if l__UserGameSettings__6.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v36 == l__Keyboard__8 then
                v36 = l__ClickToMoveController__12;
            end;
        else
            v36 = u5[l__DevComputerMovementMode__16];
            if not v36 and l__DevComputerMovementMode__16 ~= Enum.DevComputerMovementMode.Scriptable then
                warn("No character control module is associated with DevComputerMovementMode ", l__DevComputerMovementMode__16);
            end;
        end;
        if v36 then
            return v36, true;
        elseif l__DevComputerMovementMode__16 == Enum.DevComputerMovementMode.Scriptable then
            return nil, true;
        else
            return nil, false;
        end;
    else
        return nil, false;
    end;
end;
function u1.SelectTouchModule(_) --[[ Line: 371 ]]
    -- upvalues: l__Players__1 (copy), u5 (copy), l__UserGameSettings__6 (copy)
    local l__DevTouchMovementMode__17 = l__Players__1.LocalPlayer.DevTouchMovementMode;
    local v37;
    if l__DevTouchMovementMode__17 == Enum.DevTouchMovementMode.UserChoice then
        v37 = u5[l__UserGameSettings__6.TouchMovementMode];
    else
        if l__DevTouchMovementMode__17 == Enum.DevTouchMovementMode.Scriptable then
            return nil, true;
        end;
        v37 = u5[l__DevTouchMovementMode__17];
    end;
    return v37, true;
end;
local function u40() --[[ Line: 384 ]]
    -- upvalues: l__UserInputService__3 (copy)
    local v38 = l__UserInputService__3:GetGamepadState(Enum.UserInputType.Gamepad1);
    for _, v39 in pairs(v38) do
        if v39.KeyCode == Enum.KeyCode.Thumbstick2 then
            return v39.Position;
        end;
    end;
    return Vector3.new(0, 0, 0);
end;
function u1.calculateRawMoveVector(p41, p42, p43) --[[ Line: 394 ]]
    -- upvalues: l__Workspace__5 (copy), l__VRService__7 (copy), u40 (copy)
    local l__CurrentCamera__18 = l__Workspace__5.CurrentCamera;
    if not l__CurrentCamera__18 then
        return p43;
    end;
    local l__CFrame__19 = l__CurrentCamera__18.CFrame;
    if l__VRService__7.VREnabled and p42.RootPart then
        l__VRService__7:GetUserCFrame(Enum.UserCFrame.Head);
        local v44 = p41:GetEstimatedVRTorsoFrame();
        if (l__CurrentCamera__18.Focus.Position - l__CFrame__19.Position).Magnitude < 3 then
            l__CFrame__19 = l__CFrame__19 * v44;
        else
            l__CFrame__19 = l__CurrentCamera__18.CFrame * (v44.Rotation + v44.Position * l__CurrentCamera__18.HeadScale);
        end;
    end;
    if p42:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, _, _, v49, v46, v47, _, _, v48, _, _, v49 = l__CFrame__19:GetComponents();
        if v48 >= 1 or v48 <= -1 then
            v47 = -v46 * math.sign(v48);
        end;
        local v50 = math.sqrt(v49 * v49 + v47 * v47);
        return Vector3.new((v49 * p43.X + v47 * p43.Z) / v50, 0, (v49 * p43.Z - v47 * p43.X) / v50);
    end;
    if not l__VRService__7.VREnabled then
        return l__CFrame__19:VectorToWorldSpace(p43);
    end;
    local v51 = Vector3.new(p43.X, 0, p43.Z);
    if v51.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0);
    end;
    local v52 = -u40().Y * 1.3962634015954636;
    local v53 = math.atan2(-v51.X, -v51.Z);
    local _, v54, _ = l__CFrame__19:ToEulerAnglesYXZ();
    return CFrame.fromEulerAnglesYXZ(v52, v53 + v54, 0).LookVector;
end;
function u1.OnRenderStepped(p55, p56) --[[ Line: 453 ]]
    -- upvalues: l__Gamepad__9 (copy), l__VRService__7 (copy), l__Players__1 (copy)
    if p55.activeController and (p55.activeController.enabled and p55.humanoid) then
        local v57 = p55.activeController:GetMoveVector();
        local v58 = p55.activeController:IsMoveVectorCameraRelative();
        local v59 = p55:GetClickToMoveController();
        if p55.activeController == v59 then
            v59:OnRenderStepped(p56);
        elseif v57.magnitude > 0 then
            v59:CleanupPath();
        else
            v59:OnRenderStepped(p56);
            v57 = v59:GetMoveVector();
            v58 = v59:IsMoveVectorCameraRelative();
        end;
        if p55.vehicleController then
            local v60;
            v57, v60 = p55.vehicleController:Update(v57, v58, p55.activeControlModule == l__Gamepad__9);
        end;
        if v58 then
            v57 = p55:calculateRawMoveVector(p55.humanoid, v57);
        end;
        p55.inputMoveVector = v57;
        if l__VRService__7.VREnabled then
            v57 = p55:updateVRMoveVector(v57);
        end;
        p55.moveFunction(l__Players__1.LocalPlayer, v57, false);
        local l__humanoid__20 = p55.humanoid;
        local v61 = not p55.activeController:GetIsJumping() and p55.touchJumpController;
        if v61 then
            v61 = p55.touchJumpController:GetIsJumping();
        end;
        l__humanoid__20.Jump = v61;
    end;
end;
function u1.updateVRMoveVector(p62, p63) --[[ Line: 502 ]]
    -- upvalues: l__VRService__7 (copy)
    local l__CurrentCamera__21 = workspace.CurrentCamera;
    if p63.Magnitude ~= 0 or ((l__CurrentCamera__21.Focus.Position - l__CurrentCamera__21.CFrame.Position).Magnitude >= 5 or (not l__VRService__7.AvatarGestures or (not p62.humanoid or p62.humanoid.Sit))) then
        return p63;
    end;
    local v64 = l__VRService__7:GetUserCFrame(Enum.UserCFrame.Head);
    local v65 = (l__CurrentCamera__21.CFrame * (v64.Rotation + v64.Position * l__CurrentCamera__21.HeadScale) * CFrame.new(0, -0.7 * p62.humanoid.RootPart.Size.Y / 2, 0)).Position - p62.humanoid.RootPart.CFrame.Position;
    return Vector3.new(v65.x, 0, v65.z);
end;
function u1.OnHumanoidSeated(p66, p67, p68) --[[ Line: 527 ]]
    -- upvalues: l__Value__15 (copy)
    if p67 then
        if p68 and p68:IsA("VehicleSeat") then
            if not p66.vehicleController then
                p66.vehicleController = p66.vehicleController.new(l__Value__15);
            end;
            p66.vehicleController:Enable(true, p68);
        end;
    elseif p66.vehicleController then
        p66.vehicleController:Enable(false, p68);
    end;
end;
function u1.OnCharacterAdded(u69, p70) --[[ Line: 542 ]]
    u69.humanoid = p70:FindFirstChildOfClass("Humanoid");
    while not u69.humanoid do
        p70.ChildAdded:wait();
        u69.humanoid = p70:FindFirstChildOfClass("Humanoid");
    end;
    if u69.humanoidSeatedConn then
        u69.humanoidSeatedConn:Disconnect();
        u69.humanoidSeatedConn = nil;
    end;
    u69.humanoidSeatedConn = u69.humanoid.Seated:Connect(function(p71, p72) --[[ Line: 553 ]]
        -- upvalues: u69 (copy)
        u69:OnHumanoidSeated(p71, p72);
    end);
    u69:UpdateMovementMode();
end;
function u1.OnCharacterRemoving(p73, _) --[[ Line: 560 ]]
    p73.humanoid = nil;
    p73:UpdateMovementMode();
end;
function u1.UpdateTouchGuiVisibility(p74) --[[ Line: 566 ]]
    -- upvalues: l__GuiService__4 (copy), l__UserInputService__3 (copy)
    local v75 = p74.humanoid and l__GuiService__4.TouchControlsEnabled;
    if v75 then
        v75 = l__UserInputService__3.PreferredInput == Enum.PreferredInput.Touch;
    end;
    if v75 and not p74.touchGui then
        p74:CreateTouchGuiContainer();
    end;
    if p74.touchGui then
        p74.touchGui.Enabled = v75 and true or false;
    end;
end;
function u1.SwitchToController(p76, p77) --[[ Line: 585 ]]
    -- upvalues: l__Value__15 (copy)
    if p77 then
        if not p76.controllers[p77] then
            p76.controllers[p77] = p77.new(l__Value__15);
        end;
        if p76.activeController ~= p76.controllers[p77] then
            if p76.activeController then
                p76.activeController:Enable(false);
            end;
            p76.activeController = p76.controllers[p77];
            p76.activeControlModule = p77;
            p76:UpdateActiveControlModuleEnabled();
        end;
    else
        if p76.activeController then
            p76.activeController:Enable(false);
        end;
        p76.activeController = nil;
        p76.activeControlModule = nil;
    end;
end;
function u1.UpdateMovementMode(p78) --[[ Line: 624 ]]
    -- upvalues: l__UserInputService__3 (copy)
    p78:UpdateTouchGuiVisibility();
    if l__UserInputService__3.PreferredInput == Enum.PreferredInput.Touch then
        local v79, v80 = p78:SelectTouchModule();
        if v80 and p78.touchControlFrame then
            p78:SwitchToController(v79);
        end;
    else
        p78:SwitchToController((p78:SelectComputerMovementModule()));
    end;
end;
function u1.CreateTouchGuiContainer(p81) --[[ Line: 640 ]]
    -- upvalues: u4 (ref)
    if p81.playerGui then
        if p81.touchGui then
            p81.touchGui:Destroy();
        end;
        p81.touchGui = Instance.new("ScreenGui");
        p81.touchGui.Name = "TouchGui";
        p81.touchGui.ResetOnSpawn = false;
        p81.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        if u4 then
            p81.touchGui.ClipToDeviceSafeArea = false;
        end;
        p81.touchControlFrame = Instance.new("Frame");
        p81.touchControlFrame.Name = "TouchControlFrame";
        p81.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
        p81.touchControlFrame.BackgroundTransparency = 1;
        p81.touchControlFrame.Parent = p81.touchGui;
        p81.touchGui.Parent = p81.playerGui;
    end;
end;
function u1.GetClickToMoveController(p82) --[[ Line: 666 ]]
    -- upvalues: l__ClickToMoveController__12 (copy), l__Value__15 (copy)
    if not p82.controllers[l__ClickToMoveController__12] then
        p82.controllers[l__ClickToMoveController__12] = l__ClickToMoveController__12.new(l__Value__15);
    end;
    return p82.controllers[l__ClickToMoveController__12];
end;
return u1.new();