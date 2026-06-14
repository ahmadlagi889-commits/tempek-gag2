-- Decompiled with Potassium's decompiler.

local l__StarterGui__1 = game:GetService("StarterGui");
local l__Window__2 = require(script.Parent.CmdrInterface.Window);
return function(p1) --[[ Line: 4 ]]
    -- upvalues: l__StarterGui__1 (copy), l__Window__2 (copy)
    p1:HandleEvent("Message", function(p2) --[[ Line: 5 ]]
        -- upvalues: l__StarterGui__1 (ref)
        l__StarterGui__1:SetCore("ChatMakeSystemMessage", {
            Text = ("[Announcement] %s"):format(p2),
            Color = Color3.fromRGB(249, 217, 56)
        });
    end);
    p1:HandleEvent("AddLine", function(...) --[[ Line: 12 ]]
        -- upvalues: l__Window__2 (ref)
        l__Window__2:AddLine(...);
    end);
end;