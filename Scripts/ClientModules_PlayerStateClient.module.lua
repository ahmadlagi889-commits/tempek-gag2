-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__ReplicaClient__3 = require(l__ReplicatedStorage__2.ClientModules.ReplicaClient);
local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
local u2 = nil;
local u3 = {};
local u4 = false;
local function u6() --[[ Line: 14 ]]
    -- upvalues: u2 (ref), u3 (copy)
    if u2 then
        for _, v5 in ipairs(u3) do
            task.spawn(v5, u2);
        end;
        table.clear(u3);
    end;
end;
function v1.GetLocalReplica(_) --[[ Line: 40 ]]
    -- upvalues: u4 (ref), l__ReplicaClient__3 (copy), l__LocalPlayer__4 (copy), u2 (ref), u6 (copy)
    if not u4 then
        u4 = true;
        l__ReplicaClient__3.OnNew("PlayerState", function(p7) --[[ Line: 30 ]]
            -- upvalues: l__LocalPlayer__4 (ref), u2 (ref), u6 (ref)
            if p7.Tags and p7.Tags.UserId == l__LocalPlayer__4.UserId then
                u2 = p7;
                u6();
            end;
        end);
        l__ReplicaClient__3.RequestData();
    end;
    return u2;
end;
function v1.OnLocalReplica(_, p8) --[[ Line: 45 ]]
    -- upvalues: u4 (ref), l__ReplicaClient__3 (copy), l__LocalPlayer__4 (copy), u2 (ref), u6 (copy), u3 (copy)
    if not u4 then
        u4 = true;
        l__ReplicaClient__3.OnNew("PlayerState", function(p9) --[[ Line: 30 ]]
            -- upvalues: l__LocalPlayer__4 (ref), u2 (ref), u6 (ref)
            if p9.Tags and p9.Tags.UserId == l__LocalPlayer__4.UserId then
                u2 = p9;
                u6();
            end;
        end);
        l__ReplicaClient__3.RequestData();
    end;
    if u2 then
        task.spawn(p8, u2);
    else
        table.insert(u3, p8);
    end;
end;
function v1.WaitForLocalReplica(_, p10) --[[ Line: 54 ]]
    -- upvalues: u4 (ref), l__ReplicaClient__3 (copy), l__LocalPlayer__4 (copy), u2 (ref), u6 (copy)
    if not u4 then
        u4 = true;
        l__ReplicaClient__3.OnNew("PlayerState", function(p11) --[[ Line: 30 ]]
            -- upvalues: l__LocalPlayer__4 (ref), u2 (ref), u6 (ref)
            if p11.Tags and p11.Tags.UserId == l__LocalPlayer__4.UserId then
                u2 = p11;
                u6();
            end;
        end);
        l__ReplicaClient__3.RequestData();
    end;
    if u2 then
        return u2;
    end;
    local v12 = os.clock();
    local v13 = p10 or 30;
    while not u2 and os.clock() - v12 < v13 do
        task.wait();
    end;
    return u2;
end;
return v1;