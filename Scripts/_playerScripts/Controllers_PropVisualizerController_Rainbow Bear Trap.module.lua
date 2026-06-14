-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Networking__2 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__RagdollModule__3 = require(game.ReplicatedStorage.ClientModules.RagdollModule);
return function(u1) --[[ Line: 5 ]]
    -- upvalues: l__Players__1 (copy), l__Networking__2 (copy), l__RagdollModule__3 (copy)
    local u2 = u1:GetAttribute("PropId");
    local u3 = u1:GetAttribute("UserId") == l__Players__1.LocalPlayer.UserId;
    local l__Primary__4 = u1.Primary;
    local l__Open__5 = u1.Build.Open;
    local l__Close__6 = u1.Build.Close;
    local l__Slam__7 = l__Primary__4.Slam;
    local l__Open__8 = l__Primary__4.Open;
    u1:SetAttribute("Debounce", true);
    l__Networking__2.BearTrap.Closed.OnClientEvent:Connect(function(p4) --[[ Line: 14 ]]
        -- upvalues: u2 (copy), u1 (copy), l__Close__6 (copy), l__Open__5 (copy), l__Slam__7 (copy)
        if p4 == u2 then
            u1:SetAttribute("Debounce", false);
            l__Close__6.Transparency = 0;
            l__Open__5.Transparency = 1;
            l__Slam__7.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__Slam__7.TimePosition = 0;
            l__Slam__7.Playing = true;
        end;
    end);
    l__Networking__2.BearTrap.Reset.OnClientEvent:Connect(function(p5) --[[ Line: 23 ]]
        -- upvalues: u2 (copy), u1 (copy), l__Close__6 (copy), l__Open__5 (copy), l__Open__8 (copy)
        if p5 == u2 then
            u1:SetAttribute("Debounce", true);
            l__Close__6.Transparency = 1;
            l__Open__5.Transparency = 0;
            l__Open__8.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__Open__8.TimePosition = 0;
            l__Open__8.Playing = true;
        end;
    end);
    l__Primary__4.Touched:Connect(function(p6) --[[ Line: 32 ]]
        -- upvalues: u1 (copy), u3 (copy), l__Players__1 (ref), l__RagdollModule__3 (ref), l__Networking__2 (ref), u2 (copy), l__Primary__4 (copy)
        if u1:GetAttribute("Debounce") then
            if u3 then
            else
                if p6 then
                    p6 = p6.Parent;
                end;
                local v7;
                if p6 then
                    v7 = l__Players__1:GetPlayerFromCharacter(p6);
                else
                    v7 = p6;
                end;
                if v7 == l__Players__1.LocalPlayer then
                    l__RagdollModule__3:Ragdoll(p6, 3);
                    l__Networking__2.BearTrap.BearTrap:Fire(u2, l__Primary__4.Position, "Rainbow Bear Trap");
                end;
            end;
        end;
    end);
end;