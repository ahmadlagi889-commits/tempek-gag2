-- Decompiled with Potassium's decompiler.

local l__Debris__1 = game:GetService("Debris");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Emit__3 = require(l__ReplicatedStorage__2.UserGenerated.VFX.Emit);
return function(p1, p2, p3) --[[ Name: PlayVFX, Line 25 ]]
    -- upvalues: l__Debris__1 (copy), l__Emit__3 (copy)
    local v4 = Instance.new("Attachment");
    v4.CFrame = p1.CFrame:ToObjectSpace(p2);
    for _, v5 in ipairs(p3:GetDescendants()) do
        if v5:IsA("ParticleEmitter") then
            v5.Parent = v4;
        end;
    end;
    if p3:IsA("ParticleEmitter") then
        p3.Parent = v4;
    else
        p3:Destroy();
    end;
    v4.Parent = p1;
    l__Debris__1:AddItem(v4, l__Emit__3(v4));
end;