-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local u2 = Random.new();
TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0);
require(game.Players.LocalPlayer.PlayerScripts.Controllers.BlockSmashController);
local u3 = {};
function u1.StopWobble(_, p4) --[[ Line: 14 ]]
    -- upvalues: u3 (copy)
    local v5 = u3[p4];
    if v5 then
        v5.Connection:Disconnect();
        if p4.Parent then
            p4:PivotTo(v5.StartPivot);
        end;
        u3[p4] = nil;
    end;
end;
function u1.ScaleUp(_, u6, u7, u8, p9) --[[ Line: 25 ]]
    -- upvalues: u1 (copy), l__RunService__2 (copy), l__TweenService__1 (copy)
    u1:StopWobble(u6);
    local u10 = p9 or Enum.EasingStyle.Exponential;
    local v11, v12 = u6:GetBoundingBox();
    local u13 = v11.Position.Y - v12.Y / 2;
    local u14 = u6:GetScale();
    local u15 = os.clock();
    local u16 = nil;
    u16 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 34 ]]
        -- upvalues: u6 (copy), u16 (ref), u15 (copy), u8 (copy), l__TweenService__1 (ref), u10 (ref), u14 (copy), u7 (copy), u13 (copy)
        if u6.Parent then
            local v17 = (os.clock() - u15) / u8;
            local v18 = math.clamp(v17, 0, 1);
            local v19 = l__TweenService__1:GetValue(v18, u10, Enum.EasingDirection.Out);
            u6:ScaleTo(u14 + (u7 - u14) * v19);
            local v20, v21 = u6:GetBoundingBox();
            local v22 = v20.Position.Y - v21.Y / 2;
            u6:PivotTo(u6:GetPivot() + Vector3.new(0, u13 - v22, 0));
            if v18 >= 1 then
                u16:Disconnect();
            end;
        else
            u16:Disconnect();
        end;
    end);
end;
function u1.Wobble(_, u23, p24, p25) --[[ Line: 53 ]]
    -- upvalues: u1 (copy), u2 (copy), l__RunService__2 (copy), u3 (copy)
    u1:StopWobble(u23);
    local u26 = p24 or 1;
    local u27 = p25 or 0.5;
    local v28, v29 = u23:GetBoundingBox();
    u23.WorldPivot = v28 * CFrame.new(0, -v29.Y / 2, 0);
    local u30 = u23:GetPivot();
    local u31 = os.clock();
    local u32 = u2:NextNumber(0, 6.283185307179586);
    local u33 = u2:NextInteger(0, 1) == 0 and 1 or -1;
    local u34 = nil;
    u34 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 66 ]]
        -- upvalues: u23 (copy), u34 (ref), u3 (ref), u31 (copy), u27 (ref), u26 (ref), u33 (copy), u30 (copy), u32 (copy)
        if u23.Parent then
            local v35 = os.clock() - u31;
            local v36 = math.clamp(v35 / u27, 0, 1);
            local v37 = 1 - v36;
            local v38 = math.sin(v35 * 25) * 0.2617993877991494 * u26 * v37 * u33;
            u23:PivotTo(u30 * CFrame.Angles(0, u32, 0) * CFrame.Angles(0, 0, v38) * CFrame.Angles(0, -u32, 0));
            if v36 >= 1 then
                u23:PivotTo(u30);
                u34:Disconnect();
                u3[u23] = nil;
            end;
        else
            u34:Disconnect();
            u3[u23] = nil;
        end;
    end);
    u3[u23] = {
        Connection = u34,
        StartPivot = u30
    };
end;
function u1.ScaleUpInstant(_, p39, p40) --[[ Line: 88 ]]
    -- upvalues: u1 (copy)
    u1:StopWobble(p39);
    local v41, v42 = p39:GetBoundingBox();
    local v43 = v41.Position.Y - v42.Y / 2;
    p39:ScaleTo(p40);
    local v44, v45 = p39:GetBoundingBox();
    local v46 = v44.Position.Y - v45.Y / 2;
    p39:PivotTo(p39:GetPivot() + Vector3.new(0, v43 - v46, 0));
end;
function u1.PopupFadeEffect(_, p47, p48, p49) --[[ Line: 100 ]]
    -- upvalues: u1 (copy), l__TweenService__1 (copy)
    local v50 = p47:Clone();
    v50.Parent = game.Workspace;
    v50:PivotTo(p47:GetPivot());
    u1:ScaleUp(v50, p48, 0.5);
    local v51 = TweenInfo.new(p49, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0);
    for _, v52 in pairs(v50:GetDescendants()) do
        if v52:IsA("BasePart") then
            v52.CanCollide = false;
            local v53 = l__TweenService__1:Create(v52, v51, {
                Transparency = 1
            });
            v53:Play();
            game.Debris:AddItem(v53, v51.Time);
        end;
    end;
    game.Debris:AddItem(v50, v51.Time);
end;
function u1.PlayPopVFX(_, p54, p55) --[[ Line: 120 ]]
    for _, v56 in pairs(p54.Main:GetDescendants()) do
        if v56:IsA("ParticleEmitter") and v56.Name == "Level" .. tostring(p55) then
            v56:Emit(v56:GetAttribute("EmitCount"));
        end;
    end;
end;
function u1.HighlightFlash(_, p57, p58) --[[ Line: 129 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v59 = TweenInfo.new(p58, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
    local v60 = Instance.new("Highlight");
    v60.OutlineTransparency = 1;
    v60.FillColor = Color3.new(1, 1, 1);
    v60.FillTransparency = 0;
    v60.Parent = p57;
    v60.Adornee = p57;
    local v61 = l__TweenService__1:Create(v60, v59, {
        FillTransparency = 1
    });
    v61:Play();
    game.Debris:AddItem(v61, v59.Time);
    game.Debris:AddItem(v60, v59.Time);
end;
function u1.PlayHatchUpOne(_, p62) --[[ Line: 144 ]]
    -- upvalues: u1 (copy)
    u1:ScaleUpInstant(p62, 2);
    u1:PopupFadeEffect(p62, 3, 0.5);
    u1:PlayPopVFX(p62, 1);
    u1:HighlightFlash(p62, 0.5);
end;
function u1.PlayHatchUpTwo(_, p63) --[[ Line: 154 ]]
    -- upvalues: u1 (copy)
    u1:ScaleUpInstant(p63, 4);
    u1:PopupFadeEffect(p63, 7, 0.5);
    u1:PlayPopVFX(p63, 2);
    u1:HighlightFlash(p63, 0.5);
end;
function u1.PlayHatchUpOneElastic(_, u64) --[[ Line: 164 ]]
    -- upvalues: u1 (copy)
    u1:ScaleUp(u64, 1.35, 1.2, Enum.EasingStyle.Elastic);
    task.spawn(function() --[[ Line: 167 ]]
        -- upvalues: u1 (ref), u64 (copy)
        task.wait(0.2);
        u1:PopupFadeEffect(u64, 1.75, 0.5);
        u1:PlayPopVFX(u64, 1);
        u1:HighlightFlash(u64, 0.5);
    end);
end;
function u1.PlayHatchUpTwoElastic(_, u65) --[[ Line: 175 ]]
    -- upvalues: u1 (copy)
    u1:ScaleUp(u65, 2, 1.2, Enum.EasingStyle.Elastic);
    task.spawn(function() --[[ Line: 178 ]]
        -- upvalues: u1 (ref), u65 (copy)
        task.wait(0.2);
        u1:PopupFadeEffect(u65, 2.5, 0.5);
        u1:PlayPopVFX(u65, 2);
        u1:HighlightFlash(u65, 0.5);
    end);
end;
function u1.PlayHatchUpScale(_, p66, p67, p68) --[[ Line: 186 ]]
    -- upvalues: u1 (copy)
    u1:ScaleUpInstant(p66, p67);
    u1:PopupFadeEffect(p66, p67 * 1.5, 0.5);
    u1:PlayPopVFX(p66, p68);
    u1:HighlightFlash(p66, 0.5);
end;
function u1.NormalEffect(_, p69) --[[ Line: 196 ]]
    -- upvalues: u2 (copy), u1 (copy)
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p69, 0.7, 0.5);
    if math.random(1, 10) == 1 then
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:Wobble(p69, 0.7, 0.5);
    end;
    task.wait(u2:NextNumber(0.5, 1.5));
end;
function u1.BigEffect(_, p70) --[[ Line: 206 ]]
    -- upvalues: u2 (copy), u1 (copy)
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p70, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p70, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpOne(p70);
    if math.random(1, 10) == 1 then
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:Wobble(p70, 0.7, 0.5);
    end;
    task.wait(u2:NextNumber(0.5, 1.5));
end;
function u1.HugeEffect(_, p71) --[[ Line: 220 ]]
    -- upvalues: u2 (copy), u1 (copy)
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p71, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p71, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpOne(p71);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p71, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpTwo(p71);
end;
function u1.NormalEffectMode2(_, p72) --[[ Line: 233 ]]
    -- upvalues: u2 (copy), u1 (copy)
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p72, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p72, 0.7, 0.5);
    if math.random(1, 10) == 1 then
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:Wobble(p72, 1, 0.5);
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:PlayHatchUpScale(p72, 1.5, 1);
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:Wobble(p72, 0.7, 0.5);
    end;
    task.wait(u2:NextNumber(0.5, 1.5));
end;
function u1.BigEffectMode2(_, p73) --[[ Line: 249 ]]
    -- upvalues: u2 (copy), u1 (copy)
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p73, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p73, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p73, 1, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpScale(p73, 1.5, 1);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p73, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p73, 1, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpScale(p73, 2, 2);
    if math.random(1, 10) == 1 then
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:Wobble(p73, 1.2, 0.75);
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:PlayHatchUpScale(p73, 3, 3);
        task.wait(u2:NextNumber(0.5, 1.5));
        u1:Wobble(p73, 0.7, 0.5);
    end;
    task.wait(u2:NextNumber(0.5, 1.5));
end;
function u1.HugeEffectMode2(_, p74) --[[ Line: 275 ]]
    -- upvalues: u2 (copy), u1 (copy)
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p74, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p74, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p74, 1, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpScale(p74, 1.5, 1);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p74, 0.7, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p74, 1, 0.5);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpScale(p74, 2, 2);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p74, 1.2, 0.75);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpScale(p74, 3, 3);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:Wobble(p74, 1.5, 0.75);
    task.wait(u2:NextNumber(0.5, 1.5));
    u1:PlayHatchUpScale(p74, 4, 3);
    task.wait(u2:NextNumber(0.5, 1.5));
end;
function u1.HatchEgg(_, u75, u76, p77, p78) --[[ Line: 301 ]]
    -- upvalues: u1 (copy)
    local u79 = p78 or 1;
    if p77 == "Instant" then
        task.spawn(function() --[[ Line: 306 ]]
            -- upvalues: u79 (ref), u76 (copy), u1 (ref), u75 (copy)
            if u79 == 1 then
                if u76 == "Normal" then
                    u1:NormalEffect(u75);
                    return;
                end;
                if u76 == "Big" then
                    u1:BigEffect(u75);
                    return;
                end;
                if u76 == "Huge" then
                    u1:HugeEffect(u75);
                end;
            elseif u79 == 2 then
                if u76 == "Normal" then
                    u1:NormalEffectMode2(u75);
                    return;
                end;
                if u76 == "Big" then
                    u1:BigEffectMode2(u75);
                    return;
                end;
                if u76 == "Huge" then
                    u1:HugeEffectMode2(u75);
                end;
            end;
        end);
    end;
end;
return u1;