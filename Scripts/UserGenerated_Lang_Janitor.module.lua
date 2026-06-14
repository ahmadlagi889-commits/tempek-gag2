-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Bindable__2 = require(l__ReplicatedStorage__1.UserGenerated.Concurrency.Bindable);
local function u3(u1) --[[ Line: 60 ]]
    if typeof(u1) == "RBXScriptConnection" then
        task.spawn(u1.Disconnect, u1);
    elseif typeof(u1) == "Instance" then
        if u1:IsA("AnimationTrack") and u1.IsPlaying then
            task.spawn(function() --[[ Line: 66 ]]
                -- upvalues: u1 (copy)
                u1:Stop(0.05);
                task.delay(0.11666666666666667, function() --[[ Line: 68 ]]
                    -- upvalues: u1 (ref)
                    u1:Destroy();
                end);
            end);
        else
            task.spawn(u1.Destroy, u1);
        end;
    elseif type(u1) == "thread" then
        pcall(task.cancel, u1);
    elseif type(u1) == "function" then
        task.spawn(u1);
    else
        if type(u1) == "table" then
            task.spawn(function(p2) --[[ Line: 80 ]]
                if p2.Destroy then
                    p2:Destroy();
                else
                    if p2.Disconnect then
                        p2:Disconnect();
                    end;
                end;
            end, u1);
        end;
    end;
end;
local function v6(p4, p5) --[[ Line: 106 ]]
    -- upvalues: u3 (copy)
    if p5 ~= nil then
        if typeof(p5) ~= "RBXScriptConnection" and (typeof(p5) ~= "Instance" and (type(p5) ~= "thread" and type(p5) ~= "function")) then
            if type(p5) == "table" then
                if type(p5.Destroy) ~= "function" and type(p5.Disconnect) ~= "function" then
                    error("Unknown thing: table (missing Destroy/Disconnect)");
                end;
            else
                error((`Unknown thing: {typeof(p5)}`));
            end;
        end;
        if not p4.Destroyed then
            table.insert(p4.Things, p5);
            return p5;
        end;
        u3(p5);
    end;
    return p5;
end;
local v10 = {
    Destroy = function(p7) --[[ Name: Destroy, Line 90 ]]
        -- upvalues: u3 (copy)
        if p7.Destroyed then
            return false;
        end;
        p7.Destroyed = true;
        for _, v8 in ipairs(p7.Things) do
            u3(v8);
        end;
        p7.Destroying:Fire();
        return true;
    end,
    IsDestroyed = function(p9) --[[ Name: IsDestroyed, Line 102 ]]
        return p9.Destroyed;
    end,
    Add = v6
};
local u11 = table.freeze({
    __index = v10,
    __call = v6
});
table.freeze(v10);
return table.freeze({
    new = function() --[[ Name: new, Line 147 ]]
        -- upvalues: l__Bindable__2 (copy), u11 (copy)
        local v12 = {
            Destroyed = false,
            Destroying = l__Bindable__2.new(),
            Things = {}
        };
        return setmetatable(v12, u11);
    end
});