-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Workspace__2 = game:GetService("Workspace");
local l__Signal__3 = require(script.Parent.Signal);
local l__CurrentCamera__4 = l__Workspace__2.CurrentCamera;
local l__ViewportSize__5 = l__CurrentCamera__4.ViewportSize;
local u1 = math.clamp(l__ViewportSize__5.Y / 1080, 0.33, 2);
local u2 = l__ViewportSize__5;
local u3 = 0;
local u4 = {
    Changed = l__Signal__3.new(),
    GetViewportSize = function() --[[ Name: GetViewportSize, Line 27 ]]
        -- upvalues: l__ViewportSize__5 (ref)
        return l__ViewportSize__5;
    end,
    GetResolutionScale = function() --[[ Name: GetResolutionScale, Line 31 ]]
        -- upvalues: u1 (ref)
        return u1;
    end
};
function u4.Observe(u5) --[[ Line: 35 ]]
    -- upvalues: u4 (copy)
    local u6 = u4.Changed:Connect(function() --[[ Line: 36 ]]
        -- upvalues: u5 (copy)
        task.spawn(u5);
    end);
    task.spawn(u5);
    return function() --[[ Line: 42 ]]
        -- upvalues: u6 (copy)
        u6:Disconnect();
    end;
end;
l__CurrentCamera__4:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 48 ]]
    -- upvalues: l__ViewportSize__5 (ref), l__CurrentCamera__4 (copy), u1 (ref)
    l__ViewportSize__5 = l__CurrentCamera__4.ViewportSize;
    u1 = math.clamp(l__ViewportSize__5.Y / 1080, 0.33, 2);
end);
l__RunService__1.RenderStepped:Connect(function() --[[ Line: 53 ]]
    -- upvalues: l__ViewportSize__5 (ref), u2 (ref), u3 (ref), u4 (copy)
    if l__ViewportSize__5 ~= u2 and os.clock() - u3 >= 0.15 then
        u3 = os.clock();
        u2 = l__ViewportSize__5;
        u4.Changed:Fire();
    end;
end);
return table.freeze(u4);