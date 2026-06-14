-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
return function(u1) --[[ Line: 3 ]]
    local u2 = "Window";
    function u1.Window(p3, p4) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u2 (copy)
        return u1.Internal._Insert(u2, p3, p4);
    end;
    u1.SetFocusedWindow = u1.Internal.SetFocusedWindow;
    local u5 = "Tooltip";
    function u1.Tooltip(p6, p7) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u5 (copy)
        return u1.Internal._Insert(u5, p6, p7);
    end;
    local u8 = "MenuBar";
    function u1.MenuBar(p9, p10) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u8 (copy)
        return u1.Internal._Insert(u8, p9, p10);
    end;
    local u11 = "Menu";
    function u1.Menu(p12, p13) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u11 (copy)
        return u1.Internal._Insert(u11, p12, p13);
    end;
    local u14 = "MenuItem";
    function u1.MenuItem(p15, p16) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u14 (copy)
        return u1.Internal._Insert(u14, p15, p16);
    end;
    local u17 = "MenuToggle";
    function u1.MenuToggle(p18, p19) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u17 (copy)
        return u1.Internal._Insert(u17, p18, p19);
    end;
    local u20 = "Separator";
    function u1.Separator(p21, p22) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u20 (copy)
        return u1.Internal._Insert(u20, p21, p22);
    end;
    local u23 = "Indent";
    function u1.Indent(p24, p25) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u23 (copy)
        return u1.Internal._Insert(u23, p24, p25);
    end;
    local u26 = "SameLine";
    function u1.SameLine(p27, p28) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u26 (copy)
        return u1.Internal._Insert(u26, p27, p28);
    end;
    local u29 = "Group";
    function u1.Group(p30, p31) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u29 (copy)
        return u1.Internal._Insert(u29, p30, p31);
    end;
    local u32 = "Text";
    function u1.Text(p33, p34) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u32 (copy)
        return u1.Internal._Insert(u32, p33, p34);
    end;
    function u1.TextWrapped(p35) --[[ Line: 440 ]]
        -- upvalues: u1 (copy)
        p35[2] = true;
        return u1.Internal._Insert("Text", p35);
    end;
    function u1.TextColored(p36) --[[ Line: 465 ]]
        -- upvalues: u1 (copy)
        p36[3] = p36[2];
        p36[2] = nil;
        return u1.Internal._Insert("Text", p36);
    end;
    local u37 = "SeparatorText";
    function u1.SeparatorText(p38, p39) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u37 (copy)
        return u1.Internal._Insert(u37, p38, p39);
    end;
    local u40 = "InputText";
    function u1.InputText(p41, p42) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u40 (copy)
        return u1.Internal._Insert(u40, p41, p42);
    end;
    local u43 = "Button";
    function u1.Button(p44, p45) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u43 (copy)
        return u1.Internal._Insert(u43, p44, p45);
    end;
    local u46 = "SmallButton";
    function u1.SmallButton(p47, p48) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u46 (copy)
        return u1.Internal._Insert(u46, p47, p48);
    end;
    local u49 = "Checkbox";
    function u1.Checkbox(p50, p51) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u49 (copy)
        return u1.Internal._Insert(u49, p50, p51);
    end;
    local u52 = "RadioButton";
    function u1.RadioButton(p53, p54) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u52 (copy)
        return u1.Internal._Insert(u52, p53, p54);
    end;
    local u55 = "Image";
    function u1.Image(p56, p57) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u55 (copy)
        return u1.Internal._Insert(u55, p56, p57);
    end;
    local u58 = "ImageButton";
    function u1.ImageButton(p59, p60) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u58 (copy)
        return u1.Internal._Insert(u58, p59, p60);
    end;
    local u61 = "Tree";
    function u1.Tree(p62, p63) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u61 (copy)
        return u1.Internal._Insert(u61, p62, p63);
    end;
    local u64 = "CollapsingHeader";
    function u1.CollapsingHeader(p65, p66) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u64 (copy)
        return u1.Internal._Insert(u64, p65, p66);
    end;
    local u67 = "TabBar";
    function u1.TabBar(p68, p69) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u67 (copy)
        return u1.Internal._Insert(u67, p68, p69);
    end;
    local u70 = "Tab";
    function u1.Tab(p71, p72) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u70 (copy)
        return u1.Internal._Insert(u70, p71, p72);
    end;
    local u73 = "InputNum";
    function u1.InputNum(p74, p75) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u73 (copy)
        return u1.Internal._Insert(u73, p74, p75);
    end;
    local u76 = "InputVector2";
    function u1.InputVector2(p77, p78) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u76 (copy)
        return u1.Internal._Insert(u76, p77, p78);
    end;
    local u79 = "InputVector3";
    function u1.InputVector3(p80, p81) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u79 (copy)
        return u1.Internal._Insert(u79, p80, p81);
    end;
    local u82 = "InputUDim";
    function u1.InputUDim(p83, p84) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u82 (copy)
        return u1.Internal._Insert(u82, p83, p84);
    end;
    local u85 = "InputUDim2";
    function u1.InputUDim2(p86, p87) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u85 (copy)
        return u1.Internal._Insert(u85, p86, p87);
    end;
    local u88 = "InputRect";
    function u1.InputRect(p89, p90) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u88 (copy)
        return u1.Internal._Insert(u88, p89, p90);
    end;
    local u91 = "DragNum";
    function u1.DragNum(p92, p93) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u91 (copy)
        return u1.Internal._Insert(u91, p92, p93);
    end;
    local u94 = "DragVector2";
    function u1.DragVector2(p95, p96) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u94 (copy)
        return u1.Internal._Insert(u94, p95, p96);
    end;
    local u97 = "DragVector3";
    function u1.DragVector3(p98, p99) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u97 (copy)
        return u1.Internal._Insert(u97, p98, p99);
    end;
    local u100 = "DragUDim";
    function u1.DragUDim(p101, p102) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u100 (copy)
        return u1.Internal._Insert(u100, p101, p102);
    end;
    local u103 = "DragUDim2";
    function u1.DragUDim2(p104, p105) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u103 (copy)
        return u1.Internal._Insert(u103, p104, p105);
    end;
    local u106 = "DragRect";
    function u1.DragRect(p107, p108) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u106 (copy)
        return u1.Internal._Insert(u106, p107, p108);
    end;
    local u109 = "InputColor3";
    function u1.InputColor3(p110, p111) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u109 (copy)
        return u1.Internal._Insert(u109, p110, p111);
    end;
    local u112 = "InputColor4";
    function u1.InputColor4(p113, p114) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u112 (copy)
        return u1.Internal._Insert(u112, p113, p114);
    end;
    local u115 = "SliderNum";
    function u1.SliderNum(p116, p117) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u115 (copy)
        return u1.Internal._Insert(u115, p116, p117);
    end;
    local u118 = "SliderVector2";
    function u1.SliderVector2(p119, p120) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u118 (copy)
        return u1.Internal._Insert(u118, p119, p120);
    end;
    local u121 = "SliderVector3";
    function u1.SliderVector3(p122, p123) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u121 (copy)
        return u1.Internal._Insert(u121, p122, p123);
    end;
    local u124 = "SliderUDim";
    function u1.SliderUDim(p125, p126) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u124 (copy)
        return u1.Internal._Insert(u124, p125, p126);
    end;
    local u127 = "SliderUDim2";
    function u1.SliderUDim2(p128, p129) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u127 (copy)
        return u1.Internal._Insert(u127, p128, p129);
    end;
    local u130 = "SliderRect";
    function u1.SliderRect(p131, p132) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u130 (copy)
        return u1.Internal._Insert(u130, p131, p132);
    end;
    local u133 = "Selectable";
    function u1.Selectable(p134, p135) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u133 (copy)
        return u1.Internal._Insert(u133, p134, p135);
    end;
    local u136 = "Combo";
    function u1.Combo(p137, p138) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u136 (copy)
        return u1.Internal._Insert(u136, p137, p138);
    end;
    function u1.ComboArray(p139, p140, p141) --[[ Line: 1667 ]]
        -- upvalues: u1 (copy)
        if p140 == nil then
            p140 = u1.State(p141[1]);
        end;
        local v142 = u1.Internal._Insert("Combo", p139, p140);
        local l__index__1 = v142.state.index;
        for _, v143 in p141 do
            u1.Internal._Insert("Selectable", { v143, v143 }, {
                index = l__index__1
            });
        end;
        u1.End();
        return v142;
    end;
    function u1.ComboEnum(p144, p145, p146) --[[ Line: 1716 ]]
        -- upvalues: u1 (copy)
        if p145 == nil then
            p145 = u1.State(p146:GetEnumItems()[1]);
        end;
        local v147 = u1.Internal._Insert("Combo", p144, p145);
        local l__index__2 = v147.state.index;
        for _, v148 in p146:GetEnumItems() do
            u1.Internal._Insert("Selectable", { v148.Name, v148 }, {
                index = l__index__2
            });
        end;
        u1.End();
        return v147;
    end;
    u1.InputEnum = u1.ComboEnum;
    local u149 = "ProgressBar";
    function u1.ProgressBar(p150, p151) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u149 (copy)
        return u1.Internal._Insert(u149, p150, p151);
    end;
    local u152 = "PlotLines";
    function u1.PlotLines(p153, p154) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u152 (copy)
        return u1.Internal._Insert(u152, p153, p154);
    end;
    local u155 = "PlotHistogram";
    function u1.PlotHistogram(p156, p157) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u155 (copy)
        return u1.Internal._Insert(u155, p156, p157);
    end;
    local u158 = "Table";
    function u1.Table(p159, p160) --[[ Line: 6 ]]
        -- upvalues: u1 (copy), u158 (copy)
        return u1.Internal._Insert(u158, p159, p160);
    end;
    function u1.NextColumn() --[[ Line: 1973 ]]
        -- upvalues: u1 (copy)
        local v161 = u1.Internal._GetParentWidget();
        assert(v161 ~= nil, "Iris.NextColumn() can only called when directly within a table.");
        if v161._columnIndex == v161.arguments.NumColumns then
            v161._columnIndex = 1;
            v161._rowIndex = v161._rowIndex + 1;
        else
            v161._columnIndex = v161._columnIndex + 1;
        end;
        return v161._columnIndex;
    end;
    function u1.NextRow() --[[ Line: 1993 ]]
        -- upvalues: u1 (copy)
        local v162 = u1.Internal._GetParentWidget();
        assert(v162 ~= nil, "Iris.NextRow() can only called when directly within a table.");
        v162._columnIndex = 1;
        v162._rowIndex = v162._rowIndex + 1;
        return v162._rowIndex;
    end;
    function u1.SetColumnIndex(p163) --[[ Line: 2010 ]]
        -- upvalues: u1 (copy)
        local v164 = u1.Internal._GetParentWidget();
        assert(v164 ~= nil, "Iris.SetColumnIndex() can only called when directly within a table.");
        local v165;
        if p163 >= 1 then
            v165 = p163 <= v164.arguments.NumColumns;
        else
            v165 = false;
        end;
        local v166 = `The index must be between 1 and {v164.arguments.NumColumns}, inclusive.`;
        assert(v165, v166);
        v164._columnIndex = p163;
    end;
    function u1.SetRowIndex(p167) --[[ Line: 2024 ]]
        -- upvalues: u1 (copy)
        local v168 = u1.Internal._GetParentWidget();
        assert(v168 ~= nil, "Iris.SetRowIndex() can only called when directly within a table.");
        assert(p167 >= 1, "The index must be greater or equal to 1.");
        v168._rowIndex = p167;
    end;
    function u1.NextHeaderColumn() --[[ Line: 2038 ]]
        -- upvalues: u1 (copy)
        local v169 = u1.Internal._GetParentWidget();
        assert(v169 ~= nil, "Iris.NextHeaderColumn() can only called when directly within a table.");
        v169._rowIndex = 0;
        v169._columnIndex = v169._columnIndex % v169.arguments.NumColumns + 1;
        return v169._columnIndex;
    end;
    function u1.SetHeaderColumnIndex(p170) --[[ Line: 2057 ]]
        -- upvalues: u1 (copy)
        local v171 = u1.Internal._GetParentWidget();
        assert(v171 ~= nil, "Iris.SetHeaderColumnIndex() can only called when directly within a table.");
        local v172;
        if p170 >= 1 then
            v172 = p170 <= v171.arguments.NumColumns;
        else
            v172 = false;
        end;
        local v173 = `The index must be between 1 and {v171.arguments.NumColumns}, inclusive.`;
        assert(v172, v173);
        v171._rowIndex = 0;
        v171._columnIndex = p170;
    end;
    function u1.SetColumnWidth(p174, p175) --[[ Line: 2078 ]]
        -- upvalues: u1 (copy)
        local v176 = u1.Internal._GetParentWidget();
        assert(v176 ~= nil, "Iris.SetColumnWidth() can only called when directly within a table.");
        local v177;
        if p174 >= 1 then
            v177 = p174 <= v176.arguments.NumColumns;
        else
            v177 = false;
        end;
        local v178 = `The index must be between 1 and {v176.arguments.NumColumns}, inclusive.`;
        assert(v177, v178);
        local v179 = v176.state.widths.value[p174];
        v176.state.widths.value[p174] = p175;
        v176.state.widths:set(v176.state.widths.value, p175 ~= v179);
    end;
end;