-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__SoundService__3 = game:GetService("SoundService");
local l__LevelUpEffect__4 = require(l__ReplicatedStorage__2.ClientModules.Effects.LevelUpEffect);
local l__Networking__5 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__SkillPointSFX__7 = l__SoundService__3.SFX.SkillPointSFX;
return {
    Start = function(_) --[[ Name: Start, Line 16 ]]
        -- upvalues: l__Networking__5 (copy), l__SkillPointSFX__7 (copy), l__LocalPlayer__6 (copy), l__LevelUpEffect__4 (copy)
        if workspace:GetAttribute("SkillPointsOn") == true then
            l__Networking__5.SkillPoints.SkillPointEarned.OnClientEvent:Connect(function() --[[ Line: 23 ]]
                -- upvalues: l__SkillPointSFX__7 (ref), l__LocalPlayer__6 (ref), l__LevelUpEffect__4 (ref)
                l__SkillPointSFX__7.TimePosition = 0;
                l__SkillPointSFX__7.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                l__SkillPointSFX__7:Play();
                local l__Character__8 = l__LocalPlayer__6.Character;
                if l__Character__8 then
                    if l__Character__8:FindFirstChild("HumanoidRootPart") then
                        l__LevelUpEffect__4:Play(l__Character__8);
                    end;
                end;
            end);
        end;
    end
};