-- Decompiled with Potassium's decompiler.

local l__TopText__1 = require(game.ReplicatedStorage.ClientModules.TopText);
task.wait(math.random(8, 12) * 0.2);
if script and (script.Parent and script.Parent ~= nil) then
    l__TopText__1.TakeAwayResponses(script.Parent.Parent.Parent, game.Players.LocalPlayer);
end;