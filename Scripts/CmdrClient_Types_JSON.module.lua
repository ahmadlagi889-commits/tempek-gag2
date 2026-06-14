-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
return function(p1) --[[ Line: 3 ]]
    -- upvalues: l__HttpService__1 (copy)
    p1:RegisterType("json", {
        Validate = function(p2) --[[ Name: Validate, Line 5 ]]
            -- upvalues: l__HttpService__1 (ref)
            return pcall(l__HttpService__1.JSONDecode, l__HttpService__1, p2);
        end,
        Parse = function(p3) --[[ Name: Parse, Line 9 ]]
            -- upvalues: l__HttpService__1 (ref)
            return l__HttpService__1:JSONDecode(p3);
        end
    });
end;