-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local function u7(p3, p4) --[[ Line: 12 ]]
        if p3.state.index.value == p4 then
            for v5 = p4 - 1, 1, -1 do
                if p3.Tabs[v5].state.isOpened.value == true then
                    p3.state.index:set(v5);
                    return;
                end;
            end;
            for v6 = p4, #p3.Tabs do
                if p3.Tabs[v6].state.isOpened.value == true then
                    p3.state.index:set(v6);
                    return;
                end;
            end;
            p3.state.index:set(0);
        end;
    end;
    u1.WidgetConstructor("TabBar", {
        hasState = true,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = function(p8) --[[ Name: Generate, Line 43 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v9 = Instance.new("Frame");
            v9.Name = "Iris_TabBar";
            v9.AutomaticSize = Enum.AutomaticSize.Y;
            v9.Size = UDim2.fromScale(1, 0);
            v9.BackgroundTransparency = 1;
            v9.BorderSizePixel = 0;
            u2.UIListLayout(v9, Enum.FillDirection.Vertical, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Bottom;
            local v10 = Instance.new("Frame");
            v10.Name = "Bar";
            v10.AutomaticSize = Enum.AutomaticSize.Y;
            v10.Size = UDim2.fromScale(1, 0);
            v10.BackgroundTransparency = 1;
            v10.BorderSizePixel = 0;
            u2.UIListLayout(v10, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
            v10.Parent = v9;
            local v11 = Instance.new("Frame");
            v11.Name = "Underline";
            v11.Size = UDim2.new(1, 0, 0, 1);
            v11.BackgroundColor3 = u1._config.TabActiveColor;
            v11.BackgroundTransparency = u1._config.TabActiveTransparency;
            v11.BorderSizePixel = 0;
            v11.LayoutOrder = 1;
            v11.Parent = v9;
            local v12 = Instance.new("Frame");
            v12.Name = "TabContainer";
            v12.AutomaticSize = Enum.AutomaticSize.Y;
            v12.Size = UDim2.fromScale(1, 0);
            v12.BackgroundTransparency = 1;
            v12.BorderSizePixel = 0;
            v12.LayoutOrder = 2;
            v12.ClipsDescendants = true;
            v12.Parent = v9;
            p8.ChildContainer = v12;
            p8.Tabs = {};
            return v9;
        end,
        Update = function(_) --[[ Name: Update, Line 90 ]] end,
        ChildAdded = function(p13, p14) --[[ Name: ChildAdded, Line 91 ]]
            assert(p14.type == "Tab", "Only Iris.Tab can be parented to Iris.TabBar.");
            local l__Instance__1 = p13.Instance;
            p14.ChildContainer.Parent = p13.ChildContainer;
            p14.Index = #p13.Tabs + 1;
            p13.state.index.ConnectedWidgets[p14.ID] = p14;
            table.insert(p13.Tabs, p14);
            return l__Instance__1.Bar;
        end,
        ChildDiscarded = function(p15, p16) --[[ Name: ChildDiscarded, Line 101 ]]
            -- upvalues: u7 (copy)
            local l__Index__2 = p16.Index;
            table.remove(p15.Tabs, l__Index__2);
            for v17 = l__Index__2, #p15.Tabs do
                p15.Tabs[v17].Index = v17;
            end;
            u7(p15, l__Index__2);
        end,
        GenerateState = function(p18) --[[ Name: GenerateState, Line 111 ]]
            -- upvalues: u1 (copy)
            if p18.state.index == nil then
                p18.state.index = u1._widgetState(p18, "index", 1);
            end;
        end,
        UpdateState = function(_) --[[ Name: UpdateState, Line 116 ]] end,
        Discard = function(p19) --[[ Name: Discard, Line 118 ]]
            p19.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("Tab", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1,
            Hideable = 2
        },
        Events = {
            clicked = u2.EVENTS.click(function(p20) --[[ Line: 132 ]]
                return p20.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p21) --[[ Line: 135 ]]
                return p21.Instance;
            end),
            selected = {
                Init = function(_) --[[ Line: 139 ]] end,
                Get = function(p22) --[[ Line: 140 ]]
                    -- upvalues: u1 (copy)
                    return p22.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(_) --[[ Line: 145 ]] end,
                Get = function(p23) --[[ Line: 146 ]]
                    -- upvalues: u1 (copy)
                    return p23.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(_) --[[ Line: 151 ]] end,
                Get = function(p24) --[[ Line: 152 ]]
                    return p24.state.index.value == p24.Index;
                end
            },
            opened = {
                Init = function(_) --[[ Line: 157 ]] end,
                Get = function(p25) --[[ Line: 158 ]]
                    -- upvalues: u1 (copy)
                    return p25.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(_) --[[ Line: 163 ]] end,
                Get = function(p26) --[[ Line: 164 ]]
                    -- upvalues: u1 (copy)
                    return p26.lastClosedTick == u1._cycleTick;
                end
            }
        },
        Generate = function(u27) --[[ Name: Generate, Line 169 ]]
            -- upvalues: u1 (copy), u2 (copy), u7 (copy)
            local v28 = Instance.new("TextButton");
            v28.Name = "Iris_Tab";
            v28.AutomaticSize = Enum.AutomaticSize.XY;
            v28.BackgroundColor3 = u1._config.TabColor;
            v28.BackgroundTransparency = u1._config.TabTransparency;
            v28.BorderSizePixel = 0;
            v28.Text = "";
            v28.AutoButtonColor = false;
            u27.ButtonColors = {
                Color = u1._config.TabColor,
                Transparency = u1._config.TabTransparency,
                HoveredColor = u1._config.TabHoveredColor,
                HoveredTransparency = u1._config.TabHoveredTransparency,
                ActiveColor = u1._config.TabActiveColor,
                ActiveTransparency = u1._config.TabActiveTransparency
            };
            u2.UIPadding(v28, Vector2.new(u1._config.FramePadding.X, 0));
            u2.applyFrameStyle(v28, true, true);
            u2.UIListLayout(v28, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInteractionHighlights("Background", v28, v28, u27.ButtonColors);
            u2.applyButtonClick(v28, function() --[[ Line: 192 ]]
                -- upvalues: u27 (copy)
                u27.state.index:set(u27.Index);
            end);
            local v29 = Instance.new("TextLabel");
            v29.Name = "TextLabel";
            v29.AutomaticSize = Enum.AutomaticSize.XY;
            v29.BackgroundTransparency = 1;
            v29.BorderSizePixel = 0;
            u2.applyTextStyle(v29);
            u2.UIPadding(v29, Vector2.new(0, u1._config.FramePadding.Y));
            v29.Parent = v28;
            local v30 = u1._config.TextSize + (u1._config.FramePadding.Y - 1) * 2;
            local v31 = Instance.new("TextButton");
            v31.Name = "CloseButton";
            v31.Size = UDim2.fromOffset(v30, v30);
            v31.BackgroundTransparency = 1;
            v31.BorderSizePixel = 0;
            v31.Text = "";
            v31.AutoButtonColor = false;
            v31.LayoutOrder = 1;
            u2.UICorner(v31);
            u2.applyButtonClick(v31, function() --[[ Line: 219 ]]
                -- upvalues: u27 (copy), u7 (ref)
                u27.state.isOpened:set(false);
                u7(u27.parentWidget, u27.Index);
            end);
            u2.applyInteractionHighlights("Background", v31, v31, {
                Transparency = 1,
                Color = u1._config.TabColor,
                HoveredColor = u1._config.ButtonHoveredColor,
                HoveredTransparency = u1._config.ButtonHoveredTransparency,
                ActiveColor = u1._config.ButtonActiveColor,
                ActiveTransparency = u1._config.ButtonActiveTransparency
            });
            v31.Parent = v28;
            local v32 = Instance.new("ImageLabel");
            v32.Name = "Icon";
            v32.AnchorPoint = Vector2.new(0.5, 0.5);
            v32.Position = UDim2.fromScale(0.5, 0.5);
            v32.Size = UDim2.fromOffset(math.floor(0.7 * v30), (math.floor(0.7 * v30)));
            v32.BackgroundTransparency = 1;
            v32.BorderSizePixel = 0;
            v32.Image = u2.ICONS.MULTIPLICATION_SIGN;
            v32.ImageTransparency = 1;
            u2.applyInteractionHighlights("Image", v28, v32, {
                Transparency = 1,
                Color = u1._config.TextColor,
                HoveredColor = u1._config.TextColor,
                HoveredTransparency = u1._config.TextTransparency,
                ActiveColor = u1._config.TextColor,
                ActiveTransparency = u1._config.TextTransparency
            });
            v32.Parent = v31;
            local v33 = Instance.new("Frame");
            v33.Name = "TabContainer";
            v33.AutomaticSize = Enum.AutomaticSize.Y;
            v33.Size = UDim2.fromScale(1, 0);
            v33.BackgroundTransparency = 1;
            v33.BorderSizePixel = 0;
            v33.ClipsDescendants = true;
            u2.UIListLayout(v33, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            u2.UIPadding(v33, Vector2.new(0, u1._config.ItemSpacing.Y)).PaddingBottom = UDim.new();
            u27.ChildContainer = v33;
            return v28;
        end,
        Update = function(p34) --[[ Name: Update, Line 270 ]]
            local l__Instance__3 = p34.Instance;
            local l__TextLabel__4 = l__Instance__3.TextLabel;
            local l__CloseButton__5 = l__Instance__3.CloseButton;
            l__TextLabel__4.Text = p34.arguments.Text;
            l__CloseButton__5.Visible = p34.arguments.Hideable == true;
        end,
        ChildAdded = function(p35, _) --[[ Name: ChildAdded, Line 278 ]]
            return p35.ChildContainer;
        end,
        GenerateState = function(p36) --[[ Name: GenerateState, Line 281 ]]
            -- upvalues: u1 (copy)
            p36.state.index = p36.parentWidget.state.index;
            p36.state.index.ConnectedWidgets[p36.ID] = p36;
            if p36.state.isOpened == nil then
                p36.state.isOpened = u1._widgetState(p36, "isOpened", true);
            end;
        end,
        UpdateState = function(p37) --[[ Name: UpdateState, Line 289 ]]
            -- upvalues: u1 (copy), u7 (copy)
            local l__Instance__6 = p37.Instance;
            local l__ChildContainer__7 = p37.ChildContainer;
            if p37.state.isOpened.lastChangeTick == u1._cycleTick then
                if p37.state.isOpened.value == true then
                    p37.lastOpenedTick = u1._cycleTick + 1;
                    local l__parentWidget__8 = p37.parentWidget;
                    local l__Index__9 = p37.Index;
                    if l__parentWidget__8.state.index.value <= 0 then
                        l__parentWidget__8.state.index:set(l__Index__9);
                    end;
                    l__Instance__6.Visible = true;
                else
                    p37.lastClosedTick = u1._cycleTick + 1;
                    u7(p37.parentWidget, p37.Index);
                    l__Instance__6.Visible = false;
                end;
            end;
            if p37.state.index.lastChangeTick == u1._cycleTick then
                if p37.state.index.value == p37.Index then
                    p37.ButtonColors.Color = u1._config.TabActiveColor;
                    p37.ButtonColors.Transparency = u1._config.TabActiveTransparency;
                    l__Instance__6.BackgroundColor3 = u1._config.TabActiveColor;
                    l__Instance__6.BackgroundTransparency = u1._config.TabActiveTransparency;
                    l__ChildContainer__7.Visible = true;
                    p37.lastSelectedTick = u1._cycleTick + 1;
                    return;
                end;
                p37.ButtonColors.Color = u1._config.TabColor;
                p37.ButtonColors.Transparency = u1._config.TabTransparency;
                l__Instance__6.BackgroundColor3 = u1._config.TabColor;
                l__Instance__6.BackgroundTransparency = u1._config.TabTransparency;
                l__ChildContainer__7.Visible = false;
                p37.lastUnselectedTick = u1._cycleTick + 1;
            end;
        end,
        Discard = function(p38) --[[ Name: Discard, Line 323 ]]
            -- upvalues: u7 (copy), u2 (copy)
            if p38.state.isOpened.value == true then
                u7(p38.parentWidget, p38.Index);
            end;
            p38.Instance:Destroy();
            p38.ChildContainer:Destroy();
            u2.discardState(p38);
        end
    });
end;