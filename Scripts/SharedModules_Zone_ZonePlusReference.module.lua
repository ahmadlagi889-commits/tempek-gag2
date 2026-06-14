-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
return {
    addToReplicatedStorage = function() --[[ Name: addToReplicatedStorage, Line 9 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy)
        if l__ReplicatedStorage__1:FindFirstChild(script.Name) then
            return false;
        end;
        local v1 = Instance.new("ObjectValue");
        v1.Name = script.Name;
        v1.Value = script.Parent;
        v1.Parent = l__ReplicatedStorage__1;
        local v2 = Instance.new("BoolValue");
        v2.Name = game:GetService("RunService"):IsClient() and "Client" or "Server";
        v2.Value = true;
        v2.Parent = v1;
        return v1;
    end,
    getObject = function() --[[ Name: getObject, Line 25 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy)
        return l__ReplicatedStorage__1:FindFirstChild(script.Name) or false;
    end
};