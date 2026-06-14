-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__PolicyService__2 = game:GetService("PolicyService");
local l__RunService__3 = game:GetService("RunService");
local l__Cache__4 = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache);
local l__Asserts__5 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local u1 = {
    Discord = 0,
    Facebook = 1,
    Twitch = 2,
    YouTube = 3,
    X = 4,
    GitHub = 5,
    Guilded = 6
};
table.freeze(u1);
local u4 = l__Cache__4.new({
    Callback = function(p2) --[[ Name: Callback, Line 50 ]]
        -- upvalues: l__Players__1 (copy), l__PolicyService__2 (copy)
        local v3 = l__Players__1:GetPlayerByUserId(p2);
        assert(v3, "PlayerNotOnline");
        return l__PolicyService__2:GetPolicyInfoForPlayerAsync(v3);
    end,
    AssertKey = l__Asserts__5.Integer
});
l__Players__1.PlayerRemoving:Connect(function(p5) --[[ Line: 57 ]]
    -- upvalues: l__Players__1 (copy), u4 (copy)
    local l__UserId__6 = p5.UserId;
    task.delay(60, function() --[[ Line: 60 ]]
        -- upvalues: l__Players__1 (ref), l__UserId__6 (copy), u4 (ref)
        if not l__Players__1:GetPlayerByUserId(l__UserId__6) then
            u4:Delete(l__UserId__6);
        end;
    end);
end);
if l__RunService__3:IsServer() then
    l__Players__1.PlayerAdded:Connect(function(p6) --[[ Line: 67 ]]
        -- upvalues: u4 (copy)
        u4:GetAsync(p6.UserId);
    end);
end;
return table.freeze({
    ExternalLinkReference = u1,
    ExternalLinkReferencesToInts = function(p7) --[[ Name: ExternalLinkReferencesToInts, Line 77 ]]
        -- upvalues: u1 (copy)
        local v8 = {};
        for _, v9 in ipairs(p7) do
            local v10 = u1[v9];
            if v10 then
                table.insert(v8, v10);
            end;
        end;
        return v8;
    end,
    GetPolicyInfoForPlayerAsync = function(p11, p12) --[[ Name: GetPolicyInfoForPlayerAsync, Line 90 ]]
        -- upvalues: l__Asserts__5 (copy), u4 (copy)
        l__Asserts__5.Player(p11);
        l__Asserts__5.Optional(l__Asserts__5.Boolean)(p12);
        if p12 then
            return u4:Get(p11.UserId);
        else
            return u4:GetAsync(p11.UserId);
        end;
    end
});