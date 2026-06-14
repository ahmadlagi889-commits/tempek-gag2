-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 10
};
local l__GuiService__1 = game:GetService("GuiService");
local l__Players__2 = game:GetService("Players");
local l__ProximityPromptService__3 = game:GetService("ProximityPromptService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__RunService__5 = game:GetService("RunService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__Workspace__7 = game:GetService("Workspace");
local l__SharedModules__8 = l__ReplicatedStorage__4:WaitForChild("SharedModules");
local l__SeedData__9 = require(l__SharedModules__8:WaitForChild("SeedData"));
local l__RarityVisuals__10 = require(l__SharedModules__8:WaitForChild("RarityVisuals"));
local l__MutationData__11 = require(l__SharedModules__8:WaitForChild("MutationData"));
local l__WeightFormat__12 = require(l__SharedModules__8:WaitForChild("WeightFormat"));
local l__ScreenResolution__13 = require(l__ReplicatedStorage__4:WaitForChild("ClientModules"):WaitForChild("ScreenResolution"));
local l__PlayerGui__14 = l__Players__2.LocalPlayer:WaitForChild("PlayerGui");
local u2 = nil;
local u3 = nil;
local u4 = Color3.new(1, 1, 1);
local u5 = Color3.fromRGB(60, 220, 80);
local u6 = Color3.fromRGB(255, 255, 255);
local u7 = Color3.fromRGB(0, 0, 0);
local u8 = Vector2.new(220, 64);
local u9 = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
local l__Gardens__15 = l__Workspace__7:WaitForChild("Gardens");
local l__Fruits__16 = l__ReplicatedStorage__4:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits");
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = {};
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = 0;
local u23 = 0;
local u24 = 0;
local u25 = {};
local u26 = false;
local u27 = {};
local u28 = nil;
local u29 = 0;
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = 0;
local u35 = 0;
local u36 = 0;
local u37 = 0;
local u38 = 0;
local u39 = 0;
local function u48(p40) --[[ Line: 214 ]]
    if p40 <= 0 then
        return "";
    elseif p40 < 60 then
        if p40 == math.floor(p40) then
            return string.format("%ds", p40);
        else
            return string.format("%.1fs", p40);
        end;
    else
        local v41 = {
            { "y", 31104000 },
            { "mo", 2592000 },
            { "w", 604800 },
            { "d", 86400 },
            { "h", 3600 },
            { "m", 60 },
            { "s", 1 }
        };
        for v42 = 1, #v41 - 1 do
            local v43 = v41[v42][1];
            local v44 = v41[v42][2];
            if v44 <= p40 then
                local v45 = math.floor(p40 / v44);
                local v46 = v41[v42 + 1][1];
                local v47 = math.floor((p40 - v45 * v44) / v41[v42 + 1][2]);
                return string.format("%d%s %d%s", v45, v43, v47, v46);
            end;
        end;
        return string.format("%dm %ds", math.floor(p40 / 60), (math.floor(p40 % 60)));
    end;
end;
local u49 = {
    Fruits = true,
    FruitSpawnLocations = true
};
local function u57(p50) --[[ Line: 283 ]]
    -- upvalues: u49 (copy)
    local v51 = p50:GetAttribute("Height");
    if v51 then
        return v51;
    end;
    local v52 = (-1 / 0);
    local v53 = (1 / 0);
    for _, v54 in p50:GetDescendants() do
        if v54:IsA("BasePart") then
            local l__Parent__17 = v54.Parent;
            local v55;
            while true do
                if not l__Parent__17 or l__Parent__17 == p50 then
                    v55 = false;
                    break;
                end;
                if u49[l__Parent__17.Name] then
                    v55 = true;
                    break;
                end;
                l__Parent__17 = l__Parent__17.Parent;
            end;
            if not v55 then
                local l__Position__18 = (v54.CFrame * CFrame.new(0, v54.Size.Y / 2, 0)).Position;
                if v52 < l__Position__18.Y then
                    v52 = l__Position__18.Y;
                end;
                local l__Y__19 = (v54.CFrame * CFrame.new(0, -v54.Size.Y / 2, 0)).Position.Y;
                if l__Y__19 < v53 then
                    v53 = l__Y__19;
                end;
            end;
        end;
    end;
    if v52 == (-1 / 0) then
        return nil;
    end;
    local v56 = math.round(v52 - v53);
    p50:SetAttribute("Height", v56);
    return v56;
end;
local function u61() --[[ Line: 315 ]]
    -- upvalues: l__Gardens__15 (copy)
    local v58 = {};
    if not l__Gardens__15 then
        return v58;
    end;
    for _, v59 in l__Gardens__15:GetChildren() do
        if v59:IsA("Model") then
            local v60 = v59:FindFirstChild("Plants");
            if v60 and v60:IsA("Folder") then
                table.insert(v58, v60);
            end;
        end;
    end;
    return v58;
end;
local function u65() --[[ Line: 328 ]]
    -- upvalues: u28 (ref), u29 (ref), u61 (copy), u27 (ref)
    local v62 = os.clock();
    if u28 and v62 - u29 < 1 then
    else
        u29 = v62;
        local v63 = u61();
        u27 = v63;
        local v64 = RaycastParams.new();
        v64.FilterType = Enum.RaycastFilterType.Include;
        v64.FilterDescendantsInstances = v63;
        u28 = v64;
        if #v63 == 0 then
            u29 = 0;
        end;
    end;
end;
local function u75() --[[ Line: 354 ]]
    -- upvalues: u28 (ref), l__Workspace__7 (copy), u19 (ref), l__GuiService__1 (copy), l__UserInputService__6 (copy)
    local v66 = u28;
    if not v66 then
        return nil, nil;
    end;
    local l__CurrentCamera__20 = l__Workspace__7.CurrentCamera;
    if not l__CurrentCamera__20 then
        return nil, nil;
    end;
    local v67 = u19;
    local v68;
    if v67 then
        local v69 = l__GuiService__1:GetGuiInset();
        v68 = Vector2.new(v67.Position.X + v69.X, v67.Position.Y + v69.Y);
    elseif l__UserInputService__6.MouseEnabled then
        v68 = l__UserInputService__6:GetMouseLocation();
    else
        v68 = nil;
    end;
    if not v68 then
        return nil, nil;
    end;
    local v70 = l__CurrentCamera__20:ViewportPointToRay(v68.X, v68.Y);
    local l__Origin__21 = v70.Origin;
    local v71 = 1000;
    local v72 = nil;
    while v71 > 0 do
        v72 = l__Workspace__7:Raycast(l__Origin__21, v70.Direction * v71, v66);
        if not v72 then
            return nil, nil;
        end;
        local l__Instance__22 = v72.Instance;
        if l__Instance__22 and (l__Instance__22:IsA("BasePart") and l__Instance__22.Transparency < 1) then
            break;
        end;
        local v73 = (v72.Position - l__Origin__21).Magnitude + 0.01;
        l__Origin__21 = l__Origin__21 + v70.Direction * v73;
        v71 = v71 - v73;
        v72 = nil;
    end;
    if not v72 then
        return nil, nil;
    end;
    local l__Instance__23 = v72.Instance;
    local v74 = nil;
    while l__Instance__23 do
        local l__Parent__24 = l__Instance__23.Parent;
        if l__Instance__23:IsA("Model") and (l__Parent__24 and l__Parent__24:IsA("Folder")) then
            if l__Parent__24.Name == "Fruits" and not v74 then
                v74 = l__Instance__23;
            elseif l__Parent__24.Name == "Plants" then
                return l__Instance__23, v74;
            end;
        end;
        l__Instance__23 = l__Parent__24;
    end;
    return nil, nil;
end;
local function u83(p76) --[[ Line: 419 ]]
    -- upvalues: u12 (ref), u32 (ref), u18 (copy), l__MutationData__11 (copy), u4 (copy), l__RarityVisuals__10 (copy)
    if u12 then
        if u32 then
            u32();
            u32 = nil;
        end;
        local v77 = p76:GetAttribute("SeedName");
        if type(v77) ~= "string" then
            v77 = nil;
        end;
        local v78;
        if v77 then
            v78 = u18[v77];
        else
            v78 = nil;
        end;
        local v79 = (not v78 or type(v78.Rarity) ~= "string") and "Common" or v78.Rarity;
        local v80 = p76:GetAttribute("Mutation");
        u12.Text = v77 or "?";
        local v81 = u12:FindFirstChildOfClass("UIGradient");
        if v81 then
            v81:Destroy();
        end;
        if type(v80) == "string" and v80 ~= "" then
            local v82 = l__MutationData__11.GetMutation(v80);
            if v82 and v82.Gradient then
                u12.TextColor3 = u4;
                v82.Gradient:Clone().Parent = u12;
                return;
            end;
        end;
        u32 = l__RarityVisuals__10.ApplyToLabels({ u12 }, v79);
    end;
end;
local function u86(u84) --[[ Line: 471 ]]
    -- upvalues: u30 (ref), u31 (ref), u20 (ref), u83 (copy), u24 (ref)
    if u30 then
        u30:Disconnect();
        u30 = nil;
    end;
    if u31 then
        u31:Disconnect();
        u31 = nil;
    end;
    u30 = u84:GetAttributeChangedSignal("Mutation"):Connect(function() --[[ Line: 477 ]]
        -- upvalues: u20 (ref), u84 (copy), u83 (ref)
        if u20 == u84 then
            u83(u84);
        end;
    end);
    u31 = u84.AncestryChanged:Connect(function(_, p85) --[[ Line: 485 ]]
        -- upvalues: u20 (ref), u84 (copy), u24 (ref)
        if u20 == u84 and not p85 then
            u24 = 0;
        end;
    end);
end;
local function u88(p87) --[[ Line: 492 ]]
    -- upvalues: u20 (ref), u24 (ref), u83 (copy), u86 (copy)
    if p87 then
        if p87 == u20 then
            if u24 == 0 then
                u24 = 1;
            end;
        elseif u20 then
            u20 = p87;
            u83(p87);
            u86(p87);
        else
            u20 = p87;
            u83(p87);
            u86(p87);
            u24 = 1;
        end;
    else
        if u20 then
            u24 = 0;
        end;
    end;
end;
local function u99() --[[ Line: 530 ]]
    -- upvalues: u25 (copy), l__Workspace__7 (copy), l__ScreenResolution__13 (copy), u19 (ref), l__GuiService__1 (copy), l__UserInputService__6 (copy)
    if next(u25) == nil then
        return false;
    end;
    local l__CurrentCamera__25 = l__Workspace__7.CurrentCamera;
    if not l__CurrentCamera__25 then
        return false;
    end;
    local v89 = 150 * l__ScreenResolution__13.GetResolutionScale();
    local v90 = v89 * v89;
    local v91 = u19;
    local v92;
    if v91 then
        local v93 = l__GuiService__1:GetGuiInset();
        v92 = Vector2.new(v91.Position.X + v93.X, v91.Position.Y + v93.Y);
    elseif l__UserInputService__6.MouseEnabled then
        v92 = l__UserInputService__6:GetMouseLocation();
    else
        v92 = nil;
    end;
    if not v92 then
        return false;
    end;
    for v94 in u25 do
        local l__Parent__26 = v94.Parent;
        if l__Parent__26 and l__Parent__26:IsA("BasePart") then
            local v95, v96 = l__CurrentCamera__25:WorldToViewportPoint(l__Parent__26.Position);
            if v96 then
                local v97 = v92.X - v95.X;
                local v98 = v92.Y - v95.Y;
                if v97 * v97 + v98 * v98 <= v90 then
                    return true;
                end;
            end;
        end;
    end;
    return false;
end;
local function u126(p100) --[[ Line: 566 ]]
    -- upvalues: u22 (ref), u65 (copy), u75 (copy), u21 (ref), u88 (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u26 (ref), u99 (copy), u24 (ref), u23 (ref), u20 (ref), u30 (ref), u31 (ref), u32 (ref), u33 (ref), u2 (ref), u3 (ref), l__WeightFormat__12 (copy), u38 (ref), u39 (ref), u34 (ref), u35 (ref), u36 (ref), u37 (ref), u48 (copy), l__Fruits__16 (copy), u57 (copy), l__Workspace__7 (copy), u19 (ref), l__GuiService__1 (copy), l__UserInputService__6 (copy), u8 (copy)
    u22 = u22 + p100;
    if u22 >= 0.1 then
        u22 = 0;
        u65();
        local v101, v102 = u75();
        if v101 then
            u21 = v102;
        end;
        u88(v101);
    end;
    if u11 and (u12 and (u13 and (u14 and (u15 and (u16 and u17))))) then
        u26 = u99();
        local v103 = u26 and 0 or u24;
        local v104 = p100 / 0.1;
        if u23 < v103 then
            u23 = math.min(v103, u23 + v104);
        elseif v103 < u23 then
            u23 = math.max(v103, u23 - v104);
        end;
        local v105 = 1 - u23;
        u12.TextTransparency = v105;
        u13.Transparency = v105;
        u14.TextTransparency = v105;
        u15.Transparency = v105;
        u16.TextTransparency = v105;
        u17.Transparency = v105;
        u11.Visible = u23 > 0;
        if u23 == 0 and (u24 == 0 and u20) then
            u20 = nil;
            u21 = nil;
            if u30 then
                u30:Disconnect();
                u30 = nil;
            end;
            if u31 then
                u31:Disconnect();
                u31 = nil;
            end;
            if u32 then
                u32();
                u32 = nil;
            end;
            local v106 = u12 and u12:FindFirstChildOfClass("UIGradient");
            if v106 then
                v106:Destroy();
            end;
            u33 = nil;
            u14.Text = "";
            u16.Text = "";
        else
            if u20 and u23 > 0 then
                local v107 = u20:GetAttribute("UserId");
                local v108 = u20:GetAttribute("PlantId");
                local v109;
                if u2 and (type(v107) == "number" and type(v108) == "string") then
                    v109 = u2:GetPlantGrowthData(v107, v108);
                else
                    v109 = nil;
                end;
                if u21 then
                    u14.Text = "";
                    u14.Visible = false;
                    local v110 = u3:CalculateFruitWeight(u21);
                    u16.Text = not v110 and "⚖️ ?" or `⚖️ {l__WeightFormat__12.FormatGrams(v110)}`;
                    u16.Visible = true;
                    u33 = nil;
                elseif v109 and (type(v109.MaxAge) == "number" and (type(v109.CurrentAge) == "number" and (type(v109.StableGrowthAmount) == "number" and (v109.StableGrowthAmount > 0 and v109.CurrentAge < v109.MaxAge)))) then
                    if u33 ~= u20 or (v109.CurrentAge ~= u38 or v109.StableGrowthAmount ~= u39) then
                        u33 = u20;
                        u34 = v109.CurrentAge;
                        u35 = v109.MaxAge;
                        u36 = v109.StableGrowthAmount;
                        u37 = os.clock();
                        u38 = v109.CurrentAge;
                        u39 = v109.StableGrowthAmount;
                    end;
                    local v111 = u34 + (os.clock() - u37) * u36;
                    u14.Text = u48((u35 - math.min(v111, u35)) / u36);
                    u14.Visible = true;
                    u16.Visible = false;
                else
                    u14.Text = "";
                    u14.Visible = false;
                    local v112 = nil;
                    local v113 = u20:GetAttribute("SeedName");
                    local v114;
                    if type(v113) == "string" then
                        v114 = l__Fruits__16:FindFirstChild(v113) == nil;
                    else
                        v114 = false;
                    end;
                    if v114 then
                        local v115 = u3:CalculatePlantWeight(u20);
                        if type(v115) == "number" then
                            v112 = `⚖️ {l__WeightFormat__12.FormatGrams(v115)}`;
                        end;
                    end;
                    if not v112 then
                        local v116 = u57(u20);
                        v112 = not v116 and "📏 10ft" or `📏 {math.round(v116)}ft`;
                    end;
                    u16.Text = v112;
                    u16.Visible = true;
                    u33 = nil;
                end;
                local l__CurrentCamera__27 = l__Workspace__7.CurrentCamera;
                local v117 = u19;
                local v118;
                if v117 then
                    local v119 = l__GuiService__1:GetGuiInset();
                    v118 = Vector2.new(v117.Position.X + v119.X, v117.Position.Y + v119.Y);
                elseif l__UserInputService__6.MouseEnabled then
                    v118 = l__UserInputService__6:GetMouseLocation();
                else
                    v118 = nil;
                end;
                if l__CurrentCamera__27 and v118 then
                    local l__ViewportSize__28 = l__CurrentCamera__27.ViewportSize;
                    local v120 = math.min(u12.TextBounds.X, u8.X);
                    local v121;
                    if u14.Visible then
                        v121 = u14;
                    else
                        v121 = u16;
                    end;
                    local v122 = math.min(v121.TextBounds.X, u8.X);
                    local v123 = math.max(v120, v122);
                    local v124 = v123 / 2;
                    local v125 = u19 and 42 or 28;
                    if v118.X + v125 + v123 <= l__ViewportSize__28.X then
                        u11.AnchorPoint = Vector2.new(0.5, 0.5);
                        u11.Position = UDim2.fromOffset(v118.X + v125 + v124, v118.Y);
                        return;
                    end;
                    u11.AnchorPoint = Vector2.new(0.5, 0.5);
                    u11.Position = UDim2.fromOffset(v118.X - v125 - v124, v118.Y);
                end;
            end;
        end;
    end;
end;
local function u137() --[[ Line: 782 ]]
    -- upvalues: l__PlayerGui__14 (copy), u10 (ref), u8 (copy), u11 (ref), u9 (copy), u12 (ref), u7 (copy), u13 (ref), u5 (copy), u14 (ref), u15 (ref), u6 (copy), u16 (ref), u17 (ref)
    local v127 = Instance.new("ScreenGui");
    v127.Name = "PlantHoverTooltip";
    v127.DisplayOrder = -1;
    v127.IgnoreGuiInset = true;
    v127.ResetOnSpawn = false;
    v127.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v127.Enabled = true;
    v127.Parent = l__PlayerGui__14;
    u10 = v127;
    local v128 = Instance.new("Frame");
    v128.Name = "Frame";
    v128.AnchorPoint = Vector2.new(0, 0.5);
    v128.BackgroundTransparency = 1;
    v128.BorderSizePixel = 0;
    v128.Size = UDim2.fromOffset(u8.X, u8.Y);
    v128.Position = UDim2.fromOffset(0, 0);
    v128.Visible = false;
    v128.Parent = v127;
    u11 = v128;
    local v129 = Instance.new("UIListLayout");
    v129.FillDirection = Enum.FillDirection.Vertical;
    v129.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v129.VerticalAlignment = Enum.VerticalAlignment.Center;
    v129.Padding = UDim.new(0, 2);
    v129.SortOrder = Enum.SortOrder.LayoutOrder;
    v129.Parent = v128;
    local v130 = Instance.new("TextLabel");
    v130.Name = "Name";
    v130.BackgroundTransparency = 1;
    v130.BorderSizePixel = 0;
    v130.FontFace = u9;
    v130.LayoutOrder = 1;
    v130.Size = UDim2.new(1, 0, 0.55, 0);
    v130.Text = "";
    v130.TextColor3 = Color3.new(1, 1, 1);
    v130.TextScaled = true;
    v130.TextSize = 24;
    v130.TextTransparency = 1;
    v130.TextWrapped = true;
    v130.TextXAlignment = Enum.TextXAlignment.Center;
    v130.TextYAlignment = Enum.TextYAlignment.Center;
    v130.Parent = v128;
    u12 = v130;
    local v131 = Instance.new("UIStroke");
    v131.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    v131.Color = u7;
    v131.LineJoinMode = Enum.LineJoinMode.Round;
    v131.Thickness = 2;
    v131.Transparency = 1;
    v131.Parent = v130;
    u13 = v131;
    local v132 = Instance.new("UIGradient");
    v132.Color = ColorSequence.new(u7);
    v132.Parent = v131;
    local v133 = Instance.new("TextLabel");
    v133.Name = "Timer";
    v133.BackgroundTransparency = 1;
    v133.BorderSizePixel = 0;
    v133.FontFace = u9;
    v133.LayoutOrder = 2;
    v133.Size = UDim2.new(1, 0, 0.4, 0);
    v133.Text = "";
    v133.TextColor3 = u5;
    v133.TextScaled = true;
    v133.TextSize = 20;
    v133.TextTransparency = 1;
    v133.TextWrapped = true;
    v133.TextXAlignment = Enum.TextXAlignment.Center;
    v133.TextYAlignment = Enum.TextYAlignment.Center;
    v133.Parent = v128;
    u14 = v133;
    local v134 = Instance.new("UIStroke");
    v134.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    v134.Color = u7;
    v134.LineJoinMode = Enum.LineJoinMode.Round;
    v134.Thickness = 2;
    v134.Transparency = 1;
    v134.Parent = v133;
    u15 = v134;
    local v135 = Instance.new("TextLabel");
    v135.Name = "Meters";
    v135.BackgroundTransparency = 1;
    v135.BorderSizePixel = 0;
    v135.FontFace = u9;
    v135.LayoutOrder = 2;
    v135.Size = UDim2.new(1, 0, 0.4, 0);
    v135.Text = "";
    v135.TextColor3 = u6;
    v135.TextScaled = true;
    v135.TextSize = 20;
    v135.TextTransparency = 1;
    v135.TextWrapped = true;
    v135.TextXAlignment = Enum.TextXAlignment.Center;
    v135.TextYAlignment = Enum.TextYAlignment.Center;
    v135.Visible = false;
    v135.Parent = v128;
    u16 = v135;
    local v136 = Instance.new("UIStroke");
    v136.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    v136.Color = u7;
    v136.LineJoinMode = Enum.LineJoinMode.Round;
    v136.Thickness = 2;
    v136.Transparency = 1;
    v136.Parent = v135;
    u17 = v136;
end;
function v1.Init(_) --[[ Line: 925 ]]
    -- upvalues: l__SeedData__9 (copy), u18 (copy)
    for _, v138 in l__SeedData__9 do
        if type(v138) == "table" and type(v138.SeedName) == "string" then
            u18[v138.SeedName] = v138;
        end;
    end;
end;
function v1.Start(_) --[[ Line: 936 ]]
    -- upvalues: u2 (ref), u3 (ref), u137 (copy), l__ProximityPromptService__3 (copy), u25 (copy), l__UserInputService__6 (copy), u19 (ref), l__RunService__5 (copy), u126 (copy)
    u2 = require(script.Parent.PlantVisualizerController);
    u3 = require(script.Parent.FruitVisualizerController);
    u137();
    l__ProximityPromptService__3.PromptShown:Connect(function(p139) --[[ Line: 949 ]]
        -- upvalues: u25 (ref)
        if p139:HasTag("HarvestPrompt") then
            u25[p139] = true;
        end;
    end);
    l__ProximityPromptService__3.PromptHidden:Connect(function(p140) --[[ Line: 954 ]]
        -- upvalues: u25 (ref)
        if p140:HasTag("HarvestPrompt") then
            u25[p140] = nil;
        end;
    end);
    l__UserInputService__6.TouchStarted:Connect(function(p141, p142) --[[ Line: 964 ]]
        -- upvalues: u19 (ref)
        if p142 then
        else
            if u19 == nil then
                u19 = p141;
            end;
        end;
    end);
    l__UserInputService__6.TouchEnded:Connect(function(p143) --[[ Line: 970 ]]
        -- upvalues: u19 (ref)
        if p143 == u19 then
            u19 = nil;
        end;
    end);
    l__RunService__5:BindToRenderStep("PlantHoverTooltip", Enum.RenderPriority.Camera.Value - 1, u126);
end;
return v1;