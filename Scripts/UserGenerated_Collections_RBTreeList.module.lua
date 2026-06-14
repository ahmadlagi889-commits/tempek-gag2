-- Decompiled with Potassium's decompiler.

local function u9(p1) --[[ Line: 161 ]]
    local l__Right1__1 = p1.Right1;
    local v2;
    if l__Right1__1 then
        v2 = l__Right1__1.Color1;
    else
        v2 = false;
    end;
    local v3;
    if v2 then
        v3 = p1.Right1;
        p1.Right1 = v3.Left1;
        v3.Left1 = p1;
        v3.Color1 = p1.Color1;
        p1.Color1 = true;
    else
        v3 = p1;
    end;
    local l__Left1__2 = v3.Left1;
    local v4;
    if l__Left1__2 then
        v4 = l__Left1__2.Color1;
    else
        v4 = false;
    end;
    local v5;
    if v4 then
        local l__Left1__3 = v3.Left1.Left1;
        local v6;
        if l__Left1__3 then
            v6 = l__Left1__3.Color1;
        else
            v6 = false;
        end;
        if v6 then
            v5 = v3.Left1;
            v3.Left1 = v5.Right1;
            v5.Right1 = v3;
            v5.Color1 = v3.Color1;
            v3.Color1 = true;
        else
            v5 = v3;
        end;
    else
        v5 = v3;
    end;
    local l__Left1__4 = v5.Left1;
    local v7;
    if l__Left1__4 then
        v7 = l__Left1__4.Color1;
    else
        v7 = false;
    end;
    if v7 then
        local l__Right1__5 = v5.Right1;
        local v8;
        if l__Right1__5 then
            v8 = l__Right1__5.Color1;
        else
            v8 = false;
        end;
        if v8 then
            v5.Color1 = not v5.Color1;
            local l__Left1__6 = v5.Left1;
            l__Left1__6.Color1 = not l__Left1__6.Color1;
            local l__Right1__7 = v5.Right1;
            l__Right1__7.Color1 = not l__Right1__7.Color1;
        end;
    end;
    return v5;
end;
local function u17(p10) --[[ Line: 174 ]]
    -- upvalues: u17 (copy), u9 (copy)
    if not p10.Left1 then
        return nil, p10;
    end;
    local l__Left1__8 = p10.Left1;
    local v11;
    if l__Left1__8 then
        v11 = l__Left1__8.Color1;
    else
        v11 = false;
    end;
    local v12;
    if v11 then
        v12 = p10;
    else
        local l__Left1__9 = p10.Left1.Left1;
        local v13;
        if l__Left1__9 then
            v13 = l__Left1__9.Color1;
        else
            v13 = false;
        end;
        if v13 then
            v12 = p10;
        else
            p10.Color1 = not p10.Color1;
            local l__Left1__10 = p10.Left1;
            l__Left1__10.Color1 = not l__Left1__10.Color1;
            local l__Right1__11 = p10.Right1;
            l__Right1__11.Color1 = not l__Right1__11.Color1;
            local l__Left1__12 = p10.Right1.Left1;
            local v14;
            if l__Left1__12 then
                v14 = l__Left1__12.Color1;
            else
                v14 = false;
            end;
            if v14 then
                local l__Right1__13 = p10.Right1;
                local l__Left1__14 = l__Right1__13.Left1;
                l__Right1__13.Left1 = l__Left1__14.Right1;
                l__Left1__14.Right1 = l__Right1__13;
                l__Left1__14.Color1 = l__Right1__13.Color1;
                l__Right1__13.Color1 = true;
                p10.Right1 = l__Left1__14;
                v12 = p10.Right1;
                p10.Right1 = v12.Left1;
                v12.Left1 = p10;
                v12.Color1 = p10.Color1;
                p10.Color1 = true;
                v12.Color1 = not v12.Color1;
                local l__Left1__15 = v12.Left1;
                l__Left1__15.Color1 = not l__Left1__15.Color1;
                local l__Right1__16 = v12.Right1;
                l__Right1__16.Color1 = not l__Right1__16.Color1;
            else
                v12 = p10;
            end;
        end;
    end;
    local v15, v16 = u17(v12.Left1);
    v12.Left1 = v15;
    return u9(v12), v16;
end;
local function u27(p18) --[[ Line: 188 ]]
    -- upvalues: u27 (copy), u9 (copy)
    local l__Left1__17 = p18.Left1;
    local v19;
    if l__Left1__17 then
        v19 = l__Left1__17.Color1;
    else
        v19 = false;
    end;
    local v20;
    if v19 then
        v20 = p18.Left1;
        p18.Left1 = v20.Right1;
        v20.Right1 = p18;
        v20.Color1 = p18.Color1;
        p18.Color1 = true;
    else
        v20 = p18;
    end;
    if not v20.Right1 then
        return nil, v20;
    end;
    local l__Right1__18 = v20.Right1;
    local v21;
    if l__Right1__18 then
        v21 = l__Right1__18.Color1;
    else
        v21 = false;
    end;
    local v22;
    if v21 then
        v22 = v20;
    else
        local l__Left1__19 = v20.Right1.Left1;
        local v23;
        if l__Left1__19 then
            v23 = l__Left1__19.Color1;
        else
            v23 = false;
        end;
        if v23 then
            v22 = v20;
        else
            v20.Color1 = not v20.Color1;
            local l__Left1__20 = v20.Left1;
            l__Left1__20.Color1 = not l__Left1__20.Color1;
            local l__Right1__21 = v20.Right1;
            l__Right1__21.Color1 = not l__Right1__21.Color1;
            local l__Left1__22 = v20.Left1.Left1;
            local v24;
            if l__Left1__22 then
                v24 = l__Left1__22.Color1;
            else
                v24 = false;
            end;
            if v24 then
                v22 = v20.Left1;
                v20.Left1 = v22.Right1;
                v22.Right1 = v20;
                v22.Color1 = v20.Color1;
                v20.Color1 = true;
                v22.Color1 = not v22.Color1;
                local l__Left1__23 = v22.Left1;
                l__Left1__23.Color1 = not l__Left1__23.Color1;
                local l__Right1__24 = v22.Right1;
                l__Right1__24.Color1 = not l__Right1__24.Color1;
            else
                v22 = v20;
            end;
        end;
    end;
    local v25, v26 = u27(v22.Right1);
    v22.Right1 = v25;
    return u9(v22), v26;
end;
local function u30(p28) --[[ Line: 205 ]]
    -- upvalues: u30 (copy)
    if not p28 then
        return -1;
    end;
    local v29 = u30(p28.Left1);
    return math.max(v29, u30(p28.Right1)) + 1;
end;
local function u36(p31, p32, p33, p34) --[[ Line: 214 ]]
    -- upvalues: u36 (copy)
    if not p32 then
        return true;
    end;
    if p33 ~= nil and p31(p32.Key, p33) <= 0 then
        return false;
    end;
    if p34 ~= nil and p31(p32.Key, p34) >= 0 then
        return false;
    end;
    local v35 = u36(p31, p32.Left1, p33, p32.Key);
    if v35 then
        v35 = u36(p31, p32.Right1, p32.Key, p34);
    end;
    return v35;
end;
local function u55(p37, p38, p39) --[[ Line: 233 ]]
    -- upvalues: u55 (copy), u17 (copy), u9 (copy)
    local v40;
    if p38 then
        local v41;
        if p37(p38.Key, p39) > 0 then
            local l__Left1__25 = p38.Left1;
            local v42;
            if l__Left1__25 then
                v42 = l__Left1__25.Color1;
            else
                v42 = false;
            end;
            if v42 then
                v41 = p38;
            else
                local l__Left1__26 = p38.Left1.Left1;
                local v43;
                if l__Left1__26 then
                    v43 = l__Left1__26.Color1;
                else
                    v43 = false;
                end;
                if v43 then
                    v41 = p38;
                else
                    p38.Color1 = not p38.Color1;
                    local l__Left1__27 = p38.Left1;
                    l__Left1__27.Color1 = not l__Left1__27.Color1;
                    local l__Right1__28 = p38.Right1;
                    l__Right1__28.Color1 = not l__Right1__28.Color1;
                    local l__Left1__29 = p38.Right1.Left1;
                    local v44;
                    if l__Left1__29 then
                        v44 = l__Left1__29.Color1;
                    else
                        v44 = false;
                    end;
                    if v44 then
                        local l__Right1__30 = p38.Right1;
                        local l__Left1__31 = l__Right1__30.Left1;
                        l__Right1__30.Left1 = l__Left1__31.Right1;
                        l__Left1__31.Right1 = l__Right1__30;
                        l__Left1__31.Color1 = l__Right1__30.Color1;
                        l__Right1__30.Color1 = true;
                        p38.Right1 = l__Left1__31;
                        v41 = p38.Right1;
                        p38.Right1 = v41.Left1;
                        v41.Left1 = p38;
                        v41.Color1 = p38.Color1;
                        p38.Color1 = true;
                        v41.Color1 = not v41.Color1;
                        local l__Left1__32 = v41.Left1;
                        l__Left1__32.Color1 = not l__Left1__32.Color1;
                        local l__Right1__33 = v41.Right1;
                        l__Right1__33.Color1 = not l__Right1__33.Color1;
                    else
                        v41 = p38;
                    end;
                end;
            end;
            local v45;
            v45, v40 = u55(p37, v41.Left1, p39);
            v41.Left1 = v45;
        else
            local l__Left1__34 = p38.Left1;
            local v46;
            if l__Left1__34 then
                v46 = l__Left1__34.Color1;
            else
                v46 = false;
            end;
            local v47;
            if v46 then
                v47 = p38.Left1;
                p38.Left1 = v47.Right1;
                v47.Right1 = p38;
                v47.Color1 = p38.Color1;
                p38.Color1 = true;
            else
                v47 = p38;
            end;
            if p37(v47.Key, p39) == 0 and not v47.Right1 then
                v47.Left2.Right2 = v47.Right2;
                v47.Right2.Left2 = v47.Left2;
                v47.Left1 = nil;
                v47.Right1 = nil;
                v47.Left2 = nil;
                v47.Right2 = nil;
                return nil, v47;
            end;
            if v47.Right1 then
                local l__Right1__35 = v47.Right1;
                local v48;
                if l__Right1__35 then
                    v48 = l__Right1__35.Color1;
                else
                    v48 = false;
                end;
                if v48 then
                    v41 = v47;
                else
                    local l__Left1__36 = v47.Right1.Left1;
                    local v49;
                    if l__Left1__36 then
                        v49 = l__Left1__36.Color1;
                    else
                        v49 = false;
                    end;
                    if v49 then
                        v41 = v47;
                    else
                        v47.Color1 = not v47.Color1;
                        local l__Left1__37 = v47.Left1;
                        l__Left1__37.Color1 = not l__Left1__37.Color1;
                        local l__Right1__38 = v47.Right1;
                        l__Right1__38.Color1 = not l__Right1__38.Color1;
                        local l__Left1__39 = v47.Left1.Left1;
                        local v50;
                        if l__Left1__39 then
                            v50 = l__Left1__39.Color1;
                        else
                            v50 = false;
                        end;
                        if v50 then
                            v41 = v47.Left1;
                            v47.Left1 = v41.Right1;
                            v41.Right1 = v47;
                            v41.Color1 = v47.Color1;
                            v47.Color1 = true;
                            v41.Color1 = not v41.Color1;
                            local l__Left1__40 = v41.Left1;
                            l__Left1__40.Color1 = not l__Left1__40.Color1;
                            local l__Right1__41 = v41.Right1;
                            l__Right1__41.Color1 = not l__Right1__41.Color1;
                        else
                            v41 = v47;
                        end;
                    end;
                end;
            else
                v41 = v47;
            end;
            if p37(v41.Key, p39) == 0 then
                local l__Left1__42 = v41.Left1;
                local l__Right1__43 = v41.Right1;
                local l__Color1__44 = v41.Color1;
                v41.Left2.Right2 = v41.Right2;
                v41.Right2.Left2 = v41.Left2;
                v41.Left1 = nil;
                v41.Right1 = nil;
                v41.Left2 = nil;
                v41.Right2 = nil;
                if l__Left1__42 and l__Right1__43 then
                    local v51, v52 = u17(l__Right1__43);
                    v52.Right1 = v51;
                    v52.Left1 = l__Left1__42;
                    v52.Color1 = l__Color1__44;
                    v40 = v41;
                    v41 = v52;
                else
                    local v53 = l__Left1__42 or l__Right1__43;
                    v53.Color1 = l__Color1__44;
                    v40 = v41;
                    v41 = v53;
                end;
            else
                local v54;
                v54, v40 = u55(p37, v41.Right1, p39);
                v41.Right1 = v54;
            end;
        end;
        p38 = u9(v41);
    else
        v40 = nil;
    end;
    return p38, v40;
end;
local function u67(p56, p57, p58, p59, p60) --[[ Line: 280 ]]
    -- upvalues: u67 (copy), u9 (copy)
    if p57 then
        local v61 = false;
        local v62 = p56(p57.Key, p59);
        local v63;
        if v62 == 0 then
            p57.Value = p60;
            v63 = p57;
        else
            if v62 > 0 then
                local v64;
                v64, v63, v61 = u67(p56, p57.Left1, p57.Left2, p59, p60);
                p57.Left1 = v64;
            else
                local v65;
                v65, v63, v61 = u67(p56, p57.Right1, p57, p59, p60);
                p57.Right1 = v65;
            end;
            if v61 then
                p57 = u9(p57);
            end;
        end;
        return p57, v63, v61;
    end;
    local v66 = {
        Color1 = true,
        Left2 = nil,
        Right2 = nil,
        Key = p59,
        Value = p60
    };
    local l__Right2__45 = p58.Right2;
    v66.Right2 = l__Right2__45;
    v66.Left2 = p58;
    p58.Right2 = v66;
    l__Right2__45.Left2 = v66;
    return v66, v66, true;
end;
local function u72(p68, p69) --[[ Line: 317 ]]
    -- upvalues: u72 (copy)
    if not p68 then
        return p69 == 0;
    end;
    local v70;
    if p68 then
        v70 = p68.Color1;
    else
        v70 = false;
    end;
    if not v70 then
        p69 = p69 - 1;
    end;
    local v71 = u72(p68.Left1, p69);
    if v71 then
        v71 = u72(p68.Right1, p69);
    end;
    return v71;
end;
local function u75(p73) --[[ Line: 330 ]]
    -- upvalues: u75 (copy)
    local v74 = 0;
    if p73 then
        v74 = v74 + 1 + u75(p73.Left1) + u75(p73.Right1);
    end;
    return v74;
end;
local function u79(p76, p77) --[[ Line: 340 ]]
    -- upvalues: u75 (copy), u79 (copy)
    if p76 then
        local l__Left1__46 = p76.Left1;
        local v78 = 0;
        if l__Left1__46 then
            v78 = v78 + 1 + u75(l__Left1__46.Left1) + u75(l__Left1__46.Right1);
        end;
        if p77 < v78 then
            return u79(p76.Left1, p77);
        elseif v78 < p77 then
            return u79(p76.Right1, p77 - v78 - 1);
        else
            return p76.Key;
        end;
    else
        return nil;
    end;
end;
local function u86(p80, p81, p82) --[[ Line: 354 ]]
    -- upvalues: u86 (copy), u75 (copy)
    if p82 then
        local v83 = p80(p82.Key, p81);
        if v83 > 0 then
            return u86(p80, p81, p82.Left1);
        elseif v83 < 0 then
            local l__Left1__47 = p82.Left1;
            local v84 = 0;
            if l__Left1__47 then
                v84 = v84 + 1 + u75(l__Left1__47.Left1) + u75(l__Left1__47.Right1);
            end;
            return v84 + 1 + u86(p80, p81, p82.Right1);
        else
            local l__Left1__48 = p82.Left1;
            local v85 = 0;
            if l__Left1__48 then
                v85 = v85 + 1 + u75(l__Left1__48.Left1) + u75(l__Left1__48.Right1);
            end;
            return v85;
        end;
    else
        return 0;
    end;
end;
local function u93(p87, p88) --[[ Line: 368 ]]
    -- upvalues: u93 (copy)
    if not p88 then
        return true;
    end;
    local l__Right1__49 = p88.Right1;
    local v89;
    if l__Right1__49 then
        v89 = l__Right1__49.Color1;
    else
        v89 = false;
    end;
    if v89 then
        return false;
    end;
    if p88 ~= p87 then
        local v90;
        if p88 then
            v90 = p88.Color1;
        else
            v90 = false;
        end;
        if v90 then
            local l__Left1__50 = p88.Left1;
            local v91;
            if l__Left1__50 then
                v91 = l__Left1__50.Color1;
            else
                v91 = false;
            end;
            if v91 then
                return false;
            end;
        end;
    end;
    local v92 = u93(p87, p88.Left1);
    if v92 then
        v92 = u93(p88.Right1);
    end;
    return v92;
end;
local v94 = {};
local u95 = table.freeze({
    __index = v94
});
function v94.Insert(p96, p97, p98) --[[ Line: 387 ]]
    -- upvalues: u67 (copy)
    local v99, v100, v101 = u67(p96.Comparator, p96.Root, p96.List, p97, p98);
    v99.Color1 = false;
    p96.Root = v99;
    if v101 then
        p96.Size = p96.Size + 1;
    end;
    return v100, v101;
end;
function v94.Remove(p102, p103) --[[ Line: 403 ]]
    -- upvalues: u55 (copy)
    local l__Root__51 = p102.Root;
    local v104;
    if l__Root__51 then
        local l__Left1__52 = l__Root__51.Left1;
        local v105;
        if l__Left1__52 then
            v105 = l__Left1__52.Color1;
        else
            v105 = false;
        end;
        if not v105 then
            local l__Right1__53 = l__Root__51.Right1;
            local v106;
            if l__Right1__53 then
                v106 = l__Right1__53.Color1;
            else
                v106 = false;
            end;
            if not v106 then
                l__Root__51.Color1 = true;
            end;
        end;
        local v107;
        v107, v104 = u55(p102.Comparator, l__Root__51, p103);
        if v107 then
            v107.Color1 = false;
        end;
        p102.Root = v107;
        if v104 then
            p102.Size = p102.Size - 1;
        end;
    else
        v104 = nil;
    end;
    return v104;
end;
function v94.RemoveMin(p108) --[[ Line: 423 ]]
    -- upvalues: u17 (copy)
    local l__Root__54 = p108.Root;
    local v109;
    if l__Root__54 then
        local l__Left1__55 = l__Root__54.Left1;
        local v110;
        if l__Left1__55 then
            v110 = l__Left1__55.Color1;
        else
            v110 = false;
        end;
        if not v110 then
            local l__Right1__56 = l__Root__54.Right1;
            local v111;
            if l__Right1__56 then
                v111 = l__Right1__56.Color1;
            else
                v111 = false;
            end;
            if not v111 then
                l__Root__54.Color1 = true;
            end;
        end;
        local v112;
        v112, v109 = u17(l__Root__54);
        if v112 then
            v112.Color1 = false;
        end;
        p108.Root = v112;
        if v109 then
            p108.Size = p108.Size - 1;
        end;
    else
        v109 = nil;
    end;
    return v109;
end;
function v94.RemoveMax(p113) --[[ Line: 442 ]]
    -- upvalues: u27 (copy)
    local l__Root__57 = p113.Root;
    local v114;
    if l__Root__57 then
        local l__Left1__58 = l__Root__57.Left1;
        local v115;
        if l__Left1__58 then
            v115 = l__Left1__58.Color1;
        else
            v115 = false;
        end;
        if not v115 then
            local l__Right1__59 = l__Root__57.Right1;
            local v116;
            if l__Right1__59 then
                v116 = l__Right1__59.Color1;
            else
                v116 = false;
            end;
            if not v116 then
                l__Root__57.Color1 = true;
            end;
        end;
        local v117;
        v117, v114 = u27(l__Root__57);
        if v117 then
            v117.Color1 = false;
        end;
        p113.Root = v117;
        if v114 then
            p113.Size = p113.Size - 1;
        end;
    else
        v114 = nil;
    end;
    return v114;
end;
function v94.Min(p118) --[[ Line: 462 ]]
    local l__List__60 = p118.List;
    local l__Left1__61 = l__List__60.Left1;
    if l__Left1__61 == l__List__60 then
        return nil;
    else
        return l__Left1__61;
    end;
end;
function v94.Max(p119) --[[ Line: 471 ]]
    local l__List__62 = p119.List;
    local l__Right1__63 = l__List__62.Right1;
    if l__Right1__63 == l__List__62 then
        return nil;
    else
        return l__Right1__63;
    end;
end;
function v94.GetSize(p120) --[[ Line: 481 ]]
    return p120.Size;
end;
function v94.ForEach(p121, p122) --[[ Line: 485 ]]
    local v123 = type(p122) == "function";
    assert(v123);
    local l__List__64 = p121.List;
    local v124 = l__List__64;
    while true do
        l__List__64 = l__List__64.Right2;
        if l__List__64 == v124 then
            break;
        end;
        p122(l__List__64.Key, l__List__64.Value);
    end;
end;
function v94.Next(p125, p126) --[[ Line: 498 ]]
    local l__List__65 = p125.List;
    if p126 == nil then
        p126 = p125.List;
    end;
    local l__Right2__66 = p126.Right2;
    if l__Right2__66 == l__List__65 then
        return nil, nil;
    else
        return l__Right2__66, l__Right2__66;
    end;
end;
function v94.Iterator(p127) --[[ Line: 508 ]]
    return p127.Next, p127;
end;
function v94.IsBST(p128) --[[ Line: 512 ]]
    -- upvalues: u36 (copy)
    local l__Comparator__67 = p128.Comparator;
    local l__Root__68 = p128.Root;
    local v129;
    if l__Root__68 then
        v129 = u36(l__Comparator__67, l__Root__68.Left1, nil, l__Root__68.Key);
        if v129 then
            return u36(l__Comparator__67, l__Root__68.Right1, l__Root__68.Key, nil);
        end;
    else
        v129 = true;
    end;
    return v129;
end;
function v94.IsSizeConsistent(p130) --[[ Line: 516 ]]
    -- upvalues: u75 (copy)
    local l__Size__69 = p130.Size;
    local l__Root__70 = p130.Root;
    local v131 = 0;
    if l__Root__70 then
        v131 = v131 + 1 + u75(l__Root__70.Left1) + u75(l__Root__70.Right1);
    end;
    if l__Size__69 ~= v131 then
        return false;
    end;
    local l__List__71 = p130.List;
    local v132 = l__List__71;
    local v133 = 0;
    while true do
        l__List__71 = l__List__71.Right2;
        if l__List__71 == v132 then
            break;
        end;
        v133 = v133 + 1;
    end;
    return l__Size__69 == v133;
end;
function v94.IsRankConsistent(u134) --[[ Line: 538 ]]
    -- upvalues: u75 (copy), u79 (copy), u86 (copy)
    for v135 = 0, u134.Size - 1 do
        local l__Root__72 = u134.Root;
        local v136;
        if l__Root__72 then
            local l__Left1__73 = l__Root__72.Left1;
            local v137 = 0;
            if l__Left1__73 then
                v137 = v137 + 1 + u75(l__Left1__73.Left1) + u75(l__Left1__73.Right1);
            end;
            if v135 < v137 then
                v136 = u79(l__Root__72.Left1, v135);
            elseif v137 < v135 then
                v136 = u79(l__Root__72.Right1, v135 - v137 - 1);
            else
                v136 = l__Root__72.Key;
            end;
        else
            v136 = nil;
        end;
        if v135 ~= u86(u134.Comparator, v136, u134.Root) then
            return false;
        end;
    end;
    u134:ForEach(function(p138, _) --[[ Line: 548 ]]
        -- upvalues: u86 (ref), u134 (copy), u75 (ref), u79 (ref)
        local v139 = u86(u134.Comparator, p138, u134.Root);
        local l__Root__74 = u134.Root;
        local v140;
        if l__Root__74 then
            local l__Left1__75 = l__Root__74.Left1;
            local v141 = 0;
            if l__Left1__75 then
                v141 = v141 + 1 + u75(l__Left1__75.Left1) + u75(l__Left1__75.Right1);
            end;
            if v139 < v141 then
                v140 = u79(l__Root__74.Left1, v139);
            elseif v141 < v139 then
                v140 = u79(l__Root__74.Right1, v139 - v141 - 1);
            else
                v140 = l__Root__74.Key;
            end;
        else
            v140 = nil;
        end;
        if u134.Comparator(v140, p138) ~= 0 then
            return false;
        end;
    end);
    return true;
end;
function v94.Is23(p142) --[[ Line: 558 ]]
    -- upvalues: u93 (copy)
    return u93(p142.Root, p142.Root);
end;
function v94.IsBalanced(p143) --[[ Line: 562 ]]
    -- upvalues: u72 (copy)
    local l__Root__76 = p143.Root;
    local v144 = l__Root__76;
    local v145 = 0;
    while l__Root__76 do
        local v146;
        if l__Root__76 then
            v146 = l__Root__76.Color1;
        else
            v146 = false;
        end;
        if not v146 then
            v145 = v145 + 1;
        end;
        l__Root__76 = l__Root__76.Left1;
    end;
    local v147;
    if v144 then
        local v148;
        if v144 then
            v148 = v144.Color1;
        else
            v148 = false;
        end;
        if not v148 then
            v145 = v145 - 1;
        end;
        v147 = u72(v144.Left1, v145);
        if v147 then
            return u72(v144.Right1, v145);
        end;
    else
        v147 = v145 == 0;
    end;
    return v147;
end;
function v94.Check(p149) --[[ Line: 575 ]]
    if p149:IsBST() then
        if p149:IsSizeConsistent() then
            if p149:IsRankConsistent() then
                if p149:Is23() then
                    if p149:IsBalanced() then
                        return true;
                    else
                        return false, "Not balanced";
                    end;
                else
                    return false, "Not a 2-3 tree";
                end;
            else
                return false, "Ranks not consistent";
            end;
        else
            return false, "Subtree counts not consistent";
        end;
    else
        return false, "Not in symmetric order";
    end;
end;
table.freeze(v94);
return table.freeze({
    Compare = function(p150, p151) --[[ Name: Compare, Line 599 ]]
        return p150 < p151 and -1 or (p151 < p150 and 1 or 0);
    end,
    new = function(p152, _, _) --[[ Name: new, Line 605 ]]
        -- upvalues: u95 (copy)
        local v153 = type(p152) == "function";
        assert(v153);
        local v154 = {
            Color1 = false,
            Key = nil,
            Value = nil
        };
        v154.Left2 = v154;
        v154.Right2 = v154;
        return setmetatable({
            Root = nil,
            Size = 0,
            Comparator = p152,
            List = v154
        }, u95);
    end
});