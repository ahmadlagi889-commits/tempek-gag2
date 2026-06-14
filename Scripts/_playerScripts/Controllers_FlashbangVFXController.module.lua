-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
local l__Lighting__3 = game:GetService("Lighting");
local l__Debris__4 = game:GetService("Debris");
local l__SoundService__5 = game:GetService("SoundService");
local l__CurrentCamera__6 = workspace.CurrentCamera;
local l__Networking__7 = require(game.ReplicatedStorage.SharedModules.Networking);
local u1 = {
    Init = function(_) --[[ Name: Init, Line 19 ]] end
};
function u1.Start(_) --[[ Line: 21 ]]
    -- upvalues: l__Networking__7 (copy), u1 (copy)
    l__Networking__7.Flashbang.Flashbang.OnClientEvent:Connect(function() --[[ Line: 22 ]]
        -- upvalues: u1 (ref)
        u1:Flash(1, 1.75);
    end);
    l__Networking__7.Flashbang.Detonate.OnClientEvent:Connect(function() --[[ Line: 26 ]]
        -- upvalues: u1 (ref)
        u1:DetonationFlash();
    end);
end;
local function u4() --[[ Line: 31 ]]
    -- upvalues: l__Players__2 (copy)
    local l__LocalPlayer__8 = l__Players__2.LocalPlayer;
    if l__LocalPlayer__8 then
        l__LocalPlayer__8 = l__Players__2.LocalPlayer:FindFirstChild("PlayerGui");
    end;
    if not l__LocalPlayer__8 then
        return nil;
    end;
    local v2 = l__LocalPlayer__8:FindFirstChild("FlashbangGui");
    if not v2 then
        v2 = Instance.new("ScreenGui");
        v2.Name = "FlashbangGui";
        v2.DisplayOrder = 999;
        v2.IgnoreGuiInset = true;
        v2.ResetOnSpawn = false;
        v2.Parent = l__LocalPlayer__8;
    end;
    local v3 = v2:FindFirstChild("WhiteFrame");
    if not v3 then
        v3 = Instance.new("Frame");
        v3.Name = "WhiteFrame";
        v3.Size = UDim2.fromScale(1, 1);
        v3.BackgroundColor3 = Color3.new(1, 1, 1);
        v3.BackgroundTransparency = 1;
        v3.BorderSizePixel = 0;
        v3.Parent = v2;
    end;
    return v3;
end;
function u1.Flash(_, u5, p6) --[[ Line: 61 ]]
    -- upvalues: u4 (copy), l__TweenService__1 (copy), l__Debris__4 (copy), l__Lighting__3 (copy), l__CurrentCamera__6 (copy)
    local u7 = p6 or 0.5;
    task.spawn(function() --[[ Line: 63 ]]
        -- upvalues: u5 (copy), u4 (ref), l__TweenService__1 (ref), l__Debris__4 (ref), l__Lighting__3 (ref), l__CurrentCamera__6 (ref), u7 (ref)
        local v8 = TweenInfo.new(u5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local v9 = TweenInfo.new(u5 * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local v10 = u4();
        v10.Parent.Enabled = true;
        if v10 then
            v10.BackgroundTransparency = 1;
            local v11 = l__TweenService__1:Create(v10, v8, {
                BackgroundTransparency = 0
            });
            v11:Play();
            l__Debris__4:AddItem(v11, v8.Time);
        end;
        local v12 = l__TweenService__1:Create(l__Lighting__3, v8, {
            ExposureCompensation = 9
        });
        v12:Play();
        l__Debris__4:AddItem(v12, v8.Time);
        local v13 = l__TweenService__1:Create(l__CurrentCamera__6, v8, {
            FieldOfView = 80
        });
        v13:Play();
        l__Debris__4:AddItem(v13, v8.Time);
        task.wait(u5 + u7);
        local v14 = l__TweenService__1:Create(l__Lighting__3, v9, {
            ExposureCompensation = 0
        });
        v14:Play();
        l__Debris__4:AddItem(v14, v9.Time);
        local v15 = l__TweenService__1:Create(l__CurrentCamera__6, v9, {
            FieldOfView = 70
        });
        v15:Play();
        l__Debris__4:AddItem(v15, v9.Time);
        if v10 then
            local v16 = l__TweenService__1:Create(v10, v9, {
                BackgroundTransparency = 1
            });
            v16:Play();
            l__Debris__4:AddItem(v16, v9.Time);
        end;
    end);
end;
function u1.DetonationFlash(_) --[[ Line: 100 ]]
    -- upvalues: u4 (copy), l__TweenService__1 (copy), l__Debris__4 (copy), l__Lighting__3 (copy), l__CurrentCamera__6 (copy), l__SoundService__5 (copy)
    task.spawn(function() --[[ Line: 101 ]]
        -- upvalues: u4 (ref), l__TweenService__1 (ref), l__Debris__4 (ref), l__Lighting__3 (ref), l__CurrentCamera__6 (ref), l__SoundService__5 (ref)
        local v17 = u4();
        if v17 then
            local v18 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v19 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            v17.Parent.Enabled = true;
            v17.BackgroundTransparency = 1;
            local v20 = l__TweenService__1:Create(v17, v18, {
                BackgroundTransparency = 0
            });
            v20:Play();
            l__Debris__4:AddItem(v20, v18.Time);
            local v21 = l__TweenService__1:Create(l__Lighting__3, v18, {
                ExposureCompensation = 9
            });
            v21:Play();
            l__Debris__4:AddItem(v21, v18.Time);
            local v22 = l__TweenService__1:Create(l__CurrentCamera__6, v18, {
                FieldOfView = 80
            });
            v22:Play();
            l__Debris__4:AddItem(v22, v18.Time);
            local u23 = Instance.new("Sound");
            u23.SoundId = "rbxassetid://122137666092419";
            u23.Volume = 2;
            u23.SoundGroup = l__SoundService__5:FindFirstChild("SFXGroup");
            u23.Parent = v17.Parent;
            u23:Play();
            l__Debris__4:AddItem(u23, 30);
            task.spawn(function() --[[ Line: 130 ]]
                -- upvalues: u23 (copy), l__TweenService__1 (ref), l__Debris__4 (ref)
                if not u23.IsLoaded then
                    u23.Loaded:Wait();
                end;
                local l__TimeLength__9 = u23.TimeLength;
                if l__TimeLength__9 > 0 and u23.Parent then
                    local v24 = TweenInfo.new(l__TimeLength__9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                    local v25 = l__TweenService__1:Create(u23, v24, {
                        Volume = 0.5
                    });
                    v25:Play();
                    l__Debris__4:AddItem(v25, v24.Time);
                end;
            end);
            local v26 = math.random(40, 50) * 0.1;
            task.wait(v26);
            local v27 = l__TweenService__1:Create(v17, v19, {
                BackgroundTransparency = 1
            });
            v27:Play();
            l__Debris__4:AddItem(v27, v19.Time);
            local v28 = l__TweenService__1:Create(l__Lighting__3, v19, {
                ExposureCompensation = 0
            });
            v28:Play();
            l__Debris__4:AddItem(v28, v19.Time);
            local v29 = l__TweenService__1:Create(l__CurrentCamera__6, v19, {
                FieldOfView = 70
            });
            v29:Play();
            l__Debris__4:AddItem(v29, v19.Time);
        end;
    end);
end;
return u1;