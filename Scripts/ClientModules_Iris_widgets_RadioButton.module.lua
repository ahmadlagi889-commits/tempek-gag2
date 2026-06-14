-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("RadioButton", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Index = 2
        },
        Events = {
            selected = {
                Init = function(_) --[[ Line: 14 ]] end,
                Get = function(p3) --[[ Line: 15 ]]
                    -- upvalues: u1 (copy)
                    return p3.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(_) --[[ Line: 20 ]] end,
                Get = function(p4) --[[ Line: 21 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(_) --[[ Line: 26 ]] end,
                Get = function(p5) --[[ Line: 27 ]]
                    return p5.state.index.value == p5.arguments.Index;
                end
            },
            hovered = u2.EVENTS.hover(function(p6) --[[ Line: 31 ]]
                return p6.Instance;
            end)
        },
        Generate = function(u7) --[[ Name: Generate, Line 35 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v8 = Instance.new("TextButton");
            v8.Name = "Iris_RadioButton";
            v8.AutomaticSize = Enum.AutomaticSize.XY;
            v8.Size = UDim2.fromOffset(0, 0);
            v8.BackgroundTransparency = 1;
            v8.BorderSizePixel = 0;
            v8.Text = "";
            v8.AutoButtonColor = false;
            u2.UIListLayout(v8, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v9 = u1._config.TextSize + 2 * (u1._config.FramePadding.Y - 1);
            local v10 = Instance.new("Frame");
            v10.Name = "Button";
            v10.Size = UDim2.fromOffset(v9, v9);
            v10.BackgroundColor3 = u1._config.FrameBgColor;
            v10.BackgroundTransparency = u1._config.FrameBgTransparency;
            v10.Parent = v8;
            u2.UICorner(v10);
            local l__UIPadding__1 = u2.UIPadding;
            local l__new__2 = Vector2.new;
            local v11 = math.floor(v9 / 5);
            local v12 = math.max(1, v11);
            local v13 = math.floor(v9 / 5);
            l__UIPadding__1(v10, l__new__2(v12, (math.max(1, v13))));
            local v14 = Instance.new("Frame");
            v14.Name = "Circle";
            v14.Size = UDim2.fromScale(1, 1);
            v14.BackgroundColor3 = u1._config.CheckMarkColor;
            v14.BackgroundTransparency = u1._config.CheckMarkTransparency;
            u2.UICorner(v14);
            v14.Parent = v10;
            u2.applyInteractionHighlights("Background", v8, v10, {
                Color = u1._config.FrameBgColor,
                Transparency = u1._config.FrameBgTransparency,
                HoveredColor = u1._config.FrameBgHoveredColor,
                HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ActiveColor = u1._config.FrameBgActiveColor,
                ActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            u2.applyButtonClick(v8, function() --[[ Line: 76 ]]
                -- upvalues: u7 (copy)
                u7.state.index:set(u7.arguments.Index);
            end);
            local v15 = Instance.new("TextLabel");
            v15.Name = "TextLabel";
            v15.AutomaticSize = Enum.AutomaticSize.XY;
            v15.BackgroundTransparency = 1;
            v15.BorderSizePixel = 0;
            v15.LayoutOrder = 1;
            u2.applyTextStyle(v15);
            v15.Parent = v8;
            return v8;
        end,
        Update = function(p16) --[[ Name: Update, Line 92 ]]
            -- upvalues: u1 (copy)
            p16.Instance.TextLabel.Text = p16.arguments.Text or "Radio Button";
            if p16.state then
                p16.state.index.lastChangeTick = u1._cycleTick;
                u1._widgets[p16.type].UpdateState(p16);
            end;
        end,
        Discard = function(p17) --[[ Name: Discard, Line 102 ]]
            -- upvalues: u2 (copy)
            p17.Instance:Destroy();
            u2.discardState(p17);
        end,
        GenerateState = function(p18) --[[ Name: GenerateState, Line 106 ]]
            -- upvalues: u1 (copy)
            if p18.state.index == nil then
                p18.state.index = u1._widgetState(p18, "index", p18.arguments.Index);
            end;
        end,
        UpdateState = function(p19) --[[ Name: UpdateState, Line 111 ]]
            -- upvalues: u1 (copy)
            local l__Circle__3 = p19.Instance.Button.Circle;
            if p19.state.index.value == p19.arguments.Index then
                l__Circle__3.BackgroundTransparency = u1._config.CheckMarkTransparency;
                p19.lastSelectedTick = u1._cycleTick + 1;
            else
                l__Circle__3.BackgroundTransparency = 1;
                p19.lastUnselectedTick = u1._cycleTick + 1;
            end;
        end
    });
end;