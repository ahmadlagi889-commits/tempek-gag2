-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
game:GetService("Players");
assert(l__RunService__2:IsClient());
local l__Bindable__3 = require(l__ReplicatedStorage__1.UserGenerated.Concurrency.Bindable);
local l__SharedFastFlags__4 = require(l__ReplicatedStorage__1.UserGenerated.FastFlags.SharedFastFlags);
local l__Asserts__5 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local l__DeepEqualsPureUnsafe__6 = require(l__ReplicatedStorage__1.UserGenerated.Collections.DeepEqualsPureUnsafe);
local l__DeepCopyPureUnsafe__7 = require(l__ReplicatedStorage__1.UserGenerated.Collections.DeepCopyPureUnsafe);
local l__DeepFreezeUnsafe__8 = require(l__ReplicatedStorage__1.UserGenerated.Collections.DeepFreezeUnsafe);
local l__ObjectPaths__9 = require(l__ReplicatedStorage__1.UserGenerated.Strings.ObjectPaths);
local v1 = {};
local u2 = table.freeze({
    __index = v1
});
function v1.Get(p3) --[[ Line: 48 ]]
    return p3.Value;
end;
function v1.GetAsync(p4) --[[ Line: 51 ]]
    if p4.ValueLoaded then
        return p4.Value;
    end;
    local u5 = coroutine.running();
    local v6 = p4.Loaded:Connect(function() --[[ Line: 56 ]]
        -- upvalues: u5 (copy)
        task.spawn(u5);
    end);
    coroutine.yield();
    v6:Disconnect();
    return p4.Value;
end;
function v1.IsLoaded(p7) --[[ Line: 63 ]]
    return p7.ValueLoaded;
end;
table.freeze(v1);
local l__NullValue__10 = l__SharedFastFlags__4.NullValue;
local l__UpdateRemote__11 = l__SharedFastFlags__4.UpdateRemote;
local u8 = {};
local u9 = false;
local u10 = {};
local u11 = l__Bindable__3.new();
local function u23(p12, p13, p14) --[[ Line: 141 ]]
    -- upvalues: l__Asserts__5 (copy), l__DeepCopyPureUnsafe__7 (copy), l__DeepFreezeUnsafe__8 (copy), u8 (copy), l__ObjectPaths__9 (copy), u10 (ref), l__NullValue__10 (copy), u9 (ref), l__Bindable__3 (copy), u2 (copy)
    l__Asserts__5.String(p12);
    l__Asserts__5.Function(p13);
    p13(p14);
    l__Asserts__5.Storable(p14);
    local v15 = l__DeepCopyPureUnsafe__7(p14);
    l__DeepFreezeUnsafe__8(v15);
    local v16 = not u8[p12];
    local v17 = `ConflictingKeys: {p12}, {p12}`;
    assert(v16, v17);
    for v18, _ in pairs(u8) do
        if l__ObjectPaths__9.HasHierarchicalOverlap(p12, v18) then
            error((`ConflictingKeys: {p12}, {v18}`));
        end;
    end;
    local v19 = u10[p12];
    local v20;
    if v19 == nil then
        v19 = v15;
        v20 = false;
    else
        if v19 == l__NullValue__10 then
            v19 = nil;
        end;
        v20 = u9;
    end;
    local v21 = {
        Replicated = true,
        Changed = l__Bindable__3.new(),
        Loaded = l__Bindable__3.new(),
        Key = p12,
        DefaultValue = v15,
        Assertion = p13,
        ValueLoaded = v20,
        Value = v19
    };
    local v22 = setmetatable(v21, u2);
    u8[p12] = v22;
    return v22;
end;
local v33 = {
    Loaded = u11,
    IsA = function(p24) --[[ Name: IsA, Line 67 ]]
        -- upvalues: u2 (copy)
        local v25;
        if type(p24) == "table" then
            v25 = getmetatable(p24) == u2;
        else
            v25 = false;
        end;
        return v25;
    end,
    Assert = function(p26) --[[ Name: Assert, Line 71 ]]
        -- upvalues: u2 (copy)
        local v27;
        if type(p26) == "table" then
            v27 = getmetatable(p26) == u2;
        else
            v27 = false;
        end;
        if not v27 then
            error("FastFlag", 2);
        end;
        return p26;
    end,
    Replicated = function(p28, p29, p30) --[[ Name: Replicated, Line 197 ]]
        -- upvalues: u23 (copy)
        return u23(p28, p29, p30);
    end,
    Private = function(_, _, _) --[[ Name: Private, Line 205 ]]
        error("ServerOnly");
    end,
    Get = function(p31) --[[ Name: Get, Line 213 ]]
        -- upvalues: u8 (copy), l__Asserts__5 (copy)
        local v32 = u8[p31];
        if v32 then
            return v32;
        end;
        l__Asserts__5.String(p31);
        error((`UnknownKey: '{p31}'`));
    end,
    IsLoaded = function() --[[ Name: IsLoaded, Line 224 ]]
        -- upvalues: u9 (ref)
        return u9;
    end
};
l__UpdateRemote__11.OnClientEvent:Connect(function(p34, p35) --[[ Name: SetContent, Line 93 ]]
    -- upvalues: l__DeepFreezeUnsafe__8 (copy), u10 (ref), u8 (copy), l__NullValue__10 (copy), l__DeepEqualsPureUnsafe__6 (copy), u9 (ref), u11 (copy)
    l__DeepFreezeUnsafe__8(p34);
    u10 = p34;
    local v36 = {};
    local v37 = {};
    for v38, v41 in pairs(p34) do
        local v40 = u8[v38];
        if v40 then
            if v41 == l__NullValue__10 then
                local v41 = nil;
            end;
            local l__Value__12 = v40.Value;
            if not l__DeepEqualsPureUnsafe__6(v41, l__Value__12) then
                v40.Value = v41;
                table.insert(v36, {
                    instance = v40,
                    value = v41,
                    prevValue = l__Value__12
                });
            end;
            if p35 and not v40.ValueLoaded then
                v40.ValueLoaded = true;
                table.insert(v37, v40);
            end;
        end;
    end;
    if p35 then
        p35 = not u9;
    end;
    if p35 then
        u9 = true;
    end;
    for _, v42 in ipairs(v37) do
        v42.Loaded:Fire();
    end;
    if p35 then
        u11:Fire();
    end;
    for _, v43 in ipairs(v36) do
        v43.instance.Changed:Fire(v43.value, v43.prevValue);
    end;
end);
table.freeze(v33);
return v33;