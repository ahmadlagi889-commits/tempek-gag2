-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__FocusState__2 = script.Parent:WaitForChild("FocusState");
l__UserInputService__1.WindowFocused:Connect(function() --[[ Line: 24 ]]
    -- upvalues: l__FocusState__2 (copy)
    l__FocusState__2:FireServer(true);
end);
l__UserInputService__1.WindowFocusReleased:Connect(function() --[[ Line: 27 ]]
    -- upvalues: l__FocusState__2 (copy)
    l__FocusState__2:FireServer(false);
end);