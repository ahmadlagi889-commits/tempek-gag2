-- Decompiled with Potassium's decompiler.

local l__Heartbeat__1 = game:GetService("RunService").Heartbeat;
local u1 = newproxy(true);
getmetatable(u1).__tostring = function() --[[ Line: 31 ]]
    return "IndicesReference";
end;
local u2 = newproxy(true);
getmetatable(u2).__tostring = function() --[[ Line: 36 ]]
    return "LinkToInstanceIndex";
end;
local u3 = {
    IGNORE_MEMORY_DEBUG = true,
    ClassName = "Janitor",
    __index = {
        CurrentlyCleaning = true,
        [u1] = nil
    }
};
local u4 = {
    ["function"] = true,
    Promise = "cancel",
    RBXScriptConnection = "Disconnect"
};
function u3.new() --[[ Line: 58 ]]
    -- upvalues: u1 (copy), u3 (copy)
    return setmetatable({
        CurrentlyCleaning = false,
        [u1] = nil
    }, u3);
end;
function u3.Is(p5) --[[ Line: 65 ]]
    -- upvalues: u3 (copy)
    local v6;
    if type(p5) == "table" then
        v6 = getmetatable(p5) == u3;
    else
        v6 = false;
    end;
    return v6;
end;
u3.is = u3.Is;
function u3.__index.Add(p7, p8, p9, p10) --[[ Line: 71 ]]
    -- upvalues: u1 (copy), u4 (copy)
    if p10 then
        p7:Remove(p10);
        local v11 = p7[u1];
        if not v11 then
            v11 = {};
            p7[u1] = v11;
        end;
        v11[p10] = p8;
    end;
    local v12 = typeof(p8);
    local v13 = p9 or (u4[v12 == "table" and string.match(tostring(p8), "Promise") and "Promise" or v12] or "Destroy");
    if type(p8) ~= "function" then
        local _ = p8[v13];
    end;
    p7[p8] = { v13, (debug.traceback("")) };
    return p8;
end;
u3.__index.Give = u3.__index.Add;
function u3.__index.AddPromise(p14, u15) --[[ Line: 101 ]]
    local v16 = false;
    if not v16 then
        return u15;
    end;
    if not v16.is(u15) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s))", typeof(u15), (tostring(u15))));
    end;
    if u15:getStatus() ~= v16.Status.Started then
        return u15;
    end;
    local v17 = newproxy(false);
    local v20 = p14:Add(v16.new(function(p18, _, p19) --[[ Line: 109 ]]
        -- upvalues: u15 (copy)
        if p19(function() --[[ Line: 110 ]]
            -- upvalues: u15 (ref)
            u15:cancel();
        end) then
        else
            p18(u15);
        end;
    end), "cancel", v17);
    v20:finallyCall(p14.Remove, p14, v17);
    return v20;
end;
u3.__index.GivePromise = u3.__index.AddPromise;
function u3.__index.AddObject(p21, p22) --[[ Line: 131 ]]
    local v23 = newproxy(false);
    local v24 = false;
    if not (v24 and v24.is(p22)) then
        return p21:Add(p22, false, v23), v23;
    end;
    if p22:getStatus() ~= v24.Status.Started then
        return p22;
    end;
    local v25 = p21:Add(v24.resolve(p22), "cancel", v23);
    v25:finallyCall(p21.Remove, p21, v23);
    return v25, v23;
end;
u3.__index.GiveObject = u3.__index.AddObject;
function u3.__index.Remove(p26, p27) --[[ Line: 149 ]]
    -- upvalues: u1 (copy)
    local v28 = p26[u1];
    local v29 = v28 and v28[p27];
    if v29 then
        local v30 = p26[v29];
        if v30 then
            v30 = v30[1];
        end;
        if v30 then
            if v30 == true then
                v29();
            else
                local v31 = v29[v30];
                if v31 then
                    v31(v29);
                end;
            end;
            p26[v29] = nil;
        end;
        v28[p27] = nil;
    end;
    return p26;
end;
function u3.__index.Get(p32, p33) --[[ Line: 178 ]]
    -- upvalues: u1 (copy)
    local v34 = p32[u1];
    if v34 then
        return v34[p33];
    else
        return nil;
    end;
end;
function u3.__index.Cleanup(p35) --[[ Line: 186 ]]
    -- upvalues: u1 (copy)
    if not p35.CurrentlyCleaning then
        p35.CurrentlyCleaning = nil;
        for v36, v37 in next, p35 do
            if v36 ~= u1 then
                local v38 = type(v36);
                if v38 == "string" or v38 == "number" then
                    p35[v36] = nil;
                else
                    local v39 = v37[1];
                    local _ = v37[2];
                    if v39 == true then
                        local v40, _ = pcall(v36);
                        if not v40 then
                            debug.traceback("", 3);
                        end;
                    else
                        local v41 = v36[v39];
                        if v41 then
                            local v42, _ = pcall(v41, v36);
                            local v43;
                            if typeof(v36) == "Instance" then
                                v43 = v41 == "Destroy";
                            else
                                v43 = false;
                            end;
                            if not (v42 or v43) then
                                debug.traceback("", 3);
                            end;
                        end;
                    end;
                    p35[v36] = nil;
                end;
            end;
        end;
        local v44 = p35[u1];
        if v44 then
            for v45 in next, v44 do
                v44[v45] = nil;
            end;
            p35[u1] = {};
        end;
        p35.CurrentlyCleaning = false;
    end;
end;
u3.__index.Clean = u3.__index.Cleanup;
function u3.__index.Destroy(p46) --[[ Line: 241 ]]
    p46:Cleanup();
end;
u3.__call = u3.__index.Cleanup;
local u47 = {
    Connected = true
};
u47.__index = u47;
function u47.Disconnect(p48) --[[ Line: 251 ]]
    if p48.Connected then
        p48.Connected = false;
        p48.Connection:Disconnect();
    end;
end;
function u47.__tostring(p49) --[[ Line: 258 ]]
    return "Disconnect<" .. tostring(p49.Connected) .. ">";
end;
function u3.__index.LinkToInstance(u50, p51, p52) --[[ Line: 262 ]]
    -- upvalues: u2 (copy), u47 (copy), l__Heartbeat__1 (copy)
    local u53 = nil;
    local v54 = p52 and newproxy(false) or u2;
    local u55 = p51.Parent == nil;
    local u56 = setmetatable({}, u47);
    local u58 = p51.AncestryChanged:Connect(function(_, p57) --[[ Name: ChangedFunction, Line 268 ]]
        -- upvalues: u56 (copy), u55 (ref), l__Heartbeat__1 (ref), u53 (ref), u50 (copy)
        u55 = u56.Connected and p57 == nil;
        if u55 then
            coroutine.wrap(function() --[[ Line: 274 ]]
                -- upvalues: l__Heartbeat__1 (ref), u56 (ref), u53 (ref), u50 (ref), u55 (ref)
                l__Heartbeat__1:Wait();
                if u56.Connected then
                    if u53.Connected then
                        while u55 and (u53.Connected and u56.Connected) do
                            l__Heartbeat__1:Wait();
                        end;
                        if u56.Connected and u55 then
                            u50:Cleanup();
                        end;
                    else
                        u50:Cleanup();
                    end;
                end;
            end)();
        end;
    end);
    u56.Connection = u58;
    if u55 then
        local l__Parent__2 = p51.Parent;
        if u56.Connected then
            if l__Parent__2 == nil then
                u55 = true;
            else
                u55 = false;
            end;
            if u55 then
                coroutine.wrap(function() --[[ Line: 274 ]]
                    -- upvalues: l__Heartbeat__1 (ref), u56 (copy), u58 (ref), u50 (copy), u55 (ref)
                    l__Heartbeat__1:Wait();
                    if u56.Connected then
                        if u58.Connected then
                            while u55 and (u58.Connected and u56.Connected) do
                                l__Heartbeat__1:Wait();
                            end;
                            if u56.Connected and u55 then
                                u50:Cleanup();
                            end;
                        else
                            u50:Cleanup();
                        end;
                    end;
                end)();
            end;
        end;
    end;
    return u50:Add(u56, "Disconnect", v54);
end;
function u3.__index.LinkToInstances(p59, ...) --[[ Line: 305 ]]
    -- upvalues: u3 (copy)
    local v60 = u3.new();
    for _, v61 in ipairs({ ... }) do
        v60:Add(p59:LinkToInstance(v61, true), "Disconnect");
    end;
    return v60;
end;
for v62, v63 in next, u3.__index do
    local v64 = string.lower(v62);
    local v65 = string.sub(v64, 1, 1) .. string.sub(v62, 2);
    u3.__index[v65] = v63;
end;
return u3;