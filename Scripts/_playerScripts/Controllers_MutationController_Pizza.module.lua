-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("RunService");
local l__CollectionService__1 = game:GetService("CollectionService");
local u2 = {};
local _ = script.VFX;
function v1.ApplyMutationEffect(p3) --[[ Line: 27 ]]
    -- upvalues: u2 (copy), l__CollectionService__1 (copy)
    if u2[p3] then
    else
        l__CollectionService__1:AddTag(p3, "Pizza");
        local v4 = {};
        if p3:IsA("BasePart") then
            table.insert(v4, p3);
        end;
        for _, v5 in p3:GetDescendants() do
            if v5:IsA("BasePart") then
                table.insert(v4, v5);
            end;
        end;
        table.sort(v4, function(p6, p7) --[[ Line: 45 ]]
            return p6.Position.Y > p7.Position.Y;
        end);
        local v8 = { Color3.fromRGB(255, 196, 144) };
        local v9 = { Color3.fromRGB(191, 18, 18), Color3.fromRGB(255, 227, 124), Color3.fromRGB(13, 191, 0) };
        for v10 = 1, #v4 do
            local v11 = v4[v10];
            local v12 = math.floor(v10 / 4);
            local v13 = math.clamp(v12, 1, 3);
            if v13 == 1 then
                v11.Color = v8[v13];
            else
                v11.Color = v9[Random.new():NextInteger(1, #v9)];
            end;
        end;
    end;
end;
l__CollectionService__1:GetInstanceAddedSignal("Pizza"):Connect(v1.ApplyMutationEffect);
for _, v14 in l__CollectionService__1:GetTagged("Pizza") do
    task.spawn(v1.ApplyMutationEffect, v14);
end;
return v1;