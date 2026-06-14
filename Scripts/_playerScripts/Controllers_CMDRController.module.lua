-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local u1 = {
    7627847305,
    71552399,
    8095632868,
    1755750680,
    355661302,
    9568431755,
    1787623041,
    6785965,
    4925297398,
    1848784060,
    1836038679,
    7805349940,
    1833666230,
    2882755487,
    2213470865,
    5455502981,
    95217455
};
return {
    StartOrder = 10,
    Init = function(_) --[[ Name: Init, Line 32 ]]
        -- upvalues: l__Players__1 (copy), l__RunService__3 (copy), u1 (copy), l__ReplicatedStorage__2 (copy)
        local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
        if l__RunService__3:IsStudio() and true or (table.find(u1, l__LocalPlayer__4.UserId) and true or game.PlaceId == 1) then
            local l__topbarplus__5 = require(l__ReplicatedStorage__2.ClientModules.topbarplus);
            local l__CmdrClient__6 = l__ReplicatedStorage__2:WaitForChild("CmdrClient", 10);
            if l__CmdrClient__6 then
                local u2 = require(l__CmdrClient__6);
                local v3 = l__topbarplus__5.new();
                v3:setName("CmdrIcon");
                v3:setLabel("Cmdr");
                v3:setRight();
                v3:setOrder(100);
                v3:setCaption("Toggle command console (F2)");
                v3:bindToggleKey(Enum.KeyCode.F2);
                v3.deselectWhenOtherIconSelected = false;
                v3.selected:Connect(function() --[[ Line: 53 ]]
                    -- upvalues: u2 (copy)
                    u2:Show();
                end);
                v3.deselected:Connect(function() --[[ Line: 57 ]]
                    -- upvalues: u2 (copy)
                    u2:Hide();
                end);
                u2:SetActivationKeys({});
            end;
        end;
    end,
    Start = function(_) --[[ Name: Start, Line 64 ]] end
};