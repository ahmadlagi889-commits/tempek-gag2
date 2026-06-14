-- Decompiled with Potassium's decompiler.

local function u4(p1) --[[ Line: 4 ]]
    local v2 = string.split(p1, "/");
    for v3 = #v2, 1, -1 do
        if v2[v3] == "" then
            table.remove(v2, v3);
        end;
    end;
    return v2;
end;
local function u9(p5, p6) --[[ Line: 24 ]]
    -- upvalues: u9 (copy)
    if p5.instance == nil then
    else
        p5.instance = nil;
        local l__connections__1 = p5.connections;
        if l__connections__1 then
            for _, v7 in ipairs(l__connections__1) do
                v7:Disconnect();
            end;
            table.clear(l__connections__1);
        end;
        if p6 and p5.alias then
            p6[p5.alias] = nil;
        end;
        local l__children__2 = p5.children;
        if l__children__2 then
            for _, v8 in pairs(l__children__2) do
                u9(v8, p6);
            end;
        end;
    end;
end;
local u10 = {};
u10.__index = u10;
function u10.new(p11, p12) --[[ Line: 54 ]]
    -- upvalues: u4 (copy), u10 (copy)
    local v13 = {};
    local v14 = 1;
    local v15 = {};
    local v16 = {};
    local v17 = {};
    local v18 = {};
    for v19, v20 in pairs(p11) do
        v13[v19] = u4(v20);
        v14 = v14 + 1;
    end;
    return setmetatable({
        _boundFn = p12,
        _parsedManifest = v13,
        _manifestSizeTarget = v14,
        _dtorMap = v15,
        _connections = v16,
        _rootInstToRootNode = v17,
        _rootInstToManifest = v18
    }, u10);
end;
function u10._startBoundFn(p21, p22, p23) --[[ Line: 80 ]]
    local l___boundFn__3 = p21._boundFn;
    local l___dtorMap__4 = p21._dtorMap;
    local v24 = l___dtorMap__4[p22];
    if v24 then
        v24();
        l___dtorMap__4[p22] = nil;
    end;
    local v25 = l___boundFn__3(p23);
    if v25 then
        l___dtorMap__4[p22] = v25;
    end;
end;
function u10._stopBoundFn(p26, p27) --[[ Line: 96 ]]
    local l___dtorMap__5 = p26._dtorMap;
    local v28 = l___dtorMap__5[p27];
    if v28 then
        v28();
        l___dtorMap__5[p27] = nil;
    end;
end;
function u10.bindRoot(u29, u30) --[[ Line: 106 ]]
    -- upvalues: u9 (copy)
    debug.profilebegin("AtomicBinding:BindRoot");
    local l___parsedManifest__6 = u29._parsedManifest;
    local l___rootInstToRootNode__7 = u29._rootInstToRootNode;
    local l___rootInstToManifest__8 = u29._rootInstToManifest;
    local l___manifestSizeTarget__9 = u29._manifestSizeTarget;
    assert(l___rootInstToManifest__8[u30] == nil);
    local u31 = {};
    l___rootInstToManifest__8[u30] = u31;
    debug.profilebegin("BuildTree");
    local v32 = {
        alias = "root",
        instance = u30
    };
    if next(l___parsedManifest__6) then
        v32.children = {};
        v32.connections = {};
    end;
    l___rootInstToRootNode__7[u30] = v32;
    for v33, v34 in pairs(l___parsedManifest__6) do
        local v35 = v32;
        for v36, v37 in ipairs(v34) do
            local v38 = v36 == #v34;
            local v39 = v32.children[v37] or {};
            if v38 then
                if v39.alias ~= nil then
                    error("Multiple aliases assigned to one instance");
                end;
                v39.alias = v33;
            else
                v39.children = v39.children or {};
                v39.connections = v39.connections or {};
            end;
            v32.children[v37] = v39;
            v32 = v39;
        end;
        v32 = v35;
    end;
    debug.profileend();
    local function u55(p40) --[[ Line: 160 ]]
        -- upvalues: u31 (copy), u55 (copy), u29 (copy), u30 (copy), u9 (ref), l___manifestSizeTarget__9 (copy)
        local u41 = assert(p40.instance);
        local l__children__10 = p40.children;
        local l__alias__11 = p40.alias;
        local v42 = not l__children__10;
        if l__alias__11 then
            u31[l__alias__11] = u41;
        end;
        if not v42 then
            local function v45(p43) --[[ Line: 172 ]]
                -- upvalues: l__children__10 (copy), u55 (ref)
                local v44 = l__children__10[p43.Name];
                if v44 and v44.instance == nil then
                    v44.instance = p43;
                    u55(v44);
                end;
            end;
            local function v50(p46) --[[ Line: 183 ]]
                -- upvalues: l__children__10 (copy), u29 (ref), u30 (ref), u9 (ref), u31 (ref), u41 (copy), u55 (ref)
                local l__Name__12 = p46.Name;
                local v47 = l__children__10[l__Name__12];
                if v47 then
                    if v47.instance == p46 then
                        u29:_stopBoundFn(u30);
                        u9(v47, u31);
                        assert(v47.instance == nil);
                        local v48 = u41:FindFirstChild(l__Name__12);
                        local v49 = v48 and l__children__10[v48.Name];
                        if v49 then
                            if v49.instance ~= nil then
                                return;
                            end;
                            v49.instance = v48;
                            u55(v49);
                        end;
                    end;
                end;
            end;
            for _, v51 in ipairs(u41:GetChildren()) do
                local v52 = l__children__10[v51.Name];
                if v52 then
                    if v52.instance == nil then
                        v52.instance = v51;
                        u55(v52);
                    end;
                end;
            end;
            table.insert(p40.connections, u41.ChildAdded:Connect(v45));
            table.insert(p40.connections, u41.ChildRemoved:Connect(v50));
        end;
        if v42 then
            local v53 = l___manifestSizeTarget__9;
            local v54 = 0;
            for _ in pairs(u31) do
                v54 = v54 + 1;
            end;
            assert(v54 <= v53, v54);
            if v54 == v53 then
                u29:_startBoundFn(u30, u31);
            end;
        end;
    end;
    debug.profilebegin("ResolveTree");
    u55(v32);
    debug.profileend();
    debug.profileend();
end;
function u10.unbindRoot(p56, p57) --[[ Line: 236 ]]
    -- upvalues: u9 (copy)
    local l___rootInstToRootNode__13 = p56._rootInstToRootNode;
    local l___rootInstToManifest__14 = p56._rootInstToManifest;
    p56:_stopBoundFn(p57);
    local v58 = l___rootInstToRootNode__13[p57];
    if v58 then
        u9(v58, (assert(l___rootInstToManifest__14[p57])));
        l___rootInstToRootNode__13[p57] = nil;
    end;
    l___rootInstToManifest__14[p57] = nil;
end;
function u10.destroy(p59) --[[ Line: 252 ]]
    -- upvalues: u9 (copy)
    debug.profilebegin("AtomicBinding:destroy");
    for _, v60 in pairs(p59._dtorMap) do
        v60:destroy();
    end;
    table.clear(p59._dtorMap);
    for _, v61 in ipairs(p59._connections) do
        v61:Disconnect();
    end;
    table.clear(p59._connections);
    local l___rootInstToManifest__15 = p59._rootInstToManifest;
    for v62, v63 in pairs(p59._rootInstToRootNode) do
        u9(v63, (assert(l___rootInstToManifest__15[v62])));
    end;
    table.clear(p59._rootInstToManifest);
    table.clear(p59._rootInstToRootNode);
    debug.profileend();
end;
return u10;