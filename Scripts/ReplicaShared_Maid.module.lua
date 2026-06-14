-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 43 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local function u5(...) --[[ Line: 51 ]]
    -- upvalues: u4 (copy)
    u4(...);
    while true do
        u4(coroutine.yield());
    end;
end;
local function u8(p6, ...) --[[ Line: 58 ]]
    local v7 = typeof(p6);
    if v7 == "function" then
        p6(...);
    elseif v7 == "RBXScriptConnection" then
        p6:Disconnect();
    elseif v7 == "Instance" then
        p6:Destroy();
    else
        if v7 == "table" then
            if type(p6.Destroy) == "function" then
                p6:Destroy();
                return;
            end;
            if type(p6.Disconnect) == "function" then
                p6:Disconnect();
            end;
        end;
    end;
end;
local function u9(...) --[[ Line: 78 ]]
    -- upvalues: u1 (ref), u5 (copy), u8 (copy)
    if not u1 then
        u1 = coroutine.create(u5);
    end;
    task.spawn(assert(u1), u8, ...);
end;
local u10 = {};
u10.__index = u10;
function u10.New(p11, p12) --[[ Line: 103 ]]
    -- upvalues: u10 (copy)
    local v13 = {
        maid = p11,
        object = p12
    };
    setmetatable(v13, u10);
    return v13;
end;
function u10.Destroy(p14) --[[ Line: 116 ]]
    p14.maid.tokens[p14] = nil;
end;
function u10.Cleanup(p15, ...) --[[ Line: 120 ]]
    -- upvalues: u9 (copy)
    if p15.object == nil then
    else
        p15.maid.tokens[p15] = nil;
        u9(p15.object, ...);
        p15.object = nil;
    end;
end;
local u16 = {};
u16.__index = u16;
function u16.New(p17) --[[ Line: 135 ]]
    -- upvalues: u16 (copy)
    local v18 = {
        is_cleaned = false,
        tokens = {},
        key = p17
    };
    setmetatable(v18, u16);
    return v18;
end;
function u16.IsActive(p19) --[[ Line: 149 ]]
    return not p19.is_cleaned;
end;
function u16.Add(p20, p21) --[[ Line: 153 ]]
    -- upvalues: u9 (copy), u10 (copy)
    if p20.is_cleaned == true then
        u9(p21);
    end;
    local v22 = typeof(p21);
    if v22 == "table" then
        if type(p21.Destroy) ~= "function" and type(p21.Disconnect) ~= "function" then
            error((`[{script.Name}]: Received table as cleanup object, but couldn't detect a :Destroy() or :Disconnect() method`));
        end;
    elseif v22 ~= "function" and (v22 ~= "RBXScriptConnection" and v22 ~= "Instance") then
        error((`[{script.Name}]: Cleanup of type "{v22}" not supported`));
    end;
    local v23 = u10.New(p20, p21);
    p20.tokens[v23] = true;
    return v23;
end;
function u16.Cleanup(p24, ...) --[[ Line: 176 ]]
    if p24.key ~= nil then
        error((`[{script.Name}]: "Cleanup()" is locked for this Maid`));
    end;
    p24.is_cleaned = true;
    for v25 in pairs(p24.tokens) do
        v25:Cleanup(...);
    end;
end;
function u16.Unlock(p26, p27) --[[ Line: 190 ]]
    if p26.key ~= nil and p26.key ~= p27 then
        error((`[{script.Name}]: Invalid lock key`));
    end;
    p26.key = nil;
end;
return u16;