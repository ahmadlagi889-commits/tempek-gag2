-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 0
};
local l__SoundService__1 = game:GetService("SoundService");
function v1.Init(_) --[[ Line: 39 ]]
    -- upvalues: l__SoundService__1 (copy)
    game.DescendantAdded:Connect(function(p2) --[[ Line: 43 ]]
        -- upvalues: l__SoundService__1 (ref)
        if p2:IsA("Sound") then
            if p2.SoundGroup ~= nil then
                return;
            end;
            p2.SoundGroup = l__SoundService__1:FindFirstChild("SFXGroup");
        end;
    end);
    for _, v3 in game:GetDescendants() do
        if v3:IsA("Sound") then
            if v3.SoundGroup == nil then
                v3.SoundGroup = l__SoundService__1:FindFirstChild("SFXGroup");
            end;
        end;
    end;
end;
return v1;