-- Decompiled with Potassium's decompiler.

return function(u1) --[[ Line: 1 ]]
    local u2 = u1:getInstance("ClickRegion");
    local u3 = Instance.new("CanvasGroup");
    u3.Name = "Caption";
    u3.AnchorPoint = Vector2.new(0.5, 0);
    u3.BackgroundTransparency = 1;
    u3.BorderSizePixel = 0;
    u3.GroupTransparency = 1;
    u3.Position = UDim2.fromOffset(0, 0);
    u3.Visible = true;
    u3.ZIndex = 30;
    u3.Parent = u2;
    local u4 = Instance.new("Frame");
    u4.Name = "Box";
    u4.AutomaticSize = Enum.AutomaticSize.XY;
    u4.BackgroundColor3 = Color3.fromRGB(101, 102, 104);
    u4.Position = UDim2.fromOffset(4, 7);
    u4.ZIndex = 12;
    u4.Parent = u3;
    local v5 = Instance.new("TextLabel");
    v5.Name = "Header";
    v5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    v5.Text = "Caption";
    v5.TextColor3 = Color3.fromRGB(255, 255, 255);
    v5.TextSize = 14;
    v5.TextTruncate = Enum.TextTruncate.None;
    v5.TextWrapped = false;
    v5.TextXAlignment = Enum.TextXAlignment.Left;
    v5.AutomaticSize = Enum.AutomaticSize.X;
    v5.BackgroundTransparency = 1;
    v5.LayoutOrder = 1;
    v5.Size = UDim2.fromOffset(0, 16);
    v5.ZIndex = 18;
    v5.Parent = u4;
    local v6 = Instance.new("UIListLayout");
    v6.Name = "Layout";
    v6.Padding = UDim.new(0, 8);
    v6.SortOrder = Enum.SortOrder.LayoutOrder;
    v6.Parent = u4;
    local v7 = Instance.new("UICorner");
    v7.Name = "CaptionCorner";
    v7.Parent = u4;
    local v8 = Instance.new("UIPadding");
    v8.Name = "Padding";
    v8.PaddingBottom = UDim.new(0, 12);
    v8.PaddingLeft = UDim.new(0, 12);
    v8.PaddingRight = UDim.new(0, 12);
    v8.PaddingTop = UDim.new(0, 12);
    v8.Parent = u4;
    local u9 = Instance.new("Frame");
    u9.Name = "Hotkeys";
    u9.AutomaticSize = Enum.AutomaticSize.Y;
    u9.BackgroundTransparency = 1;
    u9.LayoutOrder = 3;
    u9.Size = UDim2.fromScale(1, 0);
    u9.Visible = false;
    u9.Parent = u4;
    local v10 = Instance.new("UIListLayout");
    v10.Name = "Layout1";
    v10.Padding = UDim.new(0, 6);
    v10.FillDirection = Enum.FillDirection.Vertical;
    v10.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v10.HorizontalFlex = Enum.UIFlexAlignment.None;
    v10.ItemLineAlignment = Enum.ItemLineAlignment.Automatic;
    v10.VerticalFlex = Enum.UIFlexAlignment.None;
    v10.SortOrder = Enum.SortOrder.LayoutOrder;
    v10.Parent = u9;
    local v11 = Instance.new("ImageLabel");
    v11.Name = "Key1";
    v11.Image = "rbxasset://textures/ui/Controls/key_single.png";
    v11.ImageTransparency = 0.7;
    v11.ScaleType = Enum.ScaleType.Slice;
    v11.SliceCenter = Rect.new(5, 5, 23, 24);
    v11.AutomaticSize = Enum.AutomaticSize.X;
    v11.BackgroundTransparency = 1;
    v11.LayoutOrder = 1;
    v11.Size = UDim2.fromOffset(0, 30);
    v11.ZIndex = 15;
    v11.Parent = u9;
    local v12 = Instance.new("UIPadding");
    v12.Name = "Inset";
    v12.PaddingLeft = UDim.new(0, 8);
    v12.PaddingRight = UDim.new(0, 8);
    v12.Parent = v11;
    local u13 = Instance.new("TextLabel");
    u13.AutoLocalize = false;
    u13.Name = "LabelContent";
    u13.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    u13.Text = "";
    u13.TextColor3 = Color3.fromRGB(189, 190, 190);
    u13.TextSize = 14;
    u13.AutomaticSize = Enum.AutomaticSize.X;
    u13.BackgroundTransparency = 1;
    u13.Position = UDim2.fromOffset(0, -1);
    u13.Size = UDim2.fromScale(1, 1);
    u13.ZIndex = 16;
    u13.Parent = v11;
    local u14 = Instance.new("ImageLabel");
    u14.Name = "Caret";
    u14.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png";
    u14.ImageColor3 = Color3.fromRGB(101, 102, 104);
    u14.ImageRectOffset = Vector2.new(260, 440);
    u14.ImageRectSize = Vector2.new(16, 8);
    u14.AnchorPoint = Vector2.new(0, 0.5);
    u14.BackgroundTransparency = 1;
    u14.Position = UDim2.new(0, 0, 0, 4);
    u14.Rotation = 180;
    u14.Size = UDim2.fromOffset(16, 8);
    u14.ZIndex = 12;
    u14.Parent = u3;
    local u15 = Instance.new("ImageLabel");
    u15.Name = "DropShadow";
    u15.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png";
    u15.ImageColor3 = Color3.fromRGB(0, 0, 0);
    u15.ImageRectOffset = Vector2.new(217, 486);
    u15.ImageRectSize = Vector2.new(25, 25);
    u15.ImageTransparency = 0.45;
    u15.ScaleType = Enum.ScaleType.Slice;
    u15.SliceCenter = Rect.new(12, 12, 13, 13);
    u15.BackgroundTransparency = 1;
    u15.Position = UDim2.fromOffset(0, 5);
    u15.Size = UDim2.new(1, 0, 0, 48);
    u15.Parent = u3;
    u4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 147 ]]
        -- upvalues: u15 (copy), u4 (copy)
        u15.Size = UDim2.new(1, 0, 0, u4.AbsoluteSize.Y + 8);
    end);
    local l__captionJanitor__1 = u1.captionJanitor;
    local _, u16 = u1:clipOutside(u3);
    u16.AutomaticSize = Enum.AutomaticSize.None;
    l__captionJanitor__1:add(u3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Name: matchSize, Line 157 ]]
        -- upvalues: u3 (copy), u16 (copy)
        local l__AbsoluteSize__2 = u3.AbsoluteSize;
        u16.Size = UDim2.fromOffset(l__AbsoluteSize__2.X, l__AbsoluteSize__2.Y);
    end));
    local l__AbsoluteSize__3 = u3.AbsoluteSize;
    u16.Size = UDim2.fromOffset(l__AbsoluteSize__3.X, l__AbsoluteSize__3.Y);
    local u17 = false;
    local l__Header__4 = u3.Box.Header;
    local l__UserInputService__5 = game:GetService("UserInputService");
    local function v21(p18) --[[ Line: 170 ]]
        -- upvalues: l__UserInputService__5 (copy), u3 (copy), u1 (copy), l__Header__4 (copy), u13 (copy), u9 (copy)
        local l__KeyboardEnabled__6 = l__UserInputService__5.KeyboardEnabled;
        local v19 = u3:GetAttribute("CaptionText") or "";
        local v20 = v19 == "_hotkey_";
        if l__KeyboardEnabled__6 or not v20 then
            l__Header__4.Text = v19;
            l__Header__4.Visible = not v20;
            if p18 then
                u13.Text = p18.Name;
                u9.Visible = true;
            end;
            if not l__KeyboardEnabled__6 then
                u9.Visible = false;
            end;
        else
            u1:setCaption();
        end;
    end;
    u3:GetAttributeChangedSignal("CaptionText"):Connect(v21);
    local l__Quad__7 = Enum.EasingStyle.Quad;
    local u22 = TweenInfo.new(0.2, l__Quad__7, Enum.EasingDirection.In);
    local u23 = TweenInfo.new(0.2, l__Quad__7, Enum.EasingDirection.Out);
    local l__TweenService__8 = game:GetService("TweenService");
    local l__RunService__9 = game:GetService("RunService");
    local function u35(p24) --[[ Line: 203 ]]
        -- upvalues: u17 (ref), u14 (copy), u3 (copy), u2 (copy), u16 (copy), u22 (copy), u23 (copy), l__TweenService__8 (copy), l__RunService__9 (copy)
        if u17 then
            if p24 == nil then
                p24 = u17;
            end;
            local v25 = not p24;
            if v25 == nil then
                v25 = u17;
            end;
            local v26 = UDim2.new(0.5, 0, 1, v25 and 10 or 2);
            local v27;
            if p24 == nil then
                v27 = u17;
            else
                v27 = p24;
            end;
            local v28 = UDim2.new(0.5, 0, 1, v27 and 10 or 2);
            if p24 then
                u14.Position = UDim2.fromOffset(0, u14.Position.Y.Offset);
                u3.AutomaticSize = Enum.AutomaticSize.XY;
                u3.Size = UDim2.fromOffset(32, 53);
            else
                local l__AbsoluteSize__10 = u3.AbsoluteSize;
                u3.AutomaticSize = Enum.AutomaticSize.Y;
                u3.Size = UDim2.fromOffset(l__AbsoluteSize__10.X, l__AbsoluteSize__10.Y);
            end;
            local u29 = nil;
            local function v32() --[[ Line: 232 ]]
                -- upvalues: u2 (ref), u3 (ref), u14 (ref), u29 (ref)
                local v30 = u2.AbsolutePosition.X - u3.AbsolutePosition.X + u2.AbsoluteSize.X / 2 - u14.AbsoluteSize.X / 2;
                local l__Offset__11 = u14.Position.Y.Offset;
                local v31 = UDim2.fromOffset(v30, l__Offset__11);
                if u29 ~= v30 then
                    u29 = v30;
                    u14.Position = UDim2.fromOffset(0, l__Offset__11);
                    task.wait();
                end;
                u14.Position = v31;
            end;
            u16.Position = v26;
            v32();
            local v33 = l__TweenService__8:Create(u16, p24 and u22 or u23, {
                Position = v28
            });
            local u34 = l__RunService__9.Heartbeat:Connect(v32);
            v33:Play();
            v33.Completed:Once(function() --[[ Line: 255 ]]
                -- upvalues: u34 (copy)
                u34:Disconnect();
            end);
        end;
    end;
    l__captionJanitor__1:add(u2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 260 ]]
        -- upvalues: u35 (copy)
        u35();
    end));
    u35(false);
    l__captionJanitor__1:add(u1.toggleKeyAdded:Connect(v21));
    for v36, _ in pairs(u1.bindedToggleKeys) do
        local l__KeyboardEnabled__12 = l__UserInputService__5.KeyboardEnabled;
        local v37 = u3:GetAttribute("CaptionText") or "";
        local v38 = v37 == "_hotkey_";
        if l__KeyboardEnabled__12 or not v38 then
            l__Header__4.Text = v37;
            l__Header__4.Visible = not v38;
            if v36 then
                u13.Text = v36.Name;
                u9.Visible = true;
            end;
            if not l__KeyboardEnabled__12 then
                u9.Visible = false;
            end;
        else
            u1:setCaption();
        end;
        break;
    end;
    l__captionJanitor__1:add(u1.fakeToggleKeyChanged:Connect(v21));
    local l__fakeToggleKey__13 = u1.fakeToggleKey;
    if l__fakeToggleKey__13 then
        local l__KeyboardEnabled__14 = l__UserInputService__5.KeyboardEnabled;
        local v39 = u3:GetAttribute("CaptionText") or "";
        local v40 = v39 == "_hotkey_";
        if l__KeyboardEnabled__14 or not v40 then
            l__Header__4.Text = v39;
            l__Header__4.Visible = not v40;
            if l__fakeToggleKey__13 then
                u13.Text = l__fakeToggleKey__13.Name;
                u9.Visible = true;
            end;
            if not l__KeyboardEnabled__14 then
                u9.Visible = false;
            end;
        else
            u1:setCaption();
        end;
    end;
    local function u44(p41) --[[ Line: 276 ]]
        -- upvalues: u17 (ref), u1 (copy), u22 (copy), u23 (copy), l__TweenService__8 (copy), u3 (copy), u35 (copy), l__UserInputService__5 (copy), l__Header__4 (copy), u9 (copy)
        if u17 == p41 then
        else
            local l__joinedFrame__15 = u1.joinedFrame;
            if l__joinedFrame__15 and string.match(l__joinedFrame__15.Name, "Dropdown") then
                p41 = false;
            end;
            u17 = p41;
            l__TweenService__8:Create(u3, p41 and u22 or u23, {
                GroupTransparency = p41 and 0 or 1
            }):Play();
            u35();
            local l__KeyboardEnabled__16 = l__UserInputService__5.KeyboardEnabled;
            local v42 = u3:GetAttribute("CaptionText") or "";
            local v43 = v42 == "_hotkey_";
            if l__KeyboardEnabled__16 or not v43 then
                l__Header__4.Text = v42;
                l__Header__4.Visible = not v43;
                if not l__KeyboardEnabled__16 then
                    u9.Visible = false;
                end;
            else
                u1:setCaption();
            end;
        end;
    end;
    local l__iconModule__17 = require(u1.iconModule);
    l__captionJanitor__1:add(u1.stateChanged:Connect(function(p45) --[[ Line: 298 ]]
        -- upvalues: l__iconModule__17 (copy), u1 (copy), u44 (copy)
        if p45 == "Viewing" then
            local l__captionLastClosedClock__18 = l__iconModule__17.captionLastClosedClock;
            local v46 = (l__captionLastClosedClock__18 and os.clock() - l__captionLastClosedClock__18 or 999) < 0.3 and 0 or 0.5;
            task.delay(v46, function() --[[ Line: 303 ]]
                -- upvalues: u1 (ref), u44 (ref)
                if u1.activeState == "Viewing" then
                    u44(true);
                end;
            end);
        else
            l__iconModule__17.captionLastClosedClock = os.clock();
            u44(false);
        end;
    end));
    return u3;
end;