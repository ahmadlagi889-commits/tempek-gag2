-- Decompiled with Potassium's decompiler.

local l__CommonUtils__1 = script.Parent.Parent:WaitForChild("CommonUtils");
local l__FlagUtil__2 = require(l__CommonUtils__1:WaitForChild("FlagUtil"));
local l__Value__3 = Enum.ContextActionPriority.Medium.Value;
local l__Players__4 = game:GetService("Players");
local l__ContextActionService__5 = game:GetService("ContextActionService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__GameSettings__7 = UserSettings().GameSettings;
local l__CameraUtils__8 = require(script.Parent:WaitForChild("CameraUtils"));
local u1 = l__FlagUtil__2.getUserFlag("UserFixStuckShiftLock");
local u2 = {};
u2.__index = u2;
function u2.new() --[[ Line: 33 ]]
    -- upvalues: u2 (copy), l__GameSettings__7 (copy), l__Players__4 (copy), l__UserInputService__6 (copy)
    local u3 = setmetatable({}, u2);
    u3.isMouseLocked = false;
    u3.savedMouseCursor = nil;
    u3.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift };
    u3.mouseLockToggledEvent = Instance.new("BindableEvent");
    local v4 = script:FindFirstChild("BoundKeys");
    if not (v4 and v4:IsA("StringValue")) then
        if v4 then
            v4:Destroy();
        end;
        v4 = Instance.new("StringValue");
        assert(v4, "");
        v4.Name = "BoundKeys";
        v4.Value = "LeftShift,RightShift";
        v4.Parent = script;
    end;
    if v4 then
        v4.Changed:Connect(function(p5) --[[ Line: 58 ]]
            -- upvalues: u3 (copy)
            u3:OnBoundKeysObjectChanged(p5);
        end);
        u3:OnBoundKeysObjectChanged(v4.Value);
    end;
    l__GameSettings__7.Changed:Connect(function(p6) --[[ Line: 65 ]]
        -- upvalues: u3 (copy)
        if p6 == "ControlMode" or p6 == "ComputerMovementMode" then
            u3:UpdateMouseLockAvailability();
        end;
    end);
    l__Players__4.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() --[[ Line: 72 ]]
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    l__Players__4.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() --[[ Line: 77 ]]
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    l__UserInputService__6:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 81 ]]
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    u3:UpdateMouseLockAvailability();
    return u3;
end;
function u2.GetIsMouseLocked(p7) --[[ Line: 90 ]]
    return p7.isMouseLocked;
end;
function u2.GetBindableToggleEvent(p8) --[[ Line: 94 ]]
    return p8.mouseLockToggledEvent.Event;
end;
function u2.GetMouseLockOffset(_) --[[ Line: 98 ]]
    return Vector3.new(1.75, 0, 0);
end;
function u2.UpdateMouseLockAvailability(p9) --[[ Line: 102 ]]
    -- upvalues: l__Players__4 (copy), l__GameSettings__7 (copy), l__UserInputService__6 (copy)
    local l__DevEnableMouseLock__9 = l__Players__4.LocalPlayer.DevEnableMouseLock;
    local v10 = l__Players__4.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable;
    local v11 = l__UserInputService__6.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and (l__DevEnableMouseLock__9 and (l__GameSettings__7.ControlMode == Enum.ControlMode.MouseLockSwitch and l__GameSettings__7.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove));
    if v11 then
        v11 = not v10;
    end;
    if v11 ~= p9.enabled then
        p9:EnableMouseLock(v11);
    end;
end;
function u2.OnBoundKeysObjectChanged(p12, p13) --[[ Line: 115 ]]
    p12.boundKeys = {};
    for v14 in string.gmatch(p13, "[^%s,]+") do
        for _, v15 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v14 == v15.Name then
                p12.boundKeys[#p12.boundKeys + 1] = v15;
                break;
            end;
        end;
    end;
    p12:UnbindContextActions();
    p12:BindContextActions();
end;
function u2.OnMouseLockToggled(p16) --[[ Line: 130 ]]
    -- upvalues: l__CameraUtils__8 (copy)
    p16.isMouseLocked = not p16.isMouseLocked;
    if p16.isMouseLocked then
        local v17 = script:FindFirstChild("CursorImage");
        if v17 and (v17:IsA("StringValue") and v17.Value) then
            l__CameraUtils__8.setMouseIconOverride(v17.Value);
        else
            if v17 then
                v17:Destroy();
            end;
            local v18 = Instance.new("StringValue");
            assert(v18, "");
            v18.Name = "CursorImage";
            v18.Value = "rbxasset://textures/MouseLockedCursor.png";
            v18.Parent = script;
            l__CameraUtils__8.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png");
        end;
    else
        l__CameraUtils__8.restoreMouseIcon();
    end;
    p16.mouseLockToggledEvent:Fire();
end;
function u2.DoMouseLockSwitch(p19, _, p20, _) --[[ Line: 155 ]]
    if p20 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;
    p19:OnMouseLockToggled();
    return Enum.ContextActionResult.Sink;
end;
function u2.BindContextActions(u21) --[[ Line: 163 ]]
    -- upvalues: l__ContextActionService__5 (copy), l__Value__3 (copy)
    l__ContextActionService__5:BindActionAtPriority("MouseLockSwitchAction", function(p22, p23, p24) --[[ Line: 164 ]]
        -- upvalues: u21 (copy)
        return u21:DoMouseLockSwitch(p22, p23, p24);
    end, false, l__Value__3, unpack(u21.boundKeys));
end;
function u2.UnbindContextActions(_) --[[ Line: 169 ]]
    -- upvalues: l__ContextActionService__5 (copy)
    l__ContextActionService__5:UnbindAction("MouseLockSwitchAction");
end;
function u2.IsMouseLocked(p25) --[[ Line: 173 ]]
    local l__enabled__10 = p25.enabled;
    if l__enabled__10 then
        l__enabled__10 = p25.isMouseLocked;
    end;
    return l__enabled__10;
end;
function u2.EnableMouseLock(p26, p27) --[[ Line: 177 ]]
    -- upvalues: l__CameraUtils__8 (copy), u1 (copy)
    if p27 ~= p26.enabled then
        p26.enabled = p27;
        if p26.enabled then
            p26:BindContextActions();
            return;
        end;
        l__CameraUtils__8.restoreMouseIcon();
        p26:UnbindContextActions();
        if u1 then
            if p26.isMouseLocked then
                p26.isMouseLocked = false;
                p26.mouseLockToggledEvent:Fire();
            end;
        else
            if p26.isMouseLocked then
                p26.mouseLockToggledEvent:Fire();
            end;
            p26.isMouseLocked = false;
        end;
    end;
end;
return u2;