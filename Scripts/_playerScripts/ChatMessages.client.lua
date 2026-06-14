-- Decompiled with Potassium's decompiler.

local u1 = {
    "<font color=\"#00aaff\"><b>[TIP]</b></font> Your garden literally grows <font color=\"#55ff7f\"><b>offline</b></font>!",
    "<font color=\"#00aaff\"><b>[TIP]</b></font> Fruits <font color=\"#ff5555\"><b>decay</b></font> if you go away go too long!",
    "<font color=\"#00aaff\"><b>[TIP]</b></font> Pets have a chance to <font color=\"#55aaff\"><b>big</b></font>... or even <font color=\"#aa55ff\"><b>huge</b></font>!",
    "<font color=\"#00aaff\"><b>[TIP]</b></font> Invite your <font color=\"#55ff7f\"><b>friends</b></font> for <font color=\"#ffd700\"><b>sheckles bonuses</b></font> and more fun!",
    "<font color=\"#00aaff\"><b>[TIP]</b></font> <font color=\"#55aaff\"><b>Watering seed packs</b></font> might give more <font color=\"#ffd700\"><b>luck</b></font>, who knows!",
    "<font color=\"#00aaff\"><b>[TIP]</b></font> <font color=\"#55aaff\"><b>Sprinklers</b></font> give your plants more <font color=\"#ffd700\"><b>luck</b></font>!",
    "<font color=\"#00aaff\"><b>[TIP]</b></font> Some <font color=\"#ff8855\"><b>props</b></font> can be used for <font color=\"#ff8855\"><b>defense</b></font>!"
};
local l__RBXGeneral__1 = game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral");
task.spawn(function() --[[ Line: 13 ]]
    -- upvalues: u1 (copy), l__RBXGeneral__1 (copy)
    local v2 = nil;
    local v3 = nil;
    while true do
        task.wait(300);
        local v4;
        repeat
            v4 = math.random(1, #u1);
        until v4 ~= v2 and v4 ~= v3;
        l__RBXGeneral__1:DisplaySystemMessage(u1[v4]);
        v3 = v2;
        v2 = v4;
    end;
end);