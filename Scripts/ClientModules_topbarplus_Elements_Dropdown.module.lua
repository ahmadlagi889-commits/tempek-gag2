-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__Themes__3 = require(script.Parent.Parent.Features.Themes);
return function(u1) --[[ Line: 5 ]]
    -- upvalues: l__Themes__3 (copy), l__TweenService__1 (copy), l__RunService__2 (copy)
    local u2 = Instance.new("Frame");
    u2.Name = "Dropdown";
    u2.AutomaticSize = Enum.AutomaticSize.X;
    u2.BackgroundTransparency = 1;
    u2.BorderSizePixel = 0;
    u2.AnchorPoint = Vector2.new(0.5, 0);
    u2.Position = UDim2.new(0.5, 0, 1, 10);
    u2.ZIndex = -2;
    u2.ClipsDescendants = true;
    u2.Parent = u1.widget;
    local l__GuiService__4 = game:GetService("GuiService");
    u1:setBehaviour("Dropdown", "BackgroundTransparency", function(p3) --[[ Line: 20 ]]
        -- upvalues: l__GuiService__4 (copy)
        local v4 = p3 * l__GuiService__4.PreferredTransparency;
        if p3 == 1 then
            return p3;
        else
            return v4;
        end;
    end);
    u1.janitor:add(l__GuiService__4:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() --[[ Line: 28 ]]
        -- upvalues: u1 (copy), u2 (copy)
        u1:refreshAppearance(u2, "BackgroundTransparency");
    end));
    local v5 = Instance.new("UICorner");
    v5.Name = "DropdownCorner";
    v5.CornerRadius = UDim.new(0, 10);
    v5.Parent = u2;
    local u6 = Instance.new("ScrollingFrame");
    u6.Name = "DropdownScroller";
    u6.AutomaticSize = Enum.AutomaticSize.X;
    u6.BackgroundTransparency = 1;
    u6.BorderSizePixel = 0;
    u6.AnchorPoint = Vector2.new(0, 0);
    u6.Position = UDim2.new(0, 0, 0, 0);
    u6.ZIndex = -1;
    u6.ClipsDescendants = true;
    u6.Visible = true;
    u6.VerticalScrollBarInset = Enum.ScrollBarInset.None;
    u6.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
    u6.Active = false;
    u6.ScrollingEnabled = true;
    u6.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    u6.ScrollBarThickness = 5;
    u6.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    u6.ScrollBarImageTransparency = 0.8;
    u6.CanvasSize = UDim2.new(0, 0, 0, 0);
    u6.Selectable = false;
    u6.Active = true;
    u6.Parent = u2;
    local u7 = Instance.new("NumberValue");
    u7.Name = "DropdownSpeed";
    u7.Value = 0.07;
    u7.Parent = u2;
    local u8 = Instance.new("UIPadding");
    u8.Name = "DropdownPadding";
    u8.PaddingTop = UDim.new(0, 0);
    u8.PaddingBottom = UDim.new(0, 0);
    u8.Parent = u6;
    local v9 = Instance.new("UIListLayout");
    v9.Name = "DropdownList";
    v9.FillDirection = Enum.FillDirection.Vertical;
    v9.SortOrder = Enum.SortOrder.LayoutOrder;
    v9.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v9.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    v9.Parent = u6;
    local l__dropdownJanitor__5 = u1.dropdownJanitor;
    local l__iconModule__6 = require(u1.iconModule);
    u1.dropdownChildAdded:Connect(function(u10) --[[ Line: 81 ]]
        local _, u11 = u10:modifyTheme({
            { "Widget", "BorderSize", 0 },
            { "IconCorners", "CornerRadius", UDim.new(0, 10) },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 58 },
            { "IconLabel", "TextSize", 20 },
            { "IconOverlay", "Size", UDim2.new(1, 0, 1, 0) },
            { "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
            { "Notice", "Position", UDim2.new(1, -24, 0, 5) },
            { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
            { "Selection", "Size", UDim2.new(1, -0, 1, -0) },
            { "Selection", "Position", UDim2.new(0, 0, 0, 0) }
        });
        task.defer(function() --[[ Line: 95 ]]
            -- upvalues: u10 (copy), u11 (copy)
            u10.joinJanitor:add(function() --[[ Line: 96 ]]
                -- upvalues: u10 (ref), u11 (ref)
                u10:removeModification(u11);
            end);
        end);
    end);
    u1.dropdownSet:Connect(function(p12) --[[ Line: 101 ]]
        -- upvalues: u1 (copy), l__iconModule__6 (copy)
        for _, v13 in pairs(u1.dropdownIcons) do
            l__iconModule__6.getIconByUID(v13):destroy();
        end;
        if type(p12) == "table" then
            for _, v14 in pairs(p12) do
                v14:joinDropdown(u1);
            end;
        end;
    end);
    local function u25() --[[ Line: 113 ]]
        -- upvalues: u2 (copy), u6 (copy), u8 (copy)
        local v15 = u2:GetAttribute("MaxIcons");
        if not v15 then
            return 0;
        end;
        local v16 = {};
        for _, v17 in pairs(u6:GetChildren()) do
            if v17:IsA("GuiObject") and v17.Visible then
                table.insert(v16, v17);
            end;
        end;
        table.sort(v16, function(p18, p19) --[[ Line: 124 ]]
            return p18.AbsolutePosition.Y < p19.AbsolutePosition.Y;
        end);
        local v20 = math.ceil(v15);
        local v21 = 0;
        for v22 = 1, v20 do
            local v23 = v16[v22];
            if not v23 then
                break;
            end;
            local l__Y__7 = v23.AbsoluteSize.Y;
            local v24;
            if v22 == v20 then
                v24 = v20 ~= v15;
            else
                v24 = false;
            end;
            if v24 then
                l__Y__7 = l__Y__7 * (v15 - v20 + 1);
            end;
            v21 = v21 + l__Y__7;
        end;
        return v21 + (u8.PaddingTop.Offset + u8.PaddingBottom.Offset);
    end;
    local u26 = nil;
    local u27 = nil;
    local u28 = nil;
    local u29 = nil;
    local function v35() --[[ Line: 159 ]]
        -- upvalues: l__Themes__3 (ref), u2 (copy), u28 (ref), u29 (ref), u7 (copy), u26 (ref), u27 (ref), u1 (copy), u25 (copy), l__TweenService__1 (ref)
        local v30 = l__Themes__3.getInstanceValue(u2, "MaxIcons") or 1;
        local v31;
        if u28 and (u28 == v30 and u29) then
            v31 = u29;
        else
            v31 = TweenInfo.new(u7.Value * v30, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            u29 = v31;
            u28 = v30;
        end;
        if u26 then
            u26:Cancel();
            u26:Destroy();
            u26 = nil;
        end;
        if u27 then
            u27:Cancel();
            u27:Destroy();
            u27 = nil;
        end;
        if u1.isSelected then
            local v32 = u25();
            u2.Visible = true;
            u2.BackgroundTransparency = 0;
            u2.Size = UDim2.new(0, u2.Size.X.Offset, 0, 0);
            local u33 = l__TweenService__1:Create(u2, v31, {
                Size = UDim2.new(0, u2.Size.X.Offset, 0, v32)
            });
            u26 = u33;
            u33:Play();
            u33.Completed:Connect(function() --[[ Line: 184 ]]
                -- upvalues: u26 (ref), u33 (copy)
                if u26 == u33 then
                    u26 = nil;
                end;
                u33:Destroy();
            end);
        else
            local u34 = l__TweenService__1:Create(u2, TweenInfo.new(0), {
                Size = UDim2.new(0, u2.Size.X.Offset, 0, 0)
            });
            u27 = u34;
            u34:Play();
            u34.Completed:Connect(function() --[[ Line: 193 ]]
                -- upvalues: u27 (ref), u34 (copy)
                if u27 == u34 then
                    u27 = nil;
                end;
                u34:Destroy();
            end);
        end;
    end;
    l__dropdownJanitor__5:add(u1.toggled:Connect(v35));
    v35();
    local function u40() --[[ Line: 204 ]]
        -- upvalues: l__Themes__3 (ref), u2 (copy), u28 (ref), u29 (ref), u7 (copy), u1 (copy), u26 (ref), u27 (ref), l__RunService__2 (ref), u25 (copy), l__TweenService__1 (ref)
        local v36 = l__Themes__3.getInstanceValue(u2, "MaxIcons") or 1;
        local v37;
        if u28 and (u28 == v36 and u29) then
            v37 = u29;
        else
            v37 = TweenInfo.new(u7.Value * v36, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            u29 = v37;
            u28 = v36;
        end;
        if u1.isSelected then
            if u26 then
                u26:Cancel();
                u26:Destroy();
                u26 = nil;
            end;
            if u27 then
                u27:Cancel();
                u27:Destroy();
                u27 = nil;
            end;
            l__RunService__2.Heartbeat:Wait();
            local v38 = u25();
            local u39 = l__TweenService__1:Create(u2, v37, {
                Size = UDim2.new(0, u2.Size.X.Offset, 0, v38)
            });
            u26 = u39;
            u39:Play();
            u39.Completed:Connect(function() --[[ Line: 226 ]]
                -- upvalues: u26 (ref), u39 (copy)
                if u26 == u39 then
                    u26 = nil;
                end;
                u39:Destroy();
            end);
        end;
    end;
    l__dropdownJanitor__5:add(u1.toggled:Connect(v35));
    local u41 = 0;
    local u42 = false;
    local function u58() --[[ Line: 240 ]]
        -- upvalues: u41 (ref), u42 (ref), u58 (copy), u2 (copy), u6 (copy), l__iconModule__6 (copy), u1 (copy), u8 (copy)
        u41 = u41 + 1;
        if u42 then
            return;
        end;
        local u43 = u41;
        u42 = true;
        task.defer(function() --[[ Line: 245 ]]
            -- upvalues: u42 (ref), u41 (ref), u43 (copy), u58 (ref)
            u42 = false;
            if u41 ~= u43 then
                u58();
            end;
        end);
        local v44 = u2:GetAttribute("MaxIcons");
        if not v44 then
            return;
        end;
        local v45 = {};
        for _, v46 in pairs(u6:GetChildren()) do
            if v46:IsA("GuiObject") and v46.Visible then
                table.insert(v45, { v46, v46.AbsolutePosition.Y });
            end;
        end;
        table.sort(v45, function(p47, p48) --[[ Line: 260 ]]
            return p47[2] < p48[2];
        end);
        local v49 = math.ceil(v44);
        local v50 = 0;
        local v51 = false;
        for v52 = 1, v49 do
            local v53 = v45[v52];
            if not v53 then
                break;
            end;
            local v54 = v53[1];
            local l__Y__8 = v54.AbsoluteSize.Y;
            local v55;
            if v52 == v49 then
                v55 = v49 ~= v44;
            else
                v55 = false;
            end;
            if v55 then
                l__Y__8 = l__Y__8 * (v44 - v49 + 1);
            end;
            v50 = v50 + l__Y__8;
            if not v55 then
                local v56 = v54:GetAttribute("WidgetUID");
                if v56 then
                    v56 = l__iconModule__6.getIconByUID(v56);
                end;
                if v56 then
                    local v57;
                    if v51 then
                        v57 = nil;
                    else
                        v57 = u1:getInstance("ClickRegion");
                        v51 = true;
                    end;
                    v56:getInstance("ClickRegion").NextSelectionUp = v57;
                end;
            end;
        end;
        u6.Size = UDim2.fromOffset(0, v50 + (u8.PaddingTop.Offset + u8.PaddingBottom.Offset));
    end;
    l__dropdownJanitor__5:add(u6:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(u58));
    l__dropdownJanitor__5:add(u6.ChildAdded:Connect(u58));
    l__dropdownJanitor__5:add(u6.ChildRemoved:Connect(u40));
    l__dropdownJanitor__5:add(u6.ChildRemoved:Connect(u58));
    l__dropdownJanitor__5:add(u2:GetAttributeChangedSignal("MaxIcons"):Connect(u58));
    l__dropdownJanitor__5:add(u2:GetAttributeChangedSignal("MaxIcons"):Connect(u40));
    l__dropdownJanitor__5:add(u1.childThemeModified:Connect(u58));
    u58();
    for _, v59 in pairs(u6:GetChildren()) do
        if v59:IsA("GuiObject") then
            v59:GetPropertyChangedSignal("Visible"):Connect(u40);
            v59:GetPropertyChangedSignal("Size"):Connect(u40);
        end;
    end;
    l__dropdownJanitor__5:add(u6.ChildAdded:Connect(function(p60) --[[ Line: 318 ]]
        -- upvalues: l__RunService__2 (ref), u40 (copy)
        l__RunService__2.Heartbeat:Wait();
        if p60:IsA("GuiObject") then
            p60:GetPropertyChangedSignal("Visible"):Connect(u40);
            p60:GetPropertyChangedSignal("Size"):Connect(u40);
        end;
        u40();
    end));
    u2.Visible = false;
    return u2;
end;