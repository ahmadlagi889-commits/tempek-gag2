-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 3
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Networking__5 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__AntiAfkFlags__6 = require(l__ReplicatedStorage__2.SharedModules.Flags.AntiAfkFlags);
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local u2 = os.clock();
local u3 = false;
local function u4() --[[ Line: 27 ]]
    -- upvalues: u2 (ref), u3 (ref)
    u2 = os.clock();
    u3 = false;
end;
function v1.Init(_) --[[ Line: 40 ]] end;
function v1.Start(_) --[[ Line: 43 ]]
    -- upvalues: l__UserInputService__4 (copy), u2 (ref), u3 (ref), u4 (copy), l__RunService__3 (copy), l__AntiAfkFlags__6 (copy), l__LocalPlayer__7 (copy), l__Networking__5 (copy)
    l__UserInputService__4.InputBegan:Connect(function(p5) --[[ Line: 47 ]]
        -- upvalues: u2 (ref), u3 (ref)
        local l__UserInputType__8 = p5.UserInputType;
        if l__UserInputType__8 == Enum.UserInputType.Keyboard or (l__UserInputType__8 == Enum.UserInputType.MouseButton1 or (l__UserInputType__8 == Enum.UserInputType.MouseButton2 or (l__UserInputType__8 == Enum.UserInputType.MouseButton3 or l__UserInputType__8 == Enum.UserInputType.Gamepad1))) then
            u2 = os.clock();
            u3 = false;
        end;
    end);
    l__UserInputService__4.InputChanged:Connect(function(p6) --[[ Line: 59 ]]
        -- upvalues: l__UserInputService__4 (ref), u2 (ref), u3 (ref)
        if p6.UserInputType == Enum.UserInputType.MouseMovement then
            if l__UserInputService__4:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                u2 = os.clock();
                u3 = false;
            end;
        else
            if (p6.KeyCode == Enum.KeyCode.Thumbstick1 or p6.KeyCode == Enum.KeyCode.Thumbstick2) and p6.Position.Magnitude > 0.15 then
                u2 = os.clock();
                u3 = false;
            end;
        end;
    end);
    l__UserInputService__4.TouchStarted:Connect(u4);
    l__UserInputService__4.TouchMoved:Connect(u4);
    task.spawn(function() --[[ Line: 82 ]]
        -- upvalues: l__RunService__3 (ref), l__AntiAfkFlags__6 (ref), u3 (ref), u2 (ref), l__LocalPlayer__7 (ref), l__Networking__5 (ref)
        while task.wait(1) do
            if not l__RunService__3:IsStudio() and (l__AntiAfkFlags__6.Enabled:Get() and not u3) then
                local v7 = os.clock() - u2;
                local v8 = l__LocalPlayer__7:GetAttribute("AntiAfkIdleOverride");
                if type(v8) ~= "number" or v8 <= 0 then
                    v8 = l__AntiAfkFlags__6.IdleSeconds:Get();
                end;
                if v8 <= v7 then
                    u3 = true;
                    l__Networking__5.AntiAfk.RequestHop:Fire();
                end;
            end;
        end;
    end);
end;
return v1;