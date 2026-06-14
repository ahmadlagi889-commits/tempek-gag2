-- Decompiled with Potassium's decompiler.

local u1;
if game:GetService("RunService"):IsServer() then
    u1 = require(game:GetService("ServerScriptService").UserGenerated.Analytics);
else
    u1 = nil;
end;
return function(p2) --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    p2:RegisterHook("AfterRun", function(u3) --[[ Line: 27 ]]
        -- upvalues: u1 (ref)
        if u1 then
            local l__Executor__1 = u3.Executor;
            if typeof(l__Executor__1) == "Instance" and l__Executor__1:IsA("Player") then
                if not pcall(function() --[[ Line: 37 ]]
                    -- upvalues: u1 (ref), l__Executor__1 (copy), u3 (copy)
                    local v4 = u1;
                    local v5 = l__Executor__1;
                    local v6 = "PlayerAdminCommand";
                    local v7 = {
                        Command = u3.Name,
                        Alias = u3.Alias
                    };
                    local l__RawText__2 = u3.RawText;
                    if type(l__RawText__2) == "string" then
                        if #l__RawText__2 > 500 then
                            l__RawText__2 = string.sub(l__RawText__2, 1, 500);
                        end;
                    else
                        l__RawText__2 = nil;
                    end;
                    v7.RawText = l__RawText__2;
                    v7.Group = u3.Group;
                    local l__Response__3 = u3.Response;
                    if type(l__Response__3) == "string" then
                        if #l__Response__3 > 500 then
                            l__Response__3 = string.sub(l__Response__3, 1, 500);
                        end;
                    else
                        l__Response__3 = nil;
                    end;
                    v7.Response = l__Response__3;
                    v4:LogPlayerEvent(v5, v6, v7);
                end) then
                    warn((`[CmdrService] AfterRun analytics log failed for {u3.Name}`));
                end;
            end;
        end;
    end);
end;