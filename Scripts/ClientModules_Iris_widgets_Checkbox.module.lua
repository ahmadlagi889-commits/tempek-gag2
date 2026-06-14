-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Checkbox", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {
            checked = {
                Init = function(_) --[[ Line: 13 ]] end,
                Get = function(p3) --[[ Line: 14 ]]
                    -- upvalues: u1 (copy)
                    return p3.lastCheckedTick == u1._cycleTick;
                end
            },
            unchecked = {
                Init = function(_) --[[ Line: 19 ]] end,
                Get = function(p4) --[[ Line: 20 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastUncheckedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p5) --[[ Line: 24 ]]
                return p5.Instance;
            end)
        },
        Generate = function(u6) --[[ Name: Generate, Line 28 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v7 = Instance.new("TextButton");
            v7.Name = "Iris_Checkbox";
            v7.AutomaticSize = Enum.AutomaticSize.XY;
            v7.Size = UDim2.fromOffset(0, 0);
            v7.BackgroundTransparency = 1;
            v7.BorderSizePixel = 0;
            v7.Text = "";
            v7.AutoButtonColor = false;
            u2.UIListLayout(v7, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v8 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v9 = Instance.new("Frame");
            v9.Name = "Box";
            v9.Size = UDim2.fromOffset(v8, v8);
            v9.BackgroundColor3 = u1._config.FrameBgColor;
            v9.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.applyFrameStyle(v9, true);
            u2.UIPadding(v9, Vector2.new(math.floor(v8 / 10), (math.floor(v8 / 10))));
            u2.applyInteractionHighlights("Background", v7, v9, {
                Color = u1._config.FrameBgColor,
                Transparency = u1._config.FrameBgTransparency,
                HoveredColor = u1._config.FrameBgHoveredColor,
                HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ActiveColor = u1._config.FrameBgActiveColor,
                ActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            v9.Parent = v7;
            local v10 = Instance.new("ImageLabel");
            v10.Name = "Checkmark";
            v10.Size = UDim2.fromScale(1, 1);
            v10.BackgroundTransparency = 1;
            v10.Image = u2.ICONS.CHECKMARK;
            v10.ImageColor3 = u1._config.CheckMarkColor;
            v10.ImageTransparency = 1;
            v10.ScaleType = Enum.ScaleType.Fit;
            v10.Parent = v9;
            u2.applyButtonClick(v7, function() --[[ Line: 73 ]]
                -- upvalues: u6 (copy)
                u6.state.isChecked:set(not u6.state.isChecked.value);
            end);
            local v11 = Instance.new("TextLabel");
            v11.Name = "TextLabel";
            v11.AutomaticSize = Enum.AutomaticSize.XY;
            v11.BackgroundTransparency = 1;
            v11.BorderSizePixel = 0;
            v11.LayoutOrder = 1;
            u2.applyTextStyle(v11);
            v11.Parent = v7;
            return v7;
        end,
        GenerateState = function(p12) --[[ Name: GenerateState, Line 89 ]]
            -- upvalues: u1 (copy)
            if p12.state.isChecked == nil then
                p12.state.isChecked = u1._widgetState(p12, "checked", false);
            end;
        end,
        Update = function(p13) --[[ Name: Update, Line 94 ]]
            p13.Instance.TextLabel.Text = p13.arguments.Text or "Checkbox";
        end,
        UpdateState = function(p14) --[[ Name: UpdateState, Line 98 ]]
            -- upvalues: u1 (copy)
            local l__Checkmark__1 = p14.Instance.Box.Checkmark;
            if p14.state.isChecked.value then
                l__Checkmark__1.ImageTransparency = u1._config.CheckMarkTransparency;
                p14.lastCheckedTick = u1._cycleTick + 1;
            else
                l__Checkmark__1.ImageTransparency = 1;
                p14.lastUncheckedTick = u1._cycleTick + 1;
            end;
        end,
        Discard = function(p15) --[[ Name: Discard, Line 110 ]]
            -- upvalues: u2 (copy)
            p15.Instance:Destroy();
            u2.discardState(p15);
        end
    });
end;