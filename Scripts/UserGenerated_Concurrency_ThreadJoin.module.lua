-- Decompiled with Potassium's decompiler.

return function(p1, p2) --[[ Name: ThreadJoin, Line 20 ]]
    local v3 = os.clock();
    while coroutine.status(p1) ~= "dead" do
        if p2 ~= nil and p2 <= os.clock() - v3 then
            return false;
        end;
        task.wait();
    end;
    return true;
end;