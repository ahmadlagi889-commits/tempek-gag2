-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local function u6() --[[ Line: 4 ]]
        -- upvalues: u1 (copy), u2 (copy)
        if u1._rootInstance == nil then
        else
            local v3 = u1._rootInstance:FindFirstChild("PopupScreenGui");
            local l__TooltipContainer__1 = v3.TooltipContainer;
            local v4 = u2.getMouseLocation();
            local v5 = u2.findBestWindowPosForPopup(v4, l__TooltipContainer__1.AbsoluteSize, u1._config.DisplaySafeAreaPadding, v3.AbsoluteSize);
            l__TooltipContainer__1.Position = UDim2.fromOffset(v5.X, v5.Y);
        end;
    end;
    u2.registerEvent("InputChanged", function() --[[ Line: 15 ]]
        -- upvalues: u1 (copy), u6 (copy)
        if u1._started then
            u6();
        end;
    end);
    u1.WidgetConstructor("Tooltip", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {},
        Generate = function(p7) --[[ Name: Generate, Line 30 ]]
            -- upvalues: u1 (copy), u2 (copy)
            p7.parentWidget = u1._rootWidget;
            local v8 = Instance.new("Frame");
            v8.Name = "Iris_Tooltip";
            v8.AutomaticSize = Enum.AutomaticSize.Y;
            v8.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            v8.BorderSizePixel = 0;
            v8.BackgroundTransparency = 1;
            local v9 = Instance.new("TextLabel");
            v9.Name = "TooltipText";
            v9.AutomaticSize = Enum.AutomaticSize.XY;
            v9.Size = UDim2.fromOffset(0, 0);
            v9.BackgroundColor3 = u1._config.PopupBgColor;
            v9.BackgroundTransparency = u1._config.PopupBgTransparency;
            u2.applyTextStyle(v9);
            u2.UIStroke(v9, u1._config.PopupBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(v9, u1._config.WindowPadding);
            if u1._config.PopupRounding > 0 then
                u2.UICorner(v9, u1._config.PopupRounding);
            end;
            v9.Parent = v8;
            return v8;
        end,
        Update = function(p10) --[[ Name: Update, Line 58 ]]
            -- upvalues: u6 (copy)
            local l__TooltipText__2 = p10.Instance.TooltipText;
            if p10.arguments.Text == nil then
                error("Text argument is required for Iris.Tooltip().", 5);
            end;
            l__TooltipText__2.Text = p10.arguments.Text;
            u6();
        end,
        Discard = function(p11) --[[ Name: Discard, Line 67 ]]
            p11.Instance:Destroy();
        end
    });
    local u12 = 0;
    local u13 = nil;
    local u14 = false;
    local u15 = nil;
    local u16 = nil;
    local u17 = false;
    local u18 = false;
    local u19 = false;
    local l__Top__3 = Enum.TopBottom.Top;
    local l__Left__4 = Enum.LeftRight.Left;
    local u20 = nil;
    local u21 = nil;
    local u22 = false;
    local u23 = {};
    local function u27() --[[ Line: 91 ]]
        -- upvalues: u1 (copy), u23 (copy)
        if u1._config.UseScreenGUIs == false then
        else
            local v24 = 65535;
            local v25 = nil;
            for _, v26 in u23 do
                if v26.state.isOpened.value and (not v26.arguments.NoNav and v26.Instance:IsA("ScreenGui")) then
                    local l__DisplayOrder__5 = v26.Instance.DisplayOrder;
                    if l__DisplayOrder__5 < v24 then
                        v25 = v26;
                        v24 = l__DisplayOrder__5;
                    end;
                end;
            end;
            if v25 then
                if v25.state.isUncollapsed.value == false then
                    v25.state.isUncollapsed:set(true);
                end;
                u1.SetFocusedWindow(v25);
            end;
        end;
    end;
    local function u38(p28, p29) --[[ Line: 122 ]]
        -- upvalues: u1 (copy), u2 (copy)
        local v30 = Vector2.new(p28.state.position.value.X, p28.state.position.value.Y);
        local v31 = (u1._config.TextSize + 2 * u1._config.FramePadding.Y) * 2;
        local v32 = u2.getScreenSizeForWindow(p28);
        local v33 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local v34 = v32 - v30 - v33;
        local l__new__6 = Vector2.new;
        local l__X__7 = p29.X;
        local v35 = math.max(v34.X, v31);
        local v36 = math.clamp(l__X__7, v31, v35);
        local l__Y__8 = p29.Y;
        local v37 = math.max(v34.Y, v31);
        return l__new__6(v36, (math.clamp(l__Y__8, v31, v37)));
    end;
    local function u46(p39, p40) --[[ Line: 132 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local l__Instance__9 = p39.Instance;
        local v41 = u2.getScreenSizeForWindow(p39);
        local v42 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local l__new__10 = Vector2.new;
        local l__X__11 = p40.X;
        local l__X__12 = v42.X;
        local v43 = math.max(v42.X, v41.X - l__Instance__9.WindowButton.AbsoluteSize.X - v42.X);
        local v44 = math.clamp(l__X__11, l__X__12, v43);
        local l__Y__13 = p40.Y;
        local l__Y__14 = v42.Y;
        local v45 = math.max(v42.Y, v41.Y - l__Instance__9.WindowButton.AbsoluteSize.Y - v42.Y);
        return l__new__10(v44, (math.clamp(l__Y__13, l__Y__14, v45)));
    end;
    function u1.SetFocusedWindow(p47) --[[ Line: 143 ]]
        -- upvalues: u21 (ref), u22 (ref), u23 (copy), u1 (copy), u12 (ref), u2 (copy)
        if u21 == p47 then
        else
            if u22 and u21 ~= nil then
                if u23[u21.ID] then
                    local l__WindowButton__15 = u21.Instance.WindowButton;
                    local l__TitleBar__16 = l__WindowButton__15.Content.TitleBar;
                    if u21.state.isUncollapsed.value then
                        l__TitleBar__16.BackgroundColor3 = u1._config.TitleBgColor;
                        l__TitleBar__16.BackgroundTransparency = u1._config.TitleBgTransparency;
                    else
                        l__TitleBar__16.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                        l__TitleBar__16.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                    end;
                    l__WindowButton__15.UIStroke.Color = u1._config.BorderColor;
                end;
                u22 = false;
                u21 = nil;
            end;
            if p47 ~= nil then
                u22 = true;
                u21 = p47;
                local l__Instance__17 = p47.Instance;
                local l__WindowButton__18 = l__Instance__17.WindowButton;
                local l__TitleBar__19 = l__WindowButton__18.Content.TitleBar;
                l__TitleBar__19.BackgroundColor3 = u1._config.TitleBgActiveColor;
                l__TitleBar__19.BackgroundTransparency = u1._config.TitleBgActiveTransparency;
                l__WindowButton__18.UIStroke.Color = u1._config.BorderActiveColor;
                u12 = u12 + 1;
                if p47.usesScreenGuis then
                    l__Instance__17.DisplayOrder = u12 + u1._config.DisplayOrderOffset;
                else
                    l__Instance__17.ZIndex = u12 + u1._config.DisplayOrderOffset;
                end;
                if p47.state.isUncollapsed.value == false then
                    p47.state.isUncollapsed:set(true);
                end;
                if u2.GuiService.SelectedObject then
                    if l__TitleBar__19.Visible then
                        u2.GuiService:Select(l__TitleBar__19);
                        return;
                    end;
                    u2.GuiService:Select(p47.ChildContainer);
                end;
            end;
        end;
    end;
    u2.registerEvent("InputBegan", function(p48) --[[ Line: 204 ]]
        -- upvalues: u1 (copy), u2 (copy), u23 (copy), u27 (copy), u18 (ref), u19 (ref), u22 (ref), u21 (ref), l__Top__3 (ref), l__Left__4 (ref), u17 (ref), u16 (ref)
        if not u1._started then
            return;
        end;
        if p48.UserInputType == Enum.UserInputType.MouseButton1 then
            local v49 = u2.getMouseLocation();
            local v50 = false;
            for _, v51 in u23 do
                local l__Instance__20 = v51.Instance;
                if l__Instance__20 then
                    local l__ResizeBorder__21 = l__Instance__20.WindowButton.ResizeBorder;
                    if l__ResizeBorder__21 and u2.isPosInsideRect(v49, l__ResizeBorder__21.AbsolutePosition - u2.GuiOffset, l__ResizeBorder__21.AbsolutePosition - u2.GuiOffset + l__ResizeBorder__21.AbsoluteSize) then
                        v50 = true;
                        break;
                    end;
                end;
            end;
            if not v50 then
                u1.SetFocusedWindow(nil);
            end;
        end;
        if p48.KeyCode == Enum.KeyCode.Tab and (u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
            u27();
        end;
        if p48.UserInputType == Enum.UserInputType.MouseButton1 and (u18 and (not u19 and (u22 and u21))) then
            local v52 = u21.state.position.value + u21.state.size.value / 2;
            local v53 = u2.getMouseLocation() - v52;
            if math.abs(v53.X) * u21.state.size.value.Y >= math.abs(v53.Y) * u21.state.size.value.X then
                l__Top__3 = Enum.TopBottom.Center;
                local v54;
                if math.sign(v53.X) == -1 then
                    v54 = Enum.LeftRight.Left;
                else
                    v54 = Enum.LeftRight.Right;
                end;
                l__Left__4 = v54;
            else
                l__Left__4 = Enum.LeftRight.Center;
                local v55;
                if math.sign(v53.Y) == -1 then
                    v55 = Enum.TopBottom.Top;
                else
                    v55 = Enum.TopBottom.Bottom;
                end;
                l__Top__3 = v55;
            end;
            u17 = true;
            u16 = u21;
        end;
    end);
    u2.registerEvent("TouchTapInWorld", function(_, p56) --[[ Line: 250 ]]
        -- upvalues: u1 (copy)
        if u1._started then
            if not p56 then
                u1.SetFocusedWindow(nil);
            end;
        end;
    end);
    u2.registerEvent("InputChanged", function(p57) --[[ Line: 259 ]]
        -- upvalues: u1 (copy), u14 (ref), u13 (ref), u2 (copy), u15 (ref), u46 (copy), u17 (ref), u16 (ref), u20 (ref), l__Left__4 (ref), l__Top__3 (ref), u38 (copy)
        if u1._started then
            if u14 and u13 then
                local v58;
                if p57.UserInputType == Enum.UserInputType.Touch then
                    local l__Position__22 = p57.Position;
                    v58 = Vector2.new(l__Position__22.X, l__Position__22.Y);
                else
                    v58 = u2.getMouseLocation();
                end;
                local l__WindowButton__23 = u13.Instance.WindowButton;
                local v59 = u46(u13, v58 - u15);
                l__WindowButton__23.Position = UDim2.fromOffset(v59.X, v59.Y);
                u13.state.position.value = v59;
            end;
            if u17 and (u16 and u16.arguments.NoResize ~= true) then
                local l__WindowButton__24 = u16.Instance.WindowButton;
                local v60 = Vector2.new(l__WindowButton__24.Position.X.Offset, l__WindowButton__24.Position.Y.Offset);
                local v61 = Vector2.new(l__WindowButton__24.Size.X.Offset, l__WindowButton__24.Size.Y.Offset);
                local v62;
                if p57.UserInputType == Enum.UserInputType.Touch then
                    v62 = p57.Delta;
                else
                    v62 = u2.getMouseLocation() - u20;
                end;
                local v63 = v60 + Vector2.new(l__Left__4 ~= Enum.LeftRight.Left and 0 or v62.X, l__Top__3 ~= Enum.TopBottom.Top and 0 or v62.Y);
                local l__new__25 = Vector2.new;
                local v64;
                if l__Left__4 == Enum.LeftRight.Left then
                    v64 = -v62.X;
                else
                    v64 = l__Left__4 ~= Enum.LeftRight.Right and 0 or v62.X;
                end;
                local v65;
                if l__Top__3 == Enum.TopBottom.Top then
                    v65 = -v62.Y;
                else
                    v65 = l__Top__3 ~= Enum.TopBottom.Bottom and 0 or v62.Y;
                end;
                local v66 = u38(u16, v61 + l__new__25(v64, v65));
                local v67 = u46(u16, v63);
                l__WindowButton__24.Size = UDim2.fromOffset(v66.X, v66.Y);
                u16.state.size.value = v66;
                l__WindowButton__24.Position = UDim2.fromOffset(v67.X, v67.Y);
                u16.state.position.value = v67;
            end;
            u20 = u2.getMouseLocation();
        end;
    end);
    u2.registerEvent("InputEnded", function(p68, _) --[[ Line: 313 ]]
        -- upvalues: u1 (copy), u14 (ref), u13 (ref), u17 (ref), u16 (ref), u27 (copy)
        if u1._started then
            if (p68.UserInputType == Enum.UserInputType.MouseButton1 or p68.UserInputType == Enum.UserInputType.Touch) and (u14 and u13) then
                local l__WindowButton__26 = u13.Instance.WindowButton;
                u14 = false;
                u13.state.position:set(Vector2.new(l__WindowButton__26.Position.X.Offset, l__WindowButton__26.Position.Y.Offset));
            end;
            if (p68.UserInputType == Enum.UserInputType.MouseButton1 or p68.UserInputType == Enum.UserInputType.Touch) and (u17 and u16) then
                local l__Instance__27 = u16.Instance;
                u17 = false;
                u16.state.size:set(l__Instance__27.WindowButton.AbsoluteSize);
            end;
            if p68.KeyCode == Enum.KeyCode.ButtonX then
                u27();
            end;
        end;
    end);
    u1.WidgetConstructor("Window", {
        hasState = true,
        hasChildren = true,
        Args = {
            Title = 1,
            NoTitleBar = 2,
            NoBackground = 3,
            NoCollapse = 4,
            NoClose = 5,
            NoMove = 6,
            NoScrollbar = 7,
            NoResize = 8,
            NoNav = 9,
            NoMenu = 10
        },
        Events = {
            closed = {
                Init = function(_) --[[ Line: 352 ]] end,
                Get = function(p69) --[[ Line: 353 ]]
                    -- upvalues: u1 (copy)
                    return p69.lastClosedTick == u1._cycleTick;
                end
            },
            opened = {
                Init = function(_) --[[ Line: 358 ]] end,
                Get = function(p70) --[[ Line: 359 ]]
                    -- upvalues: u1 (copy)
                    return p70.lastOpenedTick == u1._cycleTick;
                end
            },
            collapsed = {
                Init = function(_) --[[ Line: 364 ]] end,
                Get = function(p71) --[[ Line: 365 ]]
                    -- upvalues: u1 (copy)
                    return p71.lastCollapsedTick == u1._cycleTick;
                end
            },
            uncollapsed = {
                Init = function(_) --[[ Line: 370 ]] end,
                Get = function(p72) --[[ Line: 371 ]]
                    -- upvalues: u1 (copy)
                    return p72.lastUncollapsedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p73) --[[ Line: 375 ]]
                return p73.Instance.WindowButton;
            end)
        },
        Generate = function(u74) --[[ Name: Generate, Line 380 ]]
            -- upvalues: u1 (copy), u23 (copy), u2 (copy), u13 (ref), u14 (ref), u15 (ref), u22 (ref), u21 (ref), u17 (ref), l__Top__3 (ref), l__Left__4 (ref), u16 (ref), u18 (ref), u19 (ref)
            u74.parentWidget = u1._rootWidget;
            u74.usesScreenGuis = u1._config.UseScreenGUIs;
            u23[u74.ID] = u74;
            local v75;
            if u74.usesScreenGuis then
                v75 = Instance.new("ScreenGui");
                v75.ResetOnSpawn = false;
                v75.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                v75.DisplayOrder = u1._config.DisplayOrderOffset;
                v75.ScreenInsets = u1._config.ScreenInsets;
                v75.IgnoreGuiInset = u1._config.IgnoreGuiInset;
            else
                v75 = Instance.new("Frame");
                v75.AnchorPoint = Vector2.new(0.5, 0.5);
                v75.Position = UDim2.fromScale(0.5, 0.5);
                v75.Size = UDim2.fromScale(1, 1);
                v75.BackgroundTransparency = 1;
                v75.ZIndex = u1._config.DisplayOrderOffset;
            end;
            v75.Name = "Iris_Window";
            local v76 = Instance.new("TextButton");
            v76.Name = "WindowButton";
            v76.Size = UDim2.fromOffset(0, 0);
            v76.BackgroundTransparency = 1;
            v76.BorderSizePixel = 0;
            v76.Text = "";
            v76.AutoButtonColor = false;
            v76.ClipsDescendants = false;
            v76.Selectable = false;
            v76.SelectionImageObject = u1.SelectionImageObject;
            v76.SelectionGroup = true;
            v76.SelectionBehaviorUp = Enum.SelectionBehavior.Stop;
            v76.SelectionBehaviorDown = Enum.SelectionBehavior.Stop;
            v76.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop;
            v76.SelectionBehaviorRight = Enum.SelectionBehavior.Stop;
            u2.UIStroke(v76, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            v76.Parent = v75;
            u2.applyInputBegan(v76, function(p77) --[[ Line: 425 ]]
                -- upvalues: u74 (copy), u1 (ref), u13 (ref), u14 (ref), u15 (ref), u2 (ref)
                if p77.UserInputType == Enum.UserInputType.MouseMovement or p77.UserInputType == Enum.UserInputType.Keyboard then
                else
                    if u74.state.isUncollapsed.value then
                        u1.SetFocusedWindow(u74);
                    end;
                    if not u74.arguments.NoMove and p77.UserInputType == Enum.UserInputType.MouseButton1 then
                        u13 = u74;
                        u14 = true;
                        u15 = u2.getMouseLocation() - u74.state.position.value;
                    end;
                end;
            end);
            local v78 = Instance.new("Frame");
            v78.Name = "Content";
            v78.AnchorPoint = Vector2.new(0.5, 0.5);
            v78.Position = UDim2.fromScale(0.5, 0.5);
            v78.Size = UDim2.fromScale(1, 1);
            v78.BackgroundTransparency = 1;
            v78.ClipsDescendants = true;
            v78.Parent = v76;
            local v79 = u2.UIListLayout(v78, Enum.FillDirection.Vertical, UDim.new(0, 0));
            v79.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            v79.VerticalAlignment = Enum.VerticalAlignment.Top;
            local u80 = Instance.new("ScrollingFrame");
            u80.Name = "WindowContainer";
            u80.Size = UDim2.fromScale(1, 1);
            u80.BackgroundColor3 = u1._config.WindowBgColor;
            u80.BackgroundTransparency = u1._config.WindowBgTransparency;
            u80.BorderSizePixel = 0;
            u80.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            u80.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            u80.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            u80.CanvasSize = UDim2.fromScale(0, 0);
            u80.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            u80.TopImage = u2.ICONS.BLANK_SQUARE;
            u80.MidImage = u2.ICONS.BLANK_SQUARE;
            u80.BottomImage = u2.ICONS.BLANK_SQUARE;
            u80.LayoutOrder = u74.ZIndex + 65535;
            u80.ClipsDescendants = true;
            u2.UIPadding(u80, u1._config.WindowPadding);
            u80.Parent = v78;
            local v81 = Instance.new("UIFlexItem");
            v81.FlexMode = Enum.UIFlexMode.Fill;
            v81.ItemLineAlignment = Enum.ItemLineAlignment.End;
            v81.Parent = u80;
            u80:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 480 ]]
                -- upvalues: u74 (copy), u80 (copy)
                u74.state.scrollDistance.value = u80.CanvasPosition.Y;
            end);
            u2.applyInputBegan(u80, function(p82) --[[ Line: 485 ]]
                -- upvalues: u74 (copy), u1 (ref)
                if p82.UserInputType == Enum.UserInputType.MouseMovement or p82.UserInputType == Enum.UserInputType.Keyboard then
                else
                    if u74.state.isUncollapsed.value then
                        u1.SetFocusedWindow(u74);
                    end;
                end;
            end);
            local v83 = Instance.new("Frame");
            v83.Name = "TerminatingFrame";
            v83.Size = UDim2.fromOffset(0, u1._config.WindowPadding.Y + u1._config.FramePadding.Y);
            v83.BackgroundTransparency = 1;
            v83.BorderSizePixel = 0;
            v83.LayoutOrder = 2147483632;
            u2.UIListLayout(u80, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top;
            v83.Parent = u80;
            local v84 = Instance.new("Frame");
            v84.Name = "TitleBar";
            v84.AutomaticSize = Enum.AutomaticSize.Y;
            v84.Size = UDim2.fromScale(1, 0);
            v84.BorderSizePixel = 0;
            v84.ClipsDescendants = true;
            v84.Parent = v78;
            u2.UIPadding(v84, Vector2.new(u1._config.FramePadding.X));
            u2.UIListLayout(v84, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInputBegan(v84, function(p85) --[[ Line: 516 ]]
                -- upvalues: u74 (copy), u13 (ref), u14 (ref), u15 (ref)
                if p85.UserInputType == Enum.UserInputType.Touch and not u74.arguments.NoMove then
                    u13 = u74;
                    u14 = true;
                    local l__Position__28 = p85.Position;
                    u15 = Vector2.new(l__Position__28.X, l__Position__28.Y) - u74.state.position.value;
                end;
            end);
            local v86 = u1._config.TextSize + (u1._config.FramePadding.Y - 1) * 2;
            local v87 = Instance.new("TextButton");
            v87.Name = "CollapseButton";
            v87.AutomaticSize = Enum.AutomaticSize.None;
            v87.AnchorPoint = Vector2.new(0, 0.5);
            v87.Size = UDim2.fromOffset(v86, v86);
            v87.Position = UDim2.fromScale(0, 0.5);
            v87.BackgroundTransparency = 1;
            v87.BorderSizePixel = 0;
            v87.AutoButtonColor = false;
            v87.Text = "";
            u2.UICorner(v87);
            v87.Parent = v84;
            u2.applyButtonClick(v87, function() --[[ Line: 544 ]]
                -- upvalues: u74 (copy)
                u74.state.isUncollapsed:set(not u74.state.isUncollapsed.value);
            end);
            u2.applyInteractionHighlights("Background", v87, v87, {
                Transparency = 1,
                Color = u1._config.ButtonColor,
                HoveredColor = u1._config.ButtonHoveredColor,
                HoveredTransparency = u1._config.ButtonHoveredTransparency,
                ActiveColor = u1._config.ButtonActiveColor,
                ActiveTransparency = u1._config.ButtonActiveTransparency
            });
            local v88 = Instance.new("ImageLabel");
            v88.Name = "Arrow";
            v88.AnchorPoint = Vector2.new(0.5, 0.5);
            v88.Size = UDim2.fromOffset(math.floor(0.7 * v86), (math.floor(0.7 * v86)));
            v88.Position = UDim2.fromScale(0.5, 0.5);
            v88.BackgroundTransparency = 1;
            v88.BorderSizePixel = 0;
            v88.Image = u2.ICONS.MULTIPLICATION_SIGN;
            v88.ImageColor3 = u1._config.TextColor;
            v88.ImageTransparency = u1._config.TextTransparency;
            v88.Parent = v87;
            local v89 = Instance.new("TextButton");
            v89.Name = "CloseButton";
            v89.AutomaticSize = Enum.AutomaticSize.None;
            v89.AnchorPoint = Vector2.new(1, 0.5);
            v89.Size = UDim2.fromOffset(v86, v86);
            v89.Position = UDim2.fromScale(1, 0.5);
            v89.BackgroundTransparency = 1;
            v89.BorderSizePixel = 0;
            v89.Text = "";
            v89.AutoButtonColor = false;
            v89.LayoutOrder = 2;
            u2.UICorner(v89);
            u2.applyButtonClick(v89, function() --[[ Line: 583 ]]
                -- upvalues: u74 (copy)
                u74.state.isOpened:set(false);
            end);
            u2.applyInteractionHighlights("Background", v89, v89, {
                Transparency = 1,
                Color = u1._config.ButtonColor,
                HoveredColor = u1._config.ButtonHoveredColor,
                HoveredTransparency = u1._config.ButtonHoveredTransparency,
                ActiveColor = u1._config.ButtonActiveColor,
                ActiveTransparency = u1._config.ButtonActiveTransparency
            });
            v89.Parent = v84;
            local v90 = Instance.new("ImageLabel");
            v90.Name = "Icon";
            v90.AnchorPoint = Vector2.new(0.5, 0.5);
            v90.Size = UDim2.fromOffset(math.floor(0.7 * v86), (math.floor(0.7 * v86)));
            v90.Position = UDim2.fromScale(0.5, 0.5);
            v90.BackgroundTransparency = 1;
            v90.BorderSizePixel = 0;
            v90.Image = u2.ICONS.MULTIPLICATION_SIGN;
            v90.ImageColor3 = u1._config.TextColor;
            v90.ImageTransparency = u1._config.TextTransparency;
            v90.Parent = v89;
            local v91 = Instance.new("TextLabel");
            v91.Name = "Title";
            v91.AutomaticSize = Enum.AutomaticSize.XY;
            v91.BorderSizePixel = 0;
            v91.BackgroundTransparency = 1;
            v91.LayoutOrder = 1;
            v91.ClipsDescendants = true;
            u2.UIPadding(v91, Vector2.new(0, u1._config.FramePadding.Y));
            u2.applyTextStyle(v91);
            v91.TextXAlignment = Enum.TextXAlignment[u1._config.WindowTitleAlign.Name];
            local v92 = Instance.new("UIFlexItem");
            v92.FlexMode = Enum.UIFlexMode.Fill;
            v92.ItemLineAlignment = Enum.ItemLineAlignment.Center;
            v92.Parent = v91;
            v91.Parent = v84;
            local v93 = u1._config.TextSize + u1._config.FramePadding.X;
            local v94 = Instance.new("ImageButton");
            v94.Name = "LeftResizeGrip";
            v94.AnchorPoint = Vector2.yAxis;
            v94.Rotation = 180;
            v94.Position = UDim2.fromScale(0, 1);
            v94.Size = UDim2.fromOffset(v93, v93);
            v94.BackgroundTransparency = 1;
            v94.BorderSizePixel = 0;
            v94.Image = u2.ICONS.BOTTOM_RIGHT_CORNER;
            v94.ImageColor3 = u1._config.ResizeGripColor;
            v94.ImageTransparency = 1;
            v94.AutoButtonColor = false;
            v94.ZIndex = 3;
            v94.Parent = v76;
            u2.applyInteractionHighlights("Image", v94, v94, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyButtonDown(v94, function() --[[ Line: 658 ]]
                -- upvalues: u22 (ref), u21 (ref), u74 (copy), u1 (ref), u17 (ref), l__Top__3 (ref), l__Left__4 (ref), u16 (ref)
                if not u22 or u21 ~= u74 then
                    u1.SetFocusedWindow(u74);
                end;
                u17 = true;
                l__Top__3 = Enum.TopBottom.Bottom;
                l__Left__4 = Enum.LeftRight.Left;
                u16 = u74;
            end);
            local v95 = Instance.new("ImageButton");
            v95.Name = "RightResizeGrip";
            v95.AnchorPoint = Vector2.one;
            v95.Rotation = 90;
            v95.Position = UDim2.fromScale(1, 1);
            v95.Size = UDim2.fromOffset(v93, v93);
            v95.BackgroundTransparency = 1;
            v95.BorderSizePixel = 0;
            v95.Image = u2.ICONS.BOTTOM_RIGHT_CORNER;
            v95.ImageColor3 = u1._config.ResizeGripColor;
            v95.ImageTransparency = u1._config.ResizeGripTransparency;
            v95.AutoButtonColor = false;
            v95.ZIndex = 3;
            v95.Parent = v76;
            u2.applyInteractionHighlights("Image", v95, v95, {
                Color = u1._config.ResizeGripColor,
                Transparency = u1._config.ResizeGripTransparency,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyButtonDown(v95, function() --[[ Line: 694 ]]
                -- upvalues: u22 (ref), u21 (ref), u74 (copy), u1 (ref), u17 (ref), l__Top__3 (ref), l__Left__4 (ref), u16 (ref)
                if not u22 or u21 ~= u74 then
                    u1.SetFocusedWindow(u74);
                end;
                u17 = true;
                l__Top__3 = Enum.TopBottom.Bottom;
                l__Left__4 = Enum.LeftRight.Right;
                u16 = u74;
            end);
            local v96 = Instance.new("ImageButton");
            v96.Name = "LeftResizeBorder";
            v96.AnchorPoint = Vector2.new(1, 0.5);
            v96.Position = UDim2.fromScale(0, 0.5);
            v96.Size = UDim2.new(0, u1._config.WindowResizePadding.X, 1, 2 * u1._config.WindowBorderSize);
            v96.Transparency = 1;
            v96.Image = u2.ICONS.BORDER;
            v96.ResampleMode = Enum.ResamplerMode.Pixelated;
            v96.ScaleType = Enum.ScaleType.Slice;
            v96.SliceCenter = Rect.new(0, 0, 1, 1);
            v96.ImageRectOffset = Vector2.new(2, 2);
            v96.ImageRectSize = Vector2.new(2, 1);
            v96.ImageTransparency = 1;
            v96.AutoButtonColor = false;
            v96.ZIndex = 4;
            v96.Parent = v76;
            local v97 = Instance.new("ImageButton");
            v97.Name = "RightResizeBorder";
            v97.AnchorPoint = Vector2.new(0, 0.5);
            v97.Position = UDim2.fromScale(1, 0.5);
            v97.Size = UDim2.new(0, u1._config.WindowResizePadding.X, 1, 2 * u1._config.WindowBorderSize);
            v97.Transparency = 1;
            v97.Image = u2.ICONS.BORDER;
            v97.ResampleMode = Enum.ResamplerMode.Pixelated;
            v97.ScaleType = Enum.ScaleType.Slice;
            v97.SliceCenter = Rect.new(1, 0, 2, 1);
            v97.ImageRectOffset = Vector2.new(1, 2);
            v97.ImageRectSize = Vector2.new(2, 1);
            v97.ImageTransparency = 1;
            v97.AutoButtonColor = false;
            v97.ZIndex = 4;
            v97.Parent = v76;
            local v98 = Instance.new("ImageButton");
            v98.Name = "TopResizeBorder";
            v98.AnchorPoint = Vector2.new(0.5, 1);
            v98.Position = UDim2.fromScale(0.5, 0);
            v98.Size = UDim2.new(1, 2 * u1._config.WindowBorderSize, 0, u1._config.WindowResizePadding.Y);
            v98.Transparency = 1;
            v98.Image = u2.ICONS.BORDER;
            v98.ResampleMode = Enum.ResamplerMode.Pixelated;
            v98.ScaleType = Enum.ScaleType.Slice;
            v98.SliceCenter = Rect.new(0, 0, 1, 1);
            v98.ImageRectOffset = Vector2.new(2, 2);
            v98.ImageRectSize = Vector2.new(1, 2);
            v98.ImageTransparency = 1;
            v98.AutoButtonColor = false;
            v98.ZIndex = 4;
            v98.Parent = v76;
            local v99 = Instance.new("ImageButton");
            v99.Name = "BottomResizeBorder";
            v99.AnchorPoint = Vector2.new(0.5, 0);
            v99.Position = UDim2.fromScale(0.5, 1);
            v99.Size = UDim2.new(1, 2 * u1._config.WindowBorderSize, 0, u1._config.WindowResizePadding.Y);
            v99.Transparency = 1;
            v99.Image = u2.ICONS.BORDER;
            v99.ResampleMode = Enum.ResamplerMode.Pixelated;
            v99.ScaleType = Enum.ScaleType.Slice;
            v99.SliceCenter = Rect.new(0, 1, 1, 2);
            v99.ImageRectOffset = Vector2.new(2, 1);
            v99.ImageRectSize = Vector2.new(1, 2);
            v99.ImageTransparency = 1;
            v99.AutoButtonColor = false;
            v99.ZIndex = 4;
            v99.Parent = v76;
            u2.applyInteractionHighlights("Image", v96, v96, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyInteractionHighlights("Image", v97, v97, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyInteractionHighlights("Image", v98, v98, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyInteractionHighlights("Image", v99, v99, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            local v100 = Instance.new("Frame");
            v100.Name = "ResizeBorder";
            v100.Position = UDim2.fromOffset(-u1._config.WindowResizePadding.X, -u1._config.WindowResizePadding.Y);
            v100.Size = UDim2.new(1, u1._config.WindowResizePadding.X * 2, 1, u1._config.WindowResizePadding.Y * 2);
            v100.BackgroundTransparency = 1;
            v100.BorderSizePixel = 0;
            v100.Active = false;
            v100.Selectable = false;
            v100.ClipsDescendants = false;
            v100.Parent = v76;
            u2.applyMouseEnter(v100, function() --[[ Line: 824 ]]
                -- upvalues: u21 (ref), u74 (copy), u18 (ref)
                if u21 == u74 then
                    u18 = true;
                end;
            end);
            u2.applyMouseLeave(v100, function() --[[ Line: 829 ]]
                -- upvalues: u21 (ref), u74 (copy), u18 (ref)
                if u21 == u74 then
                    u18 = false;
                end;
            end);
            u2.applyInputBegan(v100, function(p101) --[[ Line: 834 ]]
                -- upvalues: u74 (copy), u1 (ref)
                if p101.UserInputType == Enum.UserInputType.MouseMovement or p101.UserInputType == Enum.UserInputType.Keyboard then
                else
                    if u74.state.isUncollapsed.value then
                        u1.SetFocusedWindow(u74);
                    end;
                end;
            end);
            u2.applyMouseEnter(v76, function() --[[ Line: 843 ]]
                -- upvalues: u21 (ref), u74 (copy), u19 (ref)
                if u21 == u74 then
                    u19 = true;
                end;
            end);
            u2.applyMouseLeave(v76, function() --[[ Line: 848 ]]
                -- upvalues: u21 (ref), u74 (copy), u19 (ref)
                if u21 == u74 then
                    u19 = false;
                end;
            end);
            u74.ChildContainer = u80;
            return v75;
        end,
        GenerateState = function(p102) --[[ Name: GenerateState, Line 857 ]]
            -- upvalues: u1 (copy), u22 (ref), u21 (ref), u46 (copy), u38 (copy)
            if p102.state.size == nil then
                p102.state.size = u1._widgetState(p102, "size", Vector2.new(400, 300));
            end;
            if p102.state.position == nil then
                local l__state__29 = p102.state;
                local l___widgetState__30 = u1._widgetState;
                local v103 = "position";
                local v104;
                if u22 and u21 then
                    v104 = u21.state.position.value + Vector2.new(15, 45);
                else
                    v104 = Vector2.new(150, 250);
                end;
                l__state__29.position = l___widgetState__30(p102, v103, v104);
            end;
            p102.state.position.value = u46(p102, p102.state.position.value);
            p102.state.size.value = u38(p102, p102.state.size.value);
            if p102.state.isUncollapsed == nil then
                p102.state.isUncollapsed = u1._widgetState(p102, "isUncollapsed", true);
            end;
            if p102.state.isOpened == nil then
                p102.state.isOpened = u1._widgetState(p102, "isOpened", true);
            end;
            if p102.state.scrollDistance == nil then
                p102.state.scrollDistance = u1._widgetState(p102, "scrollDistance", 0);
            end;
        end,
        Update = function(p105) --[[ Name: Update, Line 877 ]]
            -- upvalues: u1 (copy)
            local l__Instance__31 = p105.Instance;
            local l__ChildContainer__32 = p105.ChildContainer;
            local l__WindowButton__33 = l__Instance__31.WindowButton;
            local l__Content__34 = l__WindowButton__33.Content;
            local l__TitleBar__35 = l__Content__34.TitleBar;
            local l__Title__36 = l__TitleBar__35.Title;
            local v106 = l__Content__34:FindFirstChild("Iris_MenuBar");
            local l__LeftResizeGrip__37 = l__WindowButton__33.LeftResizeGrip;
            local l__RightResizeGrip__38 = l__WindowButton__33.RightResizeGrip;
            local l__LeftResizeBorder__39 = l__WindowButton__33.LeftResizeBorder;
            local l__RightResizeBorder__40 = l__WindowButton__33.RightResizeBorder;
            local l__TopResizeBorder__41 = l__WindowButton__33.TopResizeBorder;
            local l__BottomResizeBorder__42 = l__WindowButton__33.BottomResizeBorder;
            if p105.arguments.NoResize == true then
                l__LeftResizeGrip__37.Visible = false;
                l__RightResizeGrip__38.Visible = false;
                l__LeftResizeBorder__39.Visible = false;
                l__RightResizeBorder__40.Visible = false;
                l__TopResizeBorder__41.Visible = false;
                l__BottomResizeBorder__42.Visible = false;
            else
                l__LeftResizeGrip__37.Visible = true;
                l__RightResizeGrip__38.Visible = true;
                l__LeftResizeBorder__39.Visible = true;
                l__RightResizeBorder__40.Visible = true;
                l__TopResizeBorder__41.Visible = true;
                l__BottomResizeBorder__42.Visible = true;
            end;
            if p105.arguments.NoScrollbar then
                l__ChildContainer__32.ScrollBarThickness = 0;
            else
                l__ChildContainer__32.ScrollBarThickness = u1._config.ScrollbarSize;
            end;
            if p105.arguments.NoTitleBar then
                l__TitleBar__35.Visible = false;
            else
                l__TitleBar__35.Visible = true;
            end;
            if v106 then
                if p105.arguments.NoMenu then
                    v106.Visible = false;
                else
                    v106.Visible = true;
                end;
            end;
            if p105.arguments.NoBackground then
                l__ChildContainer__32.BackgroundTransparency = 1;
            else
                l__ChildContainer__32.BackgroundTransparency = u1._config.WindowBgTransparency;
            end;
            if p105.arguments.NoCollapse then
                l__TitleBar__35.CollapseButton.Visible = false;
            else
                l__TitleBar__35.CollapseButton.Visible = true;
            end;
            if p105.arguments.NoClose then
                l__TitleBar__35.CloseButton.Visible = false;
            else
                l__TitleBar__35.CloseButton.Visible = true;
            end;
            l__Title__36.Text = p105.arguments.Title or "";
        end,
        UpdateState = function(u107) --[[ Name: UpdateState, Line 944 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local l__value__43 = u107.state.size.value;
            local l__value__44 = u107.state.position.value;
            local l__value__45 = u107.state.isUncollapsed.value;
            local l__value__46 = u107.state.isOpened.value;
            local l__value__47 = u107.state.scrollDistance.value;
            local l__Instance__48 = u107.Instance;
            local l__ChildContainer__49 = u107.ChildContainer;
            local l__WindowButton__50 = l__Instance__48.WindowButton;
            local l__Content__51 = l__WindowButton__50.Content;
            local l__TitleBar__52 = l__Content__51.TitleBar;
            local v108 = l__Content__51:FindFirstChild("Iris_MenuBar");
            local l__LeftResizeGrip__53 = l__WindowButton__50.LeftResizeGrip;
            local l__RightResizeGrip__54 = l__WindowButton__50.RightResizeGrip;
            local l__LeftResizeBorder__55 = l__WindowButton__50.LeftResizeBorder;
            local l__RightResizeBorder__56 = l__WindowButton__50.RightResizeBorder;
            local l__TopResizeBorder__57 = l__WindowButton__50.TopResizeBorder;
            local l__BottomResizeBorder__58 = l__WindowButton__50.BottomResizeBorder;
            l__WindowButton__50.Size = UDim2.fromOffset(l__value__43.X, l__value__43.Y);
            l__WindowButton__50.Position = UDim2.fromOffset(l__value__44.X, l__value__44.Y);
            if l__value__46 then
                if u107.usesScreenGuis then
                    l__Instance__48.Enabled = true;
                    l__WindowButton__50.Visible = true;
                else
                    l__Instance__48.Visible = true;
                    l__WindowButton__50.Visible = true;
                end;
                u107.lastOpenedTick = u1._cycleTick + 1;
            else
                if u107.usesScreenGuis then
                    l__Instance__48.Enabled = false;
                    l__WindowButton__50.Visible = false;
                else
                    l__Instance__48.Visible = false;
                    l__WindowButton__50.Visible = false;
                end;
                u107.lastClosedTick = u1._cycleTick + 1;
            end;
            if l__value__45 then
                l__TitleBar__52.CollapseButton.Arrow.Image = u2.ICONS.DOWN_POINTING_TRIANGLE;
                if v108 then
                    v108.Visible = not u107.arguments.NoMenu;
                end;
                l__ChildContainer__49.Visible = true;
                if u107.arguments.NoResize ~= true then
                    l__LeftResizeGrip__53.Visible = true;
                    l__RightResizeGrip__54.Visible = true;
                    l__LeftResizeBorder__55.Visible = true;
                    l__RightResizeBorder__56.Visible = true;
                    l__TopResizeBorder__57.Visible = true;
                    l__BottomResizeBorder__58.Visible = true;
                end;
                l__WindowButton__50.AutomaticSize = Enum.AutomaticSize.None;
                u107.lastUncollapsedTick = u1._cycleTick + 1;
            else
                local l__Y__59 = l__TitleBar__52.AbsoluteSize.Y;
                l__TitleBar__52.CollapseButton.Arrow.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                if v108 then
                    v108.Visible = false;
                end;
                l__ChildContainer__49.Visible = false;
                l__LeftResizeGrip__53.Visible = false;
                l__RightResizeGrip__54.Visible = false;
                l__LeftResizeBorder__55.Visible = false;
                l__RightResizeBorder__56.Visible = false;
                l__TopResizeBorder__57.Visible = false;
                l__BottomResizeBorder__58.Visible = false;
                l__WindowButton__50.Size = UDim2.fromOffset(l__value__43.X, l__Y__59);
                u107.lastCollapsedTick = u1._cycleTick + 1;
            end;
            if l__value__46 and l__value__45 then
                u1.SetFocusedWindow(u107);
            else
                l__TitleBar__52.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                l__TitleBar__52.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                l__WindowButton__50.UIStroke.Color = u1._config.BorderColor;
                u1.SetFocusedWindow(nil);
            end;
            if l__value__47 and l__value__47 ~= 0 then
                local u109 = #u1._postCycleCallbacks + 1;
                local u110 = u1._cycleTick + 1;
                u1._postCycleCallbacks[u109] = function() --[[ Line: 1035 ]]
                    -- upvalues: u1 (ref), u110 (copy), u107 (copy), l__ChildContainer__49 (copy), l__value__47 (copy), u109 (copy)
                    if u110 <= u1._cycleTick then
                        if u107.lastCycleTick ~= -1 then
                            l__ChildContainer__49.CanvasPosition = Vector2.new(0, l__value__47);
                        end;
                        u1._postCycleCallbacks[u109] = nil;
                    end;
                end;
            end;
        end,
        ChildAdded = function(p111, p112) --[[ Name: ChildAdded, Line 1045 ]]
            local l__Content__60 = p111.Instance.WindowButton.Content;
            if p112.type ~= "MenuBar" then
                return p111.ChildContainer;
            end;
            local l__ChildContainer__61 = p111.ChildContainer;
            p112.Instance.ZIndex = l__ChildContainer__61.ZIndex + 1;
            p112.Instance.LayoutOrder = l__ChildContainer__61.LayoutOrder - 1;
            return l__Content__60;
        end,
        Discard = function(p113) --[[ Name: Discard, Line 1057 ]]
            -- upvalues: u21 (ref), u22 (ref), u13 (ref), u14 (ref), u16 (ref), u17 (ref), u23 (copy), u2 (copy)
            if u21 == p113 then
                u21 = nil;
                u22 = false;
            end;
            if u13 == p113 then
                u13 = nil;
                u14 = false;
            end;
            if u16 == p113 then
                u16 = nil;
                u17 = false;
            end;
            u23[p113.ID] = nil;
            p113.Instance:Destroy();
            u2.discardState(p113);
        end
    });
end;