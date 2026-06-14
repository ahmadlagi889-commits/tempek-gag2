-- Decompiled with Potassium's decompiler.

return function(p1) --[[ Line: 1 ]]
    p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", {
        {
            Name = "+",
            Perform = function(p2, p3) --[[ Name: Perform, Line 5 ]]
                return p2 + p3;
            end
        },
        {
            Name = "-",
            Perform = function(p4, p5) --[[ Name: Perform, Line 11 ]]
                return p4 - p5;
            end
        },
        {
            Name = "*",
            Perform = function(p6, p7) --[[ Name: Perform, Line 17 ]]
                return p6 * p7;
            end
        },
        {
            Name = "/",
            Perform = function(p8, p9) --[[ Name: Perform, Line 23 ]]
                return p8 / p9;
            end
        },
        {
            Name = "**",
            Perform = function(p10, p11) --[[ Name: Perform, Line 29 ]]
                return p10 ^ p11;
            end
        },
        {
            Name = "%",
            Perform = function(p12, p13) --[[ Name: Perform, Line 35 ]]
                return p12 % p13;
            end
        }
    }));
end;