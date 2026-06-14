-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Networking__1 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__Poof__2 = game.ReplicatedStorage.Assets.Poof;
local l__PopVFX__3 = game.ReplicatedStorage.Assets.PopVFX;
local l__Temporary__4 = game.Workspace.Temporary;
function v1.Init(_) --[[ Line: 9 ]]
    -- upvalues: l__Networking__1 (copy), l__PopVFX__3 (copy), l__Poof__2 (copy), l__Temporary__4 (copy)
    l__Networking__1.ShecklePop.SheckleCollect.OnClientEvent:Connect(function(u2) --[[ Line: 10 ]]
        -- upvalues: l__PopVFX__3 (ref)
        task.spawn(function() --[[ Line: 13 ]]
            -- upvalues: l__PopVFX__3 (ref), u2 (copy)
            local v3 = Instance.new("Model");
            v3.Parent = game.Workspace.Temporary;
            local v4 = l__PopVFX__3:Clone();
            v4.Parent = v3;
            v3:ScaleTo(0.5);
            v4.Position = u2;
            task.wait();
            for _, v5 in pairs(v4:GetDescendants()) do
                if v5:IsA("ParticleEmitter") then
                    v5:Emit(v5:GetAttribute("EmitCount"));
                end;
            end;
            game.Debris:AddItem(v3, 3);
        end);
    end);
    l__Networking__1.ShecklePop.PlayerDeath.OnClientEvent:Connect(function(u6) --[[ Line: 29 ]]
        -- upvalues: l__Poof__2 (ref), l__Temporary__4 (ref)
        task.spawn(function() --[[ Line: 30 ]]
            -- upvalues: l__Poof__2 (ref), l__Temporary__4 (ref), u6 (copy)
            local v7 = l__Poof__2:Clone();
            v7.Parent = l__Temporary__4;
            v7.Position = u6;
            task.wait();
            for _, v8 in pairs(v7:GetDescendants()) do
                if v8:IsA("ParticleEmitter") then
                    v8:Emit(math.random(7, 11));
                end;
            end;
            game.Debris:AddItem(v7, 3);
        end);
    end);
end;
return v1;