-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__TweenService__4 = game:GetService("TweenService");
game:GetService("Debris");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__RunService__6 = game:GetService("RunService");
local l__SoundService__7 = game:GetService("SoundService");
local l__Sprinklers__8 = l__ReplicatedStorage__5.Assets.Sprinklers;
local l__Networking__9 = require(l__ReplicatedStorage__5.SharedModules.Networking);
local l__SprinklerData__10 = require(l__ReplicatedStorage__5.SharedModules.SprinklerData);
local l__LocalPlayer__11 = l__Players__1.LocalPlayer;
local l__CurrentCamera__12 = workspace.CurrentCamera;
local l__Gardens__13 = workspace:WaitForChild("Gardens");
local l__Assets__14 = l__ReplicatedStorage__5.Assets;
local _ = l__Assets__14.Dirt;
local _ = l__Assets__14.Seeds;
local l__Temporary__15 = workspace.Temporary;
local u2 = 0;
TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
TweenInfo.new(0.12, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u3 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
local _ = {
    Color3.fromRGB(101, 67, 33),
    Color3.fromRGB(92, 60, 28),
    Color3.fromRGB(110, 75, 40),
    Color3.fromRGB(85, 55, 25)
};
local u4 = Color3.fromRGB(100, 255, 100);
local u5 = Color3.fromRGB(255, 100, 100);
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {};
function v1.Init(_) --[[ Line: 69 ]]
    -- upvalues: l__SprinklerData__10 (copy), u11 (copy)
    for _, v12 in l__SprinklerData__10 do
        u11[v12.SprinklerName] = v12;
    end;
end;
function v1.Start(u13) --[[ Line: 76 ]]
    -- upvalues: l__UserInputService__2 (copy), l__LocalPlayer__11 (copy)
    l__UserInputService__2.InputBegan:Connect(function(p14, p15) --[[ Line: 78 ]]
        -- upvalues: u13 (copy)
        u13:OnInput(p14, p15);
    end);
    l__UserInputService__2.TouchTapInWorld:Connect(function(p16, p17) --[[ Line: 87 ]]
        -- upvalues: u13 (copy)
        if p17 then
        else
            local v18 = u13:GetEquippedTool();
            if v18 and v18:GetAttribute("Sprinkler") then
                u13:TryPlace(p16);
            end;
        end;
    end);
    local l__Character__16 = l__LocalPlayer__11.Character;
    if l__Character__16 then
        u13:SetupCharacter(l__Character__16);
    end;
    l__LocalPlayer__11.CharacterAdded:Connect(function(p19) --[[ Line: 100 ]]
        -- upvalues: u13 (copy)
        u13:SetupCharacter(p19);
    end);
end;
function v1.IsTouchInput(_) --[[ Line: 106 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local l__TouchEnabled__17 = l__UserInputService__2.TouchEnabled;
    if l__TouchEnabled__17 then
        l__TouchEnabled__17 = not l__UserInputService__2.MouseEnabled;
    end;
    return l__TouchEnabled__17;
end;
function v1.SetupCharacter(u20, p21) --[[ Line: 110 ]]
    p21.ChildAdded:Connect(function(p22) --[[ Line: 111 ]]
        -- upvalues: u20 (copy)
        if p22:IsA("Tool") and p22:GetAttribute("Sprinkler") then
            u20:CreatePreview(p22:GetAttribute("Sprinkler"));
        end;
    end);
    p21.ChildRemoved:Connect(function(p23) --[[ Line: 117 ]]
        -- upvalues: u20 (copy)
        if p23:IsA("Tool") and p23:GetAttribute("Sprinkler") then
            u20:DestroyPreview();
        end;
    end);
    for _, v24 in p21:GetChildren() do
        if v24:IsA("Tool") and v24:GetAttribute("Sprinkler") then
            u20:CreatePreview(v24:GetAttribute("Sprinkler"));
        end;
    end;
end;
function v1.CreatePreview(u25, p26) --[[ Line: 130 ]]
    -- upvalues: l__Sprinklers__8 (copy), u11 (copy), u6 (ref), l__Assets__14 (copy), u7 (ref), u9 (ref), l__TweenService__4 (copy), u3 (copy), u10 (ref), l__Temporary__15 (copy), u8 (ref), l__RunService__6 (copy)
    u25:DestroyPreview();
    if u25:IsTouchInput() then
    else
        local v27 = l__Sprinklers__8:FindFirstChild(p26);
        local v28 = u11[p26];
        if v27 and v28 then
            u6 = v27:Clone();
            u6.Name = "SprinklerPreview";
            local v29 = l__Assets__14.SprinklerRadius:Clone();
            v29.Size = Vector3.new(v28.Radius, 0.5, v28.Radius);
            v29.Anchored = true;
            v29.CanCollide = false;
            v29.CanQuery = false;
            v29.CanTouch = false;
            v29.Parent = u6;
            u7 = v29;
            local u30 = v29:FindFirstChild("SurfaceGui");
            if u30 then
                local u31 = u30:FindFirstChild("PrimaryCircle");
                if u31 and u31:IsA("ImageLabel") then
                    u9 = l__TweenService__4:Create(u31, u3, {
                        ImageTransparency = 0.5
                    });
                    u10 = task.spawn(function() --[[ Line: 165 ]]
                        -- upvalues: u7 (ref), u31 (copy), u30 (copy), l__TweenService__4 (ref)
                        while u7 do
                            local u32 = u31:Clone();
                            local v33 = u32:FindFirstChildOfClass("UIScale");
                            if not v33 then
                                v33 = Instance.new("UIScale");
                                v33.Parent = u32;
                            end;
                            u32.Parent = u30;
                            v33.Scale = 0;
                            local v34 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                            l__TweenService__4:Create(v33, v34, {
                                Scale = 1
                            }):Play();
                            local v35 = l__TweenService__4:Create(u32, v34, {
                                ImageTransparency = 0
                            });
                            v35:Play();
                            v35.Completed:Once(function() --[[ Line: 184 ]]
                                -- upvalues: l__TweenService__4 (ref), u32 (copy)
                                local v36 = l__TweenService__4:Create(u32, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    ImageTransparency = 1
                                });
                                v36:Play();
                                v36.Completed:Once(function() --[[ Line: 188 ]]
                                    -- upvalues: u32 (ref)
                                    u32:Destroy();
                                end);
                            end);
                            task.wait(1.1);
                        end;
                    end);
                end;
            end;
            for _, v37 in u6:GetDescendants() do
                if v37:IsA("BasePart") then
                    if v37.Transparency == 0 then
                        v37.Transparency = 0.5;
                    end;
                    v37.CanCollide = false;
                    v37.CanQuery = false;
                    v37.CanTouch = false;
                    v37.Anchored = true;
                elseif v37:IsA("ParticleEmitter") then
                    v37.Enabled = false;
                end;
            end;
            u6.Parent = l__Temporary__15;
            u8 = l__RunService__6.RenderStepped:Connect(function() --[[ Line: 214 ]]
                -- upvalues: u25 (copy)
                u25:UpdatePreview();
            end);
        end;
    end;
end;
function v1.DestroyPreview(_) --[[ Line: 219 ]]
    -- upvalues: u10 (ref), u9 (ref), u6 (ref), u7 (ref), u8 (ref)
    if u10 then
        task.cancel(u10);
        u10 = nil;
    end;
    if u9 then
        u9:Cancel();
        u9 = nil;
    end;
    if u6 then
        u6:Destroy();
        u6 = nil;
    end;
    u7 = nil;
    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;
end;
function v1.SetPreviewColor(_, p38) --[[ Line: 243 ]]
    -- upvalues: u6 (ref), u4 (copy), u5 (copy)
    if u6 then
        local v39 = p38 and u4 or u5;
        for _, v40 in u6:GetDescendants() do
            if v40:IsA("BasePart") then
                v40.Color = v39;
            end;
        end;
    end;
end;
function v1.IsUsingGamepad(_) --[[ Line: 255 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v41 = l__UserInputService__2:GetLastInputType();
    return (v41 == Enum.UserInputType.Gamepad1 or (v41 == Enum.UserInputType.Gamepad2 or v41 == Enum.UserInputType.Gamepad3)) and true or v41 == Enum.UserInputType.Gamepad4;
end;
function v1.GetGamepadPlacementRay(_) --[[ Line: 263 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    local l__Character__18 = l__LocalPlayer__11.Character;
    if l__Character__18 then
        local v42 = l__Character__18:FindFirstChild("HumanoidRootPart");
        if v42 then
            return v42.Position + v42.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.CreatePreviewRaycastParams(_) --[[ Line: 278 ]]
    -- upvalues: l__LocalPlayer__11 (copy), l__Temporary__15 (copy)
    local v43 = RaycastParams.new();
    v43.FilterType = Enum.RaycastFilterType.Exclude;
    local l__Character__19 = l__LocalPlayer__11.Character;
    local v44 = workspace:QueryDescendants("BasePart[Transparency = 1]");
    table.insert(v44, l__Temporary__15);
    if l__Character__19 then
        table.insert(v44, l__Character__19);
    end;
    v43.FilterDescendantsInstances = v44;
    return v43;
end;
function v1.IsTooCloseToSprinkler(_, p45, p46) --[[ Line: 291 ]]
    -- upvalues: u6 (ref), u11 (copy)
    if not p45 then
        return false;
    end;
    for _, v47 in p45:GetDescendants() do
        if v47:IsA("Model") and (v47 ~= u6 and (u11[v47.Name] and (v47.PrimaryPart and (v47.PrimaryPart.Position - p46).Magnitude < 1))) then
            return true;
        end;
    end;
    return false;
end;
function v1.UpdatePreview(p48) --[[ Line: 306 ]]
    -- upvalues: u6 (ref), l__UserInputService__2 (copy), l__CurrentCamera__12 (copy), l__CollectionService__3 (copy), l__Temporary__15 (copy), u7 (ref)
    if u6 then
        local v49 = p48:CreateRaycastParams();
        local v50;
        if p48:IsUsingGamepad() then
            local v51, v52 = p48:GetGamepadPlacementRay();
            if not v51 then
                u6.Parent = nil;
                return;
            end;
            v50 = workspace:Raycast(v51, v52, v49);
        else
            local v53 = l__UserInputService__2:GetMouseLocation();
            local v54 = l__CurrentCamera__12:ViewportPointToRay(v53.X, v53.Y);
            v50 = workspace:Raycast(v54.Origin, v54.Direction * 5000, v49);
        end;
        if v50 then
            local l__Instance__20 = v50.Instance;
            local v55 = p48:GetPlotFromPart(l__Instance__20);
            local v56 = v55 and (l__CollectionService__3:HasTag(l__Instance__20, "PlantArea") and l__Instance__20:IsDescendantOf(v55));
            if v56 then
                if v55:GetAttribute("Owner") == nil then
                    v56 = false;
                else
                    v56 = not p48:IsTooCloseToSprinkler(v55, v50.Position);
                end;
            end;
            u6.Parent = l__Temporary__15;
            local l__Position__21 = v50.Position;
            local v57 = Vector3.new(l__Position__21.X, 142.602, l__Position__21.Z);
            if u6.PrimaryPart then
                u6:PivotTo(CFrame.new(v57));
            end;
            if u7 then
                u7.CFrame = CFrame.new(v57);
            end;
            p48:SetPreviewColor(v56);
        else
            local v58 = p48:CreatePreviewRaycastParams();
            local v59;
            if p48:IsUsingGamepad() then
                local v60, v61 = p48:GetGamepadPlacementRay();
                if not v60 then
                    u6.Parent = nil;
                    return;
                end;
                v59 = workspace:Raycast(v60, v61, v58);
            else
                local v62 = l__UserInputService__2:GetMouseLocation();
                local v63 = l__CurrentCamera__12:ViewportPointToRay(v62.X, v62.Y);
                v59 = workspace:Raycast(v63.Origin, v63.Direction * 5000, v58);
            end;
            if v59 then
                u6.Parent = l__Temporary__15;
                local l__Position__22 = v59.Position;
                local v64 = Vector3.new(l__Position__22.X, 142.602, l__Position__22.Z);
                if u6.PrimaryPart then
                    u6:PivotTo(CFrame.new(v64));
                end;
                if u7 then
                    u7.CFrame = CFrame.new(v64);
                end;
                p48:SetPreviewColor(false);
            else
                u6.Parent = nil;
            end;
        end;
    end;
end;
function v1.GetPlayerPlot(_) --[[ Line: 387 ]]
    -- upvalues: l__LocalPlayer__11 (copy), l__Gardens__13 (copy)
    local v65 = l__LocalPlayer__11:GetAttribute("PlotId");
    if v65 then
        return l__Gardens__13:FindFirstChild("Plot" .. v65);
    else
        return nil;
    end;
end;
function v1.GetPlotFromPart(_, p66) --[[ Line: 393 ]]
    -- upvalues: l__Gardens__13 (copy)
    while p66 do
        if p66.Parent == l__Gardens__13 and string.match(p66.Name, "^Plot%d+$") then
            return p66;
        end;
        p66 = p66.Parent;
        if p66 == workspace then
            break;
        end;
    end;
    return nil;
end;
function v1.GetPlotId(_, p67) --[[ Line: 405 ]]
    return tonumber(string.match(p67.Name, "%d+"));
end;
function v1.GetEquippedTool(_) --[[ Line: 411 ]]
    -- upvalues: l__LocalPlayer__11 (copy)
    local l__Character__23 = l__LocalPlayer__11.Character;
    if l__Character__23 then
        return l__Character__23:FindFirstChildWhichIsA("Tool");
    else
        return nil;
    end;
end;
function v1.CreateRaycastParams(_) --[[ Line: 417 ]]
    local v68 = RaycastParams.new();
    v68.FilterType = Enum.RaycastFilterType.Include;
    v68.FilterDescendantsInstances = workspace.Gardens:QueryDescendants("BasePart.PlantArea");
    return v68;
end;
function v1.OnInput(p69, p70, p71) --[[ Line: 427 ]]
    if p71 then
    elseif p70.UserInputType == Enum.UserInputType.MouseButton1 and true or p70.KeyCode == Enum.KeyCode.ButtonR2 then
        p69:TryPlace();
    end;
end;
function v1.TryPlace(p72, p73) --[[ Line: 441 ]]
    -- upvalues: u2 (ref), l__UserInputService__2 (copy), l__CurrentCamera__12 (copy), l__CollectionService__3 (copy), l__Networking__9 (copy), l__LocalPlayer__11 (copy), l__SoundService__7 (copy)
    local v74 = os.clock();
    if v74 - u2 < 0.5 then
        return false;
    end;
    local v75 = p72:GetEquippedTool();
    if not v75 then
        return false;
    end;
    local v76 = v75:GetAttribute("Sprinkler");
    if not v76 then
        return false;
    end;
    local v77 = p72:CreateRaycastParams();
    local v78;
    if p72:IsUsingGamepad() then
        local v79, v80 = p72:GetGamepadPlacementRay();
        if not v79 then
            return false;
        end;
        v78 = workspace:Raycast(v79, v80, v77);
    else
        local v81 = p73 or l__UserInputService__2:GetMouseLocation();
        local v82 = l__CurrentCamera__12:ViewportPointToRay(v81.X, v81.Y);
        v78 = workspace:Raycast(v82.Origin, v82.Direction * 5000, v77);
    end;
    if not v78 then
        return false;
    end;
    local l__Instance__24 = v78.Instance;
    if not l__CollectionService__3:HasTag(l__Instance__24, "PlantArea") then
        return false;
    end;
    local v83 = p72:GetPlotFromPart(l__Instance__24);
    if not v83 then
        return false;
    end;
    if not l__Instance__24:IsDescendantOf(v83) then
        return false;
    end;
    if not v83:GetAttribute("Owner") then
        return false;
    end;
    local v84 = p72:GetPlotId(v83);
    if not v84 then
        return false;
    end;
    if p72:IsTooCloseToSprinkler(v83, v78.Position) then
        return false;
    end;
    u2 = v74;
    l__Networking__9.Place.PlaceSprinkler:Fire(v78.Position, v76, v75, v84);
    local l__Character__25 = l__LocalPlayer__11.Character;
    if l__Character__25 then
        l__Character__25 = l__Character__25:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__25 then
        local v85 = Instance.new("Sound");
        v85.SoundId = "rbxassetid://135948019584556";
        v85.SoundGroup = l__SoundService__7:FindFirstChild("SFXGroup");
        v85.Parent = l__Character__25;
        v85:Play();
        game.Debris:AddItem(v85, 3);
    end;
    return true;
end;
return v1;