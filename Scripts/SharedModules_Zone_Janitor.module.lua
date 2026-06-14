-- Decompiled with Potassium's decompiler.

local l__Heartbeat__1 = game:GetService("RunService").Heartbeat;
local u1 = newproxy(true);
getmetatable(u1).__tostring = function() --[[ Line: 11 ]]
    return "IndicesReference";
end;
local u2 = newproxy(true);
getmetatable(u2).__tostring = function() --[[ Line: 16 ]]
    return "LinkToInstanceIndex";
end;
local u3 = {
    ClassName = "Janitor",
    __index = {
        CurrentlyCleaning = true,
        [u1] = nil
    }
};
local u4 = {
    ["function"] = true,
    RBXScriptConnection = "Disconnect"
};
function u3.new() --[[ Line: 40 ]]
    -- upvalues: u1 (copy), u3 (copy)
    return setmetatable({
        CurrentlyCleaning = false,
        [u1] = nil
    }, u3);
end;
function u3.Is(p5) --[[ Line: 52 ]]
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
function u3.__index.Add(p7, p8, p9, p10) --[[ Line: 65 ]]
    -- upvalues: u1 (copy), u4 (copy)
    if p10 == nil then
        p10 = newproxy(false);
    end;
    if p10 then
        p7:Remove(p10);
        local v11 = p7[u1];
        if not v11 then
            v11 = {};
            p7[u1] = v11;
        end;
        v11[p10] = p8;
    end;
    local v12 = p9 or (u4[typeof(p8)] or "Destroy");
    if type(p8) ~= "function" then
        local _ = p8[v12];
    end;
    p7[p8] = v12;
    return p8, p10;
end;
u3.__index.Give = u3.__index.Add;
function u3.__index.AddObject(p13, p14) --[[ Line: 130 ]]
    local v15 = newproxy(false);
    return p13:Add(p14, false, v15), v15;
end;
u3.__index.GiveObject = u3.__index.AddObject;
function u3.__index.Remove(p16, p17) --[[ Line: 154 ]]
    -- upvalues: u1 (copy)
    local v18 = p16[u1];
    local v19 = v18 and v18[p17];
    if v19 then
        local v20 = p16[v19];
        if v20 then
            if v20 == true then
                v19();
            else
                local v21 = v19[v20];
                if v21 then
                    v21(v19);
                end;
            end;
            p16[v19] = nil;
        end;
        v18[p17] = nil;
    end;
    return p16;
end;
function u3.__index.Get(p22, p23) --[[ Line: 188 ]]
    -- upvalues: u1 (copy)
    local v24 = p22[u1];
    if v24 then
        return v24[p23];
    end;
end;
function u3.__index.Cleanup(p25) --[[ Line: 199 ]]
    -- upvalues: u1 (copy)
    if not p25.CurrentlyCleaning then
        p25.CurrentlyCleaning = nil;
        for v26, v27 in next, p25 do
            if v26 ~= u1 then
                local v28 = type(v26);
                if v28 == "string" or v28 == "number" then
                    p25[v26] = nil;
                else
                    if v27 == true then
                        v26();
                    else
                        local v29 = v26[v27];
                        if v29 then
                            v29(v26);
                        end;
                    end;
                    p25[v26] = nil;
                end;
            end;
        end;
        local v30 = p25[u1];
        if v30 then
            for v31 in next, v30 do
                v30[v31] = nil;
            end;
            p25[u1] = {};
        end;
        p25.CurrentlyCleaning = false;
    end;
end;
u3.__index.Clean = u3.__index.Cleanup;
function u3.__index.Destroy(p32) --[[ Line: 245 ]]
    p32:Cleanup();
end;
u3.__call = u3.__index.Cleanup;
local u33 = {
    Connected = true
};
u33.__index = u33;
function u33.Disconnect(p34) --[[ Line: 259 ]]
    if p34.Connected then
        p34.Connected = false;
        p34.Connection:Disconnect();
    end;
end;
function u33.__tostring(p35) --[[ Line: 266 ]]
    return "Disconnect<" .. tostring(p35.Connected) .. ">";
end;
function u3.__index.LinkToInstance(u36, p37, p38) --[[ Line: 276 ]]
    -- upvalues: u2 (copy), u33 (copy), l__Heartbeat__1 (copy)
    local u39 = nil;
    local v40 = p38 and newproxy(false) or u2;
    local u41 = p37.Parent == nil;
    local u42 = setmetatable({}, u33);
    local u44 = p37.AncestryChanged:Connect(function(_, p43) --[[ Name: ChangedFunction, Line 282 ]]
        -- upvalues: u42 (copy), u41 (ref), l__Heartbeat__1 (ref), u39 (ref), u36 (copy)
        u41 = u42.Connected and p43 == nil;
        if u41 then
            coroutine.wrap(function() --[[ Line: 288 ]]
                -- upvalues: l__Heartbeat__1 (ref), u42 (ref), u39 (ref), u36 (ref), u41 (ref)
                l__Heartbeat__1:Wait();
                if u42.Connected then
                    if u39.Connected then
                        while u41 and (u39.Connected and u42.Connected) do
                            l__Heartbeat__1:Wait();
                        end;
                        if u42.Connected and u41 then
                            u36:Cleanup();
                        end;
                    else
                        u36:Cleanup();
                    end;
                end;
            end)();
        end;
    end);
    u42.Connection = u44;
    if u41 then
        local l__Parent__2 = p37.Parent;
        if u42.Connected then
            if l__Parent__2 == nil then
                u41 = true;
            else
                u41 = false;
            end;
            if u41 then
                coroutine.wrap(function() --[[ Line: 288 ]]
                    -- upvalues: l__Heartbeat__1 (ref), u42 (copy), u44 (ref), u36 (copy), u41 (ref)
                    l__Heartbeat__1:Wait();
                    if u42.Connected then
                        if u44.Connected then
                            while u41 and (u44.Connected and u42.Connected) do
                                l__Heartbeat__1:Wait();
                            end;
                            if u42.Connected and u41 then
                                u36:Cleanup();
                            end;
                        else
                            u36:Cleanup();
                        end;
                    end;
                end)();
            end;
        end;
    end;
    return u36:Add(u42, "Disconnect", v40);
end;
function u3.__index.LinkToInstances(p45, ...) --[[ Line: 324 ]]
    -- upvalues: u3 (copy)
    local v46 = u3.new();
    for _, v47 in ipairs({ ... }) do
        v46:Add(p45:LinkToInstance(v47, true), "Disconnect");
    end;
    return v46;
end;
for v48, v49 in next, u3.__index do
    local v50 = string.lower(v48);
    local v51 = string.sub(v50, 1, 1) .. string.sub(v48, 2);
    u3.__index[v51] = v49;
end;
return u3;