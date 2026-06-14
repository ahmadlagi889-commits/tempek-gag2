-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__LocalizationService__2 = game:GetService("LocalizationService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__Cache__5 = require(l__ReplicatedStorage__3.UserGenerated.Concurrency.Cache);
local l__Asserts__6 = require(l__ReplicatedStorage__3.UserGenerated.Lang.Asserts);
local u3 = l__Cache__5.new({
    Callback = function(p1) --[[ Name: Callback, Line 29 ]]
        -- upvalues: l__Players__1 (copy), l__LocalizationService__2 (copy)
        local v2 = l__Players__1:GetPlayerByUserId(p1);
        assert(v2, "PlayerNotOnline");
        return l__LocalizationService__2:GetCountryRegionForPlayerAsync(v2);
    end,
    AssertKey = l__Asserts__6.Integer
});
l__Players__1.PlayerRemoving:Connect(function(p4) --[[ Line: 36 ]]
    -- upvalues: l__Players__1 (copy), u3 (copy)
    local l__UserId__7 = p4.UserId;
    task.delay(60, function() --[[ Line: 39 ]]
        -- upvalues: l__Players__1 (ref), l__UserId__7 (copy), u3 (ref)
        if not l__Players__1:GetPlayerByUserId(l__UserId__7) then
            u3:Delete(l__UserId__7);
        end;
    end);
end);
if l__RunService__4:IsServer() then
    l__Players__1.PlayerAdded:Connect(function(p5) --[[ Line: 46 ]]
        -- upvalues: u3 (copy)
        u3:GetAsync(p5.UserId);
    end);
else
    task.spawn(function() --[[ Line: 50 ]]
        -- upvalues: u3 (copy), l__Players__1 (copy)
        u3:GetAsync(l__Players__1.LocalPlayer.UserId);
    end);
end;
return table.freeze({
    GetCountryRegionForPlayerAsync = function(p6, p7) --[[ Name: GetCountryRegionForPlayerAsync, Line 57 ]]
        -- upvalues: l__Asserts__6 (copy), u3 (copy)
        l__Asserts__6.Player(p6);
        l__Asserts__6.Optional(l__Asserts__6.Boolean)(p7);
        if p7 then
            return u3:Get(p6.UserId);
        else
            return u3:GetAsync(p6.UserId);
        end;
    end
});