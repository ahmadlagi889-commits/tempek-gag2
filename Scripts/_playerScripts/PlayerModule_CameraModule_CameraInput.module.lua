-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__Players__3 = game:GetService("Players");
game:GetService("RunService");
local l__UserGameSettings__4 = UserSettings():GetService("UserGameSettings");
local l__VRService__5 = game:GetService("VRService");
local l__GuiService__6 = game:GetService("GuiService");
local l__CommonUtils__7 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__8 = require(l__CommonUtils__7:WaitForChild("FlagUtil"));
local u1 = l__FlagUtil__8.getUserFlag("UserPSSinkUnknownTouchEvents");
local v2 = l__FlagUtil__8.getUserFlag("UserPSTextboxResetCameraInput");
local l__LocalPlayer__9 = l__Players__3.LocalPlayer;
local l__Value__10 = Enum.ContextActionPriority.Medium.Value;
local u3 = Vector2.new(1, 0.77) * 0.06981317007977318 * 60;
local u4 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u5 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u6 = Vector2.new(1, 0.66) * 0.017453292519943295;
local u7 = Instance.new("BindableEvent");
local u8 = Instance.new("BindableEvent");
local l__Event__11 = u7.Event;
local l__Event__12 = u8.Event;
l__UserInputService__2.InputBegan:Connect(function(p9, p10) --[[ Line: 44 ]]
    -- upvalues: u7 (copy)
    if not p10 and p9.UserInputType == Enum.UserInputType.MouseButton2 then
        u7:Fire();
    end;
end);
l__UserInputService__2.InputEnded:Connect(function(p11, _) --[[ Line: 50 ]]
    -- upvalues: u8 (copy)
    if p11.UserInputType == Enum.UserInputType.MouseButton2 then
        u8:Fire();
    end;
end);
local function u15(p12) --[[ Line: 61 ]]
    local v13 = (math.abs(p12) - 0.1) / 0.9 * 2;
    local v14 = (math.exp(v13) - 1) / 6.38905609893065;
    return math.sign(p12) * math.clamp(v14, 0, 1);
end;
local function u19(p16) --[[ Line: 75 ]]
    local l__CurrentCamera__13 = workspace.CurrentCamera;
    if not l__CurrentCamera__13 then
        return p16;
    end;
    local v17 = l__CurrentCamera__13.CFrame:ToEulerAnglesYXZ();
    if p16.Y * v17 >= 0 then
        return p16;
    end;
    local v18 = (1 - (math.abs(v17) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;
    return Vector2.new(1, v18) * p16;
end;
local function u25(p20) --[[ Line: 101 ]]
    -- upvalues: l__LocalPlayer__9 (copy)
    local v21 = l__LocalPlayer__9:FindFirstChildOfClass("PlayerGui");
    if v21 then
        v21 = v21:FindFirstChild("TouchGui");
    end;
    local v22;
    if v21 then
        v22 = v21:FindFirstChild("TouchControlFrame");
    else
        v22 = v21;
    end;
    if v22 then
        v22 = v22:FindFirstChild("DynamicThumbstickFrame");
    end;
    if not v22 then
        return false;
    end;
    if not v21.Enabled then
        return false;
    end;
    local l__AbsolutePosition__14 = v22.AbsolutePosition;
    local v23 = l__AbsolutePosition__14 + v22.AbsoluteSize;
    local v24;
    if p20.X >= l__AbsolutePosition__14.X and (p20.Y >= l__AbsolutePosition__14.Y and p20.X <= v23.X) then
        v24 = p20.Y <= v23.Y;
    else
        v24 = false;
    end;
    return v24;
end;
local v26 = {};
local u27 = {};
local u28 = 0;
local u29 = {
    Thumbstick2 = Vector2.new()
};
local u30 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u31 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u32 = {
    Pinch = 0,
    Move = Vector2.new()
};
local u33 = Instance.new("BindableEvent");
v26.gamepadZoomPress = u33.Event;
local u34 = l__VRService__5.VREnabled and Instance.new("BindableEvent") or nil;
if l__VRService__5.VREnabled then
    v26.gamepadReset = u34.Event;
end;
function v26.getRotationActivated() --[[ Line: 172 ]]
    -- upvalues: u28 (ref), u29 (copy)
    return u28 > 0 and true or u29.Thumbstick2.Magnitude > 0;
end;
function v26.getRotation(p35, p36) --[[ Line: 176 ]]
    -- upvalues: l__UserGameSettings__4 (copy), u30 (copy), u29 (copy), u31 (copy), u19 (copy), u32 (copy), u3 (copy), u4 (copy), u5 (copy), u6 (copy)
    local v37 = Vector2.new(1, l__UserGameSettings__4:GetCameraYInvertValue());
    local v38 = Vector2.new(u30.Right - u30.Left, 0) * p35;
    local v39 = u29.Thumbstick2 * l__UserGameSettings__4.GamepadCameraSensitivity * p35;
    local l__Movement__15 = u31.Movement;
    local l__Pan__16 = u31.Pan;
    local v40 = u19(u32.Move);
    if p36 then
        v38 = Vector2.new();
    end;
    return (v38 * 2.0943951023931953 + v39 * u3 + l__Movement__15 * u4 + l__Pan__16 * u5 + v40 * u6) * v37;
end;
function v26.getZoomDelta() --[[ Line: 201 ]]
    -- upvalues: u30 (copy), u31 (copy), u32 (copy)
    return (u30.O - u30.I) * 0.1 + (-u31.Wheel + u31.Pinch) * 1 + -u32.Pinch * 0.04;
end;
local function u42(_, _, p41) --[[ Line: 209 ]]
    -- upvalues: u29 (copy), u15 (ref)
    local l__Position__17 = p41.Position;
    u29[p41.KeyCode.Name] = Vector2.new(u15(l__Position__17.X), -u15(l__Position__17.Y));
    return Enum.ContextActionResult.Pass;
end;
local function u45(_, p43, p44) --[[ Line: 225 ]]
    -- upvalues: u30 (copy)
    u30[p44.KeyCode.Name] = p43 == Enum.UserInputState.Begin and 1 or 0;
end;
local function u47(_, p46, _) --[[ Line: 229 ]]
    -- upvalues: u33 (copy)
    if p46 == Enum.UserInputState.Begin then
        u33:Fire();
    end;
end;
local function u49(_, p48, _) --[[ Line: 235 ]]
    -- upvalues: u34 (copy)
    if p48 == Enum.UserInputState.Begin then
        u34:Fire();
    end;
end;
local function u53() --[[ Line: 241 ]]
    -- upvalues: u29 (copy), u30 (copy), u31 (copy), u32 (copy), u28 (ref)
    for _, v50 in pairs({
        u29,
        u30,
        u31,
        u32
    }) do
        for v51, v52 in pairs(v50) do
            if type(v52) == "boolean" then
                v50[v51] = false;
            else
                v50[v51] = v50[v51] * 0;
            end;
        end;
    end;
    u28 = 0;
end;
local u54 = {};
local u55 = nil;
local u56 = nil;
local function u59(p57, p58) --[[ Line: 267 ]]
    -- upvalues: u55 (ref), u25 (copy), u28 (ref), u54 (ref)
    assert(p57.UserInputType == Enum.UserInputType.Touch);
    assert(p57.UserInputState == Enum.UserInputState.Begin);
    if u55 == nil and (u25(p57.Position) and not p58) then
        u55 = p57;
    else
        if not p58 then
            u28 = math.max(0, u28 + 1);
        end;
        u54[p57] = p58;
    end;
end;
local function u61(p60, _) --[[ Line: 287 ]]
    -- upvalues: u55 (ref), u54 (ref), u56 (ref), u28 (ref)
    assert(p60.UserInputType == Enum.UserInputType.Touch);
    assert(p60.UserInputState == Enum.UserInputState.End);
    if p60 == u55 then
        u55 = nil;
    end;
    if u54[p60] == false then
        u56 = nil;
        u28 = math.max(0, u28 - 1);
    end;
    u54[p60] = nil;
end;
local function u69(p62, p63) --[[ Line: 306 ]]
    -- upvalues: u55 (ref), u54 (ref), u1 (copy), u32 (copy), u56 (ref)
    assert(p62.UserInputType == Enum.UserInputType.Touch);
    assert(p62.UserInputState == Enum.UserInputState.Change);
    if p62 == u55 then
    else
        if u54[p62] == nil then
            if u1 then
                u54[p62] = true;
            else
                u54[p62] = p63;
            end;
        end;
        local v64 = {};
        for v65, v66 in pairs(u54) do
            if not v66 then
                table.insert(v64, v65);
            end;
        end;
        if #v64 == 1 and u54[p62] == false then
            local l__Delta__18 = p62.Delta;
            local v67 = u32;
            v67.Move = v67.Move + Vector2.new(l__Delta__18.X, l__Delta__18.Y);
        end;
        if #v64 == 2 then
            local l__Magnitude__19 = (v64[1].Position - v64[2].Position).Magnitude;
            if u56 then
                local v68 = u32;
                v68.Pinch = v68.Pinch + (l__Magnitude__19 - u56);
            end;
            u56 = l__Magnitude__19;
        else
            u56 = nil;
        end;
    end;
end;
local function u70() --[[ Line: 354 ]]
    -- upvalues: u54 (ref), u55 (ref), u56 (ref), u28 (ref)
    u54 = {};
    u55 = nil;
    u56 = nil;
    u28 = 0;
end;
local function u75(p71, p72, p73, p74) --[[ Line: 362 ]]
    -- upvalues: u31 (copy)
    if not p74 then
        u31.Wheel = p71;
        u31.Pan = p72;
        u31.Pinch = -p73;
    end;
end;
local function u78(p76, p77) --[[ Line: 370 ]]
    -- upvalues: u59 (ref), u28 (ref)
    if p76.UserInputType == Enum.UserInputType.Touch then
        u59(p76, p77);
    else
        if p76.UserInputType == Enum.UserInputType.MouseButton2 and not p77 then
            u28 = math.max(0, u28 + 1);
        end;
    end;
end;
local function u81(p79, p80) --[[ Line: 379 ]]
    -- upvalues: u69 (ref), u31 (copy)
    if p79.UserInputType == Enum.UserInputType.Touch then
        u69(p79, p80);
    else
        if p79.UserInputType == Enum.UserInputType.MouseMovement then
            local l__Delta__20 = p79.Delta;
            u31.Movement = Vector2.new(l__Delta__20.X, l__Delta__20.Y);
        end;
    end;
end;
local function u84(p82, p83) --[[ Line: 388 ]]
    -- upvalues: u61 (ref), u28 (ref)
    if p82.UserInputType == Enum.UserInputType.Touch then
        u61(p82, p83);
    else
        if p82.UserInputType == Enum.UserInputType.MouseButton2 then
            u28 = math.max(0, u28 - 1);
        end;
    end;
end;
local u85 = false;
function v26.setInputEnabled(p86) --[[ Line: 399 ]]
    -- upvalues: u85 (ref), u53 (copy), u70 (ref), l__ContextActionService__1 (copy), u42 (copy), l__Value__10 (copy), u45 (copy), l__VRService__5 (copy), u49 (copy), u47 (copy), u27 (ref), l__UserInputService__2 (copy), u78 (copy), u81 (copy), u84 (copy), u75 (copy), l__GuiService__6 (copy)
    if u85 == p86 then
    else
        u85 = p86;
        u53();
        u70();
        if u85 then
            l__ContextActionService__1:BindActionAtPriority("RbxCameraThumbstick", u42, false, l__Value__10, Enum.KeyCode.Thumbstick2);
            l__ContextActionService__1:BindActionAtPriority("RbxCameraKeypress", u45, false, l__Value__10, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);
            if l__VRService__5.VREnabled then
                l__ContextActionService__1:BindAction("RbxCameraGamepadReset", u49, false, Enum.KeyCode.ButtonL3);
            end;
            l__ContextActionService__1:BindAction("RbxCameraGamepadZoom", u47, false, Enum.KeyCode.ButtonR3);
            table.insert(u27, l__UserInputService__2.InputBegan:Connect(u78));
            table.insert(u27, l__UserInputService__2.InputChanged:Connect(u81));
            table.insert(u27, l__UserInputService__2.InputEnded:Connect(u84));
            table.insert(u27, l__UserInputService__2.PointerAction:Connect(u75));
            table.insert(u27, l__GuiService__6.MenuOpened:connect(u70));
        else
            l__ContextActionService__1:UnbindAction("RbxCameraThumbstick");
            l__ContextActionService__1:UnbindAction("RbxCameraMouseMove");
            l__ContextActionService__1:UnbindAction("RbxCameraMouseWheel");
            l__ContextActionService__1:UnbindAction("RbxCameraKeypress");
            l__ContextActionService__1:UnbindAction("RbxCameraGamepadZoom");
            if l__VRService__5.VREnabled then
                l__ContextActionService__1:UnbindAction("RbxCameraGamepadReset");
            end;
            for _, v87 in pairs(u27) do
                v87:Disconnect();
            end;
            u27 = {};
        end;
    end;
end;
function v26.getInputEnabled() --[[ Line: 468 ]]
    -- upvalues: u85 (ref)
    return u85;
end;
function v26.resetInputForFrameEnd() --[[ Line: 472 ]]
    -- upvalues: u31 (copy), u32 (copy)
    u31.Movement = Vector2.new();
    u32.Move = Vector2.new();
    u32.Pinch = 0;
    u31.Wheel = 0;
    u31.Pan = Vector2.new();
    u31.Pinch = 0;
end;
l__UserInputService__2.WindowFocused:Connect(u53);
l__UserInputService__2.WindowFocusReleased:Connect(u53);
if v2 then
    l__UserInputService__2.TextBoxFocusReleased:Connect(u53);
end;
local u88 = false;
local u89 = false;
local u90 = 0;
function v26.getHoldPan() --[[ Line: 496 ]]
    -- upvalues: u88 (ref)
    return u88;
end;
function v26.getTogglePan() --[[ Line: 500 ]]
    -- upvalues: u89 (ref)
    return u89;
end;
function v26.getPanning() --[[ Line: 504 ]]
    -- upvalues: u89 (ref), u88 (ref)
    return u89 or u88;
end;
function v26.setTogglePan(p91) --[[ Line: 508 ]]
    -- upvalues: u89 (ref)
    u89 = p91;
end;
local u92 = false;
local u93 = nil;
local u94 = nil;
function v26.enableCameraToggleInput() --[[ Line: 516 ]]
    -- upvalues: u92 (ref), u88 (ref), u89 (ref), u93 (ref), u94 (ref), l__Event__11 (ref), u90 (ref), l__Event__12 (ref), l__UserInputService__2 (copy)
    if u92 then
    else
        u92 = true;
        u88 = false;
        u89 = false;
        if u93 then
            u93:Disconnect();
        end;
        if u94 then
            u94:Disconnect();
        end;
        u93 = l__Event__11:Connect(function() --[[ Line: 533 ]]
            -- upvalues: u88 (ref), u90 (ref)
            u88 = true;
            u90 = tick();
        end);
        u94 = l__Event__12:Connect(function() --[[ Line: 538 ]]
            -- upvalues: u88 (ref), u90 (ref), u89 (ref), l__UserInputService__2 (ref)
            u88 = false;
            if tick() - u90 < 0.3 and (u89 or l__UserInputService__2:GetMouseDelta().Magnitude < 2) then
                u89 = not u89;
            end;
        end);
    end;
end;
function v26.disableCameraToggleInput() --[[ Line: 546 ]]
    -- upvalues: u92 (ref), u93 (ref), u94 (ref)
    if u92 then
        u92 = false;
        if u93 then
            u93:Disconnect();
            u93 = nil;
        end;
        if u94 then
            u94:Disconnect();
            u94 = nil;
        end;
    end;
end;
return v26;