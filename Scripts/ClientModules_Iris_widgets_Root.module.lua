-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    local u3 = 0;
    u1.WidgetConstructor("Root", {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = function(_) --[[ Name: Generate, Line 12 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v4 = Instance.new("Folder");
            v4.Name = "Iris_Root";
            local v5;
            if u1._config.UseScreenGUIs then
                v5 = Instance.new("ScreenGui");
                v5.ResetOnSpawn = false;
                v5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                v5.ScreenInsets = u1._config.ScreenInsets;
                v5.IgnoreGuiInset = u1._config.IgnoreGuiInset;
                v5.DisplayOrder = u1._config.DisplayOrderOffset;
            else
                v5 = Instance.new("Frame");
                v5.AnchorPoint = Vector2.new(0.5, 0.5);
                v5.Position = UDim2.fromScale(0.5, 0.5);
                v5.Size = UDim2.fromScale(1, 1);
                v5.BackgroundTransparency = 1;
                v5.ZIndex = u1._config.DisplayOrderOffset;
            end;
            v5.Name = "PseudoWindowScreenGui";
            v5.Parent = v4;
            local v6;
            if u1._config.UseScreenGUIs then
                v6 = Instance.new("ScreenGui");
                v6.ResetOnSpawn = false;
                v6.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                v6.DisplayOrder = u1._config.DisplayOrderOffset + 1024;
                v6.ScreenInsets = u1._config.ScreenInsets;
                v6.IgnoreGuiInset = u1._config.IgnoreGuiInset;
            else
                v6 = Instance.new("Frame");
                v6.AnchorPoint = Vector2.new(0.5, 0.5);
                v6.Position = UDim2.fromScale(0.5, 0.5);
                v6.Size = UDim2.fromScale(1, 1);
                v6.BackgroundTransparency = 1;
                v6.ZIndex = u1._config.DisplayOrderOffset + 1024;
            end;
            v6.Name = "PopupScreenGui";
            v6.Parent = v4;
            local v7 = Instance.new("Frame");
            v7.Name = "TooltipContainer";
            v7.AutomaticSize = Enum.AutomaticSize.XY;
            v7.Size = UDim2.fromOffset(0, 0);
            v7.BackgroundTransparency = 1;
            v7.BorderSizePixel = 0;
            u2.UIListLayout(v7, Enum.FillDirection.Vertical, UDim.new(0, u1._config.PopupBorderSize));
            v7.Parent = v6;
            local v8 = Instance.new("Frame");
            v8.Name = "MenuBarContainer";
            v8.AutomaticSize = Enum.AutomaticSize.Y;
            v8.Size = UDim2.fromScale(1, 0);
            v8.BackgroundTransparency = 1;
            v8.BorderSizePixel = 0;
            v8.Parent = v6;
            local v9 = Instance.new("Frame");
            v9.Name = "PseudoWindow";
            v9.AutomaticSize = Enum.AutomaticSize.XY;
            v9.Size = UDim2.new(0, 0, 0, 0);
            v9.Position = UDim2.fromOffset(0, 22);
            v9.BackgroundTransparency = u1._config.WindowBgTransparency;
            v9.BackgroundColor3 = u1._config.WindowBgColor;
            v9.BorderSizePixel = u1._config.WindowBorderSize;
            v9.BorderColor3 = u1._config.BorderColor;
            v9.Selectable = false;
            v9.SelectionGroup = true;
            v9.SelectionBehaviorUp = Enum.SelectionBehavior.Stop;
            v9.SelectionBehaviorDown = Enum.SelectionBehavior.Stop;
            v9.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop;
            v9.SelectionBehaviorRight = Enum.SelectionBehavior.Stop;
            v9.Visible = false;
            u2.UIPadding(v9, u1._config.WindowPadding);
            u2.UIListLayout(v9, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y));
            v9.Parent = v5;
            return v4;
        end,
        Update = function(p10) --[[ Name: Update, Line 100 ]]
            -- upvalues: u3 (ref)
            if u3 > 0 then
                p10.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = true;
            end;
        end,
        Discard = function(p11) --[[ Name: Discard, Line 108 ]]
            -- upvalues: u3 (ref)
            u3 = 0;
            p11.Instance:Destroy();
        end,
        ChildAdded = function(p12, p13) --[[ Name: ChildAdded, Line 112 ]]
            -- upvalues: u3 (ref)
            local l__Instance__1 = p12.Instance;
            if p13.type == "Window" then
                return p12.Instance;
            end;
            if p13.type == "Tooltip" then
                return l__Instance__1.PopupScreenGui.TooltipContainer;
            end;
            if p13.type == "MenuBar" then
                return l__Instance__1.PopupScreenGui.MenuBarContainer;
            end;
            local l__PseudoWindow__2 = l__Instance__1.PseudoWindowScreenGui.PseudoWindow;
            u3 = u3 + 1;
            l__PseudoWindow__2.Visible = true;
            return l__PseudoWindow__2;
        end,
        ChildDiscarded = function(p14, p15) --[[ Name: ChildDiscarded, Line 131 ]]
            -- upvalues: u3 (ref)
            if p15.type ~= "Window" and (p15.type ~= "Tooltip" and p15.type ~= "MenuBar") then
                u3 = u3 - 1;
                if u3 == 0 then
                    p14.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = false;
                end;
            end;
        end
    });
end;