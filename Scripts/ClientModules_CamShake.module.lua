-- Decompiled with Potassium's decompiler.

local l__CameraShaker__1 = require(script.CameraShaker);
local l__CurrentCamera__2 = workspace.CurrentCamera;
local v2 = l__CameraShaker__1.new(Enum.RenderPriority.Camera.Value, function(p1) --[[ Line: 3 ]]
    -- upvalues: l__CurrentCamera__2 (copy)
    l__CurrentCamera__2.CFrame = l__CurrentCamera__2.CFrame * p1;
end);
v2:Start();
return v2;