-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__Debris__5 = game:GetService("Debris");
local l__Networking__6 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local v1 = {};
local u2 = {};
local function u6(p3) --[[ Line: 33 ]]
    local v4 = workspace:FindFirstChild("_PetVisualClient");
    if v4 then
        v4 = v4:FindFirstChild("Models");
    end;
    if not v4 then
        return nil;
    end;
    local l__Parent__7 = p3.Parent;
    if l__Parent__7 then
        l__Parent__7 = p3.Parent.Name;
    end;
    for _, v5 in pairs(v4:GetChildren()) do
        if v5:IsA("Model") and (v5:GetAttribute("OwnerSlot") == p3.Name and (not l__Parent__7 or v5:GetAttribute("Owner") == l__Parent__7)) then
            return v5;
        end;
    end;
    return nil;
end;
local function u10(p7) --[[ Line: 49 ]]
    for _, v8 in pairs({ "Mouth", "FireOrigin", "Head" }) do
        local v9 = p7:FindFirstChild(v8, true);
        if v9 and v9:IsA("BasePart") then
            return v9;
        end;
    end;
    return p7.PrimaryPart;
end;
local function u14() --[[ Line: 57 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy)
    local v11 = l__ReplicatedStorage__2:FindFirstChild("Assets");
    if v11 then
        v11 = v11:FindFirstChild("VFX");
    end;
    if v11 then
        local v12 = v11:FindFirstChild("OtherStorage");
        if v12 then
            v12 = v12:FindFirstChild("FireEmitter");
        end;
        if v12 and v12:IsA("Attachment") then
            return v12;
        else
            local v13 = v11:FindFirstChild("StatusVFX");
            if v13 then
                v13 = v13:FindFirstChild("BurningVFX");
            end;
            if v13 then
                v13 = v13:FindFirstChild("fire");
            end;
            if v13 and v13:IsA("ParticleEmitter") then
                return v13;
            else
                return nil;
            end;
        end;
    else
        return nil;
    end;
end;
local function u22(p15, p16) --[[ Line: 82 ]]
    local u17 = p15:FindFirstChildOfClass("AnimationController");
    if u17 then
        u17 = u17:FindFirstChildOfClass("Animator");
    end;
    if u17 then
        local v18 = p15:FindFirstChild("Animations");
        local u19 = v18 and v18:FindFirstChild("FireBreath") or p15:FindFirstChild("FireBreath");
        if u19 and u19:IsA("Animation") then
            local v20, u21 = pcall(function() --[[ Line: 92 ]]
                -- upvalues: u17 (copy), u19 (copy)
                return u17:LoadAnimation(u19);
            end);
            if v20 and u21 then
                u21.Looped = true;
                u21.Priority = Enum.AnimationPriority.Action;
                u21:Play(0.15);
                task.delay(p16, function() --[[ Line: 99 ]]
                    -- upvalues: u21 (copy)
                    if u21 and u21.IsPlaying then
                        u21:Stop(0.2);
                    end;
                end);
            end;
        end;
    end;
end;
local function u43(u23, p24, u25, p26) --[[ Line: 105 ]]
    -- upvalues: u10 (copy), u14 (copy), u2 (copy), u22 (copy), l__RunService__3 (copy), l__Debris__5 (copy)
    local u27 = u10(p24);
    if u27 then
        local u28 = Instance.new("Part");
        u28.Name = "BlackDragonFireBeam";
        u28.Anchored = true;
        u28.CanCollide = false;
        u28.CanQuery = false;
        u28.CanTouch = false;
        u28.Massless = true;
        u28.Transparency = 1;
        u28.Size = Vector3.new(0.2, 0.2, 1);
        u28.Parent = workspace;
        local v29 = u14();
        if v29 then
            local v30 = v29:Clone();
            v30.Parent = u28;
            v30.Position = Vector3.new(0, 0, -0.5);
        end;
        local u31 = {};
        local v32 = u2[u23];
        if v32 and v32.Beam then
            v32.Token = u31;
            if v32.Beam.Parent then
                v32.Beam:Destroy();
            end;
        end;
        u2[u23] = {
            Token = u31,
            Beam = u28
        };
        u22(p24, p26);
        local u33 = os.clock() + p26;
        local u34 = nil;
        u34 = l__RunService__3.RenderStepped:Connect(function() --[[ Line: 139 ]]
            -- upvalues: u2 (ref), u23 (copy), u31 (copy), u33 (copy), u28 (copy), u27 (copy), u34 (ref), u25 (copy)
            local v35 = u2[u23];
            if v35 and (v35.Token == u31 and (u33 > os.clock() and (u28.Parent and u27.Parent))) then
                local l__Position__8 = u27.Position;
                local v36 = u25;
                local v37;
                if v36 then
                    v37 = v36:FindFirstChild("HumanoidRootPart");
                    if not (v37 and v37:IsA("BasePart")) then
                        v37 = nil;
                    end;
                else
                    v37 = nil;
                end;
                local v38;
                if v37 then
                    v38 = v37.Position;
                else
                    v38 = l__Position__8 + u27.CFrame.LookVector * 10;
                end;
                local v39 = math.min((v38 - l__Position__8).Magnitude, 60);
                local v40 = v39 < 0.1 and 0.1 or v39;
                u28.Size = Vector3.new(0.2, 0.2, v40);
                u28.CFrame = CFrame.lookAt(l__Position__8, v38) * CFrame.new(0, 0, -v40 * 0.5);
                u28.FireEmitter.WorldCFrame = CFrame.lookAt(l__Position__8, v38);
            else
                if u34 then
                    u34:Disconnect();
                end;
            end;
        end);
        task.delay(p26, function() --[[ Line: 156 ]]
            -- upvalues: u34 (ref), u2 (ref), u23 (copy), u31 (copy), u28 (copy), l__Debris__5 (ref)
            if u34 then
                u34:Disconnect();
            end;
            local v41 = u2[u23];
            if v41 and v41.Token ~= u31 then
            else
                u2[u23] = nil;
                for _, v42 in pairs(u28:GetChildren()) do
                    if v42:IsA("ParticleEmitter") then
                        v42.Enabled = false;
                    end;
                end;
                l__Debris__5:AddItem(u28, 2);
            end;
        end);
    end;
end;
local function u54(p44, p45) --[[ Line: 171 ]]
    -- upvalues: l__CollectionService__4 (copy), l__ReplicatedStorage__2 (copy), l__Players__1 (copy), l__Debris__5 (copy)
    local v46;
    if p44 then
        v46 = p44:FindFirstChild("HumanoidRootPart");
        if not (v46 and v46:IsA("BasePart")) then
            v46 = nil;
        end;
    else
        v46 = nil;
    end;
    if v46 then
        if p45 then
            for _, v47 in pairs(l__CollectionService__4:GetTagged("BlackDragonBurn")) do
                if v47:IsDescendantOf(p44) then
                    return;
                end;
            end;
            local v48 = l__ReplicatedStorage__2:FindFirstChild("Assets");
            if v48 then
                v48 = v48:FindFirstChild("PetEffects");
            end;
            if v48 then
                v48 = v48:FindFirstChild("BlackDragonPlayerFire");
            end;
            if v48 then
                local v49 = game.SoundService.SFX.burnEffect:Clone();
                v49.Parent = v46;
                v49.Looped = true;
                v49:AddTag("BlackDragonBurn");
                if p44 == l__Players__1.LocalPlayer.Character then
                    local v50 = game.ReplicatedStorage.Assets.Vignette:Clone();
                    v50.ImageLabel.ImageColor3 = Color3.fromRGB(255, 35, 35);
                    v50.Parent = game.Players.LocalPlayer.PlayerGui;
                    v50.ImageLabel.ImageTransparency = 0.6;
                    v50.Name = "FireVignette";
                    v50:AddTag("BlackDragonBurn");
                    game.TweenService:Create(v50.ImageLabel.UIScale, TweenInfo.new(0.5), {
                        Scale = 1.01
                    }):Play();
                    game.TweenService:Create(v50.ImageLabel, TweenInfo.new(0.5), {
                        ImageTransparency = 0.8
                    }):Play();
                end;
                for _, v51 in pairs(v48:GetChildren()) do
                    local v52 = v51:Clone();
                    v52.Parent = v46;
                    if v52:IsA("ParticleEmitter") then
                        v52.Enabled = true;
                    end;
                    v52:AddTag("BlackDragonBurn");
                end;
            end;
        else
            for _, v53 in pairs(l__CollectionService__4:GetTagged("BlackDragonBurn")) do
                if v53:IsDescendantOf(p44) then
                    v53:RemoveTag("BlackDragonBurn");
                    if v53:IsA("ParticleEmitter") then
                        v53.Enabled = false;
                    end;
                    if v53:IsA("ScreenGui") then
                        game.TweenService:Create(v53.ImageLabel.UIScale, TweenInfo.new(0.5), {
                            Scale = 1.06
                        }):Play();
                        game.TweenService:Create(v53.ImageLabel, TweenInfo.new(0.5), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                    l__Debris__5:AddItem(v53, 1);
                end;
            end;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 232 ]] end;
function v1.Start(_) --[[ Line: 234 ]]
    -- upvalues: l__Networking__6 (copy), u6 (copy), u43 (copy), u54 (copy)
    l__Networking__6.BlackDragon.BreathStart.OnClientEvent:Connect(function(p55, p56, p57) --[[ Line: 235 ]]
        -- upvalues: u6 (ref), u43 (ref)
        if typeof(p55) == "Instance" then
            if type(p57) == "number" and p57 > 0 then
                local v58 = u6(p55);
                if v58 then
                    u43(p55, v58, p56, p57);
                end;
            end;
        end;
    end);
    l__Networking__6.BlackDragon.Ignite.OnClientEvent:Connect(function(p59, p60) --[[ Line: 243 ]]
        -- upvalues: u54 (ref)
        if typeof(p59) == "Instance" then
            u54(p59, p60 == true);
        end;
    end);
end;
return v1;