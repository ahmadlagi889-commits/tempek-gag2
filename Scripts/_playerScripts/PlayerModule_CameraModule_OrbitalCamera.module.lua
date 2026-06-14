-- Decompiled with Potassium's decompiler.

local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(l__CommonUtils__1:WaitForChild("FlagUtil")).getUserFlag("UserFixOrbitalCameraAzimuth");
local l__CameraUtils__2 = require(script.Parent:WaitForChild("CameraUtils"));
local l__CameraInput__3 = require(script.Parent:WaitForChild("CameraInput"));
local l__Players__4 = game:GetService("Players");
local l__BaseCamera__5 = require(script.Parent:WaitForChild("BaseCamera"));
local u2 = setmetatable({}, l__BaseCamera__5);
u2.__index = u2;
function u2.new() --[[ Line: 46 ]]
    -- upvalues: l__BaseCamera__5 (copy), u2 (copy)
    local v3 = l__BaseCamera__5.new();
    local v4 = setmetatable(v3, u2);
    v4.lastUpdate = tick();
    v4.changedSignalConnections = {};
    v4.refAzimuthRad = nil;
    v4.curAzimuthRad = nil;
    v4.minAzimuthAbsoluteRad = nil;
    v4.maxAzimuthAbsoluteRad = nil;
    v4.useAzimuthLimits = nil;
    v4.curElevationRad = nil;
    v4.minElevationRad = nil;
    v4.maxElevationRad = nil;
    v4.curDistance = nil;
    v4.minDistance = nil;
    v4.maxDistance = nil;
    v4.gamepadDollySpeedMultiplier = 1;
    v4.lastUserPanCamera = tick();
    v4.externalProperties = {};
    v4.externalProperties.InitialDistance = 25;
    v4.externalProperties.MinDistance = 10;
    v4.externalProperties.MaxDistance = 100;
    v4.externalProperties.InitialElevation = 35;
    v4.externalProperties.MinElevation = 35;
    v4.externalProperties.MaxElevation = 35;
    v4.externalProperties.ReferenceAzimuth = -45;
    v4.externalProperties.CWAzimuthTravel = 90;
    v4.externalProperties.CCWAzimuthTravel = 90;
    v4.externalProperties.UseAzimuthLimits = false;
    v4:LoadNumberValueParameters();
    return v4;
end;
function u2.LoadOrCreateNumberValueParameter(u5, u6, p7, u8) --[[ Line: 85 ]]
    local v9 = script:FindFirstChild(u6);
    if v9 and v9:IsA(p7) then
        u5.externalProperties[u6] = v9.Value;
    else
        if u5.externalProperties[u6] == nil then
            return;
        end;
        v9 = Instance.new(p7);
        v9.Name = u6;
        v9.Parent = script;
        v9.Value = u5.externalProperties[u6];
    end;
    if u8 then
        if u5.changedSignalConnections[u6] then
            u5.changedSignalConnections[u6]:Disconnect();
        end;
        u5.changedSignalConnections[u6] = v9.Changed:Connect(function(p10) --[[ Line: 105 ]]
            -- upvalues: u5 (copy), u6 (copy), u8 (copy)
            u5.externalProperties[u6] = p10;
            u8(u5);
        end);
    end;
end;
function u2.SetAndBoundsCheckAzimuthValues(p11) --[[ Line: 112 ]]
    local v12 = math.rad(p11.externalProperties.ReferenceAzimuth);
    local v13 = math.rad(p11.externalProperties.CWAzimuthTravel);
    p11.minAzimuthAbsoluteRad = v12 - math.abs(v13);
    local v14 = math.rad(p11.externalProperties.ReferenceAzimuth);
    local v15 = math.rad(p11.externalProperties.CCWAzimuthTravel);
    p11.maxAzimuthAbsoluteRad = v14 + math.abs(v15);
    p11.useAzimuthLimits = p11.externalProperties.UseAzimuthLimits;
    if p11.useAzimuthLimits then
        p11.curAzimuthRad = math.max(p11.curAzimuthRad, p11.minAzimuthAbsoluteRad);
        p11.curAzimuthRad = math.min(p11.curAzimuthRad, p11.maxAzimuthAbsoluteRad);
    end;
end;
function u2.SetAndBoundsCheckElevationValues(p16) --[[ Line: 122 ]]
    local v17 = math.max(p16.externalProperties.MinElevation, -80);
    local v18 = math.min(p16.externalProperties.MaxElevation, 80);
    local v19 = math.min(v17, v18);
    p16.minElevationRad = math.rad(v19);
    local v20 = math.max(v17, v18);
    p16.maxElevationRad = math.rad(v20);
    p16.curElevationRad = math.max(p16.curElevationRad, p16.minElevationRad);
    p16.curElevationRad = math.min(p16.curElevationRad, p16.maxElevationRad);
end;
function u2.SetAndBoundsCheckDistanceValues(p21) --[[ Line: 138 ]]
    p21.minDistance = p21.externalProperties.MinDistance;
    p21.maxDistance = p21.externalProperties.MaxDistance;
    p21.curDistance = math.max(p21.curDistance, p21.minDistance);
    p21.curDistance = math.min(p21.curDistance, p21.maxDistance);
end;
function u2.LoadNumberValueParameters(p22) --[[ Line: 146 ]]
    -- upvalues: u1 (copy)
    p22:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil);
    p22:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil);
    local v23 = "ReferenceAzimuth";
    local v24 = "NumberValue";
    local v25;
    if u1 then
        v25 = p22.SetAndBoundsCheckAzimuthValues;
    else
        v25 = p22.SetAndBoundsCheckAzimuthValue;
    end;
    p22:LoadOrCreateNumberValueParameter(v23, v24, v25);
    p22:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p22.SetAndBoundsCheckAzimuthValues);
    p22:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p22.SetAndBoundsCheckAzimuthValues);
    p22:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p22.SetAndBoundsCheckElevationValues);
    p22:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p22.SetAndBoundsCheckElevationValues);
    p22:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p22.SetAndBoundsCheckDistanceValues);
    p22:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p22.SetAndBoundsCheckDistanceValues);
    p22:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p22.SetAndBoundsCheckAzimuthValues);
    p22.curAzimuthRad = math.rad(p22.externalProperties.ReferenceAzimuth);
    p22.curElevationRad = math.rad(p22.externalProperties.InitialElevation);
    p22.curDistance = p22.externalProperties.InitialDistance;
    p22:SetAndBoundsCheckAzimuthValues();
    p22:SetAndBoundsCheckElevationValues();
    p22:SetAndBoundsCheckDistanceValues();
end;
function u2.GetModuleName(_) --[[ Line: 172 ]]
    return "OrbitalCamera";
end;
function u2.SetInitialOrientation(p26, p27) --[[ Line: 176 ]]
    -- upvalues: l__CameraUtils__2 (copy)
    if p27 and p27.RootPart then
        assert(p27.RootPart, "");
        local l__Unit__6 = (p27.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit;
        local v28 = l__CameraUtils__2.GetAngleBetweenXZVectors(l__Unit__6, p26:GetCameraLookVector());
        local l__Y__7 = p26:GetCameraLookVector().Y;
        local v29 = math.asin(l__Y__7) - math.asin(l__Unit__6.Y);
        l__CameraUtils__2.IsFinite(v28);
        l__CameraUtils__2.IsFinite(v29);
    else
        warn("OrbitalCamera could not set initial orientation due to missing humanoid");
    end;
end;
function u2.GetCameraToSubjectDistance(p30) --[[ Line: 194 ]]
    return p30.curDistance;
end;
function u2.SetCameraToSubjectDistance(p31, p32) --[[ Line: 198 ]]
    -- upvalues: l__Players__4 (copy)
    if l__Players__4.LocalPlayer then
        p31.currentSubjectDistance = math.clamp(p32, p31.minDistance, p31.maxDistance);
        p31.currentSubjectDistance = math.max(p31.currentSubjectDistance, p31.FIRST_PERSON_DISTANCE_THRESHOLD);
    end;
    p31.inFirstPerson = false;
    p31:UpdateMouseBehavior();
    return p31.currentSubjectDistance;
end;
function u2.CalculateNewLookVector(p33, p34, p35) --[[ Line: 211 ]]
    local v36 = p34 or p33:GetCameraLookVector();
    local v37 = math.asin(v36.Y);
    local v38 = math.clamp(p35.Y, v37 - 1.3962634015954636, v37 - -1.3962634015954636);
    local v39 = Vector2.new(p35.X, v38);
    local v40 = CFrame.new(Vector3.new(0, 0, 0), v36);
    return (CFrame.Angles(0, -v39.X, 0) * v40 * CFrame.Angles(-v39.Y, 0, 0)).LookVector;
end;
function u2.Update(p41, p42) --[[ Line: 222 ]]
    -- upvalues: l__CameraInput__3 (copy), l__Players__4 (copy)
    local v43 = tick();
    local v44 = v43 - p41.lastUpdate;
    local v45 = l__CameraInput__3.getRotation(p42) ~= Vector2.new();
    local l__CurrentCamera__8 = workspace.CurrentCamera;
    local l__CFrame__9 = l__CurrentCamera__8.CFrame;
    local l__Focus__10 = l__CurrentCamera__8.Focus;
    local l__LocalPlayer__11 = l__Players__4.LocalPlayer;
    local v46;
    if l__CurrentCamera__8 then
        v46 = l__CurrentCamera__8.CameraSubject;
    else
        v46 = l__CurrentCamera__8;
    end;
    local v47;
    if v46 then
        v47 = v46:IsA("VehicleSeat");
    else
        v47 = v46;
    end;
    local v48;
    if v46 then
        v48 = v46:IsA("SkateboardPlatform");
    else
        v48 = v46;
    end;
    if p41.lastUpdate == nil or v44 > 1 then
        p41.lastCameraTransform = nil;
    end;
    if v45 then
        p41.lastUserPanCamera = tick();
    end;
    local v49 = p41:GetSubjectPosition();
    if v49 and (l__LocalPlayer__11 and l__CurrentCamera__8) then
        if p41.gamepadDollySpeedMultiplier ~= 1 then
            p41:SetCameraToSubjectDistance(p41.currentSubjectDistance * p41.gamepadDollySpeedMultiplier);
        end;
        l__Focus__10 = CFrame.new(v49);
        local v50 = l__CameraInput__3.getRotation(p42);
        p41.curAzimuthRad = p41.curAzimuthRad - v50.X;
        if p41.useAzimuthLimits then
            p41.curAzimuthRad = math.clamp(p41.curAzimuthRad, p41.minAzimuthAbsoluteRad, p41.maxAzimuthAbsoluteRad);
        else
            p41.curAzimuthRad = p41.curAzimuthRad == 0 and 0 or (math.sign(p41.curAzimuthRad) * (math.abs(p41.curAzimuthRad) % 6.283185307179586) or 0);
        end;
        p41.curElevationRad = math.clamp(p41.curElevationRad + v50.Y, p41.minElevationRad, p41.maxElevationRad);
        local v51 = v49 + p41.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p41.curElevationRad, p41.curAzimuthRad, 0) * Vector3.new(0, 0, 1));
        l__CFrame__9 = CFrame.new(v51, v49);
        p41.lastCameraTransform = l__CFrame__9;
        p41.lastCameraFocus = l__Focus__10;
        if (v47 or v48) and v46:IsA("BasePart") then
            p41.lastSubjectCFrame = v46.CFrame;
        else
            p41.lastSubjectCFrame = nil;
        end;
    end;
    p41.lastUpdate = v43;
    return l__CFrame__9, l__Focus__10;
end;
return u2;