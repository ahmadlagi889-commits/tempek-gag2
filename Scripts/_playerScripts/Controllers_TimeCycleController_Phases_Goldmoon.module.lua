-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("Lighting");
local l__TweenService__1 = game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
game:GetService("SoundService");
local l__Networking__4 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
local l__NotificationController__6 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__FieldOfViewController__7 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__LightingController__8 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
local l__Goldmoon__9 = l__ReplicatedStorage__2.Assets:WaitForChild("Goldmoon");
local l__Skybox__10 = require(game.ReplicatedStorage.ClientModules.Skybox);
local l__Goldmoon__11 = game.ReplicatedStorage.Assets.Skybox.Goldmoon;
local u2 = {
    Brightness = 4,
    EnvironmentDiffuseScale = 1,
    ClockTime = 21,
    Ambient = Color3.fromRGB(241, 175, 7),
    ColorShift_Bottom = Color3.fromRGB(35, 135, 171),
    ColorShift_Top = Color3.fromRGB(250, 218, 34),
    OutdoorAmbient = Color3.fromRGB(74, 139, 180)
};
local function u13(p3, p4, p5, p6, p7) --[[ Line: 45 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v8 = p3:GetScale();
    local v9 = p6 or Enum.EasingStyle.Linear;
    local v10 = p7 or Enum.EasingDirection.InOut;
    local v11 = 0;
    while v11 < p5 do
        v11 = v11 + task.wait(0);
        local v12 = l__TweenService__1:GetValue(math.clamp(v11 / p5, 0.01, 1), v9, v10);
        p3:ScaleTo(v8 + (p4 - v8) * v12);
    end;
end;
local u14 = nil;
local function v19(p15) --[[ Line: 73 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__Players__3 (copy), u14 (ref), l__LocalPlayer__5 (copy), l__FieldOfViewController__7 (copy), l__NotificationController__6 (copy)
    if p15:GetAttribute("Gold") then
    else
        p15:SetAttribute("Gold", true);
        for _, v16 in l__ReplicatedStorage__2.Assets.GoldEffect:GetChildren() do
            local v17 = v16:Clone();
            if v17:IsA("Highlight") then
                v17.Parent = p15;
            else
                v17.Parent = p15:WaitForChild("Torso");
            end;
            v17:AddTag("ClearUpGold");
        end;
        if p15 == l__Players__3.LocalPlayer.Character and not u14 then
            u14 = l__ReplicatedStorage__2.Assets.Vignette:Clone();
            u14.ImageLabel.ImageTransparency = 0.7;
            u14.ImageLabel.UIScale.Scale = 1;
            u14.ImageLabel.ImageColor3 = Color3.fromRGB(255, 234, 128);
            game.TweenService:Create(u14.ImageLabel.UIScale, TweenInfo.new(1), {
                Scale = 1.04
            }):Play();
            game.TweenService:Create(u14.ImageLabel, TweenInfo.new(1), {
                ImageTransparency = 0.8
            }):Play();
            u14.Parent = l__LocalPlayer__5.PlayerGui;
            local u18 = Instance.new("ColorCorrectionEffect");
            u18.Parent = game.Lighting;
            game.TweenService:Create(u18, TweenInfo.new(0.4), {
                Brightness = 0.4,
                TintColor = Color3.fromRGB(255, 223, 94)
            }):Play();
            game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
                FieldOfView = 90
            }):Play();
            task.delay(0.4, function() --[[ Line: 111 ]]
                -- upvalues: u18 (copy), l__FieldOfViewController__7 (ref)
                game.TweenService:Create(u18, TweenInfo.new(0.8), {
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                game.Debris:AddItem(u18, 0.8);
                game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.6), {
                    FieldOfView = 80
                }):Play();
                l__FieldOfViewController__7:SetBaseFOV(80);
            end);
            l__NotificationController__6:CreateNotification("You are " .. ("<font color=\"#" .. Color3.fromRGB(255, 204, 0):ToHex() .. "\">MIDAS!</font>") .. " Steal QUICK to get a " .. "<font color=\"#" .. Color3.fromRGB(255, 204, 0):ToHex() .. "\">GOLD PLANT!</font>", nil, 7);
        end;
    end;
end;
local function v24(p20) --[[ Line: 133 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__LocalPlayer__5 (copy), u14 (ref), l__FieldOfViewController__7 (copy)
    local v21 = l__ReplicatedStorage__2.Assets.GoldDisperse:Clone();
    v21.Parent = p20.HumanoidRootPart;
    for _, v22 in v21:GetChildren() do
        if v22:IsA("ParticleEmitter") then
            v22:Emit(v22:GetAttribute("EmitCount") or 3);
        elseif v22:IsA("Sound") then
            v22:Play();
        end;
    end;
    if p20 == l__LocalPlayer__5.Character and u14 then
        game.TweenService:Create(u14.ImageLabel.UIScale, TweenInfo.new(1), {
            Scale = 1.14
        }):Play();
        game.TweenService:Create(u14.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play();
        l__FieldOfViewController__7:SetBaseFOV(70);
        game.Debris:AddItem(u14, 1);
        u14 = nil;
    end;
    game.Debris:AddItem(v21, 3);
    p20:SetAttribute("Gold", nil);
    for _, v23 in p20:GetDescendants() do
        if v23:HasTag("ClearUpGold") then
            if v23:IsA("Highlight") then
                game.TweenService:Create(v23, TweenInfo.new(0.5), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play();
            elseif v23:IsA("ParticleEmitter") or v23:IsA("Trail") then
                v23.Enabled = false;
            end;
            game.Debris:AddItem(v23, 1);
        end;
    end;
end;
for _, v25 in game.CollectionService:GetTagged("GoldHighlight") do
    v19(v25);
end;
game.CollectionService:GetInstanceAddedSignal("GoldHighlight"):Connect(v19);
game.CollectionService:GetInstanceRemovedSignal("GoldHighlight"):Connect(v24);
l__Networking__4.WeatherEffects.GoldMoonStrike.OnClientEvent:Connect(function(p26) --[[ Line: 184 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy)
    local v27 = l__ReplicatedStorage__2.Assets.GoldMeteor:Clone();
    local v28 = CFrame.new(p26) * CFrame.new(0, 200, 250);
    v27.CFrame = v28;
    v27.Parent = workspace;
    v27.Travel:Play();
    local v29 = 0;
    while v29 < 2 do
        v29 = v29 + task.wait(0.025);
        local v30 = game.TweenService:GetValue(v29 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        v27:PivotTo(v28:Lerp(CFrame.new(p26), v30));
        v27.Attachment.BillboardGui.ImageLabel.Rotation = tick() * 720 % 360;
    end;
    v27.Poof:Play();
    v27.Attachment.BillboardGui.Enabled = false;
    for _, v31 in v27.Attachment.Attachment:GetChildren() do
        v31:Emit(v31:GetAttribute("EmitCount") or 5);
    end;
    game.Debris:AddItem(v27, 4);
end);
function v1.Start(_, _, _) --[[ Line: 240 ]]
    -- upvalues: l__NotificationController__6 (copy), l__LightingController__8 (copy), u2 (copy), l__Goldmoon__9 (copy), l__Skybox__10 (copy), l__Goldmoon__11 (copy), u13 (copy)
    if isActive then
    else
        isActive = true;
        l__NotificationController__6:CreateNotification("May midas grace you...");
        l__LightingController__8:TransitionTo(u2, 3);
        l__Goldmoon__9.Parent = workspace;
        task.delay(2, function() --[[ Line: 224 ]]
            -- upvalues: l__Goldmoon__9 (ref), l__Skybox__10 (ref), l__Goldmoon__11 (ref), u13 (ref)
            l__Goldmoon__9.MoonModel:ScaleTo(0.01);
            l__Skybox__10.SetOrder(l__Goldmoon__11, 2);
            u13(l__Goldmoon__9.MoonModel, 1, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        end);
    end;
end;
function v1.End(_) --[[ Line: 251 ]]
    -- upvalues: l__Goldmoon__9 (copy), l__ReplicatedStorage__2 (copy), l__Skybox__10 (copy), l__Goldmoon__11 (copy)
    if isActive then
        isActive = false;
        l__Goldmoon__9.Parent = l__ReplicatedStorage__2.Assets;
        l__Skybox__10.SetOrder(l__Goldmoon__11, 0);
    end;
end;
return v1;