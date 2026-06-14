-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__GroupService__2 = game:GetService("GroupService");
local l__RunService__3 = game:GetService("RunService");
local l__Cache__4 = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache);
local l__Asserts__5 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local u2 = l__Cache__4.new({
    MaxAge = (1 / 0),
    Callback = function(p1) --[[ Name: Callback, Line 38 ]]
        -- upvalues: l__GroupService__2 (copy)
        return l__GroupService__2:GetGroupsAsync(p1);
    end,
    AssertKey = l__Asserts__5.Integer
});
l__Players__1.PlayerRemoving:Connect(function(p3) --[[ Line: 44 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    local l__UserId__6 = p3.UserId;
    task.delay(60, function() --[[ Line: 47 ]]
        -- upvalues: l__Players__1 (ref), l__UserId__6 (copy), u2 (ref)
        if not l__Players__1:GetPlayerByUserId(l__UserId__6) then
            u2:Delete(l__UserId__6);
        end;
    end);
end);
if l__RunService__3:IsServer() then
    l__Players__1.PlayerAdded:Connect(function(p4) --[[ Line: 54 ]]
        -- upvalues: u2 (copy)
        u2:GetAsync(p4.UserId);
    end);
else
    task.spawn(function() --[[ Line: 58 ]]
        -- upvalues: u2 (copy), l__Players__1 (copy)
        u2:GetAsync(l__Players__1.LocalPlayer.UserId);
    end);
end;
return table.freeze({
    Cache = u2,
    GetGroupsAsync = function(p5, p6) --[[ Name: GetGroupsAsync, Line 67 ]]
        -- upvalues: l__Asserts__5 (copy), u2 (copy)
        l__Asserts__5.Integer(p5);
        l__Asserts__5.Optional(l__Asserts__5.Boolean)(p6);
        if p6 then
            return u2:Get(p5);
        else
            return u2:GetAsync(p5);
        end;
    end
});