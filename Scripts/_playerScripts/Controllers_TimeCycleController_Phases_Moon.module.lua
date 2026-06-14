-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Lighting__3 = game:GetService("Lighting");
local l__Debris__4 = game:GetService("Debris");
local l__LightingController__5 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__LocalPlayer__6 = game.Players.LocalPlayer;
local u2 = {
    Brightness = 3,
    ClockTime = 3.1,
    Ambient = Color3.new(0.823529, 0.823529, 0.823529),
    ColorShift_Bottom = Color3.new(0.160784, 0.196078, 0.670588),
    ColorShift_Top = Color3.new(0.603922, 0.8, 0.980392),
    OutdoorAmbient = Color3.new(0.34902, 0.419608, 0.4)
};
local u3 = nil;
local u4 = false;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = game.SoundService.SFX["Werewolf Howl"];
local function u17() --[[ Line: 36 ]]
    -- upvalues: l__LocalPlayer__6 (copy)
    local v12 = l__LocalPlayer__6:GetAttribute("IsInOwnGarden") and 0.4 or 0.56;
    local v13 = l__LocalPlayer__6:FindFirstChild("FogDensityClear");
    local v14 = v13 and v13.Value or 0;
    local v15 = l__LocalPlayer__6:FindFirstChild("OwlNightVisionMult");
    local v16 = v15 and v15.Value or 1;
    return math.clamp((v12 - v14) / (v16 <= 0 and 1 or v16), 0, 1);
end;
local function u22(p18, p19, u20) --[[ Line: 55 ]]
    -- upvalues: u5 (ref), u10 (ref), l__TweenService__2 (copy)
    if u5 then
        if u10 then
            u10:Cancel();
            u10:Destroy();
            u10 = nil;
        end;
        local u21 = l__TweenService__2:Create(u5, TweenInfo.new(p19, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Density = p18
        });
        u10 = u21;
        if u20 then
            u21.Completed:Once(function(_) --[[ Line: 70 ]]
                -- upvalues: u10 (ref), u21 (copy), u20 (copy)
                if u10 == u21 then
                    u10 = nil;
                end;
                u21:Destroy();
                u20();
            end);
        else
            u21.Completed:Once(function() --[[ Line: 78 ]]
                -- upvalues: u10 (ref), u21 (copy)
                if u10 == u21 then
                    u10 = nil;
                end;
                u21:Destroy();
            end);
        end;
        u21:Play();
    end;
end;
local function u23() --[[ Line: 93 ]]
    -- upvalues: u4 (ref), u5 (ref), l__LocalPlayer__6 (copy), u22 (copy), u17 (copy)
    if u4 then
        if u5 then
            if l__LocalPlayer__6:GetAttribute("OfflineCutscenePlaying") == true then
                u22(0, 0.5);
            else
                u22(u17(), 1.5);
            end;
        end;
    end;
end;
local function u25() --[[ Line: 106 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u5 (ref), l__Lighting__3 (copy), l__LocalPlayer__6 (copy), u22 (copy), u17 (copy)
    local v24 = l__ReplicatedStorage__1.Assets:FindFirstChild("NightAtmosphere");
    if v24 then
        if not u5 then
            u5 = v24:Clone();
            u5.Name = "ActiveNightAtmosphere";
            u5.Density = 0;
            u5.Parent = l__Lighting__3;
        end;
        if l__LocalPlayer__6:GetAttribute("OfflineCutscenePlaying") == true then
            u22(0, 0.5);
        else
            u22(u17(), 1.5);
        end;
    end;
end;
TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local function u33() --[[ Line: 142 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u3 (ref), l__TweenService__2 (copy), l__Debris__4 (copy)
    local v26 = l__ReplicatedStorage__1.Assets:FindFirstChild("Night");
    if v26 then
        u3 = v26:Clone();
        u3.Name = "ActiveNight";
        u3.Parent = workspace;
        local v27 = {};
        for _, v28 in u3:GetDescendants() do
            if v28:IsA("BasePart") then
                if v28:GetAttribute("OGTransparency") == nil then
                    v28:SetAttribute("OGTransparency", v28.Transparency);
                end;
                v28.Transparency = 1;
                table.insert(v27, v28);
            end;
        end;
        local u29 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        for v30, u31 in v27 do
            task.delay(v30 * 0.05, function() --[[ Line: 165 ]]
                -- upvalues: l__TweenService__2 (ref), u31 (copy), u29 (copy), l__Debris__4 (ref)
                local v32 = l__TweenService__2:Create(u31, u29, {
                    Transparency = u31:GetAttribute("OGTransparency")
                });
                v32:Play();
                l__Debris__4:AddItem(v32, u29.Time);
            end);
        end;
    end;
end;
local function u40() --[[ Line: 174 ]]
    -- upvalues: u3 (ref), l__TweenService__2 (copy), l__Debris__4 (copy)
    if u3 then
        local v34 = {};
        for _, v35 in u3:GetDescendants() do
            if v35:IsA("BasePart") then
                table.insert(v34, v35);
            end;
        end;
        local v36 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        for _, v37 in v34 do
            local v38 = l__TweenService__2:Create(v37, v36, {
                Transparency = 1
            });
            v38:Play();
            l__Debris__4:AddItem(v38, v36.Time);
        end;
        local u39 = u3;
        task.delay(2.1, function() --[[ Line: 193 ]]
            -- upvalues: u39 (copy)
            if u39 and u39.Parent then
                u39:Destroy();
            end;
        end);
        u3 = nil;
    end;
end;
function v1.Start(_, _, _) --[[ Line: 201 ]]
    -- upvalues: u4 (ref), u11 (copy), l__LightingController__5 (copy), u2 (copy), u33 (copy), u25 (copy), u6 (ref), l__LocalPlayer__6 (copy), u23 (copy), u7 (ref), u8 (ref), u9 (ref)
    u4 = true;
    u11.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    u11.Playing = true;
    u11.TimePosition = 0;
    l__LightingController__5:TransitionTo(u2);
    u33();
    u25();
    u6 = l__LocalPlayer__6:GetAttributeChangedSignal("IsInOwnGarden"):Connect(u23);
    local v41 = l__LocalPlayer__6:FindFirstChild("FogDensityClear");
    if v41 then
        u7 = v41.Changed:Connect(u23);
    end;
    local v42 = l__LocalPlayer__6:FindFirstChild("OwlNightVisionMult");
    if v42 then
        u8 = v42.Changed:Connect(u23);
    end;
    u9 = l__LocalPlayer__6:GetAttributeChangedSignal("OfflineCutscenePlaying"):Connect(u23);
end;
function v1.End(_) --[[ Line: 231 ]]
    -- upvalues: u4 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u40 (copy), u5 (ref), u22 (copy)
    u4 = false;
    if u6 then
        u6:Disconnect();
        u6 = nil;
    end;
    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;
    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;
    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;
    u40();
    if u5 then
        u22(0, 2, function() --[[ Line: 132 ]]
            -- upvalues: u5 (ref)
            if u5 then
                u5:Destroy();
                u5 = nil;
            end;
        end);
    end;
end;
return v1;