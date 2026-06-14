-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__VRService__2 = game:GetService("VRService");
UserSettings():GetService("UserGameSettings");
require(script.Parent:WaitForChild("CameraInput"));
require(script.Parent:WaitForChild("CameraUtils"));
local l__VRBaseCamera__3 = require(script.Parent:WaitForChild("VRBaseCamera"));
local u1 = setmetatable({}, l__VRBaseCamera__3);
u1.__index = u1;
function u1.new() --[[ Line: 28 ]]
    -- upvalues: l__VRBaseCamera__3 (copy), u1 (copy), l__Players__1 (copy)
    local v2 = l__VRBaseCamera__3.new();
    local v3 = setmetatable(v2, u1);
    v3.lastUpdate = tick();
    v3.focusOffset = CFrame.new();
    v3:Reset();
    v3.controlModule = require(l__Players__1.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"));
    v3.savedAutoRotate = true;
    return v3;
end;
function u1.Reset(p4) --[[ Line: 41 ]]
    -- upvalues: l__VRBaseCamera__3 (copy)
    p4.needsReset = true;
    p4.needsBlackout = true;
    p4.motionDetTime = 0;
    p4.blackOutTimer = 0;
    p4.lastCameraResetPosition = nil;
    l__VRBaseCamera__3.Reset(p4);
end;
function u1.Update(p5, p6) --[[ Line: 50 ]]
    -- upvalues: l__Players__1 (copy), l__VRService__2 (copy)
    local l__CurrentCamera__4 = workspace.CurrentCamera;
    local l__CFrame__5 = l__CurrentCamera__4.CFrame;
    local l__Focus__6 = l__CurrentCamera__4.Focus;
    local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
    p5:GetHumanoid();
    local _ = l__CurrentCamera__4.CameraSubject;
    if p5.lastUpdate == nil or p6 > 1 then
        p5.lastCameraTransform = nil;
    end;
    p5:UpdateFadeFromBlack(p6);
    p5:UpdateEdgeBlur(l__LocalPlayer__7, p6);
    local l__lastSubjectPosition__8 = p5.lastSubjectPosition;
    local v7 = p5:GetSubjectPosition();
    if p5.needsBlackout then
        p5:StartFadeFromBlack();
        local v8 = math.clamp(p6, 0.0001, 0.1);
        p5.blackOutTimer = p5.blackOutTimer + v8;
        if p5.blackOutTimer > 0.1 and game:IsLoaded() then
            p5.needsBlackout = false;
            p5.needsReset = true;
        end;
    end;
    if v7 and (l__LocalPlayer__7 and l__CurrentCamera__4) then
        local v9 = p5:GetVRFocus(v7, p6);
        if p5:IsInFirstPerson() then
            if l__VRService__2.AvatarGestures then
                l__CFrame__5, l__Focus__6 = p5:UpdateImmersionCamera(p6, l__CFrame__5, v9, l__lastSubjectPosition__8, v7);
            else
                l__CFrame__5, l__Focus__6 = p5:UpdateFirstPersonTransform(p6, l__CFrame__5, v9, l__lastSubjectPosition__8, v7);
            end;
        elseif l__VRService__2.ThirdPersonFollowCamEnabled then
            l__CFrame__5, l__Focus__6 = p5:UpdateThirdPersonFollowTransform(p6, l__CFrame__5, v9, l__lastSubjectPosition__8, v7);
        else
            l__CFrame__5, l__Focus__6 = p5:UpdateThirdPersonComfortTransform(p6, l__CFrame__5, v9, l__lastSubjectPosition__8, v7);
        end;
        p5.lastCameraTransform = l__CFrame__5;
        p5.lastCameraFocus = l__Focus__6;
    end;
    p5.lastUpdate = tick();
    return l__CFrame__5, l__Focus__6;
end;
function u1.GetAvatarFeetWorldYValue(_) --[[ Line: 112 ]]
    local l__CameraSubject__9 = workspace.CurrentCamera.CameraSubject;
    if not l__CameraSubject__9 then
        return nil;
    end;
    if not (l__CameraSubject__9:IsA("Humanoid") and l__CameraSubject__9.RootPart) then
        return nil;
    end;
    local l__RootPart__10 = l__CameraSubject__9.RootPart;
    return l__RootPart__10.Position.Y - l__RootPart__10.Size.Y / 2 - l__CameraSubject__9.HipHeight;
end;
function u1.UpdateFirstPersonTransform(p10, p11, _, p12, p13, p14) --[[ Line: 127 ]]
    -- upvalues: l__Players__1 (copy)
    if p10.needsReset then
        p10:StartFadeFromBlack();
        p10.needsReset = false;
    end;
    local l__LocalPlayer__11 = l__Players__1.LocalPlayer;
    if (p13 - p14).magnitude > 0.01 then
        p10:StartVREdgeBlur(l__LocalPlayer__11);
    end;
    local l__p__12 = p12.p;
    local v15 = p10:GetCameraLookVector();
    local l__Unit__13 = Vector3.new(v15.X, 0, v15.Z).Unit;
    local v16 = p10:getRotation(p11);
    local v17 = p10:CalculateNewLookVectorFromArg(l__Unit__13, Vector2.new(v16, 0));
    return CFrame.new(l__p__12 - 0.5 * v17, l__p__12), p12;
end;
function u1.UpdateImmersionCamera(p18, p19, _, _, _, p20) --[[ Line: 153 ]]
    -- upvalues: l__Players__1 (copy), l__VRService__2 (copy)
    local v21 = p18:GetSubjectCFrame();
    local l__CurrentCamera__14 = workspace.CurrentCamera;
    local l__Character__15 = l__Players__1.LocalPlayer.Character;
    local v22 = p18:GetHumanoid();
    if not v22 then
        return l__CurrentCamera__14.CFrame, l__CurrentCamera__14.Focus;
    end;
    local v23 = l__Character__15:FindFirstChild("HumanoidRootPart");
    if not v23 then
        return l__CurrentCamera__14.CFrame, l__CurrentCamera__14.Focus;
    end;
    p18.characterOrientation = v23:FindFirstChild("CharacterAlignOrientation");
    if not p18.characterOrientation then
        local v24 = v23:FindFirstChild("RootAttachment");
        if not v24 then
            return;
        end;
        p18.characterOrientation = Instance.new("AlignOrientation");
        p18.characterOrientation.Name = "CharacterAlignOrientation";
        p18.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        p18.characterOrientation.Attachment0 = v24;
        p18.characterOrientation.RigidityEnabled = true;
        p18.characterOrientation.Parent = v23;
    end;
    if p18.characterOrientation.Enabled == false then
        p18.characterOrientation.Enabled = true;
    end;
    if p18.needsReset then
        p18.needsReset = false;
        p18.savedAutoRotate = v22.AutoRotate;
        v22.AutoRotate = false;
        if p18.NoRecenter then
            p18.NoRecenter = false;
            l__VRService__2:RecenterUserHeadCFrame();
        end;
        p18:StartFadeFromBlack();
    elseif v22.Sit then
        if (v21.Position - l__CurrentCamera__14.CFrame.Position).Magnitude > 0.01 then
            p18:StartVREdgeBlur(l__Players__1.LocalPlayer);
        end;
    else
        local v25 = p18.controlModule:GetEstimatedVRTorsoFrame();
        p18.characterOrientation.CFrame = l__CurrentCamera__14.CFrame * v25;
        if p18.controlModule.inputMoveVector.Magnitude > 0 then
            p18.motionDetTime = 0.1;
        end;
        if p18.controlModule.inputMoveVector.Magnitude > 0 or p18.motionDetTime > 0 then
            p18.motionDetTime = p18.motionDetTime - p19;
            p18:StartVREdgeBlur(l__Players__1.LocalPlayer);
            local v26 = l__VRService__2:GetUserCFrame(Enum.UserCFrame.Head);
            local v27 = v26.Rotation + v26.Position * l__CurrentCamera__14.HeadScale;
            local l__HumanoidRootPart__16 = l__Character__15.HumanoidRootPart;
            local v28 = l__CurrentCamera__14.CFrame * v27 * CFrame.new(0, -0.7 * l__HumanoidRootPart__16.Size.Y / 2, 0);
            local l__LookVector__17 = l__HumanoidRootPart__16.CFrame.LookVector;
            local v29 = p20 - (v28 - Vector3.new(l__LookVector__17.X, 0, l__LookVector__17.Z).Unit * l__HumanoidRootPart__16.Size.Y * 0.125).Position + l__CurrentCamera__14.CFrame.Position;
            local v30 = Vector3.new(v29.X, p20.Y, v29.Z);
            v21 = l__CurrentCamera__14.CFrame.Rotation + v30;
        else
            v21 = l__CurrentCamera__14.CFrame.Rotation + Vector3.new(l__CurrentCamera__14.CFrame.Position.X, p20.Y, l__CurrentCamera__14.CFrame.Position.Z);
        end;
        local v31 = p18:getRotation(p19);
        if math.abs(v31) > 0 then
            local v32 = l__VRService__2:GetUserCFrame(Enum.UserCFrame.Head);
            local v33 = v32.Rotation + v32.Position * l__CurrentCamera__14.HeadScale;
            local v34 = v21 * v33;
            v21 = CFrame.new(v34.Position) * CFrame.Angles(0, -math.rad(v31 * 90), 0) * v34.Rotation * v33:Inverse();
        end;
    end;
    return v21, v21 * CFrame.new(0, 0, -0.5);
end;
function u1.UpdateThirdPersonComfortTransform(p35, p36, p37, p38, p39, p40) --[[ Line: 265 ]]
    -- upvalues: l__Players__1 (copy), l__VRService__2 (copy)
    local v41 = p35:GetCameraToSubjectDistance();
    local v42 = v41 < 0.5 and 0.5 or v41;
    if p39 ~= nil and p35.lastCameraFocus ~= nil then
        local _ = l__Players__1.LocalPlayer;
        local v43 = p39 - p40;
        local v44 = p35.controlModule:GetMoveVector();
        local v45 = v43.magnitude > 0.01 and true or v44.magnitude > 0.01;
        if v45 then
            p35.motionDetTime = 0.1;
        end;
        p35.motionDetTime = p35.motionDetTime - p36;
        if (p35.motionDetTime > 0 and true or v45) and not p35.needsReset then
            local l__lastCameraFocus__18 = p35.lastCameraFocus;
            p35.VRCameraFocusFrozen = true;
            return p37, l__lastCameraFocus__18;
        end;
        local v46 = p35.lastCameraResetPosition == nil and true or (p40 - p35.lastCameraResetPosition).Magnitude > 1;
        local v47 = p35:getRotation(p36);
        if math.abs(v47) > 0 then
            local v48 = p38:ToObjectSpace(p37);
            p37 = p38 * CFrame.Angles(0, -v47, 0) * v48;
        end;
        if p35.VRCameraFocusFrozen and v46 or p35.needsReset then
            l__VRService__2:RecenterUserHeadCFrame();
            p35.VRCameraFocusFrozen = false;
            p35.needsReset = false;
            p35.lastCameraResetPosition = p40;
            p35:ResetZoom();
            p35:StartFadeFromBlack();
            local v49 = p35:GetHumanoid();
            local v50 = v49.Torso and v49.Torso.CFrame.lookVector or Vector3.new(1, 0, 0);
            local v51 = Vector3.new(v50.X, 0, v50.Z);
            local v52 = p38.Position - v51 * v42;
            local v53 = Vector3.new(p38.Position.X, v52.Y, p38.Position.Z);
            p37 = CFrame.new(v52, v53);
        end;
    end;
    return p37, p38;
end;
function u1.UpdateThirdPersonFollowTransform(p54, p55, _, _, p56, p57) --[[ Line: 332 ]]
    -- upvalues: l__VRService__2 (copy), l__Players__1 (copy)
    local l__CurrentCamera__19 = workspace.CurrentCamera;
    local v58 = p54:GetCameraToSubjectDistance();
    local v59 = p54:GetVRFocus(p57, p55);
    if p54.needsReset then
        p54.needsReset = false;
        l__VRService__2:RecenterUserHeadCFrame();
        p54:ResetZoom();
        p54:StartFadeFromBlack();
    end;
    if p54.recentered then
        local v60 = p54:GetSubjectCFrame();
        if not v60 then
            return l__CurrentCamera__19.CFrame, l__CurrentCamera__19.Focus;
        end;
        local v61 = v59 * v60.Rotation * CFrame.new(0, 0, v58);
        p54.focusOffset = v59:ToObjectSpace(v61);
        p54.recentered = false;
        return v61, v59;
    end;
    local v62 = v59:ToWorldSpace(p54.focusOffset);
    local _ = l__Players__1.LocalPlayer;
    local v63 = p56 - p57;
    local l__controlModule__20 = p54.controlModule;
    local v64 = l__controlModule__20:GetMoveVector();
    if v63.magnitude > 0.01 or v64.magnitude > 0 then
        local v65 = l__controlModule__20:GetEstimatedVRTorsoFrame();
        local v66 = l__CurrentCamera__19.CFrame * (v65.Rotation + v65.Position * l__CurrentCamera__19.HeadScale);
        local l__LookVector__21 = v66.LookVector;
        local v67 = Vector3.new(l__LookVector__21.X, 0, l__LookVector__21.Z).Unit * v58;
        v62 = v62:Lerp(CFrame.new(l__CurrentCamera__19.CFrame.Position + (v59.Position - v67) - v66.Position) * v62.Rotation, 0.01);
    end;
    local v68 = p54:getRotation(p55);
    if math.abs(v68) > 0 then
        local v69 = v59:ToObjectSpace(v62);
        v62 = v59 * CFrame.Angles(0, -v68, 0) * v69;
    end;
    p54.focusOffset = v59:ToObjectSpace(v62);
    local v70 = v62 * CFrame.new(0, 0, -v58);
    if (v70.Position - l__CurrentCamera__19.Focus.Position).Magnitude > 0.01 then
        p54:StartVREdgeBlur(l__Players__1.LocalPlayer);
    end;
    return v62, v70;
end;
function u1.LeaveFirstPerson(p71) --[[ Line: 410 ]]
    -- upvalues: l__VRBaseCamera__3 (copy)
    l__VRBaseCamera__3.LeaveFirstPerson(p71);
    p71.needsReset = true;
    if p71.VRBlur then
        p71.VRBlur.Visible = false;
    end;
    if p71.characterOrientation then
        p71.characterOrientation.Enabled = false;
    end;
    local v72 = p71:GetHumanoid();
    if v72 then
        v72.AutoRotate = p71.savedAutoRotate;
    end;
end;
return u1;