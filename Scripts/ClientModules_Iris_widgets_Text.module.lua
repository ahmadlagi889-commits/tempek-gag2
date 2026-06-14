-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Text", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            Wrapped = 2,
            Color = 3,
            RichText = 4
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p3) --[[ Line: 15 ]]
                return p3.Instance;
            end)
        },
        Generate = function(_) --[[ Name: Generate, Line 19 ]]
            -- upvalues: u2 (copy)
            local v4 = Instance.new("TextLabel");
            v4.Name = "Iris_Text";
            v4.AutomaticSize = Enum.AutomaticSize.XY;
            v4.Size = UDim2.fromOffset(0, 0);
            v4.BackgroundTransparency = 1;
            v4.BorderSizePixel = 0;
            u2.applyTextStyle(v4);
            u2.UIPadding(v4, Vector2.new(0, 2));
            return v4;
        end,
        Update = function(p5) --[[ Name: Update, Line 32 ]]
            -- upvalues: u1 (copy)
            local l__Instance__1 = p5.Instance;
            if p5.arguments.Text == nil then
                error("Text argument is required for Iris.Text().", 5);
            end;
            if p5.arguments.Wrapped == nil then
                l__Instance__1.TextWrapped = u1._config.TextWrapped;
            else
                l__Instance__1.TextWrapped = p5.arguments.Wrapped;
            end;
            if p5.arguments.Color then
                l__Instance__1.TextColor3 = p5.arguments.Color;
            else
                l__Instance__1.TextColor3 = u1._config.TextColor;
            end;
            if p5.arguments.RichText == nil then
                l__Instance__1.RichText = u1._config.RichText;
            else
                l__Instance__1.RichText = p5.arguments.RichText;
            end;
            l__Instance__1.Text = p5.arguments.Text;
        end,
        Discard = function(p6) --[[ Name: Discard, Line 55 ]]
            p6.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("SeparatorText", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p7) --[[ Line: 68 ]]
                return p7.Instance;
            end)
        },
        Generate = function(_) --[[ Name: Generate, Line 72 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v8 = Instance.new("Frame");
            v8.Name = "Iris_SeparatorText";
            v8.AutomaticSize = Enum.AutomaticSize.Y;
            v8.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v8.BackgroundTransparency = 1;
            v8.BorderSizePixel = 0;
            v8.ClipsDescendants = true;
            u2.UIPadding(v8, Vector2.new(0, u1._config.SeparatorTextPadding.Y));
            u2.UIListLayout(v8, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemSpacing.X));
            v8.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
            local v9 = Instance.new("TextLabel");
            v9.Name = "TextLabel";
            v9.AutomaticSize = Enum.AutomaticSize.XY;
            v9.BackgroundTransparency = 1;
            v9.BorderSizePixel = 0;
            v9.LayoutOrder = 1;
            u2.applyTextStyle(v9);
            v9.Parent = v8;
            local v10 = Instance.new("Frame");
            v10.Name = "Left";
            v10.AnchorPoint = Vector2.new(1, 0.5);
            v10.Size = UDim2.fromOffset(u1._config.SeparatorTextPadding.X - u1._config.ItemSpacing.X, u1._config.SeparatorTextBorderSize);
            v10.BackgroundColor3 = u1._config.SeparatorColor;
            v10.BackgroundTransparency = u1._config.SeparatorTransparency;
            v10.BorderSizePixel = 0;
            v10.Parent = v8;
            local v11 = Instance.new("Frame");
            v11.Name = "Right";
            v11.AnchorPoint = Vector2.new(1, 0.5);
            v11.Size = UDim2.new(1, 0, 0, u1._config.SeparatorTextBorderSize);
            v11.BackgroundColor3 = u1._config.SeparatorColor;
            v11.BackgroundTransparency = u1._config.SeparatorTransparency;
            v11.BorderSizePixel = 0;
            v11.LayoutOrder = 2;
            v11.Parent = v8;
            return v8;
        end,
        Update = function(p12) --[[ Name: Update, Line 120 ]]
            local l__TextLabel__2 = p12.Instance.TextLabel;
            if p12.arguments.Text == nil then
                error("Text argument is required for Iris.SeparatorText().", 5);
            end;
            l__TextLabel__2.Text = p12.arguments.Text;
        end,
        Discard = function(p13) --[[ Name: Discard, Line 128 ]]
            p13.Instance:Destroy();
        end
    });
end;