-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Debris__4 = game:GetService("Debris");
local u1 = {
    Intensity = 0.7,
    Duration = 0.5
};
local u2 = {
    Intensity = 0.8,
    Duration = 0.5
};
local u3 = {
    Intensity = 1.2,
    Duration = 0.75,
    Shake = 0.6
};
local u4 = {
    Intensity = 1.2,
    Duration = 0.75,
    Shake = 1
};
local u5 = { u1, u1 };
local u6 = {
    Chance = 0.1,
    PreDelayMin = 0.5,
    PreDelayMax = 1.5,
    PostDelay = 0.5,
    Spec = u1,
    FollowUpSpec = u1
};
local u7 = Random.new();
local u8 = {};
local l__SpiralTrail__5 = require(game.ReplicatedStorage.ClientModules.SpiralTrail);
local l__Assets__6 = l__ReplicatedStorage__1:WaitForChild("Assets");
local function u11(p9) --[[ Line: 110 ]]
    local v10 = { p9.Name };
    local l__Parent__7 = p9.Parent;
    while l__Parent__7 and l__Parent__7 ~= game do
        table.insert(v10, 1, l__Parent__7.Name);
        l__Parent__7 = l__Parent__7.Parent;
    end;
    return table.concat(v10, "/");
end;
local function u16(p12) --[[ Line: 120 ]]
    local v13 = {};
    for _, v14 in p12:GetChildren() do
        local v15 = `{v14.Name}({v14.ClassName})`;
        table.insert(v13, v15);
    end;
    return #v13 == 0 and "(no children)" or table.concat(v13, ", ");
end;
local function u36(u17, p18, p19, p20) --[[ Line: 144 ]]
    -- upvalues: u8 (copy), u7 (copy), l__RunService__3 (copy)
    local v21 = u8[u17];
    if v21 then
        v21.Connection:Disconnect();
        if u17.Parent then
            u17:PivotTo(v21.StartPivot);
        end;
        u8[u17] = nil;
    end;
    local u22 = p18 or 1;
    local u23 = p19 or 0.5;
    local u24 = p20 or 0;
    local v25, v26 = u17:GetBoundingBox();
    u17.WorldPivot = v25 * CFrame.new(0, -v26.Y / 2, 0);
    local u27 = u17:GetPivot();
    local u28 = os.clock();
    local u29 = u7:NextNumber(0, 6.283185307179586);
    local u30 = u7:NextInteger(0, 1) == 0 and 1 or -1;
    local u31 = nil;
    u31 = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 159 ]]
        -- upvalues: u17 (copy), u31 (ref), u8 (ref), u28 (copy), u23 (ref), u22 (ref), u30 (copy), u7 (ref), u24 (ref), u27 (copy), u29 (copy)
        if u17.Parent then
            local v32 = os.clock() - u28;
            local v33 = math.clamp(v32 / u23, 0, 1);
            local v34 = 1 - v33;
            local v35 = math.sin(v32 * 25) * 0.2617993877991494 * u22 * v34 * u30;
            u17:PivotTo(u27 * CFrame.new(u7:NextNumber(-1, 1) * u24 * u22 * v34, 0, u7:NextNumber(-1, 1) * u24 * u22 * v34) * CFrame.Angles(0, u29, 0) * CFrame.Angles(0, 0, v35) * CFrame.Angles(0, -u29, 0));
            if v33 >= 1 then
                u17:PivotTo(u27);
                u31:Disconnect();
                u8[u17] = nil;
            end;
        else
            u31:Disconnect();
            u8[u17] = nil;
        end;
    end);
    u8[u17] = {
        Connection = u31,
        StartPivot = u27
    };
end;
local function u55(u37, u38, u39, p40) --[[ Line: 188 ]]
    -- upvalues: u8 (copy), l__RunService__3 (copy), l__TweenService__2 (copy)
    local v41 = u8[u37];
    if v41 then
        v41.Connection:Disconnect();
        if u37.Parent then
            u37:PivotTo(v41.StartPivot);
        end;
        u8[u37] = nil;
    end;
    local u42 = p40 or Enum.EasingStyle.Exponential;
    local v43, v44 = u37:GetBoundingBox();
    local u45 = v43.Position.Y - v44.Y / 2;
    local u46 = u37:GetScale();
    local u47 = os.clock();
    local u48 = nil;
    u48 = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 197 ]]
        -- upvalues: u37 (copy), u48 (ref), u47 (copy), u39 (copy), l__TweenService__2 (ref), u42 (ref), u46 (copy), u38 (copy), u45 (copy)
        if u37.Parent then
            local v49 = (os.clock() - u47) / u39;
            local v50 = math.clamp(v49, 0, 1);
            local v51 = l__TweenService__2:GetValue(v50, u42, Enum.EasingDirection.Out);
            u37:ScaleTo(u46 + (u38 - u46) * v51);
            local v52, v53 = u37:GetBoundingBox();
            local v54 = v52.Position.Y - v53.Y / 2;
            u37:PivotTo(u37:GetPivot() + Vector3.new(0, u45 - v54, 0));
            if v50 >= 1 then
                u48:Disconnect();
            end;
        else
            u48:Disconnect();
        end;
    end);
end;
local function u65(p56, p57) --[[ Line: 216 ]]
    -- upvalues: u8 (copy)
    local v58 = u8[p56];
    if v58 then
        v58.Connection:Disconnect();
        if p56.Parent then
            p56:PivotTo(v58.StartPivot);
        end;
        u8[p56] = nil;
    end;
    local v59, v60 = p56:GetBoundingBox();
    local v61 = v59.Position.Y - v60.Y / 2;
    p56:ScaleTo(p57);
    local v62, v63 = p56:GetBoundingBox();
    local v64 = v62.Position.Y - v63.Y / 2;
    p56:PivotTo(p56:GetPivot() + Vector3.new(0, v61 - v64, 0));
end;
local function u72(p66) --[[ Line: 260 ]]
    if p66:IsA("Model") then
        local v67 = not p66.PrimaryPart and p66:FindFirstChildWhichIsA("BasePart", true);
        if v67 then
            p66.PrimaryPart = v67;
        end;
        for _, v68 in p66:GetDescendants() do
            if v68:IsA("BasePart") then
                v68.Anchored = true;
                v68.CanCollide = false;
                v68.CanQuery = false;
                v68.CanTouch = false;
                v68.Massless = true;
                v68.Transparency = 1;
            end;
        end;
        return p66;
    end;
    local v69 = Instance.new("Model");
    if p66:IsA("BasePart") then
        p66.Anchored = true;
        p66.CanCollide = false;
        p66.CanQuery = false;
        p66.CanTouch = false;
        p66.Massless = true;
        p66.Transparency = 1;
        p66.Parent = v69;
        v69.PrimaryPart = p66;
        return v69;
    end;
    local v70 = Instance.new("Part");
    v70.Anchored = true;
    v70.CanCollide = false;
    v70.CanQuery = false;
    v70.CanTouch = false;
    v70.Massless = true;
    v70.Transparency = 1;
    v70.Size = Vector3.new(0.1, 0.1, 0.1);
    v70.Parent = v69;
    v69.PrimaryPart = v70;
    for _, v71 in p66:GetChildren() do
        v71.Parent = v70;
    end;
    return v69;
end;
local function u78(p73, p74, p75) --[[ Line: 298 ]]
    -- upvalues: u72 (copy)
    local v76 = u72((p73:Clone()));
    if not v76.PrimaryPart then
        v76:Destroy();
        return nil;
    end;
    local v77 = p74:GetScale();
    if math.abs(v77 - 1) > 0.001 then
        v76:ScaleTo(v77);
    end;
    v76:PivotTo(p75);
    v76.Parent = p74;
    return v76;
end;
local function u87(p79, p80) --[[ Line: 331 ]]
    local v81 = `Level{p80}`;
    local v82 = {};
    if p79.Name == v81 then
        if p79:IsA("ParticleEmitter") and not table.find(v82, p79) then
            table.insert(v82, p79);
        end;
        for _, v83 in p79:GetDescendants() do
            if v83:IsA("ParticleEmitter") then
                if not table.find(v82, v83) then
                    table.insert(v82, v83);
                end;
            end;
        end;
        return v82;
    end;
    local v84 = p79:FindFirstChild(v81);
    if v84 then
        if v84:IsA("ParticleEmitter") and not table.find(v82, v84) then
            table.insert(v82, v84);
        end;
        for _, v85 in v84:GetDescendants() do
            if v85:IsA("ParticleEmitter") then
                if not table.find(v82, v85) then
                    table.insert(v82, v85);
                end;
            end;
        end;
    end;
    for _, v86 in p79:GetDescendants() do
        if v86:IsA("ParticleEmitter") and v86.Name == v81 then
            if not table.find(v82, v86) then
                table.insert(v82, v86);
            end;
        end;
    end;
    return v82;
end;
local function u92(p88) --[[ Line: 368 ]]
    -- upvalues: u11 (copy)
    for _, v89 in p88 do
        if v89.Parent then
            local v90 = v89:GetAttribute("EmitCount");
            local v91 = type(v90) ~= "number" and 1 or v90;
            ("Emitting %* from %* Enabled=%*"):format(v91, u11(v89), v89.Enabled);
            v89:Emit(v91);
        else
            ("Skipping emit, no parent: %*"):format((u11(v89)));
        end;
    end;
end;
local function u108(p93, p94) --[[ Line: 381 ]]
    -- upvalues: u11 (copy), l__Assets__6 (copy), u16 (copy), u78 (copy), u87 (copy), u92 (copy), l__Debris__4 (copy)
    ("Start level=%* egg=%*"):format(p94, (p93:GetFullName()));
    local v95 = p93.PrimaryPart or p93:FindFirstChildWhichIsA("BasePart");
    if v95 then
        ("Root part: %* eggScale=%*"):format(u11(v95), (p93:GetScale()));
        local v96 = l__Assets__6:FindFirstChild("EggEffects");
        if v96 then
            local v97 = l__Assets__6:FindFirstChild("EggEffects");
            local v98;
            if v97 then
                v98 = v97:FindFirstChild("GrowEffects");
            else
                v98 = nil;
            end;
            if v98 then
                ("GrowEffects template: %* (%*) children: %*"):format(u11(v98), v98.ClassName, (u16(v98)));
                local v99 = u78(v98, p93, v95.CFrame);
                if v99 then
                    ("Scaled VFX clone to %* at %* (%*)"):format(p93:GetScale(), u11(v99), v99.ClassName);
                    local u100 = u87(v99, p94);
                    if #u100 == 0 then
                        ("Abort: no Level%* ParticleEmitters in scaled GrowEffects clone"):format(p94);
                        local v101 = {};
                        for _, v102 in v98:GetDescendants() do
                            if v102:IsA("ParticleEmitter") then
                                local v103 = `{u11(v102)} EmitCount={v102:GetAttribute("EmitCount")}`;
                                table.insert(v101, v103);
                            end;
                        end;
                        if #v101 ~= 0 then
                            ("GrowEffects ParticleEmitters: %*"):format((table.concat(v101, " | ")));
                        end;
                        v99:Destroy();
                    else
                        for _, v104 in u100 do
                            ("Queued emitter: %* parent=%*"):format(u11(v104), not v104.Parent and "nil" or v104.Parent:GetFullName());
                        end;
                        task.spawn(function() --[[ Line: 438 ]]
                            -- upvalues: u100 (copy), u92 (ref)
                            task.wait();
                            ("Emitting %* emitter(s)"):format(#u100);
                            u92(u100);
                        end);
                        local v105 = 1;
                        for _, v106 in u100 do
                            v105 = math.max(v105, v106.Lifetime.Max);
                        end;
                        local v107 = v105 + 0.5;
                        ("Scheduling cleanup in %*s for scaled VFX clone"):format(v107);
                        l__Debris__4:AddItem(v99, v107);
                    end;
                end;
            else
                ("Abort: EggEffects.GrowEffects missing. EggEffects children: %*"):format((u16(v96)));
            end;
        end;
    end;
end;
local function u126(u109, p110, p111) --[[ Line: 468 ]]
    -- upvalues: u65 (copy), u7 (copy), l__SpiralTrail__5 (copy), l__TweenService__2 (copy)
    local v112 = u109:FindFirstChild("Highlight", true);
    local v113 = u109:GetScale();
    local v114 = v113 * 0.7;
    u65(u109, v113);
    local v115 = u109:GetPivot();
    local v116 = v115 * CFrame.new(0, 4, 0);
    local l__Angles__8 = CFrame.Angles;
    local v117 = u7:NextNumber(-180, 180);
    local v118 = v116 * l__Angles__8(0, math.rad(v117), 0);
    task.delay(0.5, function() --[[ Line: 487 ]]
        -- upvalues: l__SpiralTrail__5 (ref), u109 (copy)
        l__SpiralTrail__5.Init(u109.PrimaryPart, {
            Size = 0.4,
            Offset = 2,
            Time = 0.2,
            Frequency = 1,
            Color = Color3.fromRGB(255, 255, 255)
        });
    end);
    local v119 = 0;
    while v119 < 1.8 do
        v119 = v119 + game:GetService("RunService").Heartbeat:Wait();
        local v120 = (math.sin(v119 / 1.8 * 6.283185307179586) + 1) / 2;
        local v121 = CFrame.Angles(0, math.rad(v120 * (v119 / 1.8 * 360 * 5)), 0);
        local v122 = CFrame.new(u7:NextNumber(-1, 1) * p111 * v119 / 1.8, u7:NextNumber(-1, 1) * p111 * v119 / 1.8, u7:NextNumber(-1, 1) * p111 * v119 / 1.8);
        if v119 < 1.4 then
            u109:PivotTo(v115:Lerp(v118, (l__TweenService__2:GetValue(v119 / 1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In))) * v122 * v121);
        else
            u109:PivotTo(v118:Lerp(v115, (l__TweenService__2:GetValue((v119 - 1.4) / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In))) * v122 * v121);
        end;
        if v119 > 0.4 and v119 < 1 then
            local v123 = l__TweenService__2:GetValue(v119 - 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            u65(u109, v113 + (v114 - v113) * v123);
        elseif v119 > 1 then
            local v124 = l__TweenService__2:GetValue((v119 - 1) / 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.InOut);
            u65(u109, v114 + (p110 - v114) * v124);
        end;
        if v119 < 0.6 then
            v112.FillTransparency = l__TweenService__2:GetValue(v119 / 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * -1 + 1;
            v112.OutlineTransparency = l__TweenService__2:GetValue(v119 / 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * -0.5 + 1;
        elseif v119 > 1 then
            local v125 = v119 - 1.4;
            v112.FillTransparency = l__TweenService__2:GetValue(v125 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * 1 + 0;
            v112.OutlineTransparency = l__TweenService__2:GetValue(v125 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * 0.5 + 0.5;
        end;
    end;
end;
local function u135(p127, p128, p129, p130, p131) --[[ Line: 582 ]]
    -- upvalues: u36 (copy), u8 (copy)
    local v132 = p127:GetScale() - 1;
    local v133 = math.abs(v132) > 0.001;
    if not v133 then
        p127:PivotTo(p128);
    end;
    u36(p127, p129, p130, p131);
    task.wait(p130);
    local v134 = u8[p127];
    if v134 then
        v134.Connection:Disconnect();
        if p127.Parent then
            p127:PivotTo(v134.StartPivot);
        end;
        u8[p127] = nil;
    end;
    if not v133 then
        p127:PivotTo(p128);
    end;
end;
local function u147(p136, p137, p138, p139, p140, p141, p142, p143) --[[ Line: 643 ]]
    -- upvalues: u135 (copy)
    for v144, v145 in p138 do
        local v146;
        if p143 then
            v146 = v144 == 1;
        else
            v146 = p143;
        end;
        if not v146 then
            task.wait(p139 or 0.5);
        end;
        if p141 then
            p141();
        end;
        u135(p136, p137, v145.Intensity, v145.Duration, v145.Shake);
        p140.index = p140.index + 1;
        if p142 and p142.onWobbleBeat then
            p142.onWobbleBeat(p140.index);
        end;
    end;
end;
local function u156(p148, p149, p150, p151, p152, p153, p154) --[[ Line: 735 ]]
    -- upvalues: u7 (copy), u135 (copy)
    local v155;
    if p150.PreDelayMin and p150.PreDelayMax then
        v155 = u7:NextNumber(p150.PreDelayMin, p150.PreDelayMax);
        task.wait(v155 or 0.5);
    else
        v155 = nil;
    end;
    local l__Spec__9 = p150.Spec;
    task.wait(p151 or 0.5);
    if p153 then
        p153();
    end;
    u135(p148, p149, l__Spec__9.Intensity, l__Spec__9.Duration, l__Spec__9.Shake);
    p152.index = p152.index + 1;
    if p154 and p154.onWobbleBeat then
        p154.onWobbleBeat(p152.index);
    end;
    if p150.FollowUpSpec then
        if v155 then
            task.wait(v155 or 0.5);
        end;
        local l__FollowUpSpec__10 = p150.FollowUpSpec;
        task.wait(p151 or 0.5);
        if p153 then
            p153();
        end;
        u135(p148, p149, l__FollowUpSpec__10.Intensity, l__FollowUpSpec__10.Duration, l__FollowUpSpec__10.Shake);
        p152.index = p152.index + 1;
        if p154 and p154.onWobbleBeat then
            p154.onWobbleBeat(p152.index);
        end;
        if p150.PostDelay then
            task.wait(p150.PostDelay or 0.5);
        end;
    elseif p150.PostDelay then
        task.wait(p150.PostDelay or 0.5);
    end;
end;
local function u164(p157, p158, p159, p160, p161, p162, p163) --[[ Line: 899 ]]
    -- upvalues: u135 (copy), u126 (copy), u108 (copy), u164 (copy)
    if math.random() > p159.Chance then
    else
        if p159.Wobble and (p159.ScaleUp and p159.WobbleAfterScale) then
            if math.random() >= 0.15 then
                local l__Wobble__11 = p159.Wobble;
                task.wait(p160 or 0.5);
                if p162 then
                    p162();
                end;
                u135(p157, p158, l__Wobble__11.Intensity, l__Wobble__11.Duration, l__Wobble__11.Shake);
                p161.index = p161.index + 1;
                if p163 and p163.onWobbleBeat then
                    p163.onWobbleBeat(p161.index);
                end;
                task.wait(p160 or 0.5);
            else
                p161.index = p161.index + 1;
                if p163 and p163.onWobbleBeat then
                    p163.onWobbleBeat(p161.index);
                end;
            end;
            local l__Scale__12 = p159.ScaleUp.Scale;
            local l__VfxLevel__13 = p159.ScaleUp.VfxLevel;
            if l__VfxLevel__13 == 1 then
                u126(p157, l__Scale__12, 0);
            elseif l__VfxLevel__13 == 2 then
                u126(p157, l__Scale__12, 0.2);
            end;
            u108(p157, l__VfxLevel__13);
            local l__VfxLevel__14 = p159.ScaleUp.VfxLevel;
            local l__Scale__15 = p159.ScaleUp.Scale;
            if p163 and p163.onGrowBeat then
                p163.onGrowBeat(l__VfxLevel__14, l__Scale__15);
            end;
            local l__WobbleAfterScale__16 = p159.WobbleAfterScale;
            task.wait(p160 or 0.5);
            if p162 then
                p162();
            end;
            u135(p157, p158, l__WobbleAfterScale__16.Intensity, l__WobbleAfterScale__16.Duration, l__WobbleAfterScale__16.Shake);
            p161.index = p161.index + 1;
            if p163 and p163.onWobbleBeat then
                p163.onWobbleBeat(p161.index);
            end;
        elseif p159.Wobble then
            local l__Wobble__17 = p159.Wobble;
            task.wait(p160 or 0.5);
            if p162 then
                p162();
            end;
            u135(p157, p158, l__Wobble__17.Intensity, l__Wobble__17.Duration, l__Wobble__17.Shake);
            p161.index = p161.index + 1;
            if p163 and p163.onWobbleBeat then
                p163.onWobbleBeat(p161.index);
            end;
        end;
        if p159.Nested then
            u164(p157, p158, p159.Nested, p160, p161, p162, p163);
        end;
    end;
end;
return table.freeze({
    GROW_SCALE_1 = 2,
    GROW_SCALE_2 = 4,
    GROW_SCALE_3 = 6,
    GROW_STEP_MULT = 2,
    ResolveHatchTargetScale = function(p165, p166) --[[ Name: ResolveHatchTargetScale, Line 1038 ]]
        return p165 == "Huge" and 6 or (p165 == "Big" and 4 or p166 * 2);
    end,
    NormalPreHatchConfig = {
        InitialWobbles = u5,
        OptionalWobble = u6
    },
    StopWobble = function(p167) --[[ Name: StopWobble, Line 133 ]]
        -- upvalues: u8 (copy)
        local v168 = u8[p167];
        if v168 then
            v168.Connection:Disconnect();
            if p167.Parent then
                p167:PivotTo(v168.StartPivot);
            end;
            u8[p167] = nil;
        end;
    end,
    Wobble = u36,
    ScaleUp = u55,
    ScaleUpInstant = u65,
    PopupFadeEffect = function(p169, p170, p171) --[[ Name: PopupFadeEffect, Line 228 ]]
        -- upvalues: u55 (copy), l__TweenService__2 (copy), l__Debris__4 (copy)
        local v172 = p169:GetScale();
        local v173 = p169:GetPivot();
        local v174 = p169:Clone();
        v174:ScaleTo(v172);
        v174:PivotTo(v173);
        v174.Parent = p169.Parent or workspace;
        u55(v174, p170, 0.5);
        local v175 = TweenInfo.new(p171, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0);
        for _, v176 in v174:GetDescendants() do
            if v176:IsA("BasePart") then
                v176.CanCollide = false;
                local v177 = l__TweenService__2:Create(v176, v175, {
                    Transparency = 1
                });
                v177:Play();
                l__Debris__4:AddItem(v177, v175.Time);
            end;
        end;
        l__Debris__4:AddItem(v174, v175.Time);
    end,
    PlayPopVFX = u108,
    HighlightFlash = function(p178, p179) --[[ Name: HighlightFlash, Line 449 ]]
        -- upvalues: l__TweenService__2 (copy), l__Debris__4 (copy)
        local v180 = TweenInfo.new(p179, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
        local v181 = Instance.new("Highlight");
        v181.OutlineTransparency = 1;
        v181.FillColor = Color3.new(1, 1, 1);
        v181.FillTransparency = 0;
        v181.Parent = p178;
        v181.Adornee = p178;
        local v182 = l__TweenService__2:Create(v181, v180, {
            FillTransparency = 1
        });
        v182:Play();
        l__Debris__4:AddItem(v182, v180.Time);
        l__Debris__4:AddItem(v181, v180.Time);
    end,
    PlayNearMissScale = function(p183, p184, p185) --[[ Name: PlayNearMissScale, Line 558 ]]
        -- upvalues: u126 (copy), u108 (copy)
        if p185 == 1 then
            u126(p183, p184, 0);
        elseif p185 == 2 then
            u126(p183, p184, 0.2);
        end;
        u108(p183, p185);
    end,
    Pause = function(p186) --[[ Name: Pause, Line 578 ]]
        task.wait(p186 or 0.5);
    end,
    WobbleAndWait = u135,
    ResetToLand = function(p187, p188) --[[ Name: ResetToLand, Line 595 ]]
        -- upvalues: u8 (copy)
        local v189 = u8[p187];
        if v189 then
            v189.Connection:Disconnect();
            if p187.Parent then
                p187:PivotTo(v189.StartPivot);
            end;
            u8[p187] = nil;
        end;
        local v190 = p187:GetScale() - 1;
        if math.abs(v190) <= 0.001 then
            p187:PivotTo(p188);
        end;
    end,
    RunPreHatchSequence = function(p191, p192, p193, p194, p195) --[[ Name: RunPreHatchSequence, Line 939 ]]
        -- upvalues: u135 (copy), u156 (copy), u164 (copy), u8 (copy)
        local v196 = p193.Pause or 0.5;
        local v197 = {
            index = 0
        };
        for v198, v199 in p193.InitialWobbles do
            if v198 ~= 1 then
                task.wait(v196 or 0.5);
            end;
            if p194 then
                p194();
            end;
            u135(p191, p192, v199.Intensity, v199.Duration, v199.Shake);
            v197.index = v197.index + 1;
            if p195 and p195.onWobbleBeat then
                p195.onWobbleBeat(v197.index);
            end;
        end;
        if p193.OptionalWobble then
            local l__OptionalWobble__18 = p193.OptionalWobble;
            if math.random() <= l__OptionalWobble__18.Chance then
                u156(p191, p192, l__OptionalWobble__18, v196, v197, p194, p195);
            end;
        end;
        if p193.NearMiss then
            u164(p191, p192, p193.NearMiss, v196, v197, p194, p195);
        end;
        task.wait(v196 or 0.5);
        local v200 = u8[p191];
        if v200 then
            v200.Connection:Disconnect();
            if p191.Parent then
                p191:PivotTo(v200.StartPivot);
            end;
            u8[p191] = nil;
        end;
        local v201 = p191:GetScale() - 1;
        if math.abs(v201) <= 0.001 then
            p191:PivotTo(p192);
        end;
    end,
    RunBigPreHatchSequence = function(p202, p203, p204, p205) --[[ Name: RunBigPreHatchSequence, Line 982 ]]
        -- upvalues: u147 (copy), u5 (copy), u156 (copy), u6 (copy), u126 (copy), u108 (copy), u1 (copy), u2 (copy), u8 (copy)
        local v206 = {
            index = 0
        };
        u147(p202, p203, u5, 0.5, v206, p204, p205, true);
        u156(p202, p203, u6, 0.5, v206, p204, p205);
        task.wait(0.5);
        if p205 and p205.onGrowStart then
            p205.onGrowStart(1, 2);
        end;
        u126(p202, 2, 0);
        u108(p202, 1);
        if p205 and p205.onGrowBeat then
            p205.onGrowBeat(1, 2);
        end;
        u147(p202, p203, { u1, u2 }, 0.7, v206, p204, p205);
        local v207 = u6;
        if math.random() <= v207.Chance then
            u156(p202, p203, v207, 0.5, v206, p204, p205);
        end;
        task.wait(0.5);
        local v208 = u8[p202];
        if v208 then
            v208.Connection:Disconnect();
            if p202.Parent then
                p202:PivotTo(v208.StartPivot);
            end;
            u8[p202] = nil;
        end;
        local v209 = p202:GetScale() - 1;
        if math.abs(v209) <= 0.001 then
            p202:PivotTo(p203);
        end;
    end,
    RunHugePreHatchSequence = function(p210, p211, p212, p213) --[[ Name: RunHugePreHatchSequence, Line 998 ]]
        -- upvalues: u147 (copy), u5 (copy), u156 (copy), u6 (copy), u126 (copy), u108 (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u8 (copy)
        local v214 = {
            index = 0
        };
        u147(p210, p211, u5, 0.5, v214, p212, p213, true);
        u156(p210, p211, u6, 0.5, v214, p212, p213);
        task.wait(0.5);
        if p213 and p213.onGrowStart then
            p213.onGrowStart(1, 2);
        end;
        u126(p210, 2, 0);
        u108(p210, 1);
        if p213 and p213.onGrowBeat then
            p213.onGrowBeat(1, 2);
        end;
        u147(p210, p211, { u1, u2 }, 0.7, v214, p212, p213);
        u156(p210, p211, u6, 0.5, v214, p212, p213);
        task.wait(0.5);
        if p213 and p213.onGrowStart then
            p213.onGrowStart(2, 4);
        end;
        u126(p210, 4, 0.2);
        u108(p210, 2);
        if p213 and p213.onGrowBeat then
            p213.onGrowBeat(2, 4);
        end;
        u147(p210, p211, { u3, u4 }, 0.9, v214, p212, p213);
        task.wait(0.5);
        local v215 = u8[p210];
        if v215 then
            v215.Connection:Disconnect();
            if p210.Parent then
                p210:PivotTo(v215.StartPivot);
            end;
            u8[p210] = nil;
        end;
        local v216 = p210:GetScale() - 1;
        if math.abs(v216) <= 0.001 then
            p210:PivotTo(p211);
        end;
    end
});