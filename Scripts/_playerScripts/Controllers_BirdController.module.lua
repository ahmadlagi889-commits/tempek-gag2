-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__RunService__5 = game:GetService("RunService");
local l__SoundService__6 = game:GetService("SoundService");
local l__Networking__7 = require(l__ReplicatedStorage__4.SharedModules.Networking);
local l__LocalPlayer__8 = l__Players__1.LocalPlayer;
local l__CurrentCamera__9 = workspace.CurrentCamera;
local l__Robin__10 = l__ReplicatedStorage__4:WaitForChild("Assets"):WaitForChild("Pets"):WaitForChild("Robin");
local l__Temporary__11 = workspace:WaitForChild("Temporary");
local u2 = Color3.fromRGB(100, 255, 100);
local u3 = Color3.fromRGB(255, 100, 100);
local u4 = 0;
local u5 = nil;
local u6 = nil;
local u7 = false;
local function u13(p8, p9, p10) --[[ Line: 36 ]]
    for _ = 1, 10 do
        local v11 = workspace:Raycast(p8, p9, p10);
        if not v11 then
            return nil;
        end;
        if v11.Instance.Transparency < 1 then
            return v11;
        end;
        local v12 = table.clone(p10.FilterDescendantsInstances);
        table.insert(v12, v11.Instance);
        p10.FilterDescendantsInstances = v12;
    end;
    return nil;
end;
function v1.Init(_) --[[ Line: 51 ]] end;
function v1.Start(u14) --[[ Line: 54 ]]
    -- upvalues: l__UserInputService__2 (copy), l__LocalPlayer__8 (copy)
    l__UserInputService__2.InputBegan:Connect(function(p15, p16) --[[ Line: 55 ]]
        -- upvalues: u14 (copy)
        u14:OnInput(p15, p16);
    end);
    local l__Character__12 = l__LocalPlayer__8.Character;
    if l__Character__12 then
        u14:SetupCharacter(l__Character__12);
    end;
    l__LocalPlayer__8.CharacterAdded:Connect(function(p17) --[[ Line: 61 ]]
        -- upvalues: u14 (copy)
        u14:SetupCharacter(p17);
    end);
end;
function v1.SetupCharacter(u18, p19) --[[ Line: 66 ]]
    p19.ChildAdded:Connect(function(p20) --[[ Line: 67 ]]
        -- upvalues: u18 (copy)
        if p20:IsA("Tool") and p20:GetAttribute("Bird") then
            u18:EnterPlacingMode();
        end;
    end);
    p19.ChildRemoved:Connect(function(p21) --[[ Line: 72 ]]
        -- upvalues: u18 (copy)
        if p21:IsA("Tool") and p21:GetAttribute("Bird") then
            u18:ExitPlacingMode();
        end;
    end);
    for _, v22 in p19:GetChildren() do
        if v22:IsA("Tool") and v22:GetAttribute("Bird") then
            u18:EnterPlacingMode();
        end;
    end;
end;
function v1.EnterPlacingMode(p23) --[[ Line: 84 ]]
    -- upvalues: u7 (ref)
    if u7 then
    else
        u7 = true;
        p23:CreatePreview();
    end;
end;
function v1.ExitPlacingMode(p24) --[[ Line: 90 ]]
    -- upvalues: u7 (ref)
    u7 = false;
    p24:DestroyPreview();
end;
function v1.CreatePreview(u25) --[[ Line: 95 ]]
    -- upvalues: l__Robin__10 (copy), l__Temporary__11 (copy), u5 (ref), u6 (ref), l__RunService__5 (copy)
    u25:DestroyPreview();
    local v26 = l__Robin__10:Clone();
    v26.Name = "BirdPreview";
    for _, v27 in v26:GetDescendants() do
        if v27:IsA("BasePart") then
            if v27.Transparency == 0 then
                v27.Transparency = 0.5;
            end;
            v27.CanCollide = false;
            v27.CanQuery = false;
            v27.CanTouch = false;
            v27.Anchored = true;
        elseif v27:IsA("ParticleEmitter") or (v27:IsA("Trail") or v27:IsA("Beam")) then
            v27.Enabled = false;
        end;
    end;
    v26.Parent = l__Temporary__11;
    u5 = v26;
    u6 = l__RunService__5.RenderStepped:Connect(function() --[[ Line: 116 ]]
        -- upvalues: u25 (copy)
        debug.profilebegin("Controllers/BirdController/PreviewUpdate");
        u25:UpdatePreview();
        debug.profileend();
    end);
end;
function v1.DestroyPreview(_) --[[ Line: 123 ]]
    -- upvalues: u6 (ref), u5 (ref)
    if u6 then
        u6:Disconnect();
        u6 = nil;
    end;
    if u5 then
        u5:Destroy();
        u5 = nil;
    end;
end;
function v1.SetPreviewColor(_, p28) --[[ Line: 134 ]]
    -- upvalues: u5 (ref), u2 (copy), u3 (copy)
    if u5 then
        local v29 = p28 and u2 or u3;
        for _, v30 in u5:GetDescendants() do
            if v30:IsA("BasePart") then
                v30.Color = v29;
            end;
        end;
    end;
end;
function v1.IsUsingGamepad(_) --[[ Line: 144 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v31 = l__UserInputService__2:GetLastInputType();
    return (v31 == Enum.UserInputType.Gamepad1 or (v31 == Enum.UserInputType.Gamepad2 or v31 == Enum.UserInputType.Gamepad3)) and true or v31 == Enum.UserInputType.Gamepad4;
end;
function v1.GetGamepadPlacementRay(_) --[[ Line: 152 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local l__Character__13 = l__LocalPlayer__8.Character;
    if l__Character__13 then
        local v32 = l__Character__13:FindFirstChild("HumanoidRootPart");
        if v32 then
            return v32.Position + v32.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0);
        else
            return nil, nil;
        end;
    else
        return nil, nil;
    end;
end;
function v1.CreateRaycastParams(_) --[[ Line: 162 ]]
    -- upvalues: l__LocalPlayer__8 (copy), l__Temporary__11 (copy), u5 (ref)
    local v33 = RaycastParams.new();
    v33.FilterType = Enum.RaycastFilterType.Exclude;
    local l__Character__14 = l__LocalPlayer__8.Character;
    local v34 = { l__Temporary__11 };
    if u5 then
        table.insert(v34, u5);
    end;
    if l__Character__14 then
        table.insert(v34, l__Character__14);
    end;
    v33.FilterDescendantsInstances = v34;
    return v33;
end;
function v1.IsValidPlacement(_, p35) --[[ Line: 173 ]]
    -- upvalues: l__CollectionService__3 (copy)
    local v36 = p35 + Vector3.new(0, 50, 0);
    local v37 = l__CollectionService__3:GetTagged("GardenTotalArea");
    if #v37 == 0 then
        return false;
    end;
    local v38 = RaycastParams.new();
    v38.FilterType = Enum.RaycastFilterType.Include;
    v38.FilterDescendantsInstances = v37;
    return workspace:Raycast(v36, Vector3.new(0, -100, 0), v38) ~= nil;
end;
function v1.UpdatePreview(p39) --[[ Line: 187 ]]
    -- upvalues: u5 (ref), u13 (copy), l__UserInputService__2 (copy), l__CurrentCamera__9 (copy), l__Temporary__11 (copy)
    if u5 then
        local v40 = p39:CreateRaycastParams();
        local v41;
        if p39:IsUsingGamepad() then
            local v42, v43 = p39:GetGamepadPlacementRay();
            if not (v42 and v43) then
                u5.Parent = nil;
                return;
            end;
            v41 = u13(v42, v43, v40);
        else
            local v44 = l__UserInputService__2:GetMouseLocation();
            local v45 = l__CurrentCamera__9:ViewportPointToRay(v44.X, v44.Y);
            v41 = u13(v45.Origin, v45.Direction * 5000, v40);
        end;
        if v41 then
            u5.Parent = l__Temporary__11;
            local l__Position__15 = v41.Position;
            local v46 = l__Position__15 + Vector3.new(0, 14, 0);
            if u5.PrimaryPart then
                u5:PivotTo(CFrame.new(v46));
            end;
            p39:SetPreviewColor(p39:IsValidPlacement(l__Position__15));
        else
            u5.Parent = nil;
        end;
    end;
end;
function v1.GetEquippedTool(_) --[[ Line: 223 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local l__Character__16 = l__LocalPlayer__8.Character;
    if l__Character__16 then
        return l__Character__16:FindFirstChildWhichIsA("Tool");
    else
        return nil;
    end;
end;
function v1.OnInput(p47, p48, p49) --[[ Line: 229 ]]
    -- upvalues: u7 (ref), u4 (ref), u13 (copy), l__CurrentCamera__9 (copy), l__Networking__7 (copy), l__LocalPlayer__8 (copy), l__SoundService__6 (copy)
    if p49 then
    elseif u7 then
        if (p48.UserInputType == Enum.UserInputType.MouseButton1 or p48.UserInputType == Enum.UserInputType.Touch) and true or p48.KeyCode == Enum.KeyCode.ButtonR2 then
            local v50 = os.clock();
            if v50 - u4 < 0.5 then
            else
                local v51 = p47:GetEquippedTool();
                if v51 then
                    local v52 = v51:GetAttribute("Bird");
                    if v52 then
                        local v53 = p47:CreateRaycastParams();
                        local v54;
                        if p47:IsUsingGamepad() then
                            local v55, v56 = p47:GetGamepadPlacementRay();
                            if not (v55 and v56) then
                                return;
                            end;
                            v54 = u13(v55, v56, v53);
                        else
                            local l__Position__17 = p48.Position;
                            local v57 = l__CurrentCamera__9:ScreenPointToRay(l__Position__17.X, l__Position__17.Y);
                            v54 = u13(v57.Origin, v57.Direction * 5000, v53);
                        end;
                        if v54 then
                            if p47:IsValidPlacement(v54.Position) then
                                u4 = v50;
                                l__Networking__7.Place.PlaceBird:Fire(v54.Position, v52, v51);
                                local l__Character__18 = l__LocalPlayer__8.Character;
                                if l__Character__18 then
                                    l__Character__18 = l__Character__18:FindFirstChild("HumanoidRootPart");
                                end;
                                if l__Character__18 then
                                    local v58 = Instance.new("Sound");
                                    v58.SoundId = "rbxassetid://135948019584556";
                                    v58.SoundGroup = l__SoundService__6:FindFirstChild("SFXGroup");
                                    v58.Parent = l__Character__18;
                                    v58:Play();
                                    game.Debris:AddItem(v58, 3);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
return v1;