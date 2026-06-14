-- Decompiled with Potassium's decompiler.

local l__Signal__1 = require(script.Signal);
local l__Task__2 = require(script.Task);
local l__Types__3 = require(script.Types);
local u1 = {
    UseBuffers = true,
    DebugOutgoing = false,
    DebugOutgoingInterval = 5,
    DebugOutgoingTop = 10
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__Reads__6 = l__Types__3.Reads;
local l__Writes__7 = l__Types__3.Writes;
local l__Import__8 = l__Types__3.Import;
local l__Export__9 = l__Types__3.Export;
local l__Truncate__10 = l__Types__3.Truncate;
local l__Ended__11 = l__Types__3.Ended;
local l__NumberU8__12 = l__Reads__6.NumberU8;
local l__NumberU8__13 = l__Writes__7.NumberU8;
local l__NumberU16__14 = l__Reads__6.NumberU16;
local l__NumberU16__15 = l__Writes__7.NumberU16;
local u7 = {};
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = {
    BufferLength = 128,
    BufferOffset = 0,
    InstancesOffset = 0,
    Buffer = buffer.create(128),
    Instances = {}
};
local u15 = nil;
local u16 = 0;
local function u28(p17) --[[ Line: 52 ]]
    -- upvalues: u1 (copy), l__RunService__4 (copy), u15 (ref), u16 (ref)
    if u1.DebugOutgoing == true and l__RunService__4:IsServer() == true then
        local v18 = u15;
        if v18 == nil then
            v18 = {};
            u15 = v18;
            u16 = os.clock();
        end;
        v18[p17] = (v18[p17] or 0) + 1;
        local v19 = os.clock();
        if (u1.DebugOutgoingInterval or 5) > v19 - u16 then
        else
            u16 = v19;
            local v20 = {};
            for v21, v22 in v18 do
                v20[#v20 + 1] = { v21, v22 };
            end;
            table.sort(v20, function(p23, p24) --[[ Line: 77 ]]
                return p23[2] > p24[2];
            end);
            local v25 = {};
            for v26 = 1, math.min(u1.DebugOutgoingTop or 10, #v20) do
                local v27 = v20[v26];
                v25[#v25 + 1] = v27[1] .. "=" .. tostring(v27[2]);
            end;
            table.clear(v18);
        end;
    end;
end;
local function v34(_, p29, ...) --[[ Line: 93 ]]
    -- upvalues: u8 (copy), u7 (copy), l__RunService__4 (copy), u13 (ref), l__Signal__1 (copy), u12 (ref), u2 (ref)
    local v30 = u8[p29];
    if v30 then
        return v30;
    end;
    local v31 = setmetatable({}, u7);
    v31.Name = p29;
    if l__RunService__4:IsServer() then
        v31.Id = u13;
        v31.OnServerEvent = l__Signal__1();
        u12:SetAttribute(p29, u13);
        u8[u13] = v31;
        u13 = u13 + 1;
    else
        v31.Id = u12:GetAttribute(p29);
        v31.OnClientEvent = l__Signal__1();
        if v31.Id then
            u8[v31.Id] = v31;
        end;
    end;
    local v32, v33 = u2(table.pack(...));
    v31.Reads = v32;
    v31.Writes = v33;
    u8[v31.Name] = v31;
    return v31;
end;
u7.__index = u7;
u7.Type = "Packet";
function u7.Response(p35, ...) --[[ Line: 119 ]]
    -- upvalues: u2 (ref)
    p35.ResponseTimeout = p35.ResponseTimeout or 10;
    local v36, v37 = u2(table.pack(...));
    p35.ResponseReads = v36;
    p35.ResponseWrites = v37;
    return p35;
end;
function u7.Fire(p38, ...) --[[ Line: 125 ]]
    -- upvalues: u1 (copy), l__RunService__4 (copy), u11 (ref), l__Import__8 (copy), u14 (ref), l__NumberU16__15 (copy), l__NumberU8__13 (copy), l__Task__2 (copy), u6 (ref), u5 (ref), l__Export__9 (copy), u12 (ref)
    if not u1.UseBuffers then
        if not p38.ResponseReads then
            u12:FireServer(p38.Id, ...);
            return;
        end;
        if l__RunService__4:IsServer() then
            error("You must use FireClient(player)", 2);
        end;
        local v39 = nil;
        for _ = 1, 128 do
            v39 = u11[u11.Index];
            if not v39 then
                break;
            end;
            u11.Index = (u11.Index + 1) % 128;
        end;
        if v39 then
            error("Cannot have more than 128 yielded threads", 2);
        end;
        u11[u11.Index] = {
            Yielded = coroutine.running(),
            Timeout = l__Task__2:Delay(p38.ResponseTimeout, u6, u11, u11.Index, p38.ResponseTimeoutValue)
        };
        u12:FireServer(p38.Id, u11.Index, ...);
        u11.Index = (u11.Index + 1) % 128;
        return coroutine.yield();
    end;
    if not p38.ResponseReads then
        l__Import__8(u14);
        l__NumberU16__15(p38.Id);
        u5(p38.Writes, { ... });
        u14 = l__Export__9();
        return;
    end;
    if l__RunService__4:IsServer() then
        error("You must use FireClient(player)", 2);
    end;
    local v40 = nil;
    for _ = 1, 128 do
        v40 = u11[u11.Index];
        if not v40 then
            break;
        end;
        u11.Index = (u11.Index + 1) % 128;
    end;
    if v40 then
        error("Cannot have more than 128 yielded threads", 2);
    end;
    l__Import__8(u14);
    l__NumberU16__15(p38.Id);
    l__NumberU8__13(u11.Index);
    u11[u11.Index] = {
        Yielded = coroutine.running(),
        Timeout = l__Task__2:Delay(p38.ResponseTimeout, u6, u11, u11.Index, p38.ResponseTimeoutValue)
    };
    u11.Index = (u11.Index + 1) % 128;
    u5(p38.Writes, { ... });
    u14 = l__Export__9();
    return coroutine.yield();
end;
function u7.FireClient(p41, p42, ...) --[[ Line: 171 ]]
    -- upvalues: u1 (copy), u28 (copy), u10 (ref), l__Import__8 (copy), u9 (ref), l__NumberU16__15 (copy), l__NumberU8__13 (copy), l__Task__2 (copy), u6 (ref), u5 (ref), l__Export__9 (copy), u12 (ref)
    if p42.Parent == nil then
        return;
    end;
    if u1.UseBuffers then
        if not p41.ResponseReads then
            u28(p41.Name);
            l__Import__8(u9[p42] or {
                BufferLength = 128,
                BufferOffset = 0,
                InstancesOffset = 0,
                Buffer = buffer.create(128),
                Instances = {}
            });
            l__NumberU16__15(p41.Id);
            u5(p41.Writes, { ... });
            u9[p42] = l__Export__9();
            return;
        end;
        u28(p41.Name);
        local v43 = u10[p42];
        if v43 == nil then
            v43 = {
                Index = 0
            };
            u10[p42] = v43;
        end;
        local v44 = nil;
        for _ = 1, 128 do
            v44 = v43[v43.Index];
            if not v44 then
                break;
            end;
            v43.Index = (v43.Index + 1) % 128;
        end;
        if not v44 then
            l__Import__8(u9[p42] or {
                BufferLength = 128,
                BufferOffset = 0,
                InstancesOffset = 0,
                Buffer = buffer.create(128),
                Instances = {}
            });
            l__NumberU16__15(p41.Id);
            l__NumberU8__13(v43.Index);
            v43[v43.Index] = {
                Yielded = coroutine.running(),
                Timeout = l__Task__2:Delay(p41.ResponseTimeout, u6, v43, v43.Index, p41.ResponseTimeoutValue)
            };
            v43.Index = (v43.Index + 1) % 128;
            u5(p41.Writes, { ... });
            u9[p42] = l__Export__9();
            return coroutine.yield();
        end;
        error("Cannot have more than 128 yielded threads", 2);
    else
        if not p41.ResponseReads then
            u28(p41.Name);
            u12:FireClient(p42, p41.Id, ...);
            return;
        end;
        u28(p41.Name);
        local v45 = u10[p42];
        if v45 == nil then
            v45 = {
                Index = 0
            };
            u10[p42] = v45;
        end;
        local v46 = nil;
        for _ = 1, 128 do
            v46 = v45[v45.Index];
            if not v46 then
                break;
            end;
            v45.Index = (v45.Index + 1) % 128;
        end;
        if not v46 then
            v45[v45.Index] = {
                Yielded = coroutine.running(),
                Timeout = l__Task__2:Delay(p41.ResponseTimeout, u6, v45, v45.Index, p41.ResponseTimeoutValue)
            };
            u12:FireClient(p42, p41.Id, v45.Index, ...);
            v45.Index = (v45.Index + 1) % 128;
            return coroutine.yield();
        end;
        error("Cannot have more than 128 yielded threads", 2);
    end;
end;
function u7.FireAllClients(p47, ...) --[[ Line: 221 ]]
    -- upvalues: l__RunService__4 (copy), u1 (copy), u28 (copy), l__Import__8 (copy), u14 (ref), l__NumberU16__15 (copy), u5 (ref), l__Export__9 (copy), u12 (ref)
    if not l__RunService__4:IsServer() then
        error("FireAllClients can only be called from the server", 2);
    end;
    if p47.ResponseReads then
        error("Cannot use FireAllClients with packets that expect a response", 2);
    end;
    if u1.UseBuffers then
        u28(p47.Name);
        l__Import__8(u14);
        l__NumberU16__15(p47.Id);
        u5(p47.Writes, { ... });
        u14 = l__Export__9();
    else
        u28(p47.Name);
        u12:FireAllClients(p47.Id, ...);
    end;
end;
function u7.Serialize(p48, ...) --[[ Line: 236 ]]
    -- upvalues: l__Import__8 (copy), u5 (ref), l__Truncate__10 (copy)
    l__Import__8({
        BufferLength = 128,
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = buffer.create(128),
        Instances = {}
    });
    u5(p48.Writes, { ... });
    return l__Truncate__10();
end;
function u7.Deserialize(p49, p50, p51) --[[ Line: 242 ]]
    -- upvalues: l__Import__8 (copy), u4 (ref)
    l__Import__8({
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = p50,
        BufferLength = buffer.len(p50),
        Instances = p51 or {}
    });
    return u4(p49.Reads);
end;
u2 = function(p52) --[[ Name: ParametersToFunctions, Line 249 ]]
    -- upvalues: u3 (ref), l__Reads__6 (copy), l__Writes__7 (copy)
    local v53 = table.create(#p52);
    local v54 = table.create(#p52);
    for v55, v56 in ipairs(p52) do
        if type(v56) == "table" then
            local v57, v58 = u3(v56);
            v53[v55] = v57;
            v54[v55] = v58;
        else
            local v59 = l__Reads__6[v56];
            local v60 = l__Writes__7[v56];
            v53[v55] = v59;
            v54[v55] = v60;
        end;
    end;
    return v53, v54;
end;
u3 = function(p61) --[[ Name: TableToFunctions, Line 261 ]]
    -- upvalues: u3 (ref), l__Reads__6 (copy), l__Writes__7 (copy), l__NumberU16__14 (copy), l__NumberU16__15 (copy)
    if #p61 == 1 then
        local v62 = p61[1];
        local u63, u64;
        if type(v62) == "table" then
            u63, u64 = u3(v62);
        else
            u63 = l__Reads__6[v62];
            u64 = l__Writes__7[v62];
        end;
        return function() --[[ Line: 270 ]]
            -- upvalues: l__NumberU16__14 (ref), u63 (ref)
            local v65 = l__NumberU16__14();
            local v66 = table.create(v65);
            for v67 = 1, v65 do
                v66[v67] = u63();
            end;
            return v66;
        end, function(p68) --[[ Line: 276 ]]
            -- upvalues: l__NumberU16__15 (ref), u64 (ref)
            l__NumberU16__15(#p68);
            for _, v69 in p68 do
                u64(v69);
            end;
        end;
    end;
    local u70 = {};
    for v71, _ in p61 do
        table.insert(u70, v71);
    end;
    table.sort(u70);
    local u72 = table.create(#u70);
    local u73 = table.create(#u70);
    for v74, v75 in u70 do
        local v76 = p61[v75];
        if type(v76) == "table" then
            local v77, v78 = u3(v76);
            u72[v74] = v77;
            u73[v74] = v78;
        else
            local v79 = l__Reads__6[v76];
            local v80 = l__Writes__7[v76];
            u72[v74] = v79;
            u73[v74] = v80;
        end;
    end;
    return function() --[[ Line: 292 ]]
        -- upvalues: u72 (copy), u70 (copy)
        local v81 = {};
        for v82, v83 in u72 do
            v81[u70[v82]] = v83();
        end;
        return v81;
    end, function(p84) --[[ Line: 297 ]]
        -- upvalues: u73 (copy), u70 (copy)
        for v85, v86 in u73 do
            v86(p84[u70[v85]]);
        end;
    end;
end;
u4 = function(p87) --[[ Name: ReadParameters, Line 304 ]]
    local v88 = table.create(#p87);
    for v89, v90 in p87 do
        v88[v89] = v90();
    end;
    return table.unpack(v88);
end;
u5 = function(p91, p92) --[[ Name: WriteParameters, Line 310 ]]
    for v93, v94 in p91 do
        v94(p92[v93]);
    end;
end;
u6 = function(p95, p96, p97) --[[ Name: Timeout, Line 314 ]]
    local v98 = p95[p96];
    if v98 then
        pcall(task.defer, v98.Yielded, p97);
        p95[p96] = nil;
    end;
end;
if l__RunService__4:IsServer() then
    u9 = {};
    u10 = {};
    u13 = 0;
    u12 = Instance.new("RemoteEvent", script);
    local u99 = {};
    local u104 = task.spawn(function() --[[ Line: 340 ]]
        -- upvalues: u14 (ref), u12 (ref), u9 (ref), u99 (copy)
        while true do
            coroutine.yield();
            if u14.BufferOffset > 0 then
                local v100 = buffer.create(u14.BufferOffset);
                buffer.copy(v100, 0, u14.Buffer, 0, u14.BufferOffset);
                if u14.InstancesOffset == 0 then
                    u12:FireAllClients(v100);
                else
                    u12:FireAllClients(v100, u14.Instances);
                    u14.InstancesOffset = 0;
                    table.clear(u14.Instances);
                end;
                u14.BufferOffset = 0;
            end;
            for v101, v102 in u9 do
                local v103 = buffer.create(v102.BufferOffset);
                buffer.copy(v103, 0, v102.Buffer, 0, v102.BufferOffset);
                if v102.InstancesOffset == 0 then
                    u12:FireClient(v101, v103);
                else
                    u12:FireClient(v101, v103, v102.Instances);
                end;
            end;
            table.clear(u9);
            table.clear(u99);
        end;
    end);
    local function u109(p105, p106, p107, ...) --[[ Line: 369 ]]
        -- upvalues: l__RunService__4 (copy), l__Import__8 (copy), u9 (ref), l__NumberU16__15 (copy), l__NumberU8__13 (copy), u5 (ref), l__Export__9 (copy)
        if p105.OnServerInvoke == nil then
            l__RunService__4:IsStudio();
        else
            local v108 = { p105.OnServerInvoke(p106, ...) };
            if p106.Parent == nil then
            else
                l__Import__8(u9[p106] or {
                    BufferLength = 128,
                    BufferOffset = 0,
                    InstancesOffset = 0,
                    Buffer = buffer.create(128),
                    Instances = {}
                });
                l__NumberU16__15(p105.Id);
                l__NumberU8__13(p107 + 128);
                u5(p105.ResponseWrites, v108);
                u9[p106] = l__Export__9();
            end;
        end;
    end;
    local function u120(p110, p111, p112) --[[ Line: 380 ]]
        -- upvalues: u99 (copy), l__RunService__4 (copy), l__Import__8 (copy), l__Ended__11 (copy), l__NumberU16__14 (copy), u8 (copy), l__NumberU8__12 (copy), l__Task__2 (copy), u109 (copy), u4 (ref), u10 (ref)
        local v113 = u99[p110] or 0;
        local v114 = buffer.len(p111);
        local v115 = v113 + math.max(v114, 800);
        if v115 > 8000 then
            l__RunService__4:IsStudio();
        else
            u99[p110] = v115;
            l__Import__8({
                BufferOffset = 0,
                InstancesOffset = 0,
                Buffer = p111,
                BufferLength = buffer.len(p111),
                Instances = p112 or {}
            });
            while true do
                local v116 = l__Ended__11() == false and u8[l__NumberU16__14()];
                if not v116 then
                    break;
                end;
                if v116.ResponseReads then
                    local v117 = l__NumberU8__12();
                    if v117 < 128 then
                        l__Task__2:Defer(u109, v116, p110, v117, u4(v116.Reads));
                    else
                        local v118 = v117 - 128;
                        local v119 = u10[p110][v118];
                        if v119 then
                            task.cancel(v119.Timeout);
                            task.defer(v119.Yielded, u4(v116.ResponseReads));
                            u10[p110][v118] = nil;
                        elseif not l__RunService__4:IsStudio() then
                            u4(v116.ResponseReads);
                        end;
                    end;
                else
                    v116.OnServerEvent:Fire(p110, u4(v116.Reads));
                end;
            end;
        end;
    end;
    local function u125(p121, p122, p123, ...) --[[ Line: 413 ]]
        -- upvalues: l__RunService__4 (copy), u12 (ref)
        if p121.OnServerInvoke == nil then
            l__RunService__4:IsStudio();
        else
            local v124 = { p121.OnServerInvoke(p122, ...) };
            if p122.Parent == nil then
            else
                u12:FireClient(p122, p121.Id, p123 + 128, table.unpack(v124));
            end;
        end;
    end;
    local function u130(p126, p127, ...) --[[ Line: 420 ]]
        -- upvalues: u8 (copy), l__Task__2 (copy), u125 (copy)
        local v128 = u8[p127];
        if v128 then
            if v128.ResponseReads then
                local v129 = { ... };
                l__Task__2:Defer(u125, v128, p126, table.remove(v129, 1), table.unpack(v129));
            else
                v128.OnServerEvent:Fire(p126, ...);
            end;
        end;
    end;
    u12.OnServerEvent:Connect(function(p131, p132, ...) --[[ Line: 432 ]]
        -- upvalues: u120 (copy), u130 (copy)
        local v133, v134;
        if typeof(p132) == "buffer" then
            v133, v134 = pcall(u120, p131, p132, ...);
        else
            v133, v134 = pcall(u130, p131, p132, ...);
        end;
        if not v133 then
            warn((`[Packet] Server event handler errored for {p131.Name}: {v134}`));
        end;
    end);
    l__Players__5.PlayerRemoving:Connect(function(p135) --[[ Line: 444 ]]
        -- upvalues: u9 (ref), u10 (ref), u99 (copy)
        u9[p135] = nil;
        u10[p135] = nil;
        u99[p135] = nil;
    end);
    if u1.UseBuffers then
        l__RunService__4.Heartbeat:Connect(function(_) --[[ Line: 451 ]]
            -- upvalues: u104 (copy)
            task.defer(u104);
        end);
    end;
else
    u11 = {
        Index = 0
    };
    u12 = script:WaitForChild("RemoteEvent");
    local u136 = 0;
    local u138 = task.spawn(function() --[[ Line: 458 ]]
        -- upvalues: u14 (ref), u12 (ref)
        while true do
            repeat
                coroutine.yield();
            until u14.BufferOffset > 0;
            local v137 = buffer.create(u14.BufferOffset);
            buffer.copy(v137, 0, u14.Buffer, 0, u14.BufferOffset);
            if u14.InstancesOffset == 0 then
                u12:FireServer(v137);
            else
                u12:FireServer(v137, u14.Instances);
                u14.InstancesOffset = 0;
                table.clear(u14.Instances);
            end;
            u14.BufferOffset = 0;
        end;
    end);
    local function u142(p139, p140, ...) --[[ Line: 476 ]]
        -- upvalues: l__Import__8 (copy), u14 (ref), l__NumberU16__15 (copy), l__NumberU8__13 (copy), u5 (ref), l__Export__9 (copy)
        if p139.OnClientInvoke == nil then
        else
            local v141 = { p139.OnClientInvoke(...) };
            l__Import__8(u14);
            l__NumberU16__15(p139.Id);
            l__NumberU8__13(p140 + 128);
            u5(p139.ResponseWrites, v141);
            u14 = l__Export__9();
        end;
    end;
    local function u146(p143, p144, ...) --[[ Line: 486 ]]
        -- upvalues: u12 (ref)
        if p143.OnClientInvoke == nil then
        else
            local v145 = { p143.OnClientInvoke(...) };
            u12:FireServer(p143.Id, p144 + 128, table.unpack(v145));
        end;
    end;
    local function u153(p147, ...) --[[ Line: 492 ]]
        -- upvalues: u8 (copy), l__Task__2 (copy), u146 (copy), u11 (ref)
        local v148 = u8[p147];
        if v148 then
            if v148.ResponseReads then
                local v149 = { ... };
                local v150 = table.remove(v149, 1);
                if v150 < 128 then
                    l__Task__2:Defer(u146, v148, v150, table.unpack(v149));
                    return;
                end;
                local v151 = v150 - 128;
                local v152 = u11[v151];
                if v152 then
                    task.cancel(v152.Timeout);
                    pcall(task.defer, v152.Yielded, table.unpack(v149));
                    u11[v151] = nil;
                end;
            else
                v148.OnClientEvent:Fire(...);
            end;
        end;
    end;
    u12.OnClientEvent:Connect(function(p154, ...) --[[ Line: 519 ]]
        -- upvalues: l__Import__8 (copy), l__Ended__11 (copy), u8 (copy), l__NumberU16__14 (copy), l__NumberU8__12 (copy), l__Task__2 (copy), u142 (copy), u4 (ref), u11 (ref), u153 (copy)
        if typeof(p154) == "buffer" then
            local v155 = select(1, ...);
            l__Import__8({
                BufferOffset = 0,
                InstancesOffset = 0,
                Buffer = p154,
                BufferLength = buffer.len(p154),
                Instances = v155 or {}
            });
            while l__Ended__11() == false do
                local v156 = u8[l__NumberU16__14()];
                if v156.ResponseReads then
                    local v157 = l__NumberU8__12();
                    if v157 < 128 then
                        l__Task__2:Defer(u142, v156, v157, u4(v156.Reads));
                    else
                        local v158 = v157 - 128;
                        local v159 = u11[v158];
                        if v159 then
                            task.cancel(v159.Timeout);
                            pcall(task.defer, v159.Yielded, u4(v156.ResponseReads));
                            u11[v158] = nil;
                        end;
                    end;
                else
                    v156.OnClientEvent:Fire(u4(v156.Reads));
                end;
            end;
        else
            u153(p154, ...);
        end;
    end);
    u12.AttributeChanged:Connect(function(p160) --[[ Line: 556 ]]
        -- upvalues: u8 (copy), u12 (ref)
        local v161 = u8[p160];
        if v161 then
            if v161.Id then
                u8[v161.Id] = nil;
            end;
            v161.Id = u12:GetAttribute(p160);
            if v161.Id then
                u8[v161.Id] = v161;
            end;
        end;
    end);
    if u1.UseBuffers then
        l__RunService__4.Heartbeat:Connect(function(p162) --[[ Line: 566 ]]
            -- upvalues: u136 (ref), u138 (copy)
            u136 = u136 + p162;
            if u136 > 0.016666666666666666 then
                u136 = u136 % 0.016666666666666666;
                task.defer(u138);
            end;
        end);
    end;
end;
local v163 = setmetatable(l__Types__3.Types, {
    __call = v34
});
v163.Settings = u1;
return v163;