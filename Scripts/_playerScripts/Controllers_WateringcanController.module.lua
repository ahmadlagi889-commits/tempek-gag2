-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__RunService__5 = game:GetService("RunService");
local l__TweenService__6 = game:GetService("TweenService");
local l__Debris__7 = game:GetService("Debris");
local l__WateringcanData__8 = require(l__ReplicatedStorage__4.SharedModules.WateringcanData);
local l__Networking__9 = require(l__ReplicatedStorage__4.SharedModules.Networking);
local l__LocalPlayer__10 = l__Players__1.LocalPlayer;
local l__CurrentCamera__11 = workspace.CurrentCamera;
local l__Water__12 = game.SoundService.SFX.Water;
local l__Temporary__13 = workspace.Temporary;
local l__Baseplate__14 = workspace:WaitForChild("Baseplate");
local u2 = Color3.fromRGB(100, 175, 255);
local u3 = Color3.fromRGB(255, 100, 100);
local u4 = 0;
local u5 = nil;
local u6 = false;
local u7 = nil;
local u8 = Color3.fromRGB(100, 175, 255);
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = {};
local function u14(...) --[[ Line: 71 ]] end;
local function u15(...) --[[ Line: 77 ]] end;
function v1.Init(_) --[[ Line: 87 ]]
    -- upvalues: l__WateringcanData__8 (copy), u13 (copy), u14 (copy)
    for _, v16 in l__WateringcanData__8 do
        u13[v16.Name] = v16;
    end;
    u14("Init complete. Loaded", #l__WateringcanData__8, "watering can definitions");
end;
function v1.Start(u17) --[[ Line: 94 ]]
    -- upvalues: u14 (copy), l__UserInputService__2 (copy), l__LocalPlayer__10 (copy), l__Networking__9 (copy)
    u14("Start. TouchEnabled =", l__UserInputService__2.TouchEnabled, "| MouseEnabled =", l__UserInputService__2.MouseEnabled);
    l__UserInputService__2.InputBegan:Connect(function(p18, p19) --[[ Line: 98 ]]
        -- upvalues: u17 (copy)
        u17:OnInputBegan(p18, p19);
    end);
    l__UserInputService__2.InputEnded:Connect(function(p20, _) --[[ Line: 102 ]]
        -- upvalues: u17 (copy)
        u17:OnInputEnded(p20);
    end);
    l__UserInputService__2.TouchTapInWorld:Connect(function(p21, p22) --[[ Line: 109 ]]
        -- upvalues: u14 (ref), u17 (copy)
        if p22 then
            u14("TouchTapInWorld ignored (processed by UI)");
        else
            local v23 = u17:GetEquippedTool();
            if v23 and v23:GetAttribute("WateringCan") then
                u14(("TouchTapInWorld at screen (%.0f, %.0f)"):format(p21.X, p21.Y));
                u17:TryWater(p21);
            else
                u14("TouchTapInWorld ignored (no watering can equipped)");
            end;
        end;
    end);
    local l__Character__15 = l__LocalPlayer__10.Character;
    if l__Character__15 then
        u17:SetupCharacter(l__Character__15);
    end;
    l__LocalPlayer__10.CharacterAdded:Connect(function(p24) --[[ Line: 129 ]]
        -- upvalues: u17 (copy)
        u17:SetupCharacter(p24);
    end);
    l__Networking__9.WateringCan.WateringCanFx.OnClientEvent:Connect(function(p25, p26, p27) --[[ Line: 133 ]]
        -- upvalues: u14 (ref), u17 (copy)
        u14("FX event received:", p26, "at", p25, "from", p27 and (p27.Name or "nil") or "nil");
        u17:PlayWateringEffect(p25, p26);
        u17:PlayWaterStream(p27, p25, p26);
    end);
end;
function v1.PlayWateringEffect(_, p28, p29) --[[ Line: 144 ]]
    -- upvalues: u13 (copy), u15 (copy), u8 (copy), l__RunService__5 (copy), l__Temporary__13 (copy), l__Water__12 (copy), l__TweenService__6 (copy), l__Debris__7 (copy), u14 (copy)
    local v30 = u13[p29];
    local v31 = v30 and (v30.SplashRadius or 8) or 8;
    local u32 = v30 and (v30.EffectTime or 10) or 10;
    if not v30 then
        u15("PlayWateringEffect: unknown can name \'" .. tostring(p29) .. "\', using defaults");
    end;
    local v33 = Vector3.new(0.15, v31, v31);
    local v34 = Vector3.new(0.15, v31 * 2, v31 * 2);
    local u35 = game.ReplicatedStorage.Assets.Stud_Part:Clone();
    u35.BackSurface = Enum.SurfaceType.Studs;
    u35.TopSurface = Enum.SurfaceType.Studs;
    u35.LeftSurface = Enum.SurfaceType.Studs;
    u35.RightSurface = Enum.SurfaceType.Studs;
    u35.FrontSurface = Enum.SurfaceType.Studs;
    u35.BottomSurface = Enum.SurfaceType.Studs;
    u35.Material = Enum.Material.Glacier;
    u35.MaterialVariant = "2022 Weld";
    u35.Name = "WateringCanFx";
    u35.Shape = Enum.PartType.Cylinder;
    u35.Size = v33;
    u35.CFrame = CFrame.new(p28 + Vector3.new(0, 0.075, 0)) * CFrame.Angles(0, 0, 1.5707963267948966);
    u35.Transparency = 1;
    u35.Color = u8;
    local u36;
    if p29 == "Super Watering Can" then
        u36 = l__RunService__5.RenderStepped:Connect(function() --[[ Line: 178 ]]
            -- upvalues: u35 (copy)
            if u35 and u35.Parent then
                u35.Color = Color3.fromHSV(os.clock() * 0.5 % 1, 1, 1);
            end;
        end);
    else
        u36 = nil;
    end;
    u35.CanCollide = false;
    u35.CanQuery = false;
    u35.CanTouch = false;
    u35.Anchored = true;
    u35.CastShadow = false;
    u35.Parent = l__Temporary__13;
    local u37 = l__Water__12:Clone();
    u37.Name = "WateringCanSFX";
    u37.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    u37.RollOffMode = Enum.RollOffMode.InverseTapered;
    u37.RollOffMinDistance = 10;
    u37.RollOffMaxDistance = 80;
    u37.Parent = u35;
    u37:Play();
    u37.Ended:Once(function() --[[ Line: 200 ]]
        -- upvalues: u37 (copy)
        u37:Destroy();
    end);
    local v38 = l__TweenService__6:Create(u35, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 0.5,
        Size = v34
    });
    local v39 = Vector3.new(0.15, v31 * 2 * 0.6, v31 * 2 * 0.6);
    local u40 = l__TweenService__6:Create(u35, TweenInfo.new(u32, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Transparency = 0.8,
        Size = v39
    });
    local u41 = l__TweenService__6:Create(u35, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1
    });
    v38:Play();
    l__Debris__7:AddItem(v38, 1.3);
    task.delay(0.3, function() --[[ Line: 228 ]]
        -- upvalues: u35 (copy), u40 (copy), l__Debris__7 (ref), u32 (copy)
        if u35 and u35.Parent then
            u40:Play();
            l__Debris__7:AddItem(u40, u32 + 1);
        end;
    end);
    task.delay(0.3 + u32, function() --[[ Line: 235 ]]
        -- upvalues: u35 (copy), u41 (copy), l__Debris__7 (ref)
        if u35 and u35.Parent then
            u41:Play();
            l__Debris__7:AddItem(u41, 1.2);
        end;
    end);
    task.delay(0.3 + u32 + 0.2, function() --[[ Line: 242 ]]
        -- upvalues: u36 (ref), u35 (copy), u14 (ref)
        if u36 then
            u36:Disconnect();
            u36 = nil;
        end;
        if u35 and u35.Parent then
            u35:Destroy();
        end;
        u14("Puddle FX cleaned up");
    end);
end;
Color3.fromRGB(100, 175, 255);
function v1.PlayWaterStream(_, p42, u43, u44) --[[ Line: 261 ]]
    -- upvalues: u15 (copy), u13 (copy), l__Temporary__13 (copy), l__RunService__5 (copy), l__TweenService__6 (copy), l__Debris__7 (copy)
    if p42 then
        local l__Character__16 = p42.Character;
        if l__Character__16 then
            local v45 = u13[u44];
            local u46 = v45 and v45.SplashRadius or 8;
            local v47 = l__Character__16:FindFirstChild("Right Arm") or l__Character__16:FindFirstChild("RightHand");
            local u48;
            if v47 and v47:IsA("BasePart") then
                u48 = (v47.CFrame * CFrame.new(0, -v47.Size.Y / 2 - 2, 0.65)).Position;
            else
                local v49 = l__Character__16:FindFirstChild("HumanoidRootPart");
                if not (v49 and v49:IsA("BasePart")) then
                    u15("PlayWaterStream: no arm or HumanoidRootPart found");
                    return;
                end;
                u48 = v49.Position + Vector3.new(0, 1, 0);
            end;
            task.spawn(function() --[[ Line: 288 ]]
                -- upvalues: u44 (copy), u46 (copy), u43 (copy), l__Temporary__13 (ref), l__RunService__5 (ref), u48 (ref), l__TweenService__6 (ref), l__Debris__7 (ref)
                local u50 = u44 == "Super Watering Can";
                local u51 = {};
                local u52 = {};
                local u53 = {};
                for _ = 1, 12 do
                    local v54 = math.random() * 3.141592653589793 * 2;
                    local v55 = math.random() * u46;
                    local v56 = u43;
                    local v57 = math.cos(v54) * v55;
                    local v58 = math.sin(v54) * v55;
                    local v59 = v56 + Vector3.new(v57, -3, v58);
                    local l__Angles__17 = CFrame.Angles;
                    local v60 = math.random(0, 360);
                    local v61 = math.rad(v60);
                    local v62 = math.random(0, 360);
                    local v63 = math.rad(v62);
                    local v64 = math.random(0, 360);
                    local v65 = l__Angles__17(v61, v63, (math.rad(v64)));
                    local v66 = game.ReplicatedStorage.Assets.Stud_Part:Clone();
                    v66.BackSurface = Enum.SurfaceType.Studs;
                    v66.TopSurface = Enum.SurfaceType.Studs;
                    v66.LeftSurface = Enum.SurfaceType.Studs;
                    v66.RightSurface = Enum.SurfaceType.Studs;
                    v66.FrontSurface = Enum.SurfaceType.Studs;
                    v66.BottomSurface = Enum.SurfaceType.Studs;
                    v66.Material = Enum.Material.Glacier;
                    v66.MaterialVariant = "2022 Weld";
                    v66.Color = u50 and Color3.fromHSV(v66.Position.Y % 6 / 6, 1, 1) or Color3.new(0, 0.666667, 1);
                    v66.Size = Vector3.new(1, 1, 1);
                    v66.Transparency = 0.3;
                    v66.Anchored = true;
                    v66.CanCollide = false;
                    v66.CanQuery = false;
                    v66.CanTouch = false;
                    v66.CastShadow = false;
                    v66.Parent = l__Temporary__13;
                    table.insert(u51, v66);
                    table.insert(u52, v59);
                    table.insert(u53, v65);
                end;
                local u67 = 0;
                local u68 = nil;
                u68 = l__RunService__5.RenderStepped:Connect(function(p69) --[[ Line: 340 ]]
                    -- upvalues: u67 (ref), u51 (copy), u52 (copy), u48 (ref), u53 (copy), u50 (copy), u68 (ref), l__TweenService__6 (ref), l__Debris__7 (ref)
                    u67 = u67 + p69;
                    local v70 = true;
                    for v71, v72 in u51 do
                        local v73 = u52[v71];
                        local v74 = (u48 + v73) / 2 + Vector3.new(0, 8, 0);
                        local v75 = math.clamp(u67 / 0.4 - (v71 - 1) / 12 * 0.6, 0, 1);
                        if v75 < 1 then
                            v70 = false;
                        end;
                        v72.CFrame = CFrame.new((1 - v75) * (1 - v75) * u48 + (1 - v75) * 2 * v75 * v74 + v75 * v75 * v73) * u53[v71];
                        v72.Transparency = v75 * 0.4 + 0.3;
                        if u50 then
                            v72.Color = Color3.fromHSV(v72.Position.Y % 6 / 6, 1, 1);
                        end;
                        v72.Size = Vector3.new(1, 1, 1) * (1 - v75 * 0.5);
                    end;
                    if v70 then
                        u68:Disconnect();
                        local v76 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                        for _, v77 in u51 do
                            local v78 = l__TweenService__6:Create(v77, v76, {
                                Transparency = 1,
                                Size = Vector3.new(0.1, 0.1, 0.1)
                            });
                            v78:Play();
                            l__Debris__7:AddItem(v78, v76.Time);
                        end;
                        task.delay(0.35, function() --[[ Line: 381 ]]
                            -- upvalues: u51 (ref)
                            for _, v79 in u51 do
                                v79:Destroy();
                            end;
                        end);
                    end;
                end);
            end);
        else
            u15("PlayWaterStream: no character for", p42.Name);
        end;
    end;
end;
function v1.SetupCharacter(u80, p81) --[[ Line: 393 ]]
    -- upvalues: u14 (copy)
    u14("SetupCharacter for", p81.Name);
    p81.ChildAdded:Connect(function(p82) --[[ Line: 396 ]]
        -- upvalues: u14 (ref), u80 (copy)
        if p82:IsA("Tool") and p82:GetAttribute("WateringCan") then
            u14("Watering can equipped:", p82:GetAttribute("WateringCan"));
            u80:CreatePreview(p82:GetAttribute("WateringCan"));
        end;
    end);
    p81.ChildRemoved:Connect(function(p83) --[[ Line: 403 ]]
        -- upvalues: u14 (ref), u80 (copy)
        if p83:IsA("Tool") and p83:GetAttribute("WateringCan") then
            u14("Watering can unequipped:", p83:GetAttribute("WateringCan"));
            u80:DestroyPreview();
            u80:StopHold();
        end;
    end);
    for _, v84 in p81:GetChildren() do
        if v84:IsA("Tool") and v84:GetAttribute("WateringCan") then
            u80:CreatePreview(v84:GetAttribute("WateringCan"));
        end;
    end;
end;
function v1.IsTouchInput(_) --[[ Line: 418 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local l__TouchEnabled__18 = l__UserInputService__2.TouchEnabled;
    if l__TouchEnabled__18 then
        l__TouchEnabled__18 = not l__UserInputService__2.MouseEnabled;
    end;
    return l__TouchEnabled__18;
end;
function v1.GetFacingTargetPosition(p85) --[[ Line: 422 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__CurrentCamera__11 (copy), l__UserInputService__2 (copy)
    local l__Character__19 = l__LocalPlayer__10.Character;
    if l__Character__19 then
        local v86 = l__Character__19:FindFirstChild("HumanoidRootPart");
        if v86 and v86:IsA("BasePart") then
            if p85:IsUsingGamepad() then
                local l__LookVector__20 = l__CurrentCamera__11.CFrame.LookVector;
                local v87 = Vector3.new(l__LookVector__20.X, 0, l__LookVector__20.Z);
                if v87.Magnitude < 0.001 then
                    return nil;
                else
                    return v86.Position + v87.Unit * 10;
                end;
            elseif p85:IsTouchInput() then
                return nil;
            else
                local v88 = l__UserInputService__2:GetMouseLocation();
                local v89 = l__CurrentCamera__11:ViewportPointToRay(v88.X, v88.Y);
                local l__Origin__21 = v89.Origin;
                local l__Direction__22 = v89.Direction;
                if math.abs(l__Direction__22.Y) < 0.001 then
                    return nil;
                else
                    local v90 = (v86.Position.Y - l__Origin__21.Y) / l__Direction__22.Y;
                    if v90 < 0 then
                        return nil;
                    else
                        return l__Origin__21 + l__Direction__22 * v90;
                    end;
                end;
            end;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.UpdateFacing(p91) --[[ Line: 450 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local l__Character__23 = l__LocalPlayer__10.Character;
    if l__Character__23 then
        local v92 = l__Character__23:FindFirstChild("HumanoidRootPart");
        local v93 = l__Character__23:FindFirstChildOfClass("Humanoid");
        if v92 and (v92:IsA("BasePart") and v93) then
            if v93.Health <= 0 then
            elseif v93.Sit then
            else
                local v94 = p91:GetFacingTargetPosition();
                if v94 then
                    local v95 = Vector3.new(v94.X, v92.Position.Y, v94.Z);
                    if (v95 - v92.Position).Magnitude < 0.1 then
                        v93.AutoRotate = true;
                    else
                        v93.AutoRotate = false;
                        v92.CFrame = CFrame.lookAt(v92.Position, v95);
                    end;
                else
                    v93.AutoRotate = true;
                end;
            end;
        end;
    end;
end;
function v1.EnableCharacterFacing(u96) --[[ Line: 477 ]]
    -- upvalues: u12 (ref), l__RunService__5 (copy)
    u96:DisableCharacterFacing();
    u12 = l__RunService__5.RenderStepped:Connect(function() --[[ Line: 480 ]]
        -- upvalues: u96 (copy)
        u96:UpdateFacing();
    end);
end;
function v1.DisableCharacterFacing(_) --[[ Line: 485 ]]
    -- upvalues: u12 (ref), l__LocalPlayer__10 (copy)
    if u12 then
        u12:Disconnect();
        u12 = nil;
    end;
    local l__Character__24 = l__LocalPlayer__10.Character;
    local v97 = l__Character__24 and l__Character__24:FindFirstChildOfClass("Humanoid");
    if v97 then
        v97.AutoRotate = true;
    end;
end;
function v1.CreatePreview(u98, p99) --[[ Line: 500 ]]
    -- upvalues: u14 (copy), u11 (ref), u13 (copy), u15 (copy), u9 (ref), u2 (copy), l__Temporary__13 (copy), u10 (ref), l__RunService__5 (copy)
    u98:DestroyPreview();
    u14("CreatePreview for", p99);
    u11 = u13[p99];
    if not u11 then
        u15("CreatePreview: no data found for \'" .. tostring(p99) .. "\', using default radius");
    end;
    if u98:IsTouchInput() then
        u14("CreatePreview skipped (mobile) - no preview, no facing");
    else
        local v100 = u11 and u11.SplashRadius or 8;
        u9 = game.ReplicatedStorage.Assets.Stud_Part:Clone();
        u9.BackSurface = Enum.SurfaceType.Studs;
        u9.TopSurface = Enum.SurfaceType.Studs;
        u9.LeftSurface = Enum.SurfaceType.Studs;
        u9.RightSurface = Enum.SurfaceType.Studs;
        u9.FrontSurface = Enum.SurfaceType.Studs;
        u9.BottomSurface = Enum.SurfaceType.Studs;
        u9.Material = Enum.Material.Glacier;
        u9.MaterialVariant = "2022 Weld";
        u9.Name = "WateringCanPreview";
        u9.Shape = Enum.PartType.Cylinder;
        u9.Size = Vector3.new(0.15, v100 * 2, v100 * 2);
        u9.CFrame = CFrame.Angles(0, 0, 1.5707963267948966);
        u9.Transparency = 0.6;
        u9.Color = u2;
        u9.CanCollide = false;
        u9.CanQuery = false;
        u9.CanTouch = false;
        u9.Anchored = true;
        u9.CastShadow = false;
        u9.Parent = l__Temporary__13;
        u10 = l__RunService__5.RenderStepped:Connect(function() --[[ Line: 545 ]]
            -- upvalues: u98 (copy)
            u98:UpdatePreview();
        end);
        u98:EnableCharacterFacing();
    end;
end;
function v1.DestroyPreview(p101) --[[ Line: 552 ]]
    -- upvalues: u9 (ref), u14 (copy), u10 (ref), u11 (ref)
    if u9 then
        u14("DestroyPreview");
        u9:Destroy();
        u9 = nil;
    end;
    if u10 then
        u10:Disconnect();
        u10 = nil;
    end;
    u11 = nil;
    p101:DisableCharacterFacing();
end;
function v1.SetPreviewColor(_, p102) --[[ Line: 569 ]]
    -- upvalues: u9 (ref), u2 (copy), u3 (copy)
    if u9 then
        u9.Color = p102 and u2 or u3;
    end;
end;
function v1.IsUsingGamepad(_) --[[ Line: 578 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v103 = l__UserInputService__2:GetLastInputType();
    return (v103 == Enum.UserInputType.Gamepad1 or (v103 == Enum.UserInputType.Gamepad2 or v103 == Enum.UserInputType.Gamepad3)) and true or v103 == Enum.UserInputType.Gamepad4;
end;
function v1.GetGamepadPlacementRay(_) --[[ Line: 586 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local l__Character__25 = l__LocalPlayer__10.Character;
    if l__Character__25 then
        local v104 = l__Character__25:FindFirstChild("HumanoidRootPart");
        if v104 then
            return v104.Position + v104.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.CreateRaycastParams(_) --[[ Line: 601 ]]
    -- upvalues: l__CollectionService__3 (copy), l__Baseplate__14 (copy)
    local v105 = RaycastParams.new();
    v105.FilterType = Enum.RaycastFilterType.Include;
    local v106 = l__CollectionService__3:GetTagged("PlantArea");
    table.insert(v106, l__Baseplate__14);
    v105.FilterDescendantsInstances = v106;
    return v105;
end;
function v1.IsValidPlacement(_, p107) --[[ Line: 612 ]]
    -- upvalues: l__CollectionService__3 (copy)
    return l__CollectionService__3:HasTag(p107, "PlantArea");
end;
function v1.UpdatePreview(p108) --[[ Line: 616 ]]
    -- upvalues: u9 (ref), l__UserInputService__2 (copy), l__CurrentCamera__11 (copy), l__Temporary__13 (copy), u11 (ref)
    if u9 then
        local v109 = p108:CreateRaycastParams();
        local v110;
        if p108:IsUsingGamepad() then
            local v111, v112 = p108:GetGamepadPlacementRay();
            if not v111 then
                u9.Parent = nil;
                return;
            end;
            v110 = workspace:Raycast(v111, v112, v109);
        else
            local v113 = l__UserInputService__2:GetMouseLocation();
            local v114 = l__CurrentCamera__11:ViewportPointToRay(v113.X, v113.Y);
            v110 = workspace:Raycast(v114.Origin, v114.Direction * 5000, v109);
        end;
        if v110 then
            u9.Parent = l__Temporary__13;
            local l__Position__26 = v110.Position;
            local v115 = p108:IsValidPlacement(v110.Instance);
            u9.CFrame = CFrame.new(l__Position__26 + Vector3.new(0, -0.225, 0)) * CFrame.Angles(0, 0, 1.5707963267948966);
            if v115 and (u11 and u11.Name == "Super Watering Can") then
                u9.Color = Color3.fromHSV(os.clock() * 0.5 % 1, 1, 1);
            else
                p108:SetPreviewColor(v115);
            end;
        else
            u9.Parent = nil;
        end;
    end;
end;
function v1.GetEquippedTool(_) --[[ Line: 655 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local l__Character__27 = l__LocalPlayer__10.Character;
    if l__Character__27 then
        return l__Character__27:FindFirstChildWhichIsA("Tool");
    else
        return nil;
    end;
end;
function v1.IsValidWateringInput(_, p116) --[[ Line: 664 ]]
    return p116.UserInputType == Enum.UserInputType.MouseButton1 and true or p116.KeyCode == Enum.KeyCode.ButtonR2;
end;
function v1.TryWater(p117, p118) --[[ Line: 677 ]]
    -- upvalues: u4 (ref), u14 (copy), l__UserInputService__2 (copy), l__CurrentCamera__11 (copy), l__Networking__9 (copy)
    local v119 = os.clock();
    if v119 - u4 < 0.5 then
        u14(("TryWater blocked: cooldown (%.2fs remaining)"):format(0.5 - (v119 - u4)));
        return false;
    end;
    local v120 = p117:GetEquippedTool();
    if not v120 then
        u14("TryWater blocked: no tool equipped");
        return false;
    end;
    local v121 = v120:GetAttribute("WateringCan");
    if not v121 then
        u14("TryWater blocked: equipped tool is not a watering can");
        return false;
    end;
    local v122 = p117:CreateRaycastParams();
    local v123;
    if p117:IsUsingGamepad() then
        local v124, v125 = p117:GetGamepadPlacementRay();
        if not v124 then
            u14("TryWater blocked: gamepad ray unavailable (no character?)");
            return false;
        end;
        v123 = workspace:Raycast(v124, v125, v122);
    else
        local v126 = p118 or l__UserInputService__2:GetMouseLocation();
        local v127 = l__CurrentCamera__11:ViewportPointToRay(v126.X, v126.Y);
        v123 = workspace:Raycast(v127.Origin, v127.Direction * 5000, v122);
    end;
    if not v123 then
        u14("TryWater blocked: raycast hit nothing");
        return false;
    end;
    if not p117:IsValidPlacement(v123.Instance) then
        u14("TryWater blocked: hit", v123.Instance:GetFullName(), "(not tagged \'PlantArea\')");
        return false;
    end;
    u4 = v119;
    u14(("Watering with \'%s\' at (%.1f, %.1f, %.1f)"):format(v121, v123.Position.X, v123.Position.Y, v123.Position.Z));
    l__Networking__9.WateringCan.UseWateringCan:Fire(v123.Position - Vector3.new(0, 0.3, 0), v121, v120);
    return true;
end;
function v1.StopHold(_) --[[ Line: 733 ]]
    -- upvalues: u6 (ref), u14 (copy), u5 (ref), u7 (ref)
    if u6 then
        u14("Hold stopped");
    end;
    u6 = false;
    u5 = nil;
    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;
end;
function v1.OnInputBegan(u128, p129, p130) --[[ Line: 745 ]]
    -- upvalues: u14 (copy), u5 (ref), u6 (ref), u7 (ref), l__RunService__5 (copy)
    if p130 then
    elseif u128:IsValidWateringInput(p129) then
        u14("InputBegan:", p129.UserInputType.Name, p129.KeyCode == Enum.KeyCode.Unknown and "" or (p129.KeyCode.Name or ""));
        u128:TryWater();
        u5 = os.clock();
        u6 = true;
        if u7 then
            u7:Disconnect();
            u7 = nil;
        end;
        local u131 = u5;
        u7 = l__RunService__5.Heartbeat:Connect(function() --[[ Line: 766 ]]
            -- upvalues: u6 (ref), u5 (ref), u131 (copy), u128 (copy), u14 (ref)
            if u6 and u5 == u131 then
                local v132 = u128:GetEquippedTool();
                if v132 and v132:GetAttribute("WateringCan") then
                    if os.clock() - u5 < 1 then
                    else
                        u128:TryWater();
                    end;
                else
                    u14("Hold cancelled: tool unequipped mid-hold");
                    u128:StopHold();
                end;
            else
                u128:StopHold();
            end;
        end);
    end;
end;
function v1.OnInputEnded(p133, p134) --[[ Line: 788 ]]
    if p133:IsValidWateringInput(p134) then
        p133:StopHold();
    end;
end;
return v1;