-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local u2 = Instance.new("Animation");
u2.AnimationId = "rbxassetid://70712271927105";
local u3 = Instance.new("Animation");
u3.AnimationId = "rbxassetid://88608854229717";
local u4 = Instance.new("Animation");
u4.AnimationId = "rbxassetid://90165627812936";
local l__CarpetInspect__2 = script.Parent.CarpetInspect;
l__CarpetInspect__2.Parent = nil;
function v1.Run(p5) --[[ Line: 20 ]]
    -- upvalues: l__CarpetInspect__2 (copy), l__RunService__1 (copy), u2 (copy), u3 (copy), u4 (copy)
    local _ = p5.Plot;
    local l__PlayerModel__3 = p5.PlayerModel;
    local l__PlayerHumanoid__4 = p5.PlayerHumanoid;
    local l__Camera__5 = p5.Camera;
    local l__Trove__6 = p5.Trove;
    if l__PlayerModel__3 and l__PlayerHumanoid__4 then
        local u6 = l__CarpetInspect__2:Clone();
        l__Trove__6:Add(u6);
        local v7 = l__PlayerModel__3:Clone();
        v7.PrimaryPart = v7.HumanoidRootPart;
        v7:PivotTo(u6.Player:GetPivot());
        v7.Parent = u6;
        u6.Player:Destroy();
        v7.Name = "Player";
        u6.Parent = workspace.Terrain;
        l__Camera__5.CameraType = Enum.CameraType.Scriptable;
        local u8 = l__RunService__1.RenderStepped:Connect(function(_) --[[ Line: 67 ]]
            -- upvalues: u6 (copy), l__Camera__5 (copy)
            if u6.Parent then
                workspace.CurrentCamera.CFrame = u6.Camera.Camera.CFrame;
                l__Camera__5.FieldOfView = 35;
            end;
        end);
        l__Trove__6:Add(u8);
        u6.Carpet:FindFirstChildOfClass("AnimationController");
        local v9 = { u2, u3, u4 };
        game:GetService("ContentProvider"):PreloadAsync(v9);
        local u10 = script.FadeIn:Clone();
        u10.Parent = game.Players.LocalPlayer.PlayerGui;
        u10.Frame.BackgroundTransparency = 0;
        l__Trove__6:Add(u10);
        repeat
            task.wait(0.25);
        until game:GetService("ContentProvider").RequestQueueSize == 0;
        if u6.Parent then
            local u11 = v7.Humanoid.Animator:LoadAnimation(u2);
            local u12 = u6.Carpet.AnimationController.Animator:LoadAnimation(u3);
            local u13 = u6.Camera.AnimationController.Animator:LoadAnimation(u4);
            local v14 = {};
            workspace.CurrentCamera.FieldOfView = 35;
            local v15 = u13:GetMarkerReachedSignal("Clearup");
            table.insert(v14, v15:Connect(function() --[[ Line: 102 ]]
                -- upvalues: u10 (copy)
                game.TweenService:Create(u10.Frame, TweenInfo.new(0.3), {
                    BackgroundTransparency = 1
                }):Play();
            end));
            local v16 = u13:GetMarkerReachedSignal("TurnOffFaceCamera");
            table.insert(v14, v16:Connect(function() --[[ Line: 112 ]]
                -- upvalues: u6 (copy)
                for _, v17 in u6.Carpet.Carpet.Bone:GetDescendants() do
                    if v17:IsA("Trail") then
                        v17.FaceCamera = false;
                    end;
                end;
            end));
            local v18 = u13:GetMarkerReachedSignal("Start");
            table.insert(v14, v18:Connect(function() --[[ Line: 124 ]]
                -- upvalues: u6 (copy)
                for _, v19 in u6.Carpet.Carpet.Bone:GetDescendants() do
                    if v19:IsA("Trail") then
                        v19.FaceCamera = true;
                        v19.Enabled = true;
                    elseif v19:IsA("ParticleEmitter") then
                        v19:Clear();
                        v19.Enabled = true;
                    end;
                end;
            end));
            local v20 = u13:GetMarkerReachedSignal("FadeOut");
            table.insert(v14, v20:Connect(function() --[[ Line: 138 ]]
                -- upvalues: u10 (copy), u6 (copy)
                game.TweenService:Create(u10.Frame, TweenInfo.new(0.3), {
                    BackgroundTransparency = 0
                }):Play();
                for _, v21 in u6.Carpet.Carpet.Bone:GetDescendants() do
                    if v21:IsA("Trail") then
                        v21.Enabled = false;
                    elseif v21:IsA("ParticleEmitter") then
                        v21.Enabled = false;
                    end;
                end;
            end));
            u11.Looped = true;
            u12.Looped = true;
            u13.Looped = true;
            u11:Play();
            u12:Play();
            u13:Play();
            l__Camera__5.FieldOfView = 25;
            l__Trove__6:Add(function() --[[ Line: 162 ]]
                -- upvalues: u10 (copy), u8 (ref), u11 (copy), u13 (copy), u12 (copy)
                if u10 then
                    u10:Destroy();
                end;
                if u8 then
                    u8:Disconnect();
                end;
                if u11 then
                    u11:Stop();
                    u11:Destroy();
                end;
                if u13 then
                    u13:Stop();
                    u13:Destroy();
                end;
                if u12 then
                    u12:Stop();
                    u12:Destroy();
                end;
            end);
        end;
    end;
end;
return v1;