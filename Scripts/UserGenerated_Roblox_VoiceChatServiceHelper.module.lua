-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__VoiceChatService__2 = game:GetService("VoiceChatService");
local l__Cache__3 = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache);
local l__Asserts__4 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local u2 = l__Cache__3.new({
    MaxAge = (1 / 0),
    Callback = function(p1) --[[ Name: Callback, Line 27 ]]
        -- upvalues: l__VoiceChatService__2 (copy)
        return l__VoiceChatService__2:IsVoiceEnabledForUserIdAsync(p1);
    end,
    AssertKey = l__Asserts__4.Integer
});
l__Players__1.PlayerRemoving:Connect(function(p3) --[[ Line: 34 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    local l__UserId__5 = p3.UserId;
    task.delay(60, function() --[[ Line: 37 ]]
        -- upvalues: l__Players__1 (ref), l__UserId__5 (copy), u2 (ref)
        if not l__Players__1:GetPlayerByUserId(l__UserId__5) then
            u2:Delete(l__UserId__5);
        end;
    end);
end);
task.spawn(function() --[[ Line: 43 ]]
    -- upvalues: u2 (copy), l__Players__1 (copy)
    u2:GetAsync(l__Players__1.LocalPlayer.UserId);
end);
return table.freeze({
    IsVoiceEnabledForUserIdAsync = function(p4, p5) --[[ Name: IsVoiceEnabledForUserIdAsync, Line 49 ]]
        -- upvalues: l__Asserts__4 (copy), u2 (copy)
        l__Asserts__4.Integer(p4);
        l__Asserts__4.Optional(l__Asserts__4.Boolean)(p5);
        if p5 then
            return u2:Get(p4);
        else
            return u2:GetAsync(p4);
        end;
    end
});