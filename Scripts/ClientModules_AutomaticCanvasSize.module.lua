-- Decompiled with Potassium's decompiler.

local function u3(p1, p2) --[[ Line: 23 ]]
    return Vector2.new(p2.PaddingLeft.Offset + p2.PaddingRight.Offset, p2.PaddingTop.Offset + p2.PaddingBottom.Offset) + p1 * Vector2.new(p2.PaddingLeft.Scale + p2.PaddingRight.Scale, p2.PaddingTop.Scale + p2.PaddingBottom.Scale);
end;
local function u15(p4, p5) --[[ Line: 36 ]]
    -- upvalues: u3 (copy)
    local l__zero__1 = Vector2.zero;
    local l__zero__2 = Vector2.zero;
    local v6 = p4.AbsolutePosition + p4.CanvasPosition;
    local l__AbsoluteSize__3 = p4.AbsoluteSize;
    for _, v7 in p4:GetChildren() do
        if v7:IsA("GuiObject") and v7.Visible then
            local l__AbsoluteSize__4 = v7.AbsoluteSize;
            local v8 = v7:FindFirstChildOfClass("UIPadding");
            if v8 then
                l__AbsoluteSize__4 = l__AbsoluteSize__4 + u3(l__AbsoluteSize__4, v8);
            end;
            local v9 = v7.AbsolutePosition - v6;
            local v10 = v9 + l__AbsoluteSize__4;
            if p5 then
                l__zero__1 = l__zero__1:Min(v9);
            end;
            l__zero__2 = l__zero__2:Max(v10);
        end;
    end;
    local v11 = p4:FindFirstChildOfClass("UIListLayout");
    if v11 then
        l__zero__2 = l__zero__2:Max(v11.AbsoluteContentSize);
    end;
    local v12 = p4:FindFirstChildOfClass("UIGridLayout");
    if v12 then
        l__zero__2 = l__zero__2:Max(v12.AbsoluteContentSize);
    end;
    local v13 = l__zero__2 + l__zero__1:Abs();
    local v14 = p4:FindFirstChildWhichIsA("UIPadding");
    if v14 then
        v13 = v13 + u3(l__AbsoluteSize__3, v14);
    end;
    local l__ScrollingDirection__5 = p4.ScrollingDirection;
    if l__ScrollingDirection__5 == Enum.ScrollingDirection.X then
        v13 = v13 * Vector2.xAxis;
    elseif l__ScrollingDirection__5 == Enum.ScrollingDirection.Y then
        v13 = v13 * Vector2.yAxis;
    end;
    return UDim2.fromOffset(v13.X, v13.Y);
end;
local function u25(u16, p17) --[[ Line: 127 ]]
    -- upvalues: u15 (copy)
    if u16.Connections[p17] then
    else
        local v18 = {};
        if p17:IsA("GuiObject") then
            v18[#v18 + 1] = p17:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 134 ]]
                -- upvalues: u16 (copy), u15 (ref)
                local u19 = u16;
                if not u19.Destroyed then
                    if u19.Scheduled then
                        return;
                    end;
                    u19.Scheduled = true;
                    task.defer(function() --[[ Line: 110 ]]
                        -- upvalues: u19 (copy), u15 (ref)
                        u19.Scheduled = false;
                        local v20 = u19;
                        if v20.Destroyed then
                        else
                            v20.Frame.CanvasSize = u15(v20.Frame, v20.IncludeNegativeOffset);
                        end;
                    end);
                end;
            end);
            v18[#v18 + 1] = p17:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 137 ]]
                -- upvalues: u16 (copy), u15 (ref)
                local u21 = u16;
                if not u21.Destroyed then
                    if u21.Scheduled then
                        return;
                    end;
                    u21.Scheduled = true;
                    task.defer(function() --[[ Line: 110 ]]
                        -- upvalues: u21 (copy), u15 (ref)
                        u21.Scheduled = false;
                        local v22 = u21;
                        if v22.Destroyed then
                        else
                            v22.Frame.CanvasSize = u15(v22.Frame, v22.IncludeNegativeOffset);
                        end;
                    end);
                end;
            end);
        else
            if not p17:IsA("UILayout") then
                return;
            end;
            v18[#v18 + 1] = p17.Changed:Connect(function() --[[ Line: 141 ]]
                -- upvalues: u16 (copy), u15 (ref)
                local u23 = u16;
                if not u23.Destroyed then
                    if u23.Scheduled then
                        return;
                    end;
                    u23.Scheduled = true;
                    task.defer(function() --[[ Line: 110 ]]
                        -- upvalues: u23 (copy), u15 (ref)
                        u23.Scheduled = false;
                        local v24 = u23;
                        if v24.Destroyed then
                        else
                            v24.Frame.CanvasSize = u15(v24.Frame, v24.IncludeNegativeOffset);
                        end;
                    end);
                end;
            end);
        end;
        u16.Connections[p17] = v18;
    end;
end;
return function(p26, p27) --[[ Name: AutomaticCanvasSize, Line 161 ]]
    -- upvalues: u15 (copy), u25 (copy)
    local u28 = {
        Scheduled = false,
        Destroyed = false,
        Frame = p26
    };
    local v29;
    if p27 then
        v29 = p27.IncludeNegativeOffset == true;
    else
        v29 = false;
    end;
    u28.IncludeNegativeOffset = v29;
    u28.Connections = {};
    u28.Connections[p26] = { p26:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 172 ]]
            -- upvalues: u28 (copy), u15 (ref)
            local u30 = u28;
            if not u30.Destroyed then
                if u30.Scheduled then
                    return;
                end;
                u30.Scheduled = true;
                task.defer(function() --[[ Line: 110 ]]
                    -- upvalues: u30 (copy), u15 (ref)
                    u30.Scheduled = false;
                    local v31 = u30;
                    if v31.Destroyed then
                    else
                        v31.Frame.CanvasSize = u15(v31.Frame, v31.IncludeNegativeOffset);
                    end;
                end);
            end;
        end), p26.ChildAdded:Connect(function(p32) --[[ Line: 175 ]]
            -- upvalues: u25 (ref), u28 (copy), u15 (ref)
            u25(u28, p32);
            local u33 = u28;
            if not u33.Destroyed then
                if u33.Scheduled then
                    return;
                end;
                u33.Scheduled = true;
                task.defer(function() --[[ Line: 110 ]]
                    -- upvalues: u33 (copy), u15 (ref)
                    u33.Scheduled = false;
                    local v34 = u33;
                    if v34.Destroyed then
                    else
                        v34.Frame.CanvasSize = u15(v34.Frame, v34.IncludeNegativeOffset);
                    end;
                end);
            end;
        end), p26.ChildRemoved:Connect(function(p35) --[[ Line: 179 ]]
            -- upvalues: u28 (copy), u15 (ref)
            local v36 = u28;
            local v37 = v36.Connections[p35];
            if v37 then
                for _, v38 in v37 do
                    v38:Disconnect();
                end;
                v36.Connections[p35] = nil;
            end;
            local u39 = u28;
            if not u39.Destroyed then
                if u39.Scheduled then
                    return;
                end;
                u39.Scheduled = true;
                task.defer(function() --[[ Line: 110 ]]
                    -- upvalues: u39 (copy), u15 (ref)
                    u39.Scheduled = false;
                    local v40 = u39;
                    if v40.Destroyed then
                    else
                        v40.Frame.CanvasSize = u15(v40.Frame, v40.IncludeNegativeOffset);
                    end;
                end);
            end;
        end) };
    for _, v41 in p26:GetChildren() do
        u25(u28, v41);
    end;
    if not u28.Destroyed then
        u28.Frame.CanvasSize = u15(u28.Frame, u28.IncludeNegativeOffset);
    end;
    return function() --[[ Line: 191 ]]
        -- upvalues: u28 (copy)
        if u28.Destroyed then
        else
            u28.Destroyed = true;
            for v42 in u28.Connections do
                local v43 = u28;
                local v44 = v43.Connections[v42];
                if v44 then
                    for _, v45 in v44 do
                        v45:Disconnect();
                    end;
                    v43.Connections[v42] = nil;
                end;
            end;
        end;
    end;
end;