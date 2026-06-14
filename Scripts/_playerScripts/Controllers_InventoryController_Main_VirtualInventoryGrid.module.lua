-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ScrollingFrame = p2.ScrollingFrame;
    v3.UIGridFrame = p2.UIGridFrame;
    v3.HiddenParent = p2.HiddenParent;
    v3.Slots = p2.Slots;
    v3.GetNumberOfHotbarSlots = p2.GetNumberOfHotbarSlots;
    v3.GetCurrentFilter = p2.GetCurrentFilter;
    v3.ToolMatchesFilter = p2.ToolMatchesFilter;
    v3.CellSize = p2.CellSize;
    v3.CellPadding = p2.CellPadding;
    v3.BufferRows = p2.BufferRows or 2;
    v3.IsFrozen = p2.IsFrozen;
    v3.OnShowSlot = p2.OnShowSlot;
    v3._dirtyList = true;
    v3._dirtyLayout = true;
    v3._scheduled = false;
    v3._visibleSlots = {};
    v3._rendered = {};
    v3._columns = 1;
    v3._rowHeight = v3.CellSize + v3.CellPadding;
    return v3;
end;
function u1.MarkListDirty(p4) --[[ Line: 30 ]]
    p4._dirtyList = true;
    p4:RequestRender();
end;
function u1.MarkLayoutDirty(p5) --[[ Line: 35 ]]
    p5._dirtyLayout = true;
    p5:RequestRender();
end;
function u1.SetSearchQuery(p6, p7) --[[ Line: 40 ]]
    local v8 = {};
    if type(p7) == "string" then
        for v9 in p7:gmatch("%S+") do
            v8[v9:lower()] = true;
        end;
    end;
    p6._searchTerms = next(v8) and v8 and v8 or nil;
    p6._dirtyList = true;
    p6:RequestRender();
end;
local function u15(p10) --[[ Line: 52 ]]
    local v11 = {};
    table.insert(v11, p10.Name or "");
    local l__ToolTip__1 = p10.ToolTip;
    if type(l__ToolTip__1) == "string" then
        table.insert(v11, l__ToolTip__1);
    end;
    local v12 = p10:GetAttributes();
    for _, v13 in pairs(v12) do
        if type(v13) == "string" or type(v13) == "number" then
            local v14 = tostring(v13);
            table.insert(v11, v14);
        end;
    end;
    return table.concat(v11, " "):lower();
end;
local function u21(p16, p17) --[[ Line: 68 ]]
    local v18 = 0;
    for v19 in pairs(p17) do
        local _, v20 = p16:gsub(v19, "");
        v18 = v18 + v20;
    end;
    return v18;
end;
function u1.RebuildVisibleSlots(p22) --[[ Line: 87 ]]
    -- upvalues: u15 (copy), u21 (copy)
    local l___searchTerms__2 = p22._searchTerms;
    local v23 = p22.GetNumberOfHotbarSlots() + 1;
    local v24 = p22.GetCurrentFilter();
    local v25 = {};
    for v26 = v23, #p22.Slots do
        local v27 = p22.Slots[v26];
        if v27 and (v27.Tool and p22.ToolMatchesFilter(v27.Tool, v24)) then
            if l___searchTerms__2 then
                local v28 = u21(u15(v27.Tool), l___searchTerms__2);
                if v28 > 0 then
                    table.insert(v25, {
                        slot = v27,
                        hits = v28,
                        order = v26
                    });
                end;
            else
                local l__Tool__3 = v27.Tool;
                local v29, v30;
                if l__Tool__3:GetAttribute("Fruit") ~= nil then
                    local v31 = l__Tool__3:GetAttribute("Mutation") ~= nil;
                    v29 = l__Tool__3:GetAttribute("SizeMultiplier") or 1;
                    v30 = v31 and 0 or 1;
                else
                    v30 = 2;
                    v29 = 0;
                end;
                table.insert(v25, {
                    slot = v27,
                    group = v30,
                    size = v29,
                    order = v26
                });
            end;
        end;
    end;
    if l___searchTerms__2 then
        table.sort(v25, function(p32, p33) --[[ Line: 110 ]]
            if p32.hits == p33.hits then
                return p32.order < p33.order;
            else
                return p32.hits > p33.hits;
            end;
        end);
    else
        table.sort(v25, function(p34, p35) --[[ Line: 117 ]]
            if p34.group == p35.group then
                if p34.size == p35.size then
                    return p34.order < p35.order;
                else
                    return p34.size > p35.size;
                end;
            else
                return p34.group < p35.group;
            end;
        end);
    end;
    local v36 = {};
    for _, v37 in v25 do
        table.insert(v36, v37.slot);
    end;
    p22._visibleSlots = v36;
end;
function u1._updateLayout(p38) --[[ Line: 135 ]]
    local v39 = math.floor(p38.ScrollingFrame.AbsoluteSize.X / (p38.CellSize + p38.CellPadding));
    p38._columns = v39 < 1 and 1 or v39;
    p38._rowHeight = p38.CellSize + p38.CellPadding;
end;
function u1._updateCanvas(p40) --[[ Line: 144 ]]
    local v41 = math.ceil(#p40._visibleSlots / p40._columns) * p40._rowHeight + p40.CellPadding;
    p40.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, v41);
end;
function u1._desiredRange(p42) --[[ Line: 151 ]]
    local v43 = #p42._visibleSlots;
    if v43 <= 0 then
        return 1, 0;
    end;
    local l__Y__4 = p42.ScrollingFrame.CanvasPosition.Y;
    local l__Y__5 = p42.ScrollingFrame.AbsoluteWindowSize.Y;
    local v44 = math.floor(l__Y__4 / p42._rowHeight);
    local v45 = math.floor((l__Y__4 + l__Y__5) / p42._rowHeight);
    local v46 = math.max(0, v44 - p42.BufferRows);
    local v47 = v45 + p42.BufferRows;
    local v48 = v46 * p42._columns + 1;
    local v49 = (v47 + 1) * p42._columns;
    local v50 = v48 < 1 and 1 or v48;
    if v43 < v49 then
        v49 = v43;
    end;
    return v50, v49;
end;
function u1._hideSlot(_, p51) --[[ Line: 174 ]]
    if p51 then
        p51 = p51.Frame;
    end;
    if p51 then
        p51.Visible = false;
    end;
end;
function u1._showSlot(p52, p53, p54) --[[ Line: 181 ]]
    if p53 then
        p53 = p53.Frame;
    end;
    if p53 then
        local v55 = p54 - 1;
        local v56 = v55 % p52._columns;
        local v57 = math.floor(v55 / p52._columns);
        p53.Visible = true;
        p53.Position = UDim2.new(0, v56 * p52._rowHeight, 0, v57 * p52._rowHeight);
        p53.Size = UDim2.new(0, p52.CellSize, 0, p52.CellSize);
        p53.LayoutOrder = p54;
    end;
end;
function u1.RenderNow(p58) --[[ Line: 197 ]]
    if p58.IsFrozen and p58.IsFrozen() then
        p58._scheduled = false;
    else
        if p58._dirtyList then
            p58._dirtyList = false;
            p58:RebuildVisibleSlots();
        end;
        if p58._dirtyLayout then
            p58._dirtyLayout = false;
            p58:_updateLayout();
        end;
        p58:_updateCanvas();
        local v59, v60 = p58:_desiredRange();
        local v61 = {};
        for v62 = v59, v60 do
            local v63 = p58._visibleSlots[v62];
            if v63 then
                v61[v63] = v62;
            end;
        end;
        for v64 in p58._rendered do
            if not v61[v64] then
                p58:_hideSlot(v64);
                p58._rendered[v64] = nil;
            end;
        end;
        for v65, v66 in v61 do
            local v67 = p58._rendered[v65];
            p58:_showSlot(v65, v66);
            p58._rendered[v65] = true;
            if not v67 and p58.OnShowSlot then
                p58.OnShowSlot(v65);
            end;
        end;
        p58._scheduled = false;
    end;
end;
function u1.RequestRender(u68) --[[ Line: 242 ]]
    if u68._scheduled then
    else
        u68._scheduled = true;
        task.defer(function() --[[ Line: 247 ]]
            -- upvalues: u68 (copy)
            u68:RenderNow();
        end);
    end;
end;
function u1.ClearAll(p69) --[[ Line: 252 ]]
    for v70 in p69._rendered do
        p69:_hideSlot(v70);
        p69._rendered[v70] = nil;
    end;
end;
return u1;