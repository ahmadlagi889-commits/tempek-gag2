-- Decompiled with Potassium's decompiler.

local l__GamepadService__1 = game:GetService("GamepadService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__GuiService__3 = game:GetService("GuiService");
local u1 = {};
local u2 = nil;
function u1.start(p3) --[[ Line: 24 ]]
    -- upvalues: u2 (ref), l__GuiService__3 (copy), l__UserInputService__2 (copy), u1 (copy), l__GamepadService__1 (copy)
    u2 = p3;
    u2.highlightKey = Enum.KeyCode.DPadUp;
    u2.highlightIcon = false;
    task.delay(1, function() --[[ Line: 33 ]]
        -- upvalues: u2 (ref), l__GuiService__3 (ref), l__UserInputService__2 (ref), u1 (ref), l__GamepadService__1 (ref)
        local l__iconsDictionary__4 = u2.iconsDictionary;
        local u4 = nil;
        local u5 = false;
        local u6 = false;
        require(script.Parent.Parent.Utility);
        local l__Selection__5 = require(script.Parent.Parent.Elements.Selection);
        local function u10() --[[ Line: 50 ]]
            -- upvalues: l__GuiService__3 (ref), l__iconsDictionary__4 (copy), l__UserInputService__2 (ref), l__Selection__5 (copy), u2 (ref), u4 (ref), u6 (ref), u5 (ref), u1 (ref)
            local l__SelectedObject__6 = l__GuiService__3.SelectedObject;
            if l__SelectedObject__6 then
                l__SelectedObject__6 = l__SelectedObject__6:GetAttribute("CorrespondingIconUID");
            end;
            if l__SelectedObject__6 then
                l__SelectedObject__6 = l__iconsDictionary__4[l__SelectedObject__6];
            end;
            local l__GamepadEnabled__7 = l__UserInputService__2.GamepadEnabled;
            if l__SelectedObject__6 then
                if l__GamepadEnabled__7 then
                    local v7 = l__SelectedObject__6:getInstance("ClickRegion");
                    local l__selection__8 = l__SelectedObject__6.selection;
                    if not l__selection__8 then
                        l__selection__8 = l__SelectedObject__6.janitor:add(l__Selection__5(u2));
                        l__selection__8:SetAttribute("IgnoreVisibilityUpdater", true);
                        l__selection__8.Parent = l__SelectedObject__6.widget;
                        l__SelectedObject__6.selection = l__selection__8;
                        l__SelectedObject__6:refreshAppearance(l__selection__8);
                    end;
                    v7.SelectionImageObject = l__selection__8.Selection;
                end;
                if u4 and u4 ~= l__SelectedObject__6 then
                    u4:setIndicator();
                end;
                local v8;
                if l__GamepadEnabled__7 and not (u6 or l__SelectedObject__6.parentIconUID) then
                    v8 = Enum.KeyCode.ButtonB;
                else
                    v8 = nil;
                end;
                u4 = l__SelectedObject__6;
                u2.lastHighlightedIcon = l__SelectedObject__6;
                l__SelectedObject__6:setIndicator(v8);
            else
                local v9;
                if l__GamepadEnabled__7 and not u5 then
                    v9 = u2.highlightKey;
                else
                    v9 = nil;
                end;
                if not u4 then
                    u4 = u1.getIconToHighlight();
                end;
                if v9 == u2.highlightKey then
                    u5 = true;
                end;
                if u4 then
                    u4:setIndicator(v9);
                end;
            end;
        end;
        l__GuiService__3:GetPropertyChangedSignal("SelectedObject"):Connect(u10);
        local function v11() --[[ Line: 93 ]]
            -- upvalues: l__UserInputService__2 (ref), u5 (ref), u6 (ref), u10 (copy)
            if not l__UserInputService__2.GamepadEnabled then
                u5 = false;
                u6 = false;
            end;
            u10();
        end;
        l__UserInputService__2:GetPropertyChangedSignal("GamepadEnabled"):Connect(v11);
        if not l__UserInputService__2.GamepadEnabled then
            u5 = false;
            u6 = false;
        end;
        u10();
        l__UserInputService__2.InputBegan:Connect(function(p12, _) --[[ Line: 107 ]]
            -- upvalues: l__GuiService__3 (ref), l__iconsDictionary__4 (copy), u2 (ref), u1 (ref), l__GamepadService__1 (ref)
            if p12.UserInputType == Enum.UserInputType.MouseButton1 then
                local l__SelectedObject__9 = l__GuiService__3.SelectedObject;
                if l__SelectedObject__9 then
                    l__SelectedObject__9 = l__SelectedObject__9:GetAttribute("CorrespondingIconUID");
                end;
                if l__SelectedObject__9 then
                    l__SelectedObject__9 = l__iconsDictionary__4[l__SelectedObject__9];
                end;
                if l__SelectedObject__9 then
                    l__GuiService__3.SelectedObject = nil;
                end;
            elseif p12.KeyCode == u2.highlightKey then
                local v13 = u1.getIconToHighlight();
                if v13 then
                    if l__GamepadService__1.GamepadCursorEnabled then
                        task.wait(0.2);
                        l__GamepadService__1:DisableGamepadCursor();
                    end;
                    l__GuiService__3.SelectedObject = v13:getInstance("ClickRegion");
                end;
            end;
        end);
    end);
end;
function u1.getIconToHighlight() --[[ Line: 134 ]]
    -- upvalues: u2 (ref)
    local l__iconsDictionary__10 = u2.iconsDictionary;
    local v14 = u2.highlightIcon or u2.lastHighlightedIcon;
    if not v14 then
        local v15 = nil;
        for _, v16 in pairs(l__iconsDictionary__10) do
            if not v16.parentIconUID and (not v15 or v16.widget.AbsolutePosition.X < v15) then
                v15 = v16.widget.AbsolutePosition.X;
                v14 = v16;
            end;
        end;
    end;
    return v14;
end;
function u1.registerButton(u17) --[[ Line: 156 ]]
    -- upvalues: l__UserInputService__2 (copy), l__GamepadService__1 (copy), l__GuiService__3 (copy)
    local u18 = false;
    u17.InputBegan:Connect(function(_) --[[ Line: 162 ]]
        -- upvalues: u18 (ref)
        u18 = true;
        task.wait();
        task.wait();
        u18 = false;
    end);
    local u21 = l__UserInputService__2.InputBegan:Connect(function(p19) --[[ Line: 171 ]]
        -- upvalues: u18 (ref), l__GamepadService__1 (ref), l__GuiService__3 (ref), u17 (copy)
        task.wait();
        if p19.KeyCode == Enum.KeyCode.ButtonA and u18 then
            task.wait(0.2);
            l__GamepadService__1:DisableGamepadCursor();
            l__GuiService__3.SelectedObject = u17;
        else
            local v20 = l__GuiService__3.SelectedObject == u17;
            local l__Name__11 = p19.KeyCode.Name;
            if table.find({ "ButtonB", "ButtonSelect" }, l__Name__11) and (v20 and (l__Name__11 ~= "ButtonSelect" or l__GamepadService__1.GamepadCursorEnabled)) then
                l__GuiService__3.SelectedObject = nil;
            end;
        end;
    end);
    u17.Destroying:Once(function() --[[ Line: 192 ]]
        -- upvalues: u21 (copy)
        u21:Disconnect();
    end);
end;
return u1;