-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
local l__Trove__4 = require(game.ReplicatedStorage.ClientModules.Trove);
local l__DoorOpen__5 = game.SoundService.SFX.DoorOpen;
return function(u1) --[[ Line: 11 ]]
    -- upvalues: l__Players__2 (copy), l__Trove__4 (copy), l__CollectionService__1 (copy), l__DoorOpen__5 (copy), l__RunService__3 (copy)
    local l__Core__6 = u1:WaitForChild("Main"):WaitForChild("Core");
    local l__Parent__7 = l__Core__6.Parent;
    while true do
        local u2 = l__Players__2:GetPlayerByUserId(u1:GetAttribute("UserId"));
        if not u2 then
            task.wait();
        end;
        if u2 then
            local v3 = l__Trove__4.new();
            v3:AttachToInstance(u1);
            local u4 = false;
            local u5 = 0;
            for _, u6 in l__Parent__7:GetChildren() do
                if u6:IsA("BasePart") then
                    l__CollectionService__1:AddTag(u6, "CrowbarDoor");
                    v3:Add(function() --[[ Line: 29 ]]
                        -- upvalues: u6 (copy), l__CollectionService__1 (ref)
                        if u6.Parent then
                            l__CollectionService__1:RemoveTag(u6, "CrowbarDoor");
                        end;
                    end);
                end;
            end;
            local function u9(p7) --[[ Line: 37 ]]
                -- upvalues: u4 (ref), l__DoorOpen__5 (ref), l__Parent__7 (copy)
                if p7 == u4 then
                else
                    u4 = p7;
                    if p7 then
                        l__DoorOpen__5:Play();
                    end;
                    for _, v8 in l__Parent__7:GetChildren() do
                        if v8:IsA("BasePart") then
                            v8.CanCollide = not p7;
                            v8.Transparency = p7 and 0.5 or 0;
                        end;
                    end;
                end;
            end;
            local function u14() --[[ Line: 51 ]]
                -- upvalues: u2 (ref), l__Core__6 (copy)
                local l__Character__8 = u2.Character;
                if not l__Character__8 then
                    return false;
                end;
                local v10 = l__Character__8:FindFirstChild("HumanoidRootPart");
                if not v10 then
                    return false;
                end;
                local v11 = l__Core__6.CFrame:PointToObjectSpace(v10.Position);
                local v12 = l__Core__6.Size / 2;
                local v13;
                if math.abs(v11.Z) <= v12.Z + 2 and (math.abs(v11.X) <= v12.X + 2 and math.abs(v11.Y) <= v12.Y + 2) then
                    v13 = math.abs(v11.Z) >= v12.Z - 2;
                else
                    v13 = false;
                end;
                return v13;
            end;
            local u15 = 0;
            v3:Connect(l__RunService__3.Heartbeat, function(p16) --[[ Line: 66 ]]
                -- upvalues: u15 (ref), l__Core__6 (copy), u1 (copy), u9 (copy), u14 (copy), u5 (ref)
                u15 = u15 + p16;
                if u15 < 0.1 then
                else
                    u15 = 0;
                    if l__Core__6.Parent then
                        if u1:GetAttribute("ForcedOpen") then
                            u9(true);
                        else
                            local v17 = u14();
                            if v17 then
                                u5 = os.clock();
                            end;
                            u9(v17 or os.clock() - u5 < 2.5);
                        end;
                    end;
                end;
            end);
            return;
        end;
    end;
end;