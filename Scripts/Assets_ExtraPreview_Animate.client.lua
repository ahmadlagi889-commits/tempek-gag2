-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Torso__2 = l__Parent__1:WaitForChild("Torso");
local u1 = l__Torso__2:WaitForChild("Right Shoulder");
local u2 = l__Torso__2:WaitForChild("Left Shoulder");
local u3 = l__Torso__2:WaitForChild("Right Hip");
local u4 = l__Torso__2:WaitForChild("Left Hip");
l__Torso__2:WaitForChild("Neck");
local l__Humanoid__3 = l__Parent__1:WaitForChild("Humanoid");
local u5 = "Standing";
local u6 = "";
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = 1;
local u11 = {};
local u12 = {
    idle = {
        {
            id = "http://www.roblox.com/asset/?id=180435571",
            weight = 9
        },
        {
            id = "http://www.roblox.com/asset/?id=180435792",
            weight = 1
        }
    },
    walk = {
        {
            id = "http://www.roblox.com/asset/?id=180426354",
            weight = 10
        }
    },
    run = {
        {
            id = "run.xml",
            weight = 10
        }
    },
    jump = {
        {
            id = "http://www.roblox.com/asset/?id=125750702",
            weight = 10
        }
    },
    fall = {
        {
            id = "http://www.roblox.com/asset/?id=180436148",
            weight = 10
        }
    },
    climb = {
        {
            id = "http://www.roblox.com/asset/?id=180436334",
            weight = 10
        }
    },
    sit = {
        {
            id = "http://www.roblox.com/asset/?id=178130996",
            weight = 10
        }
    },
    toolnone = {
        {
            id = "http://www.roblox.com/asset/?id=182393478",
            weight = 10
        }
    },
    toolslash = {
        {
            id = "http://www.roblox.com/asset/?id=129967390",
            weight = 10
        }
    },
    toollunge = {
        {
            id = "http://www.roblox.com/asset/?id=129967478",
            weight = 10
        }
    },
    wave = {
        {
            id = "http://www.roblox.com/asset/?id=128777973",
            weight = 10
        }
    },
    point = {
        {
            id = "http://www.roblox.com/asset/?id=128853357",
            weight = 10
        }
    },
    dance1 = {
        {
            id = "http://www.roblox.com/asset/?id=182435998",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491037",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491065",
            weight = 10
        }
    },
    dance2 = {
        {
            id = "http://www.roblox.com/asset/?id=182436842",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491248",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491277",
            weight = 10
        }
    },
    dance3 = {
        {
            id = "http://www.roblox.com/asset/?id=182436935",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491368",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=182491423",
            weight = 10
        }
    },
    laugh = {
        {
            id = "http://www.roblox.com/asset/?id=129423131",
            weight = 10
        }
    },
    cheer = {
        {
            id = "http://www.roblox.com/asset/?id=129423030",
            weight = 10
        }
    }
};
local u13 = { "dance1", "dance2", "dance3" };
local u14 = {
    wave = false,
    point = false,
    dance1 = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
function configureAnimationSet(u15, u16)
    -- upvalues: u11 (copy)
    if u11[u15] ~= nil then
        for _, v17 in pairs(u11[u15].connections) do
            v17:disconnect();
        end;
    end;
    u11[u15] = {};
    u11[u15].count = 0;
    u11[u15].totalWeight = 0;
    u11[u15].connections = {};
    local v18 = script:FindFirstChild(u15);
    if v18 ~= nil then
        table.insert(u11[u15].connections, v18.ChildAdded:connect(function(_) --[[ Line: 106 ]]
            -- upvalues: u15 (copy), u16 (copy)
            configureAnimationSet(u15, u16);
        end));
        table.insert(u11[u15].connections, v18.ChildRemoved:connect(function(_) --[[ Line: 107 ]]
            -- upvalues: u15 (copy), u16 (copy)
            configureAnimationSet(u15, u16);
        end));
        local v19 = 1;
        for _, v20 in pairs(v18:GetChildren()) do
            if v20:IsA("Animation") then
                table.insert(u11[u15].connections, v20.Changed:connect(function(_) --[[ Line: 111 ]]
                    -- upvalues: u15 (copy), u16 (copy)
                    configureAnimationSet(u15, u16);
                end));
                u11[u15][v19] = {};
                u11[u15][v19].anim = v20;
                local v21 = v20:FindFirstChild("Weight");
                if v21 == nil then
                    u11[u15][v19].weight = 1;
                else
                    u11[u15][v19].weight = v21.Value;
                end;
                u11[u15].count = u11[u15].count + 1;
                u11[u15].totalWeight = u11[u15].totalWeight + u11[u15][v19].weight;
                v19 = v19 + 1;
            end;
        end;
    end;
    if u11[u15].count <= 0 then
        for v22, v23 in pairs(u16) do
            u11[u15][v22] = {};
            u11[u15][v22].anim = Instance.new("Animation");
            u11[u15][v22].anim.Name = u15;
            u11[u15][v22].anim.AnimationId = v23.id;
            u11[u15][v22].weight = v23.weight;
            u11[u15].count = u11[u15].count + 1;
            u11[u15].totalWeight = u11[u15].totalWeight + v23.weight;
        end;
    end;
end;
function scriptChildModified(p24)
    -- upvalues: u12 (copy)
    local v25 = u12[p24.Name];
    if v25 ~= nil then
        configureAnimationSet(p24.Name, v25);
    end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v26;
if l__Humanoid__3 then
    v26 = l__Humanoid__3:FindFirstChildOfClass("Animator");
else
    v26 = nil;
end;
if v26 then
    local v27 = v26:GetPlayingAnimationTracks();
    for _, v28 in ipairs(v27) do
        v28:Stop(0);
        v28:Destroy();
    end;
end;
for v29, v30 in pairs(u12) do
    configureAnimationSet(v29, v30);
end;
local u31 = "None";
local u32 = 0;
local u33 = 0;
function stopAllAnimations()
    -- upvalues: u6 (ref), u14 (copy), u7 (ref), u9 (ref), u8 (ref)
    local v34 = u6;
    local v35 = u14[v34] ~= nil and u14[v34] == false and "idle" or v34;
    u6 = "";
    u7 = nil;
    if u9 ~= nil then
        u9:disconnect();
    end;
    if u8 ~= nil then
        u8:Stop();
        u8:Destroy();
        u8 = nil;
    end;
    return v35;
end;
function setAnimationSpeed(p36)
    -- upvalues: u10 (ref), u8 (ref)
    if p36 ~= u10 then
        u10 = p36;
        u8:AdjustSpeed(u10);
    end;
end;
function keyFrameReachedFunc(p37)
    -- upvalues: u6 (ref), u14 (copy), u10 (ref), l__Humanoid__3 (copy)
    if p37 == "End" then
        local v38 = u6;
        local v39 = u10;
        playAnimation(u14[v38] ~= nil and u14[v38] == false and "idle" or v38, 0, l__Humanoid__3);
        setAnimationSpeed(v39);
    end;
end;
function playAnimation(p40, p41, p42)
    -- upvalues: u11 (copy), u7 (ref), u8 (ref), u10 (ref), u6 (ref), u9 (ref)
    local v43 = math.random(1, u11[p40].totalWeight);
    local v44 = 1;
    while u11[p40][v44].weight < v43 do
        v43 = v43 - u11[p40][v44].weight;
        v44 = v44 + 1;
    end;
    local l__anim__4 = u11[p40][v44].anim;
    if l__anim__4 ~= u7 then
        if u8 ~= nil then
            u8:Stop(p41);
            u8:Destroy();
        end;
        u10 = 1;
        u8 = p42:LoadAnimation(l__anim__4);
        u8.Priority = Enum.AnimationPriority.Core;
        u8:Play(p41);
        u6 = p40;
        u7 = l__anim__4;
        if u9 ~= nil then
            u9:disconnect();
        end;
        u9 = u8.KeyframeReached:connect(keyFrameReachedFunc);
    end;
end;
local u45 = "";
local u46 = nil;
local u47 = nil;
local u48 = nil;
function toolKeyFrameReachedFunc(p49)
    -- upvalues: u45 (ref), l__Humanoid__3 (copy)
    if p49 == "End" then
        playToolAnimation(u45, 0, l__Humanoid__3);
    end;
end;
function playToolAnimation(p50, p51, p52, p53)
    -- upvalues: u11 (copy), u47 (ref), u46 (ref), u45 (ref), u48 (ref)
    local v54 = math.random(1, u11[p50].totalWeight);
    local v55 = 1;
    while u11[p50][v55].weight < v54 do
        v54 = v54 - u11[p50][v55].weight;
        v55 = v55 + 1;
    end;
    local l__anim__5 = u11[p50][v55].anim;
    if u47 ~= l__anim__5 then
        if u46 ~= nil then
            u46:Stop();
            u46:Destroy();
            p51 = 0;
        end;
        u46 = p52:LoadAnimation(l__anim__5);
        if p53 then
            u46.Priority = p53;
        end;
        u46:Play(p51);
        u45 = p50;
        u47 = l__anim__5;
        u48 = u46.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;
function stopToolAnimations()
    -- upvalues: u45 (ref), u48 (ref), u47 (ref), u46 (ref)
    local v56 = u45;
    if u48 ~= nil then
        u48:disconnect();
    end;
    u45 = "";
    u47 = nil;
    if u46 ~= nil then
        u46:Stop();
        u46:Destroy();
        u46 = nil;
    end;
    return v56;
end;
function onRunning(p57)
    -- upvalues: l__Parent__1 (copy), l__Humanoid__3 (copy), u7 (ref), u5 (ref), u14 (copy), u6 (ref)
    local v58 = p57 / l__Parent__1:GetScale();
    if v58 > 0.01 then
        playAnimation("walk", 0.1, l__Humanoid__3);
        if u7 and u7.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
            setAnimationSpeed(v58 / 14.5);
        end;
        u5 = "Running";
    else
        if u14[u6] == nil then
            playAnimation("idle", 0.1, l__Humanoid__3);
            u5 = "Standing";
        end;
    end;
end;
function onDied()
    -- upvalues: u5 (ref)
    u5 = "Dead";
end;
function onJumping()
    -- upvalues: l__Humanoid__3 (copy), u33 (ref), u5 (ref)
    playAnimation("jump", 0.1, l__Humanoid__3);
    u33 = 0.3;
    u5 = "Jumping";
end;
function onClimbing(p59)
    -- upvalues: l__Parent__1 (copy), l__Humanoid__3 (copy), u5 (ref)
    local v60 = p59 / l__Parent__1:GetScale();
    playAnimation("climb", 0.1, l__Humanoid__3);
    setAnimationSpeed(v60 / 12);
    u5 = "Climbing";
end;
function onGettingUp()
    -- upvalues: u5 (ref)
    u5 = "GettingUp";
end;
function onFreeFall()
    -- upvalues: u33 (ref), l__Humanoid__3 (copy), u5 (ref)
    if u33 <= 0 then
        playAnimation("fall", 0.3, l__Humanoid__3);
    end;
    u5 = "FreeFall";
end;
function onFallingDown()
    -- upvalues: u5 (ref)
    u5 = "FallingDown";
end;
function onSeated()
    -- upvalues: u5 (ref)
    u5 = "Seated";
end;
function onPlatformStanding()
    -- upvalues: u5 (ref)
    u5 = "PlatformStanding";
end;
function onSwimming(p61)
    -- upvalues: u5 (ref)
    if p61 > 0 then
        u5 = "Running";
    else
        u5 = "Standing";
    end;
end;
function getTool()
    -- upvalues: l__Parent__1 (copy)
    for _, v62 in ipairs(l__Parent__1:GetChildren()) do
        if v62.className == "Tool" then
            return v62;
        end;
    end;
    return nil;
end;
function getToolAnim(p63)
    for _, v64 in ipairs(p63:GetChildren()) do
        if v64.Name == "toolanim" and v64.className == "StringValue" then
            return v64;
        end;
    end;
    return nil;
end;
function animateTool()
    -- upvalues: u31 (ref), l__Humanoid__3 (copy)
    if u31 == "None" then
        playToolAnimation("toolnone", 0.1, l__Humanoid__3, Enum.AnimationPriority.Idle);
    elseif u31 == "Slash" then
        playToolAnimation("toolslash", 0, l__Humanoid__3, Enum.AnimationPriority.Action);
    elseif u31 == "Lunge" then
        playToolAnimation("toollunge", 0, l__Humanoid__3, Enum.AnimationPriority.Action);
    end;
end;
function moveSit()
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    u1.MaxVelocity = 0.15;
    u2.MaxVelocity = 0.15;
    u1:SetDesiredAngle(1.57);
    u2:SetDesiredAngle(-1.57);
    u3:SetDesiredAngle(1.57);
    u4:SetDesiredAngle(-1.57);
end;
local u65 = 0;
function move(p66)
    -- upvalues: u65 (ref), u33 (ref), u5 (ref), l__Humanoid__3 (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u31 (ref), u32 (ref), u47 (ref)
    local v67 = 1;
    local v68 = 1;
    local v69 = p66 - u65;
    u65 = p66;
    local v70 = false;
    if u33 > 0 then
        u33 = u33 - v69;
    end;
    if u5 == "FreeFall" and u33 <= 0 then
        playAnimation("fall", 0.3, l__Humanoid__3);
    else
        if u5 == "Seated" then
            playAnimation("sit", 0.5, l__Humanoid__3);
            return;
        end;
        if u5 == "Running" then
            playAnimation("walk", 0.1, l__Humanoid__3);
        elseif u5 == "Dead" or (u5 == "GettingUp" or (u5 == "FallingDown" or (u5 == "Seated" or u5 == "PlatformStanding"))) then
            stopAllAnimations();
            v70 = true;
            v68 = 1;
            v67 = 0.1;
        end;
    end;
    if v70 then
        local v71 = v67 * math.sin(p66 * v68);
        u1:SetDesiredAngle(v71 + 0);
        u2:SetDesiredAngle(v71 - 0);
        u3:SetDesiredAngle(-v71);
        u4:SetDesiredAngle(-v71);
    end;
    local v72 = getTool();
    if v72 and v72:FindFirstChild("Handle") then
        local v73 = getToolAnim(v72);
        if v73 then
            u31 = v73.Value;
            v73.Parent = nil;
            u32 = p66 + 0.3;
        end;
        if u32 < p66 then
            u32 = 0;
            u31 = "None";
        end;
        animateTool();
    else
        stopToolAnimations();
        u31 = "None";
        u47 = nil;
        u32 = 0;
    end;
end;
l__Humanoid__3.Died:connect(onDied);
l__Humanoid__3.Running:connect(onRunning);
l__Humanoid__3.Jumping:connect(onJumping);
l__Humanoid__3.Climbing:connect(onClimbing);
l__Humanoid__3.GettingUp:connect(onGettingUp);
l__Humanoid__3.FreeFalling:connect(onFreeFall);
l__Humanoid__3.FallingDown:connect(onFallingDown);
l__Humanoid__3.Seated:connect(onSeated);
l__Humanoid__3.PlatformStanding:connect(onPlatformStanding);
l__Humanoid__3.Swimming:connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:connect(function(p74) --[[ Line: 533 ]]
    -- upvalues: u13 (copy), u5 (ref), u14 (copy), l__Humanoid__3 (copy)
    local v75 = "";
    if p74 == "/e dance" then
        v75 = u13[math.random(1, #u13)];
    elseif string.sub(p74, 1, 3) == "/e " then
        v75 = string.sub(p74, 4);
    elseif string.sub(p74, 1, 7) == "/emote " then
        v75 = string.sub(p74, 8);
    end;
    if u5 == "Standing" and u14[v75] ~= nil then
        playAnimation(v75, 0.1, l__Humanoid__3);
    end;
end);
script:WaitForChild("PlayEmote").OnInvoke = function(p76) --[[ Line: 550 ]]
    -- upvalues: u5 (ref), u14 (copy), l__Humanoid__3 (copy), u8 (ref)
    if u5 == "Standing" then
        if u14[p76] == nil then
            return false;
        end;
        playAnimation(p76, 0.1, l__Humanoid__3);
        return true, u8;
    end;
end;
playAnimation("idle", 0.1, l__Humanoid__3);
local _ = "Standing";
while l__Parent__1.Parent ~= nil do
    local _, v77 = wait(0.1);
    move(v77);
end;