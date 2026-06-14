-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__SharedABTests__3 = require(l__ReplicatedStorage__2.UserGenerated.ABTests.SharedABTests);
local l__DeepFreezeUnsafe__4 = require(l__ReplicatedStorage__2.UserGenerated.Collections.DeepFreezeUnsafe);
local l__Bindable__5 = require(l__ReplicatedStorage__2.UserGenerated.Concurrency.Bindable);
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local u1 = false;
local u2 = l__Bindable__5.new();
local function v3() --[[ Line: 31 ]]
    -- upvalues: u1 (ref)
    return u1;
end;
local u4 = nil;
local function u10(p5, p6) --[[ Line: 36 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u4 (ref)
    local v7;
    if typeof(p5) == "Instance" then
        v7 = p5:IsA("Player");
    else
        v7 = false;
    end;
    assert(v7);
    local v8 = type(p6) == "boolean";
    assert(v8);
    if p5 ~= l__LocalPlayer__6 then
        return nil;
    end;
    local v9;
    while true do
        v9 = u4;
        if v9 then
            break;
        end;
        if not p6 then
            return nil;
        end;
        if not p5.Parent then
            return nil;
        end;
        task.wait();
    end;
    return v9;
end;
local u11 = nil;
local function v14(p12) --[[ Line: 61 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (ref)
    if p12 == l__LocalPlayer__6 then
        return u11;
    end;
    local v13;
    if typeof(p12) == "Instance" then
        v13 = p12:IsA("Player");
    else
        v13 = false;
    end;
    assert(v13);
    return nil;
end;
local function u21(p15, p16, p17) --[[ Line: 68 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (ref)
    local v18 = type(p16) == "string";
    assert(v18);
    local v19;
    if p15 == l__LocalPlayer__6 then
        v19 = u11;
    else
        local v20;
        if typeof(p15) == "Instance" then
            v20 = p15:IsA("Player");
        else
            v20 = false;
        end;
        assert(v20);
        v19 = nil;
    end;
    if v19 then
        v19 = v19[p16];
    end;
    if v19 == nil then
        return p17, false;
    else
        return v19, true;
    end;
end;
local function u26(p22, p23, p24) --[[ Line: 81 ]]
    -- upvalues: u10 (copy), u21 (copy)
    local v25 = type(p23) == "string";
    assert(v25);
    if u10(p22, true) then
        return u21(p22, p23, p24);
    else
        return p24, false;
    end;
end;
local function v29() --[[ Line: 93 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (ref)
    local v27 = l__LocalPlayer__6;
    if v27 == l__LocalPlayer__6 then
        return u11;
    end;
    local v28;
    if typeof(v27) == "Instance" then
        v28 = v27:IsA("Player");
    else
        v28 = false;
    end;
    assert(v28);
    return nil;
end;
local function v30() --[[ Line: 108 ]]
    -- upvalues: u4 (ref)
    return u4;
end;
local u31 = l__Bindable__5.new();
local u32 = l__Bindable__5.new();
l__SharedABTests__3.UpdateRemote.OnClientEvent:Connect(function(p33, p34) --[[ Line: 120 ]]
    -- upvalues: l__DeepFreezeUnsafe__4 (copy), u11 (ref), u4 (ref), u1 (ref), u2 (copy), u31 (copy), l__LocalPlayer__6 (copy), u32 (copy)
    l__DeepFreezeUnsafe__4(p33);
    l__DeepFreezeUnsafe__4(p34);
    u11 = p33;
    u4 = p34;
    u1 = true;
    u2:Fire();
    u31:Fire(l__LocalPlayer__6);
    u32:Fire();
end);
return table.freeze({
    GetAttributes = v14,
    GetAttribute = u21,
    GetAttributeAsync = u26,
    GetAssignmentsAsync = u10,
    GetJobAttributes = v29,
    GetJobAttribute = function(p35, p36) --[[ Name: GetJobAttribute, Line 96 ]]
        -- upvalues: u21 (copy), l__LocalPlayer__6 (copy)
        return u21(l__LocalPlayer__6, p35, p36);
    end,
    GetJobAttributeAsync = function(p37, p38) --[[ Name: GetJobAttributeAsync, Line 102 ]]
        -- upvalues: u26 (copy), l__LocalPlayer__6 (copy)
        return u26(l__LocalPlayer__6, p37, p38);
    end,
    GetJobAssignments = v30,
    GetJobAssignmentsAsync = function(p39) --[[ Name: GetJobAssignmentsAsync, Line 111 ]]
        -- upvalues: u10 (copy), l__LocalPlayer__6 (copy)
        return u10(l__LocalPlayer__6, p39);
    end,
    IsLoaded = v3,
    Loaded = u2,
    PlayerUpdated = u31,
    JobUpdated = u32
});