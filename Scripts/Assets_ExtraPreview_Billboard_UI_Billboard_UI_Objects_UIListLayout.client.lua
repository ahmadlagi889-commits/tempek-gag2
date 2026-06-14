-- Decompiled with Potassium's decompiler.

local l__GamepadService__1 = game:GetService("GamepadService");
local l__GuiService__2 = game:GetService("GuiService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__Device__5 = require(l__ReplicatedStorage__3.ClientModules.Device);
local v1 = l__UserInputService__4.GamepadEnabled and not (l__UserInputService__4.KeyboardEnabled or l__UserInputService__4.MouseEnabled) and true or false;
local function v4() --[[ Line: 13 ]]
    -- upvalues: l__UserInputService__4 (copy)
    local v2 = script.Parent:FindFirstChildOfClass("UIListLayout");
    if v2 then
        local v3;
        if l__UserInputService__4.PreferredInput == Enum.PreferredInput.Touch then
            v3 = UDim.new(0.035, 0);
        else
            v3 = UDim.new(0, 0);
        end;
        v2.Padding = v3;
    end;
end;
l__UserInputService__4:GetPropertyChangedSignal("PreferredInput"):Connect(v4);
task.spawn(v4);
if v1 == true then
    function upd()
        -- upvalues: l__GamepadService__1 (copy)
        if #script.Parent:GetChildren() == 2 then
            l__GamepadService__1:DisableGamepadCursor();
        else
            l__GamepadService__1:EnableGamepadCursor(script.Parent:FindFirstChildWhichIsA("Frame"));
        end;
    end;
    script.Parent.ChildAdded:Connect(upd);
    script.Parent.ChildRemoved:Connect(upd);
end;
local function v8(p5) --[[ Line: 36 ]]
    -- upvalues: l__Device__5 (copy), l__GuiService__2 (copy)
    if p5:IsA("Frame") then
        local v6 = p5:FindFirstChild("Frame");
        if v6 and v6:IsA("GuiObject") then
            local u7 = v6:FindFirstChild("ImageButton");
            if u7 and u7:IsA("GuiButton") then
                p5.MouseEnter:Connect(function() --[[ Line: 51 ]]
                    -- upvalues: l__Device__5 (ref), u7 (copy), l__GuiService__2 (ref)
                    if l__Device__5:GetCurrentDevice() == "Gamepad" then
                        if u7.Parent == nil then
                        else
                            l__GuiService__2.SelectedObject = u7;
                        end;
                    end;
                end);
                u7.Selectable = false;
            end;
        end;
    end;
end;
script.Parent.ChildAdded:Connect(v8);
for _, v9 in script.Parent:GetChildren() do
    task.spawn(v8, v9);
end;