-- Decompiled with Potassium's decompiler.

local function u2(p1) --[[ Line: 107 ]]
    warn((`{tostring(p1)}\nStack Begin\n{debug.traceback(nil, 3)}Stack End`));
end;
local function u4(p3, ...) --[[ Line: 111 ]]
    -- upvalues: u2 (copy)
    return xpcall(p3, u2, ...);
end;
local function u12(p5, p6) --[[ Line: 122 ]]
    local v7 = #p5;
    local v8 = 1;
    local v9 = false;
    while v8 <= v7 do
        local v10 = v8 + (v7 - v8) // 2;
        local v11 = p5[v10].Pr - p6.Pr;
        if v11 > 0 then
            v7 = v10 - 1;
        elseif v11 < 0 then
            v8 = v10 + 1;
        else
            v8 = v10 + 1;
            v9 = true;
        end;
    end;
    return v9 and v8 and v8 or -v8;
end;
local function u20(p13, p14) --[[ Line: 149 ]]
    local v15 = #p13;
    local v16 = 1;
    local v17 = false;
    while v16 <= v15 do
        local v18 = v16 + (v15 - v16) // 2;
        local v19 = p13[v18].Pr - p14.Pr;
        if v19 > 0 then
            v15 = v18 - 1;
        elseif v19 < 0 then
            v16 = v18 + 1;
        else
            v15 = v18 - 1;
            v17 = true;
        end;
    end;
    return v17 and v16 and v16 or -v16;
end;
local function u25(p21, p22) --[[ Line: 188 ]]
    -- upvalues: u20 (copy)
    local v23 = u20(p21, p22);
    if v23 > 0 then
        for v24 = v23, #p21 do
            if p21[v24] == p22 then
                table.remove(p21, v24);
                return true;
            end;
        end;
    end;
    return false;
end;
local function u28(p26) --[[ Line: 209 ]]
    -- upvalues: u25 (copy)
    local l__Ow__1 = p26.Ow;
    if l__Ow__1 ~= nil then
        p26.Ow = nil;
        if not u25(l__Ow__1.Cs, p26) then
            warn("BindableConnectionDisconnect");
        end;
        for _, v27 in ipairs(p26.Wt) do
            task.spawn(v27);
        end;
        table.clear(p26.Wt);
    end;
end;
local v31 = table.freeze({
    IsConnected = function(p29) --[[ Name: Connection_IsConnected, Line 205 ]]
        return p29.Ow ~= nil;
    end,
    Disconnect = u28,
    GetPriority = function(p30) --[[ Name: Connection_GetPriority, Line 223 ]]
        return p30.Pr;
    end
});
local u32 = table.freeze({
    __index = v31
});
local v78 = table.freeze({
    Fire = function(p33, ...) --[[ Name: Bindable_Fire, Line 278 ]]
        local l__Cs__2 = p33.Cs;
        local v34 = 1;
        while v34 <= #l__Cs__2 do
            local v35 = l__Cs__2[v34];
            task.spawn(v35.Cb, ...);
            if l__Cs__2[v34] == v35 then
                v34 = v34 + 1;
            end;
        end;
    end,
    FireAndWait = function(p36, ...) --[[ Name: Bindable_FireAndWait, Line 292 ]]
        -- upvalues: u4 (copy)
        local l__Cs__3 = p36.Cs;
        if #l__Cs__3 == 0 then
        else
            local u37 = 1;
            local u38 = coroutine.running();
            local function v40(p39, ...) --[[ Line: 299 ]]
                -- upvalues: u4 (ref), u37 (ref), u38 (copy)
                u4(p39, ...);
                u37 = u37 - 1;
                if u37 == 0 then
                    task.spawn(u38);
                end;
            end;
            local v41 = u37;
            local v42 = 1;
            while v42 <= #l__Cs__3 do
                local v43 = l__Cs__3[v42];
                u37 = v41 + 1;
                task.spawn(v40, v43.Cb, ...);
                if l__Cs__3[v42] == v43 then
                    v42 = v42 + 1;
                end;
                v41 = u37;
            end;
            u37 = v41 - 1;
            if u37 > 0 then
                coroutine.yield();
            end;
        end;
    end,
    FireSync = function(p44, ...) --[[ Name: Bindable_FireSync, Line 321 ]]
        -- upvalues: u4 (copy)
        local l__Cs__4 = p44.Cs;
        local v45 = 1;
        while v45 <= #l__Cs__4 do
            local v46 = l__Cs__4[v45];
            u4(v46.Cb, ...);
            if l__Cs__4[v45] == v46 then
                v45 = v45 + 1;
            end;
        end;
    end,
    Invoke = function(p47, ...) --[[ Name: Bindable_Invoke, Line 333 ]]
        local l__Cs__5 = p47.Cs;
        if #l__Cs__5 >= 1 then
            return l__Cs__5[1].Cb(...);
        end;
        error("Invoke");
    end,
    Connect = function(p48, p49, p50) --[[ Name: Bindable_Connect, Line 261 ]]
        -- upvalues: u32 (copy), u12 (copy)
        local v51;
        if p50 == nil then
            v51 = true;
        elseif type(p50) == "number" then
            v51 = p50 == p50;
        else
            v51 = false;
        end;
        assert(v51);
        local v52 = p50 or (1 / 0);
        local v53 = setmetatable({
            Ow = p48,
            Cb = p49,
            Pr = v52,
            Wt = {}
        }, u32);
        if v52 == (1 / 0) then
            table.insert(p48.Cs, v53);
            return v53;
        end;
        local l__Cs__6 = p48.Cs;
        local v54 = u12(l__Cs__6, v53);
        local v55 = math.abs(v54);
        table.insert(l__Cs__6, v55, v53);
        return v53;
    end,
    Wait = function(p56) --[[ Name: Bindable_Wait, Line 344 ]]
        -- upvalues: u28 (copy), u32 (copy)
        local u57 = coroutine.running();
        local u58 = true;
        local u59 = nil;
        local function v61(...) --[[ Line: 348 ]]
            -- upvalues: u59 (ref), u57 (copy), u58 (ref), u28 (ref)
            local v60 = table.find(u59.Wt, u57);
            if v60 then
                table.remove(u59.Wt, v60);
            end;
            u58 = false;
            u28(u59);
            task.spawn(u57, ...);
        end;
        assert(true);
        local v62 = setmetatable({
            Pr = (1 / 0),
            Ow = p56,
            Cb = v61,
            Wt = {}
        }, u32);
        table.insert(p56.Cs, v62);
        u59 = v62;
        table.insert(u59.Wt, u57);
        local v63 = table.pack(coroutine.yield());
        if u58 then
            error("Disconnected");
        end;
        return table.unpack(v63);
    end,
    Once = function(p64, u65, p66) --[[ Name: Bindable_Once, Line 365 ]]
        -- upvalues: u28 (copy), u32 (copy), u12 (copy)
        local u67 = nil;
        local function v68(...) --[[ Line: 371 ]]
            -- upvalues: u28 (ref), u67 (ref), u65 (copy)
            u28(u67);
            return u65(...);
        end;
        local v69;
        if p66 == nil then
            v69 = true;
        elseif type(p66) == "number" then
            v69 = p66 == p66;
        else
            v69 = false;
        end;
        assert(v69);
        local v70 = p66 or (1 / 0);
        local v71 = setmetatable({
            Ow = p64,
            Cb = v68,
            Pr = v70,
            Wt = {}
        }, u32);
        if v70 == (1 / 0) then
            table.insert(p64.Cs, v71);
        else
            local l__Cs__7 = p64.Cs;
            local v72 = u12(l__Cs__7, v71);
            local v73 = math.abs(v72);
            table.insert(l__Cs__7, v73, v71);
        end;
        u67 = v71;
        return u67;
    end,
    DisconnectAll = function(p74) --[[ Name: Bindable_DisconnectAll, Line 378 ]]
        -- upvalues: u28 (copy)
        local l__Cs__8 = p74.Cs;
        for v75 = #l__Cs__8, 1, -1 do
            u28(l__Cs__8[v75]);
        end;
    end,
    GetSize = function(p76) --[[ Name: Bindable_GetSize, Line 385 ]]
        return #p76.Cs;
    end,
    IsEmpty = function(p77) --[[ Name: Bindable_IsEmpty, Line 389 ]]
        return #p77.Cs == 0;
    end
});
local u79 = table.freeze({
    __index = v78
});
return table.freeze({
    new = function(_) --[[ Name: new, Line 408 ]]
        -- upvalues: u79 (copy)
        return table.freeze((setmetatable({
            Cs = {}
        }, u79)));
    end,
    IsA = function(p80) --[[ Name: IsA, Line 421 ]]
        -- upvalues: u79 (copy)
        local v81;
        if type(p80) == "table" then
            v81 = getmetatable(p80) == u79;
        else
            v81 = false;
        end;
        return v81;
    end,
    Assert = function(p82) --[[ Name: Assert, Line 425 ]]
        -- upvalues: u79 (copy)
        local v83;
        if type(p82) == "table" then
            v83 = getmetatable(p82) == u79;
        else
            v83 = false;
        end;
        if not v83 then
            error("Bindable", 2);
        end;
        return p82;
    end,
    IsAConnection = function(p84) --[[ Name: Connection_IsA, Line 249 ]]
        -- upvalues: u32 (copy)
        local v85;
        if type(p84) == "table" then
            v85 = getmetatable(p84) == u32;
        else
            v85 = false;
        end;
        return v85;
    end,
    AssertConnection = function(p86) --[[ Name: Connection_Assert, Line 253 ]]
        -- upvalues: u32 (copy)
        local v87;
        if type(p86) == "table" then
            v87 = getmetatable(p86) == u32;
        else
            v87 = false;
        end;
        if not v87 then
            error("Connection", 2);
        end;
        return p86;
    end
});