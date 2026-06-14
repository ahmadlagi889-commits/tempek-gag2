-- Decompiled with Potassium's decompiler.

return function(u1) --[[ Line: 1 ]]
    local u2 = Instance.new("Frame");
    u2.Name = "Dropdown";
    u2.AutomaticSize = Enum.AutomaticSize.XY;
    u2.BackgroundTransparency = 1;
    u2.BorderSizePixel = 0;
    u2.AnchorPoint = Vector2.new(0.5, 0);
    u2.Position = UDim2.new(0.5, 0, 1, 10);
    u2.ZIndex = -2;
    u2.ClipsDescendants = true;
    u2.Parent = u1.widget;
    local v3 = Instance.new("UICorner");
    v3.Name = "DropdownCorner";
    v3.CornerRadius = UDim.new(0, 10);
    v3.Parent = u2;
    local u4 = Instance.new("ScrollingFrame");
    u4.Name = "DropdownScroller";
    u4.AutomaticSize = Enum.AutomaticSize.X;
    u4.BackgroundTransparency = 1;
    u4.BorderSizePixel = 0;
    u4.AnchorPoint = Vector2.new(0, 0);
    u4.Position = UDim2.new(0, 0, 0, 0);
    u4.ZIndex = -1;
    u4.ClipsDescendants = true;
    u4.Visible = true;
    u4.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
    u4.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
    u4.Active = false;
    u4.ScrollingEnabled = true;
    u4.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    u4.ScrollBarThickness = 5;
    u4.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    u4.ScrollBarImageTransparency = 0.8;
    u4.CanvasSize = UDim2.new(0, 0, 0, 0);
    u4.Selectable = false;
    u4.Active = true;
    u4.Parent = u2;
    local u5 = Instance.new("UIPadding");
    u5.Name = "DropdownPadding";
    u5.PaddingTop = UDim.new(0, 8);
    u5.PaddingBottom = UDim.new(0, 8);
    u5.Parent = u4;
    local v6 = Instance.new("UIListLayout");
    v6.Name = "DropdownList";
    v6.FillDirection = Enum.FillDirection.Vertical;
    v6.SortOrder = Enum.SortOrder.LayoutOrder;
    v6.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v6.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    v6.Parent = u4;
    local l__dropdownJanitor__1 = u1.dropdownJanitor;
    local l__iconModule__2 = require(u1.iconModule);
    u1.dropdownChildAdded:Connect(function(u7) --[[ Line: 58 ]]
        local _, u8 = u7:modifyTheme({
            { "Widget", "BorderSize", 0 },
            { "IconCorners", "CornerRadius", UDim.new(0, 4) },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 56 },
            { "IconLabel", "TextSize", 19 },
            { "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
            { "Notice", "Position", UDim2.new(1, -24, 0, 5) },
            { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
            { "Selection", "Size", UDim2.new(1, -8, 1, -8) },
            { "Selection", "Position", UDim2.new(0, 4, 0, 4) }
        });
        task.defer(function() --[[ Line: 72 ]]
            -- upvalues: u7 (copy), u8 (copy)
            u7.joinJanitor:add(function() --[[ Line: 73 ]]
                -- upvalues: u7 (ref), u8 (ref)
                u7:removeModification(u8);
            end);
        end);
    end);
    u1.dropdownSet:Connect(function(p9) --[[ Line: 78 ]]
        -- upvalues: u1 (copy), l__iconModule__2 (copy)
        for _, v10 in pairs(u1.dropdownIcons) do
            l__iconModule__2.getIconByUID(v10):destroy();
        end;
        local _ = #p9;
        if type(p9) == "table" then
            for _, v11 in pairs(p9) do
                v11:joinDropdown(u1);
            end;
        end;
    end);
    local l__Utility__3 = require(script.Parent.Parent.Utility);
    l__dropdownJanitor__1:add(u1.toggled:Connect(function() --[[ Name: updateVisibility, Line 95 ]]
        -- upvalues: l__Utility__3 (copy), u2 (copy), u1 (copy)
        l__Utility__3.setVisible(u2, u1.isSelected, "InternalDropdown");
    end));
    l__Utility__3.setVisible(u2, u1.isSelected, "InternalDropdown");
    local u12 = 0;
    local u13 = false;
    local function u27() --[[ Line: 107 ]]
        -- upvalues: u12 (ref), u13 (ref), u27 (copy), u2 (copy), u4 (copy), l__iconModule__2 (copy), u1 (copy), u5 (copy)
        u12 = u12 + 1;
        if u13 then
            return;
        end;
        local u14 = u12;
        u13 = true;
        task.defer(function() --[[ Line: 116 ]]
            -- upvalues: u13 (ref), u12 (ref), u14 (copy), u27 (ref)
            u13 = false;
            if u12 ~= u14 then
                u27();
            end;
        end);
        local v15 = u2:GetAttribute("MaxIcons");
        if not v15 then
            return;
        end;
        local v16 = {};
        for _, v17 in pairs(u4:GetChildren()) do
            if v17:IsA("GuiObject") then
                table.insert(v16, { v17, v17.AbsolutePosition.Y });
            end;
        end;
        table.sort(v16, function(p18, p19) --[[ Line: 133 ]]
            return p18[2] < p19[2];
        end);
        local v20 = 0;
        local v21 = false;
        for v22 = 1, v15 do
            local v23 = v16[v22];
            if not v23 then
                break;
            end;
            local v24 = v23[1];
            v20 = v20 + v24.AbsoluteSize.Y;
            local v25 = v24:GetAttribute("WidgetUID");
            if v25 then
                v25 = l__iconModule__2.getIconByUID(v25);
            end;
            if v25 then
                local v26;
                if v21 then
                    v26 = nil;
                else
                    v26 = u1:getInstance("ClickRegion");
                    v21 = true;
                end;
                v25:getInstance("ClickRegion").NextSelectionUp = v26;
            end;
        end;
        u4.Size = UDim2.fromOffset(0, v20 + u5.PaddingTop.Offset + u5.PaddingBottom.Offset);
    end;
    l__dropdownJanitor__1:add(u4:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(u27));
    l__dropdownJanitor__1:add(u4.ChildAdded:Connect(u27));
    l__dropdownJanitor__1:add(u4.ChildRemoved:Connect(u27));
    l__dropdownJanitor__1:add(u2:GetAttributeChangedSignal("MaxIcons"):Connect(u27));
    l__dropdownJanitor__1:add(u1.childThemeModified:Connect(u27));
    u27();
    return u2;
end;