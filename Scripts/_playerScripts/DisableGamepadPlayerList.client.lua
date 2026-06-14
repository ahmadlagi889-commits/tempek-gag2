-- Decompiled with Potassium's decompiler.

local l__GuiService__1 = game:GetService("GuiService");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__UserInputService__3 = game:GetService("UserInputService");
while true do
    local v1;
    if l__GuiService__1:IsTenFootInterface() then
        v1 = true;
    else
        v1 = l__UserInputService__3.GamepadEnabled and not (l__UserInputService__3.KeyboardEnabled or l__UserInputService__3.MouseEnabled);
        if v1 then
            v1 = not l__UserInputService__3.TouchEnabled;
        end;
    end;
    if v1 then
        pcall(function() --[[ Line: 27 ]]
            -- upvalues: l__StarterGui__2 (copy)
            l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
        end);
    end;
    task.wait(0.5);
end;