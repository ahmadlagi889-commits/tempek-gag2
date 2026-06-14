-- Decompiled with Potassium's decompiler.

game:GetService("LocalizationService");
game:GetService("Players");
game.Players.LocalPlayer.PlayerGui:WaitForChild("BackpackGui");
local _ = nil;
local _ = nil;
local _ = nil;
local _ = nil;
local v1 = Instance.new("BindableEvent");
local _ = {};
return {
    LocaleChanged = v1.Event,
    TranslateGameText = function(_, _, p2) --[[ Name: TranslateGameText, Line 102 ]]
        return p2;
    end,
    TranslateAndRegister = function(_, _, _, p3) --[[ Name: TranslateAndRegister, Line 125 ]]
        return p3;
    end
};