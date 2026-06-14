-- Decompiled with Potassium's decompiler.

return {
    new = function(p1) --[[ Name: new, Line 4 ]]
        local v2 = p1.Amount or 4;
        local v3 = p1.Delay or 1;
        local v4 = p1.SizeMin or Vector3.new(1, 1, 1);
        local v5 = p1.SizeMax or Vector3.new(1, 1, 1);
        local v6 = p1.Colors or { Color3.new(1, 1, 1) };
        local v7 = p1.Material or Enum.Material.Plastic;
        local v8 = p1.Velocity or 30;
        local _ = p1.Direction or Vector3.new(0, 1, 0);
        local v9 = p1.Spread or 45;
        local u10 = p1.Lifetime or 3;
        local l__Origin__1 = p1.Origin;
        local v11 = Random.new();
        local v12 = {};
        for _ = 1, v2 do
            local v13 = Instance.new("Part");
            v13.Anchored = false;
            v13.CanCollide = true;
            local v14 = v11:NextNumber(v4.X, v5.X);
            local v15 = v11:NextNumber(v4.Y, v5.Y);
            v13.Size = Vector3.new(v14, v15, v11:NextNumber(v4.Z, v5.Z));
            v13.Transparency = 0;
            v13.CFrame = l__Origin__1;
            v13.Material = v7;
            v13.Color = v6[math.random(1, #v6)];
            table.insert(v12, v13);
        end;
        for _, u16 in v12 do
            u16.Parent = workspace.Temporary;
            game.Debris:AddItem(u16, u10 + v3);
            local v17 = v11:NextNumber(-v9, v9);
            local v18 = v11:NextNumber(-v9, v9);
            u16:ApplyImpulse((l__Origin__1 * CFrame.Angles(0, math.rad(v17), 0) * CFrame.Angles(math.rad(v18), 0, 0)).LookVector * v8 * u16.AssemblyMass);
            task.delay(v3, function() --[[ Line: 65 ]]
                -- upvalues: u16 (copy), u10 (copy)
                game.TweenService:Create(u16, TweenInfo.new(u10), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
                task.delay(0.1, function() --[[ Line: 67 ]]
                    -- upvalues: u16 (ref)
                    u16.CanCollide = true;
                end);
            end);
        end;
    end
};