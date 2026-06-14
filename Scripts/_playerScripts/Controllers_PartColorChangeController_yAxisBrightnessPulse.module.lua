-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__Name__3 = script.Name;
local u1 = {};
local u2 = {};
local v3 = {};
for _, v4 in l__CollectionService__2:GetTagged(l__Name__3) do
    if v4:IsA("BasePart") then
        table.insert(u1, v4);
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal(l__Name__3):Connect(function(p5) --[[ Line: 17 ]]
    -- upvalues: u1 (copy)
    if p5:IsA("BasePart") then
        table.insert(u1, p5);
    end;
end);
function v3.Start(_) --[[ Line: 30 ]]
    -- upvalues: u1 (copy), u2 (copy), l__TweenService__1 (copy)
    task.spawn(function() --[[ Line: 32 ]]
        -- upvalues: u1 (ref), u2 (ref), l__TweenService__1 (ref)
        while true do
            local v6 = (1 / 0);
            for _, v7 in u1 do
                if v7.Position.Y < v6 then
                    v6 = v7.Position.Y;
                end;
            end;
            for _, u8 in u1 do
                if u8.Parent then
                    if not u2[u8] then
                        u2[u8] = u8.Color;
                    end;
                    local u9 = u2[u8];
                    local v10, v11, v12 = u9:ToHSV();
                    local u13 = Color3.fromHSV(v10, v11, (math.clamp(v12 * 1.5, 0, 1)));
                    task.delay((u8.Position.Y - v6) * 0.5, function() --[[ Line: 59 ]]
                        -- upvalues: l__TweenService__1 (ref), u8 (copy), u13 (copy), u9 (copy)
                        local v14 = l__TweenService__1:Create(u8, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Color = u13
                        });
                        local v15 = l__TweenService__1:Create(u8, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                            Color = u9
                        });
                        v14:Play();
                        v14.Completed:Wait();
                        v15:Play();
                    end);
                end;
            end;
            task.wait(2);
        end;
    end);
end;
return v3;