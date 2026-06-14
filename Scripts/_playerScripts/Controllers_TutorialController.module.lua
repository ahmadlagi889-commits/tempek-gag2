-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Networking__2 = require(l__ReplicatedStorage__1.SharedModules.Networking);
local l__TutorialRunner__3 = require(script.TutorialRunner);
return {
    StartOrder = 3,
    Init = function(_) --[[ Name: Init, Line 10 ]] end,
    Start = function(_) --[[ Name: Start, Line 12 ]]
        -- upvalues: l__Networking__2 (copy), l__TutorialRunner__3 (copy)
        local u1 = false;
        l__Networking__2.Tutorial.Start.OnClientEvent:Connect(function(p2) --[[ Line: 14 ]]
            -- upvalues: u1 (ref), l__TutorialRunner__3 (ref)
            if u1 then
            else
                u1 = true;
                l__TutorialRunner__3(p2);
            end;
        end);
        task.spawn(function() --[[ Line: 22 ]]
            -- upvalues: u1 (ref), l__Networking__2 (ref)
            local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
            local v3 = assert(l__LocalPlayer__4);
            while v3:GetAttribute("LoadingScreenDone") ~= true do
                task.wait(0.5);
            end;
            local v4 = 0;
            while not u1 and v4 < 30 do
                v4 = v4 + 1;
                l__Networking__2.Tutorial.Ready:Fire();
                task.wait(2);
            end;
        end);
    end
};