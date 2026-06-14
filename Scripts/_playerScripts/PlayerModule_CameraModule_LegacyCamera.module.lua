-- Decompiled with Potassium's decompiler.

Vector2.new();
require(script.Parent:WaitForChild("CameraUtils"));
local l__CameraInput__1 = require(script.Parent:WaitForChild("CameraInput"));
local l__Players__2 = game:GetService("Players");
local l__BaseCamera__3 = require(script.Parent:WaitForChild("BaseCamera"));
local u1 = setmetatable({}, l__BaseCamera__3);
u1.__index = u1;
function u1.new() --[[ Line: 21 ]]
    -- upvalues: l__BaseCamera__3 (copy), u1 (copy)
    local v2 = l__BaseCamera__3.new();
    local v3 = setmetatable(v2, u1);
    v3.cameraType = Enum.CameraType.Fixed;
    v3.lastUpdate = tick();
    v3.lastDistanceToSubject = nil;
    return v3;
end;
function u1.GetModuleName(_) --[[ Line: 31 ]]
    return "LegacyCamera";
end;
function u1.SetCameraToSubjectDistance(p4, p5) --[[ Line: 36 ]]
    -- upvalues: l__BaseCamera__3 (copy)
    return l__BaseCamera__3.SetCameraToSubjectDistance(p4, p5);
end;
function u1.Update(p6, p7) --[[ Line: 40 ]]
    -- upvalues: l__Players__2 (copy), l__CameraInput__1 (copy)
    if not p6.cameraType then
        return nil, nil;
    end;
    local v8 = tick();
    local v9 = v8 - p6.lastUpdate;
    local l__CurrentCamera__4 = workspace.CurrentCamera;
    local l__CFrame__5 = l__CurrentCamera__4.CFrame;
    local l__Focus__6 = l__CurrentCamera__4.Focus;
    local l__LocalPlayer__7 = l__Players__2.LocalPlayer;
    local v10 = l__CameraInput__1.getRotation(p7);
    if p6.lastUpdate == nil or v9 > 1 then
        p6.lastDistanceToSubject = nil;
    end;
    local v11 = p6:GetSubjectPosition();
    if p6.cameraType == Enum.CameraType.Fixed then
        if v11 and (l__LocalPlayer__7 and l__CurrentCamera__4) then
            local v12 = p6:GetCameraToSubjectDistance();
            local v13 = p6:CalculateNewLookVectorFromArg(nil, v10);
            l__Focus__6 = l__CurrentCamera__4.Focus;
            l__CFrame__5 = CFrame.new(l__CurrentCamera__4.CFrame.p, l__CurrentCamera__4.CFrame.p + v12 * v13);
        end;
    elseif p6.cameraType == Enum.CameraType.Attach then
        local v14 = p6:GetSubjectCFrame();
        local v15 = l__CurrentCamera__4.CFrame:ToEulerAnglesYXZ();
        local _, v16 = v14:ToEulerAnglesYXZ();
        local v17 = math.clamp(v15 - v10.Y, -1.3962634015954636, 1.3962634015954636);
        l__Focus__6 = CFrame.new(v14.p) * CFrame.fromEulerAnglesYXZ(v17, v16, 0);
        l__CFrame__5 = l__Focus__6 * CFrame.new(0, 0, p6:StepZoom());
    else
        if p6.cameraType ~= Enum.CameraType.Watch then
            return l__CurrentCamera__4.CFrame, l__CurrentCamera__4.Focus;
        end;
        if v11 and (l__LocalPlayer__7 and l__CurrentCamera__4) then
            local v18 = nil;
            if v11 == l__CurrentCamera__4.CFrame.p then
                warn("Camera cannot watch subject in same position as itself");
                return l__CurrentCamera__4.CFrame, l__CurrentCamera__4.Focus;
            end;
            local v19 = p6:GetHumanoid();
            if v19 and v19.RootPart then
                local v20 = v11 - l__CurrentCamera__4.CFrame.p;
                v18 = v20.unit;
                if p6.lastDistanceToSubject and p6.lastDistanceToSubject == p6:GetCameraToSubjectDistance() then
                    p6:SetCameraToSubjectDistance(v20.magnitude);
                end;
            end;
            local v21 = p6:GetCameraToSubjectDistance();
            local v22 = p6:CalculateNewLookVectorFromArg(v18, v10);
            l__Focus__6 = CFrame.new(v11);
            l__CFrame__5 = CFrame.new(v11 - v21 * v22, v11);
            p6.lastDistanceToSubject = v21;
        end;
    end;
    p6.lastUpdate = v8;
    return l__CFrame__5, l__Focus__6;
end;
return u1;