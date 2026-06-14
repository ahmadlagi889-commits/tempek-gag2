-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__Networking__5 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__Environment__6 = require(l__ReplicatedStorage__3.SharedModules.Environment);
local l__MessagePrompt__7 = require(l__ReplicatedStorage__3.ClientModules.MessagePrompt);
local l__PlayerStateClient__8 = require(l__ReplicatedStorage__3.ClientModules.PlayerStateClient);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__CurrentCamera__10 = workspace.CurrentCamera;
local u2 = { "Dig it up", "Cancel" };
local u3 = nil;
local u4 = false;
local u5 = false;
l__LocalPlayer__9:WaitForChild("HideCollectProximityPrompts");
local l__Gardens__11 = workspace:WaitForChild("Gardens");
local l__GardenZoneData__12 = l__ReplicatedStorage__3:WaitForChild("GardenZoneData");
local l__Gnomes__13 = workspace:WaitForChild("Gnomes");
local u6 = nil;
local u7 = 0;
local u8 = false;
local u9 = nil;
local u10 = 0;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = {};
local u17 = l__RunService__4:IsStudio() or l__Environment__6.env == "Dev";
local function u18(...) --[[ Line: 59 ]]
    -- upvalues: u17 (copy)
    if u17 then
        print("[ShovelController:Hit]", ...);
    end;
end;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local function u29() --[[ Line: 97 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u25 (ref)
    local l__Character__14 = l__LocalPlayer__9.Character;
    if l__Character__14 then
        local v26 = l__Character__14:FindFirstChildOfClass("Humanoid");
        if v26 then
            local v27 = v26:FindFirstChildOfClass("Animator");
            if v27 then
                local v28 = Instance.new("Animation");
                v28.AnimationId = "rbxassetid://78592768207309";
                u25 = v27:LoadAnimation(v28);
                u25.Looped = false;
                u25.Priority = Enum.AnimationPriority.Action4;
                u25:Play();
            end;
        end;
    end;
end;
local l__TweenService__15 = game:GetService("TweenService");
local u30 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
function v1.Init(_) --[[ Line: 129 ]]
    -- upvalues: l__Networking__5 (copy), l__TweenService__15 (copy), u30 (copy)
    l__Networking__5.ShovelFX.Protected.OnClientEvent:Connect(function(p31) --[[ Line: 130 ]]
        -- upvalues: l__TweenService__15 (ref), u30 (ref)
        local v32 = game.Players:FindFirstChild(p31);
        local v33 = v32 and v32.Character;
        if v33 then
            if v33:FindFirstChild("HitHighlight") then
                return;
            end;
            local v34 = Instance.new("Highlight");
            v34.Name = "HitHighlight";
            v34.Parent = v33;
            v34.FillTransparency = 0;
            v34.FillColor = Color3.new(1, 1, 1);
            v34.OutlineTransparency = 1;
            local v35 = l__TweenService__15:Create(v34, u30, {
                FillTransparency = 1
            });
            v35:Play();
            game.Debris:AddItem(v35, u30.Time);
            game.Debris:AddItem(v34, u30.Time);
        end;
    end);
end;
function v1.GetHoldProgressGui(_) --[[ Line: 151 ]]
    -- upvalues: u12 (ref), l__LocalPlayer__9 (copy), u13 (ref), u14 (ref)
    if u12 then
        return u12;
    end;
    local l__PlayerGui__16 = l__LocalPlayer__9:WaitForChild("PlayerGui");
    local v36 = Instance.new("ScreenGui");
    v36.Name = "ShovelHoldProgress";
    v36.ResetOnSpawn = false;
    v36.IgnoreGuiInset = true;
    v36.DisplayOrder = 200;
    local u37 = Instance.new("Frame");
    u37.Name = "Ring";
    u37.AnchorPoint = Vector2.new(0.5, 0.5);
    u37.Size = UDim2.fromOffset(64, 64);
    u37.BackgroundTransparency = 1;
    u37.Visible = false;
    u37.Parent = v36;
    local v38 = Instance.new("ImageLabel");
    v38.Name = "Background";
    v38.Size = UDim2.fromScale(1, 1);
    v38.BackgroundTransparency = 1;
    v38.Image = "rbxasset://textures/ui/Controls/RadialFill.png";
    v38.ImageColor3 = Color3.fromRGB(120, 20, 20);
    v38.ImageTransparency = 0.62;
    v38.Parent = u37;
    local function v44(p39, p40) --[[ Line: 180 ]]
        -- upvalues: u37 (copy)
        local v41 = Instance.new("Frame");
        v41.Name = p39;
        v41.Size = UDim2.fromScale(0.5, 1);
        v41.Position = p40 and UDim2.fromScale(0.5, 0) or UDim2.new();
        v41.BackgroundTransparency = 1;
        v41.ClipsDescendants = true;
        v41.Parent = u37;
        local v42 = Instance.new("ImageLabel");
        v42.Name = "ProgressBarImage";
        v42.Size = UDim2.fromScale(2, 1);
        v42.Position = p40 and UDim2.fromScale(-1, 0) or UDim2.new();
        v42.BackgroundTransparency = 1;
        v42.Image = "rbxasset://textures/ui/Controls/RadialFill.png";
        v42.ImageColor3 = Color3.fromRGB(255, 60, 60);
        v42.Parent = v41;
        local v43 = Instance.new("UIGradient");
        v43.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.499, 0),
            NumberSequenceKeypoint.new(0.5, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
        v43.Parent = v42;
        return v41, v43;
    end;
    local _, u45 = v44("RightGradient", true);
    local _, u46 = v44("LeftGradient", false);
    local v47 = Instance.new("NumberValue");
    v47.Name = "Progress";
    v47.Value = 0;
    v47.Parent = u37;
    v47.Changed:Connect(function(p48) --[[ Line: 217 ]]
        -- upvalues: u45 (copy), u46 (copy)
        local v49 = math.clamp(p48 * 360, 0, 360);
        u45.Rotation = math.clamp(v49, 0, 180);
        u46.Rotation = math.clamp(v49, 180, 360);
    end);
    v36.Parent = l__PlayerGui__16;
    u12 = v36;
    u13 = u37;
    u14 = v47;
    return v36;
end;
function v1.HideHoldProgress(_) --[[ Line: 232 ]]
    -- upvalues: u11 (ref), u15 (ref), u13 (ref), u14 (ref)
    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;
    u15 = nil;
    if u13 then
        u13.Visible = false;
    end;
    if u14 then
        u14.Value = 0;
    end;
end;
function v1.ShouldHoldToDelete(_) --[[ Line: 246 ]]
    -- upvalues: u21 (ref)
    if u21 then
        if u21.isPlayer then
            return false;
        else
            return u21.isGnome or u21.isFruit or u21.plantId ~= nil;
        end;
    else
        return false;
    end;
end;
function v1.ShowHoldProgress(p50) --[[ Line: 256 ]]
    -- upvalues: u13 (ref), l__UserInputService__2 (copy)
    p50:GetHoldProgressGui();
    if u13 then
        local v51 = l__UserInputService__2:GetMouseLocation();
        u13.Position = UDim2.fromOffset(v51.X, v51.Y);
        u13.Visible = true;
    end;
end;
function v1.StartDeleteHold(u52) --[[ Line: 266 ]]
    -- upvalues: u15 (ref), u20 (ref), u11 (ref), l__RunService__4 (copy), u8 (ref), l__UserInputService__2 (copy), u13 (ref), u7 (ref), u14 (ref)
    u52:HideHoldProgress();
    u15 = u20;
    u52:ShowHoldProgress();
    u11 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 270 ]]
        -- upvalues: u8 (ref), u52 (copy), u15 (ref), u20 (ref), l__UserInputService__2 (ref), u13 (ref), u7 (ref), u14 (ref)
        if u8 then
            if u15 and u15 == u20 then
                if u52:ShouldHoldToDelete() then
                    local v53 = l__UserInputService__2:GetMouseLocation();
                    if u13 then
                        u13.Position = UDim2.fromOffset(v53.X, v53.Y);
                    end;
                    local v54 = (os.clock() - u7) / 0.65;
                    local v55 = math.clamp(v54, 0, 1);
                    if u14 then
                        u14.Value = v55;
                    end;
                    if v55 >= 1 then
                        u52:HideHoldProgress();
                        u52:ProcessShovelAction();
                    end;
                else
                    u52:HideHoldProgress();
                end;
            else
                u52:HideHoldProgress();
            end;
        else
            u52:HideHoldProgress();
        end;
    end);
end;
function v1.Start(u56) --[[ Line: 301 ]]
    -- upvalues: l__UserInputService__2 (copy), u10 (ref), u23 (ref), u18 (copy), u8 (ref), u7 (ref), u9 (ref), l__RunService__4 (copy), u3 (ref), l__PlayerStateClient__8 (copy), l__LocalPlayer__9 (copy), u24 (ref)
    l__UserInputService__2.InputBegan:Connect(function(p57, p58) --[[ Line: 302 ]]
        -- upvalues: u56 (copy), u10 (ref), u23 (ref), u18 (ref), u8 (ref), u7 (ref), u9 (ref), l__RunService__4 (ref)
        if p58 then
        else
            local v59 = p57.UserInputType == Enum.UserInputType.MouseButton1;
            local v60 = p57.UserInputType == Enum.UserInputType.Touch;
            if v59 or (v60 or p57.KeyCode == Enum.KeyCode.ButtonR2) then
                local v61 = os.clock();
                local v62 = u56:ShouldHoldToDelete();
                local v63 = v61 - u10;
                if not v62 and v63 < 0.65 then
                    if u23 then
                        u18(("input ignored: client swing cooldown (%.2fs since last, need %.2fs)"):format(v63, 0.65));
                    end;
                    return;
                end;
                if v60 then
                    if v62 then
                        u8 = true;
                        u7 = v61;
                        u56:StartDeleteHold();
                    end;
                    return;
                end;
                u8 = true;
                u7 = v61;
                if v62 then
                    u18("input routed to hold-to-delete (plant/fruit/gnome highlighted) - no player hit detection this click");
                    u56:StartDeleteHold();
                    return;
                end;
                u56:ProcessShovelAction();
                if not u9 then
                    u9 = l__RunService__4.Heartbeat:Connect(function() --[[ Line: 346 ]]
                        -- upvalues: u8 (ref), u7 (ref), u56 (ref), u10 (ref)
                        debug.profilebegin("Controllers/ShovelController/AutoShovel");
                        if u8 and os.clock() - u7 >= 1 then
                            if u56:ShouldHoldToDelete() then
                                debug.profileend();
                                return;
                            end;
                            if os.clock() - u10 >= 0.1 then
                                u56:ProcessShovelAction();
                            end;
                        end;
                        debug.profileend();
                    end);
                end;
            end;
        end;
    end);
    l__UserInputService__2.InputEnded:Connect(function(p64) --[[ Line: 364 ]]
        -- upvalues: u8 (ref), u56 (copy), u9 (ref)
        if (p64.UserInputType == Enum.UserInputType.MouseButton1 or p64.UserInputType == Enum.UserInputType.Touch) and true or p64.KeyCode == Enum.KeyCode.ButtonR2 then
            u8 = false;
            u56:HideHoldProgress();
            if u9 then
                u9:Disconnect();
                u9 = nil;
            end;
        end;
    end);
    l__UserInputService__2.TouchTapInWorld:Connect(function(_, p65) --[[ Line: 379 ]]
        -- upvalues: u10 (ref), u56 (copy)
        if p65 then
        elseif os.clock() - u10 < 0.65 then
        elseif u56:ShouldHoldToDelete() then
        else
            u56:ProcessShovelAction();
        end;
    end);
    task.spawn(function() --[[ Line: 390 ]]
        -- upvalues: u3 (ref), l__PlayerStateClient__8 (ref)
        u3 = l__PlayerStateClient__8:WaitForLocalReplica(30);
    end);
    local l__Character__17 = l__LocalPlayer__9.Character;
    if l__Character__17 then
        u56:SetupCharacter(l__Character__17);
    end;
    l__LocalPlayer__9.CharacterAdded:Connect(function(p66) --[[ Line: 396 ]]
        -- upvalues: u56 (copy)
        u56:SetupCharacter(p66);
    end);
    l__LocalPlayer__9:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 397 ]]
        -- upvalues: u24 (ref)
        u24 = nil;
    end);
end;
function v1.ActivateHitDetection(p67) --[[ Line: 400 ]]
    -- upvalues: u18 (copy), l__LocalPlayer__9 (copy), l__Networking__5 (copy), l__Players__1 (copy), u16 (copy)
    local v68 = p67:GetEquippedTool();
    if v68 then
        local v69 = l__LocalPlayer__9:GetAttribute("IsInOwnGarden") and "NormalCollision" or "GardenCollision";
        local v70 = {};
        local u71 = {};
        local u72 = {};
        local u73 = {};
        for _, v74 in v68:GetDescendants() do
            if v74:IsA("BasePart") and v74.Name ~= v69 then
                table.insert(v70, v74);
            end;
        end;
        u18(("swing started: listening on %d shovel part(s) for %.2fs (ignoring \'%s\' parts)"):format(#v70, 0.4, v69));
        if #v70 == 0 then
            u18("WARNING: 0 hittable parts on the shovel - Touched can never fire, no player can be hit this swing");
        end;
        l__Networking__5.Shovel.SwingShovel:Fire();
        local l__Character__18 = l__LocalPlayer__9.Character;
        if l__Character__18 then
            l__Character__18 = l__Character__18:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__18 then
            local v75 = workspace:FindFirstChild("_PetVisualClient");
            if v75 then
                v75 = v75:FindFirstChild("Models");
            end;
            if v75 then
                local l__Position__19 = l__Character__18.Position;
                for _, v76 in pairs(v75:GetChildren()) do
                    local v77 = v76:GetAttribute("PetID");
                    local v78 = v76:GetAttribute("Owner");
                    if typeof(v77) == "string" and (v77 ~= "" and (typeof(v78) == "string" and v78 ~= l__LocalPlayer__9.Name)) then
                        local l__PrimaryPart__20 = v76.PrimaryPart;
                        if l__PrimaryPart__20 and (l__PrimaryPart__20.Position - l__Position__19).Magnitude <= 8 then
                            local v79 = l__Players__1:FindFirstChild(v78);
                            if v79 then
                                u71[v77] = true;
                                l__Networking__5.Pets.ScarePet:Fire(v79.UserId, v77);
                            end;
                        end;
                    end;
                end;
            end;
        end;
        for _, v80 in v70 do
            local v91 = v80.Touched:Connect(function(p81) --[[ Line: 456 ]]
                -- upvalues: u71 (copy), l__Players__1 (ref), l__LocalPlayer__9 (ref), l__Networking__5 (ref), u73 (copy), u16 (ref), u18 (ref)
                local v82 = p81:FindFirstAncestorWhichIsA("Model");
                if v82 then
                    local v83 = v82:GetAttribute("Owner");
                    local v84 = v82:GetAttribute("PetID");
                    if typeof(v83) == "string" and (typeof(v84) == "string" and v84 ~= "") then
                        if u71[v84] then
                        else
                            local v85 = l__Players__1:FindFirstChild(v83);
                            if v85 then
                                if v85 == l__LocalPlayer__9 then
                                else
                                    u71[v84] = true;
                                    l__Networking__5.Pets.ScarePet:Fire(v85.UserId, v84);
                                end;
                            end;
                        end;
                    else
                        local v86 = l__Players__1:GetPlayerFromCharacter(v82);
                        if v86 and v86 ~= l__LocalPlayer__9 then
                            if u73[v86] then
                            else
                                local v87 = os.clock();
                                if u16[v86] and v87 - u16[v86] < 0.5 then
                                    u18(("touched %s but per-target cooldown active (%.2fs since last, need %.2fs) - not firing HitPlayer"):format(v86.Name, v87 - u16[v86], 0.5));
                                else
                                    u73[v86] = true;
                                    u16[v86] = v87;
                                    local l__Character__21 = l__LocalPlayer__9.Character;
                                    if l__Character__21 then
                                        l__Character__21 = l__LocalPlayer__9.Character:FindFirstChild("HumanoidRootPart");
                                    end;
                                    local v88 = v82:FindFirstChild("HumanoidRootPart");
                                    if l__Character__21 and v88 then
                                        local l__Magnitude__22 = (v88.Position - l__Character__21.Position).Magnitude;
                                        local v89 = v88.Position - l__Character__21.Position;
                                        local v90 = v89.Magnitude > 0.001 and v89.Unit:Dot(l__Character__21.CFrame.LookVector) or 1;
                                        u18(("touched %s -> firing HitPlayer (client dist %.1f, facing dot %.2f). Server requires dist <= 12 and dot >= 0.3"):format(v86.Name, l__Magnitude__22, v90));
                                    else
                                        u18("touched", v86.Name, "-> firing HitPlayer");
                                    end;
                                    l__Networking__5.Shovel.HitPlayer:Fire(v86.UserId);
                                end;
                            end;
                        end;
                    end;
                end;
            end);
            table.insert(u72, v91);
        end;
        task.delay(0.4, function() --[[ Line: 503 ]]
            -- upvalues: u72 (copy), u73 (copy), u18 (ref)
            for _, v92 in u72 do
                v92:Disconnect();
            end;
            if next(u73) == nil then
                u18(("swing window closed after %.2fs: shovel never touched another player\'s character (check reach, CanTouch, collision groups, swing animation timing vs window)"):format(0.4));
            end;
        end);
    else
        u18("ActivateHitDetection aborted: no equipped tool");
    end;
end;
function v1.ProcessShovelAction(u93) --[[ Line: 513 ]]
    -- upvalues: u18 (copy), u21 (ref), u10 (ref), u29 (copy), u20 (ref), l__Networking__5 (copy), u4 (ref), u3 (ref), u5 (ref), l__MessagePrompt__7 (copy), u2 (copy)
    local u94 = u93:GetEquippedTool();
    if u94 then
        local u95 = u94:GetAttribute("Shovel");
        if u95 then
            local v96 = u21;
            if v96 then
                v96 = u21.plantId ~= nil and true or (u21.isFruit or u21.isGnome);
            end;
            local v97 = os.clock();
            local v98 = v97 - u10;
            if not v96 then
                if v98 < 0.65 then
                    return;
                end;
                u10 = v97;
            end;
            u29();
            if u20 and u21 then
                if u21.isPlayer and u21.player then
                    u93:ActivateHitDetection();
                    u93:ClearHighlight();
                elseif u21.isGnome and u21.gnomePart then
                    l__Networking__5.Place.RemoveGnome:Fire(u21.gnomePart);
                    u93:ClearHighlight();
                else
                    local l__plantId__23 = u21.plantId;
                    local u99 = u21.fruitId or "";
                    if u4 and true or (u3 and u3.Data.HasShoveledPlant == true and true or false) then
                        l__Networking__5.Shovel.UseShovel:Fire(l__plantId__23, u99, u95, u94);
                        u93:ActivateHitDetection();
                        if u20 then
                            u20:Destroy();
                            u93:ClearHighlight();
                        end;
                    elseif u5 then
                    else
                        u5 = true;
                        local u100 = u20;
                        task.spawn(function() --[[ Line: 568 ]]
                            -- upvalues: l__MessagePrompt__7 (ref), u2 (ref), u5 (ref), u4 (ref), l__Networking__5 (ref), l__plantId__23 (copy), u99 (copy), u95 (copy), u94 (copy), u100 (copy), u93 (copy)
                            local v101 = l__MessagePrompt__7.Prompt({
                                message = "The Shovel will <b>permanently remove</b> this from your garden. You won\'t get it back.",
                                titleOverride = "Dig This Up?",
                                yield = true,
                                hideClose = true,
                                options = u2
                            });
                            u5 = false;
                            if v101 then
                                u4 = true;
                                l__Networking__5.Shovel.UseShovel:Fire(l__plantId__23, u99, u95, u94);
                                if u100 then
                                    u100:Destroy();
                                end;
                                u93:ClearHighlight();
                            end;
                        end);
                    end;
                end;
            else
                u93:ActivateHitDetection();
            end;
        else
            u18("ProcessShovelAction aborted: equipped tool", u94.Name, "has no \'Shovel\' attribute");
        end;
    else
        u18("ProcessShovelAction aborted: no equipped tool");
    end;
end;
function v1.OnInput(p102, p103, p104) --[[ Line: 598 ]]
    -- upvalues: u10 (ref)
    if p104 then
    elseif p103.UserInputType == Enum.UserInputType.MouseButton1 and true or p103.KeyCode == Enum.KeyCode.ButtonR2 then
        if os.clock() - u10 < 0.65 then
        else
            p102:ProcessShovelAction();
        end;
    end;
end;
function v1.SetupCharacter(u105, p106) --[[ Line: 612 ]]
    -- upvalues: u23 (ref)
    p106.ChildAdded:Connect(function(p107) --[[ Line: 613 ]]
        -- upvalues: u23 (ref), u105 (copy)
        if p107:IsA("Tool") and p107:GetAttribute("Shovel") then
            u23 = p107;
            u105:StartHoverDetection();
        end;
    end);
    p106.ChildRemoved:Connect(function(p108) --[[ Line: 620 ]]
        -- upvalues: u23 (ref), u105 (copy)
        if p108:IsA("Tool") and (p108:GetAttribute("Shovel") and u23 == p108) then
            u23 = nil;
            u105:StopHoverDetection();
        end;
    end);
    for _, v109 in p106:GetChildren() do
        if v109:IsA("Tool") and v109:GetAttribute("Shovel") then
            u23 = v109;
            u105:StartHoverDetection();
        end;
    end;
end;
function v1.GetPlayerPlantsFolder(_) --[[ Line: 637 ]]
    -- upvalues: u24 (ref), l__LocalPlayer__9 (copy), l__Gardens__11 (copy)
    if u24 then
        return u24;
    end;
    local v110 = l__LocalPlayer__9:GetAttribute("PlotId");
    if not v110 then
        return nil;
    end;
    local v111 = l__Gardens__11:FindFirstChild("Plot" .. tostring(v110));
    if not v111 then
        return nil;
    end;
    u24 = v111:FindFirstChild("Plants");
    return u24;
end;
function v1.IsPlayerInMyGarden(_, p112) --[[ Line: 647 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__GardenZoneData__12 (copy)
    if p112 == l__LocalPlayer__9 then
        return false;
    else
        local v113 = l__LocalPlayer__9:GetAttribute("PlotId");
        if v113 then
            local v114 = l__GardenZoneData__12:FindFirstChild(p112.Name);
            if v114 then
                return v114.Value == v113;
            else
                return false;
            end;
        else
            return false;
        end;
    end;
end;
function v1.IsPlayerStealingFromMe(_, p115) --[[ Line: 656 ]]
    -- upvalues: l__LocalPlayer__9 (copy)
    return p115 ~= l__LocalPlayer__9;
end;
function v1.GetPlayerFromCharacter(_, p116) --[[ Line: 661 ]]
    -- upvalues: l__Players__1 (copy)
    return l__Players__1:GetPlayerFromCharacter(p116);
end;
function v1.GetNearbyPlayerInGarden(p117) --[[ Line: 665 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__Players__1 (copy)
    local l__Character__24 = l__LocalPlayer__9.Character;
    if l__Character__24 then
        local v118 = l__Character__24:FindFirstChild("HumanoidRootPart");
        if v118 then
            local l__Position__25 = v118.Position;
            local v119 = 7;
            local v120 = nil;
            local v121 = nil;
            for _, v122 in l__Players__1:GetPlayers() do
                if v122 ~= l__LocalPlayer__9 and (p117:IsPlayerInMyGarden(v122) or p117:IsPlayerStealingFromMe(v122)) then
                    local l__Character__26 = v122.Character;
                    if l__Character__26 then
                        local v123 = l__Character__26:FindFirstChild("HumanoidRootPart");
                        if v123 then
                            local l__Magnitude__27 = (v123.Position - l__Position__25).Magnitude;
                            if l__Magnitude__27 < v119 then
                                v121 = l__Character__26;
                                v120 = v122;
                                v119 = l__Magnitude__27;
                            end;
                        end;
                    end;
                end;
            end;
            if v120 and v121 then
                return v121, {
                    plantId = nil,
                    fruitId = nil,
                    isFruit = false,
                    isPlayer = true,
                    isGnome = false,
                    gnomePart = nil,
                    player = v120
                };
            else
                return nil, nil;
            end;
        else
            return nil, nil;
        end;
    else
        return nil, nil;
    end;
end;
function v1.GetGnomePartFromVisual(_, p124) --[[ Line: 695 ]]
    -- upvalues: l__Gnomes__13 (copy)
    return l__Gnomes__13:FindFirstChild((string.gsub(p124.Name, "^GnomeVisual_", "")));
end;
function v1.GetHighlightTarget(p125, p126) --[[ Line: 700 ]]
    -- upvalues: u6 (ref), l__LocalPlayer__9 (copy)
    if not p126 then
        return nil, nil;
    end;
    local v127 = p126;
    while p126 and p126 ~= workspace do
        local l__Parent__28 = p126.Parent;
        if not u6 then
            u6 = workspace:FindFirstChild("GnomeVisuals");
        end;
        if l__Parent__28 == u6 and p126:IsA("Model") then
            local v128 = p125:GetGnomePartFromVisual(p126);
            if v128 and v128:GetAttribute("Owner") == l__LocalPlayer__9.Name then
                return p126, {
                    plantId = nil,
                    fruitId = nil,
                    isFruit = false,
                    isPlayer = false,
                    player = nil,
                    isGnome = true,
                    gnomePart = v128
                };
            else
                return nil, nil;
            end;
        end;
        p126 = p126.Parent;
    end;
    local v129 = p125:GetPlayerPlantsFolder();
    if not v129 then
        return nil, nil;
    end;
    while v127 and v127 ~= workspace do
        local l__Parent__29 = v127.Parent;
        if l__Parent__29 and l__Parent__29.Name == "Fruits" then
            local l__Parent__30 = l__Parent__29.Parent;
            if l__Parent__30 and l__Parent__30.Parent == v129 then
                return v127, {
                    isFruit = true,
                    isPlayer = false,
                    player = nil,
                    isGnome = false,
                    gnomePart = nil,
                    plantId = l__Parent__30.Name,
                    fruitId = v127.Name
                };
            end;
        end;
        if l__Parent__29 == v129 then
            return v127, {
                fruitId = nil,
                isFruit = false,
                isPlayer = false,
                player = nil,
                isGnome = false,
                gnomePart = nil,
                plantId = v127.Name
            };
        end;
        v127 = l__Parent__29;
    end;
    return nil, nil;
end;
function v1.ClearHighlight(_) --[[ Line: 736 ]]
    -- upvalues: u19 (ref), u20 (ref), u21 (ref)
    if u19 then
        u19:Destroy();
        u19 = nil;
    end;
    u20 = nil;
    u21 = nil;
end;
function v1.CreateRaycastParams(_) --[[ Line: 742 ]]
    -- upvalues: l__LocalPlayer__9 (copy)
    local v130 = RaycastParams.new();
    v130.FilterType = Enum.RaycastFilterType.Exclude;
    local l__Character__31 = l__LocalPlayer__9.Character;
    if l__Character__31 then
        v130.FilterDescendantsInstances = { l__Character__31 };
    end;
    return v130;
end;
function v1.IsPartVisible(_, p131) --[[ Line: 750 ]]
    return p131.Transparency < 1;
end;
function v1.RaycastIgnoreInvisible(p132, p133, p134, p135) --[[ Line: 754 ]]
    -- upvalues: u6 (ref), l__LocalPlayer__9 (copy)
    local v136 = p134;
    local v137 = {};
    for _ = 1, 10 do
        local v138 = workspace:Raycast(p133, p134, p135);
        if not v138 then
            return nil;
        end;
        if p132:IsPartVisible(v138.Instance) then
            return v138;
        end;
        if not u6 then
            u6 = workspace:FindFirstChild("GnomeVisuals");
        end;
        if u6 then
            local l__Instance__32 = v138.Instance;
            if not u6 then
                u6 = workspace:FindFirstChild("GnomeVisuals");
            end;
            if l__Instance__32:IsDescendantOf(u6) then
                return v138;
            end;
        end;
        table.insert(v137, v138.Instance);
        p135.FilterDescendantsInstances = { l__LocalPlayer__9.Character, unpack(v137) };
        local l__Magnitude__33 = (v138.Position - p133).Magnitude;
        local l__Magnitude__34 = p134.Magnitude;
        p133 = v138.Position + v136.Unit * 0.01;
        p134 = v136.Unit * (l__Magnitude__34 - l__Magnitude__33);
        if p134.Magnitude < 0.1 then
            return nil;
        end;
    end;
    return nil;
end;
function v1.IsUsingGamepad(_) --[[ Line: 774 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v139 = l__UserInputService__2:GetLastInputType();
    return (v139 == Enum.UserInputType.Gamepad1 or (v139 == Enum.UserInputType.Gamepad2 or v139 == Enum.UserInputType.Gamepad3)) and true or v139 == Enum.UserInputType.Gamepad4;
end;
function v1.GetGamepadPlacementRay(_) --[[ Line: 779 ]]
    -- upvalues: l__LocalPlayer__9 (copy)
    local l__Character__35 = l__LocalPlayer__9.Character;
    if l__Character__35 then
        local v140 = l__Character__35:FindFirstChild("HumanoidRootPart");
        if v140 then
            return v140.Position + v140.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0);
        else
            return nil, nil;
        end;
    else
        return nil, nil;
    end;
end;
function v1.GetTargetFromRaycast(p141) --[[ Line: 791 ]]
    -- upvalues: l__UserInputService__2 (copy), l__CurrentCamera__10 (copy)
    debug.profilebegin("Controllers/ShovelController/GetTargetFromRaycast");
    local v142 = p141:CreateRaycastParams();
    local v143;
    if p141:IsUsingGamepad() then
        local v144, v145 = p141:GetGamepadPlacementRay();
        if not v144 then
            debug.profileend();
            return nil;
        end;
        v143 = p141:RaycastIgnoreInvisible(v144, v145, v142);
    else
        local v146 = l__UserInputService__2:GetMouseLocation();
        local v147 = l__CurrentCamera__10:ViewportPointToRay(v146.X, v146.Y);
        v143 = p141:RaycastIgnoreInvisible(v147.Origin, v147.Direction * 5000, v142);
    end;
    local v148 = v143 and v143.Instance or nil;
    debug.profileend();
    return v148;
end;
function v1.UpdateHighlightBlink(p149) --[[ Line: 812 ]]
    -- upvalues: u19 (ref), u8 (ref)
    if u19 then
        local v150 = u8 and p149:ShouldHoldToDelete() and 5.2 or 1.8;
        local v151 = os.clock() * v150 * 3.141592653589793 * 2;
        local v152 = (math.sin(v151) + 1) * 0.5;
        u19.FillTransparency = v152 * 0.4 + 0.35;
        u19.OutlineTransparency = v152 * 0.7 + 0.2;
    end;
end;
function v1.UpdateHighlight(p153) --[[ Line: 823 ]]
    -- upvalues: u20 (ref), u19 (ref), u21 (ref)
    debug.profilebegin("Controllers/ShovelController/UpdateHighlight");
    local v154, v155 = p153:GetHighlightTarget((p153:GetTargetFromRaycast()));
    if v154 == u20 then
        p153:UpdateHighlightBlink();
        debug.profileend();
    else
        p153:ClearHighlight();
        if v154 then
            local v156 = Instance.new("Highlight");
            if v155 and v155.isPlayer then
                v156.FillColor = Color3.fromRGB(255, 165, 0);
            elseif v155 and v155.isGnome then
                v156.FillColor = Color3.fromRGB(255, 100, 100);
            else
                v156.FillColor = Color3.fromRGB(255, 0, 0);
            end;
            v156.OutlineColor = Color3.fromRGB(255, 0, 0);
            v156.FillTransparency = 0.35;
            v156.OutlineTransparency = 0.9;
            v156.Parent = v154;
            v156.Adornee = v154;
            u19 = v156;
            u20 = v154;
            u21 = v155;
            p153:UpdateHighlightBlink();
        end;
        debug.profileend();
    end;
end;
function v1.StartHoverDetection(u157) --[[ Line: 848 ]]
    -- upvalues: u22 (ref), l__RunService__4 (copy)
    if u22 then
    else
        u22 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 850 ]]
            -- upvalues: u157 (copy)
            debug.profilebegin("Controllers/ShovelController/RenderStepped");
            u157:UpdateHighlight();
            debug.profileend();
        end);
    end;
end;
function v1.StopHoverDetection(p158) --[[ Line: 857 ]]
    -- upvalues: u22 (ref)
    if u22 then
        u22:Disconnect();
        u22 = nil;
    end;
    p158:HideHoldProgress();
    p158:ClearHighlight();
end;
function v1.GetEquippedTool(_) --[[ Line: 863 ]]
    -- upvalues: l__LocalPlayer__9 (copy)
    local l__Character__36 = l__LocalPlayer__9.Character;
    if l__Character__36 then
        return l__Character__36:FindFirstChildWhichIsA("Tool");
    else
        return nil;
    end;
end;
return v1;