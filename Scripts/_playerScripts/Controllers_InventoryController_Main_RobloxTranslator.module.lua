-- Decompiled with Potassium's decompiler.

local l__LocalizationService__1 = game:GetService("LocalizationService");
local l__PlayerGui__2 = game.Players.LocalPlayer.PlayerGui;
l__PlayerGui__2:WaitForChild("BackpackGui");
local l__Players__3 = game:GetService("Players");
if l__Players__3.LocalPlayer == nil then
    l__Players__3:GetPropertyChangedSignal("LocalPlayer"):Wait();
end;
local u1 = nil;
local u2 = {};
return {
    FormatByKey = function(_, p3, p4) --[[ Name: FormatByKey, Line 54 ]]
        -- upvalues: u1 (ref), l__PlayerGui__2 (copy), l__LocalizationService__1 (copy)
        if u1 == nil then
            u1 = l__PlayerGui__2.CoreScriptLocalization:GetTranslator(l__LocalizationService__1.RobloxLocaleId);
        end;
        return u1:FormatByKey(p3, p4);
    end,
    FormatByKeyForLocale = function(_, p5, p6, p7) --[[ Name: FormatByKeyForLocale, Line 62 ]]
        -- upvalues: u2 (copy), l__PlayerGui__2 (copy)
        local v8 = u2[p6];
        if not v8 then
            v8 = l__PlayerGui__2.CoreScriptLocalization:GetTranslator(p6);
            u2[p6] = v8;
        end;
        return v8:FormatByKey(p5, p7);
    end
};