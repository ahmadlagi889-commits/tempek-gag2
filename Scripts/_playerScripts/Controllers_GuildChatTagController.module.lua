-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local l__GuildChatTag__1 = require(script.GuildChatTag);
return {
    StartOrder = 5,
    Init = function(_) --[[ Name: Init, Line 10 ]]
        -- upvalues: l__GuildChatTag__1 (copy)
        l__GuildChatTag__1.Install();
    end
};