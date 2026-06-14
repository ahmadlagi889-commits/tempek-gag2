-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
return function(p1) --[[ Line: 5 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    local u2 = {
        SelectedItem = 0,
        Items = {},
        ItemOptions = {}
    };
    local l__Util__2 = p1.Util;
    local l__Autocomplete__3 = l__LocalPlayer__1:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete");
    local l__TextButton__4 = l__Autocomplete__3:WaitForChild("TextButton");
    local l__Title__5 = l__Autocomplete__3:WaitForChild("Title");
    local l__Description__6 = l__Autocomplete__3:WaitForChild("Description");
    local l__Entry__7 = l__Autocomplete__3.Parent:WaitForChild("Frame"):WaitForChild("Entry");
    l__TextButton__4.Parent = nil;
    local l__ScrollBarThickness__8 = l__Autocomplete__3.ScrollBarThickness;
    local function u7(p3, p4, p5, p6) --[[ Line: 24 ]]
        -- upvalues: l__Util__2 (copy)
        p3.Visible = p5 ~= nil;
        p4.Text = p5 or "";
        if p6 then
            p4.Size = UDim2.new(0, l__Util__2.GetTextSize(p5 or "", p4, Vector2.new(1000, 1000), 1, 0).X, p3.Size.Y.Scale, p3.Size.Y.Offset);
        end;
    end;
    local function u8() --[[ Line: 38 ]]
        -- upvalues: l__Autocomplete__3 (copy), l__Title__5 (copy)
        l__Autocomplete__3.Size = UDim2.new(0, math.max(l__Title__5.Field.TextBounds.X + l__Title__5.Field.Type.TextBounds.X, l__Autocomplete__3.Size.X.Offset), 0, (math.min(l__Autocomplete__3.UIListLayout.AbsoluteContentSize.Y, l__Autocomplete__3.Parent.AbsoluteSize.Y - l__Autocomplete__3.AbsolutePosition.Y - 10)));
    end;
    local function u11(p9) --[[ Line: 48 ]]
        -- upvalues: u7 (copy), l__Title__5 (copy), l__Description__6 (copy), l__Autocomplete__3 (copy), u8 (copy), l__ScrollBarThickness__8 (copy)
        u7(l__Title__5, l__Title__5.Field, p9.name, true);
        local l__Type__9 = l__Title__5.Field.Type;
        local l__Type__10 = l__Title__5.Field.Type;
        local l__type__11 = p9.type;
        if l__type__11 then
            l__type__11 = ": " .. p9.type:sub(1, 1):upper() .. p9.type:sub(2);
        end;
        l__Type__9.Visible = l__type__11 ~= nil;
        l__Type__10.Text = l__type__11 or "";
        local v10 = l__Description__6;
        local l__Label__12 = l__Description__6.Label;
        local l__description__13 = p9.description;
        v10.Visible = l__description__13 ~= nil;
        l__Label__12.Text = l__description__13 or "";
        l__Description__6.Label.TextColor3 = p9.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255);
        l__Description__6.Size = UDim2.new(1, 0, 0, 40);
        while not l__Description__6.Label.TextFits do
            l__Description__6.Size = l__Description__6.Size + UDim2.new(0, 0, 0, 2);
            if l__Description__6.Size.Y.Offset > 500 then
                break;
            end;
        end;
        task.wait();
        l__Autocomplete__3.UIListLayout:ApplyLayout();
        u8();
        l__Autocomplete__3.ScrollBarThickness = l__ScrollBarThickness__8;
    end;
    function u2.Show(p12, p13, p14) --[[ Line: 88 ]]
        -- upvalues: l__Autocomplete__3 (copy), l__TextButton__4 (copy), l__Entry__7 (copy), l__Util__2 (copy), u11 (copy)
        local v15 = p14 or {};
        for _, v16 in pairs(p12.Items) do
            if v16.gui then
                v16.gui:Destroy();
            end;
        end;
        p12.SelectedItem = 1;
        p12.Items = p13;
        p12.Prefix = v15.prefix or "";
        p12.LastItem = v15.isLast or false;
        p12.Command = v15.command;
        p12.Arg = v15.arg;
        p12.NumArgs = v15.numArgs;
        p12.IsPartial = v15.isPartial;
        l__Autocomplete__3.ScrollBarThickness = 0;
        local v17 = 200;
        for v18, v19 in pairs(p12.Items) do
            local v20 = v19[1];
            local v21 = v19[2];
            local v22 = l__TextButton__4:Clone();
            v22.Name = v20 .. v21;
            v22.BackgroundTransparency = v18 == p12.SelectedItem and 0.5 or 1;
            local v23, v24 = string.find(v21:lower(), v20:lower(), 1, true);
            v22.Typed.Text = string.rep(" ", v23 - 1) .. v20;
            v22.Suggest.Text = string.sub(v21, 0, v23 - 1) .. string.rep(" ", #v20) .. string.sub(v21, v24 + 1);
            v22.Parent = l__Autocomplete__3;
            v22.LayoutOrder = v18;
            local v25 = math.max(v22.Typed.TextBounds.X, v22.Suggest.TextBounds.X) + 20;
            if v17 < v25 then
                v17 = v25;
            end;
            v19.gui = v22;
        end;
        l__Autocomplete__3.UIListLayout:ApplyLayout();
        local l__Text__14 = l__Entry__7.TextBox.Text;
        local v26 = l__Util__2.SplitString(l__Text__14);
        if l__Text__14:sub(#l__Text__14, #l__Text__14) == " " and not v15.at then
            v26[#v26 + 1] = "e";
        end;
        table.remove(v26, #v26);
        local v27 = v15.at and v15.at or #table.concat(v26, " ") + 1;
        l__Autocomplete__3.Position = UDim2.new(0, l__Entry__7.TextBox.AbsolutePosition.X - 10 + v27 * 7, 0, l__Entry__7.TextBox.AbsolutePosition.Y + 30);
        l__Autocomplete__3.Size = UDim2.new(0, v17, 0, l__Autocomplete__3.UIListLayout.AbsoluteContentSize.Y);
        l__Autocomplete__3.Visible = true;
        local v28 = u11;
        if p12.Items[1] then
            v15 = p12.Items[1].options or v15;
        end;
        v28(v15);
    end;
    function u2.GetSelectedItem(_) --[[ Line: 161 ]]
        -- upvalues: l__Autocomplete__3 (copy), u2 (copy)
        if l__Autocomplete__3.Visible == false then
            return nil;
        else
            return u2.Items[u2.SelectedItem];
        end;
    end;
    function u2.Hide(_) --[[ Line: 170 ]]
        -- upvalues: l__Autocomplete__3 (copy)
        l__Autocomplete__3.Visible = false;
    end;
    function u2.IsVisible(_) --[[ Line: 175 ]]
        -- upvalues: l__Autocomplete__3 (copy)
        return l__Autocomplete__3.Visible;
    end;
    function u2.Select(p29, p30) --[[ Line: 180 ]]
        -- upvalues: l__Autocomplete__3 (copy), l__Title__5 (copy), l__Description__6 (copy), l__TextButton__4 (copy), u11 (copy)
        if l__Autocomplete__3.Visible then
            p29.SelectedItem = p29.SelectedItem + p30;
            if p29.SelectedItem > #p29.Items then
                p29.SelectedItem = 1;
            elseif p29.SelectedItem < 1 then
                p29.SelectedItem = #p29.Items;
            end;
            for v31, v32 in pairs(p29.Items) do
                v32.gui.BackgroundTransparency = v31 == p29.SelectedItem and 0.5 or 1;
            end;
            l__Autocomplete__3.CanvasPosition = Vector2.new(0, (math.max(0, l__Title__5.Size.Y.Offset + l__Description__6.Size.Y.Offset + p29.SelectedItem * l__TextButton__4.Size.Y.Offset - l__Autocomplete__3.Size.Y.Offset)));
            if p29.Items[p29.SelectedItem] and p29.Items[p29.SelectedItem].options then
                u11(p29.Items[p29.SelectedItem].options or {});
            end;
        end;
    end;
    l__Autocomplete__3.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(u8);
    return u2;
end;