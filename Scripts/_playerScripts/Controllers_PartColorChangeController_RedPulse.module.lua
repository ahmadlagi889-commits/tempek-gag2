-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__Name__3 = script.Name;
local u1 = {};
local v2 = {};
for _, v3 in l__CollectionService__2:GetTagged(l__Name__3) do
    if v3:IsA("BasePart") then
        table.insert(u1, v3);
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal(l__Name__3):Connect(function(p4) --[[ Line: 18 ]]
    -- upvalues: u1 (copy)
    if p4:IsA("BasePart") then
        table.insert(u1, p4);
    end;
end);
function v2.Start(_) --[[ Line: 24 ]]
    -- upvalues: l__RunService__1 (copy), u1 (copy)
    l__RunService__1.Heartbeat:Connect(function() --[[ Line: 25 ]]
        -- upvalues: u1 (ref)
        local v5 = tick();
        for _, v6 in u1 do
            if v6.Parent then
                local v7 = (math.sin((v6.Position.Y - v5 * 0.5) / 1 * 3.141592653589793 * 2) + 1) / 2 * 0.55 + 0.35;
                v6.Color = Color3.fromHSV(0, 1, v7);
            end;
        end;
    end);
end;
return v2;