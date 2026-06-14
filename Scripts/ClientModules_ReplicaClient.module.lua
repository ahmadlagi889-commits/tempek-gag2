-- Decompiled with Potassium's decompiler.

local l__ReplicaShared__1 = game.ReplicatedStorage.ReplicaShared;
local l__Remote__2 = require(l__ReplicaShared__1.Remote);
local l__Signal__3 = require(l__ReplicaShared__1.Signal);
local l__Maid__4 = require(l__ReplicaShared__1.Maid);
local u1 = {};
local l__CollectionService__5 = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
local u2 = false;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = l__Remote__2.New("ReplicaRequestData");
local v9 = l__Remote__2.New("ReplicaSet");
local v10 = l__Remote__2.New("ReplicaSetValues");
local v11 = l__Remote__2.New("ReplicaTableInsert");
local v12 = l__Remote__2.New("ReplicaTableRemove");
local v13 = l__Remote__2.New("ReplicaWrite");
local u14 = l__Remote__2.New("ReplicaSignal");
local v15 = l__Remote__2.New("ReplicaParent");
local v16 = l__Remote__2.New("ReplicaCreate");
local v17 = l__Remote__2.New("ReplicaBind");
local v18 = l__Remote__2.New("ReplicaDestroy");
local u19 = l__Remote__2.New("ReplicaSignalUnreliable", true);
local u20 = {};
local u21 = false;
local function u34(p22) --[[ Line: 112 ]]
    -- upvalues: u20 (copy)
    local v23 = u20[p22];
    if v23 ~= nil then
        return v23;
    end;
    local v24 = require(p22);
    local v25 = {};
    for v26, v27 in pairs(v24) do
        table.insert(v25, { v26, v27 });
    end;
    table.sort(v25, function(p28, p29) --[[ Line: 128 ]]
        return p28[1] < p29[1];
    end);
    local v30 = {};
    for v31, v32 in ipairs(v25) do
        local v33 = {
            Name = v32[1],
            Id = v31,
            fn = v32[2]
        };
        v30[v32[1]] = v33;
        v30[v31] = v33;
    end;
    u20[p22] = v30;
    return v30;
end;
local u35 = nil;
local function u38(p36, ...) --[[ Line: 178 ]]
    -- upvalues: u35 (ref)
    local v37 = u35;
    u35 = nil;
    p36(...);
    u35 = v37;
end;
local function u39(...) --[[ Line: 186 ]]
    -- upvalues: u38 (copy)
    u38(...);
    while true do
        u38(coroutine.yield());
    end;
end;
local u40 = {
    IsReady = false,
    OnLocalReady = l__Signal__3.New()
};
u40.__index = u40;
local function u48(p41, p42) --[[ Line: 199 ]]
    -- upvalues: u34 (copy), u5 (copy), u4 (copy), l__Signal__3 (copy), l__Maid__4 (copy), u1 (copy), u40 (copy)
    local v43;
    if p42[5] == nil then
        v43 = nil;
    else
        v43 = u34(p42[5]);
    end;
    local v44 = p42[1];
    local v45 = u5[p42[4]] or u4[p42[4]];
    local v46 = {
        BoundInstance = nil,
        Tags = p42[2],
        Data = p42[3],
        Id = p41,
        Token = v44,
        Parent = v45,
        Children = {},
        OnClientEvent = l__Signal__3.New(),
        Maid = l__Maid__4.New(u1),
        self_creation = p42,
        write_lib = v43,
        set_listeners = {},
        write_listeners = {},
        changed_listeners = l__Signal__3.New()
    };
    local v47 = setmetatable(v46, u40);
    if v45 ~= nil then
        v45.Children[v47] = true;
    end;
    return v47;
end;
function u40.RequestData() --[[ Line: 238 ]]
    -- upvalues: u2 (ref), u8 (copy), u40 (copy)
    if u2 == true then
    else
        u2 = true;
        task.spawn(function() --[[ Line: 246 ]]
            -- upvalues: u8 (ref), u40 (ref)
            u8:FireServer();
            while task.wait(2) and u40.IsReady ~= true do
                u8:FireServer();
            end;
        end);
    end;
end;
function u40.OnNew(p49, u50) --[[ Line: 261 ]]
    -- upvalues: u7 (copy), l__Signal__3 (copy), u3 (copy), u35 (ref), u39 (copy)
    if type(p49) ~= "string" then
        error((`[{script.Name}]: "token" must be a string`));
    end;
    local v51 = u7[p49];
    if v51 == nil then
        v51 = l__Signal__3.New();
        u7[p49] = v51;
    end;
    local v52 = u3[p49];
    local u53 = v51:Connect(u50);
    if v52 ~= nil then
        local u54 = {};
        for v55 in pairs(v52) do
            u54[v55] = true;
        end;
        task.defer(function() --[[ Line: 285 ]]
            -- upvalues: u54 (copy), u53 (copy), u35 (ref), u39 (ref), u50 (copy)
            for v56 in pairs(u54) do
                if u53.IsConnected ~= true then
                    break;
                end;
                if not u35 then
                    u35 = coroutine.create(u39);
                end;
                task.spawn(u35, u50, v56);
            end;
        end);
    end;
    return u53;
end;
function u40.FromId(p57) --[[ Line: 303 ]]
    -- upvalues: u4 (copy)
    return u4[p57];
end;
function u40.Test() --[[ Line: 307 ]]
    -- upvalues: u3 (copy), u4 (copy), u5 (copy), u6 (copy)
    return {
        TokenReplicas = u3,
        Replicas = u4,
        BindReplicas = u5,
        BindInstances = u6
    };
end;
function u40.OnSet(p58, p59, p60) --[[ Line: 316 ]]
    -- upvalues: l__Signal__3 (copy)
    local v61 = table.concat(p59, ".");
    local v62 = p58.set_listeners[v61];
    if v62 == nil then
        v62 = l__Signal__3.New();
        p58.set_listeners[v61] = v62;
    end;
    return v62:Connect(p60);
end;
function u40.OnWrite(p63, p64, p65) --[[ Line: 327 ]]
    -- upvalues: l__Signal__3 (copy)
    local v66 = p63.write_listeners[p64];
    if v66 == nil then
        v66 = l__Signal__3.New();
        p63.write_listeners[p64] = v66;
    end;
    return v66:Connect(p65);
end;
function u40.OnChange(p67, p68) --[[ Line: 337 ]]
    return p67.changed_listeners:Connect(p68);
end;
function u40.GetChild(p69, p70) --[[ Line: 341 ]]
    if type(p70) ~= "string" then
        error((`[{script.Name}]: "token" must be a string`));
    end;
    for v71 in pairs(p69.Children) do
        if v71.Token == p70 then
            return v71;
        end;
    end;
    return nil;
end;
function u40.FireServer(p72, ...) --[[ Line: 353 ]]
    -- upvalues: u14 (copy)
    u14:FireServer(p72.Id, ...);
end;
function u40.UFireServer(p73, ...) --[[ Line: 357 ]]
    -- upvalues: u19 (copy)
    u19:FireServer(p73.Id, ...);
end;
function u40.Identify(p74) --[[ Line: 361 ]]
    local v75 = "";
    local v76 = true;
    for v77, v78 in pairs(p74.Tags) do
        v75 = v75 .. `{v76 == true and "" or ";"}{tostring(v77)}={tostring(v78)}`;
        v76 = false;
    end;
    return `[Id:{p74.Id};Token:{p74.Token};Tags:[{v75}]]`;
end;
function u40.IsActive(p79) --[[ Line: 371 ]]
    return p79.Maid:IsActive();
end;
function u40.Set(p80, p81, p82) --[[ Line: 375 ]]
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "Set()" can't be called outside of WriteLibs client-side`));
    end;
    local l__Data__6 = p80.Data;
    for v83 = 1, #p81 - 1 do
        l__Data__6 = l__Data__6[p81[v83]];
    end;
    local v84 = p81[#p81];
    local v85 = l__Data__6[v84];
    l__Data__6[v84] = p82;
    if next(p80.set_listeners) ~= nil then
        local v86 = p80.set_listeners[table.concat(p81, ".")];
        if v86 ~= nil then
            v86:Fire(p82, v85);
        end;
    end;
    p80.changed_listeners:Fire("Set", p81, p82, v85);
end;
function u40.SetValues(p87, p88, p89) --[[ Line: 403 ]]
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "SetValues()" can't be called outside of WriteLibs client-side`));
    end;
    local l__Data__7 = p87.Data;
    for _, v90 in ipairs(p88) do
        l__Data__7 = l__Data__7[v90];
    end;
    for v91, v92 in pairs(p89) do
        l__Data__7[v91] = v92;
    end;
    p87.changed_listeners:Fire("SetValues", p88, p89);
end;
function u40.TableInsert(p93, p94, p95, p96) --[[ Line: 425 ]]
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "TableInsert()" can't be called outside of WriteLibs client-side`));
    end;
    local l__Data__8 = p93.Data;
    for _, v97 in ipairs(p94) do
        l__Data__8 = l__Data__8[v97];
    end;
    if p96 == nil then
        table.insert(l__Data__8, p95);
        p96 = #l__Data__8;
    else
        table.insert(l__Data__8, p96, p95);
    end;
    p93.changed_listeners:Fire("TableInsert", p94, p95, p96);
    return p96;
end;
function u40.TableRemove(p98, p99, p100) --[[ Line: 452 ]]
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "TableRemove()" can't be called outside of WriteLibs client-side`));
    end;
    local l__Data__9 = p98.Data;
    for _, v101 in ipairs(p99) do
        l__Data__9 = l__Data__9[v101];
    end;
    local v102 = table.remove(l__Data__9, p100);
    p98.changed_listeners:Fire("TableRemove", p99, v102, p100);
    return v102;
end;
function u40.Write(p103, p104, ...) --[[ Line: 474 ]]
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "Write()" can't be called outside of WriteLibs client-side`));
    end;
    local v105 = table.pack(p103.write_lib[p104].fn(p103, ...));
    local v106 = p103.write_listeners[p104];
    if v106 ~= nil then
        v106:Fire(...);
    end;
    return table.unpack(v105);
end;
local function u111(p107, p108) --[[ Line: 496 ]]
    -- upvalues: u111 (copy), u3 (copy), u4 (copy), u5 (copy), u1 (copy)
    for v109 in pairs(p107.Children) do
        u111(v109, true);
    end;
    if p108 ~= true and p107.Parent ~= nil then
        p107.Parent.Children[p107] = nil;
    end;
    local l__Id__10 = p107.Id;
    local v110 = u3[p107.Token];
    if v110 ~= nil then
        v110[p107] = nil;
    end;
    if u4[l__Id__10] == p107 then
        u4[l__Id__10] = nil;
    end;
    if u5[l__Id__10] == p107 then
        u5[l__Id__10] = nil;
    end;
    p107.Maid:Unlock(u1);
    p107.Maid:Cleanup();
    p107.BoundInstance = nil;
end;
local function u116(p112, p113) --[[ Line: 528 ]]
    -- upvalues: u48 (copy), u5 (copy), u116 (copy), u111 (copy)
    local v114 = u48(p112.Id, p112.self_creation);
    u5[p112.Id] = v114;
    for v115 in pairs(p112.Children) do
        u116(v115, true);
    end;
    if p113 ~= true then
        u111(p112);
    end;
    return v114;
end;
local function u124(p117, p118) --[[ Line: 549 ]]
    -- upvalues: u5 (copy), u3 (copy), u4 (copy), u124 (copy), u7 (copy)
    local v119;
    if p118 == nil then
        p118 = {};
        v119 = true;
    else
        v119 = false;
    end;
    u5[p117.Id] = nil;
    local l__Token__11 = p117.Token;
    local v120 = u3[l__Token__11];
    if v120 == nil then
        v120 = {};
        u3[l__Token__11] = v120;
    end;
    v120[p117] = true;
    u4[p117.Id] = p117;
    table.insert(p118, p117);
    for v121 in pairs(p117.Children) do
        u124(v121, p118);
    end;
    if v119 == true then
        for _, v122 in ipairs(p118) do
            local v123 = u7[v122.Token];
            if v123 ~= nil then
                v123:Fire(v122);
            end;
        end;
    end;
end;
local function u132(p125, p126, p127) --[[ Line: 588 ]]
    -- upvalues: u132 (copy)
    local v128 = p125[p127];
    if v128 ~= nil then
        table.sort(v128, function(p129, p130) --[[ Line: 592 ]]
            return p129.Id < p130.Id;
        end);
        for _, v131 in ipairs(v128) do
            p126(v131.Id, v131.SelfCreation);
            u132(p125, p126, v131.Id);
        end;
    end;
end;
local function u161(p133, p134, p135) --[[ Line: 604 ]]
    -- upvalues: u132 (copy)
    local v136 = {};
    local v137 = {};
    local v138 = {};
    if type(p133[1]) == "table" then
        for _, v139 in ipairs(p133) do
            for v140, v141 in pairs(v139) do
                local v142 = {
                    Id = tonumber(v140),
                    SelfCreation = v141
                };
                local v143 = v141[4];
                if v143 == 0 or v142.Id == p134 then
                    table.insert(v136, v142);
                elseif v139[tostring(v143)] == nil then
                    table.insert(v138, v142);
                else
                    local v144 = v137[v143];
                    if v144 == nil then
                        v144 = {};
                        v137[v143] = v144;
                    end;
                    table.insert(v144, v142);
                end;
            end;
        end;
    else
        for v145, v146 in pairs(p133) do
            local v147 = {
                Id = tonumber(v145),
                SelfCreation = v146
            };
            local v148 = v146[4];
            if v148 == 0 or v147.Id == p134 then
                table.insert(v136, v147);
            elseif p133[tostring(v148)] == nil then
                table.insert(v138, v147);
            else
                local v149 = v137[v148];
                if v149 == nil then
                    v149 = {};
                    v137[v148] = v149;
                end;
                table.insert(v149, v147);
            end;
        end;
    end;
    table.sort(v136, function(p150, p151) --[[ Line: 655 ]]
        return p150.Id < p151.Id;
    end);
    local v152 = {};
    for _, v153 in ipairs(v136) do
        p135(v153.Id, v153.SelfCreation);
        u132(v137, p135, v153.Id);
    end;
    if #v138 ~= 0 then
        local v154 = `[{script.Name}]: GROUP REPLICATION ERROR - Missing parents for:\n`;
        for v155 = 1, math.min(#v138, 50) do
            local v156 = v138[v155];
            local l__SelfCreation__12 = v156.SelfCreation;
            local v157 = "";
            local v158 = true;
            for v159, v160 in pairs(l__SelfCreation__12[2]) do
                v157 = v157 .. `{v158 == true and "" or ";"}{tostring(v159)}={tostring(v160)}`;
                v158 = false;
            end;
            v154 = v154 .. `[Id:{v156.Id};ParentId:{l__SelfCreation__12[4]};Token:{l__SelfCreation__12[1]};Tags:[{v157}]]\n`;
        end;
        if #v138 > 50 then
            v154 = v154 .. `(hiding {50 - #v138} more)\n`;
        end;
        local _ = v154 .. "Traceback:\n" .. debug.traceback();
    end;
    return v152;
end;
u8.OnClientEvent:Connect(function() --[[ Line: 705 ]]
    -- upvalues: u40 (copy)
    if u40.IsReady == true then
    else
        u40.IsReady = true;
        u40.OnLocalReady:Fire();
    end;
end);
v9.OnClientEvent:Connect(function(p162, p163, p164) --[[ Line: 716 ]]
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v165 = u4[p162] or u5[p162];
    if v165 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p162}]`));
    end;
    u21 = true;
    local v166, v167 = pcall(v165.Set, v165, p163, p164);
    u21 = false;
    if v166 ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v165:Identify()}\n` .. v167);
    end;
end);
v10.OnClientEvent:Connect(function(p168, p169, p170) --[[ Line: 726 ]]
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v171 = u4[p168] or u5[p168];
    if v171 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p168}]`));
    end;
    u21 = true;
    local v172, v173 = pcall(v171.SetValues, v171, p169, p170);
    u21 = false;
    if v172 ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v171:Identify()}\n` .. v173);
    end;
end);
v11.OnClientEvent:Connect(function(p174, p175, p176, p177) --[[ Line: 736 ]]
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v178 = u4[p174] or u5[p174];
    if v178 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p174}]`));
    end;
    u21 = true;
    local v179, v180 = pcall(v178.TableInsert, v178, p175, p176, p177);
    u21 = false;
    if v179 ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v178:Identify()}\n` .. v180);
    end;
end);
v12.OnClientEvent:Connect(function(p181, p182, p183) --[[ Line: 746 ]]
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v184 = u4[p181] or u5[p181];
    if v184 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p181}]`));
    end;
    u21 = true;
    local v185, v186 = pcall(v184.TableRemove, v184, p182, p183);
    u21 = false;
    if v185 ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v184:Identify()}\n` .. v186);
    end;
end);
v13.OnClientEvent:Connect(function(p187, p188, ...) --[[ Line: 756 ]]
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v189 = u4[p187] or u5[p187];
    if v189 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p187}]`));
    end;
    local l__Name__13 = v189.write_lib[p188].Name;
    u21 = true;
    local v190, v191 = pcall(v189.Write, v189, l__Name__13, ...);
    u21 = false;
    if v190 ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v189:Identify()}\n` .. v191);
    end;
end);
local function v194(p192, ...) --[[ Line: 767 ]]
    -- upvalues: u4 (copy), u5 (copy)
    local v193 = u4[p192] or u5[p192];
    if v193 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p192}]`));
    end;
    v193.OnClientEvent:Fire(...);
end;
u14.OnClientEvent:Connect(v194);
u19.OnClientEvent:Connect(v194);
v15.OnClientEvent:Connect(function(p195, p196) --[[ Line: 775 ]]
    -- upvalues: u4 (copy), u5 (copy), u124 (copy), u116 (copy)
    local v197 = u4[p195] or u5[p195];
    if v197 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p195}]`));
    end;
    local l__Parent__14 = v197.Parent;
    local v198 = u4[p196] or u5[p196];
    if v198 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p196}]`));
    end;
    l__Parent__14.Children[v197] = nil;
    v198.Children[v197] = true;
    v197.Parent = v198;
    v197.self_creation[4] = p196;
    if u5[l__Parent__14.Id] == nil or u4[p196] == nil then
        if u4[l__Parent__14.Id] ~= nil and u5[p196] ~= nil then
            u116(v197);
        end;
    else
        u124(v197);
    end;
end);
v16.OnClientEvent:Connect(function(p199, p200) --[[ Line: 796 ]]
    -- upvalues: u161 (copy), u48 (copy), u6 (copy), u5 (copy), u3 (copy), u4 (copy), u7 (copy)
    local u201 = {};
    u161(p199, p200, function(p202, p203) --[[ Line: 800 ]]
        -- upvalues: u48 (ref), u6 (ref), u5 (ref), u3 (ref), u4 (ref), u201 (copy)
        local v204 = p203[4];
        local v205 = u48(p202, p203);
        local v206 = false;
        if v204 == 0 then
            if v205.Tags.Bind == true then
                local v207 = u6[p202];
                v205.BoundInstance = v207;
                v206 = v207 == nil and true or v206;
            end;
        else
            v206 = u5[v204] ~= nil and true or v206;
        end;
        if v206 == true then
            u5[p202] = v205;
        else
            local l__Token__15 = v205.Token;
            local v208 = u3[l__Token__15];
            if v208 == nil then
                v208 = {};
                u3[l__Token__15] = v208;
            end;
            v208[v205] = true;
            u4[p202] = v205;
            table.insert(u201, v205);
        end;
    end);
    for _, v209 in ipairs(u201) do
        local v210 = u7[v209.Token];
        if v210 ~= nil then
            v210:Fire(v209);
        end;
    end;
end);
v17.OnClientEvent:Connect(function(p211) --[[ Line: 855 ]]
    -- upvalues: u4 (copy), u5 (copy), u6 (copy), u116 (copy)
    local v212 = u4[p211] or u5[p211];
    if v212 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p211}]`));
    end;
    v212.Tags.Bind = true;
    local v213 = u6[p211];
    v212.BoundInstance = v213;
    if v213 == nil then
        u116(v212);
    end;
end);
v18.OnClientEvent:Connect(function(p214) --[[ Line: 869 ]]
    -- upvalues: u4 (copy), u5 (copy), u111 (copy)
    local v215 = u4[p214] or u5[p214];
    if v215 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p214}]`));
    end;
    u111(v215);
end);
l__CollectionService__5:GetInstanceAddedSignal("REPLICA"):Connect(function(p216) --[[ Line: 904 ]]
    -- upvalues: u6 (copy), u5 (copy), u124 (copy)
    if p216:IsA("NumberValue") == true then
        local l__Value__16 = p216.Value;
        local l__Parent__17 = p216.Parent;
        u6[l__Value__16] = l__Parent__17;
        local v217 = u5[l__Value__16];
        if v217 ~= nil then
            v217.BoundInstance = l__Parent__17;
            u124(v217);
        end;
    end;
end);
l__CollectionService__5:GetInstanceRemovedSignal("REPLICA"):Connect(function(p218) --[[ Line: 910 ]]
    -- upvalues: u6 (copy), u4 (copy), u116 (copy)
    if p218:IsA("NumberValue") == true then
        local l__Value__18 = p218.Value;
        u6[l__Value__18] = nil;
        local v219 = u4[l__Value__18];
        if v219 ~= nil then
            u116(v219);
        end;
    end;
end);
for _, v220 in pairs(l__CollectionService__5:GetTagged("REPLICA")) do
    if v220:IsA("NumberValue") == true then
        local l__Value__19 = v220.Value;
        local l__Parent__20 = v220.Parent;
        u6[l__Value__19] = l__Parent__20;
        local v221 = u5[l__Value__19];
        if v221 ~= nil then
            v221.BoundInstance = l__Parent__20;
            u124(v221);
        end;
    end;
end;
return u40;