-- Decompiled with Potassium's decompiler.

return {
    Start = function(_) --[[ Name: Start, Line 3 ]]
        for _, v1 in script:GetChildren() do
            require(v1)();
        end;
    end
};