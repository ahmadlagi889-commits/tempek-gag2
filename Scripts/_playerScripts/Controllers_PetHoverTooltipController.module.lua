-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 11
};
local l__GuiService__1 = game:GetService("GuiService");
local l__Players__2 = game:GetService("Players");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Workspace__6 = game:GetService("Workspace");
local l__PetData__7 = require(l__ReplicatedStorage__3.SharedData.PetData);
local l__PetTypes__8 = require(l__ReplicatedStorage__3.SharedData.PetTypes);
local l__RarityVisuals__9 = require(l__ReplicatedStorage__3.SharedModules.RarityVisuals);
local l__AnimatedGradient__10 = require(l__ReplicatedStorage__3.SharedModules.AnimatedGradient);
local l__LocalPlayer__11 = l__Players__2.LocalPlayer;
local l__PlayerGui__12 = l__LocalPlayer__11:WaitForChild("PlayerGui");
local u2 = Color3.new(1, 1, 1);
local u3 = Color3.fromRGB(0, 0, 0);
local u4 = Vector2.new(260, 44);
local u5 = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
local u6 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(140, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 200))
});
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = 0;
local u14 = 0;
local u15 = 0;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local function u37(p21, p22, p23, p24) --[[ Line: 106 ]]
    local v25 = p23:PointToObjectSpace(p21);
    local v26 = p23:VectorToObjectSpace(p22);
    local v27 = p24 * 0.5;
    local v28 = { v25.X, v25.Y, v25.Z };
    local v29 = { v26.X, v26.Y, v26.Z };
    local v30 = { v27.X, v27.Y, v27.Z };
    local v31 = (-1 / 0);
    local v32 = (1 / 0);
    for v33 = 1, 3 do
        if math.abs(v29[v33]) < 1e-6 then
            if v28[v33] < -v30[v33] or v28[v33] > v30[v33] then
                return nil;
            end;
        else
            local v34 = (-v30[v33] - v28[v33]) / v29[v33];
            local v35 = (v30[v33] - v28[v33]) / v29[v33];
            if v35 >= v34 then
                local v36 = v34;
                v34 = v35;
                v35 = v36;
            end;
            if v31 >= v35 then
                v35 = v31;
            end;
            if v34 >= v32 then
                v34 = v32;
            end;
            if v34 < v35 then
                return nil;
            end;
            v32 = v34;
            v31 = v35;
        end;
    end;
    if v32 < 0 then
        return nil;
    else
        return math.max(v31, 0);
    end;
end;
local function u48(p38, p39) --[[ Line: 135 ]]
    -- upvalues: l__Workspace__6 (copy), u18 (ref), u19 (ref), u37 (copy)
    local l__CurrentCamera__13 = l__Workspace__6.CurrentCamera;
    if not l__CurrentCamera__13 then
        return nil;
    end;
    local v40 = l__CurrentCamera__13:ViewportPointToRay(p38, p39);
    local l__Origin__14 = v40.Origin;
    local l__Direction__15 = v40.Direction;
    local v41 = 1000;
    local v42 = nil;
    for _, v43 in { u18, u19 } do
        if v43 then
            for _, v44 in v43:GetChildren() do
                if v44:IsA("Model") then
                    local v45, v46 = v44:GetBoundingBox();
                    local v47 = u37(l__Origin__14, l__Direction__15, v45, v46);
                    if v47 and v47 < v41 then
                        v42 = v44;
                        v41 = v47;
                    end;
                end;
            end;
        end;
    end;
    return v42;
end;
local function u61(p49) --[[ Line: 162 ]]
    -- upvalues: u18 (ref), u19 (ref), l__Workspace__6 (copy)
    local l__Parent__16 = p49.Parent;
    if l__Parent__16 == u18 then
        local v50 = p49:GetAttribute("PetName");
        if type(v50) ~= "string" or v50 == "" then
            v50 = nil;
        end;
        if not v50 then
            return nil;
        end;
        local v51 = {
            Species = v50
        };
        local v52 = p49:GetAttribute("PetSize");
        if type(v52) ~= "string" or v52 == "" then
            v52 = nil;
        end;
        v51.Size = v52;
        local v53 = p49:GetAttribute("PetType");
        if type(v53) ~= "string" or v53 == "" then
            v53 = nil;
        end;
        v51.Type = v53;
        return v51;
    end;
    if l__Parent__16 ~= u19 then
        return nil;
    end;
    local v54 = p49:GetAttribute("Owner");
    if type(v54) ~= "string" or v54 == "" then
        v54 = nil;
    end;
    local v55 = p49:GetAttribute("OwnerSlot");
    if type(v55) ~= "string" or v55 == "" then
        v55 = nil;
    end;
    if not (v54 and v55) then
        return nil;
    end;
    local v56 = l__Workspace__6:FindFirstChild("PlayerPetReferences");
    if v56 then
        v56 = v56:FindFirstChild(v54);
    end;
    if v56 then
        v56 = v56:FindFirstChild(v55);
    end;
    if not v56 then
        return nil;
    end;
    local v57 = v56:GetAttribute("PetSpecies");
    if type(v57) ~= "string" or v57 == "" then
        v57 = nil;
    end;
    if not v57 then
        return nil;
    end;
    local v58 = {
        Species = v57
    };
    local v59 = v56:GetAttribute("PetSize");
    if type(v59) ~= "string" or v59 == "" then
        v59 = nil;
    end;
    v58.Size = v59;
    local v60 = v56:GetAttribute("PetType");
    if type(v60) ~= "string" or v60 == "" then
        v60 = nil;
    end;
    v58.Type = v60;
    return v58;
end;
local function u67(p62) --[[ Line: 211 ]]
    -- upvalues: u9 (ref), u16 (ref), l__AnimatedGradient__10 (copy), l__PetData__7 (copy), l__PetTypes__8 (copy), u2 (copy), u6 (copy), l__RarityVisuals__9 (copy)
    if u9 then
        if u16 then
            u16();
            u16 = nil;
        end;
        local v63 = u9 and u9:FindFirstChildOfClass("UIGradient");
        if v63 then
            l__AnimatedGradient__10:Remove(v63);
            v63:Destroy();
        end;
        u9.Text = l__PetData__7.GetDisplayName(p62.Species, p62.Size);
        if p62.Type == l__PetTypes__8.Rainbow then
            u9.TextColor3 = u2;
            local v64 = Instance.new("UIGradient");
            v64.Color = u6;
            v64.Parent = u9;
            l__AnimatedGradient__10:Add(v64);
        else
            local v65 = l__PetData__7[p62.Species];
            local v66 = (not v65 or type(v65.Rarity) ~= "string") and "Common" or v65.Rarity;
            u16 = l__RarityVisuals__9.ApplyToLabels({ u9 }, v66);
        end;
    end;
end;
local function u75(u68) --[[ Line: 258 ]]
    -- upvalues: u12 (ref), u15 (ref), u61 (copy), u9 (ref), u16 (ref), l__AnimatedGradient__10 (copy), u67 (copy), u17 (ref)
    if u68 then
        if u68 == u12 then
            if u15 == 0 then
                u15 = 1;
            end;
        elseif u12 then
            u12 = u68;
            local v69 = u61(u68);
            if v69 then
                u67(v69);
            else
                if u9 then
                    u9.Text = "?";
                end;
                if u16 then
                    u16();
                    u16 = nil;
                end;
                local v70 = u9 and u9:FindFirstChildOfClass("UIGradient");
                if v70 then
                    l__AnimatedGradient__10:Remove(v70);
                    v70:Destroy();
                end;
            end;
            if u17 then
                u17:Disconnect();
                u17 = nil;
            end;
            u17 = u68.AncestryChanged:Connect(function(_, p71) --[[ Line: 241 ]]
                -- upvalues: u12 (ref), u68 (copy), u15 (ref)
                if u12 == u68 and not p71 then
                    u15 = 0;
                end;
            end);
        else
            u12 = u68;
            local v72 = u61(u68);
            if v72 then
                u67(v72);
            else
                if u9 then
                    u9.Text = "?";
                end;
                if u16 then
                    u16();
                    u16 = nil;
                end;
                local v73 = u9 and u9:FindFirstChildOfClass("UIGradient");
                if v73 then
                    l__AnimatedGradient__10:Remove(v73);
                    v73:Destroy();
                end;
            end;
            if u17 then
                u17:Disconnect();
                u17 = nil;
            end;
            u17 = u68.AncestryChanged:Connect(function(_, p74) --[[ Line: 241 ]]
                -- upvalues: u12 (ref), u68 (copy), u15 (ref)
                if u12 == u68 and not p74 then
                    u15 = 0;
                end;
            end);
            u15 = 1;
        end;
    else
        if u12 then
            u15 = 0;
        end;
    end;
end;
local function u95(p76) --[[ Line: 281 ]]
    -- upvalues: u13 (ref), l__Workspace__6 (copy), u18 (ref), u19 (ref), u11 (ref), l__GuiService__1 (copy), l__UserInputService__5 (copy), u75 (copy), u48 (copy), u8 (ref), u9 (ref), u10 (ref), u14 (ref), u15 (ref), u12 (ref), u17 (ref), u16 (ref), l__AnimatedGradient__10 (copy), u4 (copy)
    u13 = u13 + p76;
    if u13 >= 0.1 then
        u13 = 0;
        local v77 = l__Workspace__6:FindFirstChild("Map");
        local v78;
        if v77 then
            v78 = v77:FindFirstChild("WildPetSpawns");
        else
            v78 = nil;
        end;
        u18 = v78;
        local v79 = l__Workspace__6:FindFirstChild("_PetVisualClient");
        local v80;
        if v79 then
            v80 = v79:FindFirstChild("Models");
        else
            v80 = nil;
        end;
        u19 = v80;
        local v81 = u11;
        local v82;
        if v81 then
            local v83 = l__GuiService__1:GetGuiInset();
            v82 = Vector2.new(v81.Position.X + v83.X, v81.Position.Y + v83.Y);
        elseif l__UserInputService__5.MouseEnabled then
            v82 = l__UserInputService__5:GetMouseLocation();
        else
            v82 = nil;
        end;
        local v84 = u75;
        local v85;
        if v82 then
            v85 = u48(v82.X, v82.Y);
        else
            v85 = nil;
        end;
        v84(v85);
    end;
    if u8 and (u9 and u10) then
        local v86 = p76 / 0.1;
        if u14 < u15 then
            u14 = math.min(u15, u14 + v86);
        elseif u15 < u14 then
            u14 = math.max(u15, u14 - v86);
        end;
        local v87 = 1 - u14;
        u9.TextTransparency = v87;
        u10.Transparency = v87;
        u8.Visible = u14 > 0;
        if u14 == 0 and (u15 == 0 and u12) then
            u12 = nil;
            if u17 then
                u17:Disconnect();
                u17 = nil;
            end;
            if u16 then
                u16();
                u16 = nil;
            end;
            local v88 = u9 and u9:FindFirstChildOfClass("UIGradient");
            if v88 then
                l__AnimatedGradient__10:Remove(v88);
                v88:Destroy();
            end;
        else
            if u12 and u14 > 0 then
                local l__CurrentCamera__17 = l__Workspace__6.CurrentCamera;
                local v89 = u11;
                local v90;
                if v89 then
                    local v91 = l__GuiService__1:GetGuiInset();
                    v90 = Vector2.new(v89.Position.X + v91.X, v89.Position.Y + v91.Y);
                elseif l__UserInputService__5.MouseEnabled then
                    v90 = l__UserInputService__5:GetMouseLocation();
                else
                    v90 = nil;
                end;
                if l__CurrentCamera__17 and v90 then
                    local l__ViewportSize__18 = l__CurrentCamera__17.ViewportSize;
                    local v92 = u11 and 42 or 28;
                    local v93 = math.min(u9.TextBounds.X, u4.X);
                    local v94 = v93 / 2;
                    if v90.X + v92 + v93 <= l__ViewportSize__18.X then
                        u8.AnchorPoint = Vector2.new(0.5, 0.5);
                        u8.Position = UDim2.fromOffset(v90.X + v92 + v94, v90.Y);
                        return;
                    end;
                    u8.AnchorPoint = Vector2.new(0.5, 0.5);
                    u8.Position = UDim2.fromOffset(v90.X - v92 - v94, v90.Y);
                end;
            end;
        end;
    end;
end;
local function u102() --[[ Line: 334 ]]
    -- upvalues: l__PlayerGui__12 (copy), u7 (ref), u4 (copy), u8 (ref), u5 (copy), u9 (ref), u3 (copy), u10 (ref)
    local v96 = Instance.new("ScreenGui");
    v96.Name = "PetHoverTooltip";
    v96.DisplayOrder = -1;
    v96.IgnoreGuiInset = true;
    v96.ResetOnSpawn = false;
    v96.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v96.Enabled = true;
    v96.Parent = l__PlayerGui__12;
    u7 = v96;
    local v97 = Instance.new("Frame");
    v97.Name = "Frame";
    v97.AnchorPoint = Vector2.new(0, 0.5);
    v97.BackgroundTransparency = 1;
    v97.BorderSizePixel = 0;
    v97.Size = UDim2.fromOffset(u4.X, u4.Y);
    v97.Position = UDim2.fromOffset(0, 0);
    v97.Visible = false;
    v97.Parent = v96;
    u8 = v97;
    local v98 = Instance.new("UIListLayout");
    v98.FillDirection = Enum.FillDirection.Vertical;
    v98.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v98.VerticalAlignment = Enum.VerticalAlignment.Center;
    v98.SortOrder = Enum.SortOrder.LayoutOrder;
    v98.Parent = v97;
    local v99 = Instance.new("TextLabel");
    v99.Name = "Name";
    v99.BackgroundTransparency = 1;
    v99.BorderSizePixel = 0;
    v99.FontFace = u5;
    v99.Size = UDim2.new(1, 0, 1, 0);
    v99.Text = "";
    v99.TextColor3 = Color3.new(1, 1, 1);
    v99.TextScaled = true;
    v99.TextSize = 24;
    v99.TextTransparency = 1;
    v99.TextWrapped = true;
    v99.TextXAlignment = Enum.TextXAlignment.Center;
    v99.TextYAlignment = Enum.TextYAlignment.Center;
    v99.Parent = v97;
    u9 = v99;
    local v100 = Instance.new("UIStroke");
    v100.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    v100.Color = u3;
    v100.LineJoinMode = Enum.LineJoinMode.Round;
    v100.Thickness = 2;
    v100.Transparency = 1;
    v100.Parent = v99;
    u10 = v100;
    local v101 = Instance.new("UIGradient");
    v101.Color = ColorSequence.new(u3);
    v101.Parent = v100;
end;
function v1.Start(_) --[[ Line: 394 ]]
    -- upvalues: u102 (copy), u20 (ref), l__LocalPlayer__11 (copy), l__Workspace__6 (copy), u18 (ref), u19 (ref), u48 (copy), u61 (copy), l__UserInputService__5 (copy), u11 (ref), l__GuiService__1 (copy), l__RunService__4 (copy), u95 (copy)
    u102();
    local v103, v104 = pcall(function() --[[ Line: 399 ]]
        return require(script.Parent.PetListController);
    end);
    if v103 then
        u20 = v104;
    end;
    local function u113(p105, p106) --[[ Line: 409 ]]
        -- upvalues: u20 (ref), l__LocalPlayer__11 (ref), l__Workspace__6 (ref), u18 (ref), u19 (ref), u48 (ref), u61 (ref)
        if not (u20 and u20.ShowPetInfo) then
            return false;
        end;
        if l__LocalPlayer__11:GetAttribute("IsInOwnGarden") ~= true then
            return false;
        end;
        local l__Character__19 = l__LocalPlayer__11.Character;
        if l__Character__19 and l__Character__19:FindFirstChildWhichIsA("Tool") then
            return false;
        end;
        local v107 = l__Workspace__6:FindFirstChild("Map");
        local v108;
        if v107 then
            v108 = v107:FindFirstChild("WildPetSpawns");
        else
            v108 = nil;
        end;
        u18 = v108;
        local v109 = l__Workspace__6:FindFirstChild("_PetVisualClient");
        local v110;
        if v109 then
            v110 = v109:FindFirstChild("Models");
        else
            v110 = nil;
        end;
        u19 = v110;
        local v111 = u48(p105, p106);
        if not v111 then
            return false;
        end;
        if v111.Parent ~= u19 then
            return false;
        end;
        if v111:GetAttribute("Owner") ~= l__LocalPlayer__11.Name then
            return false;
        end;
        local v112 = u61(v111);
        if not v112 then
            return false;
        end;
        u20:ShowPetInfo(v112.Species, v112.Size, v112.Type);
        return true;
    end;
    l__UserInputService__5.InputBegan:Connect(function(p114, p115) --[[ Line: 431 ]]
        -- upvalues: l__UserInputService__5 (ref), u113 (copy)
        if p115 then
        elseif p114.UserInputType == Enum.UserInputType.MouseButton1 then
            local v116 = l__UserInputService__5:GetMouseLocation();
            u113(v116.X, v116.Y);
        end;
    end);
    l__UserInputService__5.TouchStarted:Connect(function(p117, p118) --[[ Line: 442 ]]
        -- upvalues: u11 (ref)
        if p118 then
        else
            if u11 == nil then
                u11 = p117;
            end;
        end;
    end);
    l__UserInputService__5.TouchEnded:Connect(function(p119) --[[ Line: 448 ]]
        -- upvalues: u11 (ref)
        if p119 == u11 then
            u11 = nil;
        end;
    end);
    l__UserInputService__5.TouchTapInWorld:Connect(function(p120, p121) --[[ Line: 458 ]]
        -- upvalues: l__GuiService__1 (ref), u113 (copy)
        if p121 then
        else
            local v122 = l__GuiService__1:GetGuiInset();
            u113(p120.X + v122.X, p120.Y + v122.Y);
        end;
    end);
    l__RunService__4:BindToRenderStep("PetHoverTooltip", Enum.RenderPriority.Camera.Value - 1, u95);
end;
return v1;