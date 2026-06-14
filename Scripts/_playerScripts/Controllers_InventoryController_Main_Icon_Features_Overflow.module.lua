-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {};
local u4 = nil;
local l__CurrentCamera__1 = workspace.CurrentCamera;
local u5 = {};
local u6 = {};
local l__Utility__2 = require(script.Parent.Parent.Utility);
local u7 = nil;
function u1.start(p8) --[[ Line: 23 ]]
    -- upvalues: u7 (ref), u4 (ref), u2 (copy), l__Utility__2 (copy), u1 (copy), l__CurrentCamera__1 (copy)
    u7 = p8;
    u4 = u7.iconsDictionary;
    local v9 = nil;
    for _, v10 in pairs(u7.container) do
        if v9 == nil then
            if v10.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
                v9 = v10;
            end;
        end;
        for _, v11 in pairs(v10.Holders:GetChildren()) do
            if v11:GetAttribute("IsAHolder") then
                u2[v11.Name] = v11;
            end;
        end;
    end;
    local u12 = false;
    local u14 = l__Utility__2.createStagger(0.1, function(p13) --[[ Line: 41 ]]
        -- upvalues: u12 (ref), u1 (ref)
        if u12 then
            if not p13 then
                u1.updateAvailableIcons("Center");
            end;
            u1.updateBoundary("Left");
            u1.updateBoundary("Right");
        end;
    end);
    task.delay(1, function() --[[ Line: 51 ]]
        -- upvalues: u12 (ref), u14 (copy)
        u12 = true;
        u14();
    end);
    u7.iconAdded:Connect(u14);
    u7.iconRemoved:Connect(u14);
    u7.iconChanged:Connect(u14);
    l__CurrentCamera__1:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 61 ]]
        -- upvalues: u14 (copy)
        u14(true);
    end);
    v9:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 64 ]]
        -- upvalues: u14 (copy)
        u14(true);
    end);
end;
function u1.getWidth(p15, _) --[[ Line: 69 ]]
    local l__widget__3 = p15.widget;
    return l__widget__3:GetAttribute("TargetWidth") or l__widget__3.AbsoluteSize.X;
end;
function u1.getAvailableIcons(p16) --[[ Line: 74 ]]
    -- upvalues: u3 (copy), u1 (copy)
    return u3[p16] or u1.updateAvailableIcons(p16);
end;
function u1.updateAvailableIcons(p17) --[[ Line: 82 ]]
    -- upvalues: u2 (copy), u4 (ref), u6 (copy), u3 (copy)
    local _ = u2[p17].UIListLayout;
    local v18 = 0;
    local v19 = {};
    for _, v20 in pairs(u4) do
        local l__parentIconUID__4 = v20.parentIconUID;
        if (not l__parentIconUID__4 or u6[l__parentIconUID__4]) and (v20.alignment == p17 and not u6[v20.UID]) then
            table.insert(v19, v20);
            v18 = v18 + 1;
        end;
    end;
    if v18 <= 0 then
        return {};
    end;
    table.sort(v19, function(p21, p22) --[[ Line: 106 ]]
        local l__LayoutOrder__5 = p21.widget.LayoutOrder;
        local l__LayoutOrder__6 = p22.widget.LayoutOrder;
        local l__parentIconUID__7 = p21.parentIconUID;
        local l__parentIconUID__8 = p22.parentIconUID;
        if l__parentIconUID__7 == l__parentIconUID__8 then
            if l__LayoutOrder__5 < l__LayoutOrder__6 then
                return true;
            elseif l__LayoutOrder__6 < l__LayoutOrder__5 then
                return false;
            else
                return p21.widget.AbsolutePosition.X < p22.widget.AbsolutePosition.X;
            end;
        else
            if l__parentIconUID__8 then
                return false;
            end;
            if l__parentIconUID__7 then
                return true;
            end;
        end;
    end);
    u3[p17] = v19;
    return v19;
end;
function u1.getRealXPositions(p23, p24) --[[ Line: 132 ]]
    -- upvalues: u2 (copy), l__Utility__2 (copy), u1 (copy)
    local v25 = p23 == "Left";
    local v26 = u2[p23];
    local l__X__9 = v26.AbsolutePosition.X;
    local l__X__10 = v26.AbsoluteSize.X;
    local l__Offset__11 = v26.UIListLayout.Padding.Offset;
    local v27 = v25 and l__X__9 and l__X__9 or l__X__9 + l__X__10;
    local v28 = {};
    if v25 then
        l__Utility__2.reverseTable(p24);
    end;
    for v29 = #p24, 1, -1 do
        local v30 = p24[v29];
        local v31 = u1.getWidth(v30);
        if not v25 then
            v27 = v27 - v31;
        end;
        v28[v30.UID] = v27;
        if v25 then
            v27 = v27 + v31;
        end;
        v27 = v27 + (v25 and l__Offset__11 and l__Offset__11 or -l__Offset__11);
    end;
    return v28;
end;
function u1.updateBoundary(p32) --[[ Line: 162 ]]
    -- upvalues: u2 (copy), u1 (copy), u5 (copy), u7 (ref), u6 (copy), l__Utility__2 (copy)
    local v33 = u2[p32];
    local l__UIListLayout__12 = v33.UIListLayout;
    local l__X__13 = v33.AbsolutePosition.X;
    local l__X__14 = v33.AbsoluteSize.X;
    local l__Offset__15 = l__UIListLayout__12.Padding.Offset;
    local l__Offset__16 = l__UIListLayout__12.Padding.Offset;
    local v34 = u1.updateAvailableIcons(p32);
    local v35 = 0;
    local v36 = 0;
    for _, v37 in pairs(v34) do
        v35 = v35 + (u1.getWidth(v37) + l__Offset__16);
        v36 = v36 + 1;
    end;
    if v36 <= 0 then
    else
        local v38 = p32 == "Central";
        local v39 = p32 == "Left";
        local v40 = not v39;
        local v41 = u5[p32];
        if not v41 and (not v38 and #v34 > 0) then
            v41 = u7.new();
            v41:setImage(6069276526, "Deselected");
            v41:setName("Overflow" .. p32);
            v41:setOrder(v39 and -9999999 or 9999999);
            v41:setAlignment(p32);
            v41:autoDeselect(false);
            v41.isAnOverflow = true;
            v41:select("OverflowStart", v41);
            v41:setEnabled(false);
            u5[p32] = v41;
            u6[v41.UID] = true;
        end;
        local v42 = p32 == "Left" and "Right" or "Left";
        local v43 = u1.updateAvailableIcons(v42);
        local v44 = v39 and v43[1];
        if not v44 then
            if v40 then
                v44 = v43[#v43];
            else
                v44 = v40;
            end;
        end;
        local v45 = u5[v42];
        local v46;
        if v39 then
            v46 = l__X__13 + l__X__14 or l__X__13;
        else
            v46 = l__X__13;
        end;
        if v44 then
            local _ = v44.widget;
            local v47 = u1.getRealXPositions(v42, v43)[v44.UID];
            local v48 = u1.getWidth(v44);
            v46 = v39 and v47 - l__Offset__15 or v47 + v48 + l__Offset__15;
        end;
        local v49 = u1.getAvailableIcons("Center");
        local v50 = v49[v39 and 1 or #v49];
        if v50 and not v50.hasRelocatedInOverflow then
            local v51 = v39 and v34[#v34];
            if not v51 then
                if v40 then
                    v51 = v34[1];
                else
                    v51 = v40;
                end;
            end;
            local l__X__17 = v50.widget.AbsolutePosition.X;
            local l__X__18 = v51.widget.AbsolutePosition.X;
            local v52 = u1.getWidth(v51);
            local v53 = v39 and l__X__17 - l__Offset__15 or l__X__17 + u1.getWidth(v50) + l__Offset__15;
            if v39 then
                l__X__18 = l__X__18 + v52 or l__X__18;
            end;
            if v39 then
                if v53 < l__X__18 then
                    v50:align("Left");
                    v50.hasRelocatedInOverflow = true;
                end;
            elseif v40 and l__X__18 < v53 then
                v50:align("Right");
                v50.hasRelocatedInOverflow = true;
            end;
        end;
        if v41 then
            local v54 = v41:getInstance("Menu");
            local v55 = l__X__13 + l__X__14;
            if v54 and v45 then
                local l__X__19 = v45.widget.AbsolutePosition.X;
                local v56 = u1.getWidth(v45);
                local v57 = v39 and l__X__19 - l__Offset__15 or l__X__19 + v56 + l__Offset__15;
                local v58 = v45:getInstance("Menu");
                local v59 = v54.AbsoluteCanvasSize.X >= v58.AbsoluteCanvasSize.X;
                local v60 = l__X__13 + l__X__14 / 2;
                local v61 = v39 and v60 - l__Offset__15 / 2 or v60 + l__Offset__15 / 2;
                if v59 then
                    v61 = v57;
                end;
                l__X__14 = v39 and v61 - l__X__13 or v55 - v61;
            end;
            local v62;
            if v54 then
                v62 = v54:GetAttribute("MaxWidth");
            else
                v62 = v54;
            end;
            local v63 = l__Utility__2.round(l__X__14);
            if v54 and v62 ~= v63 then
                v54:SetAttribute("MaxWidth", v63);
            end;
        end;
        local v64 = u1.getRealXPositions(p32, v34);
        local v65 = false;
        for v66 = #v34, 1, -1 do
            local v67 = v34[v66];
            local v68 = u1.getWidth(v67);
            local v69 = v64[v67.UID];
            if v39 and v46 <= v69 + v68 or v40 and v69 <= v46 then
                v65 = true;
            end;
        end;
        for v70 = #v34, 1, -1 do
            local v71 = v34[v70];
            if not u6[v71.UID] then
                if v65 and not v71.parentIconUID then
                    v71:joinMenu(v41);
                elseif not v65 and v71.parentIconUID then
                    v71:leave();
                end;
            end;
        end;
        if v41.isEnabled ~= v65 then
            v41:setEnabled(v65);
        end;
        if v41.isEnabled and not v41.overflowAlreadyOpened then
            v41.overflowAlreadyOpened = true;
            v41:select();
        end;
    end;
end;
return u1;