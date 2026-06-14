-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock"
};
local u3 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode"
};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__VRService__4 = game:GetService("VRService");
local l__UserGameSettings__5 = UserSettings():GetService("UserGameSettings");
local l__CommonUtils__6 = script.Parent:WaitForChild("CommonUtils");
local l__ConnectionUtil__7 = require(l__CommonUtils__6:WaitForChild("ConnectionUtil"));
local l__FlagUtil__8 = require(l__CommonUtils__6:WaitForChild("FlagUtil"));
local l__CameraUtils__9 = require(script:WaitForChild("CameraUtils"));
local l__CameraInput__10 = require(script:WaitForChild("CameraInput"));
local l__ClassicCamera__11 = require(script:WaitForChild("ClassicCamera"));
local l__OrbitalCamera__12 = require(script:WaitForChild("OrbitalCamera"));
local l__LegacyCamera__13 = require(script:WaitForChild("LegacyCamera"));
local l__VehicleCamera__14 = require(script:WaitForChild("VehicleCamera"));
local l__VRCamera__15 = require(script:WaitForChild("VRCamera"));
local l__VRVehicleCamera__16 = require(script:WaitForChild("VRVehicleCamera"));
local l__Invisicam__17 = require(script:WaitForChild("Invisicam"));
local l__Poppercam__18 = require(script:WaitForChild("Poppercam"));
local l__TransparencyController__19 = require(script:WaitForChild("TransparencyController"));
local l__MouseLockController__20 = require(script:WaitForChild("MouseLockController"));
local u4 = {};
local u5 = {};
if not l__Players__1.LocalPlayer then
    return {};
end;
assert(l__Players__1.LocalPlayer, "Strict typing check");
local l__PlayerScripts__21 = l__Players__1.LocalPlayer:WaitForChild("PlayerScripts");
l__PlayerScripts__21:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
l__PlayerScripts__21:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
l__PlayerScripts__21:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
l__PlayerScripts__21:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
l__PlayerScripts__21:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
l__PlayerScripts__21:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
l__PlayerScripts__21:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
local u6 = l__FlagUtil__8.getUserFlag("UserPlayerConnectionMemoryLeak");
local u7 = l__FlagUtil__8.getUserFlag("UserPSFixCameraControllerReset");
function u1.new() --[[ Line: 144 ]]
    -- upvalues: l__TransparencyController__19 (copy), u6 (copy), l__ConnectionUtil__7 (copy), u1 (copy), l__Players__1 (copy), l__MouseLockController__20 (copy), l__RunService__2 (copy), u2 (copy), u3 (copy), l__UserGameSettings__5 (copy), l__UserInputService__3 (copy)
    local v8 = {
        activeTransparencyController = l__TransparencyController__19.new()
    };
    local v9;
    if u6 then
        v9 = l__ConnectionUtil__7.new();
    else
        v9 = nil;
    end;
    v8.connectionUtil = v9;
    local u10 = setmetatable(v8, u1);
    u10.activeCameraController = nil;
    u10.activeOcclusionModule = nil;
    u10.activeMouseLockController = nil;
    u10.currentComputerCameraMovementMode = nil;
    u10.cameraSubjectChangedConn = nil;
    u10.cameraTypeChangedConn = nil;
    for _, v11 in pairs(l__Players__1:GetPlayers()) do
        u10:OnPlayerAdded(v11);
    end;
    l__Players__1.PlayerAdded:Connect(function(p12) --[[ Line: 167 ]]
        -- upvalues: u10 (copy)
        u10:OnPlayerAdded(p12);
    end);
    if u6 then
        l__Players__1.PlayerRemoving:Connect(function(p13) --[[ Line: 172 ]]
            -- upvalues: u10 (copy)
            u10:OnPlayerRemoving(p13);
        end);
    end;
    u10.activeTransparencyController:Enable(true);
    u10.activeMouseLockController = l__MouseLockController__20.new();
    assert(u10.activeMouseLockController, "Strict typing check");
    local v14 = u10.activeMouseLockController:GetBindableToggleEvent();
    if v14 then
        v14:Connect(function() --[[ Line: 184 ]]
            -- upvalues: u10 (copy)
            u10:OnMouseLockToggled();
        end);
    end;
    u10:ActivateCameraController();
    u10:ActivateOcclusionModule(l__Players__1.LocalPlayer.DevCameraOcclusionMode);
    u10:OnCurrentCameraChanged();
    l__RunService__2:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p15) --[[ Line: 192 ]]
        -- upvalues: u10 (copy)
        u10:Update(p15);
    end);
    for _, u16 in pairs(u2) do
        l__Players__1.LocalPlayer:GetPropertyChangedSignal(u16):Connect(function() --[[ Line: 196 ]]
            -- upvalues: u10 (copy), u16 (copy)
            u10:OnLocalPlayerCameraPropertyChanged(u16);
        end);
    end;
    for _, u17 in pairs(u3) do
        l__UserGameSettings__5:GetPropertyChangedSignal(u17):Connect(function() --[[ Line: 202 ]]
            -- upvalues: u10 (copy), u17 (copy)
            u10:OnUserGameSettingsPropertyChanged(u17);
        end);
    end;
    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 206 ]]
        -- upvalues: u10 (copy)
        u10:OnCurrentCameraChanged();
    end);
    l__UserInputService__3:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 209 ]]
        -- upvalues: u10 (copy)
        u10:OnPreferredInputChanged();
    end);
    return u10;
end;
function u1.GetCameraMovementModeFromSettings(_) --[[ Line: 216 ]]
    -- upvalues: l__Players__1 (copy), l__CameraUtils__9 (copy), l__UserInputService__3 (copy), l__UserGameSettings__5 (copy)
    if l__Players__1.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return l__CameraUtils__9.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    else
        local v18, v19;
        if l__UserInputService__3.PreferredInput == Enum.PreferredInput.Touch then
            v18 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__Players__1.LocalPlayer.DevTouchCameraMode);
            v19 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__UserGameSettings__5.TouchCameraMovementMode);
        else
            v18 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__Players__1.LocalPlayer.DevComputerCameraMode);
            v19 = l__CameraUtils__9.ConvertCameraModeEnumToStandard(l__UserGameSettings__5.ComputerCameraMovementMode);
        end;
        if v18 == Enum.DevComputerCameraMovementMode.UserChoice then
            return v19;
        else
            return v18;
        end;
    end;
end;
function u1.ActivateOcclusionModule(p20, p21) --[[ Line: 241 ]]
    -- upvalues: l__Poppercam__18 (copy), l__Invisicam__17 (copy), u5 (copy), l__Players__1 (copy)
    local v22;
    if p21 == Enum.DevCameraOcclusionMode.Zoom then
        v22 = l__Poppercam__18;
    else
        if p21 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");
            return;
        end;
        v22 = l__Invisicam__17;
    end;
    p20.occlusionMode = p21;
    if p20.activeOcclusionModule and p20.activeOcclusionModule:GetOcclusionMode() == p21 then
        if not p20.activeOcclusionModule:GetEnabled() then
            p20.activeOcclusionModule:Enable(true);
        end;
    else
        local l__activeOcclusionModule__22 = p20.activeOcclusionModule;
        p20.activeOcclusionModule = u5[v22];
        if not p20.activeOcclusionModule then
            p20.activeOcclusionModule = v22.new();
            if p20.activeOcclusionModule then
                u5[v22] = p20.activeOcclusionModule;
            end;
        end;
        if p20.activeOcclusionModule then
            if p20.activeOcclusionModule:GetOcclusionMode() ~= p21 then
                warn("CameraScript ActivateOcclusionModule mismatch: ", p20.activeOcclusionModule:GetOcclusionMode(), "~=", p21);
            end;
            if l__activeOcclusionModule__22 then
                if l__activeOcclusionModule__22 == p20.activeOcclusionModule then
                    warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
                else
                    l__activeOcclusionModule__22:Enable(false);
                end;
            end;
            if p21 == Enum.DevCameraOcclusionMode.Invisicam then
                if l__Players__1.LocalPlayer.Character then
                    p20.activeOcclusionModule:CharacterAdded(l__Players__1.LocalPlayer.Character, l__Players__1.LocalPlayer);
                end;
            else
                for _, v23 in pairs(l__Players__1:GetPlayers()) do
                    if v23 and v23.Character then
                        p20.activeOcclusionModule:CharacterAdded(v23.Character, v23);
                    end;
                end;
                p20.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
            end;
            p20.activeOcclusionModule:Enable(true);
        end;
    end;
end;
function u1.ShouldUseVehicleCamera(p24) --[[ Line: 320 ]]
    local l__CurrentCamera__23 = workspace.CurrentCamera;
    if not l__CurrentCamera__23 then
        return false;
    end;
    local l__CameraType__24 = l__CurrentCamera__23.CameraType;
    local l__CameraSubject__25 = l__CurrentCamera__23.CameraSubject;
    local v25 = l__CameraType__24 == Enum.CameraType.Custom and true or l__CameraType__24 == Enum.CameraType.Follow;
    local v26 = l__CameraSubject__25 and l__CameraSubject__25:IsA("VehicleSeat") or false;
    local v27 = p24.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;
    if v26 then
        if not v25 then
            v27 = v25;
        end;
    else
        v27 = v26;
    end;
    return v27;
end;
function u1.ActivateCameraController(p28) --[[ Line: 336 ]]
    -- upvalues: l__LegacyCamera__13 (copy), l__VRService__4 (copy), l__VRCamera__15 (copy), l__ClassicCamera__11 (copy), l__OrbitalCamera__12 (copy), l__VRVehicleCamera__16 (copy), l__VehicleCamera__14 (copy), u4 (copy), u7 (copy)
    local l__CameraType__26 = workspace.CurrentCamera.CameraType;
    local v29 = p28:GetCameraMovementModeFromSettings();
    local v30 = nil;
    if l__CameraType__26 == Enum.CameraType.Scriptable then
        if p28.activeCameraController then
            p28.activeCameraController:Enable(false);
            p28.activeCameraController = nil;
        end;
    else
        if l__CameraType__26 == Enum.CameraType.Custom then
            v29 = p28:GetCameraMovementModeFromSettings();
        elseif l__CameraType__26 == Enum.CameraType.Track then
            v29 = Enum.ComputerCameraMovementMode.Classic;
        elseif l__CameraType__26 == Enum.CameraType.Follow then
            v29 = Enum.ComputerCameraMovementMode.Follow;
        elseif l__CameraType__26 == Enum.CameraType.Orbital then
            v29 = Enum.ComputerCameraMovementMode.Orbital;
        elseif l__CameraType__26 == Enum.CameraType.Attach or (l__CameraType__26 == Enum.CameraType.Watch or l__CameraType__26 == Enum.CameraType.Fixed) then
            v30 = l__LegacyCamera__13;
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", l__CameraType__26);
        end;
        if not v30 then
            if l__VRService__4.VREnabled then
                v30 = l__VRCamera__15;
            elseif v29 == Enum.ComputerCameraMovementMode.Classic or (v29 == Enum.ComputerCameraMovementMode.Follow or (v29 == Enum.ComputerCameraMovementMode.Default or v29 == Enum.ComputerCameraMovementMode.CameraToggle)) then
                v30 = l__ClassicCamera__11;
            else
                if v29 ~= Enum.ComputerCameraMovementMode.Orbital then
                    warn("ActivateCameraController did not select a module.");
                    return;
                end;
                v30 = l__OrbitalCamera__12;
            end;
        end;
        if p28:ShouldUseVehicleCamera() then
            if l__VRService__4.VREnabled then
                v30 = l__VRVehicleCamera__16;
            else
                v30 = l__VehicleCamera__14;
            end;
        end;
        local v31;
        if u4[v30] then
            v31 = u4[v30];
            if u7 then
                if v31.Reset and p28.activeCameraController ~= v31 then
                    v31:Reset();
                end;
            elseif v31.Reset then
                v31:Reset();
            end;
        else
            v31 = v30.new();
            u4[v30] = v31;
        end;
        if p28.activeCameraController then
            if p28.activeCameraController == v31 then
                if not p28.activeCameraController:GetEnabled() then
                    p28.activeCameraController:Enable(true);
                end;
            else
                p28.activeCameraController:Enable(false);
                p28.activeCameraController = v31;
                p28.activeCameraController:Enable(true);
            end;
        elseif v31 ~= nil then
            p28.activeCameraController = v31;
            assert(p28.activeCameraController, "Strict typing check");
            p28.activeCameraController:Enable(true);
        end;
        if p28.activeCameraController then
            p28.activeCameraController:SetCameraMovementMode(v29);
            p28.activeCameraController:SetCameraType(l__CameraType__26);
        end;
    end;
end;
function u1.OnCameraSubjectChanged(p32) --[[ Line: 442 ]]
    local l__CurrentCamera__27 = workspace.CurrentCamera;
    local v33;
    if l__CurrentCamera__27 then
        v33 = l__CurrentCamera__27.CameraSubject;
    else
        v33 = nil;
    end;
    if p32.activeTransparencyController then
        p32.activeTransparencyController:SetSubject(v33);
    end;
    if p32.activeOcclusionModule then
        p32.activeOcclusionModule:OnCameraSubjectChanged(v33);
    end;
    p32:ActivateCameraController();
end;
function u1.OnCameraTypeChanged(p34, p35) --[[ Line: 457 ]]
    -- upvalues: l__UserInputService__3 (copy), l__CameraUtils__9 (copy)
    if p35 == Enum.CameraType.Scriptable and l__UserInputService__3.MouseBehavior == Enum.MouseBehavior.LockCenter then
        l__CameraUtils__9.restoreMouseBehavior();
    end;
    p34:ActivateCameraController();
end;
function u1.OnCurrentCameraChanged(u36) --[[ Line: 469 ]]
    local l__CurrentCamera__28 = game.Workspace.CurrentCamera;
    if l__CurrentCamera__28 then
        if u36.cameraSubjectChangedConn then
            u36.cameraSubjectChangedConn:Disconnect();
        end;
        if u36.cameraTypeChangedConn then
            u36.cameraTypeChangedConn:Disconnect();
        end;
        u36.cameraSubjectChangedConn = l__CurrentCamera__28:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 481 ]]
            -- upvalues: u36 (copy)
            u36:OnCameraSubjectChanged();
        end);
        u36.cameraTypeChangedConn = l__CurrentCamera__28:GetPropertyChangedSignal("CameraType"):Connect(function() --[[ Line: 485 ]]
            -- upvalues: u36 (copy), l__CurrentCamera__28 (copy)
            u36:OnCameraTypeChanged(l__CurrentCamera__28.CameraType);
        end);
        u36:OnCameraSubjectChanged();
        u36:OnCameraTypeChanged(l__CurrentCamera__28.CameraType);
    end;
end;
function u1.OnLocalPlayerCameraPropertyChanged(p37, p38) --[[ Line: 493 ]]
    -- upvalues: l__Players__1 (copy)
    if p38 == "CameraMode" then
        if l__Players__1.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if l__Players__1.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                p37:ActivateCameraController();
                return;
            else
                warn("Unhandled value for property player.CameraMode: ", l__Players__1.LocalPlayer.CameraMode);
                return;
            end;
        end;
        if not p37.activeCameraController or p37.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p37:ActivateCameraController();
        end;
        if p37.activeCameraController then
            p37.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p38 == "DevComputerCameraMode" or p38 == "DevTouchCameraMode" then
            p37:ActivateCameraController();
            return;
        end;
        if p38 == "DevCameraOcclusionMode" then
            p37:ActivateOcclusionModule(l__Players__1.LocalPlayer.DevCameraOcclusionMode);
            return;
        end;
        if p38 == "CameraMinZoomDistance" or p38 == "CameraMaxZoomDistance" then
            if p37.activeCameraController then
                p37.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p38 == "DevTouchMovementMode" then
                return;
            end;
            if p38 == "DevComputerMovementMode" then
                return;
            end;
            local _ = p38 == "DevEnableMouseLock";
        end;
    end;
end;
function u1.OnUserGameSettingsPropertyChanged(p39, p40) --[[ Line: 535 ]]
    if p40 == "ComputerCameraMovementMode" or p40 == "TouchCameraMovementMode" then
        p39:ActivateCameraController();
    end;
end;
function u1.OnPreferredInputChanged(p41) --[[ Line: 541 ]]
    p41:ActivateCameraController();
end;
function u1.Update(p42, p43) --[[ Line: 551 ]]
    -- upvalues: l__CameraInput__10 (copy)
    if p42.activeCameraController then
        p42.activeCameraController:UpdateMouseBehavior();
        local v44, v45 = p42.activeCameraController:Update(p43);
        if p42.activeOcclusionModule then
            v44, v45 = p42.activeOcclusionModule:Update(p43, v44, v45);
        end;
        local l__CurrentCamera__29 = game.Workspace.CurrentCamera;
        l__CurrentCamera__29.CFrame = v44;
        l__CurrentCamera__29.Focus = v45;
        if p42.activeTransparencyController then
            p42.activeTransparencyController:Update(p43);
        end;
        if l__CameraInput__10.getInputEnabled() then
            l__CameraInput__10.resetInputForFrameEnd();
        end;
    end;
end;
function u1.OnCharacterAdded(p46, p47, p48) --[[ Line: 577 ]]
    if p46.activeOcclusionModule then
        p46.activeOcclusionModule:CharacterAdded(p47, p48);
    end;
end;
function u1.OnCharacterRemoving(p49, p50, p51) --[[ Line: 583 ]]
    if p49.activeOcclusionModule then
        p49.activeOcclusionModule:CharacterRemoving(p50, p51);
    end;
end;
function u1.OnPlayerAdded(u52, u53) --[[ Line: 589 ]]
    -- upvalues: u6 (copy)
    if u6 then
        if u52.connectionUtil then
            u52.connectionUtil:trackConnection(`{u53.UserId}CharacterAdded`, u53.CharacterAdded:Connect(function(p54) --[[ Line: 593 ]]
                -- upvalues: u52 (copy), u53 (copy)
                u52:OnCharacterAdded(p54, u53);
            end));
            u52.connectionUtil:trackConnection(`{u53.UserId}CharacterRemoving`, u53.CharacterRemoving:Connect(function(p55) --[[ Line: 596 ]]
                -- upvalues: u52 (copy), u53 (copy)
                u52:OnCharacterRemoving(p55, u53);
            end));
        end;
    else
        u53.CharacterAdded:Connect(function(p56) --[[ Line: 601 ]]
            -- upvalues: u52 (copy), u53 (copy)
            u52:OnCharacterAdded(p56, u53);
        end);
        u53.CharacterRemoving:Connect(function(p57) --[[ Line: 604 ]]
            -- upvalues: u52 (copy), u53 (copy)
            u52:OnCharacterRemoving(p57, u53);
        end);
    end;
end;
function u1.OnPlayerRemoving(p58, p59) --[[ Line: 610 ]]
    if p58.connectionUtil then
        p58.connectionUtil:disconnect((`{p59.UserId}CharacterAdded`));
        p58.connectionUtil:disconnect((`{p59.UserId}CharacterRemoving`));
    end;
end;
function u1.OnMouseLockToggled(p60) --[[ Line: 618 ]]
    if p60.activeMouseLockController then
        local v61 = p60.activeMouseLockController:GetIsMouseLocked();
        local v62 = p60.activeMouseLockController:GetMouseLockOffset();
        if p60.activeCameraController then
            p60.activeCameraController:SetIsMouseLocked(v61);
            p60.activeCameraController:SetMouseLockOffset(v62);
        end;
    end;
end;
u1.new();
return {};