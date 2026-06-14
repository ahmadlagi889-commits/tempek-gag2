-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__RunService__2 = game:GetService("RunService");
local u1 = nil;
local u2 = 0;
local function u4() --[[ Line: 19 ]]
    -- upvalues: u1 (ref), u2 (ref)
    if u1 then
        local v3 = os.clock();
        if v3 < u1.t or v3 - u2 < u1.interval then
        else
            u2 = v3;
            u1.callback(v3 - u1.t);
        end;
    end;
end;
local function u6() --[[ Line: 33 ]]
    -- upvalues: u1 (ref), u2 (ref)
    if u1 then
        if u1.conn then
            u1.conn:Disconnect();
            u1.conn = nil;
        end;
        local v5 = os.clock();
        if u1.t <= v5 then
            task.spawn(u1.callback, v5 - u1.t, true);
        end;
        u2 = 0;
        u1 = nil;
    end;
end;
l__UserInputService__1.InputEnded:Connect(function(p7, _) --[[ Line: 50 ]]
    -- upvalues: u6 (copy)
    if p7.UserInputType == Enum.UserInputType.MouseButton1 or (p7.UserInputType == Enum.UserInputType.Touch or p7.KeyCode == Enum.KeyCode.ButtonA) then
        u6();
    end;
end);
return function(u8, u9, u10) --[[ Line: 56 ]]
    -- upvalues: u6 (copy), u1 (ref), l__RunService__2 (copy), u4 (copy)
    local u11 = u8.MouseButton1Down:Connect(function() --[[ Line: 57 ]]
        -- upvalues: u6 (ref), u1 (ref), u8 (copy), u10 (copy), u9 (copy), l__RunService__2 (ref), u4 (ref)
        u6();
        u1 = {
            button = u8,
            t = os.clock() + (u10 and u10.minimumHoldTime or 0),
            interval = u10 and u10.interval or 0,
            callback = u9,
            conn = l__RunService__2.PostSimulation:Connect(u4)
        };
    end);
    local u12 = u8.MouseButton1Up:Connect(function() --[[ Line: 69 ]]
        -- upvalues: u1 (ref), u8 (copy), u6 (ref)
        if u1 and u1.button == u8 then
            u6();
        end;
    end);
    local u13 = u8.Destroying:Once(function() --[[ Line: 75 ]]
        -- upvalues: u1 (ref), u8 (copy), u6 (ref)
        if u1 and u1.button == u8 then
            u6();
        end;
    end);
    return function() --[[ Line: 81 ]]
        -- upvalues: u13 (copy), u11 (copy), u12 (copy)
        u13:Disconnect();
        u11:Disconnect();
        u12:Disconnect();
    end;
end;