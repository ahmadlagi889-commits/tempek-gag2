-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Separator", {
        hasState = false,
        hasChildren = false,
        Args = {},
        Events = {},
        Generate = function(p3) --[[ Name: Generate, Line 10 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v4 = Instance.new("Frame");
            v4.Name = "Iris_Separator";
            if p3.parentWidget.type == "SameLine" then
                v4.Size = UDim2.new(0, 1, u1._config.ItemWidth.Scale, u1._config.ItemWidth.Offset);
            else
                v4.Size = UDim2.new(u1._config.ItemWidth.Scale, u1._config.ItemWidth.Offset, 0, 1);
            end;
            v4.BackgroundColor3 = u1._config.SeparatorColor;
            v4.BackgroundTransparency = u1._config.SeparatorTransparency;
            v4.BorderSizePixel = 0;
            u2.UIListLayout(v4, Enum.FillDirection.Vertical, UDim.new(0, 0));
            return v4;
        end,
        Update = function(_) --[[ Name: Update, Line 27 ]] end,
        Discard = function(p5) --[[ Name: Discard, Line 28 ]]
            p5.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("Indent", {
        hasState = false,
        hasChildren = true,
        Args = {
            Width = 1
        },
        Events = {},
        Generate = function(_) --[[ Name: Generate, Line 41 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v6 = Instance.new("Frame");
            v6.Name = "Iris_Indent";
            v6.AutomaticSize = Enum.AutomaticSize.Y;
            v6.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v6.BackgroundTransparency = 1;
            v6.BorderSizePixel = 0;
            u2.UIListLayout(v6, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            u2.UIPadding(v6, Vector2.zero);
            return v6;
        end,
        Update = function(p7) --[[ Name: Update, Line 54 ]]
            -- upvalues: u1 (copy)
            local l__UIPadding__1 = p7.Instance.UIPadding;
            local l__new__2 = UDim.new;
            local v8 = 0;
            local v9;
            if p7.arguments.Width then
                v9 = p7.arguments.Width;
            else
                v9 = u1._config.IndentSpacing;
            end;
            l__UIPadding__1.PaddingLeft = l__new__2(v8, v9);
        end,
        ChildAdded = function(p10, _) --[[ Name: ChildAdded, Line 59 ]]
            return p10.Instance;
        end,
        Discard = function(p11) --[[ Name: Discard, Line 62 ]]
            p11.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("SameLine", {
        hasState = false,
        hasChildren = true,
        Args = {
            Width = 1,
            VerticalAlignment = 2,
            HorizontalAlignment = 3
        },
        Events = {},
        Generate = function(_) --[[ Name: Generate, Line 77 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v12 = Instance.new("Frame");
            v12.Name = "Iris_SameLine";
            v12.AutomaticSize = Enum.AutomaticSize.Y;
            v12.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v12.BackgroundTransparency = 1;
            v12.BorderSizePixel = 0;
            u2.UIListLayout(v12, Enum.FillDirection.Horizontal, UDim.new(0, 0));
            return v12;
        end,
        Update = function(p13) --[[ Name: Update, Line 89 ]]
            -- upvalues: u1 (copy)
            local l__UIListLayout__3 = p13.Instance.UIListLayout;
            local l__new__4 = UDim.new;
            local v14 = 0;
            local v15;
            if p13.arguments.Width then
                v15 = p13.arguments.Width;
            else
                v15 = u1._config.ItemSpacing.X;
            end;
            l__UIListLayout__3.Padding = l__new__4(v14, v15);
            if p13.arguments.VerticalAlignment then
                l__UIListLayout__3.VerticalAlignment = p13.arguments.VerticalAlignment;
            else
                l__UIListLayout__3.VerticalAlignment = Enum.VerticalAlignment.Top;
            end;
            if p13.arguments.HorizontalAlignment then
                l__UIListLayout__3.HorizontalAlignment = p13.arguments.HorizontalAlignment;
            else
                l__UIListLayout__3.HorizontalAlignment = Enum.HorizontalAlignment.Left;
            end;
        end,
        ChildAdded = function(p16, _) --[[ Name: ChildAdded, Line 105 ]]
            return p16.Instance;
        end,
        Discard = function(p17) --[[ Name: Discard, Line 108 ]]
            p17.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("Group", {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = function(_) --[[ Name: Generate, Line 119 ]]
            -- upvalues: u2 (copy), u1 (copy)
            local v18 = Instance.new("Frame");
            v18.Name = "Iris_Group";
            v18.AutomaticSize = Enum.AutomaticSize.XY;
            v18.Size = UDim2.fromOffset(0, 0);
            v18.BackgroundTransparency = 1;
            v18.BorderSizePixel = 0;
            v18.ClipsDescendants = false;
            u2.UIListLayout(v18, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            return v18;
        end,
        Update = function(_) --[[ Name: Update, Line 132 ]] end,
        ChildAdded = function(p19, _) --[[ Name: ChildAdded, Line 133 ]]
            return p19.Instance;
        end,
        Discard = function(p20) --[[ Name: Discard, Line 136 ]]
            p20.Instance:Destroy();
        end
    });
end;