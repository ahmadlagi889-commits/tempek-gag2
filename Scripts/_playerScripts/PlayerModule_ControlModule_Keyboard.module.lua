-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ContextActionService__2 = game:GetService("ContextActionService");
script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = Vector3.new();
local l__BaseCharacterController__3 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u2 = setmetatable({}, l__BaseCharacterController__3);
u2.__index = u2;
function u2.new(p3) --[[ Line: 22 ]]
    -- upvalues: l__BaseCharacterController__3 (copy), u2 (copy)
    local v4 = l__BaseCharacterController__3.new();
    local v5 = setmetatable(v4, u2);
    v5.CONTROL_ACTION_PRIORITY = p3;
    v5.forwardValue = 0;
    v5.backwardValue = 0;
    v5.leftValue = 0;
    v5.rightValue = 0;
    v5.jumpEnabled = true;
    return v5;
end;
function u2.Enable(p6, p7) --[[ Line: 37 ]]
    -- upvalues: u1 (copy)
    if p7 == p6.enabled then
        return true;
    end;
    p6.forwardValue = 0;
    p6.backwardValue = 0;
    p6.leftValue = 0;
    p6.rightValue = 0;
    p6.moveVector = u1;
    p6.jumpRequested = false;
    p6:UpdateJump();
    if p7 then
        p6:BindContextActions();
        p6:ConnectFocusEventListeners();
    else
        p6._connectionUtil:disconnectAll();
    end;
    p6.enabled = p7;
    return true;
end;
function u2.UpdateMovement(p8, p9) --[[ Line: 64 ]]
    -- upvalues: u1 (copy)
    if p9 == Enum.UserInputState.Cancel then
        p8.moveVector = u1;
    else
        p8.moveVector = Vector3.new(p8.leftValue + p8.rightValue, 0, p8.forwardValue + p8.backwardValue);
    end;
end;
function u2.UpdateJump(p10) --[[ Line: 72 ]]
    p10.isJumping = p10.jumpRequested;
end;
function u2.BindContextActions(u11) --[[ Line: 76 ]]
    -- upvalues: l__ContextActionService__2 (copy)
    l__ContextActionService__2:BindActionAtPriority("moveForwardAction", function(_, p12, _) --[[ Line: 82 ]]
        -- upvalues: u11 (copy)
        u11.forwardValue = p12 == Enum.UserInputState.Begin and -1 or 0;
        u11:UpdateMovement(p12);
        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward);
    l__ContextActionService__2:BindActionAtPriority("moveBackwardAction", function(_, p13, _) --[[ Line: 88 ]]
        -- upvalues: u11 (copy)
        u11.backwardValue = p13 == Enum.UserInputState.Begin and 1 or 0;
        u11:UpdateMovement(p13);
        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward);
    l__ContextActionService__2:BindActionAtPriority("moveLeftAction", function(_, p14, _) --[[ Line: 94 ]]
        -- upvalues: u11 (copy)
        u11.leftValue = p14 == Enum.UserInputState.Begin and -1 or 0;
        u11:UpdateMovement(p14);
        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft);
    l__ContextActionService__2:BindActionAtPriority("moveRightAction", function(_, p15, _) --[[ Line: 100 ]]
        -- upvalues: u11 (copy)
        u11.rightValue = p15 == Enum.UserInputState.Begin and 1 or 0;
        u11:UpdateMovement(p15);
        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight);
    l__ContextActionService__2:BindActionAtPriority("jumpAction", function(_, p16, _) --[[ Line: 106 ]]
        -- upvalues: u11 (copy)
        local v17 = u11;
        local l__jumpEnabled__4 = u11.jumpEnabled;
        if l__jumpEnabled__4 then
            l__jumpEnabled__4 = p16 == Enum.UserInputState.Begin;
        end;
        v17.jumpRequested = l__jumpEnabled__4;
        u11:UpdateJump();
        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump);
    u11._connectionUtil:trackBoundFunction("moveForwardAction", function() --[[ Line: 125 ]]
        -- upvalues: l__ContextActionService__2 (ref)
        l__ContextActionService__2:UnbindAction("moveForwardAction");
    end);
    u11._connectionUtil:trackBoundFunction("moveBackwardAction", function() --[[ Line: 126 ]]
        -- upvalues: l__ContextActionService__2 (ref)
        l__ContextActionService__2:UnbindAction("moveBackwardAction");
    end);
    u11._connectionUtil:trackBoundFunction("moveLeftAction", function() --[[ Line: 127 ]]
        -- upvalues: l__ContextActionService__2 (ref)
        l__ContextActionService__2:UnbindAction("moveLeftAction");
    end);
    u11._connectionUtil:trackBoundFunction("moveRightAction", function() --[[ Line: 128 ]]
        -- upvalues: l__ContextActionService__2 (ref)
        l__ContextActionService__2:UnbindAction("moveRightAction");
    end);
    u11._connectionUtil:trackBoundFunction("jumpAction", function() --[[ Line: 129 ]]
        -- upvalues: l__ContextActionService__2 (ref)
        l__ContextActionService__2:UnbindAction("jumpAction");
    end);
end;
function u2.ConnectFocusEventListeners(u18) --[[ Line: 132 ]]
    -- upvalues: u1 (copy), l__UserInputService__1 (copy)
    local function v19() --[[ Line: 133 ]]
        -- upvalues: u18 (copy), u1 (ref)
        u18.moveVector = u1;
        u18.forwardValue = 0;
        u18.backwardValue = 0;
        u18.leftValue = 0;
        u18.rightValue = 0;
        u18.jumpRequested = false;
        u18:UpdateJump();
    end;
    u18._connectionUtil:trackConnection("textBoxFocusReleased", l__UserInputService__1.TextBoxFocusReleased:Connect(v19));
    u18._connectionUtil:trackConnection("textBoxFocused", l__UserInputService__1.TextBoxFocused:Connect(function(_) --[[ Name: onTextFocusGained, Line 143 ]]
        -- upvalues: u18 (copy)
        u18.jumpRequested = false;
        u18:UpdateJump();
    end));
    u18._connectionUtil:trackConnection("windowFocusReleased", l__UserInputService__1.WindowFocused:Connect(v19));
end;
return u2;