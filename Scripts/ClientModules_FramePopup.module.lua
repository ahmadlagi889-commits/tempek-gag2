-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ClientModules__1 = game:GetService("ReplicatedStorage"):WaitForChild("ClientModules");
local l__FieldOfViewController__2 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__Blur__3 = require(l__ClientModules__1.Blur);
local u2 = {};
function v1.Show(p3) --[[ Line: 12 ]]
    -- upvalues: u2 (copy), l__FieldOfViewController__2 (copy), l__Blur__3 (copy)
    if not table.find(u2, p3) then
        table.insert(u2, p3);
    end;
    l__FieldOfViewController__2.SetFov(60, 0.3);
    l__Blur__3.SetBlur(15, 0.1);
end;
function v1.Hide(p4) --[[ Line: 21 ]]
    -- upvalues: u2 (copy), l__FieldOfViewController__2 (copy), l__Blur__3 (copy)
    local v5 = table.find(u2, p4);
    if v5 then
        table.remove(u2, v5);
    end;
    if #u2 == 0 then
        l__FieldOfViewController__2.SetCoreFov(70);
        l__FieldOfViewController__2.SetFov(70, 0.3);
        l__Blur__3.SetBlur(0, 0.3);
    end;
end;
function v1.CanInteract() --[[ Line: 34 ]]
    -- upvalues: u2 (copy)
    return #u2 == 0;
end;
return v1;