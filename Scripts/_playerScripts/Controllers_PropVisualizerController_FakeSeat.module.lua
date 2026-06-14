-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Networking__4 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
return function(u1) --[[ Line: 18 ]]
    -- upvalues: l__CollectionService__2 (copy), l__LocalPlayer__5 (copy), l__Networking__4 (copy), l__Players__1 (copy)
    local u2 = {};
    for _, v3 in u1:GetDescendants() do
        if v3:IsA("BasePart") and l__CollectionService__2:HasTag(v3, "FakeSeat") then
            table.insert(u2, v3);
        end;
    end;
    if #u2 == 0 then
    else
        local u4 = u1:GetAttribute("UserId");
        local u5 = u1:GetAttribute("PropId");
        local u6 = false;
        local u7 = {};
        local u8 = {};
        local u9 = nil;
        local u10 = {};
        local function u18(p11, p12) --[[ Line: 48 ]]
            -- upvalues: u7 (copy), u2 (copy)
            local v13 = u7[p11];
            if v13 then
                v13:Destroy();
                u7[p11] = nil;
            end;
            local v14 = p12:FindFirstChild("HumanoidRootPart");
            if v14 and v14:IsA("BasePart") then
                local v15 = u2[p11];
                local v16 = v15:GetAttribute("SeatHeight") or 2;
                local v17 = Instance.new("Weld");
                v17.Name = "SeatWeld";
                v17.Part0 = v15;
                v17.Part1 = v14;
                v17.C0 = CFrame.new(0, v16, 0);
                v17.Parent = v15;
                u7[p11] = v17;
            end;
        end;
        local function u23() --[[ Line: 65 ]]
            -- upvalues: u9 (ref), l__LocalPlayer__5 (ref), u2 (copy), u8 (copy), u7 (copy), u10 (copy), l__Networking__4 (ref), u4 (copy), u5 (copy)
            if u9 then
                u9:Disconnect();
                u9 = nil;
            end;
            local l__Character__6 = l__LocalPlayer__5.Character;
            if l__Character__6 then
                local v19 = l__Character__6:FindFirstChildWhichIsA("Humanoid");
                if v19 then
                    u9 = v19.StateChanged:Connect(function(_, p20) --[[ Line: 76 ]]
                        -- upvalues: u2 (ref), u8 (ref), l__LocalPlayer__5 (ref), u7 (ref), u10 (ref), l__Networking__4 (ref), u4 (ref), u5 (ref)
                        if p20 == Enum.HumanoidStateType.Jumping or p20 == Enum.HumanoidStateType.GettingUp then
                            for v21 = 1, #u2 do
                                if u8[v21] == l__LocalPlayer__5.UserId then
                                    local v22 = u7[v21];
                                    if v22 then
                                        v22:Destroy();
                                        u7[v21] = nil;
                                    end;
                                    u8[v21] = nil;
                                    u10[v21] = os.clock();
                                    l__Networking__4.FakeSeat.Unsit:Fire(u4, u5, v21);
                                    return;
                                end;
                            end;
                        end;
                    end);
                end;
            end;
        end;
        local u31 = l__Networking__4.FakeSeat.SeatChanged.OnClientEvent:Connect(function(p24, p25, p26, p27) --[[ Line: 93 ]]
            -- upvalues: u4 (copy), u5 (copy), u8 (copy), l__LocalPlayer__5 (ref), u7 (copy), l__Networking__4 (ref), l__Players__1 (ref), u18 (copy)
            if p24 == u4 and p25 == u5 then
                if p27 == 0 then
                    if u8[p26] == l__LocalPlayer__5.UserId then
                    else
                        local v28 = u7[p26];
                        if v28 then
                            v28:Destroy();
                            u7[p26] = nil;
                        end;
                        u8[p26] = nil;
                    end;
                elseif p27 == l__LocalPlayer__5.UserId then
                    if u8[p26] ~= l__LocalPlayer__5.UserId then
                        l__Networking__4.FakeSeat.Unsit:Fire(u4, u5, p26);
                    end;
                else
                    u8[p26] = p27;
                    local v29 = l__Players__1:GetPlayerByUserId(p27);
                    if v29 and v29.Character then
                        local v30 = v29.Character:FindFirstChildWhichIsA("Humanoid");
                        if v30 then
                            v30.Sit = true;
                        end;
                        u18(p26, v29.Character);
                    end;
                end;
            end;
        end);
        local u32 = u9;
        for u33 = 1, #u2 do
            u2[u33].Touched:Connect(function(p34) --[[ Line: 124 ]]
                -- upvalues: u6 (ref), u1 (copy), u8 (copy), u33 (copy), u10 (copy), l__LocalPlayer__5 (ref), u18 (copy), u23 (copy), l__Networking__4 (ref), u4 (copy), u5 (copy)
                if u6 then
                elseif u1:GetAttribute("IsBeingMoved") then
                elseif u8[u33] then
                else
                    local v35 = u10[u33];
                    if v35 and os.clock() - v35 < 0.5 then
                    else
                        local v36 = p34:FindFirstAncestorWhichIsA("Model");
                        if v36 == l__LocalPlayer__5.Character then
                            local v37 = v36:FindFirstChildWhichIsA("Humanoid");
                            if v37 then
                                if v37.Sit then
                                else
                                    v37.Sit = true;
                                    u18(u33, v36);
                                    u8[u33] = l__LocalPlayer__5.UserId;
                                    u23();
                                    l__Networking__4.FakeSeat.Sit:Fire(u4, u5, u33);
                                end;
                            end;
                        end;
                    end;
                end;
            end);
        end;
        u23();
        l__LocalPlayer__5.CharacterAdded:Connect(function() --[[ Line: 149 ]]
            -- upvalues: u23 (copy)
            task.wait();
            u23();
        end);
        u1.Destroying:Connect(function() --[[ Line: 154 ]]
            -- upvalues: u6 (ref), u2 (copy), u8 (copy), l__LocalPlayer__5 (ref), u7 (copy), u31 (copy), u32 (ref)
            u6 = true;
            for v38 = 1, #u2 do
                if u8[v38] == l__LocalPlayer__5.UserId then
                    local v39 = u7[v38];
                    if v39 then
                        v39:Destroy();
                        u7[v38] = nil;
                    end;
                    u8[v38] = nil;
                    local l__Character__7 = l__LocalPlayer__5.Character;
                    if l__Character__7 then
                        local v40 = l__Character__7:FindFirstChildWhichIsA("Humanoid");
                        if v40 then
                            v40.Sit = false;
                        end;
                    end;
                elseif u7[v38] then
                    local v41 = u7[v38];
                    if v41 then
                        v41:Destroy();
                        u7[v38] = nil;
                    end;
                    u8[v38] = nil;
                end;
            end;
            u31:Disconnect();
            if u32 then
                u32:Disconnect();
            end;
        end);
        l__Networking__4.FakeSeat.RequestState:Fire(u4, u5);
    end;
end;