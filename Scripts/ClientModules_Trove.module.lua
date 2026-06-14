-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = newproxy();
local u2 = newproxy();
local u3 = table.freeze({
    "Destroy",
    "Disconnect",
    "destroy",
    "disconnect"
});
local function u8(p4, p5) --[[ Line: 124 ]]
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    local v6 = typeof(p4);
    if v6 == "function" then
        return u1;
    end;
    if v6 == "thread" then
        return u2;
    end;
    if p5 then
        return p5;
    end;
    if v6 == "Instance" then
        return "Destroy";
    end;
    if v6 == "RBXScriptConnection" then
        return "Disconnect";
    end;
    if v6 == "table" then
        for _, v7 in u3 do
            if typeof(p4[v7]) == "function" then
                return v7;
            end;
        end;
    end;
    error(`failed to get cleanup function for object {v6}: {p4}`, 3);
end;
local u9 = {};
u9.__index = u9;
function u9.new() --[[ Line: 179 ]]
    -- upvalues: u9 (copy)
    local v10 = setmetatable({}, u9);
    v10._objects = {};
    v10._cleaning = false;
    return v10;
end;
function u9.Add(p11, p12, p13) --[[ Line: 188 ]]
    -- upvalues: u8 (copy)
    if p11._cleaning then
        error("cannot call trove:Add() while cleaning", 2);
    end;
    local v14 = { p12, (u8(p12, p13)) };
    table.insert(p11._objects, v14);
    return p12;
end;
function u9.Clone(p15, p16) --[[ Line: 210 ]]
    if p15._cleaning then
        error("cannot call trove:Clone() while cleaning", 2);
    end;
    return p15:Add(p16:Clone());
end;
function u9.Construct(p17, p18, ...) --[[ Line: 253 ]]
    if p17._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;
    local v19 = nil;
    local v20 = type(p18);
    if v20 == "table" then
        v19 = p18.new(...);
    elseif v20 == "function" then
        v19 = p18(...);
    end;
    return p17:Add(v19);
end;
function u9.Connect(p21, p22, p23) --[[ Line: 269 ]]
    if p21._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;
    return p21:Add(p22:Connect(p23));
end;
function u9.BindToRenderStep(p24, u25, p26, p27) --[[ Line: 292 ]]
    -- upvalues: l__RunService__1 (copy)
    if p24._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2);
    end;
    l__RunService__1:BindToRenderStep(u25, p26, p27);
    p24:Add(function() --[[ Line: 299 ]]
        -- upvalues: l__RunService__1 (ref), u25 (copy)
        l__RunService__1:UnbindFromRenderStep(u25);
    end);
end;
function u9.AddPromise(u28, u29) --[[ Line: 304 ]]
    if u28._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2);
    end;
    if typeof(u29) ~= "table" or (typeof(u29.getStatus) ~= "function" or (typeof(u29.finally) ~= "function" or typeof(u29.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;
    if u29:getStatus() == "Started" then
        u29:finally(function() --[[ Line: 311 ]]
            -- upvalues: u28 (copy), u29 (copy)
            if u28._cleaning then
            else
                u28:_findAndRemoveFromObjects(u29, false);
            end;
        end);
        u28:Add(u29, "cancel");
    end;
    return u29;
end;
function u9.Remove(p30, p31) --[[ Line: 336 ]]
    if p30._cleaning then
        error("cannot call trove:Remove() while cleaning", 2);
    end;
    return p30:_findAndRemoveFromObjects(p31, true);
end;
function u9.Extend(p32) --[[ Line: 365 ]]
    -- upvalues: u9 (copy)
    if p32._cleaning then
        error("cannot call trove:Extend() while cleaning", 2);
    end;
    return p32:Construct(u9);
end;
function u9.Clean(p33) --[[ Line: 385 ]]
    if p33._cleaning then
    else
        p33._cleaning = true;
        for _, v34 in p33._objects do
            p33:_cleanupObject(v34[1], v34[2]);
        end;
        table.clear(p33._objects);
        p33._cleaning = false;
    end;
end;
function u9.WrapClean(u35) --[[ Line: 427 ]]
    return function() --[[ Line: 428 ]]
        -- upvalues: u35 (copy)
        u35:Clean();
    end;
end;
function u9._findAndRemoveFromObjects(p36, p37, p38) --[[ Line: 433 ]]
    local l___objects__2 = p36._objects;
    for v39, v40 in l___objects__2 do
        if v40[1] == p37 then
            local v41 = #l___objects__2;
            l___objects__2[v39] = l___objects__2[v41];
            l___objects__2[v41] = nil;
            if p38 then
                p36:_cleanupObject(v40[1], v40[2]);
            end;
            return true;
        end;
    end;
    return false;
end;
function u9._cleanupObject(_, p42, p43) --[[ Line: 453 ]]
    -- upvalues: u1 (copy), u2 (copy)
    if p43 == u1 then
        p42();
    elseif p43 == u2 then
        pcall(task.cancel, p42);
    else
        p42[p43](p42);
    end;
end;
function u9.AttachToInstance(u44, p45) --[[ Line: 463 ]]
    if u44._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p45:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2);
    end;
    return u44:Connect(p45.Destroying, function() --[[ Line: 470 ]]
        -- upvalues: u44 (copy)
        u44:Destroy();
    end);
end;
function u9.Destroy(p46) --[[ Line: 484 ]]
    p46:Clean();
end;
return {
    new = u9.new
};