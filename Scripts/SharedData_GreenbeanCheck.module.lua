-- Decompiled with Potassium's decompiler.

local l__GreenbeanHumanoidDescription__1 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("GreenbeanHumanoidDescription");
local u4 = {
    IsGreenbeanDescription = function(p1) --[[ Name: IsGreenbeanDescription, Line 13 ]]
        -- upvalues: l__GreenbeanHumanoidDescription__1 (copy)
        if not p1 then
            return false;
        end;
        local v2 = string.split(p1.HatAccessory, ",");
        for _, v3 in string.split(l__GreenbeanHumanoidDescription__1.HatAccessory, ",") do
            if not table.find(v2, v3) then
                return false;
            end;
        end;
        return p1.LeftArmColor == l__GreenbeanHumanoidDescription__1.LeftArmColor and (p1.LeftLegColor == l__GreenbeanHumanoidDescription__1.LeftLegColor and (p1.RightArmColor == l__GreenbeanHumanoidDescription__1.RightArmColor and (p1.RightLegColor == l__GreenbeanHumanoidDescription__1.RightLegColor and p1.TorsoColor == l__GreenbeanHumanoidDescription__1.TorsoColor)));
    end
};
function u4.IsCharacterGreenbean(p5) --[[ Line: 39 ]]
    -- upvalues: u4 (copy)
    if p5 then
        if p5:GetAttribute("AppliedGreenbean") then
            return true;
        else
            local v6 = p5:FindFirstChildOfClass("Humanoid");
            if v6 then
                return u4.IsGreenbeanDescription(v6:GetAppliedDescription());
            else
                return false;
            end;
        end;
    else
        return false;
    end;
end;
return u4;