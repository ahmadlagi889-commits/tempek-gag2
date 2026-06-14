-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 7
};
local l__Debris__1 = game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Temporary__4 = workspace:WaitForChild("Temporary");
local l__Stud_Part__5 = l__ReplicatedStorage__3.Assets:WaitForChild("Stud_Part");
local function u8() --[[ Line: 33 ]]
    local v2 = math.random() * 3.141592653589793 * 2;
    local v3 = 2 * math.random() - 1;
    local v4 = math.acos(v3);
    local v5 = math.sin(v4) * math.cos(v2);
    local v6 = math.sin(v4) * math.sin(v2);
    local v7 = math.cos(v4);
    return Vector3.new(v5, v6, v7);
end;
function v1.Smash(_, p9) --[[ Line: 58 ]]
    -- upvalues: l__Stud_Part__5 (copy), l__Temporary__4 (copy), u8 (copy), l__TweenService__2 (copy), l__Debris__1 (copy)
    local l__Position__6 = p9.Position;
    if l__Position__6 then
        local v10 = p9.Amount or 12;
        local v11 = p9.Spread or 3;
        local v12 = p9.Color or Color3.fromRGB(139, 90, 43);
        local l__Colors__7 = p9.Colors;
        local u13 = p9.Lifetime or 1.2;
        local v14 = p9.Force or 1;
        for _ = 1, v10 do
            local v15;
            if l__Colors__7 and #l__Colors__7 > 0 then
                v15 = l__Colors__7[math.random(1, #l__Colors__7)];
            else
                v15 = v12;
            end;
            local v16 = -v11;
            local v17 = (v16 + math.random() * (v11 - v16)) * 0.5;
            local v18 = -v11;
            local v19 = (v18 + math.random() * (v11 - v18)) * 0.3;
            local v20 = -v11;
            local v21 = (v20 + math.random() * (v11 - v20)) * 0.5;
            local v22 = l__Position__6 + Vector3.new(v17, v19, v21);
            local l__Size__8 = p9.Size;
            local u23 = l__Stud_Part__5:Clone();
            u23.CollisionGroup = "Egg";
            u23.Size = Vector3.new(l__Size__8, l__Size__8, l__Size__8);
            u23.Name = "SmashBlock";
            u23.Color = v15;
            u23.CFrame = CFrame.new(v22) * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2);
            u23.Anchored = false;
            u23.CanCollide = true;
            u23.CollisionGroup = "NoPlayers";
            u23.CanQuery = false;
            u23.CanTouch = false;
            u23.Parent = l__Temporary__4;
            local v24 = v22 - l__Position__6;
            local v25;
            if v24.Magnitude < 0.1 then
                v25 = u8();
            else
                v25 = v24.Unit;
            end;
            local l__Unit__9 = (v25 + u8() * 0.4).Unit;
            local v26 = (15 + math.random() * 25) * v14;
            local v27 = (15 + math.random() * 15) * v14;
            u23.AssemblyLinearVelocity = l__Unit__9 * v26 + Vector3.new(0, v27, 0);
            u23.AssemblyAngularVelocity = u8() * 25;
            local l__Size__10 = u23.Size;
            task.delay(0.4, function() --[[ Line: 126 ]]
                -- upvalues: u23 (copy), u13 (copy), l__TweenService__2 (ref), l__Size__10 (copy)
                if u23 and u23.Parent then
                    local v28 = u13 - 0.4;
                    if v28 <= 0 then
                        u23:Destroy();
                    else
                        local v29 = l__TweenService__2:Create(u23, TweenInfo.new(v28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Transparency = 1,
                            Size = l__Size__10 * 0.3
                        });
                        v29:Play();
                        v29.Completed:Once(function() --[[ Line: 141 ]]
                            -- upvalues: u23 (ref)
                            if u23 and u23.Parent then
                                u23:Destroy();
                            end;
                        end);
                    end;
                end;
            end);
            l__Debris__1:AddItem(u23, u13 + 1);
        end;
    end;
end;
function v1.Init(_) --[[ Line: 157 ]] end;
function v1.Start(_) --[[ Line: 160 ]] end;
return v1;