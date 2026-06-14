-- Decompiled with Potassium's decompiler.

return {
    StartOrder = 10,
    Start = function(_) --[[ Name: Start, Line 5 ]]
        for _, u1 in script:GetChildren() do
            if u1:IsA("ModuleScript") then
                task.spawn(function() --[[ Line: 8 ]]
                    -- upvalues: u1 (copy)
                    require(u1):Start();
                end);
            end;
        end;
    end
};