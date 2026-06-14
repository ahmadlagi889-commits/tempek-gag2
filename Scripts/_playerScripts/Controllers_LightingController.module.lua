-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 2
};
local l__Lighting__1 = game:GetService("Lighting");
local l__TweenService__2 = game:GetService("TweenService");
local u2 = nil;
local u3 = {
    Ambient = l__Lighting__1.Ambient,
    Brightness = l__Lighting__1.Brightness,
    ColorShift_Bottom = l__Lighting__1.ColorShift_Bottom,
    ColorShift_Top = l__Lighting__1.ColorShift_Top,
    OutdoorAmbient = l__Lighting__1.OutdoorAmbient,
    ClockTime = l__Lighting__1.ClockTime,
    EnvironmentDiffuseScale = l__Lighting__1.EnvironmentDiffuseScale
};
local u4 = table.clone(u3);
function v1.GetDefault(_) --[[ Line: 19 ]]
    -- upvalues: u3 (copy)
    return u3;
end;
function v1.GetCurrentTarget(_) --[[ Line: 22 ]]
    -- upvalues: u4 (copy)
    return u4;
end;
function v1.TransitionTo(_, p5, p6) --[[ Line: 26 ]]
    -- upvalues: u2 (ref), u4 (copy), l__TweenService__2 (copy), l__Lighting__1 (copy)
    if u2 then
        u2:Cancel();
        u2:Destroy();
        u2 = nil;
    end;
    for v7, v8 in p5 do
        u4[v7] = v8;
    end;
    local u9 = l__TweenService__2:Create(l__Lighting__1, TweenInfo.new(p6 or 3, Enum.EasingStyle.Sine), p5);
    u2 = u9;
    u9.Completed:Once(function() --[[ Line: 39 ]]
        -- upvalues: u2 (ref), u9 (copy)
        if u2 == u9 then
            u2 = nil;
        end;
        u9:Destroy();
    end);
    u9:Play();
end;
function v1.SetImmediate(_, p10) --[[ Line: 46 ]]
    -- upvalues: u2 (ref), u4 (copy), l__Lighting__1 (copy)
    if u2 then
        u2:Cancel();
        u2:Destroy();
        u2 = nil;
    end;
    for v11, v12 in p10 do
        u4[v11] = v12;
        l__Lighting__1[v11] = v12;
    end;
end;
function v1.Init(_) --[[ Line: 60 ]] end;
function v1.Start(_) --[[ Line: 61 ]] end;
return v1;