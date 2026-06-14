-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__TweenService__1 = game:GetService("TweenService");
local l__Lighting__2 = game:GetService("Lighting");
local u2 = l__Lighting__2:FindFirstChild("Blur") or Instance.new("BlurEffect", l__Lighting__2);
function v1.SetBlur(p3, p4) --[[ Line: 7 ]]
    -- upvalues: l__TweenService__1 (copy), u2 (copy)
    local v5 = p4 or 0.3;
    local v6 = l__TweenService__1:Create(u2, TweenInfo.new(v5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = p3
    });
    v6:Play();
    game.Debris:AddItem(v6, v5);
end;
return v1;