-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
for _, u1 in l__CollectionService__2:GetTagged("MushroomCap") do
    if u1:IsA("BasePart") then
        local u2 = 0;
        u1.Touched:Connect(function(p3) --[[ Line: 12 ]]
            -- upvalues: u2 (ref), l__LocalPlayer__3 (copy), u1 (copy)
            local v4 = os.clock();
            if v4 - u2 < 0.25 then
            else
                local l__Character__4 = l__LocalPlayer__3.Character;
                if l__Character__4 then
                    if p3:IsDescendantOf(l__Character__4) then
                        local v5 = l__Character__4:FindFirstChild("HumanoidRootPart");
                        if v5 then
                            local v6 = l__Character__4:FindFirstChildOfClass("Humanoid");
                            if v6 then
                                if v5.Position.Y - v6.HipHeight < u1.Position.Y + u1.Size.Y / 2 - 1 then
                                else
                                    u2 = v4;
                                    v5.AssemblyLinearVelocity = Vector3.new(v5.AssemblyLinearVelocity.X * 0.2, 120, v5.AssemblyLinearVelocity.Z * 0.2);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end);
    end;
end;
l__CollectionService__2:GetInstanceAddedSignal("MushroomCap"):Connect(function(u7) --[[ Line: 46 ]]
    -- upvalues: l__LocalPlayer__3 (copy)
    if u7:IsA("BasePart") then
        local u8 = 0;
        u7.Touched:Connect(function(p9) --[[ Line: 12 ]]
            -- upvalues: u8 (ref), l__LocalPlayer__3 (ref), u7 (copy)
            local v10 = os.clock();
            if v10 - u8 < 0.25 then
            else
                local l__Character__5 = l__LocalPlayer__3.Character;
                if l__Character__5 then
                    if p9:IsDescendantOf(l__Character__5) then
                        local v11 = l__Character__5:FindFirstChild("HumanoidRootPart");
                        if v11 then
                            local v12 = l__Character__5:FindFirstChildOfClass("Humanoid");
                            if v12 then
                                if v11.Position.Y - v12.HipHeight < u7.Position.Y + u7.Size.Y / 2 - 1 then
                                else
                                    u8 = v10;
                                    v11.AssemblyLinearVelocity = Vector3.new(v11.AssemblyLinearVelocity.X * 0.2, 120, v11.AssemblyLinearVelocity.Z * 0.2);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end);
    end;
end);