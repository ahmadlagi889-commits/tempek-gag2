-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local l__Networking__4 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__Notify__5 = l__ReplicatedStorage__2:WaitForChild("Notify");
return function(u1) --[[ Line: 44 ]]
    -- upvalues: l__LocalPlayer__3 (copy), l__Notify__5 (copy), l__Networking__4 (copy), l__Players__1 (copy)
    local l__Data__6 = u1.Build.Data;
    local l__TargetTilt__7 = l__Data__6.TargetTilt;
    local u2 = l__Data__6:FindFirstChild("UP");
    local l__Tilt__8 = u1.Build.Tilt;
    local l__ATT1__9 = l__Tilt__8.Center.ATT1;
    local u3 = false;
    for _, v4 in l__Tilt__8:GetDescendants() do
        if v4:IsA("BasePart") then
            v4.Anchored = false;
        end;
    end;
    local u5 = u1:GetAttribute("UserId");
    local u6 = u1:GetAttribute("PropId");
    local u7 = { l__Tilt__8.OBJ1, l__Tilt__8.OBJ2 };
    for _, v8 in u7 do
        if v8:IsA("BasePart") then
            v8.CanCollide = false;
        end;
    end;
    local u9 = { nil, nil };
    local u10 = { nil, nil };
    local u11 = false;
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
    local u15 = 0;
    local u16 = 0;
    local u17 = 0;
    local function u31(_) --[[ Line: 133 ]]
        -- upvalues: l__LocalPlayer__3 (ref), u17 (ref), u1 (copy)
        local l__Character__10 = l__LocalPlayer__3.Character;
        if l__Character__10 then
            local u18 = l__Character__10:FindFirstChild("HumanoidRootPart");
            local u19 = l__Character__10:FindFirstChildWhichIsA("Humanoid");
            if u18 and u19 then
                local v20 = math.abs(u17) / 376.99111843077515;
                local v21 = math.clamp(v20, 0, 1);
                local v22 = math.lerp(1.5, 22.5, v21);
                local l__LookVector__11 = u18.CFrame.LookVector;
                local v23 = Vector3.new(l__LookVector__11.X, 0, l__LookVector__11.Z);
                local v24 = v23.Magnitude <= 0.01 and Vector3.new(0, 0, 1) or v23.Unit;
                local v25 = v24 * 7.5 * v22 + Vector3.new(0, v22 * 24, 0);
                u19.PlatformStand = true;
                u18.CFrame = u18.CFrame + Vector3.new(0, 2.5, 0);
                u18.AssemblyLinearVelocity = v25;
                local v26 = v24:Cross(Vector3.new(0, 1, 0));
                local u27;
                if v26.Magnitude > 0.1 then
                    u27 = v26.Unit * (v21 * 21 * v22);
                    u18.AssemblyAngularVelocity = u27;
                else
                    u27 = Vector3.new(0, 0, 0);
                end;
                task.spawn(function() --[[ Line: 165 ]]
                    -- upvalues: l__Character__10 (copy), u1 (ref), u27 (ref), u19 (copy), u18 (copy)
                    local v28 = RaycastParams.new();
                    v28.FilterType = Enum.RaycastFilterType.Exclude;
                    v28.FilterDescendantsInstances = { l__Character__10, u1 };
                    local v29 = u27;
                    while u19.Parent and (u18.Parent and u19.PlatformStand) do
                        if workspace:Raycast(u18.Position, Vector3.new(0, -4, 0), v28) then
                            u18.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                            local v30 = Vector3.new(u18.CFrame.LookVector.X, 0, u18.CFrame.LookVector.Z);
                            if v30.Magnitude > 0.01 then
                                u18.CFrame = CFrame.new(u18.Position, u18.Position + v30);
                            end;
                            break;
                        end;
                        v29 = v29 * 0.92;
                        u18.AssemblyAngularVelocity = v29;
                        task.wait();
                    end;
                    if u19.Parent then
                        u19.PlatformStand = false;
                    end;
                end);
            end;
        end;
    end;
    local function u36(p32, p33) --[[ Line: 199 ]]
        -- upvalues: u9 (copy), u7 (copy)
        if u9[p32] then
            u9[p32]:Destroy();
            u9[p32] = nil;
        end;
        local v34 = p33:FindFirstChild("HumanoidRootPart");
        if v34 then
            local v35 = Instance.new("Weld");
            v35.Name = "SeatWeld";
            v35.Part0 = u7[p32];
            v35.Part1 = v34;
            v35.C0 = CFrame.new(0, 2, 0);
            v35.Parent = u7[p32];
            u9[p32] = v35;
        end;
    end;
    local function u39() --[[ Line: 246 ]]
        -- upvalues: u13 (ref), l__LocalPlayer__3 (ref), u14 (ref), u10 (copy), u9 (copy), u31 (copy), u11 (ref), u12 (ref), u3 (ref), l__ATT1__9 (copy), l__TargetTilt__7 (copy), u2 (copy), u16 (ref), u17 (ref), u15 (ref), l__Networking__4 (ref), u5 (copy), u6 (copy)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;
        local l__Character__12 = l__LocalPlayer__3.Character;
        if l__Character__12 then
            local u37 = l__Character__12:FindFirstChildWhichIsA("Humanoid");
            if u37 then
                u13 = u37:GetPropertyChangedSignal("Sit"):Connect(function() --[[ Line: 257 ]]
                    -- upvalues: u37 (copy), u14 (ref), u10 (ref), l__LocalPlayer__3 (ref), u9 (ref), u31 (ref), u11 (ref), u12 (ref), u3 (ref), l__ATT1__9 (ref), l__TargetTilt__7 (ref), u2 (ref), u16 (ref), u17 (ref), u15 (ref), l__Networking__4 (ref), u5 (ref), u6 (ref)
                    if u37.Sit then
                    else
                        if u14 then
                            task.cancel(u14);
                            u14 = nil;
                        end;
                        for v38 = 1, 2 do
                            if u10[v38] == l__LocalPlayer__3.UserId then
                                if u9[v38] then
                                    u9[v38]:Destroy();
                                    u9[v38] = nil;
                                end;
                                u31(v38);
                                u10[v38] = nil;
                                u11 = false;
                                if u12 then
                                    task.cancel(u12);
                                    u12 = nil;
                                end;
                                if not u3 then
                                    l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
                                    l__TargetTilt__7.Value = 0;
                                    if u2 then
                                        u2.Value = 0;
                                    end;
                                end;
                                u16 = 0;
                                u17 = 0;
                                u15 = l__TargetTilt__7.Value;
                                l__Networking__4.Seesaw.Unsit:Fire(u5, u6, v38);
                                return;
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end;
    local u59 = l__Networking__4.Seesaw.SeatChanged.OnClientEvent:Connect(function(p40, p41, p42, p43, u44) --[[ Line: 273 ]]
        -- upvalues: u5 (copy), u6 (copy), u10 (copy), l__LocalPlayer__3 (ref), u9 (copy), u11 (ref), u12 (ref), u3 (ref), l__ATT1__9 (copy), l__TargetTilt__7 (copy), u2 (copy), u16 (ref), u17 (ref), u15 (ref), u14 (ref), l__Players__1 (ref), u36 (copy)
        if p40 == u5 and p41 == u6 then
            if p43 == 0 then
                if u10[p42] == l__LocalPlayer__3.UserId then
                else
                    if u9[p42] then
                        u9[p42]:Destroy();
                        u9[p42] = nil;
                    end;
                    u10[p42] = nil;
                    u11 = false;
                    if u12 then
                        task.cancel(u12);
                        u12 = nil;
                    end;
                    if not u3 then
                        l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
                        l__TargetTilt__7.Value = 0;
                        if u2 then
                            u2.Value = 0;
                        end;
                    end;
                    u16 = 0;
                    u17 = 0;
                    u15 = l__TargetTilt__7.Value;
                end;
            elseif p43 == l__LocalPlayer__3.UserId then
                if u44 > 0 then
                    u11 = false;
                    if u12 then
                        task.cancel(u12);
                        u12 = nil;
                    end;
                    if not u3 then
                        l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
                        l__TargetTilt__7.Value = 0;
                        if u2 then
                            u2.Value = 0;
                        end;
                    end;
                    u16 = 0;
                    u17 = 0;
                    u15 = l__TargetTilt__7.Value;
                    if u14 then
                        task.cancel(u14);
                        u14 = nil;
                    end;
                    u11 = true;
                    u12 = task.spawn(function() --[[ Line: 232 ]]
                        -- upvalues: u11 (ref), u3 (ref), u44 (copy), l__ATT1__9 (ref), u16 (ref), u17 (ref), u15 (ref), l__TargetTilt__7 (ref), u2 (ref)
                        while u11 and not u3 do
                            local v45 = workspace:GetServerTimeNow() - u44;
                            local v46;
                            if v45 <= 0 then
                                v46 = 0;
                            elseif v45 <= 13 then
                                local v47 = 4 - v45 * 3.75 / 13;
                                v46 = math.log(4 / (v47 <= 0.001 and 0.001 or v47)) * 3.466666666666667;
                            else
                                v46 = (v45 - 13) / 0.25 + 9.611640903764576;
                            end;
                            local v48 = math.sin(6.283185307179586 * v46) * 15;
                            l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, (math.rad(v48)));
                            local v49 = os.clock();
                            if u16 > 0 then
                                local v50 = v49 - u16;
                                if v50 > 0.0001 then
                                    u17 = (v48 - u15) / v50;
                                end;
                            end;
                            u15 = v48;
                            u16 = v49;
                            l__TargetTilt__7.Value = v48;
                            if u2 then
                                u2.Value = v45 * 0.6;
                            end;
                            task.wait();
                        end;
                    end);
                end;
            else
                u10[p42] = p43;
                local v51 = l__Players__1:GetPlayerByUserId(p43);
                if v51 and v51.Character then
                    local v52 = v51.Character:FindFirstChildWhichIsA("Humanoid");
                    if v52 then
                        v52.Sit = true;
                    end;
                    u36(p42, v51.Character);
                end;
                if u44 > 0 then
                    u11 = false;
                    if u12 then
                        task.cancel(u12);
                        u12 = nil;
                    end;
                    if not u3 then
                        l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
                        l__TargetTilt__7.Value = 0;
                        if u2 then
                            u2.Value = 0;
                        end;
                    end;
                    u16 = 0;
                    u17 = 0;
                    u15 = l__TargetTilt__7.Value;
                    if u14 then
                        task.cancel(u14);
                        u14 = nil;
                    end;
                    u11 = true;
                    u12 = task.spawn(function() --[[ Line: 232 ]]
                        -- upvalues: u11 (ref), u3 (ref), u44 (copy), l__ATT1__9 (ref), u16 (ref), u17 (ref), u15 (ref), l__TargetTilt__7 (ref), u2 (ref)
                        while u11 and not u3 do
                            local v53 = workspace:GetServerTimeNow() - u44;
                            local v54;
                            if v53 <= 0 then
                                v54 = 0;
                            elseif v53 <= 13 then
                                local v55 = 4 - v53 * 3.75 / 13;
                                v54 = math.log(4 / (v55 <= 0.001 and 0.001 or v55)) * 3.466666666666667;
                            else
                                v54 = (v53 - 13) / 0.25 + 9.611640903764576;
                            end;
                            local v56 = math.sin(6.283185307179586 * v54) * 15;
                            l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, (math.rad(v56)));
                            local v57 = os.clock();
                            if u16 > 0 then
                                local v58 = v57 - u16;
                                if v58 > 0.0001 then
                                    u17 = (v56 - u15) / v58;
                                end;
                            end;
                            u15 = v56;
                            u16 = v57;
                            l__TargetTilt__7.Value = v56;
                            if u2 then
                                u2.Value = v53 * 0.6;
                            end;
                            task.wait();
                        end;
                    end);
                end;
            end;
        end;
    end);
    local u60 = u17;
    local u61 = u16;
    local u62 = u15;
    local u63 = u12;
    local u64 = u13;
    local u65 = u11;
    local u66 = u14;
    for u67 = 1, 2 do
        u7[u67].Touched:Connect(function(p68) --[[ Line: 308 ]]
            -- upvalues: u10 (copy), u67 (copy), l__LocalPlayer__3 (ref), u36 (copy), u39 (copy), u66 (ref), l__Notify__5 (ref), l__Networking__4 (ref), u5 (copy), u6 (copy)
            if u10[u67] then
            else
                local v69 = p68:FindFirstAncestorWhichIsA("Model");
                if v69 == l__LocalPlayer__3.Character then
                    local v70 = v69:FindFirstChildWhichIsA("Humanoid");
                    if v70 then
                        if v70.Sit then
                        else
                            v70.Sit = true;
                            u36(u67, v69);
                            u10[u67] = l__LocalPlayer__3.UserId;
                            u39();
                            if u66 then
                                task.cancel(u66);
                                u66 = nil;
                            end;
                            u66 = task.delay(2, function() --[[ Line: 84 ]]
                                -- upvalues: u66 (ref), u10 (ref), l__LocalPlayer__3 (ref), l__Notify__5 (ref)
                                u66 = nil;
                                if u10[1] == l__LocalPlayer__3.UserId and true or (u10[2] == l__LocalPlayer__3.UserId and true or false) then
                                    if (not u10[1] or u10[1] == l__LocalPlayer__3.UserId) and (not u10[2] or u10[2] == l__LocalPlayer__3.UserId) then
                                        l__Notify__5:Fire("Ask a friend to join you!");
                                    end;
                                end;
                            end);
                            l__Networking__4.Seesaw.Sit:Fire(u5, u6, u67);
                        end;
                    end;
                end;
            end;
        end);
    end;
    u39();
    l__LocalPlayer__3.CharacterAdded:Connect(function() --[[ Line: 331 ]]
        -- upvalues: u39 (copy)
        task.wait();
        u39();
    end);
    u1.Destroying:Connect(function() --[[ Line: 336 ]]
        -- upvalues: u3 (ref), u66 (ref), u10 (copy), l__LocalPlayer__3 (ref), u9 (copy), u65 (ref), u63 (ref), l__ATT1__9 (copy), l__TargetTilt__7 (copy), u2 (copy), u61 (ref), u60 (ref), u62 (ref), u59 (copy), u64 (ref)
        u3 = true;
        if u66 then
            task.cancel(u66);
            u66 = nil;
        end;
        for v71 = 1, 2 do
            if u10[v71] == l__LocalPlayer__3.UserId then
                if u9[v71] then
                    u9[v71]:Destroy();
                    u9[v71] = nil;
                end;
                u10[v71] = nil;
                local l__Character__13 = l__LocalPlayer__3.Character;
                if l__Character__13 then
                    local v72 = l__Character__13:FindFirstChildWhichIsA("Humanoid");
                    if v72 then
                        v72.Sit = false;
                    end;
                end;
            elseif u9[v71] then
                if u9[v71] then
                    u9[v71]:Destroy();
                    u9[v71] = nil;
                end;
                u10[v71] = nil;
            end;
        end;
        u65 = false;
        if u63 then
            task.cancel(u63);
            u63 = nil;
        end;
        if not u3 then
            l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
            l__TargetTilt__7.Value = 0;
            if u2 then
                u2.Value = 0;
            end;
        end;
        u61 = 0;
        u60 = 0;
        u62 = l__TargetTilt__7.Value;
        u59:Disconnect();
        if u64 then
            u64:Disconnect();
        end;
    end);
    l__ATT1__9.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
    l__Networking__4.Seesaw.RequestState:Fire(u5, u6);
end;