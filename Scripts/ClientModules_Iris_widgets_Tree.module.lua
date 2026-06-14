-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local v10 = {
        hasState = true,
        hasChildren = true,
        Events = {
            collapsed = {
                Init = function(_) --[[ Line: 9 ]] end,
                Get = function(p3) --[[ Line: 10 ]]
                    -- upvalues: u1 (copy)
                    return p3.lastCollapsedTick == u1._cycleTick;
                end
            },
            uncollapsed = {
                Init = function(_) --[[ Line: 15 ]] end,
                Get = function(p4) --[[ Line: 16 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastUncollapsedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p5) --[[ Line: 20 ]]
                return p5.Instance;
            end)
        },
        Discard = function(p6) --[[ Name: Discard, Line 24 ]]
            -- upvalues: u2 (copy)
            p6.Instance:Destroy();
            u2.discardState(p6);
        end,
        ChildAdded = function(p7, _) --[[ Name: ChildAdded, Line 28 ]]
            local l__ChildContainer__1 = p7.ChildContainer;
            l__ChildContainer__1.Visible = p7.state.isUncollapsed.value;
            return l__ChildContainer__1;
        end,
        UpdateState = function(p8) --[[ Name: UpdateState, Line 35 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local l__value__2 = p8.state.isUncollapsed.value;
            local l__Instance__3 = p8.Instance;
            local l__ChildContainer__4 = p8.ChildContainer;
            l__Instance__3.Header.Button.Arrow.Image = l__value__2 and u2.ICONS.DOWN_POINTING_TRIANGLE or u2.ICONS.RIGHT_POINTING_TRIANGLE;
            if l__value__2 then
                p8.lastUncollapsedTick = u1._cycleTick + 1;
            else
                p8.lastCollapsedTick = u1._cycleTick + 1;
            end;
            l__ChildContainer__4.Visible = l__value__2;
        end,
        GenerateState = function(p9) --[[ Name: GenerateState, Line 52 ]]
            -- upvalues: u1 (copy)
            if p9.state.isUncollapsed == nil then
                p9.state.isUncollapsed = u1._widgetState(p9, "isUncollapsed", p9.arguments.DefaultOpen or false);
            end;
        end
    };
    u1.WidgetConstructor("Tree", u2.extend(v10, {
        Args = {
            Text = 1,
            SpanAvailWidth = 2,
            NoIndent = 3,
            DefaultOpen = 4
        },
        Generate = function(u11) --[[ Name: Generate, Line 69 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v12 = Instance.new("Frame");
            v12.Name = "Iris_Tree";
            v12.AutomaticSize = Enum.AutomaticSize.Y;
            v12.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, 0));
            v12.BackgroundTransparency = 1;
            v12.BorderSizePixel = 0;
            u2.UIListLayout(v12, Enum.FillDirection.Vertical, UDim.new(0, 0));
            local v13 = Instance.new("Frame");
            v13.Name = "TreeContainer";
            v13.AutomaticSize = Enum.AutomaticSize.Y;
            v13.Size = UDim2.fromScale(1, 0);
            v13.BackgroundTransparency = 1;
            v13.BorderSizePixel = 0;
            v13.LayoutOrder = 1;
            v13.Visible = false;
            u2.UIListLayout(v13, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            u2.UIPadding(v13, Vector2.zero).PaddingTop = UDim.new(0, u1._config.ItemSpacing.Y);
            v13.Parent = v12;
            local v14 = Instance.new("Frame");
            v14.Name = "Header";
            v14.AutomaticSize = Enum.AutomaticSize.Y;
            v14.Size = UDim2.fromScale(1, 0);
            v14.BackgroundTransparency = 1;
            v14.BorderSizePixel = 0;
            v14.Parent = v12;
            local v15 = Instance.new("TextButton");
            v15.Name = "Button";
            v15.BackgroundTransparency = 1;
            v15.BorderSizePixel = 0;
            v15.Text = "";
            v15.AutoButtonColor = false;
            u2.applyInteractionHighlights("Background", v15, v14, {
                Transparency = 1,
                Color = Color3.fromRGB(0, 0, 0),
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderActiveColor,
                ActiveTransparency = u1._config.HeaderActiveTransparency
            });
            u2.UIPadding(v15, Vector2.zero).PaddingLeft = UDim.new(0, u1._config.FramePadding.X);
            u2.UIListLayout(v15, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            v15.Parent = v14;
            local v16 = Instance.new("ImageLabel");
            v16.Name = "Arrow";
            v16.Size = UDim2.fromOffset(u1._config.TextSize, (math.floor(u1._config.TextSize * 0.7)));
            v16.BackgroundTransparency = 1;
            v16.BorderSizePixel = 0;
            v16.ImageColor3 = u1._config.TextColor;
            v16.ImageTransparency = u1._config.TextTransparency;
            v16.ScaleType = Enum.ScaleType.Fit;
            v16.Parent = v15;
            local v17 = Instance.new("TextLabel");
            v17.Name = "TextLabel";
            v17.AutomaticSize = Enum.AutomaticSize.XY;
            v17.Size = UDim2.fromOffset(0, 0);
            v17.BackgroundTransparency = 1;
            v17.BorderSizePixel = 0;
            u2.UIPadding(v17, Vector2.zero).PaddingRight = UDim.new(0, 21);
            u2.applyTextStyle(v17);
            v17.Parent = v15;
            u2.applyButtonClick(v15, function() --[[ Line: 146 ]]
                -- upvalues: u11 (copy)
                u11.state.isUncollapsed:set(not u11.state.isUncollapsed.value);
            end);
            u11.ChildContainer = v13;
            return v12;
        end,
        Update = function(p18) --[[ Name: Update, Line 153 ]]
            -- upvalues: u1 (copy)
            local l__Instance__5 = p18.Instance;
            local l__ChildContainer__6 = p18.ChildContainer;
            local l__Button__7 = l__Instance__5.Header.Button;
            local l__TextLabel__8 = l__Button__7.TextLabel;
            local l__UIPadding__9 = l__ChildContainer__6.UIPadding;
            l__TextLabel__8.Text = p18.arguments.Text or "Tree";
            if p18.arguments.SpanAvailWidth then
                l__Button__7.AutomaticSize = Enum.AutomaticSize.Y;
                l__Button__7.Size = UDim2.fromScale(1, 0);
            else
                l__Button__7.AutomaticSize = Enum.AutomaticSize.XY;
                l__Button__7.Size = UDim2.fromScale(0, 0);
            end;
            if p18.arguments.NoIndent then
                l__UIPadding__9.PaddingLeft = UDim.new(0, 0);
            else
                l__UIPadding__9.PaddingLeft = UDim.new(0, u1._config.IndentSpacing);
            end;
        end
    }));
    u1.WidgetConstructor("CollapsingHeader", u2.extend(v10, {
        Args = {
            Text = 1,
            DefaultOpen = 2
        },
        Generate = function(u19) --[[ Name: Generate, Line 187 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v20 = Instance.new("Frame");
            v20.Name = "Iris_CollapsingHeader";
            v20.AutomaticSize = Enum.AutomaticSize.Y;
            v20.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, 0));
            v20.BackgroundTransparency = 1;
            v20.BorderSizePixel = 0;
            u2.UIListLayout(v20, Enum.FillDirection.Vertical, UDim.new(0, 0));
            local v21 = Instance.new("Frame");
            v21.Name = "CollapsingHeaderContainer";
            v21.AutomaticSize = Enum.AutomaticSize.Y;
            v21.Size = UDim2.fromScale(1, 0);
            v21.BackgroundTransparency = 1;
            v21.BorderSizePixel = 0;
            v21.LayoutOrder = 1;
            v21.Visible = false;
            u2.UIListLayout(v21, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            u2.UIPadding(v21, Vector2.zero).PaddingTop = UDim.new(0, u1._config.ItemSpacing.Y);
            v21.Parent = v20;
            local v22 = Instance.new("Frame");
            v22.Name = "Header";
            v22.AutomaticSize = Enum.AutomaticSize.Y;
            v22.Size = UDim2.fromScale(1, 0);
            v22.BackgroundTransparency = 1;
            v22.BorderSizePixel = 0;
            v22.Parent = v20;
            local v23 = Instance.new("TextButton");
            v23.Name = "Button";
            v23.AutomaticSize = Enum.AutomaticSize.Y;
            v23.Size = UDim2.fromScale(1, 0);
            v23.BackgroundColor3 = u1._config.HeaderColor;
            v23.BackgroundTransparency = u1._config.HeaderTransparency;
            v23.BorderSizePixel = 0;
            v23.Text = "";
            v23.AutoButtonColor = false;
            v23.ClipsDescendants = true;
            u2.UIPadding(v23, u1._config.FramePadding);
            u2.applyFrameStyle(v23, true);
            u2.UIListLayout(v23, Enum.FillDirection.Horizontal, UDim.new(0, 2 * u1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInteractionHighlights("Background", v23, v23, {
                Color = u1._config.HeaderColor,
                Transparency = u1._config.HeaderTransparency,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderActiveColor,
                ActiveTransparency = u1._config.HeaderActiveTransparency
            });
            v23.Parent = v22;
            local v24 = Instance.new("ImageLabel");
            v24.Name = "Arrow";
            v24.AutomaticSize = Enum.AutomaticSize.Y;
            v24.Size = UDim2.fromOffset(u1._config.TextSize, (math.ceil(u1._config.TextSize * 0.8)));
            v24.BackgroundTransparency = 1;
            v24.BorderSizePixel = 0;
            v24.ImageColor3 = u1._config.TextColor;
            v24.ImageTransparency = u1._config.TextTransparency;
            v24.ScaleType = Enum.ScaleType.Fit;
            v24.Parent = v23;
            local v25 = Instance.new("TextLabel");
            v25.Name = "TextLabel";
            v25.AutomaticSize = Enum.AutomaticSize.XY;
            v25.Size = UDim2.fromOffset(0, 0);
            v25.BackgroundTransparency = 1;
            v25.BorderSizePixel = 0;
            u2.UIPadding(v25, Vector2.zero).PaddingRight = UDim.new(0, 21);
            u2.applyTextStyle(v25);
            v25.Parent = v23;
            u2.applyButtonClick(v23, function() --[[ Line: 270 ]]
                -- upvalues: u19 (copy)
                u19.state.isUncollapsed:set(not u19.state.isUncollapsed.value);
            end);
            u19.ChildContainer = v21;
            return v20;
        end,
        Update = function(p26) --[[ Name: Update, Line 277 ]]
            p26.Instance.Header.Button.TextLabel.Text = p26.arguments.Text or "Collapsing Header";
        end
    }));
end;