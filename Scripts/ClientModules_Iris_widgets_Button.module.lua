-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local u11 = {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            Size = 2
        },
        Events = {
            clicked = u2.EVENTS.click(function(p3) --[[ Line: 12 ]]
                return p3.Instance;
            end),
            rightClicked = u2.EVENTS.rightClick(function(p4) --[[ Line: 15 ]]
                return p4.Instance;
            end),
            doubleClicked = u2.EVENTS.doubleClick(function(p5) --[[ Line: 18 ]]
                return p5.Instance;
            end),
            ctrlClicked = u2.EVENTS.ctrlClick(function(p6) --[[ Line: 21 ]]
                return p6.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p7) --[[ Line: 24 ]]
                return p7.Instance;
            end)
        },
        Generate = function(_) --[[ Name: Generate, Line 28 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v8 = Instance.new("TextButton");
            v8.AutomaticSize = Enum.AutomaticSize.XY;
            v8.Size = UDim2.fromOffset(0, 0);
            v8.BackgroundColor3 = u1._config.ButtonColor;
            v8.BackgroundTransparency = u1._config.ButtonTransparency;
            v8.AutoButtonColor = false;
            u2.applyTextStyle(v8);
            v8.TextXAlignment = Enum.TextXAlignment.Center;
            u2.applyFrameStyle(v8);
            u2.applyInteractionHighlights("Background", v8, v8, {
                Color = u1._config.ButtonColor,
                Transparency = u1._config.ButtonTransparency,
                HoveredColor = u1._config.ButtonHoveredColor,
                HoveredTransparency = u1._config.ButtonHoveredTransparency,
                ActiveColor = u1._config.ButtonActiveColor,
                ActiveTransparency = u1._config.ButtonActiveTransparency
            });
            return v8;
        end,
        Update = function(p9) --[[ Name: Update, Line 52 ]]
            local l__Instance__1 = p9.Instance;
            l__Instance__1.Text = p9.arguments.Text or "Button";
            l__Instance__1.Size = p9.arguments.Size or UDim2.fromOffset(0, 0);
        end,
        Discard = function(p10) --[[ Name: Discard, Line 57 ]]
            p10.Instance:Destroy();
        end
    };
    u2.abstractButton = u11;
    u1.WidgetConstructor("Button", u2.extend(u11, {
        Generate = function(p12) --[[ Name: Generate, Line 65 ]]
            -- upvalues: u11 (copy)
            local v13 = u11.Generate(p12);
            v13.Name = "Iris_Button";
            return v13;
        end
    }));
    u1.WidgetConstructor("SmallButton", u2.extend(u11, {
        Generate = function(p14) --[[ Name: Generate, Line 76 ]]
            -- upvalues: u11 (copy)
            local v15 = u11.Generate(p14);
            v15.Name = "Iris_SmallButton";
            local l__UIPadding__2 = v15.UIPadding;
            l__UIPadding__2.PaddingLeft = UDim.new(0, 2);
            l__UIPadding__2.PaddingRight = UDim.new(0, 2);
            l__UIPadding__2.PaddingTop = UDim.new(0, 0);
            l__UIPadding__2.PaddingBottom = UDim.new(0, 0);
            return v15;
        end
    }));
end;