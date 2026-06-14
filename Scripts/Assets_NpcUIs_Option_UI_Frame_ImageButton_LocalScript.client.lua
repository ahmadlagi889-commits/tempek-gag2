-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local l__UIPadding__2 = script.Parent.Parent.Frame.Text_Element.UIPadding;
local u2 = l__TweenService__1:Create(l__UIPadding__2, v1, {
    PaddingLeft = UDim.new(0.04, 0)
});
local u3 = l__TweenService__1:Create(l__UIPadding__2, v1, {
    PaddingLeft = UDim.new(0, 0)
});
local l__ImageLabel__3 = script.Parent.Parent.ImageLabel;
local l__ImageTransparency__4 = script.Parent.Parent.ImageLabel.ImageTransparency;
local u4 = l__TweenService__1:Create(l__ImageLabel__3, v1, {
    ImageTransparency = 0
});
local u5 = l__TweenService__1:Create(l__ImageLabel__3, v1, {
    ImageTransparency = l__ImageTransparency__4
});
local l__Hover__5 = game.SoundService.SFX.Hover;
script.Parent.MouseEnter:Connect(function() --[[ Line: 12 ]]
    -- upvalues: l__Hover__5 (copy), u2 (copy), u4 (copy)
    l__Hover__5.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
    l__Hover__5.Playing = true;
    l__Hover__5.TimePosition = 0;
    u2:Play();
    u4:Play();
end);
script.Parent.MouseLeave:Connect(function() --[[ Line: 19 ]]
    -- upvalues: u3 (copy), u5 (copy)
    u3:Play();
    u5:Play();
end);