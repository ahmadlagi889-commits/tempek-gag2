-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.Randoms.Base);
local l__Xorshift128__1 = require(game.ReplicatedStorage.UserGenerated.Randoms.Xorshift128);
return table.freeze({
    DefaultXorshift128 = l__Xorshift128__1.R,
    Xorshift128 = function(p1) --[[ Name: Xorshift128, Line 28 ]]
        -- upvalues: l__Xorshift128__1 (copy)
        return l__Xorshift128__1.new(p1);
    end,
    UniqueXorshift128 = function(p2) --[[ Name: UniqueXorshift128, Line 31 ]]
        -- upvalues: l__Xorshift128__1 (copy)
        return l__Xorshift128__1.Unique(p2);
    end
});