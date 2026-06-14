-- Decompiled with Potassium's decompiler.

game:GetService("UserInputService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Signal__2 = require(l__ReplicatedStorage__1.ClientModules.Signal);
local l__Trove__3 = require(l__ReplicatedStorage__1.ClientModules.Trove);
local u1 = {};
u1.__index = u1;
function u1.new(p2, _, p3, p4) --[[ Line: 11 ]]
    -- upvalues: u1 (copy), l__Trove__3 (copy), l__Signal__2 (copy)
    local v5 = setmetatable({}, u1);
    v5.Cleaner = p3 or l__Trove__3.new();
    v5.Clicked = l__Signal__2.new();
    if p4 then
        v5.MouseDown = l__Signal__2.new();
        v5.MouseUp = l__Signal__2.new();
    end;
    v5.Button = p2;
    v5._ClickedState = false;
    v5:Init();
    return v5;
end;
function u1.Init(u6) --[[ Line: 30 ]]
    u6.Cleaner:Add(u6.Button.InputBegan:Connect(function(p7) --[[ Line: 31 ]]
        -- upvalues: u6 (copy)
        if (p7.UserInputType == Enum.UserInputType.MouseButton1 or p7.UserInputType == Enum.UserInputType.Touch and p7.UserInputState == Enum.UserInputState.Begin) and true or p7.KeyCode == Enum.KeyCode.ButtonA then
            if u6.MouseDown then
                u6.MouseDown:Fire();
            end;
            u6._ClickedState = true;
        end;
    end));
    u6.Cleaner:Add(u6.Button.InputEnded:Connect(function(p8) --[[ Line: 45 ]]
        -- upvalues: u6 (copy)
        if (p8.UserInputType == Enum.UserInputType.MouseButton1 or p8.UserInputType == Enum.UserInputType.Touch) and true or p8.KeyCode == Enum.KeyCode.ButtonA then
            if u6.MouseUp then
                u6.MouseUp:Fire();
            end;
            local v9 = u6:GetClickedState();
            u6._ClickedState = false;
            if v9 then
                u6.Clicked:Fire();
            end;
        end;
    end));
    u6.Cleaner:Add(u6.Button.Destroying:Once(function() --[[ Line: 64 ]]
        -- upvalues: u6 (copy)
        u6:Destroy();
    end));
end;
function u1.Destroy(p10) --[[ Line: 69 ]]
    if p10.MouseDown then
        p10.MouseDown:DisconnectAll();
        p10.MouseDown:Destroy();
    end;
    if p10.MouseUp then
        p10.MouseUp:DisconnectAll();
        p10.MouseUp:Destroy();
    end;
    p10.Clicked:DisconnectAll();
    p10.Clicked:Destroy();
    p10.Cleaner:Destroy();
end;
function u1.GetClickedState(p11) --[[ Line: 85 ]]
    return p11._ClickedState;
end;
return u1;