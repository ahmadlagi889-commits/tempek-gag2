-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__HttpService__2 = game:GetService("HttpService");
local l__JobId__3 = game.JobId;
if #l__JobId__3 ~= 0 and l__JobId__3 ~= "00000000-0000-0000-0000-000000000000" then
    return l__JobId__3;
end;
assert(l__RunService__1:IsStudio());
if not l__RunService__1:IsServer() then
    local v1;
    while true do
        v1 = script:GetAttribute("Studio");
        if type(v1) == "string" then
            break;
        end;
        task.wait();
    end;
    return v1;
end;
local v2 = l__HttpService__2:GenerateGUID(false):lower();
script:SetAttribute("Studio", v2);
return v2;