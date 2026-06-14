-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);
return function(u1, u2) --[[ Line: 32 ]]
    local u3 = {};
    local u4 = {};
    local u5 = false;
    local u6 = nil;
    local u7 = 0;
    local u8 = -1;
    local u9 = -1;
    local u10 = 0;
    local function u16(p11, p12) --[[ Line: 42 ]]
        -- upvalues: u1 (copy)
        local v13 = 0;
        for _, v14 in p11._cellInstances do
            for _, v15 in v14[p12]:GetChildren() do
                if v15:IsA("GuiObject") then
                    v13 = math.max(v13, v15.AbsoluteSize.X);
                end;
            end;
        end;
        p11._minWidths[p12] = v13 + 2 * u1._config.CellPadding.X;
    end;
    table.insert(u1._postCycleCallbacks, function() --[[ Line: 56 ]]
        -- upvalues: u3 (copy), u1 (copy), u4 (copy), u16 (copy)
        for _, v17 in u3 do
            for v18, v19 in v17._rowCycles do
                if v19 < u1._cycleTick - 1 then
                    local v20 = v17._rowInstances[v18];
                    local v21 = v17._rowBorders[v18 - 1];
                    if v20 ~= nil then
                        v20:Destroy();
                    end;
                    if v21 ~= nil then
                        v21:Destroy();
                    end;
                    v17._rowInstances[v18] = nil;
                    v17._rowBorders[v18 - 1] = nil;
                    v17._cellInstances[v18] = nil;
                    v17._rowCycles[v18] = nil;
                end;
            end;
            v17._rowIndex = 1;
            v17._columnIndex = 1;
            v17.Instance.BorderContainer.Size = UDim2.new(1, 0, 0, v17._rowContainer.AbsoluteSize.Y);
            v17._columnBorders[0].Size = UDim2.fromOffset(5, v17._rowContainer.AbsoluteSize.Y);
        end;
        for v22, v23 in u4 do
            local v24 = false;
            for v25, _ in v23 do
                u16(v22, v25);
                v24 = true;
            end;
            if v24 then
                table.clear(v23);
                u1._widgets.Table.UpdateState(v22);
            end;
        end;
    end);
    local function u37() --[[ Line: 98 ]]
        -- upvalues: u5 (ref), u6 (ref), u1 (copy), u8 (ref), u7 (ref), u9 (ref), u2 (copy), u10 (ref)
        if u5 == false or u6 == nil then
        else
            local l__widths__1 = u6.state.widths;
            local l__NumColumns__2 = u6.arguments.NumColumns;
            local l__Instance__3 = u6.Instance;
            local l__BorderContainer__4 = l__Instance__3.BorderContainer;
            local l__FixedWidth__5 = u6.arguments.FixedWidth;
            local v26 = 2 * u1._config.CellPadding.X;
            if u8 == -1 then
                u8 = l__widths__1.value[u7];
                if u8 == 0 then
                    u8 = v26 / l__Instance__3.AbsoluteSize.X;
                end;
                u9 = l__widths__1.value[u7 + 1] or -1;
                if u9 == 0 then
                    u9 = v26 / l__Instance__3.AbsoluteSize.X;
                end;
            end;
            local l__X__6 = l__Instance__3.AbsolutePosition.X;
            local v27;
            if u7 == 1 then
                v27 = 0;
            else
                local v28 = l__BorderContainer__4:FindFirstChild((`Border_{u7 - 1}`)).AbsolutePosition.X + 3 - l__X__6;
                v27 = math.floor(v28);
            end;
            local v29;
            if u7 >= l__NumColumns__2 - 1 then
                v29 = l__Instance__3.AbsoluteSize.X;
            else
                local v30 = l__BorderContainer__4:FindFirstChild((`Border_{u7 + 1}`)).AbsolutePosition.X + 3 - l__X__6;
                v29 = math.floor(v30);
            end;
            local v31 = l__X__6 - u2.GuiOffset.X;
            local l__X__7 = u2.getMouseLocation().X;
            local v32 = math.clamp(l__X__7, v27 + v31 + v26, v29 + v31 - v26) - u10;
            local v33 = u8 / (u10 - v31 - v27);
            if l__FixedWidth__5 then
                local l__value__8 = l__widths__1.value;
                local v34 = u7;
                local v35 = math.round(u8 + v32);
                l__value__8[v34] = math.clamp(v35, v26, l__Instance__3.AbsoluteSize.X - v27);
            else
                local v36 = v33 * v32;
                l__widths__1.value[u7] = math.clamp(u8 + v36, 0, (v29 - v27 - v26) / l__Instance__3.AbsoluteSize.X);
                if u7 < l__NumColumns__2 then
                    l__widths__1.value[u7 + 1] = math.clamp(u9 - v36, 0, 1);
                end;
            end;
            l__widths__1:set(l__widths__1.value, true);
        end;
    end;
    u2.registerEvent("InputChanged", function() --[[ Line: 163 ]]
        -- upvalues: u1 (copy), u37 (copy)
        if u1._started then
            u37();
        end;
    end);
    u2.registerEvent("InputEnded", function(p38) --[[ Line: 170 ]]
        -- upvalues: u1 (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
        if u1._started then
            if p38.UserInputType == Enum.UserInputType.MouseButton1 and u5 then
                u5 = false;
                u6 = nil;
                u7 = 0;
                u8 = -1;
                u9 = -1;
                u10 = 0;
            end;
        end;
    end);
    local function u43(_, p39, p40, p41) --[[ Line: 184 ]]
        -- upvalues: u2 (copy), u1 (copy)
        local v42;
        if p41 then
            v42 = Instance.new("TextButton");
            v42.Text = "";
            v42.AutoButtonColor = false;
        else
            v42 = Instance.new("Frame");
        end;
        v42.Name = `Cell_{p39}`;
        v42.AutomaticSize = Enum.AutomaticSize.Y;
        v42.Size = UDim2.new(p40, UDim.new());
        v42.BackgroundTransparency = 1;
        v42.ZIndex = p39;
        v42.LayoutOrder = p39;
        v42.ClipsDescendants = true;
        if p41 then
            u2.applyInteractionHighlights("Background", v42, v42, {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderActiveColor,
                ActiveTransparency = u1._config.HeaderActiveTransparency
            });
        end;
        u2.UIPadding(v42, u1._config.CellPadding);
        u2.UIListLayout(v42, Enum.FillDirection.Vertical, UDim.new());
        u2.UISizeConstraint(v42, Vector2.new(2 * u1._config.CellPadding.X, 0));
        return v42;
    end;
    local function u53(u44, u45, p46) --[[ Line: 219 ]]
        -- upvalues: u1 (copy), u2 (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
        local v47 = Instance.new("ImageButton");
        v47.Name = `Border_{u45}`;
        v47.Size = UDim2.new(0, 5, 1, 0);
        v47.BackgroundTransparency = 1;
        v47.Image = "";
        v47.ImageTransparency = 1;
        v47.AutoButtonColor = false;
        v47.ZIndex = u45;
        v47.LayoutOrder = u45 * 2;
        local v48 = u45 == u44.arguments.NumColumns and 3 or 2;
        local v49 = Instance.new("Frame");
        v49.Name = "Line";
        v49.Size = UDim2.new(0, 1, 1, 0);
        v49.Position = UDim2.fromOffset(v48, 0);
        v49.BackgroundColor3 = u1._config[`TableBorder{p46}Color`];
        v49.BackgroundTransparency = u1._config[`TableBorder{p46}Transparency`];
        v49.BorderSizePixel = 0;
        v49.Parent = v47;
        local v50 = Instance.new("Frame");
        v50.Name = "Hover";
        v50.Position = UDim2.fromOffset(v48, 0);
        v50.Size = UDim2.new(0, 1, 1, 0);
        v50.BackgroundColor3 = u1._config[`TableBorder{p46}Color`];
        v50.BackgroundTransparency = u1._config[`TableBorder{p46}Transparency`];
        v50.BorderSizePixel = 0;
        v50.Visible = u44.arguments.Resizable;
        v50.Parent = v47;
        u2.applyInteractionHighlights("Background", v47, v50, {
            Transparency = 1,
            Color = u1._config.ResizeGripColor,
            HoveredColor = u1._config.ResizeGripHoveredColor,
            HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
            ActiveColor = u1._config.ResizeGripActiveColor,
            ActiveTransparency = u1._config.ResizeGripActiveTransparency
        });
        u2.applyButtonDown(v47, function() --[[ Line: 263 ]]
            -- upvalues: u44 (copy), u45 (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u2 (ref)
            if u44.arguments.Resizable then
                local v51 = u44;
                local v52 = u45;
                u5 = true;
                u6 = v51;
                u7 = v52;
                u8 = -1;
                u9 = -1;
                u10 = u2.getMouseLocation().X;
            end;
        end);
        return v47;
    end;
    local function u59(p54, p55) --[[ Line: 273 ]]
        -- upvalues: u1 (copy), u2 (copy), u43 (copy)
        local v56 = Instance.new("Frame");
        v56.Name = `Row_{p55}`;
        v56.AutomaticSize = Enum.AutomaticSize.Y;
        v56.Size = UDim2.fromScale(1, 0);
        if p55 == 0 then
            v56.BackgroundColor3 = u1._config.TableHeaderColor;
            v56.BackgroundTransparency = u1._config.TableHeaderTransparency;
        elseif p54.arguments.RowBackground == true then
            if p55 % 2 == 0 then
                v56.BackgroundColor3 = u1._config.TableRowBgAltColor;
                v56.BackgroundTransparency = u1._config.TableRowBgAltTransparency;
            else
                v56.BackgroundColor3 = u1._config.TableRowBgColor;
                v56.BackgroundTransparency = u1._config.TableRowBgTransparency;
            end;
        else
            v56.BackgroundTransparency = 1;
        end;
        v56.BorderSizePixel = 0;
        v56.ZIndex = p55 * 2 - 1;
        v56.LayoutOrder = p55 * 2 - 1;
        v56.ClipsDescendants = true;
        u2.UIListLayout(v56, Enum.FillDirection.Horizontal, UDim.new());
        p54._cellInstances[p55] = table.create(p54.arguments.NumColumns);
        for v57 = 1, p54.arguments.NumColumns do
            local v58 = u43(p54, v57, p54._widths[v57], p55 == 0);
            v58.Parent = v56;
            p54._cellInstances[p55][v57] = v58;
        end;
        p54._rowInstances[p55] = v56;
        return v56;
    end;
    local function u64(_, p60, p61) --[[ Line: 311 ]]
        -- upvalues: u1 (copy)
        local v62 = Instance.new("Frame");
        v62.Name = `Border_{p60}`;
        v62.Size = UDim2.fromScale(1, 0);
        v62.BackgroundTransparency = 1;
        v62.ZIndex = p60 * 2;
        v62.LayoutOrder = p60 * 2;
        local v63 = Instance.new("Frame");
        v63.Name = "Line";
        v63.AnchorPoint = Vector2.new(0, 0.5);
        v63.Size = UDim2.new(1, 0, 0, 1);
        v63.BackgroundColor3 = u1._config[`TableBorder{p61}Color`];
        v63.BackgroundTransparency = u1._config[`TableBorder{p61}Transparency`];
        v63.BorderSizePixel = 0;
        v63.Parent = v62;
        return v62;
    end;
    u1.WidgetConstructor("Table", {
        hasState = true,
        hasChildren = true,
        Args = {
            NumColumns = 1,
            Header = 2,
            RowBackground = 3,
            OuterBorders = 4,
            InnerBorders = 5,
            Resizable = 6,
            FixedWidth = 7,
            ProportionalWidth = 8,
            LimitTableWidth = 9
        },
        Events = {},
        Generate = function(u65) --[[ Name: Generate, Line 348 ]]
            -- upvalues: u3 (copy), u4 (copy), u2 (copy), u1 (copy)
            u3[u65.ID] = u65;
            u4[u65] = {};
            local v66 = Instance.new("Frame");
            v66.Name = "Iris_Table";
            v66.AutomaticSize = Enum.AutomaticSize.Y;
            v66.Size = UDim2.fromScale(1, 0);
            v66.BackgroundTransparency = 1;
            local v67 = Instance.new("Frame");
            v67.Name = "RowContainer";
            v67.AutomaticSize = Enum.AutomaticSize.Y;
            v67.Size = UDim2.fromScale(1, 0);
            v67.BackgroundTransparency = 1;
            v67.ZIndex = 1;
            u2.UISizeConstraint(v67);
            u2.UIListLayout(v67, Enum.FillDirection.Vertical, UDim.new());
            v67.Parent = v66;
            u65._rowContainer = v67;
            local v68 = Instance.new("Frame");
            v68.Name = "BorderContainer";
            v68.Size = UDim2.fromScale(1, 1);
            v68.BackgroundTransparency = 1;
            v68.ZIndex = 2;
            v68.ClipsDescendants = true;
            u2.UISizeConstraint(v68);
            u2.UIListLayout(v68, Enum.FillDirection.Horizontal, UDim.new());
            u2.UIStroke(v68, 1, u1._config.TableBorderStrongColor, u1._config.TableBorderStrongTransparency);
            v68.Parent = v66;
            u65._columnIndex = 1;
            u65._rowIndex = 1;
            u65._rowInstances = {};
            u65._cellInstances = {};
            u65._rowBorders = {};
            u65._columnBorders = {};
            u65._rowCycles = {};
            local u69 = #u1._postCycleCallbacks + 1;
            local u70 = u1._cycleTick + 1;
            u1._postCycleCallbacks[u69] = function() --[[ Line: 394 ]]
                -- upvalues: u1 (ref), u70 (copy), u65 (copy), u69 (copy)
                if u70 <= u1._cycleTick then
                    if u65.lastCycleTick ~= -1 then
                        u65.state.widths.lastChangeTick = u1._cycleTick;
                        u1._widgets.Table.UpdateState(u65);
                    end;
                    u1._postCycleCallbacks[u69] = nil;
                end;
            end;
            return v66;
        end,
        GenerateState = function(p71) --[[ Name: GenerateState, Line 406 ]]
            -- upvalues: u1 (copy), u53 (copy), u43 (copy)
            local l__NumColumns__9 = p71.arguments.NumColumns;
            if p71.state.widths == nil then
                local v72 = table.create(l__NumColumns__9, 1 / l__NumColumns__9);
                p71.state.widths = u1._widgetState(p71, "widths", v72);
            end;
            p71._widths = table.create(l__NumColumns__9, UDim.new());
            p71._minWidths = table.create(l__NumColumns__9, 0);
            local l__Instance__10 = p71.Instance;
            local l__BorderContainer__11 = l__Instance__10.BorderContainer;
            p71._cellInstances[-1] = table.create(l__NumColumns__9);
            for v73 = 1, l__NumColumns__9 do
                local v74 = u53(p71, v73, "Light");
                v74.Visible = p71.arguments.InnerBorders;
                p71._columnBorders[v73] = v74;
                v74.Parent = l__BorderContainer__11;
                local v75 = u43(p71, v73, p71._widths[v73], false);
                v75:FindFirstChild("UISizeConstraint").MinSize = Vector2.new(2 * u1._config.CellPadding.X + (v73 > 1 and -2 or 0) + (v73 < l__NumColumns__9 and -3 or 0), 0);
                v75.LayoutOrder = v73 * 2 - 1;
                p71._cellInstances[-1][v73] = v75;
                v75.Parent = l__BorderContainer__11;
            end;
            local v76 = u53(p71, l__NumColumns__9, "Strong");
            p71._columnBorders[0] = v76;
            v76.Parent = l__Instance__10;
        end,
        Update = function(p77) --[[ Name: Update, Line 440 ]]
            -- upvalues: u1 (copy), u4 (copy)
            local l__NumColumns__12 = p77.arguments.NumColumns;
            assert(l__NumColumns__12 >= 1, "Iris.Table must have at least one column.");
            if p77._widths ~= nil and #p77._widths ~= l__NumColumns__12 then
                p77.arguments.NumColumns = #p77._widths;
                warn("NumColumns cannot change once set. See documentation.");
            end;
            for v78, v79 in p77._rowInstances do
                if v78 == 0 then
                    v79.BackgroundColor3 = u1._config.TableHeaderColor;
                    v79.BackgroundTransparency = u1._config.TableHeaderTransparency;
                elseif p77.arguments.RowBackground == true then
                    if v78 % 2 == 0 then
                        v79.BackgroundColor3 = u1._config.TableRowBgAltColor;
                        v79.BackgroundTransparency = u1._config.TableRowBgAltTransparency;
                    else
                        v79.BackgroundColor3 = u1._config.TableRowBgColor;
                        v79.BackgroundTransparency = u1._config.TableRowBgTransparency;
                    end;
                else
                    v79.BackgroundTransparency = 1;
                end;
            end;
            for _, v80 in p77._rowBorders do
                v80.Visible = p77.arguments.InnerBorders;
            end;
            for _, v81 in p77._columnBorders do
                v81.Visible = p77.arguments.InnerBorders or p77.arguments.Resizable;
            end;
            for _, v82 in p77._columnBorders do
                local v83 = v82:FindFirstChild("Hover");
                if v83 then
                    v83.Visible = p77.arguments.Resizable;
                end;
            end;
            if p77._columnBorders[l__NumColumns__12] ~= nil then
                local v84 = p77._columnBorders[l__NumColumns__12];
                local v85 = not p77.arguments.LimitTableWidth;
                if v85 then
                    v85 = p77.arguments.Resizable or p77.arguments.InnerBorders;
                end;
                v84.Visible = v85;
                local v86 = p77._columnBorders[0];
                local l__LimitTableWidth__13 = p77.arguments.LimitTableWidth;
                if l__LimitTableWidth__13 then
                    l__LimitTableWidth__13 = p77.arguments.Resizable or p77.arguments.OuterBorders;
                end;
                v86.Visible = l__LimitTableWidth__13;
            end;
            local v87 = p77._rowInstances[0];
            local v88 = p77._rowBorders[0];
            if v87 ~= nil then
                v87.Visible = p77.arguments.Header;
            end;
            if v88 ~= nil then
                local l__Header__14 = p77.arguments.Header;
                if l__Header__14 then
                    l__Header__14 = p77.arguments.InnerBorders;
                end;
                v88.Visible = l__Header__14;
            end;
            p77.Instance.BorderContainer.UIStroke.Enabled = p77.arguments.OuterBorders;
            for v89 = 1, p77.arguments.NumColumns do
                u4[p77][v89] = true;
            end;
            if p77._widths ~= nil then
                u1._widgets.Table.UpdateState(p77);
            end;
        end,
        UpdateState = function(p90) --[[ Name: UpdateState, Line 512 ]]
            local l__Instance__15 = p90.Instance;
            local l__BorderContainer__16 = l__Instance__15.BorderContainer;
            local l__RowContainer__17 = l__Instance__15.RowContainer;
            local l__NumColumns__18 = p90.arguments.NumColumns;
            local l__value__19 = p90.state.widths.value;
            local l___minWidths__20 = p90._minWidths;
            local l__FixedWidth__21 = p90.arguments.FixedWidth;
            local l__ProportionalWidth__22 = p90.arguments.ProportionalWidth;
            if not p90.arguments.Resizable then
                if l__FixedWidth__21 then
                    if l__ProportionalWidth__22 then
                        for v91 = 1, l__NumColumns__18 do
                            l__value__19[v91] = l___minWidths__20[v91];
                        end;
                    else
                        local v92 = 0;
                        for _, v93 in l___minWidths__20 do
                            v92 = math.max(v92, v93);
                        end;
                        for v94 = 1, l__NumColumns__18 do
                            l__value__19[v94] = v92;
                        end;
                    end;
                elseif l__ProportionalWidth__22 then
                    local v95 = 0;
                    for _, v96 in l___minWidths__20 do
                        v95 = v95 + v96;
                    end;
                    local v97 = 1 / v95;
                    for v98 = 1, l__NumColumns__18 do
                        l__value__19[v98] = v97 * l___minWidths__20[v98];
                    end;
                else
                    local v99 = 1 / l__NumColumns__18;
                    for v100 = 1, l__NumColumns__18 do
                        l__value__19[v100] = v99;
                    end;
                end;
            end;
            local v101 = UDim.new();
            for v102 = 1, l__NumColumns__18 do
                local v103 = l__value__19[v102];
                local v104 = UDim.new(l__FixedWidth__21 and 0 or math.clamp(v103, 0, 1), not l__FixedWidth__21 and 0 or math.max(v103, 0));
                p90._widths[v102] = v104;
                v101 = v101 + v104;
                for _, v105 in p90._cellInstances do
                    v105[v102].Size = UDim2.new(v104, UDim.new());
                end;
                p90._cellInstances[-1][v102].Size = UDim2.new(v104 + UDim.new(0, (v102 > 1 and -2 or 0) - 3), UDim.new());
            end;
            local v106 = not (p90.arguments.FixedWidth and p90.arguments.LimitTableWidth) and (1 / 0) or v101.Offset;
            l__BorderContainer__16.UISizeConstraint.MaxSize = Vector2.new(v106, (1 / 0));
            l__RowContainer__17.UISizeConstraint.MaxSize = Vector2.new(v106, (1 / 0));
            p90._columnBorders[0].Position = UDim2.fromOffset(v106 - 3, 0);
        end,
        ChildAdded = function(p107, _) --[[ Name: ChildAdded, Line 587 ]]
            -- upvalues: u1 (copy), u4 (copy), u59 (copy), u64 (copy)
            local l___rowIndex__23 = p107._rowIndex;
            local l___columnIndex__24 = p107._columnIndex;
            local v108 = p107._rowInstances[l___rowIndex__23];
            p107._rowCycles[l___rowIndex__23] = u1._cycleTick;
            u4[p107][l___columnIndex__24] = true;
            if v108 ~= nil then
                return p107._cellInstances[l___rowIndex__23][l___columnIndex__24];
            end;
            local v109 = u59(p107, l___rowIndex__23);
            if l___rowIndex__23 == 0 then
                v109.Visible = p107.arguments.Header;
            end;
            v109.Parent = p107._rowContainer;
            if l___rowIndex__23 > 0 then
                local v110 = u64(p107, l___rowIndex__23 - 1, l___rowIndex__23 == 1 and "Strong" or "Light");
                local l__InnerBorders__25 = p107.arguments.InnerBorders;
                if l__InnerBorders__25 then
                    if l___rowIndex__23 == 1 then
                        l__InnerBorders__25 = p107.arguments.Header and p107.arguments.InnerBorders;
                        if l__InnerBorders__25 then
                            l__InnerBorders__25 = p107._rowInstances[0] ~= nil;
                        end;
                    else
                        l__InnerBorders__25 = true;
                    end;
                end;
                v110.Visible = l__InnerBorders__25;
                p107._rowBorders[l___rowIndex__23 - 1] = v110;
                v110.Parent = p107._rowContainer;
            end;
            return p107._cellInstances[l___rowIndex__23][l___columnIndex__24];
        end,
        ChildDiscarded = function(p111, p112) --[[ Name: ChildDiscarded, Line 614 ]]
            -- upvalues: u4 (copy)
            local l__Parent__26 = p112.Instance.Parent;
            local v113 = l__Parent__26 ~= nil and tonumber(l__Parent__26.Name:sub(6));
            if v113 then
                u4[p111][v113] = true;
            end;
        end,
        Discard = function(p114) --[[ Name: Discard, Line 625 ]]
            -- upvalues: u3 (copy), u4 (copy), u2 (copy)
            u3[p114.ID] = nil;
            u4[p114] = nil;
            p114.Instance:Destroy();
            u2.discardState(p114);
        end
    });
end;