-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("ProgressBar", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Format = 2
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p3) --[[ Line: 13 ]]
                return p3.Instance;
            end),
            changed = {
                Init = function(_) --[[ Line: 17 ]] end,
                Get = function(p4) --[[ Line: 18 ]]
                    -- upvalues: u1 (copy)
                    return p4.lastChangedTick == u1._cycleTick;
                end
            }
        },
        Generate = function(_) --[[ Name: Generate, Line 23 ]]
            -- upvalues: u1 (copy), u2 (copy)
            local v5 = Instance.new("Frame");
            v5.Name = "Iris_ProgressBar";
            v5.AutomaticSize = Enum.AutomaticSize.Y;
            v5.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v5.BackgroundTransparency = 1;
            u2.UIListLayout(v5, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v6 = Instance.new("Frame");
            v6.Name = "Bar";
            v6.AutomaticSize = Enum.AutomaticSize.Y;
            v6.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
            v6.BackgroundColor3 = u1._config.FrameBgColor;
            v6.BackgroundTransparency = u1._config.FrameBgTransparency;
            v6.BorderSizePixel = 0;
            v6.ClipsDescendants = true;
            u2.applyFrameStyle(v6, true);
            v6.Parent = v5;
            local v7 = Instance.new("TextLabel");
            v7.Name = "Progress";
            v7.AutomaticSize = Enum.AutomaticSize.Y;
            v7.Size = UDim2.new(UDim.new(0, 0), u1._config.ContentHeight);
            v7.BackgroundColor3 = u1._config.PlotHistogramColor;
            v7.BackgroundTransparency = u1._config.PlotHistogramTransparency;
            v7.BorderSizePixel = 0;
            u2.applyTextStyle(v7);
            u2.UIPadding(v7, u1._config.FramePadding);
            u2.UICorner(v7, u1._config.FrameRounding);
            v7.Text = "";
            v7.Parent = v6;
            local v8 = Instance.new("TextLabel");
            v8.Name = "Value";
            v8.AutomaticSize = Enum.AutomaticSize.XY;
            v8.Size = UDim2.new(UDim.new(0, 0), u1._config.ContentHeight);
            v8.BackgroundTransparency = 1;
            v8.BorderSizePixel = 0;
            v8.ZIndex = 1;
            u2.applyTextStyle(v8);
            u2.UIPadding(v8, u1._config.FramePadding);
            v8.Parent = v6;
            local v9 = Instance.new("TextLabel");
            v9.Name = "TextLabel";
            v9.AutomaticSize = Enum.AutomaticSize.XY;
            v9.AnchorPoint = Vector2.new(0, 0.5);
            v9.BackgroundTransparency = 1;
            v9.BorderSizePixel = 0;
            v9.LayoutOrder = 1;
            u2.applyTextStyle(v9);
            u2.UIPadding(v8, u1._config.FramePadding);
            v9.Parent = v5;
            return v5;
        end,
        GenerateState = function(p10) --[[ Name: GenerateState, Line 88 ]]
            -- upvalues: u1 (copy)
            if p10.state.progress == nil then
                p10.state.progress = u1._widgetState(p10, "Progress", 0);
            end;
        end,
        Update = function(p11) --[[ Name: Update, Line 93 ]]
            local l__Instance__1 = p11.Instance;
            local l__TextLabel__2 = l__Instance__1.TextLabel;
            local l__Value__3 = l__Instance__1.Bar.Value;
            if p11.arguments.Format ~= nil and typeof(p11.arguments.Format) == "string" then
                l__Value__3.Text = p11.arguments.Format;
            end;
            l__TextLabel__2.Text = p11.arguments.Text or "Progress Bar";
        end,
        UpdateState = function(p12) --[[ Name: UpdateState, Line 105 ]]
            -- upvalues: u1 (copy)
            local l__Bar__4 = p12.Instance.Bar;
            local l__Progress__5 = l__Bar__4.Progress;
            local l__Value__6 = l__Bar__4.Value;
            local v13 = math.clamp(p12.state.progress.value, 0, 1);
            if l__Value__6.AbsoluteSize.X > l__Bar__4.AbsoluteSize.X * (1 - v13) then
                l__Value__6.AnchorPoint = Vector2.xAxis;
                l__Value__6.Position = UDim2.fromScale(1, 0);
            else
                l__Value__6.AnchorPoint = Vector2.zero;
                l__Value__6.Position = UDim2.fromScale(v13, 0);
            end;
            l__Progress__5.Size = UDim2.new(UDim.new(v13, 0), l__Progress__5.Size.Height);
            if p12.arguments.Format == nil or typeof(p12.arguments.Format) ~= "string" then
                l__Value__6.Text = string.format("%d%%", v13 * 100);
            else
                l__Value__6.Text = p12.arguments.Format;
            end;
            p12.lastChangedTick = u1._cycleTick + 1;
        end,
        Discard = function(p14) --[[ Name: Discard, Line 130 ]]
            -- upvalues: u2 (copy)
            p14.Instance:Destroy();
            u2.discardState(p14);
        end
    });
    local function u22(p15, p16) --[[ Line: 158 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local l__Plot__7 = p15.Instance.Background.Plot;
        local v17 = u2.getMouseLocation();
        local v18 = math.ceil((v17.X - (l__Plot__7.AbsolutePosition - u2.GuiOffset).X) / l__Plot__7.AbsoluteSize.X * #p15.Lines);
        local v19 = p15.Lines[v18];
        if v19 then
            if v19 ~= p15.HoveredLine and (not p16 and p15.HoveredLine) then
                p15.HoveredLine.BackgroundColor3 = u1._config.PlotLinesColor;
                p15.HoveredLine.BackgroundTransparency = u1._config.PlotLinesTransparency;
                p15.HoveredLine = false;
                p15.state.hovered:set(nil);
            end;
            local v20 = p15.state.values.value[v18];
            local v21 = p15.state.values.value[v18 + 1];
            if v20 and v21 then
                if math.floor(v20) == v20 and math.floor(v21) == v21 then
                    p15.Tooltip.Text = ("%d: %d\n%d: %d"):format(v18, v20, v18 + 1, v21);
                else
                    p15.Tooltip.Text = ("%d: %.3f\n%d: %.3f"):format(v18, v20, v18 + 1, v21);
                end;
            end;
            p15.HoveredLine = v19;
            v19.BackgroundColor3 = u1._config.PlotLinesHoveredColor;
            v19.BackgroundTransparency = u1._config.PlotLinesHoveredTransparency;
            if p16 then
                p15.state.hovered.value = { v20, v21 };
                return;
            end;
            p15.state.hovered:set({ v20, v21 });
        end;
    end;
    u1.WidgetConstructor("PlotLines", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Height = 2,
            Min = 3,
            Max = 4,
            TextOverlay = 5
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p23) --[[ Line: 206 ]]
                return p23.Instance;
            end)
        },
        Generate = function(u24) --[[ Name: Generate, Line 210 ]]
            -- upvalues: u1 (copy), u2 (copy), u22 (copy)
            local v25 = Instance.new("Frame");
            v25.Name = "Iris_PlotLines";
            v25.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v25.BackgroundTransparency = 1;
            v25.BorderSizePixel = 0;
            u2.UIListLayout(v25, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v26 = Instance.new("Frame");
            v26.Name = "Background";
            v26.Size = UDim2.new(u1._config.ContentWidth, UDim.new(1, 0));
            v26.BackgroundColor3 = u1._config.FrameBgColor;
            v26.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.applyFrameStyle(v26);
            v26.Parent = v25;
            local v27 = Instance.new("Frame");
            v27.Name = "Plot";
            v27.Size = UDim2.fromScale(1, 1);
            v27.BackgroundTransparency = 1;
            v27.BorderSizePixel = 0;
            v27.ClipsDescendants = true;
            v27:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 235 ]]
                -- upvalues: u24 (copy), u1 (ref)
                u24.state.values.lastChangeTick = u1._cycleTick;
                u1._widgets.PlotLines.UpdateState(u24);
            end);
            local v28 = Instance.new("TextLabel");
            v28.Name = "OverlayText";
            v28.AutomaticSize = Enum.AutomaticSize.XY;
            v28.AnchorPoint = Vector2.new(0.5, 0);
            v28.Size = UDim2.fromOffset(0, 0);
            v28.Position = UDim2.fromScale(0.5, 0);
            v28.BackgroundTransparency = 1;
            v28.BorderSizePixel = 0;
            v28.ZIndex = 2;
            u2.applyTextStyle(v28);
            v28.Parent = v27;
            local v29 = Instance.new("TextLabel");
            v29.Name = "Iris_Tooltip";
            v29.AutomaticSize = Enum.AutomaticSize.XY;
            v29.Size = UDim2.fromOffset(0, 0);
            v29.BackgroundColor3 = u1._config.PopupBgColor;
            v29.BackgroundTransparency = u1._config.PopupBgTransparency;
            v29.BorderSizePixel = 0;
            v29.Visible = false;
            u2.applyTextStyle(v29);
            u2.UIStroke(v29, u1._config.PopupBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(v29, u1._config.WindowPadding);
            if u1._config.PopupRounding > 0 then
                u2.UICorner(v29, u1._config.PopupRounding);
            end;
            local l___rootInstance__8 = u1._rootInstance;
            if l___rootInstance__8 then
                l___rootInstance__8 = u1._rootInstance:FindFirstChild("PopupScreenGui");
            end;
            if l___rootInstance__8 then
                l___rootInstance__8 = l___rootInstance__8:FindFirstChild("TooltipContainer");
            end;
            v29.Parent = l___rootInstance__8;
            u24.Tooltip = v29;
            u2.applyMouseMoved(v27, function() --[[ Line: 275 ]]
                -- upvalues: u22 (ref), u24 (copy)
                u22(u24);
            end);
            u2.applyMouseLeave(v27, function() --[[ Line: 279 ]]
                -- upvalues: u24 (copy), u1 (ref)
                local v30 = u24;
                if v30.HoveredLine then
                    v30.HoveredLine.BackgroundColor3 = u1._config.PlotLinesColor;
                    v30.HoveredLine.BackgroundTransparency = u1._config.PlotLinesTransparency;
                    v30.HoveredLine = false;
                    v30.state.hovered:set(nil);
                end;
            end);
            v27.Parent = v26;
            u24.Lines = {};
            u24.HoveredLine = false;
            local v31 = Instance.new("TextLabel");
            v31.Name = "TextLabel";
            v31.AutomaticSize = Enum.AutomaticSize.XY;
            v31.Size = UDim2.fromOffset(0, 0);
            v31.BackgroundTransparency = 1;
            v31.BorderSizePixel = 0;
            v31.ZIndex = 3;
            v31.LayoutOrder = 3;
            u2.applyTextStyle(v31);
            v31.Parent = v25;
            return v25;
        end,
        GenerateState = function(p32) --[[ Name: GenerateState, Line 303 ]]
            -- upvalues: u1 (copy)
            if p32.state.values == nil then
                p32.state.values = u1._widgetState(p32, "values", { 0, 1 });
            end;
            if p32.state.hovered == nil then
                p32.state.hovered = u1._widgetState(p32, "hovered", nil);
            end;
        end,
        Update = function(p33) --[[ Name: Update, Line 311 ]]
            local l__Instance__9 = p33.Instance;
            local l__TextLabel__10 = l__Instance__9.TextLabel;
            local l__OverlayText__11 = l__Instance__9.Background.Plot.OverlayText;
            l__TextLabel__10.Text = p33.arguments.Text or "Plot Lines";
            l__OverlayText__11.Text = p33.arguments.TextOverlay or "";
            l__Instance__9.Size = UDim2.new(1, 0, 0, p33.arguments.Height or 0);
        end,
        UpdateState = function(p34) --[[ Name: UpdateState, Line 322 ]]
            -- upvalues: u1 (copy), u22 (copy)
            if p34.state.hovered.lastChangeTick == u1._cycleTick then
                if p34.state.hovered.value then
                    p34.Tooltip.Visible = true;
                else
                    p34.Tooltip.Visible = false;
                end;
            end;
            if p34.state.values.lastChangeTick == u1._cycleTick then
                local l__Plot__12 = p34.Instance.Background.Plot;
                local l__value__13 = p34.state.values.value;
                local v35 = #l__value__13 - 1;
                local v36 = #p34.Lines;
                local v37 = p34.arguments.Min or (1 / 0);
                local v38 = p34.arguments.Max or (-1 / 0);
                if v37 == nil or v38 == nil then
                    for _, v39 in l__value__13 do
                        v37 = math.min(v37, v39);
                        v38 = math.max(v38, v39);
                    end;
                end;
                if v36 < v35 then
                    for v40 = v36 + 1, v35 do
                        local l__Lines__14 = p34.Lines;
                        local v41 = Instance.new("Frame");
                        v41.Name = tostring(v40);
                        v41.AnchorPoint = Vector2.new(0.5, 0.5);
                        v41.BackgroundColor3 = u1._config.PlotLinesColor;
                        v41.BackgroundTransparency = u1._config.PlotLinesTransparency;
                        v41.BorderSizePixel = 0;
                        v41.Parent = l__Plot__12;
                        table.insert(l__Lines__14, v41);
                    end;
                elseif v35 < v36 then
                    for _ = v35 + 1, v36 do
                        local v42 = table.remove(p34.Lines);
                        if v42 then
                            v42:Destroy();
                        end;
                    end;
                end;
                local v43 = v38 - v37;
                local l__AbsoluteSize__15 = l__Plot__12.AbsoluteSize;
                for v44 = 1, v35 do
                    local v45 = l__value__13[v44];
                    local v46 = l__value__13[v44 + 1];
                    local v47 = l__AbsoluteSize__15 * Vector2.new((v44 - 1) / v35, (v38 - v45) / v43);
                    local v48 = l__AbsoluteSize__15 * Vector2.new(v44 / v35, (v38 - v46) / v43);
                    local v49 = (v47 + v48) / 2;
                    p34.Lines[v44].Size = UDim2.fromOffset((v48 - v47).Magnitude + 1, 1);
                    p34.Lines[v44].Position = UDim2.fromOffset(v49.X, v49.Y);
                    p34.Lines[v44].Rotation = math.atan2(v48.Y - v47.Y, v48.X - v47.X) * 57.29577951308232;
                end;
                if p34.HoveredLine then
                    u22(p34, true);
                end;
            end;
        end,
        Discard = function(p50) --[[ Name: Discard, Line 385 ]]
            -- upvalues: u2 (copy)
            p50.Instance:Destroy();
            p50.Tooltip:Destroy();
            u2.discardState(p50);
        end
    });
    local function u58(p51, p52) --[[ Line: 413 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local l__Plot__16 = p51.Instance.Background.Plot;
        local v53 = u2.getMouseLocation();
        local v54 = math.ceil((v53.X - (l__Plot__16.AbsolutePosition - u2.GuiOffset).X) / l__Plot__16.AbsoluteSize.X * #p51.Blocks);
        local v55 = p51.Blocks[v54];
        if v55 then
            if v55 ~= p51.HoveredBlock and (not p52 and p51.HoveredBlock) then
                p51.HoveredBlock.BackgroundColor3 = u1._config.PlotHistogramColor;
                p51.HoveredBlock.BackgroundTransparency = u1._config.PlotHistogramTransparency;
                p51.HoveredBlock = false;
                p51.state.hovered:set(nil);
            end;
            local v56 = p51.state.values.value[v54];
            if v56 then
                local l__Tooltip__17 = p51.Tooltip;
                local v57;
                if math.floor(v56) == v56 then
                    v57 = ("%d: %d"):format(v54, v56);
                else
                    v57 = ("%d: %.3f"):format(v54, v56);
                end;
                l__Tooltip__17.Text = v57;
            end;
            p51.HoveredBlock = v55;
            v55.BackgroundColor3 = u1._config.PlotHistogramHoveredColor;
            v55.BackgroundTransparency = u1._config.PlotHistogramHoveredTransparency;
            if p52 then
                p51.state.hovered.value = v56;
                return;
            end;
            p51.state.hovered:set(v56);
        end;
    end;
    u1.WidgetConstructor("PlotHistogram", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Height = 2,
            Min = 3,
            Max = 4,
            TextOverlay = 5,
            BaseLine = 6
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p59) --[[ Line: 457 ]]
                return p59.Instance;
            end)
        },
        Generate = function(u60) --[[ Name: Generate, Line 461 ]]
            -- upvalues: u1 (copy), u2 (copy), u58 (copy)
            local v61 = Instance.new("Frame");
            v61.Name = "Iris_PlotHistogram";
            v61.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            v61.BackgroundTransparency = 1;
            v61.BorderSizePixel = 0;
            u2.UIListLayout(v61, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v62 = Instance.new("Frame");
            v62.Name = "Background";
            v62.Size = UDim2.new(u1._config.ContentWidth, UDim.new(1, 0));
            v62.BackgroundColor3 = u1._config.FrameBgColor;
            v62.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.applyFrameStyle(v62);
            v62.UIPadding.PaddingRight = UDim.new(0, u1._config.FramePadding.X - 1);
            v62.Parent = v61;
            local v63 = Instance.new("Frame");
            v63.Name = "Plot";
            v63.Size = UDim2.fromScale(1, 1);
            v63.BackgroundTransparency = 1;
            v63.BorderSizePixel = 0;
            v63.ClipsDescendants = true;
            local v64 = Instance.new("TextLabel");
            v64.Name = "OverlayText";
            v64.AutomaticSize = Enum.AutomaticSize.XY;
            v64.AnchorPoint = Vector2.new(0.5, 0);
            v64.Size = UDim2.fromOffset(0, 0);
            v64.Position = UDim2.fromScale(0.5, 0);
            v64.BackgroundTransparency = 1;
            v64.BorderSizePixel = 0;
            v64.ZIndex = 2;
            u2.applyTextStyle(v64);
            v64.Parent = v63;
            local v65 = Instance.new("TextLabel");
            v65.Name = "Iris_Tooltip";
            v65.AutomaticSize = Enum.AutomaticSize.XY;
            v65.Size = UDim2.fromOffset(0, 0);
            v65.BackgroundColor3 = u1._config.PopupBgColor;
            v65.BackgroundTransparency = u1._config.PopupBgTransparency;
            v65.BorderSizePixel = 0;
            v65.Visible = false;
            u2.applyTextStyle(v65);
            u2.UIStroke(v65, u1._config.PopupBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(v65, u1._config.WindowPadding);
            if u1._config.PopupRounding > 0 then
                u2.UICorner(v65, u1._config.PopupRounding);
            end;
            local l___rootInstance__18 = u1._rootInstance;
            if l___rootInstance__18 then
                l___rootInstance__18 = u1._rootInstance:FindFirstChild("PopupScreenGui");
            end;
            if l___rootInstance__18 then
                l___rootInstance__18 = l___rootInstance__18:FindFirstChild("TooltipContainer");
            end;
            v65.Parent = l___rootInstance__18;
            u60.Tooltip = v65;
            u2.applyMouseMoved(v63, function() --[[ Line: 524 ]]
                -- upvalues: u58 (ref), u60 (copy)
                u58(u60);
            end);
            u2.applyMouseLeave(v63, function() --[[ Line: 528 ]]
                -- upvalues: u60 (copy), u1 (ref)
                local v66 = u60;
                if v66.HoveredBlock then
                    v66.HoveredBlock.BackgroundColor3 = u1._config.PlotHistogramColor;
                    v66.HoveredBlock.BackgroundTransparency = u1._config.PlotHistogramTransparency;
                    v66.HoveredBlock = false;
                    v66.state.hovered:set(nil);
                end;
            end);
            v63.Parent = v62;
            u60.Blocks = {};
            u60.HoveredBlock = false;
            local v67 = Instance.new("TextLabel");
            v67.Name = "TextLabel";
            v67.AutomaticSize = Enum.AutomaticSize.XY;
            v67.Size = UDim2.fromOffset(0, 0);
            v67.BackgroundTransparency = 1;
            v67.BorderSizePixel = 0;
            v67.ZIndex = 3;
            v67.LayoutOrder = 3;
            u2.applyTextStyle(v67);
            v67.Parent = v61;
            return v61;
        end,
        GenerateState = function(p68) --[[ Name: GenerateState, Line 552 ]]
            -- upvalues: u1 (copy)
            if p68.state.values == nil then
                p68.state.values = u1._widgetState(p68, "values", { 1 });
            end;
            if p68.state.hovered == nil then
                p68.state.hovered = u1._widgetState(p68, "hovered", nil);
            end;
        end,
        Update = function(p69) --[[ Name: Update, Line 560 ]]
            local l__Instance__19 = p69.Instance;
            local l__TextLabel__20 = l__Instance__19.TextLabel;
            local l__OverlayText__21 = l__Instance__19.Background.Plot.OverlayText;
            l__TextLabel__20.Text = p69.arguments.Text or "Plot Histogram";
            l__OverlayText__21.Text = p69.arguments.TextOverlay or "";
            l__Instance__19.Size = UDim2.new(1, 0, 0, p69.arguments.Height or 0);
        end,
        UpdateState = function(p70) --[[ Name: UpdateState, Line 571 ]]
            -- upvalues: u1 (copy), u58 (copy)
            if p70.state.hovered.lastChangeTick == u1._cycleTick then
                if p70.state.hovered.value then
                    p70.Tooltip.Visible = true;
                else
                    p70.Tooltip.Visible = false;
                end;
            end;
            if p70.state.values.lastChangeTick == u1._cycleTick then
                local l__Plot__22 = p70.Instance.Background.Plot;
                local l__value__23 = p70.state.values.value;
                local v71 = #l__value__23;
                local v72 = #p70.Blocks;
                local v73 = p70.arguments.Min or (1 / 0);
                local v74 = p70.arguments.Max or (-1 / 0);
                local v75 = p70.arguments.BaseLine or 0;
                if v73 == nil or v74 == nil then
                    for _, v76 in l__value__23 do
                        v73 = math.min(v73 or v76, v76);
                        v74 = math.max(v74 or v76, v76);
                    end;
                end;
                if v72 < v71 then
                    for v77 = v72 + 1, v71 do
                        local l__Blocks__24 = p70.Blocks;
                        local v78 = Instance.new("Frame");
                        v78.Name = tostring(v77);
                        v78.BackgroundColor3 = u1._config.PlotHistogramColor;
                        v78.BackgroundTransparency = u1._config.PlotHistogramTransparency;
                        v78.BorderSizePixel = 0;
                        v78.Parent = l__Plot__22;
                        table.insert(l__Blocks__24, v78);
                    end;
                elseif v71 < v72 then
                    for _ = v71 + 1, v72 do
                        local v79 = table.remove(p70.Blocks);
                        if v79 then
                            v79:Destroy();
                        end;
                    end;
                end;
                local v80 = v74 - v73;
                local v81 = UDim.new(1 / v71, -1);
                for v82 = 1, v71 do
                    local v83 = l__value__23[v82];
                    if v83 >= 0 then
                        p70.Blocks[v82].Size = UDim2.new(v81, UDim.new((v83 - v75) / v80));
                        p70.Blocks[v82].Position = UDim2.fromScale((v82 - 1) / v71, (v74 - v83) / v80);
                    else
                        p70.Blocks[v82].Size = UDim2.new(v81, UDim.new((v75 - v83) / v80));
                        p70.Blocks[v82].Position = UDim2.fromScale((v82 - 1) / v71, (v74 - v75) / v80);
                    end;
                end;
                if p70.HoveredBlock then
                    u58(p70, true);
                end;
            end;
        end,
        Discard = function(p84) --[[ Name: Discard, Line 633 ]]
            -- upvalues: u2 (copy)
            p84.Instance:Destroy();
            p84.Tooltip:Destroy();
            u2.discardState(p84);
        end
    });
end;