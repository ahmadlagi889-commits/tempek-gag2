-- Decompiled with Potassium's decompiler.

Vector2.new(0, 0);
local u1 = 0;
local u2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0);
local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
local u3 = require(l__CommonUtils__1:WaitForChild("FlagUtil")).getUserFlag("UserFixCameraFPError");
local l__Players__2 = game:GetService("Players");
local l__CameraInput__3 = require(script.Parent:WaitForChild("CameraInput"));
local l__CameraUtils__4 = require(script.Parent:WaitForChild("CameraUtils"));
local l__BaseCamera__5 = require(script.Parent:WaitForChild("BaseCamera"));
local u4 = setmetatable({}, l__BaseCamera__5);
u4.__index = u4;
function u4.new() --[[ Line: 39 ]]
    -- upvalues: l__BaseCamera__5 (copy), u4 (copy), l__CameraUtils__4 (copy)
    local v5 = l__BaseCamera__5.new();
    local v6 = setmetatable(v5, u4);
    v6.isFollowCamera = false;
    v6.isCameraToggle = false;
    v6.lastUpdate = tick();
    v6.cameraToggleSpring = l__CameraUtils__4.Spring.new(5, 0);
    return v6;
end;
function u4.GetCameraToggleOffset(p7, p8) --[[ Line: 50 ]]
    -- upvalues: l__CameraInput__3 (copy), l__CameraUtils__4 (copy)
    if not p7.isCameraToggle then
        return Vector3.new();
    end;
    local l__currentSubjectDistance__6 = p7.currentSubjectDistance;
    if l__CameraInput__3.getTogglePan() then
        local l__cameraToggleSpring__7 = p7.cameraToggleSpring;
        local v9 = l__CameraUtils__4.map(l__currentSubjectDistance__6, 0.5, p7.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1);
        l__cameraToggleSpring__7.goal = math.clamp(v9, 0, 1);
    else
        p7.cameraToggleSpring.goal = 0;
    end;
    local v10 = l__CameraUtils__4.map(l__currentSubjectDistance__6, 0.5, 64, 0, 1);
    local v11 = math.clamp(v10, 0, 1) + 1;
    local v12 = p7.cameraToggleSpring:step(p8) * v11;
    return Vector3.new(0, v12, 0);
end;
function u4.SetCameraMovementMode(p13, p14) --[[ Line: 68 ]]
    -- upvalues: l__BaseCamera__5 (copy)
    l__BaseCamera__5.SetCameraMovementMode(p13, p14);
    p13.isFollowCamera = p14 == Enum.ComputerCameraMovementMode.Follow;
    p13.isCameraToggle = p14 == Enum.ComputerCameraMovementMode.CameraToggle;
end;
function u4.Update(p15, p16) --[[ Line: 75 ]]
    -- upvalues: u2 (copy), l__Players__2 (copy), l__CameraInput__3 (copy), u1 (ref), l__CameraUtils__4 (copy), u3 (copy)
    local v17 = tick();
    local l__CurrentCamera__8 = workspace.CurrentCamera;
    local l__CFrame__9 = l__CurrentCamera__8.CFrame;
    local l__Focus__10 = l__CurrentCamera__8.Focus;
    local v18;
    if p15.resetCameraAngle then
        local v19 = p15:GetHumanoidRootPart();
        if v19 then
            v18 = (v19.CFrame * u2).lookVector;
        else
            v18 = u2.lookVector;
        end;
        p15.resetCameraAngle = false;
    else
        v18 = nil;
    end;
    local l__LocalPlayer__11 = l__Players__2.LocalPlayer;
    local v20 = p15:GetHumanoid();
    local l__CameraSubject__12 = l__CurrentCamera__8.CameraSubject;
    local v21;
    if l__CameraSubject__12 then
        v21 = l__CameraSubject__12:IsA("VehicleSeat");
    else
        v21 = l__CameraSubject__12;
    end;
    local v22;
    if l__CameraSubject__12 then
        v22 = l__CameraSubject__12:IsA("SkateboardPlatform");
    else
        v22 = l__CameraSubject__12;
    end;
    local v23;
    if v20 then
        v23 = v20:GetState() == Enum.HumanoidStateType.Climbing;
    else
        v23 = v20;
    end;
    if p15.lastUpdate == nil or p16 > 1 then
        p15.lastCameraTransform = nil;
    end;
    local v24 = l__CameraInput__3.getRotation(p16);
    p15:StepZoom();
    local v25 = p15:GetCameraHeight();
    if v24 ~= Vector2.new() then
        u1 = 0;
        p15.lastUserPanCamera = tick();
    end;
    local v26 = v17 - p15.lastUserPanCamera < 2;
    local v27 = p15:GetSubjectPosition();
    if v27 and (l__LocalPlayer__11 and l__CurrentCamera__8) then
        local v28 = p15:GetCameraToSubjectDistance();
        local v29 = v28 < 0.5 and 0.5 or v28;
        if p15:GetIsMouseLocked() and not p15:IsInFirstPerson() then
            local v30 = p15:CalculateNewLookCFrameFromArg(v18, v24);
            local v31 = p15:GetMouseLockOffset();
            if v20 then
                v31 = v31 + v20.CameraOffset;
            end;
            local v32 = v31.X * v30.RightVector + v31.Y * v30.UpVector + v31.Z * v30.LookVector;
            if l__CameraUtils__4.IsFiniteVector3(v32) then
                v27 = v27 + v32;
            end;
        elseif v24 == Vector2.new() and p15.lastCameraTransform then
            local v33 = p15:IsInFirstPerson();
            if (v21 or (v22 or p15.isFollowCamera and v23)) and (p15.lastUpdate and (v20 and v20.Torso)) then
                if v33 then
                    if p15.lastSubjectCFrame and (v21 or v22) and l__CameraSubject__12:IsA("BasePart") then
                        local v34 = -l__CameraUtils__4.GetAngleBetweenXZVectors(p15.lastSubjectCFrame.lookVector, l__CameraSubject__12.CFrame.lookVector);
                        if l__CameraUtils__4.IsFinite(v34) then
                            v24 = v24 + Vector2.new(v34, 0);
                        end;
                        u1 = 0;
                    end;
                elseif not v26 then
                    local l__lookVector__13 = v20.Torso.CFrame.lookVector;
                    u1 = math.clamp(u1 + 3.839724354387525 * p16, 0, 4.363323129985824);
                    local v35 = math.clamp(u1 * p16, 0, 1);
                    local v36 = p15:IsInFirstPerson() and not (p15.isFollowCamera and p15.isClimbing) and 1 or v35;
                    local v37 = l__CameraUtils__4.GetAngleBetweenXZVectors(l__lookVector__13, p15:GetCameraLookVector());
                    if l__CameraUtils__4.IsFinite(v37) and math.abs(v37) > 0.0001 then
                        v24 = v24 + Vector2.new(v37 * v36, 0);
                    end;
                end;
            elseif p15.isFollowCamera and not (v33 or v26) then
                local v38 = l__CameraUtils__4.GetAngleBetweenXZVectors(-(p15.lastCameraTransform.p - v27), p15:GetCameraLookVector());
                if l__CameraUtils__4.IsFinite(v38) and (math.abs(v38) > 0.0001 and math.abs(v38) > 0.4 * p16) then
                    v24 = v24 + Vector2.new(v38, 0);
                end;
            end;
        end;
        local v39, v40;
        if p15.isFollowCamera then
            local v41 = p15:CalculateNewLookVectorFromArg(v18, v24);
            v39 = CFrame.new(v27);
            if u3 then
                v40 = CFrame.lookAlong(v39.p - v29 * v41, v41);
            else
                v40 = CFrame.new(v39.p - v29 * v41, v39.p) + Vector3.new(0, v25, 0);
            end;
        else
            v39 = CFrame.new(v27);
            local l__p__14 = v39.p;
            local v42 = p15:CalculateNewLookVectorFromArg(v18, v24);
            if u3 then
                v40 = CFrame.lookAlong(l__p__14 - v29 * v42, v42);
            else
                v40 = CFrame.new(l__p__14 - v29 * v42, l__p__14);
            end;
        end;
        local v43 = p15:GetCameraToggleOffset(p16);
        l__Focus__10 = v39 + v43;
        l__CFrame__9 = v40 + v43;
        p15.lastCameraTransform = l__CFrame__9;
        p15.lastCameraFocus = l__Focus__10;
        if (v21 or v22) and l__CameraSubject__12:IsA("BasePart") then
            p15.lastSubjectCFrame = l__CameraSubject__12.CFrame;
        else
            p15.lastSubjectCFrame = nil;
        end;
    end;
    p15.lastUpdate = v17;
    return l__CFrame__9, l__Focus__10;
end;
return u4;