-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 0
};
local l__TweenService__1 = game:GetService("TweenService");
local u2 = 70;
local u3 = 0;
local u4 = nil;
local function u9(p5, p6) --[[ Line: 24 ]]
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), l__TweenService__1 (copy)
    local l__CurrentCamera__2 = workspace.CurrentCamera;
    if l__CurrentCamera__2 then
        local v7 = u2 + u3;
        if u4 then
            u4:Cancel();
            u4:Destroy();
            u4 = nil;
        end;
        if p5 then
            l__CurrentCamera__2.FieldOfView = v7;
        else
            local u8 = l__TweenService__1:Create(l__CurrentCamera__2, TweenInfo.new(p6 or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FieldOfView = v7
            });
            u4 = u8;
            u8.Completed:Once(function() --[[ Line: 42 ]]
                -- upvalues: u4 (ref), u8 (copy)
                if u4 == u8 then
                    u4 = nil;
                end;
                u8:Destroy();
            end);
            u8:Play();
        end;
    end;
end;
function v1.GetBaseFOV(_) --[[ Line: 54 ]]
    -- upvalues: u2 (ref)
    return u2;
end;
function v1.SetBaseFOV(_, p10, p11, p12) --[[ Line: 58 ]]
    -- upvalues: u2 (ref), u3 (ref), u9 (copy)
    u2 = p10;
    u3 = 0;
    u9(p11, p12);
end;
function v1.GetAdjuster(_) --[[ Line: 64 ]]
    -- upvalues: u3 (ref)
    return u3;
end;
function v1.SetAdjuster(_, p13, p14) --[[ Line: 68 ]]
    -- upvalues: u3 (ref), u9 (copy)
    u3 = p13;
    u9(p14);
end;
function v1.GetTargetFOV(_) --[[ Line: 74 ]]
    -- upvalues: u2 (ref), u3 (ref)
    return u2 + u3;
end;
function v1.GetCurrentFOV(_) --[[ Line: 78 ]]
    -- upvalues: u2 (ref)
    local l__CurrentCamera__3 = workspace.CurrentCamera;
    return l__CurrentCamera__3 and l__CurrentCamera__3.FieldOfView or u2;
end;
function v1.ClearAdjuster(_, p15) --[[ Line: 83 ]]
    -- upvalues: u3 (ref), u9 (copy)
    u3 = 0;
    u9(p15);
end;
function v1.Reset(_, p16) --[[ Line: 89 ]]
    -- upvalues: u2 (ref), u3 (ref), u9 (copy)
    u2 = 70;
    u3 = 0;
    u9(p16);
end;
function v1.Init(_) --[[ Line: 100 ]]
    -- upvalues: u2 (ref), u3 (ref), u4 (ref)
    u2 = 70;
    local l__CurrentCamera__4 = workspace.CurrentCamera;
    if l__CurrentCamera__4 then
        l__CurrentCamera__4.FieldOfView = u2;
    end;
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 106 ]]
        -- upvalues: u2 (ref), u3 (ref), u4 (ref)
        local l__CurrentCamera__5 = workspace.CurrentCamera;
        if l__CurrentCamera__5 then
            local v17 = u2 + u3;
            if u4 then
                u4:Cancel();
                u4:Destroy();
                u4 = nil;
            end;
            l__CurrentCamera__5.FieldOfView = v17;
        end;
    end);
end;
function v1.Start(_) --[[ Line: 111 ]] end;
return v1;