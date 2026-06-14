-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local l__Players__2 = game:GetService("Players");
local u1 = {};
local u11 = {
    DisplayName = "Full Player Name",
    Prefixes = "# integer",
    Transform = function(p2) --[[ Name: Transform, Line 27 ]]
        -- upvalues: l__Util__1 (copy), l__Players__2 (copy)
        return p2, l__Util__1.MakeFuzzyFinder(l__Players__2:GetPlayers())(p2);
    end,
    ValidateOnce = function(p3) --[[ Name: ValidateOnce, Line 33 ]]
        -- upvalues: u1 (copy), l__Players__2 (copy)
        local v4;
        if u1[p3] then
            v4 = u1[p3];
        elseif l__Players__2:FindFirstChild(p3) then
            u1[p3] = l__Players__2[p3].UserId;
            v4 = l__Players__2[p3].UserId;
        else
            local v5;
            v5, v4 = pcall(l__Players__2.GetUserIdFromNameAsync, l__Players__2, p3);
            if v5 then
                u1[p3] = v4;
            else
                v4 = nil;
            end;
        end;
        return v4 ~= nil, "No player with that name could be found.";
    end,
    Autocomplete = function(_, p6) --[[ Name: Autocomplete, Line 37 ]]
        -- upvalues: l__Util__1 (copy)
        return l__Util__1.GetNames(p6);
    end,
    Parse = function(p7) --[[ Name: Parse, Line 41 ]]
        -- upvalues: u1 (copy), l__Players__2 (copy)
        if u1[p7] then
            return u1[p7];
        end;
        if l__Players__2:FindFirstChild(p7) then
            u1[p7] = l__Players__2[p7].UserId;
            return l__Players__2[p7].UserId;
        end;
        local v8, v9 = pcall(l__Players__2.GetUserIdFromNameAsync, l__Players__2, p7);
        if not v8 then
            return nil;
        end;
        u1[p7] = v9;
        return v9;
    end,
    Default = function(p10) --[[ Name: Default, Line 45 ]]
        return p10.Name;
    end,
    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};
return function(p12) --[[ Line: 57 ]]
    -- upvalues: u11 (copy), l__Util__1 (copy)
    p12:RegisterType("playerId", u11);
    p12:RegisterType("playerIds", l__Util__1.MakeListableType(u11, {
        Prefixes = "# integers"
    }));
end;