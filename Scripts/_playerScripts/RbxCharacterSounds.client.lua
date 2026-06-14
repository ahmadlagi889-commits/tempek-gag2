-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__SoundService__3 = game:GetService("SoundService");
local l__AtomicBinding__4 = require(script:WaitForChild("AtomicBinding"));
local u1 = "UserSoundsUseRelativeVelocity2";
local v2, v3 = pcall(function() --[[ Line: 13 ]]
    -- upvalues: u1 (copy)
    return UserSettings():IsUserFeatureEnabled(u1);
end);
local u4 = v2 and v3;
local u5 = "UserNewCharacterSoundsApi3";
local v6, v7 = pcall(function() --[[ Line: 13 ]]
    -- upvalues: u5 (copy)
    return UserSettings():IsUserFeatureEnabled(u5);
end);
local u8 = v6 and v7;
local u9 = "UserFixCharSoundsEmitters";
local v10, v11 = pcall(function() --[[ Line: 13 ]]
    -- upvalues: u9 (copy)
    return UserSettings():IsUserFeatureEnabled(u9);
end);
local u12 = v10 and v11;
local u13 = "UserFixCharSoundsEmitterRootPart";
local v14, v15 = pcall(function() --[[ Line: 13 ]]
    -- upvalues: u13 (copy)
    return UserSettings():IsUserFeatureEnabled(u13);
end);
local u16 = v14 and v15;
local u17 = {
    Climbing = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true
    },
    Died = {
        SoundId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        SoundId = "rbxasset://sounds/action_falling.ogg",
        Looped = true
    },
    GettingUp = {
        SoundId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        SoundId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        SoundId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true,
        Pitch = 1.85
    },
    Splash = {
        SoundId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3",
        Looped = true,
        Pitch = 1.6
    }
};
local u18 = {
    Climbing = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true
    },
    Died = {
        AssetId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        AssetId = "rbxasset://sounds/action_falling.ogg",
        Looping = true
    },
    GettingUp = {
        AssetId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        AssetId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        AssetId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true,
        PlaybackSpeed = 1.85
    },
    Splash = {
        AssetId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3",
        Looping = true,
        PlaybackSpeed = 1.6
    }
};
local function u22(p19, p20) --[[ Line: 101 ]]
    if p19 then
        local v21 = p19.ActiveController and (not (p19.ActiveController:IsA("GroundController") and p19.GroundSensor) and p19.ActiveController:IsA("ClimbController"));
        if v21 then
            v21 = p19.ClimbSensor;
        end;
        if v21 and v21.SensedPart then
            return p20 - v21.SensedPart:GetVelocityAtPosition(p19.RootPart.Position);
        else
            return p20;
        end;
    else
        return p20;
    end;
end;
local u77 = l__AtomicBinding__4.new({
    humanoid = "Humanoid",
    rootPart = "HumanoidRootPart"
}, function(p23) --[[ Name: initializeSoundSystem, Line 165 ]]
    -- upvalues: u4 (copy), u8 (copy), l__SoundService__3 (copy), u12 (copy), u16 (copy), l__Players__1 (copy), u18 (copy), u17 (copy), u22 (copy), l__RunService__2 (copy)
    local l__humanoid__5 = p23.humanoid;
    local l__rootPart__6 = p23.rootPart;
    local u24 = nil;
    local u25;
    if u4 then
        u25 = l__humanoid__5.Parent:FindFirstChild("ControllerManager");
    else
        u25 = nil;
    end;
    local u26 = {};
    if u8 and l__SoundService__3.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
        local v27 = nil;
        local v28 = nil;
        if u12 then
            if u16 then
                v28 = l__humanoid__5.RootPart or l__humanoid__5.Parent;
            else
                v28 = l__humanoid__5.RootPart;
            end;
        else
            v27 = l__Players__1.LocalPlayer.Character;
        end;
        local v29 = 5;
        local v30 = {};
        while v29 < 150 do
            v30[v29] = 5 / v29;
            v29 = v29 * 1.25;
        end;
        v30[150] = 0;
        if u12 then
            u24 = Instance.new("AudioEmitter", v28);
        else
            u24 = Instance.new("AudioEmitter", v27);
        end;
        u24.Name = "RbxCharacterSoundsEmitter";
        u24:SetDistanceAttenuation(v30);
        for v31, v32 in pairs(u18) do
            local v33 = Instance.new("AudioPlayer");
            local v34 = Instance.new("Wire");
            v33.Name = v31;
            v34.Name = v31 .. "Wire";
            v33.Archivable = false;
            v33.Volume = 0.65;
            for v35, v36 in pairs(v32) do
                v33[v35] = v36;
            end;
            v33.Parent = l__rootPart__6;
            v34.Parent = v33;
            v34.SourceInstance = v33;
            v34.TargetInstance = u24;
            u26[v31] = v33;
        end;
    else
        for v37, v38 in pairs(u17) do
            local v39 = Instance.new("Sound");
            v39.Name = v37;
            v39.Archivable = false;
            v39.RollOffMinDistance = 5;
            v39.RollOffMaxDistance = 150;
            v39.Volume = 0.65;
            for v40, v41 in pairs(v38) do
                v39[v40] = v41;
            end;
            v39.Parent = l__rootPart__6;
            u26[v37] = v39;
        end;
    end;
    local u42 = {};
    local function u50(p43) --[[ Line: 241 ]]
        -- upvalues: u42 (copy), u8 (ref)
        local v44 = pairs;
        local v45 = {};
        local v46 = p43 or nil;
        for v47, v48 in pairs(u42) do
            v45[v47] = v48;
        end;
        for v49 in v44(v45) do
            if v49 ~= v46 then
                if u8 and v49:IsA("AudioPlayer") then
                    v49:Stop();
                else
                    v49.Playing = false;
                end;
                u42[v49] = nil;
            end;
        end;
    end;
    local u53 = {
        [Enum.HumanoidStateType.FallingDown] = function() --[[ Line: 253 ]]
            -- upvalues: u50 (copy)
            u50();
        end,
        [Enum.HumanoidStateType.GettingUp] = function() --[[ Line: 257 ]]
            -- upvalues: u50 (copy), u26 (copy), u8 (ref)
            u50();
            local l__GettingUp__7 = u26.GettingUp;
            l__GettingUp__7.TimePosition = 0;
            if u8 and l__GettingUp__7:IsA("AudioPlayer") then
                l__GettingUp__7:Play();
            else
                l__GettingUp__7.Playing = true;
            end;
        end,
        [Enum.HumanoidStateType.Jumping] = function() --[[ Line: 262 ]]
            -- upvalues: u50 (copy), u26 (copy), u8 (ref)
            u50();
            local l__Jumping__8 = u26.Jumping;
            l__Jumping__8.TimePosition = 0;
            if u8 and l__Jumping__8:IsA("AudioPlayer") then
                l__Jumping__8:Play();
            else
                l__Jumping__8.Playing = true;
            end;
        end,
        [Enum.HumanoidStateType.Swimming] = function() --[[ Line: 267 ]]
            -- upvalues: l__rootPart__6 (copy), u26 (copy), u8 (ref), u50 (copy), u42 (copy)
            local v51 = math.abs(l__rootPart__6.AssemblyLinearVelocity.Y);
            if v51 > 0.1 then
                u26.Splash.Volume = math.clamp((v51 - 100) * 0.72 / 250 + 0.28, 0, 1);
                local l__Splash__9 = u26.Splash;
                l__Splash__9.TimePosition = 0;
                if u8 and l__Splash__9:IsA("AudioPlayer") then
                    l__Splash__9:Play();
                else
                    l__Splash__9.Playing = true;
                end;
            end;
            u50(u26.Swimming);
            local l__Swimming__10 = u26.Swimming;
            if u8 and l__Swimming__10:IsA("AudioPlayer") then
                l__Swimming__10:Play();
            else
                l__Swimming__10.Playing = true;
            end;
            u42[u26.Swimming] = true;
        end,
        [Enum.HumanoidStateType.Freefall] = function() --[[ Line: 278 ]]
            -- upvalues: u26 (copy), u50 (copy), u8 (ref), u42 (copy)
            u26.FreeFalling.Volume = 0;
            u50(u26.FreeFalling);
            local l__FreeFalling__11 = u26.FreeFalling;
            if u8 and l__FreeFalling__11:IsA("AudioPlayer") then
                l__FreeFalling__11.Looping = true;
            else
                l__FreeFalling__11.Looped = true;
            end;
            if u26.FreeFalling:IsA("Sound") then
                u26.FreeFalling.PlaybackRegionsEnabled = true;
            end;
            u26.FreeFalling.LoopRegion = NumberRange.new(2, 9);
            local l__FreeFalling__12 = u26.FreeFalling;
            l__FreeFalling__12.TimePosition = 0;
            if u8 and l__FreeFalling__12:IsA("AudioPlayer") then
                l__FreeFalling__12:Play();
            else
                l__FreeFalling__12.Playing = true;
            end;
            u42[u26.FreeFalling] = true;
        end,
        [Enum.HumanoidStateType.Landed] = function() --[[ Line: 292 ]]
            -- upvalues: u50 (copy), l__rootPart__6 (copy), u26 (copy), u8 (ref)
            u50();
            local v52 = math.abs(l__rootPart__6.AssemblyLinearVelocity.Y);
            if v52 > 75 then
                u26.Landing.Volume = math.clamp((v52 - 50) * 1 / 50 + 0, 0, 1);
                local l__Landing__13 = u26.Landing;
                l__Landing__13.TimePosition = 0;
                if u8 and l__Landing__13:IsA("AudioPlayer") then
                    l__Landing__13:Play();
                    return;
                end;
                l__Landing__13.Playing = true;
            end;
        end,
        [Enum.HumanoidStateType.Running] = function() --[[ Line: 301 ]]
            -- upvalues: u50 (copy), u26 (copy), u8 (ref), u42 (copy)
            u50(u26.Running);
            local l__Running__14 = u26.Running;
            if u8 and l__Running__14:IsA("AudioPlayer") then
                l__Running__14:Play();
            else
                l__Running__14.Playing = true;
            end;
            u42[u26.Running] = true;
        end,
        [Enum.HumanoidStateType.Climbing] = function() --[[ Line: 307 ]]
            -- upvalues: u26 (copy), l__rootPart__6 (copy), u4 (ref), u22 (ref), u25 (ref), u8 (ref), u50 (copy), u42 (copy)
            local l__Climbing__15 = u26.Climbing;
            local l__AssemblyLinearVelocity__16 = l__rootPart__6.AssemblyLinearVelocity;
            if u4 then
                l__AssemblyLinearVelocity__16 = u22(u25, l__AssemblyLinearVelocity__16);
            end;
            if math.abs(l__AssemblyLinearVelocity__16.Y) > 0.1 then
                if u8 and l__Climbing__15:IsA("AudioPlayer") then
                    l__Climbing__15:Play();
                else
                    l__Climbing__15.Playing = true;
                end;
                u50(l__Climbing__15);
            else
                u50();
            end;
            u42[l__Climbing__15] = true;
        end,
        [Enum.HumanoidStateType.Seated] = function() --[[ Line: 320 ]]
            -- upvalues: u50 (copy)
            u50();
        end,
        [Enum.HumanoidStateType.Dead] = function() --[[ Line: 324 ]]
            -- upvalues: u50 (copy), u26 (copy), u8 (ref)
            u50();
            local l__Died__17 = u26.Died;
            l__Died__17.TimePosition = 0;
            if u8 and l__Died__17:IsA("AudioPlayer") then
                l__Died__17:Play();
            else
                l__Died__17.Playing = true;
            end;
        end
    };
    local u63 = {
        [u26.Climbing] = function(_, p54, p55) --[[ Line: 332 ]]
            -- upvalues: u4 (ref), u22 (ref), u25 (ref), u8 (ref)
            if u4 then
                p55 = u22(u25, p55);
            end;
            local v56 = p55.Magnitude > 0.1;
            if u8 and p54:IsA("AudioPlayer") then
                if p54.IsPlaying and not v56 then
                    p54:Stop();
                    return;
                end;
                if not p54.IsPlaying and v56 then
                    p54:Play();
                end;
            else
                p54.Playing = v56;
            end;
        end,
        [u26.FreeFalling] = function(p57, p58, p59) --[[ Line: 337 ]]
            if p59.Magnitude > 75 then
                p58.Volume = math.clamp(p58.Volume + p57 * 0.9, 0, 1);
            else
                p58.Volume = 0;
            end;
        end,
        [u26.Running] = function(_, p60, p61) --[[ Line: 345 ]]
            -- upvalues: l__humanoid__5 (copy), u8 (ref)
            local v62;
            if p61.Magnitude > 0.5 then
                v62 = l__humanoid__5.MoveDirection.Magnitude > 0.5;
            else
                v62 = false;
            end;
            if u8 and p60:IsA("AudioPlayer") then
                if p60.IsPlaying and not v62 then
                    p60:Stop();
                    return;
                end;
                if not p60.IsPlaying and v62 then
                    p60:Play();
                end;
            else
                p60.Playing = v62;
            end;
        end
    };
    local u64 = {
        [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    };
    local u65 = u64[l__humanoid__5:GetState()] or l__humanoid__5:GetState();
    local v66 = u65;
    local v67 = u53[v66];
    if v67 then
        v67();
    end;
    u65 = v66;
    local u71 = l__humanoid__5.StateChanged:Connect(function(_, p68) --[[ Line: 369 ]]
        -- upvalues: u64 (copy), u65 (ref), u53 (copy)
        local v69 = u64[p68] or p68;
        if v69 ~= u65 then
            local v70 = u53[v69];
            if v70 then
                v70();
            end;
            u65 = v69;
        end;
    end);
    local u75 = l__RunService__2.Stepped:Connect(function(_, p72) --[[ Line: 377 ]]
        -- upvalues: u42 (copy), u63 (copy), l__rootPart__6 (copy)
        for v73 in pairs(u42) do
            local v74 = u63[v73];
            if v74 then
                v74(p72, v73, l__rootPart__6.AssemblyLinearVelocity);
            end;
        end;
    end);
    return function() --[[ Name: terminate, Line 388 ]]
        -- upvalues: u71 (copy), u75 (copy), u16 (ref), u24 (ref), u26 (copy)
        u71:Disconnect();
        u75:Disconnect();
        if u16 and u24 then
            u24:Destroy();
        end;
        for _, v76 in pairs(u26) do
            v76:Destroy();
        end;
        table.clear(u26);
    end;
end);
local u78 = {};
local function u80(p79) --[[ Line: 415 ]]
    -- upvalues: u77 (copy)
    u77:bindRoot(p79);
end;
local function u82(p81) --[[ Line: 419 ]]
    -- upvalues: u77 (copy)
    u77:unbindRoot(p81);
end;
local function v85(p83) --[[ Line: 423 ]]
    -- upvalues: u78 (copy), u77 (copy), u80 (copy), u82 (copy)
    local v84 = u78[p83];
    if not v84 then
        v84 = {};
        u78[p83] = v84;
    end;
    if p83.Character then
        u77:bindRoot(p83.Character);
    end;
    table.insert(v84, p83.CharacterAdded:Connect(u80));
    table.insert(v84, p83.CharacterRemoving:Connect(u82));
end;
local function v89(p86) --[[ Line: 437 ]]
    -- upvalues: u78 (copy), u77 (copy)
    local v87 = u78[p86];
    if v87 then
        for _, v88 in ipairs(v87) do
            v88:Disconnect();
        end;
        u78[p86] = nil;
    end;
    if p86.Character then
        u77:unbindRoot(p86.Character);
    end;
end;
for _, v90 in ipairs(l__Players__1:GetPlayers()) do
    task.spawn(v85, v90);
end;
l__Players__1.PlayerAdded:Connect(v85);
l__Players__1.PlayerRemoving:Connect(v89);