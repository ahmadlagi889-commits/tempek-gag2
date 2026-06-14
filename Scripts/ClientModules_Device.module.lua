-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local l__UserInputService__1 = game:GetService("UserInputService");
local u2 = {
    DeviceChanged = require(script.Parent.Signal).new(),
    GetCurrentDevice = function(_) --[[ Name: GetCurrentDevice, Line 13 ]]
        -- upvalues: l__UserInputService__1 (copy)
        local v1 = l__UserInputService__1:GetLastInputType();
        return v1 == Enum.UserInputType.Touch and "Touch" or ((v1 == Enum.UserInputType.Keyboard or string.find(v1.Name, "Mouse", 1, true)) and "PC" or (string.find(v1.Name, "Gamepad", 1, true) and "Gamepad" or "PC"));
    end
};
function u2.Observe(_, u3) --[[ Line: 26 ]]
    -- upvalues: u2 (copy)
    local u4 = u2.DeviceChanged:Connect(function() --[[ Line: 27 ]]
        -- upvalues: u3 (copy), u2 (ref)
        task.spawn(u3, u2:GetCurrentDevice());
    end);
    task.spawn(u3, u2:GetCurrentDevice());
    return function() --[[ Line: 33 ]]
        -- upvalues: u4 (copy)
        u4:Disconnect();
    end;
end;
function u2.Start(_) --[[ Line: 38 ]]
    -- upvalues: u2 (copy), l__UserInputService__1 (copy)
    local u5 = nil;
    l__UserInputService__1.LastInputTypeChanged:Connect(function() --[[ Name: updateInput, Line 40 ]]
        -- upvalues: u2 (ref), u5 (ref)
        local v6 = u2:GetCurrentDevice();
        if v6 == u5 then
        else
            u5 = v6;
            u2.DeviceChanged:Fire(v6);
        end;
    end);
    local v7 = u2:GetCurrentDevice();
    if v7 ~= u5 then
        u5 = v7;
        u2.DeviceChanged:Fire(v7);
    end;
end;
task.spawn(u2.Start, u2);
return u2;