-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__TweenService__5 = game:GetService("TweenService");
local l__Debris__6 = game:GetService("Debris");
local l__Networking__7 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__TeleporterData__8 = require(l__ReplicatedStorage__3.SharedModules.TeleporterData);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__Temporary__10 = workspace:WaitForChild("Temporary");
local u1 = {};
local u2 = 10;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = false;
local u7 = nil;
local u8 = {
    0.9,
    0.8,
    0.7,
    0.6,
    0.5
};
local u9 = 0;
local v10 = {
    StartOrder = 1
};
for _, v11 in l__TeleporterData__8.Data do
    u1[v11.Name] = v11.TeleportDistance;
end;
local function u17(p12, p13) --[[ Line: 83 ]]
    for _, v14 in p12:GetDescendants() do
        if v14:IsA("BasePart") then
            v14.Transparency = math.max(v14.Transparency, p13);
            v14.CanCollide = false;
            v14.CanQuery = false;
            v14.CanTouch = false;
            v14.Anchored = true;
        elseif v14:IsA("Decal") or v14:IsA("Texture") then
            v14.Transparency = math.max(v14.Transparency, p13);
        elseif v14:IsA("ParticleEmitter") or (v14:IsA("Trail") or v14:IsA("Beam")) then
            v14.Enabled = false;
        elseif v14:IsA("Fire") or (v14:IsA("Smoke") or v14:IsA("Sparkles")) then
            v14.Enabled = false;
        elseif v14:IsA("Light") then
            v14.Enabled = false;
        end;
    end;
    for _, v15 in p12:GetChildren() do
        if v15:IsA("Accessory") then
            local v16 = v15:FindFirstChild("Handle");
            if v16 and v16:IsA("BasePart") then
                v16.Transparency = math.max(v16.Transparency, p13);
                v16.Anchored = true;
                v16.CanCollide = false;
                v16.CanQuery = false;
                v16.CanTouch = false;
            end;
        end;
    end;
end;
local function u23(u18, p19) --[[ Line: 116 ]]
    -- upvalues: l__TweenService__5 (copy), l__Debris__6 (copy)
    local v20 = {};
    for _, v21 in u18:GetDescendants() do
        if v21:IsA("BasePart") then
            local v22 = l__TweenService__5:Create(v21, TweenInfo.new(p19, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            });
            v22:Play();
            table.insert(v20, v22);
        elseif v21:IsA("Decal") or v21:IsA("Texture") then
            l__TweenService__5:Create(v21, TweenInfo.new(p19, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end;
    end;
    if #v20 > 0 then
        v20[1].Completed:Once(function() --[[ Line: 135 ]]
            -- upvalues: u18 (copy)
            u18:Destroy();
        end);
    else
        l__Debris__6:AddItem(u18, p19);
    end;
    l__Debris__6:AddItem(u18, p19 + 1);
end;
local function u26() --[[ Line: 161 ]]
    -- upvalues: u7 (ref), u4 (ref), u5 (ref), u6 (ref), l__LocalPlayer__9 (copy), u17 (copy), l__Temporary__10 (copy)
    if u7 == nil then
    else
        if u4 then
            u4:Destroy();
            u4 = nil;
        end;
        if u5 then
            u5:Disconnect();
            u5 = nil;
        end;
        u6 = false;
        local l__Character__11 = l__LocalPlayer__9.Character;
        if l__Character__11 then
            if l__Character__11:FindFirstChildOfClass("Humanoid") then
                l__Character__11.Archivable = true;
                local v24 = u7:Clone();
                v24.Name = "TeleportPreview";
                l__Character__11.Archivable = false;
                if l__Character__11.PrimaryPart then
                    local v25 = v24:FindFirstChild(l__Character__11.PrimaryPart.Name);
                    if v25 and v25:IsA("BasePart") then
                        v24.PrimaryPart = v25;
                    end;
                end;
                u17(v24, 0.5);
                v24.Parent = l__Temporary__10;
                u4 = v24;
            end;
        end;
    end;
end;
local function u35(p27, p28) --[[ Line: 215 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u17 (copy), u8 (copy), l__Temporary__10 (copy), u23 (copy)
    local l__Character__12 = l__LocalPlayer__9.Character;
    if l__Character__12 then
        l__Character__12.Archivable = true;
        local v29 = l__Character__12:Clone();
        l__Character__12.Archivable = false;
        for _, v30 in v29:GetDescendants() do
            if v30:IsA("BasePart") then
                v30.CollisionGroup = "NoPlayers";
            end;
        end;
        for v31 = 1, 5 do
            local v32 = p27:Lerp(p28, v31 / 5);
            local u33 = v29:Clone();
            u33.Name = "TeleportTrail_" .. tostring(v31);
            if l__Character__12.PrimaryPart then
                local v34 = u33:FindFirstChild(l__Character__12.PrimaryPart.Name);
                if v34 and v34:IsA("BasePart") then
                    u33.PrimaryPart = v34;
                end;
            end;
            u17(u33, u8[v31]);
            u33.Parent = l__Temporary__10;
            if u33.PrimaryPart then
                u33:SetPrimaryPartCFrame(v32);
            end;
            task.delay((v31 - 1) * 0.03, function() --[[ Line: 256 ]]
                -- upvalues: u33 (copy), u23 (ref)
                if u33 and u33.Parent then
                    u23(u33, 0.6);
                end;
            end);
        end;
        v29:Destroy();
    end;
end;
local function u40() --[[ Line: 271 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u2 (ref), l__Networking__7 (copy), u35 (copy)
    local l__Character__13 = l__LocalPlayer__9.Character;
    if l__Character__13 then
        l__Character__13 = l__Character__13:FindFirstChild("Head");
    end;
    if l__Character__13 then
        local l__Character__14 = l__LocalPlayer__9.Character;
        if l__Character__14 then
            local v36 = l__Character__14:FindFirstChildOfClass("Humanoid");
            if v36 and v36.Health > 0 then
                local v37 = u2;
                local l__Character__15 = l__LocalPlayer__9.Character;
                if l__Character__15 then
                    l__Character__15 = l__Character__15:FindFirstChild("Head");
                end;
                local v38;
                if l__Character__15 then
                    local l__LookVector__16 = l__Character__15.CFrame.LookVector;
                    local v39 = Vector3.new(l__LookVector__16.X, 0, l__LookVector__16.Z);
                    if v39.Magnitude < 0.01 then
                        v38 = nil;
                    else
                        v38 = l__Character__15.CFrame + v39.Unit * v37;
                    end;
                else
                    v38 = nil;
                end;
                if v38 then
                    local l__CFrame__17 = l__Character__13.CFrame;
                    l__Character__13.CFrame = v38;
                    l__Networking__7.Place.UseTeleporter:Fire(v38.Position);
                    u35(l__CFrame__17, v38);
                end;
            end;
        end;
    end;
end;
local function u45(p41) --[[ Line: 299 ]]
    -- upvalues: u3 (ref), u2 (ref), u1 (copy), u26 (copy), u5 (ref), l__RunService__4 (copy), u4 (ref), l__LocalPlayer__9 (copy), u6 (ref), l__Temporary__10 (copy)
    if p41:GetAttribute("Teleporter") then
        u3 = p41;
        u2 = u1[p41:GetAttribute("Teleporter")] or 10;
        u26();
        u5 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 308 ]]
            -- upvalues: u4 (ref), u2 (ref), l__LocalPlayer__9 (ref), u6 (ref), l__Temporary__10 (ref)
            debug.profilebegin("Controllers/TeleporterController/PreviewUpdate");
            if u4 and u4.PrimaryPart then
                local v42 = u2;
                local l__Character__18 = l__LocalPlayer__9.Character;
                if l__Character__18 then
                    l__Character__18 = l__Character__18:FindFirstChild("Head");
                end;
                local v43;
                if l__Character__18 then
                    local l__LookVector__19 = l__Character__18.CFrame.LookVector;
                    local v44 = Vector3.new(l__LookVector__19.X, 0, l__LookVector__19.Z);
                    if v44.Magnitude < 0.01 then
                        v43 = nil;
                    else
                        v43 = l__Character__18.CFrame + v44.Unit * v42;
                    end;
                else
                    v43 = nil;
                end;
                if v43 then
                    if not u6 then
                        u4.Parent = l__Temporary__10;
                        u6 = true;
                    end;
                    u4:SetPrimaryPartCFrame(v43);
                elseif u6 then
                    u4.Parent = nil;
                    u6 = false;
                end;
            end;
            debug.profileend();
        end);
    end;
end;
local function u50() --[[ Line: 325 ]]
    -- upvalues: u3 (ref), u9 (ref), u40 (copy), u26 (copy), u5 (ref), l__RunService__4 (copy), u4 (ref), u2 (ref), l__LocalPlayer__9 (copy), u6 (ref), l__Temporary__10 (copy)
    if u3 then
        local v46 = os.clock();
        if v46 - u9 < 1 then
        else
            u9 = v46;
            u40();
            task.defer(function() --[[ Line: 335 ]]
                -- upvalues: u3 (ref), u26 (ref), u5 (ref), l__RunService__4 (ref), u4 (ref), u2 (ref), l__LocalPlayer__9 (ref), u6 (ref), l__Temporary__10 (ref)
                if u3 then
                    u26();
                    if not u5 then
                        u5 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 339 ]]
                            -- upvalues: u4 (ref), u2 (ref), l__LocalPlayer__9 (ref), u6 (ref), l__Temporary__10 (ref)
                            debug.profilebegin("Controllers/TeleporterController/PreviewUpdate");
                            if u4 and u4.PrimaryPart then
                                local v47 = u2;
                                local l__Character__20 = l__LocalPlayer__9.Character;
                                if l__Character__20 then
                                    l__Character__20 = l__Character__20:FindFirstChild("Head");
                                end;
                                local v48;
                                if l__Character__20 then
                                    local l__LookVector__21 = l__Character__20.CFrame.LookVector;
                                    local v49 = Vector3.new(l__LookVector__21.X, 0, l__LookVector__21.Z);
                                    if v49.Magnitude < 0.01 then
                                        v48 = nil;
                                    else
                                        v48 = l__Character__20.CFrame + v49.Unit * v47;
                                    end;
                                else
                                    v48 = nil;
                                end;
                                if v48 then
                                    if not u6 then
                                        u4.Parent = l__Temporary__10;
                                        u6 = true;
                                    end;
                                    u4:SetPrimaryPartCFrame(v48);
                                elseif u6 then
                                    u4.Parent = nil;
                                    u6 = false;
                                end;
                            end;
                            debug.profileend();
                        end);
                    end;
                end;
            end);
        end;
    end;
end;
local function u55(p51) --[[ Line: 363 ]]
    -- upvalues: u45 (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    p51.ChildAdded:Connect(function(p52) --[[ Line: 364 ]]
        -- upvalues: u45 (ref)
        if p52:IsA("Tool") then
            u45(p52);
        end;
    end);
    p51.ChildRemoved:Connect(function(p53) --[[ Line: 370 ]]
        -- upvalues: u3 (ref), u4 (ref), u5 (ref), u6 (ref)
        if p53:IsA("Tool") then
            if u3 ~= p53 then
                return;
            end;
            u3 = nil;
            if u4 then
                u4:Destroy();
                u4 = nil;
            end;
            if u5 then
                u5:Disconnect();
                u5 = nil;
            end;
            u6 = false;
        end;
    end);
    for _, v54 in p51:GetChildren() do
        if v54:IsA("Tool") then
            u45(v54);
        end;
    end;
end;
function SetupPreview()
    -- upvalues: u7 (ref)
    local l__Character__22 = game.Players.LocalPlayer.Character;
    if l__Character__22 == nil then
    else
        l__Character__22.Archivable = true;
        u7 = l__Character__22:Clone();
        u7.Parent = game.ReplicatedStorage.Assets;
        u7.Name = "ExtraPreview";
        l__Character__22.Archivable = false;
    end;
end;
function v10.Init(_) --[[ Line: 397 ]] end;
function v10.Start(_) --[[ Line: 400 ]]
    -- upvalues: l__UserInputService__2 (copy), u50 (copy), l__LocalPlayer__9 (copy), u55 (copy), u4 (ref), u5 (ref), u6 (ref), u3 (ref)
    l__UserInputService__2.InputBegan:Connect(function(p56, p57) --[[ Line: 401 ]]
        -- upvalues: u50 (ref)
        if p57 then
        elseif p56.UserInputType == Enum.UserInputType.MouseButton1 and true or p56.KeyCode == Enum.KeyCode.ButtonR2 then
            u50();
        end;
    end);
    local l__Character__23 = l__LocalPlayer__9.Character;
    if l__Character__23 then
        u55(l__Character__23);
    end;
    if l__LocalPlayer__9:HasAppearanceLoaded() == true then
        SetupPreview();
    end;
    l__LocalPlayer__9.CharacterAdded:Connect(function(p58) --[[ Line: 414 ]]
        -- upvalues: u4 (ref), u5 (ref), u6 (ref), u3 (ref), u55 (ref)
        if u4 then
            u4:Destroy();
            u4 = nil;
        end;
        if u5 then
            u5:Disconnect();
            u5 = nil;
        end;
        u6 = false;
        u3 = nil;
        u55(p58);
    end);
    l__LocalPlayer__9.CharacterAppearanceLoaded:Connect(function(_) --[[ Line: 420 ]]
        SetupPreview();
    end);
end;
return v10;