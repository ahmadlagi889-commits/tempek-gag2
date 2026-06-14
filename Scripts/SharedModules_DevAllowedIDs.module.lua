-- Decompiled with Potassium's decompiler.

local v1 = {
    7627847305,
    71552399,
    8095632868,
    1755750680,
    355661302,
    9568431755,
    1787623041,
    6785965,
    4925297398,
    1848784060,
    1836038679,
    7805349940,
    5455502981,
    1833666230,
    2882755487,
    2213470865,
    95217455
};
local u2 = {};
for _, v3 in v1 do
    u2[v3] = true;
end;
return table.freeze({
    List = v1,
    IsAllowed = function(p4) --[[ Name: IsAllowed, Line 39 ]]
        -- upvalues: u2 (copy)
        return u2[p4] == true;
    end
});