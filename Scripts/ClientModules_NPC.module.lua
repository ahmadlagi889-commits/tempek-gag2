-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ClientModules__1 = game:GetService("ReplicatedStorage"):WaitForChild("ClientModules");
local l__FieldOfViewController__2 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__FramePopup__3 = require(l__ClientModules__1.FramePopup);
local u2 = false;
function v1.CanSpeak() --[[ Line: 12 ]]
    -- upvalues: u2 (ref)
    return not u2;
end;
function v1.StartSpeaking() --[[ Line: 16 ]]
    -- upvalues: u2 (ref), l__FieldOfViewController__2 (copy)
    u2 = true;
    l__FieldOfViewController__2:SetAdjuster(-5);
end;
function v1.EndSpeaking() --[[ Line: 21 ]]
    -- upvalues: u2 (ref), l__FramePopup__3 (copy), l__FieldOfViewController__2 (copy)
    u2 = false;
    if l__FramePopup__3.CanInteract() then
        l__FieldOfViewController__2:ClearAdjuster();
    end;
end;
return v1;