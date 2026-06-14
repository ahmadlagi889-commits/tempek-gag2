-- Decompiled with Potassium's decompiler.

local l__GuiService__1 = game:GetService("GuiService");
local l__MenuState__2 = script.Parent:WaitForChild("MenuState");
l__GuiService__1.MenuOpened:Connect(function() --[[ Line: 24 ]]
    -- upvalues: l__MenuState__2 (copy)
    l__MenuState__2:FireServer(true);
end);
l__GuiService__1.MenuClosed:Connect(function() --[[ Line: 27 ]]
    -- upvalues: l__MenuState__2 (copy)
    l__MenuState__2:FireServer(false);
end);