-- Decompiled with Potassium's decompiler.

local l__Zone__1 = require(game.ReplicatedStorage.SharedModules.Zone);
local l__Networking__2 = require(game.ReplicatedStorage.SharedModules.Networking);
local _ = game.Players.LocalPlayer;
local l__WeatherMachineData__3 = game.ReplicatedStorage.ServerValues.WeatherMachineData;
local l__TweenService__4 = game:GetService("TweenService");
local l__CollectionService__5 = game:GetService("CollectionService");
local l__SoundService__6 = game:GetService("SoundService");
local function u10(p1) --[[ Line: 19 ]]
    -- upvalues: l__CollectionService__5 (copy), l__TweenService__4 (copy)
    local u2 = {};
    for _, v3 in ipairs(p1:GetDescendants()) do
        if v3:IsA("BasePart") and l__CollectionService__5:HasTag(v3, "Colorable") then
            table.insert(u2, {
                part = v3,
                originalColor = v3.Color
            });
        end;
    end;
    if #u2 == 0 then
    else
        local u4 = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
        task.spawn(function() --[[ Line: 31 ]]
            -- upvalues: u2 (copy), l__TweenService__4 (ref), u4 (copy)
            for v5 = 1, 12 do
                local v6 = Color3.fromHSV(v5 / 12 % 1, 1, 1);
                for _, v7 in ipairs(u2) do
                    l__TweenService__4:Create(v7.part, u4, {
                        Color = v6
                    }):Play();
                end;
                task.wait(0.25);
            end;
            local v8 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            for _, v9 in ipairs(u2) do
                if v9.part.Parent then
                    l__TweenService__4:Create(v9.part, v8, {
                        Color = v9.originalColor
                    }):Play();
                end;
            end;
        end);
    end;
end;
local function u22(p11, p12) --[[ Line: 63 ]]
    -- upvalues: l__WeatherMachineData__3 (copy)
    local v13 = p11:FindFirstChild("TextLabel");
    if v13 then
        local v14 = v13:FindFirstChild("SurfaceGui");
        if v14 then
            local v15 = v14:FindFirstChild("TextLabel");
            if v15 then
                local v16 = (l__WeatherMachineData__3:GetAttribute("CooldownUntil") or 0) - os.time();
                local v17 = v14:FindFirstChild("Frame");
                if v17 then
                    v17 = v17:FindFirstChild("Frame");
                end;
                if v16 > 0 then
                    local v18 = math.floor(v16);
                    local v19 = math.max(0, v18);
                    local v20 = math.floor(v19 / 60);
                    v15.Text = string.format("%d:%02d", v20, v19 % 60);
                    v15.TextColor3 = Color3.new(1, 0, 0);
                    if v17 then
                        v17.Size = UDim2.new(0, 0, 1, 0);
                    end;
                    v17.Parent.Visible = false;
                else
                    local v21 = math.clamp(p12, 0, 100);
                    v15.Text = string.format("%.1f", v21) .. "%";
                    v15.TextColor3 = Color3.new(1, 1, 1);
                    if v17 then
                        v17.Size = UDim2.new(v21 / 100, 0, 1, 0);
                    end;
                    v17.Parent.Visible = true;
                end;
            end;
        end;
    end;
end;
local u23 = {};
local function u28(p24) --[[ Line: 95 ]]
    -- upvalues: l__SoundService__6 (copy)
    local v25 = p24.PrimaryPart or p24:FindFirstChildWhichIsA("BasePart");
    if not v25 then
        return nil;
    end;
    local v26 = v25:FindFirstChild("WeatherMachineSFX");
    if v26 then
        return v26;
    end;
    local v27 = Instance.new("Sound");
    v27.Name = "WeatherMachineSFX";
    v27.SoundId = "rbxassetid://134599864373665";
    v27.Volume = 0;
    v27.RollOffMaxDistance = 200;
    v27.Looped = true;
    v27.SoundGroup = l__SoundService__6:FindFirstChild("SFXGroup");
    v27.Parent = v25;
    return v27;
end;
local function u41(p29, p30) --[[ Line: 113 ]]
    -- upvalues: u28 (copy), u23 (copy), l__TweenService__4 (copy)
    if p29 and p29.Parent then
        if p29:FindFirstChild("plr_Val") then
            local v31 = p30 > 0;
            p29.plr_Val.Value = p30;
            for _, v32 in ipairs(p29:GetDescendants()) do
                if v32:IsA("ParticleEmitter") then
                    v32.Enabled = v31;
                end;
            end;
            local u33 = u28(p29);
            if u33 then
                if u23[p29] then
                    u23[p29]:Cancel();
                    u23[p29] = nil;
                end;
                if v31 then
                    if not u33.Playing then
                        u33:Play();
                    end;
                    local v34 = l__TweenService__4:Create(u33, TweenInfo.new(1), {
                        Volume = 1
                    });
                    v34:Play();
                    u23[p29] = v34;
                else
                    local v35 = l__TweenService__4:Create(u33, TweenInfo.new(1), {
                        Volume = 0
                    });
                    v35:Play();
                    u23[p29] = v35;
                    v35.Completed:Once(function() --[[ Line: 144 ]]
                        -- upvalues: u33 (copy)
                        if u33.Volume <= 0.01 then
                            u33:Stop();
                        end;
                    end);
                end;
            end;
            local v36 = p29:FindFirstChild("Icon");
            if v36 and v36:FindFirstChild("Decal") then
                v36.Decal.Color3 = v31 and Color3.new(0, 0.666667, 1) or Color3.new(1, 1, 1);
            end;
            local v37 = p29:FindFirstChild("Speed_MULTI");
            if v37 then
                local v38 = v37:FindFirstChild("SurfaceGui");
                if v38 then
                    v38 = v38:FindFirstChild("TextLabel");
                end;
                if v38 then
                    local v39 = tostring(p30);
                    local v40 = #game.Players:GetPlayers();
                    v38.Text = v39 .. "/" .. tostring(v40);
                end;
            end;
        end;
    end;
end;
return function(u42) --[[ Line: 169 ]]
    -- upvalues: u22 (copy), l__WeatherMachineData__3 (copy), u10 (copy), u41 (copy), l__Zone__1 (copy), l__Networking__2 (copy)
    local v43 = 0;
    while true do
        local v44 = game:GetService("Players"):GetPlayerByUserId(u42:GetAttribute("UserId"));
        if not v44 then
            v43 = v43 + 1;
            task.wait(0.5);
        end;
        if v44 or v43 >= 20 then
            if v44 then
                local u45 = u42:FindFirstChild("Fill_Val");
                if u45 then
                    local u46 = u42:GetAttribute("PropId");
                    if u46 then
                        u22(u42, u45.Value);
                        u45:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 191 ]]
                            -- upvalues: u22 (ref), u42 (copy), u45 (copy)
                            u22(u42, u45.Value);
                        end);
                        task.spawn(function() --[[ Line: 196 ]]
                            -- upvalues: u42 (copy), l__WeatherMachineData__3 (ref), u22 (ref), u45 (copy)
                            while u42.Parent do
                                if (l__WeatherMachineData__3:GetAttribute("CooldownUntil") or 0) - os.time() > 0 then
                                    u22(u42, u45.Value);
                                end;
                                task.wait(1);
                            end;
                        end);
                        l__WeatherMachineData__3:GetAttributeChangedSignal("CooldownUntil"):Connect(function() --[[ Line: 205 ]]
                            -- upvalues: u22 (ref), u42 (copy), u45 (copy), l__WeatherMachineData__3 (ref), u10 (ref)
                            u22(u42, u45.Value);
                            if (l__WeatherMachineData__3:GetAttribute("CooldownUntil") or 0) - os.time() > 0 then
                                u10(u42);
                            end;
                        end);
                        local u47 = {};
                        local function v54(p48) --[[ Line: 214 ]]
                            -- upvalues: u47 (copy), u46 (copy), u45 (copy), u41 (ref), u42 (copy)
                            if u47[p48] then
                            elseif p48.Name == u46 then
                                local v49 = {};
                                u47[p48] = v49;
                                local u50 = p48:FindFirstChild("Fill_Value");
                                local u51 = p48:FindFirstChild("Active_Players");
                                if u50 and u51 then
                                    u45.Value = u50.Value;
                                    local v52 = u50:GetPropertyChangedSignal("Value");
                                    table.insert(v49, v52:Connect(function() --[[ Line: 228 ]]
                                        -- upvalues: u45 (ref), u50 (copy)
                                        u45.Value = u50.Value;
                                    end));
                                    local function v53() --[[ Line: 232 ]]
                                        -- upvalues: u41 (ref), u42 (ref), u51 (copy)
                                        u41(u42, #u51:GetChildren());
                                    end;
                                    u41(u42, #u51:GetChildren());
                                    table.insert(v49, u51.ChildAdded:Connect(v53));
                                    table.insert(v49, u51.ChildRemoved:Connect(v53));
                                    table.insert(v49, game.Players.PlayerAdded:Connect(v53));
                                end;
                            end;
                        end;
                        local function v58(p55) --[[ Line: 242 ]]
                            -- upvalues: u47 (copy)
                            local v56 = u47[p55];
                            if v56 then
                                for _, v57 in ipairs(v56) do
                                    v57:Disconnect();
                                end;
                                u47[p55] = nil;
                            end;
                        end;
                        for _, v59 in ipairs(l__WeatherMachineData__3:GetChildren()) do
                            v54(v59);
                        end;
                        l__WeatherMachineData__3.ChildAdded:Connect(v54);
                        l__WeatherMachineData__3.ChildRemoved:Connect(v58);
                        for _, v60 in ipairs(u42:GetDescendants()) do
                            if v60:IsA("Script") then
                                v60.Enabled = true;
                            end;
                        end;
                        local l__ZONE__7 = u42:WaitForChild("ZONE", 10);
                        if l__ZONE__7 then
                            l__ZONE__7.CanQuery = true;
                            local v61 = l__Zone__1.new(l__ZONE__7);
                            local l__Name__8 = v44.Name;
                            v61.localPlayerEntered:Connect(function() --[[ Line: 273 ]]
                                -- upvalues: u46 (copy), l__Name__8 (copy), l__Networking__2 (ref)
                                if u46 and l__Name__8 then
                                    l__Networking__2.WeatherMachine.PlayerEntered:Fire(l__Name__8, u46);
                                end;
                            end);
                            v61.localPlayerExited:Connect(function() --[[ Line: 278 ]]
                                -- upvalues: u46 (copy), l__Name__8 (copy), l__Networking__2 (ref)
                                if u46 and l__Name__8 then
                                    l__Networking__2.WeatherMachine.PlayerExited:Fire(l__Name__8, u46);
                                end;
                            end);
                            return;
                        else
                            return;
                        end;
                    else
                        return;
                    end;
                else
                    return;
                end;
            else
                return;
            end;
        end;
    end;
end;