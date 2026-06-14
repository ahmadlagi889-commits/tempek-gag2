-- Decompiled with Potassium's decompiler.

return function(u1) --[[ Line: 1 ]]
    local l__GuiService__1 = game:GetService("GuiService");
    local l__isOldTopbar__2 = u1.isOldTopbar;
    local v2 = {};
    local v3 = l__GuiService__1:GetGuiInset();
    local v4 = l__GuiService__1:IsTenFootInterface();
    local v5 = v4 and 10 or (l__isOldTopbar__2 and 12 or v3.Y - 46);
    local u6 = Instance.new("ScreenGui");
    u6:SetAttribute("StartInset", v5);
    u6.Name = "TopbarStandard";
    u6.Enabled = true;
    u6.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    u6.IgnoreGuiInset = true;
    u6.ResetOnSpawn = false;
    u6.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
    v2[u6.Name] = u6;
    u6.DisplayOrder = u1.baseDisplayOrder;
    u1.baseDisplayOrderChanged:Connect(function() --[[ Line: 22 ]]
        -- upvalues: u6 (copy), u1 (copy)
        u6.DisplayOrder = u1.baseDisplayOrder;
    end);
    local v7 = Instance.new("Frame");
    local v8 = l__isOldTopbar__2 and 2 or 0;
    local u9;
    if v4 then
        v8 = v8 + 13;
        u9 = 50;
    else
        u9 = -2;
    end;
    v7.Name = "Holders";
    v7.BackgroundTransparency = 1;
    v7.Position = UDim2.new(0, 0, 0, v8);
    v7.Size = UDim2.new(1, 0, 1, u9);
    v7.Visible = true;
    v7.ZIndex = 1;
    v7.Parent = u6;
    local u10 = u6:Clone();
    local l__Holders__3 = u10.Holders;
    local l__GuiService__4 = game:GetService("GuiService");
    local function v11() --[[ Line: 44 ]]
        -- upvalues: l__Holders__3 (copy), l__GuiService__4 (copy), u9 (ref)
        l__Holders__3.Size = UDim2.new(1, 0, 0, l__GuiService__4.TopbarInset.Height + u9);
    end;
    u10.Name = "TopbarCentered";
    u10.ScreenInsets = Enum.ScreenInsets.None;
    u1.baseDisplayOrderChanged:Connect(function() --[[ Line: 49 ]]
        -- upvalues: u10 (copy), u1 (copy)
        u10.DisplayOrder = u1.baseDisplayOrder;
    end);
    v2[u10.Name] = u10;
    l__GuiService__4:GetPropertyChangedSignal("TopbarInset"):Connect(v11);
    l__Holders__3.Size = UDim2.new(1, 0, 0, l__GuiService__4.TopbarInset.Height + u9);
    local u12 = u6:Clone();
    u12.Name = u12.Name .. "Clipped";
    u12.DisplayOrder = u12.DisplayOrder + 1;
    u1.baseDisplayOrderChanged:Connect(function() --[[ Line: 59 ]]
        -- upvalues: u12 (copy), u1 (copy)
        u12.DisplayOrder = u1.baseDisplayOrder + 1;
    end);
    v2[u12.Name] = u12;
    local u13 = u10:Clone();
    u13.Name = u13.Name .. "Clipped";
    u13.DisplayOrder = u13.DisplayOrder + 1;
    u1.baseDisplayOrderChanged:Connect(function() --[[ Line: 67 ]]
        -- upvalues: u13 (copy), u1 (copy)
        u13.DisplayOrder = u1.baseDisplayOrder + 1;
    end);
    v2[u13.Name] = u13;
    if l__isOldTopbar__2 then
        task.defer(function() --[[ Line: 73 ]]
            -- upvalues: l__GuiService__4 (copy), u1 (copy)
            local function v14() --[[ Line: 74 ]]
                -- upvalues: l__GuiService__4 (ref), u1 (ref)
                if l__GuiService__4.MenuIsOpen then
                    u1.setTopbarEnabled(false, true);
                else
                    u1.setTopbarEnabled();
                end;
            end;
            l__GuiService__4:GetPropertyChangedSignal("MenuIsOpen"):Connect(v14);
            if l__GuiService__4.MenuIsOpen then
                u1.setTopbarEnabled(false, true);
            else
                u1.setTopbarEnabled();
            end;
        end);
    end;
    local v15 = Instance.new("ScrollingFrame");
    v15:SetAttribute("IsAHolder", true);
    v15.Name = "Left";
    v15.Position = UDim2.fromOffset(v5, 0);
    v15.Size = UDim2.new(1, -24, 1, 0);
    v15.BackgroundTransparency = 1;
    v15.Visible = true;
    v15.ZIndex = 1;
    v15.Active = false;
    v15.ClipsDescendants = true;
    v15.HorizontalScrollBarInset = Enum.ScrollBarInset.None;
    v15.CanvasSize = UDim2.new(0, 0, 1, -1);
    v15.AutomaticCanvasSize = Enum.AutomaticSize.X;
    v15.ScrollingDirection = Enum.ScrollingDirection.X;
    v15.ScrollBarThickness = 0;
    v15.BorderSizePixel = 0;
    v15.Selectable = false;
    v15.ScrollingEnabled = false;
    v15.ElasticBehavior = Enum.ElasticBehavior.Never;
    v15.Parent = v7;
    local v16 = Instance.new("UIListLayout");
    v16.Padding = UDim.new(0, v5);
    v16.FillDirection = Enum.FillDirection.Horizontal;
    v16.SortOrder = Enum.SortOrder.LayoutOrder;
    v16.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    v16.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    v16.Parent = v15;
    local v17 = v15:Clone();
    v17.ScrollingEnabled = false;
    v17.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v17.Name = "Center";
    v17.Parent = l__Holders__3;
    local v18 = v15:Clone();
    v18.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    v18.Name = "Right";
    v18.AnchorPoint = Vector2.new(1, 0);
    v18.Position = UDim2.new(1, -12, 0, 0);
    v18.Parent = v7;
    return v2;
end;