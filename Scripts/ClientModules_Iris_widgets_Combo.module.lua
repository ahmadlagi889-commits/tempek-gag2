-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Selectable", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Index = 2,
            NoClick = 3
        },
        Events = {
            selected = {
                Init = function(_) --[[ Line: 15 ]] end,
                Get = function(p3) --[[ Line: 16 ]]
                    -- upvalues: u1 (copy)
                    return p3.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(_) --[[ Line: 21 ]] end,
                Get = function(p4) --[[ Line: 22 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(_) --[[ Line: 27 ]] end,
                Get = function(p5) --[[ Line: 28 ]]
                    return p5.state.index.value == p5.arguments.Index;
                end
            },
            clicked = u2.EVENTS.click(function(p6) --[[ Line: 32 ]]
                return p6.Instance.SelectableButton;
            end),
            rightClicked = u2.EVENTS.rightClick(function(p7) --[[ Line: 36 ]]
                return p7.Instance.SelectableButton;
            end),
            doubleClicked = u2.EVENTS.doubleClick(function(p8) --[[ Line: 40 ]]
                return p8.Instance.SelectableButton;
            end),
            ctrlClicked = u2.EVENTS.ctrlClick(function(p9) --[[ Line: 44 ]]
                return p9.Instance.SelectableButton;
            end),
            hovered = u2.EVENTS.hover(function(p10) --[[ Line: 48 ]]
                return p10.Instance.SelectableButton;
            end)
        },
        Generate = function(u11) --[[ Name: Generate, Line 53 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v12 = Instance.new("Frame");
            v12.Name = "Iris_Selectable";
            v12.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, u1._config.TextSize + 2 * u1._config.FramePadding.Y - u1._config.ItemSpacing.Y));
            v12.BackgroundTransparency = 1;
            v12.BorderSizePixel = 0;
            local v13 = Instance.new("TextButton");
            v13.Name = "SelectableButton";
            v13.Size = UDim2.new(1, 0, 0, u1._config.TextSize + 2 * u1._config.FramePadding.Y);
            v13.Position = UDim2.fromOffset(0, -bit32.rshift(u1._config.ItemSpacing.Y, 1));
            v13.BackgroundColor3 = u1._config.HeaderColor;
            v13.ClipsDescendants = true;
            u2.applyFrameStyle(v13);
            u2.applyTextStyle(v13);
            u2.UISizeConstraint(v13, Vector2.xAxis);
            u11.ButtonColors = {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderActiveColor,
                ActiveTransparency = u1._config.HeaderActiveTransparency
            };
            u2.applyInteractionHighlights("Background", v13, v13, u11.ButtonColors);
            u2.applyButtonClick(v13, function() --[[ Line: 82 ]]
                -- upvalues: u11 (copy)
                if u11.arguments.NoClick ~= true then
                    if type(u11.state.index.value) == "boolean" then
                        u11.state.index:set(not u11.state.index.value);
                        return;
                    end;
                    u11.state.index:set(u11.arguments.Index);
                end;
            end);
            v13.Parent = v12;
            return v12;
        end,
        GenerateState = function(p14) --[[ Name: GenerateState, Line 96 ]]
            -- upvalues: u1 (copy)
            if p14.state.index == nil then
                if p14.arguments.Index ~= nil then
                    error("A shared state index is required for Iris.Selectables() with an Index argument.", 5);
                end;
                p14.state.index = u1._widgetState(p14, "index", false);
            end;
        end,
        Update = function(p15) --[[ Name: Update, Line 104 ]]
            p15.Instance.SelectableButton.Text = p15.arguments.Text or "Selectable";
        end,
        UpdateState = function(p16) --[[ Name: UpdateState, Line 109 ]]
            -- upvalues: u1 (copy)
            local l__SelectableButton__1 = p16.Instance.SelectableButton;
            if p16.state.index.value == p16.arguments.Index or p16.state.index.value == true then
                p16.ButtonColors.Transparency = u1._config.HeaderTransparency;
                l__SelectableButton__1.BackgroundTransparency = u1._config.HeaderTransparency;
                p16.lastSelectedTick = u1._cycleTick + 1;
            else
                p16.ButtonColors.Transparency = 1;
                l__SelectableButton__1.BackgroundTransparency = 1;
                p16.lastUnselectedTick = u1._cycleTick + 1;
            end;
        end,
        Discard = function(p17) --[[ Name: Discard, Line 123 ]]
            -- upvalues: u2 (copy)
            p17.Instance:Destroy();
            u2.discardState(p17);
        end
    });
    local u18 = false;
    local u19 = -1;
    local u20 = nil;
    local u21 = 0;
    local function u28(p22) --[[ Line: 134 ]]
        -- upvalues: u2 (copy), u1 (copy), u21 (ref)
        local l__PreviewContainer__2 = p22.Instance.PreviewContainer;
        local l__ChildContainer__3 = p22.ChildContainer;
        local v23 = l__PreviewContainer__2.AbsolutePosition - u2.GuiOffset;
        local l__AbsoluteSize__4 = l__PreviewContainer__2.AbsoluteSize;
        local l__PopupBorderSize__5 = u1._config.PopupBorderSize;
        local l__AbsoluteSize__6 = l__ChildContainer__3.Parent.AbsoluteSize;
        local l__Y__7 = p22.UIListLayout.AbsoluteContentSize.Y;
        u21 = l__Y__7;
        local v24 = l__Y__7 + 2 * u1._config.WindowPadding.Y;
        local l__X__8 = v23.X;
        local v25 = v23.Y + l__AbsoluteSize__4.Y + l__PopupBorderSize__5;
        local l__zero__9 = Vector2.zero;
        local v26 = l__AbsoluteSize__6.Y - v25;
        if v26 < v24 and l__AbsoluteSize__6.Y / 2 < v25 then
            v25 = v23.Y - l__PopupBorderSize__5;
            l__zero__9 = Vector2.yAxis;
            v26 = v25;
        end;
        l__ChildContainer__3.AnchorPoint = l__zero__9;
        l__ChildContainer__3.Position = UDim2.fromOffset(l__X__8, v25);
        local v27 = math.min(v24, v26);
        l__ChildContainer__3.Size = UDim2.fromOffset(l__PreviewContainer__2.AbsoluteSize.X, v27);
    end;
    table.insert(u1._postCycleCallbacks, function() --[[ Line: 169 ]]
        -- upvalues: u18 (ref), u20 (ref), u21 (ref), u28 (copy)
        if u18 and (u20 and u20.UIListLayout.AbsoluteContentSize.Y ~= u21) then
            u28(u20);
        end;
    end);
    local function v31(p29) --[[ Line: 178 ]]
        -- upvalues: u1 (copy), u18 (ref), u20 (ref), u19 (ref), u2 (copy)
        if u1._started then
            if p29.UserInputType == Enum.UserInputType.MouseButton1 or (p29.UserInputType == Enum.UserInputType.MouseButton2 or (p29.UserInputType == Enum.UserInputType.Touch or p29.UserInputType == Enum.UserInputType.MouseWheel)) then
                if u18 == false or not u20 then
                elseif u19 == u1._cycleTick then
                else
                    local v30 = u2.getMouseLocation();
                    local l__PreviewContainer__10 = u20.Instance.PreviewContainer;
                    local l__ChildContainer__11 = u20.ChildContainer;
                    if u2.isPosInsideRect(v30, l__PreviewContainer__10.AbsolutePosition - u2.GuiOffset, l__PreviewContainer__10.AbsolutePosition - u2.GuiOffset + l__PreviewContainer__10.AbsoluteSize) then
                    elseif u2.isPosInsideRect(v30, l__ChildContainer__11.AbsolutePosition - u2.GuiOffset, l__ChildContainer__11.AbsolutePosition - u2.GuiOffset + l__ChildContainer__11.AbsoluteSize) then
                    else
                        u20.state.isOpened:set(false);
                    end;
                end;
            end;
        end;
    end;
    u2.registerEvent("InputBegan", v31);
    u2.registerEvent("InputChanged", v31);
    u1.WidgetConstructor("Combo", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1,
            NoButton = 2,
            NoPreview = 3
        },
        Events = {
            opened = {
                Init = function(_) --[[ Line: 226 ]] end,
                Get = function(p32) --[[ Line: 227 ]]
                    -- upvalues: u1 (copy)
                    return p32.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(_) --[[ Line: 232 ]] end,
                Get = function(p33) --[[ Line: 233 ]]
                    -- upvalues: u1 (copy)
                    return p33.lastClosedTick == u1._cycleTick;
                end
            },
            changed = {
                Init = function(_) --[[ Line: 238 ]] end,
                Get = function(p34) --[[ Line: 239 ]]
                    -- upvalues: u1 (copy)
                    return p34.lastChangedTick == u1._cycleTick;
                end
            },
            clicked = u2.EVENTS.click(function(p35) --[[ Line: 243 ]]
                return p35.Instance.PreviewContainer;
            end),
            hovered = u2.EVENTS.hover(function(p36) --[[ Line: 247 ]]
                return p36.Instance;
            end)
        },
        Generate = function(u37) --[[ Name: Generate, Line 251 ]]
            -- upvalues: u1 (copy), u2 (copy), u18 (ref), u20 (ref)
            local v38 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v39 = Instance.new("Frame");
            v39.Name = "Iris_Combo";
            v39.AutomaticSize = Enum.AutomaticSize.Y;
            v39.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v39.BackgroundTransparency = 1;
            v39.BorderSizePixel = 0;
            u2.UIListLayout(v39, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v40 = Instance.new("TextButton");
            v40.Name = "PreviewContainer";
            v40.AutomaticSize = Enum.AutomaticSize.Y;
            v40.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            v40.BackgroundTransparency = 1;
            v40.Text = "";
            v40.AutoButtonColor = false;
            v40.ZIndex = 2;
            u2.applyFrameStyle(v40, true);
            u2.UIListLayout(v40, Enum.FillDirection.Horizontal, UDim.new(0, 0));
            u2.UISizeConstraint(v40, Vector2.new(v38));
            v40.Parent = v39;
            local v41 = Instance.new("TextLabel");
            v41.Name = "PreviewLabel";
            v41.AutomaticSize = Enum.AutomaticSize.Y;
            v41.Size = UDim2.new(UDim.new(1, 0), u1._config.ContentHeight);
            v41.BackgroundColor3 = u1._config.FrameBgColor;
            v41.BackgroundTransparency = u1._config.FrameBgTransparency;
            v41.BorderSizePixel = 0;
            v41.ClipsDescendants = true;
            u2.applyTextStyle(v41);
            u2.UIPadding(v41, u1._config.FramePadding);
            v41.Parent = v40;
            local v42 = Instance.new("TextLabel");
            v42.Name = "DropdownButton";
            v42.Size = UDim2.new(0, v38, u1._config.ContentHeight.Scale, (math.max(u1._config.ContentHeight.Offset, v38)));
            v42.BackgroundColor3 = u1._config.ButtonColor;
            v42.BackgroundTransparency = u1._config.ButtonTransparency;
            v42.BorderSizePixel = 0;
            v42.Text = "";
            local v43 = v38 - math.round(v38 * 0.2) * 2;
            local v44 = Instance.new("ImageLabel");
            v44.Name = "Dropdown";
            v44.AnchorPoint = Vector2.new(0.5, 0.5);
            v44.Size = UDim2.fromOffset(v43, v43);
            v44.Position = UDim2.fromScale(0.5, 0.5);
            v44.BackgroundTransparency = 1;
            v44.BorderSizePixel = 0;
            v44.ImageColor3 = u1._config.TextColor;
            v44.ImageTransparency = u1._config.TextTransparency;
            v44.Parent = v42;
            v42.Parent = v40;
            u2.applyInteractionHighlightsWithMultiHighlightee("Background", v40, {
                {
                    v41,
                    {
                        Color = u1._config.FrameBgColor,
                        Transparency = u1._config.FrameBgTransparency,
                        HoveredColor = u1._config.FrameBgHoveredColor,
                        HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ActiveColor = u1._config.FrameBgActiveColor,
                        ActiveTransparency = u1._config.FrameBgActiveTransparency
                    }
                },
                {
                    v42,
                    {
                        Color = u1._config.ButtonColor,
                        Transparency = u1._config.ButtonTransparency,
                        HoveredColor = u1._config.ButtonHoveredColor,
                        HoveredTransparency = u1._config.ButtonHoveredTransparency,
                        ActiveColor = u1._config.ButtonHoveredColor,
                        ActiveTransparency = u1._config.ButtonHoveredTransparency
                    }
                }
            });
            u2.applyButtonClick(v40, function() --[[ Line: 345 ]]
                -- upvalues: u18 (ref), u20 (ref), u37 (copy)
                if u18 and u20 ~= u37 then
                else
                    u37.state.isOpened:set(not u37.state.isOpened.value);
                end;
            end);
            local v45 = Instance.new("TextLabel");
            v45.Name = "TextLabel";
            v45.AutomaticSize = Enum.AutomaticSize.X;
            v45.Size = UDim2.fromOffset(0, v38);
            v45.BackgroundTransparency = 1;
            v45.BorderSizePixel = 0;
            u2.applyTextStyle(v45);
            v45.Parent = v39;
            local v46 = Instance.new("ScrollingFrame");
            v46.Name = "ComboContainer";
            v46.BackgroundColor3 = u1._config.PopupBgColor;
            v46.BackgroundTransparency = u1._config.PopupBgTransparency;
            v46.BorderSizePixel = 0;
            v46.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            v46.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            v46.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            v46.ScrollBarThickness = u1._config.ScrollbarSize;
            v46.CanvasSize = UDim2.fromScale(0, 0);
            v46.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            v46.TopImage = u2.ICONS.BLANK_SQUARE;
            v46.MidImage = u2.ICONS.BLANK_SQUARE;
            v46.BottomImage = u2.ICONS.BLANK_SQUARE;
            v46.ClipsDescendants = true;
            u2.UIStroke(v46, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            u2.UIPadding(v46, Vector2.new(2, u1._config.WindowPadding.Y));
            u2.UISizeConstraint(v46, Vector2.new(100));
            local v47 = u2.UIListLayout(v46, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            v47.VerticalAlignment = Enum.VerticalAlignment.Top;
            local l___rootInstance__12 = u1._rootInstance;
            if l___rootInstance__12 then
                l___rootInstance__12 = u1._rootInstance:WaitForChild("PopupScreenGui");
            end;
            v46.Parent = l___rootInstance__12;
            u37.ChildContainer = v46;
            u37.UIListLayout = v47;
            return v39;
        end,
        GenerateState = function(u48) --[[ Name: GenerateState, Line 401 ]]
            -- upvalues: u1 (copy)
            if u48.state.index == nil then
                u48.state.index = u1._widgetState(u48, "index", "No Selection");
            end;
            if u48.state.isOpened == nil then
                u48.state.isOpened = u1._widgetState(u48, "isOpened", false);
            end;
            u48.state.index:onChange(function() --[[ Line: 409 ]]
                -- upvalues: u48 (copy), u1 (ref)
                u48.lastChangedTick = u1._cycleTick + 1;
                if u48.state.isOpened.value then
                    u48.state.isOpened:set(false);
                end;
            end);
        end,
        Update = function(p49) --[[ Name: Update, Line 416 ]]
            -- upvalues: u1 (copy)
            local l__Instance__13 = p49.Instance;
            local l__PreviewContainer__14 = l__Instance__13.PreviewContainer;
            local l__PreviewLabel__15 = l__PreviewContainer__14.PreviewLabel;
            local l__DropdownButton__16 = l__PreviewContainer__14.DropdownButton;
            l__Instance__13.TextLabel.Text = p49.arguments.Text or "Combo";
            if p49.arguments.NoButton then
                l__DropdownButton__16.Visible = false;
                l__PreviewLabel__15.Size = UDim2.new(UDim.new(1, 0), l__PreviewLabel__15.Size.Height);
            else
                l__DropdownButton__16.Visible = true;
                l__PreviewLabel__15.Size = UDim2.new(UDim.new(1, -(u1._config.TextSize + 2 * u1._config.FramePadding.Y)), l__PreviewLabel__15.Size.Height);
            end;
            if p49.arguments.NoPreview then
                l__PreviewLabel__15.Visible = false;
                l__PreviewContainer__14.Size = UDim2.new(0, 0, 0, 0);
                l__PreviewContainer__14.AutomaticSize = Enum.AutomaticSize.XY;
            else
                l__PreviewLabel__15.Visible = true;
                l__PreviewContainer__14.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
                l__PreviewContainer__14.AutomaticSize = Enum.AutomaticSize.Y;
            end;
        end,
        UpdateState = function(p50) --[[ Name: UpdateState, Line 444 ]]
            -- upvalues: u18 (ref), u20 (ref), u19 (ref), u1 (copy), u2 (copy), u28 (copy)
            local l__Instance__17 = p50.Instance;
            local l__ChildContainer__18 = p50.ChildContainer;
            local l__PreviewContainer__19 = l__Instance__17.PreviewContainer;
            local l__PreviewLabel__20 = l__PreviewContainer__19.PreviewLabel;
            local l__Dropdown__21 = l__PreviewContainer__19.DropdownButton.Dropdown;
            if p50.state.isOpened.value then
                u18 = true;
                u20 = p50;
                u19 = u1._cycleTick;
                p50.lastOpenedTick = u1._cycleTick + 1;
                l__Dropdown__21.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                l__ChildContainer__18.Visible = true;
                u28(p50);
            else
                if u18 then
                    u18 = false;
                    u20 = nil;
                    p50.lastClosedTick = u1._cycleTick + 1;
                end;
                l__Dropdown__21.Image = u2.ICONS.DOWN_POINTING_TRIANGLE;
                l__ChildContainer__18.Visible = false;
            end;
            local l__value__22 = p50.state.index.value;
            local v51;
            if typeof(l__value__22) == "EnumItem" then
                v51 = l__value__22.Name;
            else
                v51 = tostring(l__value__22);
            end;
            l__PreviewLabel__20.Text = v51;
        end,
        ChildAdded = function(p52, _) --[[ Name: ChildAdded, Line 476 ]]
            -- upvalues: u28 (copy)
            u28(p52);
            return p52.ChildContainer;
        end,
        Discard = function(p53) --[[ Name: Discard, Line 480 ]]
            -- upvalues: u20 (ref), u18 (ref), u2 (copy)
            if u20 and u20 == p53 then
                u20 = nil;
                u18 = false;
            end;
            p53.Instance:Destroy();
            p53.ChildContainer:Destroy();
            u2.discardState(p53);
        end
    });
end;