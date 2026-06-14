-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__TweenService__5 = game:GetService("TweenService");
local l__ContextActionService__6 = game:GetService("ContextActionService");
local l__Networking__7 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__LocalPlayer__8 = l__Players__1.LocalPlayer;
local l__CurrentCamera__9 = workspace.CurrentCamera;
local l__Gardens__10 = workspace:WaitForChild("Gardens");
local l__HideCollectProximityPrompts__11 = l__LocalPlayer__8:WaitForChild("HideCollectProximityPrompts");
local u2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = false;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = false;
local u22 = 0;
local u23 = 0;
local u24 = nil;
local u25 = nil;
local u26 = {};
local u27 = nil;
local u28 = nil;
local u29 = nil;
function v1.Init(_) --[[ Line: 61 ]] end;
function v1.ResolveButton(_, p30) --[[ Line: 65 ]]
    if p30 then
        if p30:IsA("GuiButton") then
            return p30;
        else
            local v31 = p30:FindFirstChild("Button");
            if v31 and v31:IsA("GuiButton") then
                return v31;
            else
                local v32 = p30:FindFirstChild("TextButton");
                if v32 and v32:IsA("GuiButton") then
                    return v32;
                else
                    return nil;
                end;
            end;
        end;
    else
        return nil;
    end;
end;
function v1.IsTouchOnButton(_, p33, p34) --[[ Line: 86 ]]
    if not (p34 and p34.Visible) then
        return false;
    end;
    local l__AbsolutePosition__12 = p34.AbsolutePosition;
    local l__AbsoluteSize__13 = p34.AbsoluteSize;
    local v35;
    if p33.X >= l__AbsolutePosition__12.X and (p33.X <= l__AbsolutePosition__12.X + l__AbsoluteSize__13.X and p33.Y >= l__AbsolutePosition__12.Y) then
        v35 = p33.Y <= l__AbsolutePosition__12.Y + l__AbsoluteSize__13.Y;
    else
        v35 = false;
    end;
    return v35;
end;
function v1.IsTouchOnMoveUi(p36, p37) --[[ Line: 99 ]]
    -- upvalues: u4 (ref), u5 (ref)
    if not p37 or #p37 == 0 then
        return false;
    end;
    for _, v38 in p37 do
        if p36:IsTouchOnButton(v38, u4) or p36:IsTouchOnButton(v38, u5) then
            return true;
        end;
    end;
    return false;
end;
function v1.BindGamepadRotateAction(u39) --[[ Line: 113 ]]
    -- upvalues: l__ContextActionService__6 (copy), u17 (ref), u15 (ref)
    l__ContextActionService__6:UnbindAction("TrowelRotateAction");
    l__ContextActionService__6:BindActionAtPriority("TrowelRotateAction", function(_, p40, p41) --[[ Line: 117 ]]
        -- upvalues: u17 (ref), u15 (ref), u39 (copy)
        if p40 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;
        if not (u17 and u15) then
            return Enum.ContextActionResult.Pass;
        end;
        if p41.KeyCode == Enum.KeyCode.ButtonL1 then
            u39:RotateMove(-1);
            return Enum.ContextActionResult.Sink;
        end;
        if p41.KeyCode ~= Enum.KeyCode.ButtonR1 then
            return Enum.ContextActionResult.Pass;
        end;
        u39:RotateMove(1);
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
end;
function v1.UnbindGamepadRotateAction(_) --[[ Line: 143 ]]
    -- upvalues: l__ContextActionService__6 (copy)
    l__ContextActionService__6:UnbindAction("TrowelRotateAction");
end;
function v1.BindMoveCancelAction(u42) --[[ Line: 147 ]]
    -- upvalues: l__ContextActionService__6 (copy), u17 (ref), u15 (ref)
    l__ContextActionService__6:UnbindAction("TrowelMoveCancelAction");
    l__ContextActionService__6:BindActionAtPriority("TrowelMoveCancelAction", function(_, p43, p44) --[[ Line: 151 ]]
        -- upvalues: u17 (ref), u15 (ref), u42 (copy)
        if p43 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;
        if not (u17 and u15) then
            return Enum.ContextActionResult.Pass;
        end;
        if p44.KeyCode ~= Enum.KeyCode.C and p44.KeyCode ~= Enum.KeyCode.ButtonB then
            return Enum.ContextActionResult.Pass;
        end;
        u42:CancelMove();
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.C, Enum.KeyCode.ButtonB);
end;
function v1.UnbindMoveCancelAction(_) --[[ Line: 171 ]]
    -- upvalues: l__ContextActionService__6 (copy)
    l__ContextActionService__6:UnbindAction("TrowelMoveCancelAction");
end;
function v1.SetMoveUiVisible(p45, p46) --[[ Line: 175 ]]
    -- upvalues: u4 (ref), u5 (ref), l__UserInputService__2 (copy), u6 (ref), u7 (ref), u8 (ref)
    if u4 then
        u4.Visible = p46;
        if u5 then
            u5.Visible = p46;
        end;
        if p46 then
            local l__TouchEnabled__14 = l__UserInputService__2.TouchEnabled;
            if l__TouchEnabled__14 then
                l__TouchEnabled__14 = not l__UserInputService__2.KeyboardEnabled;
            end;
            local v47 = p45:IsUsingGamepad();
            if u6 then
                u6.Visible = l__TouchEnabled__14;
            end;
            if u7 then
                local v48 = u7;
                local v49 = not l__TouchEnabled__14;
                if v49 then
                    v49 = not v47;
                end;
                v48.Visible = v49;
            end;
            if u8 then
                u8.Visible = v47;
            end;
        end;
    end;
end;
function v1.BindTrowelUi(u50, p51) --[[ Line: 195 ]]
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u17 (ref), u10 (ref)
    local v52 = p51:FindFirstChild("TrowelUI");
    if v52 then
        u3 = v52;
        u4 = u50:ResolveButton(u3:FindFirstChild("InitialModeTrowel"):FindFirstChild("Cancel"));
        u5 = u50:ResolveButton(u3:FindFirstChild("InitialModeTrowel"):FindFirstChild("Rotate"));
        if u4 then
            local v53 = u4:FindFirstChild("Text");
            if v53 then
                u6 = v53:FindFirstChild("Mobile");
                u7 = v53:FindFirstChild("PC");
                u8 = v53:FindFirstChild("Console");
            end;
            if u9 then
                u9:Disconnect();
                u9 = nil;
            end;
            u9 = u4.MouseButton1Click:Connect(function() --[[ Line: 217 ]]
                -- upvalues: u17 (ref), u50 (copy)
                if u17 then
                    u50:CancelMove();
                end;
            end);
        end;
        if u5 then
            if u10 then
                u10:Disconnect();
                u10 = nil;
            end;
            u10 = u5.MouseButton1Click:Connect(function() --[[ Line: 229 ]]
                -- upvalues: u17 (ref), u50 (copy)
                if u17 then
                    u50:RotateMove(1);
                end;
            end);
        end;
    end;
end;
function v1.Start(u54) --[[ Line: 237 ]]
    -- upvalues: l__LocalPlayer__8 (copy), u17 (ref), l__UserInputService__2 (copy), u16 (ref), l__Networking__7 (copy), u27 (ref), u29 (ref), u28 (ref)
    local l__PlayerGui__15 = l__LocalPlayer__8:WaitForChild("PlayerGui");
    u54:BindTrowelUi(l__PlayerGui__15);
    l__PlayerGui__15.ChildAdded:Connect(function(p55) --[[ Line: 242 ]]
        -- upvalues: u54 (copy), l__PlayerGui__15 (copy), u17 (ref)
        if p55.Name == "TrowelUI" then
            u54:BindTrowelUi(l__PlayerGui__15);
            u54:SetMoveUiVisible(u17);
        end;
    end);
    u54:SetMoveUiVisible(false);
    l__UserInputService__2.InputBegan:Connect(function(p56, p57) --[[ Line: 251 ]]
        -- upvalues: u54 (copy)
        u54:OnInput(p56, p57);
    end);
    l__UserInputService__2.TouchTap:Connect(function(p58, p59) --[[ Line: 254 ]]
        -- upvalues: u54 (copy)
        if p59 then
        elseif u54:IsTouchOnMoveUi(p58) then
        else
            u54:OnPrimaryAction();
        end;
    end);
    local l__Character__16 = l__LocalPlayer__8.Character;
    if l__Character__16 then
        u54:SetupCharacter(l__Character__16);
    end;
    l__LocalPlayer__8.CharacterAdded:Connect(function(p60) --[[ Line: 268 ]]
        -- upvalues: u54 (copy)
        u54:SetupCharacter(p60);
    end);
    l__LocalPlayer__8:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 272 ]]
        -- upvalues: u16 (ref)
        u16 = nil;
    end);
    l__Networking__7.Trowel.MoveRejected.OnClientEvent:Connect(function(p61) --[[ Line: 276 ]]
        -- upvalues: u27 (ref), u29 (ref), u28 (ref)
        if u27 and (u29 and u28 == p61) then
            if u27.Parent then
                u27:PivotTo(u29);
            end;
            u27 = nil;
            u28 = nil;
            u29 = nil;
        end;
    end);
end;
function v1.SetupCharacter(u62, p63) --[[ Line: 289 ]]
    -- upvalues: u15 (ref), u17 (ref)
    for _, v64 in p63:GetChildren() do
        if v64:IsA("Tool") and v64:GetAttribute("Trowel") then
            u15 = v64;
            u62:StartHoverDetection();
        end;
    end;
    p63.ChildAdded:Connect(function(p65) --[[ Line: 299 ]]
        -- upvalues: u15 (ref), u62 (copy)
        if p65:IsA("Tool") and p65:GetAttribute("Trowel") then
            u15 = p65;
            u62:StartHoverDetection();
        end;
    end);
    p63.ChildRemoved:Connect(function(p66) --[[ Line: 306 ]]
        -- upvalues: u15 (ref), u17 (ref), u62 (copy)
        if p66:IsA("Tool") and (p66:GetAttribute("Trowel") and u15 == p66) then
            u15 = nil;
            if u17 then
                u62:CancelMove();
            end;
            u62:StopHoverDetection();
        end;
    end);
    local u67 = p63:FindFirstChildOfClass("Humanoid");
    if u67 then
        u67.Died:Connect(function() --[[ Line: 324 ]]
            -- upvalues: u17 (ref), u62 (copy), u67 (copy), u15 (ref)
            if u17 then
                u62:CancelMove();
            end;
            u67:UnequipTools();
            u15 = nil;
            u62:StopHoverDetection();
        end);
    end;
end;
function v1.GetPlayerPlantsFolder(_) --[[ Line: 335 ]]
    -- upvalues: u16 (ref), l__LocalPlayer__8 (copy), l__Gardens__10 (copy)
    if u16 then
        return u16;
    end;
    local v68 = l__LocalPlayer__8:GetAttribute("PlotId");
    if not v68 then
        return nil;
    end;
    local v69 = l__Gardens__10:FindFirstChild("Plot" .. tostring(v68));
    if not v69 then
        return nil;
    end;
    u16 = v69:FindFirstChild("Plants");
    return u16;
end;
function v1.GetPlayerPlot(_) --[[ Line: 354 ]]
    -- upvalues: l__LocalPlayer__8 (copy), l__Gardens__10 (copy)
    local v70 = l__LocalPlayer__8:GetAttribute("PlotId");
    if v70 then
        return l__Gardens__10:FindFirstChild("Plot" .. tostring(v70));
    else
        return nil;
    end;
end;
function v1.IsPartVisible(_, p71) --[[ Line: 362 ]]
    return p71.Transparency < 1;
end;
function v1.CreateRaycastParams(_, p72) --[[ Line: 366 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local v73 = RaycastParams.new();
    v73.FilterType = Enum.RaycastFilterType.Exclude;
    local v74 = {};
    local l__Character__17 = l__LocalPlayer__8.Character;
    if l__Character__17 then
        table.insert(v74, l__Character__17);
    end;
    if p72 then
        for _, v75 in p72 do
            table.insert(v74, v75);
        end;
    end;
    v73.FilterDescendantsInstances = v74;
    return v73;
end;
function v1.RaycastIgnoreInvisible(p76, p77, p78, p79) --[[ Line: 385 ]]
    -- upvalues: l__LocalPlayer__8 (copy), u18 (ref)
    local v80 = p78;
    local v81 = {};
    for _ = 1, 10 do
        local v82 = workspace:Raycast(p77, p78, p79);
        if not v82 then
            return nil;
        end;
        if p76:IsPartVisible(v82.Instance) then
            return v82;
        end;
        table.insert(v81, v82.Instance);
        local v83 = {};
        local l__Character__18 = l__LocalPlayer__8.Character;
        if l__Character__18 then
            table.insert(v83, l__Character__18);
        end;
        if u18 then
            table.insert(v83, u18);
        end;
        for _, v84 in v81 do
            table.insert(v83, v84);
        end;
        p79.FilterDescendantsInstances = v83;
        local l__Magnitude__19 = (v82.Position - p77).Magnitude;
        local l__Magnitude__20 = p78.Magnitude;
        p77 = v82.Position + v80.Unit * 0.01;
        p78 = v80.Unit * (l__Magnitude__20 - l__Magnitude__19);
        if p78.Magnitude < 0.1 then
            return nil;
        end;
    end;
    return nil;
end;
function v1.IsUsingGamepad(_) --[[ Line: 423 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v85 = l__UserInputService__2:GetLastInputType();
    return (v85 == Enum.UserInputType.Gamepad1 or (v85 == Enum.UserInputType.Gamepad2 or v85 == Enum.UserInputType.Gamepad3)) and true or v85 == Enum.UserInputType.Gamepad4;
end;
function v1.GetMouseWorldRay(p86) --[[ Line: 431 ]]
    -- upvalues: l__LocalPlayer__8 (copy), l__UserInputService__2 (copy), l__CurrentCamera__9 (copy)
    if p86:IsUsingGamepad() then
        local l__Character__21 = l__LocalPlayer__8.Character;
        if l__Character__21 then
            local v87 = l__Character__21:FindFirstChild("HumanoidRootPart");
            if v87 then
                return v87.Position + v87.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0);
            else
                return nil, nil;
            end;
        else
            return nil, nil;
        end;
    else
        local v88 = l__UserInputService__2:GetMouseLocation();
        local v89 = l__CurrentCamera__9:ViewportPointToRay(v88.X, v88.Y);
        return v89.Origin, v89.Direction * 5000;
    end;
end;
function v1.GetPlantTarget(p90, p91) --[[ Line: 447 ]]
    if not p91 then
        return nil, nil;
    end;
    local v92 = p90:GetPlayerPlantsFolder();
    if not v92 then
        return nil, nil;
    end;
    while p91 and p91 ~= workspace do
        local l__Parent__22 = p91.Parent;
        if l__Parent__22 and l__Parent__22.Name == "Fruits" then
            local l__Parent__23 = l__Parent__22.Parent;
            if l__Parent__23 and l__Parent__23.Parent == v92 then
                return l__Parent__23, l__Parent__23.Name;
            end;
        end;
        if l__Parent__22 == v92 and p91:IsA("Model") then
            return p91, p91.Name;
        end;
        p91 = l__Parent__22;
    end;
    return nil, nil;
end;
function v1.ClearHighlight(_) --[[ Line: 474 ]]
    -- upvalues: u11 (ref), u12 (ref), u13 (ref)
    if u11 then
        u11:Destroy();
        u11 = nil;
    end;
    u12 = nil;
    u13 = nil;
end;
function v1.DisableCollisions(_, p93) --[[ Line: 487 ]]
    -- upvalues: u26 (ref)
    u26 = {};
    for _, v94 in p93:GetDescendants() do
        if v94:IsA("BasePart") then
            u26[v94] = {
                canCollide = v94.CanCollide,
                anchored = v94.Anchored
            };
            v94.CanCollide = false;
            v94.Anchored = true;
        end;
    end;
    local l__PrimaryPart__24 = p93.PrimaryPart;
    if l__PrimaryPart__24 and not u26[l__PrimaryPart__24] then
        u26[l__PrimaryPart__24] = {
            canCollide = l__PrimaryPart__24.CanCollide,
            anchored = l__PrimaryPart__24.Anchored
        };
        l__PrimaryPart__24.CanCollide = false;
        l__PrimaryPart__24.Anchored = true;
    end;
end;
function v1.RestoreCollisions(_) --[[ Line: 505 ]]
    -- upvalues: u26 (ref)
    for v95, v96 in u26 do
        if v95 and v95.Parent then
            v95.CanCollide = v96.canCollide;
            v95.Anchored = v96.anchored;
        end;
    end;
    u26 = {};
end;
local u97 = 0;
function v1.UpdateHoverHighlight(p98) --[[ Line: 521 ]]
    -- upvalues: u17 (ref), u97 (ref), u12 (ref), u11 (ref), u13 (ref)
    if u17 then
    else
        local v99, v100 = p98:GetMouseWorldRay();
        if v99 then
            local v101 = p98:RaycastIgnoreInvisible(v99, v100, (p98:CreateRaycastParams()));
            local v102, v103 = p98:GetPlantTarget(v101 and v101.Instance or nil);
            u97 = u97 + 1;
            if u97 >= 120 then
                u97 = 0;
            end;
            if v102 == u12 then
            else
                p98:ClearHighlight();
                if v102 then
                    local v104 = Instance.new("Highlight");
                    v104.FillColor = Color3.fromRGB(0, 255, 0);
                    v104.FillTransparency = 0.5;
                    v104.OutlineTransparency = 1;
                    v104.Parent = v102;
                    v104.Adornee = v102;
                    u11 = v104;
                    u12 = v102;
                    u13 = v103;
                end;
            end;
        end;
    end;
end;
function v1.StartMove(p105) --[[ Line: 561 ]]
    -- upvalues: u12 (ref), u13 (ref), u17 (ref), u18 (ref), u19 (ref), u21 (ref), u24 (ref), u25 (ref), u22 (ref), u23 (ref), u20 (ref)
    if u12 and u13 then
        u17 = true;
        u18 = u12;
        u19 = u13;
        u21 = false;
        u24 = nil;
        u25 = u18:GetPivot();
        local l__PrimaryPart__25 = u18.PrimaryPart;
        if l__PrimaryPart__25 then
            local _, v106, _ = l__PrimaryPart__25.CFrame:ToEulerAnglesYXZ();
            u22 = math.deg(v106);
            u23 = l__PrimaryPart__25.Size.Y / 2;
        else
            u22 = 0;
            u23 = 0;
        end;
        p105:DisableCollisions(u18);
        p105:ClearHighlight();
        p105:SetMoveUiVisible(true);
        p105:BindGamepadRotateAction();
        p105:BindMoveCancelAction();
        local v107 = Instance.new("Highlight");
        v107.FillColor = Color3.fromRGB(0, 255, 0);
        v107.FillTransparency = 0.5;
        v107.OutlineTransparency = 1;
        v107.Parent = u18;
        v107.Adornee = u18;
        u20 = v107;
    end;
end;
function v1.UpdateMovingPlant(p108) --[[ Line: 599 ]]
    -- upvalues: u17 (ref), u18 (ref), u21 (ref), u20 (ref), u24 (ref), u22 (ref)
    if u17 and u18 then
        for _, v109 in u18:GetDescendants() do
            if v109:IsA("BasePart") and v109.CanCollide then
                v109.CanCollide = false;
            end;
        end;
        local v110, v111 = p108:GetMouseWorldRay();
        if v110 then
            local v112 = p108:RaycastIgnoreInvisible(v110, v111, (p108:CreateRaycastParams({ u18 })));
            if v112 then
                local v113 = p108:GetPlayerPlot();
                local v114 = v112.Instance:HasTag("PlantArea");
                if v114 then
                    if v113 == nil then
                        v114 = false;
                    else
                        v114 = v112.Instance:IsDescendantOf(v113);
                    end;
                end;
                u21 = v114;
                u24 = v112.Position;
                u18:PivotTo(CFrame.new(v112.Position.X, v112.Position.Y + 3, v112.Position.Z) * CFrame.Angles(0, math.rad(u22), 0));
                if u20 then
                    u20.FillColor = u21 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0);
                end;
            else
                u21 = false;
                if u20 then
                    u20.FillColor = Color3.fromRGB(255, 0, 0);
                end;
            end;
        end;
    end;
end;
function v1.LandPlant(_, u115, p116, p117, _, u118) --[[ Line: 641 ]]
    -- upvalues: l__TweenService__5 (copy), u2 (copy)
    if u115 and u115.Parent then
        local u119 = CFrame.new(p116.X, p116.Y, p116.Z) * CFrame.Angles(0, math.rad(p117), 0);
        if u115.PrimaryPart then
            local u120 = u115:GetPivot();
            local u121 = Instance.new("NumberValue");
            u121.Value = 0;
            local v122 = l__TweenService__5:Create(u121, u2, {
                Value = 1
            });
            local u123 = u121.Changed:Connect(function() --[[ Line: 669 ]]
                -- upvalues: u115 (copy), u120 (copy), u119 (copy), u121 (copy)
                if u115 and u115.Parent then
                    u115:PivotTo(u120:Lerp(u119, u121.Value));
                end;
            end);
            v122.Completed:Connect(function() --[[ Line: 675 ]]
                -- upvalues: u123 (ref), u121 (copy), u115 (copy), u119 (copy), u118 (copy)
                u123:Disconnect();
                u121:Destroy();
                if u115 and u115.Parent then
                    u115:PivotTo(u119);
                end;
                for v124, v125 in u118 do
                    if v124 and v124.Parent then
                        v124.CanCollide = v125.canCollide;
                        v124.Anchored = v125.anchored;
                    end;
                end;
            end);
            v122:Play();
        else
            u115:PivotTo(u119);
            for v126, v127 in u118 do
                if v126 and v126.Parent then
                    v126.CanCollide = v127.canCollide;
                    v126.Anchored = v127.anchored;
                end;
            end;
        end;
    end;
end;
function v1.ConfirmMove(p128) --[[ Line: 691 ]]
    -- upvalues: u17 (ref), u18 (ref), u21 (ref), u24 (ref), l__Networking__7 (copy), u19 (ref), u22 (ref), u23 (ref), u25 (ref), u26 (ref), u27 (ref), u28 (ref), u29 (ref)
    if u17 and (u18 and (u21 and u24)) then
        l__Networking__7.Trowel.MovePlant:Fire(u19, u24, u22);
        local v129 = u18;
        local u130 = u19;
        local v131 = u24;
        local v132 = u22;
        local v133 = u23;
        local v134 = u25;
        local v135 = u26;
        u27 = v129;
        u28 = u130;
        u29 = v134;
        u26 = {};
        p128:EndMove(false);
        p128:LandPlant(v129, v131, v132, v133, v135);
        task.delay(2, function() --[[ Line: 714 ]]
            -- upvalues: u28 (ref), u130 (copy), u27 (ref), u29 (ref)
            if u28 == u130 then
                u27 = nil;
                u28 = nil;
                u29 = nil;
            end;
        end);
    end;
end;
function v1.RotateMove(_, p136) --[[ Line: 723 ]]
    -- upvalues: u17 (ref), u22 (ref)
    if u17 then
        u22 = (u22 + p136 * 45) % 360;
    end;
end;
function v1.CancelMove(p137) --[[ Line: 730 ]]
    -- upvalues: u17 (ref), u18 (ref), u25 (ref)
    if u17 then
        if u18 and u25 then
            u18:PivotTo(u25);
        end;
        p137:EndMove(true);
    end;
end;
function v1.EndMove(p138, p139) --[[ Line: 740 ]]
    -- upvalues: u20 (ref), u17 (ref), u18 (ref), u19 (ref), u21 (ref), u24 (ref), u25 (ref)
    if u20 then
        u20:Destroy();
        u20 = nil;
    end;
    if p139 ~= false then
        p138:RestoreCollisions();
    end;
    u17 = false;
    u18 = nil;
    u19 = nil;
    u21 = false;
    u24 = nil;
    u25 = nil;
    p138:SetMoveUiVisible(false);
    p138:UnbindGamepadRotateAction();
    p138:UnbindMoveCancelAction();
end;
function v1.StartHoverDetection(u140) --[[ Line: 767 ]]
    -- upvalues: u14 (ref), l__HideCollectProximityPrompts__11 (copy), l__RunService__4 (copy), u17 (ref)
    if u14 then
    else
        l__HideCollectProximityPrompts__11.Value = true;
        u14 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 772 ]]
            -- upvalues: u17 (ref), u140 (copy)
            debug.profilebegin("Controllers/TrowelController/RenderStepped");
            if u17 then
                u140:UpdateMovingPlant();
            else
                u140:UpdateHoverHighlight();
            end;
            debug.profileend();
        end);
    end;
end;
function v1.StopHoverDetection(p141) --[[ Line: 783 ]]
    -- upvalues: l__HideCollectProximityPrompts__11 (copy), u14 (ref), u17 (ref)
    l__HideCollectProximityPrompts__11.Value = false;
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;
    if u17 then
        p141:CancelMove();
    end;
    p141:ClearHighlight();
end;
function v1.OnInput(p142, p143, p144) --[[ Line: 801 ]]
    -- upvalues: u15 (ref), u17 (ref)
    if p144 then
    elseif u15 then
        local v145 = (p143.UserInputType == Enum.UserInputType.MouseButton1 or p143.KeyCode == Enum.KeyCode.ButtonA) and true or p143.KeyCode == Enum.KeyCode.ButtonR2;
        local v146 = p143.KeyCode == Enum.KeyCode.C and true or p143.KeyCode == Enum.KeyCode.ButtonB;
        local v147 = (p143.KeyCode == Enum.KeyCode.R or p143.KeyCode == Enum.KeyCode.ButtonL1) and true or p143.KeyCode == Enum.KeyCode.ButtonR1;
        if v146 and u17 then
            p142:CancelMove();
        elseif v147 and u17 then
            p142:RotateMove(p143.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1);
        else
            if v145 then
                p142:OnPrimaryAction();
            end;
        end;
    end;
end;
function v1.OnPrimaryAction(p148) --[[ Line: 832 ]]
    -- upvalues: u15 (ref), u17 (ref), u12 (ref), u13 (ref)
    if u15 then
        if u17 then
            p148:ConfirmMove();
        else
            if u12 and u13 then
                p148:StartMove();
            end;
        end;
    end;
end;
return v1;