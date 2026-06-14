-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("CollectionService");
local l__RunService__1 = game:GetService("RunService");
local u2 = {};
function v1.Init(_) --[[ Line: 9 ]] end;
function v1.Start(u3) --[[ Line: 12 ]]
    -- upvalues: u2 (copy), l__RunService__1 (copy)
    for _, v4 in workspace:GetDescendants() do
        if v4:IsA("BasePart") and v4:GetAttribute("VELOCITY") ~= nil then
            u3:RegisterConveyor(v4);
        end;
    end;
    workspace.DescendantAdded:Connect(function(p5) --[[ Line: 21 ]]
        -- upvalues: u3 (copy)
        if p5:IsA("BasePart") and p5:GetAttribute("VELOCITY") ~= nil then
            u3:RegisterConveyor(p5);
        end;
    end);
    workspace.DescendantRemoving:Connect(function(p6) --[[ Line: 27 ]]
        -- upvalues: u2 (ref)
        u2[p6] = nil;
    end);
    l__RunService__1.Heartbeat:Connect(function() --[[ Line: 32 ]]
        -- upvalues: u2 (ref)
        debug.profilebegin("Controllers/ConveyorController/Heartbeat");
        for v7, _ in u2 do
            local v8 = v7:GetAttribute("VELOCITY");
            if v8 then
                v7.AssemblyLinearVelocity = v7.CFrame.LookVector * v8;
            end;
        end;
        debug.profileend();
    end);
end;
function v1.RegisterConveyor(_, u9) --[[ Line: 44 ]]
    -- upvalues: u2 (copy)
    u2[u9] = true;
    u9:GetAttributeChangedSignal("VELOCITY"):Connect(function() --[[ Line: 48 ]]
        -- upvalues: u9 (copy), u2 (ref)
        if u9:GetAttribute("VELOCITY") == nil then
            u2[u9] = nil;
        else
            u2[u9] = true;
        end;
    end);
end;
return v1;