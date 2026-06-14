-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__DevAllowedIDs__3 = require(l__ReplicatedStorage__1.SharedModules.DevAllowedIDs);
local u1;
if l__RunService__2:IsServer() then
    u1 = require(game:GetService("ServerScriptService").UserGenerated.Analytics);
else
    u1 = nil;
end;
local u2 = {
    fillgarden = 132935919810877,
    fg = 132935919810877
};
return function(p3) --[[ Line: 31 ]]
    -- upvalues: u2 (copy), l__DevAllowedIDs__3 (copy), u1 (copy)
    p3:RegisterHook("BeforeRun", function(u4) --[[ Line: 32 ]]
        -- upvalues: u2 (ref), l__DevAllowedIDs__3 (ref), u1 (ref)
        local v5 = u2[u4.Name];
        if v5 and game.PlaceId == v5 then
        else
            if not (l__DevAllowedIDs__3.IsAllowed(u4.Executor.UserId) or game:GetService("RunService"):IsStudio()) then
                local l__Executor__4 = u4.Executor;
                if u1 and (typeof(l__Executor__4) == "Instance" and l__Executor__4:IsA("Player")) then
                    pcall(function() --[[ Line: 44 ]]
                        -- upvalues: u1 (ref), l__Executor__4 (copy), u4 (copy)
                        local v6 = u1;
                        local v7 = l__Executor__4;
                        local v8 = "PlayerAdminCommandDenied";
                        local v9 = {
                            Command = u4.Name
                        };
                        local l__RawText__5 = u4.RawText;
                        if type(l__RawText__5) == "string" then
                            if #l__RawText__5 > 500 then
                                l__RawText__5 = string.sub(l__RawText__5, 1, 500);
                            end;
                        else
                            l__RawText__5 = nil;
                        end;
                        v9.RawText = l__RawText__5;
                        v6:LogPlayerEvent(v7, v8, v9);
                    end);
                end;
                return "Not allowed";
            end;
        end;
    end);
end;