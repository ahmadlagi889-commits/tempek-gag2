-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local u3 = false;
    local u4 = nil;
    local u5 = {};
    local function u9(p6) --[[ Line: 8 ]]
        -- upvalues: u5 (copy), u1 (copy), u3 (ref), u4 (ref)
        for v7 = #u5, p6 and p6 + 1 or 1, -1 do
            local v8 = u5[v7];
            v8.state.isOpened:set(false);
            v8.Instance.BackgroundColor3 = u1._config.HeaderColor;
            v8.Instance.BackgroundTransparency = 1;
            table.remove(u5, v7);
        end;
        if #u5 == 0 then
            u3 = false;
            u4 = nil;
        end;
    end;
    local function u14(p10) --[[ Line: 25 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local v11 = p10.parentWidget.type == "Menu";
        local l__Instance__1 = p10.Instance;
        local l__ChildContainer__2 = p10.ChildContainer;
        l__ChildContainer__2.Size = UDim2.fromOffset(l__Instance__1.AbsoluteSize.X, 0);
        if l__ChildContainer__2.Parent == nil then
        else
            local v12 = l__Instance__1.AbsolutePosition - u2.GuiOffset;
            local l__AbsoluteSize__3 = l__Instance__1.AbsoluteSize;
            local l__AbsoluteSize__4 = l__ChildContainer__2.AbsoluteSize;
            local l__PopupBorderSize__5 = u1._config.PopupBorderSize;
            local l__AbsoluteSize__6 = l__ChildContainer__2.Parent.AbsoluteSize;
            local l__X__7 = v12.X;
            local l__zero__8 = Vector2.zero;
            if v11 then
                if v12.X + l__AbsoluteSize__4.X > l__AbsoluteSize__6.X then
                    l__zero__8 = Vector2.xAxis;
                else
                    l__X__7 = v12.X + l__AbsoluteSize__3.X;
                end;
            end;
            local v13;
            if v12.Y + l__AbsoluteSize__4.Y > l__AbsoluteSize__6.Y then
                v13 = v12.Y - l__PopupBorderSize__5 + (v11 and l__AbsoluteSize__3.Y or 0);
                l__zero__8 = l__zero__8 + Vector2.yAxis;
            else
                v13 = v12.Y + l__PopupBorderSize__5 + (v11 and 0 or l__AbsoluteSize__3.Y);
            end;
            l__ChildContainer__2.Position = UDim2.fromOffset(l__X__7, v13);
            l__ChildContainer__2.AnchorPoint = l__zero__8;
        end;
    end;
    u2.registerEvent("InputBegan", function(p15) --[[ Line: 65 ]]
        -- upvalues: u1 (copy), u3 (ref), u4 (ref), u2 (copy), u5 (copy), u9 (copy)
        if not u1._started then
            return;
        end;
        if p15.UserInputType ~= Enum.UserInputType.MouseButton1 and p15.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return;
        end;
        if u3 == false then
            return;
        end;
        if u4 == nil then
            return;
        end;
        local v16 = u2.getMouseLocation();
        local v17 = false;
        for _, v18 in u5 do
            for _, v19 in { v18.ChildContainer, v18.Instance } do
                local v20 = v19.AbsolutePosition - u2.GuiOffset;
                if u2.isPosInsideRect(v16, v20, v20 + v19.AbsoluteSize) then
                    v17 = true;
                    break;
                end;
            end;
            if v17 then
                break;
            end;
        end;
        if not v17 then
            u9();
        end;
    end);
    u1.WidgetConstructor("MenuBar", {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = function(_) --[[ Name: Generate, Line 107 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v21 = Instance.new("Frame");
            v21.Name = "Iris_MenuBar";
            v21.AutomaticSize = Enum.AutomaticSize.Y;
            v21.Size = UDim2.fromScale(1, 0);
            v21.BackgroundColor3 = u1._config.MenubarBgColor;
            v21.BackgroundTransparency = u1._config.MenubarBgTransparency;
            v21.BorderSizePixel = 0;
            v21.ClipsDescendants = true;
            u2.UIPadding(v21, Vector2.new(u1._config.WindowPadding.X, 1));
            u2.UIListLayout(v21, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyFrameStyle(v21, true, true);
            return v21;
        end,
        Update = function(_) --[[ Name: Update, Line 123 ]] end,
        ChildAdded = function(p22, _) --[[ Name: ChildAdded, Line 126 ]]
            return p22.Instance;
        end,
        Discard = function(p23) --[[ Name: Discard, Line 129 ]]
            p23.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("Menu", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1
        },
        Events = {
            clicked = u2.EVENTS.click(function(p24) --[[ Line: 142 ]]
                return p24.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p25) --[[ Line: 145 ]]
                return p25.Instance;
            end),
            opened = {
                Init = function(_) --[[ Line: 149 ]] end,
                Get = function(p26) --[[ Line: 150 ]]
                    -- upvalues: u1 (copy)
                    return p26.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(_) --[[ Line: 155 ]] end,
                Get = function(p27) --[[ Line: 156 ]]
                    -- upvalues: u1 (copy)
                    return p27.lastClosedTick == u1._cycleTick;
                end
            }
        },
        Generate = function(u28) --[[ Name: Generate, Line 161 ]]
            -- upvalues: u1 (copy), u2 (copy), u5 (copy), u3 (ref), u4 (ref), u9 (copy)
            u28.ButtonColors = {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderHoveredColor,
                ActiveTransparency = u1._config.HeaderHoveredTransparency
            };
            local v29;
            if u28.parentWidget.type == "Menu" then
                v29 = Instance.new("TextButton");
                v29.Name = "Menu";
                v29.AutomaticSize = Enum.AutomaticSize.Y;
                v29.Size = UDim2.fromScale(1, 0);
                v29.BackgroundColor3 = u1._config.HeaderColor;
                v29.BackgroundTransparency = 1;
                v29.BorderSizePixel = 0;
                v29.Text = "";
                v29.AutoButtonColor = false;
                local v30 = u2.UIPadding(v29, u1._config.FramePadding);
                v30.PaddingTop = v30.PaddingTop - UDim.new(0, 1);
                u2.UIListLayout(v29, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v31 = Instance.new("TextLabel");
                v31.Name = "TextLabel";
                v31.AutomaticSize = Enum.AutomaticSize.XY;
                v31.BackgroundTransparency = 1;
                v31.BorderSizePixel = 0;
                u2.applyTextStyle(v31);
                v31.Parent = v29;
                local v32 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                local v33 = v32 - math.round(0.2 * v32) * 2;
                local v34 = Instance.new("ImageLabel");
                v34.Name = "Icon";
                v34.Size = UDim2.fromOffset(v33, v33);
                v34.BackgroundTransparency = 1;
                v34.BorderSizePixel = 0;
                v34.ImageColor3 = u1._config.TextColor;
                v34.ImageTransparency = u1._config.TextTransparency;
                v34.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                v34.LayoutOrder = 1;
                v34.Parent = v29;
            else
                v29 = Instance.new("TextButton");
                v29.Name = "Menu";
                v29.AutomaticSize = Enum.AutomaticSize.XY;
                v29.Size = UDim2.fromScale(0, 0);
                v29.BackgroundColor3 = u1._config.HeaderColor;
                v29.BackgroundTransparency = 1;
                v29.BorderSizePixel = 0;
                v29.Text = "";
                v29.AutoButtonColor = false;
                v29.ClipsDescendants = true;
                u2.applyTextStyle(v29);
                u2.UIPadding(v29, Vector2.new(u1._config.ItemSpacing.X, u1._config.FramePadding.Y));
            end;
            u2.applyInteractionHighlights("Background", v29, v29, u28.ButtonColors);
            u2.applyButtonClick(v29, function() --[[ Line: 229 ]]
                -- upvalues: u5 (ref), u28 (copy), u3 (ref), u4 (ref)
                local v35 = #u5 > 1 and true or not u28.state.isOpened.value;
                u28.state.isOpened:set(v35);
                u3 = v35;
                u4 = v35 and u28 or nil;
                if #u5 <= 1 then
                    if v35 then
                        table.insert(u5, u28);
                        return;
                    end;
                    table.remove(u5);
                end;
            end);
            u2.applyMouseEnter(v29, function() --[[ Line: 245 ]]
                -- upvalues: u3 (ref), u4 (ref), u28 (copy), u5 (ref), u9 (ref)
                if u3 and (u4 and u4 ~= u28) then
                    u9((table.find(u5, u28.parentWidget)));
                    u28.state.isOpened:set(true);
                    u4 = u28;
                    u3 = true;
                    table.insert(u5, u28);
                end;
            end);
            local v36 = Instance.new("ScrollingFrame");
            v36.Name = "MenuContainer";
            v36.AutomaticSize = Enum.AutomaticSize.XY;
            v36.Size = UDim2.fromOffset(0, 0);
            v36.BackgroundColor3 = u1._config.PopupBgColor;
            v36.BackgroundTransparency = u1._config.PopupBgTransparency;
            v36.BorderSizePixel = 0;
            v36.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            v36.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            v36.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            v36.ScrollBarThickness = u1._config.ScrollbarSize;
            v36.CanvasSize = UDim2.fromScale(0, 0);
            v36.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            v36.TopImage = u2.ICONS.BLANK_SQUARE;
            v36.MidImage = u2.ICONS.BLANK_SQUARE;
            v36.BottomImage = u2.ICONS.BLANK_SQUARE;
            v36.ZIndex = 6;
            v36.LayoutOrder = 6;
            v36.ClipsDescendants = true;
            u2.UIStroke(v36, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            u2.UIPadding(v36, Vector2.new(2, u1._config.WindowPadding.Y - u1._config.ItemSpacing.Y));
            u2.UIListLayout(v36, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top;
            local l___rootInstance__9 = u1._rootInstance;
            if l___rootInstance__9 then
                l___rootInstance__9 = u1._rootInstance:FindFirstChild("PopupScreenGui");
            end;
            v36.Parent = l___rootInstance__9;
            u28.ChildContainer = v36;
            return v29;
        end,
        Update = function(p37) --[[ Name: Update, Line 297 ]]
            local l__Instance__10 = p37.Instance;
            if p37.parentWidget.type == "Menu" then
                l__Instance__10 = l__Instance__10.TextLabel;
            end;
            l__Instance__10.Text = p37.arguments.Text or "Menu";
        end,
        ChildAdded = function(p38, _) --[[ Name: ChildAdded, Line 307 ]]
            -- upvalues: u14 (copy)
            u14(p38);
            return p38.ChildContainer;
        end,
        ChildDiscarded = function(p39, _) --[[ Name: ChildDiscarded, Line 311 ]]
            -- upvalues: u14 (copy)
            u14(p39);
        end,
        GenerateState = function(p40) --[[ Name: GenerateState, Line 314 ]]
            -- upvalues: u1 (copy)
            if p40.state.isOpened == nil then
                p40.state.isOpened = u1._widgetState(p40, "isOpened", false);
            end;
        end,
        UpdateState = function(p41) --[[ Name: UpdateState, Line 319 ]]
            -- upvalues: u1 (copy), u14 (copy)
            local l__ChildContainer__11 = p41.ChildContainer;
            if p41.state.isOpened.value then
                p41.lastOpenedTick = u1._cycleTick + 1;
                p41.ButtonColors.Transparency = u1._config.HeaderTransparency;
                l__ChildContainer__11.Visible = true;
                u14(p41);
            else
                p41.lastClosedTick = u1._cycleTick + 1;
                p41.ButtonColors.Transparency = 1;
                l__ChildContainer__11.Visible = false;
            end;
        end,
        Discard = function(p42) --[[ Name: Discard, Line 334 ]]
            -- upvalues: u3 (ref), u5 (copy), u9 (copy), u4 (ref), u2 (copy)
            if u3 then
                local l__parentWidget__12 = p42.parentWidget;
                local v43 = table.find(u5, l__parentWidget__12);
                if v43 then
                    u9(v43);
                    if #u5 ~= 0 then
                        u4 = l__parentWidget__12;
                        u3 = true;
                    end;
                end;
            end;
            p42.Instance:Destroy();
            p42.ChildContainer:Destroy();
            u2.discardState(p42);
        end
    });
    u1.WidgetConstructor("MenuItem", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            clicked = u2.EVENTS.click(function(p44) --[[ Line: 364 ]]
                return p44.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p45) --[[ Line: 367 ]]
                return p45.Instance;
            end)
        },
        Generate = function(u46) --[[ Name: Generate, Line 371 ]]
            -- upvalues: u2 (copy), u1 (copy), u9 (copy), u3 (ref), u4 (ref), u5 (copy)
            local v47 = Instance.new("TextButton");
            v47.Name = "Iris_MenuItem";
            v47.AutomaticSize = Enum.AutomaticSize.Y;
            v47.Size = UDim2.fromScale(1, 0);
            v47.BackgroundTransparency = 1;
            v47.BorderSizePixel = 0;
            v47.Text = "";
            v47.AutoButtonColor = false;
            local v48 = u2.UIPadding(v47, u1._config.FramePadding);
            v48.PaddingTop = v48.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(v47, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
            u2.applyInteractionHighlights("Background", v47, v47, {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderHoveredColor,
                ActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            u2.applyButtonClick(v47, function() --[[ Line: 394 ]]
                -- upvalues: u9 (ref)
                u9();
            end);
            u2.applyMouseEnter(v47, function() --[[ Line: 398 ]]
                -- upvalues: u46 (copy), u3 (ref), u4 (ref), u5 (ref), u9 (ref)
                local l__parentWidget__13 = u46.parentWidget;
                if u3 and (u4 and u4 ~= l__parentWidget__13) then
                    u9((table.find(u5, l__parentWidget__13)));
                    u4 = l__parentWidget__13;
                    u3 = true;
                end;
            end);
            local v49 = Instance.new("TextLabel");
            v49.Name = "TextLabel";
            v49.AutomaticSize = Enum.AutomaticSize.XY;
            v49.BackgroundTransparency = 1;
            v49.BorderSizePixel = 0;
            u2.applyTextStyle(v49);
            v49.Parent = v47;
            local v50 = Instance.new("TextLabel");
            v50.Name = "Shortcut";
            v50.AutomaticSize = Enum.AutomaticSize.XY;
            v50.BackgroundTransparency = 1;
            v50.BorderSizePixel = 0;
            v50.LayoutOrder = 1;
            u2.applyTextStyle(v50);
            v50.Text = "";
            v50.TextColor3 = u1._config.TextDisabledColor;
            v50.TextTransparency = u1._config.TextDisabledTransparency;
            v50.Parent = v47;
            return v47;
        end,
        Update = function(p51) --[[ Name: Update, Line 436 ]]
            local l__Instance__14 = p51.Instance;
            local l__TextLabel__15 = l__Instance__14.TextLabel;
            local l__Shortcut__16 = l__Instance__14.Shortcut;
            l__TextLabel__15.Text = p51.arguments.Text;
            if p51.arguments.KeyCode then
                if p51.arguments.ModifierKey then
                    l__Shortcut__16.Text = p51.arguments.ModifierKey.Name .. " + " .. p51.arguments.KeyCode.Name;
                    return;
                end;
                l__Shortcut__16.Text = p51.arguments.KeyCode.Name;
            end;
        end,
        Discard = function(p52) --[[ Name: Discard, Line 450 ]]
            p52.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("MenuToggle", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            checked = {
                Init = function(_) --[[ Line: 466 ]] end,
                Get = function(p53) --[[ Line: 467 ]]
                    -- upvalues: u1 (copy)
                    return p53.lastCheckedTick == u1._cycleTick;
                end
            },
            unchecked = {
                Init = function(_) --[[ Line: 472 ]] end,
                Get = function(p54) --[[ Line: 473 ]]
                    -- upvalues: u1 (copy)
                    return p54.lastUncheckedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p55) --[[ Line: 477 ]]
                return p55.Instance;
            end)
        },
        Generate = function(u56) --[[ Name: Generate, Line 481 ]]
            -- upvalues: u2 (copy), u1 (copy), u9 (copy), u3 (ref), u4 (ref), u5 (copy)
            local v57 = Instance.new("TextButton");
            v57.Name = "Iris_MenuToggle";
            v57.AutomaticSize = Enum.AutomaticSize.Y;
            v57.Size = UDim2.fromScale(1, 0);
            v57.BackgroundTransparency = 1;
            v57.BorderSizePixel = 0;
            v57.Text = "";
            v57.AutoButtonColor = false;
            local v58 = u2.UIPadding(v57, u1._config.FramePadding);
            v58.PaddingTop = v58.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(v57, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInteractionHighlights("Background", v57, v57, {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderHoveredColor,
                ActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            u2.applyButtonClick(v57, function() --[[ Line: 504 ]]
                -- upvalues: u56 (copy), u9 (ref)
                u56.state.isChecked:set(not u56.state.isChecked.value);
                u9();
            end);
            u2.applyMouseEnter(v57, function() --[[ Line: 509 ]]
                -- upvalues: u56 (copy), u3 (ref), u4 (ref), u5 (ref), u9 (ref)
                local l__parentWidget__17 = u56.parentWidget;
                if u3 and (u4 and u4 ~= l__parentWidget__17) then
                    u9((table.find(u5, l__parentWidget__17)));
                    u4 = l__parentWidget__17;
                    u3 = true;
                end;
            end);
            local v59 = Instance.new("TextLabel");
            v59.Name = "TextLabel";
            v59.AutomaticSize = Enum.AutomaticSize.XY;
            v59.BackgroundTransparency = 1;
            v59.BorderSizePixel = 0;
            u2.applyTextStyle(v59);
            v59.Parent = v57;
            local v60 = Instance.new("TextLabel");
            v60.Name = "Shortcut";
            v60.AutomaticSize = Enum.AutomaticSize.XY;
            v60.BackgroundTransparency = 1;
            v60.BorderSizePixel = 0;
            v60.LayoutOrder = 1;
            u2.applyTextStyle(v60);
            v60.Text = "";
            v60.TextColor3 = u1._config.TextDisabledColor;
            v60.TextTransparency = u1._config.TextDisabledTransparency;
            v60.Parent = v57;
            local v61 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v62 = v61 - math.round(0.2 * v61) * 2;
            local v63 = Instance.new("ImageLabel");
            v63.Name = "Icon";
            v63.Size = UDim2.fromOffset(v62, v62);
            v63.BackgroundTransparency = 1;
            v63.BorderSizePixel = 0;
            v63.ImageColor3 = u1._config.TextColor;
            v63.ImageTransparency = u1._config.TextTransparency;
            v63.Image = u2.ICONS.CHECKMARK;
            v63.LayoutOrder = 2;
            v63.Parent = v57;
            return v57;
        end,
        GenerateState = function(p64) --[[ Name: GenerateState, Line 563 ]]
            -- upvalues: u1 (copy)
            if p64.state.isChecked == nil then
                p64.state.isChecked = u1._widgetState(p64, "isChecked", false);
            end;
        end,
        Update = function(p65) --[[ Name: Update, Line 568 ]]
            local l__Instance__18 = p65.Instance;
            local l__TextLabel__19 = l__Instance__18.TextLabel;
            local l__Shortcut__20 = l__Instance__18.Shortcut;
            l__TextLabel__19.Text = p65.arguments.Text;
            if p65.arguments.KeyCode then
                if p65.arguments.ModifierKey then
                    l__Shortcut__20.Text = p65.arguments.ModifierKey.Name .. " + " .. p65.arguments.KeyCode.Name;
                    return;
                end;
                l__Shortcut__20.Text = p65.arguments.KeyCode.Name;
            end;
        end,
        UpdateState = function(p66) --[[ Name: UpdateState, Line 582 ]]
            -- upvalues: u1 (copy)
            local l__Icon__21 = p66.Instance.Icon;
            if p66.state.isChecked.value then
                l__Icon__21.ImageTransparency = u1._config.TextTransparency;
                p66.lastCheckedTick = u1._cycleTick + 1;
            else
                l__Icon__21.ImageTransparency = 1;
                p66.lastUncheckedTick = u1._cycleTick + 1;
            end;
        end,
        Discard = function(p67) --[[ Name: Discard, Line 594 ]]
            -- upvalues: u2 (copy)
            p67.Instance:Destroy();
            u2.discardState(p67);
        end
    });
end;