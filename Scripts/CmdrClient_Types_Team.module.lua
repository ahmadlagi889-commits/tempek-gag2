-- Decompiled with Potassium's decompiler.

local l__Teams__1 = game:GetService("Teams");
local l__Util__2 = require(script.Parent.Parent.Shared.Util);
local u5 = {
    Transform = function(p1) --[[ Name: Transform, Line 5 ]]
        -- upvalues: l__Util__2 (copy), l__Teams__1 (copy)
        return l__Util__2.MakeFuzzyFinder(l__Teams__1:GetTeams())(p1);
    end,
    Validate = function(p2) --[[ Name: Validate, Line 11 ]]
        return #p2 > 0, "No team with that name could be found.";
    end,
    Autocomplete = function(p3) --[[ Name: Autocomplete, Line 15 ]]
        -- upvalues: l__Util__2 (copy)
        return l__Util__2.GetNames(p3);
    end,
    Parse = function(p4) --[[ Name: Parse, Line 19 ]]
        return p4[1];
    end
};
local u7 = {
    Listable = true,
    Transform = u5.Transform,
    Validate = u5.Validate,
    Autocomplete = u5.Autocomplete,
    Parse = function(p6) --[[ Name: Parse, Line 30 ]]
        return p6[1]:GetPlayers();
    end
};
local u9 = {
    Transform = u5.Transform,
    Validate = u5.Validate,
    Autocomplete = u5.Autocomplete,
    Parse = function(p8) --[[ Name: Parse, Line 40 ]]
        return p8[1].TeamColor;
    end
};
return function(p10) --[[ Line: 45 ]]
    -- upvalues: u5 (copy), l__Util__2 (copy), u7 (copy), u9 (copy)
    p10:RegisterType("team", u5);
    p10:RegisterType("teams", l__Util__2.MakeListableType(u5));
    p10:RegisterType("teamPlayers", u7);
    p10:RegisterType("teamColor", u9);
    p10:RegisterType("teamColors", l__Util__2.MakeListableType(u9));
end;