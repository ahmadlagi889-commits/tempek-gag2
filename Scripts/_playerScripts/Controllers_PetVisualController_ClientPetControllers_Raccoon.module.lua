-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Networking__1 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__SeedData__2 = require(game.ReplicatedStorage.SharedModules.SeedData);
require(script.Parent.Parent);
local l__Gardens__3 = game.Workspace.Gardens;
function v1.Init(_) --[[ Line: 57 ]]
    -- upvalues: l__Networking__1 (copy), l__Gardens__3 (copy), l__SeedData__2 (copy)
    function l__Networking__1.ReturnNearestFruit.ReturnNearestFruit.OnClientInvoke(p2, p3) --[[ Line: 58 ]]
        -- upvalues: l__Gardens__3 (ref), l__SeedData__2 (ref)
        local v4 = game.Players:FindFirstChild(p3);
        if not (v4 and v4.Parent) then
            return nil;
        end;
        local v5 = v4:GetAttribute("PlotId");
        if not v5 then
            return nil;
        end;
        local v6 = l__Gardens__3:FindFirstChild("Plot" .. v5);
        if not v6 then
            return nil;
        end;
        local v7 = (1 / 0);
        local v8 = nil;
        for _, v9 in pairs(v6.Plants:GetChildren()) do
            local v10 = nil;
            for _, v11 in pairs(l__SeedData__2) do
                if v11.SeedName == v9:GetAttribute("SeedName") then
                    v10 = v11;
                    break;
                end;
            end;
            if v10 then
                if v10.IsSingleHarvest == true then
                    local l__Magnitude__4 = (v9.PrimaryPart.Position - p2).Magnitude;
                    if l__Magnitude__4 < v7 then
                        v8 = v9;
                        v7 = l__Magnitude__4;
                    end;
                else
                    for _, v12 in pairs(v9.Fruits:GetChildren()) do
                        local l__Magnitude__5 = (v12.PrimaryPart.Position - p2).Magnitude;
                        if l__Magnitude__5 < v7 then
                            v8 = v12;
                            v7 = l__Magnitude__5;
                        end;
                    end;
                end;
            end;
        end;
        if v8 then
            return v8.Name, v8.PrimaryPart.Position;
        end;
    end;
    l__Networking__1.Raccoon.RaccoonWalkToPoint.OnClientEvent:Connect(function(_, _, _, _) --[[ Line: 98 ]] end);
end;
function v1.PlayerEnteredGarden(_) --[[ Line: 104 ]] end;
return v1;