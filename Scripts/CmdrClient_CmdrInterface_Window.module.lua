-- Decompiled with Potassium's decompiler.

local l__GuiService__1 = game:GetService("GuiService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__TextChatService__3 = game:GetService("TextChatService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local u1 = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch };
local u2 = {
    Valid = true,
    AutoComplete = nil,
    ProcessEntry = nil,
    OnTextChanged = nil,
    Cmdr = nil,
    HistoryState = nil
};
local l__Frame__5 = l__LocalPlayer__4:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame");
local l__Line__6 = l__Frame__5:WaitForChild("Line");
local l__Entry__7 = l__Frame__5:WaitForChild("Entry");
l__Line__6.Parent = nil;
function u2.UpdateLabel(p3) --[[ Line: 29 ]]
    -- upvalues: l__Entry__7 (copy), l__LocalPlayer__4 (copy)
    l__Entry__7.TextLabel.Text = l__LocalPlayer__4.Name .. "@" .. p3.Cmdr.PlaceName .. "$";
end;
function u2.GetLabel(_) --[[ Line: 34 ]]
    -- upvalues: l__Entry__7 (copy)
    return l__Entry__7.TextLabel.Text;
end;
function u2.UpdateWindowHeight(_) --[[ Line: 39 ]]
    -- upvalues: l__Frame__5 (copy)
    local v4 = l__Frame__5.UIListLayout.AbsoluteContentSize.Y + l__Frame__5.UIPadding.PaddingTop.Offset + l__Frame__5.UIPadding.PaddingBottom.Offset;
    l__Frame__5.Size = UDim2.new(l__Frame__5.Size.X.Scale, l__Frame__5.Size.X.Offset, 0, (math.clamp(v4, 0, 300)));
    l__Frame__5.CanvasPosition = Vector2.new(0, v4);
end;
function u2.AddLine(p5, p6, p7) --[[ Line: 48 ]]
    -- upvalues: u2 (copy), l__Line__6 (copy), l__Frame__5 (copy)
    local v8 = p7 or {};
    local v9 = tostring(p6);
    local v10 = typeof(v8) == "Color3" and {
        Color = v8
    } or v8;
    if #v9 == 0 then
        u2:UpdateWindowHeight();
    else
        local v11 = p5.Cmdr.Util.EmulateTabstops(v9 or "nil", 8);
        local v12 = l__Line__6:Clone();
        v12.Text = v11;
        v12.TextColor3 = v10.Color or v12.TextColor3;
        v12.RichText = v10.RichText or false;
        v12.Parent = l__Frame__5;
    end;
end;
function u2.IsVisible(_) --[[ Line: 71 ]]
    -- upvalues: l__Frame__5 (copy)
    return l__Frame__5.Visible;
end;
function u2.SetVisible(p13, p14) --[[ Line: 76 ]]
    -- upvalues: l__Frame__5 (copy), l__TextChatService__3 (copy), l__Entry__7 (copy), l__UserInputService__2 (copy)
    l__Frame__5.Visible = p14;
    if p14 then
        p13.PreviousChatWindowConfigurationEnabled = l__TextChatService__3.ChatWindowConfiguration.Enabled;
        p13.PreviousChatInputBarConfigurationEnabled = l__TextChatService__3.ChatInputBarConfiguration.Enabled;
        l__TextChatService__3.ChatWindowConfiguration.Enabled = false;
        l__TextChatService__3.ChatInputBarConfiguration.Enabled = false;
        l__Entry__7.TextBox:CaptureFocus();
        p13:SetEntryText("");
        if p13.Cmdr.ActivationUnlocksMouse then
            p13.PreviousMouseBehavior = l__UserInputService__2.MouseBehavior;
            l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.Default;
        end;
    else
        l__TextChatService__3.ChatWindowConfiguration.Enabled = p13.PreviousChatWindowConfigurationEnabled == nil and true or p13.PreviousChatWindowConfigurationEnabled;
        l__TextChatService__3.ChatInputBarConfiguration.Enabled = p13.PreviousChatInputBarConfigurationEnabled == nil and true or p13.PreviousChatInputBarConfigurationEnabled;
        l__Entry__7.TextBox:ReleaseFocus();
        p13.AutoComplete:Hide();
        if p13.PreviousMouseBehavior then
            l__UserInputService__2.MouseBehavior = p13.PreviousMouseBehavior;
            p13.PreviousMouseBehavior = nil;
        end;
    end;
end;
function u2.Hide(p15) --[[ Line: 109 ]]
    return p15:SetVisible(false);
end;
function u2.Show(p16) --[[ Line: 114 ]]
    return p16:SetVisible(true);
end;
function u2.SetEntryText(p17, p18) --[[ Line: 119 ]]
    -- upvalues: l__Entry__7 (copy), u2 (copy)
    l__Entry__7.TextBox.Text = p18;
    if p17:IsVisible() then
        l__Entry__7.TextBox:CaptureFocus();
        l__Entry__7.TextBox.CursorPosition = #p18 + 1;
        u2:UpdateWindowHeight();
    end;
end;
function u2.GetEntryText(_) --[[ Line: 130 ]]
    -- upvalues: l__Entry__7 (copy)
    return l__Entry__7.TextBox.Text:gsub("\t", "");
end;
function u2.SetIsValidInput(p19, p20, p21) --[[ Line: 136 ]]
    -- upvalues: l__Entry__7 (copy)
    l__Entry__7.TextBox.TextColor3 = p20 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73);
    p19.Valid = p20;
    p19._errorText = p21;
end;
function u2.HideInvalidState(_) --[[ Line: 142 ]]
    -- upvalues: l__Entry__7 (copy)
    l__Entry__7.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
end;
function u2.LoseFocus(p22, p23) --[[ Line: 147 ]]
    -- upvalues: l__Entry__7 (copy), l__Frame__5 (copy), l__GuiService__1 (copy)
    local l__Text__8 = l__Entry__7.TextBox.Text;
    p22:ClearHistoryState();
    if l__Frame__5.Visible and not l__GuiService__1.MenuIsOpen then
        l__Entry__7.TextBox:CaptureFocus();
    elseif l__GuiService__1.MenuIsOpen and l__Frame__5.Visible then
        p22:Hide();
    end;
    if p23 and p22.Valid then
        wait();
        p22:SetEntryText("");
        p22.ProcessEntry(l__Text__8);
    else
        if p23 then
            p22:AddLine(p22._errorText, Color3.fromRGB(255, 153, 153));
        end;
    end;
end;
function u2.TraverseHistory(p24, p25) --[[ Line: 168 ]]
    local v26 = p24.Cmdr.Dispatcher:GetHistory();
    if p24.HistoryState == nil then
        p24.HistoryState = {
            Position = #v26 + 1,
            InitialText = p24:GetEntryText()
        };
    end;
    p24.HistoryState.Position = math.clamp(p24.HistoryState.Position + p25, 1, #v26 + 1);
    p24:SetEntryText(p24.HistoryState.Position == #v26 + 1 and p24.HistoryState.InitialText or v26[p24.HistoryState.Position]);
end;
function u2.ClearHistoryState(p27) --[[ Line: 186 ]]
    p27.HistoryState = nil;
end;
function u2.SelectVertical(p28, p29) --[[ Line: 190 ]]
    if p28.AutoComplete:IsVisible() and not p28.HistoryState then
        p28.AutoComplete:Select(p29);
    else
        p28:TraverseHistory(p29);
    end;
end;
local u30 = 0;
local u31 = 0;
function u2.BeginInput(p32, p33, p34) --[[ Line: 201 ]]
    -- upvalues: l__GuiService__1 (copy), u30 (ref), u31 (ref), u1 (copy), l__Frame__5 (copy)
    if l__GuiService__1.MenuIsOpen then
        p32:Hide();
    end;
    if p34 and p32:IsVisible() == false then
    elseif p32.Cmdr.ActivationKeys[p33.KeyCode] then
        if p32.Cmdr.MashToEnable and not p32.Cmdr.Enabled then
            if tick() - u30 < 1 then
                if u31 >= 5 then
                    return p32.Cmdr:SetEnabled(true);
                end;
                u31 = u31 + 1;
            else
                u31 = 1;
            end;
            u30 = tick();
        else
            if p32.Cmdr.Enabled then
                p32:SetVisible(not p32:IsVisible());
                wait();
                p32:SetEntryText("");
                if l__GuiService__1.MenuIsOpen then
                    p32:Hide();
                end;
            end;
        end;
    elseif p32.Cmdr.Enabled == false or not p32:IsVisible() then
        if p32:IsVisible() then
            p32:Hide();
        end;
    else
        if p32.Cmdr.HideOnLostFocus and table.find(u1, p33.UserInputType) then
            local l__Position__9 = p33.Position;
            local l__AbsolutePosition__10 = l__Frame__5.AbsolutePosition;
            local l__AbsoluteSize__11 = l__Frame__5.AbsoluteSize;
            if l__Position__9.X < l__AbsolutePosition__10.X or (l__Position__9.X > l__AbsolutePosition__10.X + l__AbsoluteSize__11.X or (l__Position__9.Y < l__AbsolutePosition__10.Y or l__Position__9.Y > l__AbsolutePosition__10.Y + l__AbsoluteSize__11.Y)) then
                p32:Hide();
            end;
        else
            if p33.KeyCode == Enum.KeyCode.Down then
                p32:SelectVertical(1);
                return;
            end;
            if p33.KeyCode == Enum.KeyCode.Up then
                p32:SelectVertical(-1);
                return;
            end;
            if p33.KeyCode == Enum.KeyCode.Return then
                wait();
                p32:SetEntryText(p32:GetEntryText():gsub("\n", ""):gsub("\r", ""));
                return;
            end;
            if p33.KeyCode == Enum.KeyCode.Tab then
                local v35 = p32.AutoComplete:GetSelectedItem();
                local v36 = p32:GetEntryText();
                if v35 and not (v36:sub(#v36, #v36):match("%s") and p32.AutoComplete.LastItem) then
                    local v37 = v35[2];
                    local l__Command__12 = p32.AutoComplete.Command;
                    local v38, v39;
                    if l__Command__12 then
                        local l__Arg__13 = p32.AutoComplete.Arg;
                        v38 = l__Command__12.Alias;
                        if p32.AutoComplete.NumArgs == #l__Command__12.ArgumentDefinitions then
                            v39 = false;
                        else
                            v39 = p32.AutoComplete.IsPartial == false;
                        end;
                        local l__Arguments__14 = l__Command__12.Arguments;
                        for v40 = 1, #l__Arguments__14 do
                            local v41 = l__Arguments__14[v40];
                            local l__RawSegments__15 = v41.RawSegments;
                            if v41 == l__Arg__13 then
                                l__RawSegments__15[#l__RawSegments__15] = v37;
                            end;
                            local v42 = v41.Prefix .. table.concat(l__RawSegments__15, ",");
                            if v42:find(" ") or v42 == "" then
                                v42 = ("%q"):format(v42);
                            end;
                            v38 = ("%s %s"):format(v38, v42);
                            if v41 == l__Arg__13 then
                                break;
                            end;
                        end;
                    else
                        v38 = v37;
                        v39 = true;
                    end;
                    wait();
                    p32:SetEntryText(v38 .. (v39 and " " or ""));
                    return;
                else
                    wait();
                    p32:SetEntryText(p32:GetEntryText());
                    return;
                end;
            end;
            p32:ClearHistoryState();
        end;
    end;
end;
l__Entry__7.TextBox.FocusLost:Connect(function(p43) --[[ Line: 312 ]]
    -- upvalues: u2 (copy)
    return u2:LoseFocus(p43);
end);
l__UserInputService__2.InputBegan:Connect(function(p44, p45) --[[ Line: 316 ]]
    -- upvalues: u2 (copy)
    return u2:BeginInput(p44, p45);
end);
l__Entry__7.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 320 ]]
    -- upvalues: l__Frame__5 (copy), l__Entry__7 (copy), u2 (copy)
    l__Frame__5.CanvasPosition = Vector2.new(0, l__Frame__5.AbsoluteCanvasSize.Y);
    if l__Entry__7.TextBox.Text:match("\t") then
        l__Entry__7.TextBox.Text = l__Entry__7.TextBox.Text:gsub("\t", "");
    else
        if u2.OnTextChanged then
            return u2.OnTextChanged(l__Entry__7.TextBox.Text);
        end;
    end;
end);
l__Frame__5.ChildAdded:Connect(function() --[[ Line: 332 ]]
    -- upvalues: u2 (copy)
    task.defer(u2.UpdateWindowHeight);
end);
return u2;