-- Decompiled with Potassium's decompiler.

return function(u1, u2) --[[ Line: 6 ]]
    local u3 = Instance.new("Frame");
    u3:SetAttribute("WidgetUID", u1.UID);
    u3.Name = "Widget";
    u3.BackgroundTransparency = 1;
    u3.Visible = true;
    u3.ZIndex = 20;
    u3.Active = false;
    u3.ClipsDescendants = true;
    local u4 = Instance.new("Frame");
    u4.Name = "IconButton";
    u4.Visible = true;
    u4.ZIndex = 2;
    u4.BorderSizePixel = 0;
    u4.Parent = u3;
    u4.ClipsDescendants = true;
    u4.Active = false;
    u1.deselected:Connect(function() --[[ Line: 25 ]]
        -- upvalues: u4 (copy)
        u4.ClipsDescendants = true;
    end);
    u1.selected:Connect(function() --[[ Line: 28 ]]
        -- upvalues: u1 (copy), u4 (copy)
        task.defer(function() --[[ Line: 29 ]]
            -- upvalues: u1 (ref), u4 (ref)
            u1.resizingComplete:Once(function() --[[ Line: 30 ]]
                -- upvalues: u1 (ref), u4 (ref)
                if u1.isSelected then
                    u4.ClipsDescendants = false;
                end;
            end);
        end);
    end);
    local v5 = Instance.new("UICorner");
    v5:SetAttribute("Collective", "IconCorners");
    v5.Parent = u4;
    local u6 = require(script.Parent.Menu)(u1);
    local l__MenuUIListLayout__1 = u6.MenuUIListLayout;
    local l__MenuGap__2 = u6.MenuGap;
    u6.Parent = u4;
    local u7 = Instance.new("Frame");
    u7.Name = "IconSpot";
    u7.BackgroundColor3 = Color3.fromRGB(225, 225, 225);
    u7.BackgroundTransparency = 0.9;
    u7.Visible = true;
    u7.AnchorPoint = Vector2.new(0, 0.5);
    u7.ZIndex = 5;
    u7.Parent = u6;
    v5:Clone().Parent = u7;
    local v8 = u7:Clone();
    v8.Name = "IconOverlay";
    v8.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    v8.ZIndex = u7.ZIndex + 1;
    v8.Size = UDim2.new(1, 0, 1, 0);
    v8.Position = UDim2.new(0, 0, 0, 0);
    v8.AnchorPoint = Vector2.new(0, 0);
    v8.Visible = false;
    v8.Parent = u7;
    local u9 = Instance.new("TextButton");
    u9:SetAttribute("CorrespondingIconUID", u1.UID);
    u9.Name = "ClickRegion";
    u9.BackgroundTransparency = 1;
    u9.Visible = true;
    u9.Text = "";
    u9.ZIndex = 20;
    u9.Selectable = true;
    u9.SelectionGroup = true;
    u9.Parent = u7;
    require(script.Parent.Parent.Features.Gamepad).registerButton(u9);
    v5:Clone().Parent = u9;
    local u10 = Instance.new("Frame");
    u10.Name = "Contents";
    u10.BackgroundTransparency = 1;
    u10.Size = UDim2.fromScale(1, 1);
    u10.Parent = u7;
    local u11 = Instance.new("UIListLayout");
    u11.Name = "ContentsList";
    u11.FillDirection = Enum.FillDirection.Horizontal;
    u11.VerticalAlignment = Enum.VerticalAlignment.Center;
    u11.SortOrder = Enum.SortOrder.LayoutOrder;
    u11.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    u11.Padding = UDim.new(0, 3);
    u11.Parent = u10;
    local u12 = Instance.new("Frame");
    u12.Name = "PaddingLeft";
    u12.LayoutOrder = 1;
    u12.ZIndex = 5;
    u12.BorderColor3 = Color3.fromRGB(0, 0, 0);
    u12.BackgroundTransparency = 1;
    u12.BorderSizePixel = 0;
    u12.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    u12.Parent = u10;
    local u13 = Instance.new("Frame");
    u13.Name = "PaddingCenter";
    u13.LayoutOrder = 3;
    u13.ZIndex = 5;
    u13.Size = UDim2.new(0, 0, 1, 0);
    u13.BorderColor3 = Color3.fromRGB(0, 0, 0);
    u13.BackgroundTransparency = 1;
    u13.BorderSizePixel = 0;
    u13.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    u13.Parent = u10;
    local u14 = Instance.new("Frame");
    u14.Name = "PaddingRight";
    u14.LayoutOrder = 5;
    u14.ZIndex = 5;
    u14.BorderColor3 = Color3.fromRGB(0, 0, 0);
    u14.BackgroundTransparency = 1;
    u14.BorderSizePixel = 0;
    u14.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    u14.Parent = u10;
    local u15 = Instance.new("Frame");
    u15.Name = "IconLabelContainer";
    u15.LayoutOrder = 4;
    u15.ZIndex = 3;
    u15.AnchorPoint = Vector2.new(0, 0.5);
    u15.Size = UDim2.new(0, 0, 0.5, 0);
    u15.BackgroundTransparency = 1;
    u15.Position = UDim2.new(0.5, 0, 0.5, 0);
    u15.Parent = u10;
    local u16 = Instance.new("TextLabel");
    local u17 = workspace.CurrentCamera.ViewportSize.X + 200;
    u16.Name = "IconLabel";
    u16.LayoutOrder = 4;
    u16.ZIndex = 15;
    u16.AnchorPoint = Vector2.new(0, 0);
    u16.Size = UDim2.new(0, u17, 1, 0);
    u16.ClipsDescendants = false;
    u16.BackgroundTransparency = 1;
    u16.Position = UDim2.fromScale(0, 0);
    u16.RichText = true;
    u16.TextColor3 = Color3.fromRGB(255, 255, 255);
    u16.TextXAlignment = Enum.TextXAlignment.Left;
    u16.Text = "";
    u16.TextWrapped = true;
    u16.TextWrap = true;
    u16.TextScaled = false;
    u16.Active = false;
    u16.AutoLocalize = true;
    u16.Parent = u15;
    local u18 = Instance.new("ImageLabel");
    u18.Name = "IconImage";
    u18.LayoutOrder = 2;
    u18.ZIndex = 15;
    u18.AnchorPoint = Vector2.new(0, 0.5);
    u18.Size = UDim2.new(0, 0, 0.5, 0);
    u18.BackgroundTransparency = 1;
    u18.Position = UDim2.new(0, 11, 0.5, 0);
    u18.ScaleType = Enum.ScaleType.Stretch;
    u18.Active = false;
    u18.Parent = u10;
    local v19 = v5:Clone();
    v19:SetAttribute("Collective", nil);
    v19.CornerRadius = UDim.new(0, 0);
    v19.Name = "IconImageCorner";
    v19.Parent = u18;
    local l__TweenService__3 = game:GetService("TweenService");
    local u20 = 0;
    local function v49(_) --[[ Line: 184 ]]
        -- upvalues: u1 (copy), u16 (copy), u18 (copy), u15 (copy), u12 (copy), u13 (copy), u14 (copy), u4 (copy), u11 (copy), u10 (copy), u3 (copy), u17 (copy), u6 (copy), u7 (copy), l__MenuUIListLayout__1 (copy), l__MenuGap__2 (copy), l__TweenService__3 (copy), u9 (copy), u20 (ref), u2 (copy)
        task.defer(function() --[[ Line: 191 ]]
            -- upvalues: u1 (ref), u16 (ref), u18 (ref), u15 (ref), u12 (ref), u13 (ref), u14 (ref), u4 (ref), u11 (ref), u10 (ref), u3 (ref), u17 (ref), u6 (ref), u7 (ref), l__MenuUIListLayout__1 (ref), l__MenuGap__2 (ref), l__TweenService__3 (ref), u9 (ref), u20 (ref), u2 (ref)
            local l__indicator__4 = u1.indicator;
            if l__indicator__4 then
                l__indicator__4 = l__indicator__4.Visible;
            end;
            local v21 = l__indicator__4 or u16.Text ~= "";
            local v22;
            if u18.Image == "" then
                v22 = false;
            else
                v22 = u18.Image ~= nil;
            end;
            local _ = Enum.HorizontalAlignment.Center;
            local v23 = UDim2.fromScale(1, 1);
            if v22 and not v21 then
                u15.Visible = false;
                u18.Visible = true;
                u12.Visible = false;
                u13.Visible = false;
                u14.Visible = false;
            elseif v22 or not v21 then
                if v22 and v21 then
                    u15.Visible = true;
                    u18.Visible = true;
                    u12.Visible = true;
                    u13.Visible = not l__indicator__4;
                    u14.Visible = not l__indicator__4;
                    local _ = Enum.HorizontalAlignment.Left;
                end;
            else
                u15.Visible = true;
                u18.Visible = false;
                u12.Visible = true;
                u13.Visible = false;
                u14.Visible = true;
            end;
            u4.Size = v23;
            local l__Offset__5 = u11.Padding.Offset;
            u15.Size = UDim2.new(0, u16.TextBounds.X, u16.Size.Y.Scale, 0);
            local v24 = l__Offset__5;
            for _, v25 in pairs(u10:GetChildren()) do
                if v25:IsA("GuiObject") and v25.Visible == true then
                    v24 = v24 + ((v25:GetAttribute("TargetWidth") or v25.AbsoluteSize.X) + l__Offset__5);
                end;
            end;
            local v26 = u3:GetAttribute("MinimumWidth");
            local v27 = u3:GetAttribute("MinimumHeight");
            local v28 = u3:GetAttribute("BorderSize");
            local v29 = math.clamp(v24, v26, u17);
            local v30 = 0;
            local v31 = #u1.menuIcons > 0;
            if v31 then
                v31 = u1.isSelected;
            end;
            if v31 then
                for _, v32 in pairs(u6:GetChildren()) do
                    if v32 ~= u7 and (v32:IsA("GuiObject") and v32.Visible) then
                        v30 = v30 + ((v32:GetAttribute("TargetWidth") or v32.AbsoluteSize.X) + l__MenuUIListLayout__1.Padding.Offset);
                    end;
                end;
                if not u7.Visible then
                    local v33 = u7;
                    v29 = v29 - ((v33:GetAttribute("TargetWidth") or v33.AbsoluteSize.X) + l__MenuUIListLayout__1.Padding.Offset * 2 + v28);
                end;
                v30 = v30 - v28 * 0.5;
                v29 = v29 + (v30 - v28 * 0.75);
            end;
            local v34 = l__MenuGap__2;
            if v31 then
                v31 = u7.Visible;
            end;
            v34.Visible = v31;
            local v35 = u3:GetAttribute("DesiredWidth");
            if v35 then
                if v29 >= v35 then
                    v35 = v29;
                end;
            else
                v35 = v29;
            end;
            u1.updateMenu:Fire();
            local v36 = math.max(v35 - v30, v26) - v28 * 2;
            local v37 = u6:GetAttribute("MenuWidth");
            if v37 then
                v37 = v37 + v36 + l__MenuUIListLayout__1.Padding.Offset + 10;
            end;
            if v37 then
                local v38 = u6:GetAttribute("MaxWidth");
                if v38 then
                    v37 = math.max(v38, v26);
                end;
                u6:SetAttribute("MenuCanvasWidth", v35);
                if v37 >= v35 then
                    v37 = v35;
                end;
            else
                v37 = v35;
            end;
            local l__Quint__6 = Enum.EasingStyle.Quint;
            local l__Out__7 = Enum.EasingDirection.Out;
            local v39 = u7;
            local v40 = v39:GetAttribute("TargetWidth") or v39.AbsoluteSize.X;
            local v41 = math.max(v36, v40, u7.AbsoluteSize.X);
            local v42 = u3;
            local v43 = v42:GetAttribute("TargetWidth") or v42.AbsoluteSize.X;
            local v44 = math.max(v37, v43, u3.AbsoluteSize.X);
            local v45 = TweenInfo.new(v41 / 750, l__Quint__6, l__Out__7);
            local v46 = TweenInfo.new(v44 / 750, l__Quint__6, l__Out__7);
            l__TweenService__3:Create(u7, v45, {
                Position = UDim2.new(0, v28, 0.5, 0),
                Size = UDim2.new(0, v36, 1, -v28 * 2)
            }):Play();
            l__TweenService__3:Create(u9, v45, {
                Size = UDim2.new(0, v36, 1, 0)
            }):Play();
            local v47 = UDim2.fromOffset(v37, v27);
            if u3.Size.Y.Offset ~= v27 then
                u3.Size = v47;
            end;
            u3:SetAttribute("TargetWidth", v47.X.Offset);
            l__TweenService__3:Create(u3, v46, {
                Size = v47
            }):Play();
            u20 = u20 + 1;
            for v48 = 1, v46.Time * 100 do
                task.delay(v48 / 100, function() --[[ Line: 303 ]]
                    -- upvalues: u2 (ref), u1 (ref)
                    u2.iconChanged:Fire(u1);
                end);
            end;
            task.delay(v46.Time - 0.2, function() --[[ Line: 307 ]]
                -- upvalues: u20 (ref), u1 (ref)
                u20 = u20 - 1;
                task.defer(function() --[[ Line: 309 ]]
                    -- upvalues: u20 (ref), u1 (ref)
                    if u20 == 0 then
                        u1.resizingComplete:Fire();
                    end;
                end);
            end);
            u1:updateParent();
        end);
    end;
    local u50 = require(script.Parent.Parent.Utility).createStagger(0.01, v49);
    local u51 = true;
    u1:setBehaviour("IconLabel", "Text", u50);
    u1:setBehaviour("IconLabel", "FontFace", function(p52) --[[ Line: 322 ]]
        -- upvalues: u16 (copy), u50 (copy), u51 (ref)
        if u16.FontFace == p52 then
        else
            task.spawn(function() --[[ Line: 327 ]]
                -- upvalues: u50 (ref), u51 (ref)
                u50();
                if u51 then
                    u51 = false;
                    for _ = 1, 10 do
                        task.wait(1);
                        u50();
                    end;
                end;
            end);
        end;
    end);
    local function v55() --[[ Line: 349 ]]
        -- upvalues: u3 (copy), u1 (copy), u7 (copy), u6 (copy), l__MenuGap__2 (copy), l__MenuUIListLayout__1 (copy), u50 (copy)
        task.defer(function() --[[ Line: 350 ]]
            -- upvalues: u3 (ref), u1 (ref), u7 (ref), u6 (ref), l__MenuGap__2 (ref), l__MenuUIListLayout__1 (ref), u50 (ref)
            local v53 = u3:GetAttribute("BorderSize");
            local l__alignment__8 = u1.alignment;
            local v54;
            if u7.Visible == false then
                v54 = 0;
            elseif l__alignment__8 == "Right" then
                v54 = -v53 or v53;
            else
                v54 = v53;
            end;
            u6.Position = UDim2.new(0, v54, 0, 0);
            l__MenuGap__2.Size = UDim2.fromOffset(v53, 0);
            l__MenuUIListLayout__1.Padding = UDim.new(0, 0);
            u50();
        end);
    end;
    u1:setBehaviour("Widget", "BorderSize", v55);
    u1:setBehaviour("IconSpot", "Visible", v55);
    u1.startMenuUpdate:Connect(u50);
    u1.updateSize:Connect(u50);
    u1:setBehaviour("ContentsList", "HorizontalAlignment", u50);
    u1:setBehaviour("Widget", "Visible", u50);
    u1:setBehaviour("Widget", "DesiredWidth", u50);
    u1:setBehaviour("Widget", "MinimumWidth", u50);
    u1:setBehaviour("Widget", "MinimumHeight", u50);
    u1:setBehaviour("Indicator", "Visible", u50);
    u1:setBehaviour("IconImageRatio", "AspectRatio", u50);
    u1:setBehaviour("IconImage", "Image", function(p56) --[[ Line: 371 ]]
        -- upvalues: u18 (copy), u50 (copy)
        local v57 = tonumber(p56) and "http://www.roblox.com/asset/?id=" .. p56 or (p56 or "");
        if u18.Image ~= v57 then
            u50();
        end;
        return v57;
    end);
    u1.alignmentChanged:Connect(function(p58) --[[ Line: 378 ]]
        -- upvalues: l__MenuUIListLayout__1 (copy), u3 (copy), u1 (copy), u7 (copy), u6 (copy), l__MenuGap__2 (copy), u50 (copy)
        l__MenuUIListLayout__1.HorizontalAlignment = Enum.HorizontalAlignment[p58 == "Center" and "Left" or p58];
        task.defer(function() --[[ Line: 350 ]]
            -- upvalues: u3 (ref), u1 (ref), u7 (ref), u6 (ref), l__MenuGap__2 (ref), l__MenuUIListLayout__1 (ref), u50 (ref)
            local v59 = u3:GetAttribute("BorderSize");
            local l__alignment__9 = u1.alignment;
            local v60;
            if u7.Visible == false then
                v60 = 0;
            elseif l__alignment__9 == "Right" then
                v60 = -v59 or v59;
            else
                v60 = v59;
            end;
            u6.Position = UDim2.new(0, v60, 0, 0);
            l__MenuGap__2.Size = UDim2.fromOffset(v59, 0);
            l__MenuUIListLayout__1.Padding = UDim.new(0, 0);
            u50();
        end);
    end);
    local u61 = Instance.new("NumberValue");
    u61.Name = "IconImageScale";
    u61.Parent = u18;
    u61:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 389 ]]
        -- upvalues: u18 (copy), u61 (copy)
        u18.Size = UDim2.new(u61.Value, 0, u61.Value, 0);
    end);
    local v62 = Instance.new("UIAspectRatioConstraint");
    v62.Name = "IconImageRatio";
    v62.AspectType = Enum.AspectType.FitWithinMaxSize;
    v62.DominantAxis = Enum.DominantAxis.Height;
    v62.Parent = u18;
    local v63 = Instance.new("UIGradient");
    v63.Name = "IconGradient";
    v63.Enabled = true;
    v63.Parent = u4;
    local v64 = Instance.new("UIGradient");
    v64.Name = "IconSpotGradient";
    v64.Enabled = true;
    v64.Parent = u7;
    return u3;
end;