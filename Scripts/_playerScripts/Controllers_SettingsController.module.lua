-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__TweenService__1 = game:GetService("TweenService");
local u2 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local l__SFXGroup__2 = game.SoundService.SFXGroup;
local l__GameMusic__3 = game.SoundService.Master.GameMusic;
local l__Settings__4 = game.Players.LocalPlayer:WaitForChild("Settings");
local l__Music_Volume__5 = l__Settings__4:WaitForChild("Music_Volume");
local l__SFX_Volume__6 = l__Settings__4:WaitForChild("SFX_Volume");
function v1.Init(_) --[[ Line: 15 ]]
    -- upvalues: l__SFXGroup__2 (copy), l__SFX_Volume__6 (copy), l__GameMusic__3 (copy), l__Music_Volume__5 (copy), l__TweenService__1 (copy), u2 (copy)
    l__SFXGroup__2.Volume = l__SFX_Volume__6.Value;
    l__GameMusic__3.Volume = l__Music_Volume__5.Value;
    local l__UnixTimestamp__7 = DateTime.now().UnixTimestamp;
    l__SFX_Volume__6:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 19 ]]
        -- upvalues: l__SFXGroup__2 (ref), l__SFX_Volume__6 (ref)
        l__SFXGroup__2.Volume = l__SFX_Volume__6.Value;
    end);
    l__Music_Volume__5:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 22 ]]
        -- upvalues: l__UnixTimestamp__7 (copy), l__TweenService__1 (ref), l__GameMusic__3 (ref), u2 (ref), l__Music_Volume__5 (ref)
        if DateTime.now().UnixTimestamp - l__UnixTimestamp__7 > 3 then
            local v3 = l__TweenService__1:Create(l__GameMusic__3, u2, {
                Volume = l__Music_Volume__5.Value
            });
            v3:Play();
            game.Debris:AddItem(v3, u2.Time);
        else
            l__GameMusic__3.Volume = l__Music_Volume__5.Value;
        end;
    end);
end;
return v1;