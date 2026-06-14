-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__ButtonMash__2 = l__LocalPlayer__1.PlayerGui:WaitForChild("ButtonMash");
local l__Button__3 = l__ButtonMash__2.Button;
local l__Frame__4 = l__Button__3.ProgressBar.Frame;
local u2 = false;
function v1.Disable() --[[ Line: 15 ]]
    -- upvalues: u2 (ref)
    u2 = false;
end;
function v1.Start(u3, u4) --[[ Line: 19 ]]
    -- upvalues: u2 (ref), l__ButtonMash__2 (copy), l__Frame__4 (copy), l__Button__3 (copy), l__LocalPlayer__1 (copy)
    if not u2 then
        u2 = true;
        l__ButtonMash__2.Enabled = true;
        l__Frame__4.Size = UDim2.fromScale(0, 1);
        local u5 = 0;
        task.spawn(function() --[[ Line: 35 ]]
            -- upvalues: u2 (ref), u4 (copy), u5 (ref), l__Frame__4 (ref)
            while u2 do
                task.wait(u4 or 0.5);
                u5 = math.clamp(u5 - 0.1, 0, 1);
                l__Frame__4.Size = UDim2.fromScale(u5, 1);
            end;
        end);
        local u6 = nil;
        local v7 = {};
        local l__InputBegan__5 = game:GetService("UserInputService").InputBegan;
        table.insert(v7, l__InputBegan__5:Connect(function(p8, p9) --[[ Line: 58 ]]
            -- upvalues: l__Button__3 (ref), u5 (ref), u3 (copy), l__Frame__4 (ref), u2 (ref), u6 (ref)
            if not p9 and (p8.KeyCode == Enum.KeyCode.Space or p8.KeyCode == Enum.KeyCode.ButtonA) then
                if p8.KeyCode == Enum.KeyCode.ButtonA then
                    l__Button__3.HoverOver.Visible = true;
                    task.delay(0.1, function() --[[ Line: 64 ]]
                        -- upvalues: l__Button__3 (ref)
                        l__Button__3.HoverOver.Visible = false;
                    end);
                end;
                u5 = math.min(u5 + u3, 1);
                l__Frame__4.Size = UDim2.fromScale(u5, 1);
                if u5 == 1 then
                    u2 = false;
                    u6 = "Success";
                end;
            end;
        end));
        table.insert(v7, l__Button__3.MouseButton1Down:Connect(function() --[[ Line: 73 ]]
            -- upvalues: u5 (ref), u3 (copy), l__Frame__4 (ref), u2 (ref), u6 (ref)
            u5 = math.min(u5 + u3, 1);
            l__Frame__4.Size = UDim2.fromScale(u5, 1);
            if u5 == 1 then
                u2 = false;
                u6 = "Success";
            end;
        end));
        table.insert(v7, l__LocalPlayer__1.CharacterAdded:Connect(function() --[[ Line: 77 ]]
            -- upvalues: u6 (ref)
            u6 = false;
        end));
        local function v11() --[[ Line: 83 ]]
            -- upvalues: l__Button__3 (ref)
            local v10 = game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Touch and "PRESS ME" or (game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1 and game:GetService("GuiService"):IsTenFootInterface() and "ButtonA" or "SPACE");
            if v10 == "ButtonA" then
                l__Button__3.TextGroup.Visible = false;
                l__Button__3.GamepadIcon.Visible = true;
                l__Button__3.GamepadIcon.Image = game:GetService("UserInputService"):GetImageForKeyCode(Enum.KeyCode.ButtonA);
            else
                l__Button__3.GamepadIcon.Visible = false;
                l__Button__3.TextGroup.Visible = true;
            end;
            l__Button__3.TextGroup.TextLabel.Text = v10;
            l__Button__3.TextGroup.TextLabel.TextLabel.Text = v10;
        end;
        v11();
        local l__LastInputTypeChanged__6 = game:GetService("UserInputService").LastInputTypeChanged;
        table.insert(v7, l__LastInputTypeChanged__6:Connect(v11));
        repeat
            task.wait();
        until u6 or not u2;
        local v12 = u6 or false;
        for _, v13 in v7 do
            v13:Disconnect();
        end;
        l__ButtonMash__2.Enabled = false;
        return v12;
    end;
end;
return v1;