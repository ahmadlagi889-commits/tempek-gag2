-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local l__Players__2 = game:GetService("Players");
local u6 = {
    Transform = function(p1) --[[ Name: Transform, Line 5 ]]
        -- upvalues: l__Util__1 (copy), l__Players__2 (copy)
        return l__Util__1.MakeFuzzyFinder(l__Players__2:GetPlayers())(p1);
    end,
    Validate = function(p2) --[[ Name: Validate, Line 11 ]]
        return #p2 > 0, "No player with that name could be found.";
    end,
    Autocomplete = function(p3) --[[ Name: Autocomplete, Line 15 ]]
        -- upvalues: l__Util__1 (copy)
        return l__Util__1.GetNames(p3);
    end,
    Parse = function(p4) --[[ Name: Parse, Line 19 ]]
        return p4[1];
    end,
    Default = function(p5) --[[ Name: Default, Line 23 ]]
        return p5.Name;
    end,
    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};
return function(p7) --[[ Line: 35 ]]
    -- upvalues: u6 (copy), l__Util__1 (copy)
    p7:RegisterType("player", u6);
    p7:RegisterType("players", l__Util__1.MakeListableType(u6, {
        Prefixes = "% teamPlayers"
    }));
end;