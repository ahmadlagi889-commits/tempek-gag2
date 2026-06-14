-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local l__profilebegin__1 = debug.profilebegin;
local l__profileend__2 = debug.profileend;
local l__new__3 = Vector3.new;
local l__new__4 = CFrame.new;
local l__Angles__5 = CFrame.Angles;
local l__rad__6 = math.rad;
local u2 = l__new__3();
local l__CameraShakeInstance__7 = require(script.CameraShakeInstance);
local l__CameraShakeState__8 = l__CameraShakeInstance__7.CameraShakeState;
u1.CameraShakeInstance = l__CameraShakeInstance__7;
u1.Presets = require(script.CameraShakePresets);
function u1.new(p3, p4) --[[ Line: 87 ]]
    -- upvalues: u2 (copy), u1 (copy)
    local v5 = type(p3) == "number";
    assert(v5, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
    local v6 = type(p4) == "function";
    assert(v6, "Callback must be a function");
    return setmetatable({
        _running = false,
        _renderName = "CameraShaker",
        _renderPriority = p3,
        _posAddShake = u2,
        _rotAddShake = u2,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p4
    }, u1);
end;
function u1.Start(u7) --[[ Line: 108 ]]
    -- upvalues: l__profilebegin__1 (copy), l__profileend__2 (copy)
    if u7._running then
    else
        u7._running = true;
        local l___callback__9 = u7._callback;
        game:GetService("RunService"):BindToRenderStep(u7._renderName, u7._renderPriority, function(p8) --[[ Line: 112 ]]
            -- upvalues: l__profilebegin__1 (ref), u7 (copy), l__profileend__2 (ref), l___callback__9 (copy)
            l__profilebegin__1("CameraShakerUpdate");
            local v9 = u7:Update(p8);
            l__profileend__2();
            l___callback__9(v9);
        end);
    end;
end;
function u1.Stop(p10) --[[ Line: 121 ]]
    if p10._running then
        game:GetService("RunService"):UnbindFromRenderStep(p10._renderName);
        p10._running = false;
    end;
end;
function u1.StopSustained(p11, p12) --[[ Line: 128 ]]
    for _, v13 in pairs(p11._camShakeInstances) do
        if v13.fadeOutDuration == 0 then
            v13:StartFadeOut(p12 or v13.fadeInDuration);
        end;
    end;
end;
function u1.Update(p14, p15) --[[ Line: 137 ]]
    -- upvalues: u2 (copy), l__CameraShakeState__8 (copy), l__new__4 (copy), l__Angles__5 (copy), l__rad__6 (copy)
    local v16 = u2;
    local v17 = u2;
    local l___camShakeInstances__10 = p14._camShakeInstances;
    for v18 = 1, #l___camShakeInstances__10 do
        local v19 = l___camShakeInstances__10[v18];
        local v20 = v19:GetState();
        if v20 == l__CameraShakeState__8.Inactive and v19.DeleteOnInactive then
            p14._removeInstances[#p14._removeInstances + 1] = v18;
        elseif v20 ~= l__CameraShakeState__8.Inactive then
            local v21 = v19:UpdateShake(p15);
            v16 = v16 + v21 * v19.PositionInfluence;
            v17 = v17 + v21 * v19.RotationInfluence;
        end;
    end;
    for v22 = #p14._removeInstances, 1, -1 do
        table.remove(l___camShakeInstances__10, p14._removeInstances[v22]);
        p14._removeInstances[v22] = nil;
    end;
    return l__new__4(v16) * l__Angles__5(0, l__rad__6(v17.Y), 0) * l__Angles__5(l__rad__6(v17.X), 0, (l__rad__6(v17.Z)));
end;
function u1.Shake(p23, p24) --[[ Line: 174 ]]
    local v25;
    if type(p24) == "table" then
        v25 = p24._camShakeInstance;
    else
        v25 = false;
    end;
    assert(v25, "ShakeInstance must be of type CameraShakeInstance");
    p23._camShakeInstances[#p23._camShakeInstances + 1] = p24;
    return p24;
end;
function u1.ShakeSustain(p26, p27) --[[ Line: 181 ]]
    local v28;
    if type(p27) == "table" then
        v28 = p27._camShakeInstance;
    else
        v28 = false;
    end;
    assert(v28, "ShakeInstance must be of type CameraShakeInstance");
    p26._camShakeInstances[#p26._camShakeInstances + 1] = p27;
    p27:StartFadeIn(p27.fadeInDuration);
    return p27;
end;
function u1.ShakeOnce(p29, p30, p31, p32, p33, p34, p35) --[[ Line: 189 ]]
    -- upvalues: l__CameraShakeInstance__7 (copy)
    local v36 = l__CameraShakeInstance__7.new(p30, p31, p32, p33);
    v36.PositionInfluence = typeof(p34) == "Vector3" and p34 and p34 or Vector3.new(0.15, 0.15, 0.15);
    v36.RotationInfluence = typeof(p35) == "Vector3" and p35 and p35 or Vector3.new(1, 1, 1);
    p29._camShakeInstances[#p29._camShakeInstances + 1] = v36;
    return v36;
end;
function u1.StartShake(p37, p38, p39, p40, p41, p42) --[[ Line: 198 ]]
    -- upvalues: l__CameraShakeInstance__7 (copy)
    local v43 = l__CameraShakeInstance__7.new(p38, p39, p40);
    v43.PositionInfluence = typeof(p41) == "Vector3" and p41 and p41 or Vector3.new(0.15, 0.15, 0.15);
    v43.RotationInfluence = typeof(p42) == "Vector3" and p42 and p42 or Vector3.new(1, 1, 1);
    v43:StartFadeIn(p40);
    p37._camShakeInstances[#p37._camShakeInstances + 1] = v43;
    return v43;
end;
return u1;