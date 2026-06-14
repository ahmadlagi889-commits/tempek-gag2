-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__TweenService__5 = game:GetService("TweenService");
local l__Networking__6 = require(l__ReplicatedStorage__4.SharedModules.Networking);
local l__RarityVisuals__7 = require(l__ReplicatedStorage__4.SharedModules.RarityVisuals);
local l__PerfFlags__8 = require(l__ReplicatedStorage__4.SharedModules.Flags.PerfFlags);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__PlayerGui__10 = l__LocalPlayer__9:WaitForChild("PlayerGui");
local l__Backspace__11 = Enum.KeyCode.Backspace;
local u2 = Color3.fromRGB(255, 60, 60);
local l__BillboardGui__12 = script.BillboardGui;
l__BillboardGui__12.Parent = nil;
local u3 = {
    Common = true,
    Uncommon = true,
    Rare = true,
    Epic = true,
    Legendary = true,
    Mythic = true,
    Super = true,
    Secret = true
};
local u4 = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold);
local u5 = {
    SeedTool = "Seeds",
    Sprinkler = "Sprinklers",
    WateringCan = "WateringCans",
    Mushroom = "Mushrooms",
    Gnome = "Gnomes",
    Raccoon = "Raccoons",
    Crate = "Crates",
    Teleporter = "Teleporters",
    SeedPack = "SeedPacks",
    Wheelbarrow = "Wheelbarrows",
    Trowel = "Trowels",
    Crowbar = "Crowbars",
    Ladder = "Ladders",
    FreezeRay = "FreezeRays",
    PowerHose = "PowerHoses",
    Rake = "Rakes",
    Lantern = "Lanterns",
    Sign = "Signs",
    EmptyPot = "EmptyPots",
    Flashbang = "Flashbangs",
    Bird = "Birds"
};
local u6 = {};
local u7 = nil;
local u8 = nil;
local u9 = {};
local function u16() --[[ Line: 115 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u5 (copy)
    local l__Character__13 = l__LocalPlayer__9.Character;
    if not l__Character__13 then
        return nil, nil;
    end;
    for _, v10 in l__Character__13:GetChildren() do
        if v10:IsA("Tool") then
            local v11 = v10:GetAttribute("HarvestedFruit") == true and v10:GetAttribute("Id");
            if v11 then
                return "HarvestedFruits", v11;
            end;
            local v12 = v10:GetAttribute("PetId");
            if type(v12) == "string" and v12 ~= "" then
                return "Pets", v12;
            end;
            for v13 in v10:GetAttributes() do
                local v14 = u5[v13];
                if v14 then
                    local v15 = v10:GetAttribute(v13);
                    if v15 then
                        return v14, v15;
                    end;
                end;
            end;
        end;
    end;
    return nil, nil;
end;
local function u21() --[[ Line: 148 ]]
    -- upvalues: u8 (ref), l__UserInputService__3 (copy), u16 (ref)
    if u8 then
        local l__TouchEnabled__14 = l__UserInputService__3.TouchEnabled;
        if l__TouchEnabled__14 then
            l__TouchEnabled__14 = not l__UserInputService__3.KeyboardEnabled;
        end;
        if l__TouchEnabled__14 then
            local v17, v18 = u16();
            local v19 = u8;
            local v20;
            if v17 == nil then
                v20 = false;
            else
                v20 = v18 ~= nil;
            end;
            v19.Visible = v20;
        else
            u8.Visible = false;
        end;
    end;
end;
local function u30(p22, p23) --[[ Line: 169 ]]
    local u24 = p22:FindFirstChild("Visual");
    local v25 = p23.Position.Y + p23.Size.Y * 0.5;
    if u24 and u24:IsA("Model") then
        local v26, v27, v28 = pcall(function() --[[ Line: 173 ]]
            -- upvalues: u24 (copy)
            return u24:GetBoundingBox();
        end);
        if v26 and (v27 and v28) then
            v25 = v27.Position.Y + v28.Y * 0.5;
        end;
    end;
    local v29 = math.max(v25 - p23.Position.Y + 2.5, 5);
    return Vector3.new(0, v29, 0);
end;
local function u36(p31, p32) --[[ Line: 182 ]]
    -- upvalues: u4 (copy), u2 (copy)
    local v33 = Instance.new("Frame");
    v33.Name = "TimerFrame";
    v33.AnchorPoint = Vector2.new(0.5, 0.5);
    v33.BackgroundTransparency = 1;
    v33.BorderSizePixel = 0;
    v33.LayoutOrder = 2;
    v33.Position = UDim2.new(0.5, 0, 0.5, 0);
    v33.Size = UDim2.new(1, 0, 0.3 / p32, 0);
    v33.Parent = p31;
    local v34 = Instance.new("TextLabel");
    v34.Name = "TimerText";
    v34.AnchorPoint = Vector2.new(0.5, 0.5);
    v34.BackgroundTransparency = 1;
    v34.BorderSizePixel = 0;
    v34.Position = UDim2.new(0.5, 0, 0.5, 0);
    v34.Size = UDim2.new(1, 0, 1, 0);
    v34.FontFace = u4;
    v34.Text = "";
    v34.TextColor3 = u2;
    v34.TextScaled = true;
    v34.TextWrapped = true;
    v34.ZIndex = 3;
    v34.Parent = v33;
    local v35 = Instance.new("UIStroke");
    v35.Color = Color3.new(0, 0, 0);
    v35.Thickness = 2;
    v35.Parent = v34;
    return v34;
end;
local function u55(p37, p38) --[[ Line: 216 ]]
    -- upvalues: u3 (copy), u30 (copy), l__BillboardGui__12 (copy), l__RarityVisuals__7 (copy), u36 (copy)
    local v39 = p37:GetAttribute("DisplayName");
    if not v39 or v39 == "" then
        return nil, nil;
    end;
    local v40 = p37:GetAttribute("Rarity");
    local v41;
    if v40 == nil then
        v41 = false;
    else
        v41 = u3[v40] == true;
    end;
    local l__Y__15 = u30(p37, p38).Y;
    local v42 = p37:GetAttribute("DropOffsetY") or 0;
    local v43 = p37:FindFirstChild("PromptAnchor") or p38;
    local v44 = v43 ~= p38;
    local v45 = l__BillboardGui__12:Clone();
    v45.Name = "ItemLabel";
    v45.Adornee = v43;
    local v46 = 1;
    local u47 = p37:FindFirstChild("Visual");
    if u47 and u47:IsA("Model") then
        local v48, _, v49 = pcall(function() --[[ Line: 235 ]]
            -- upvalues: u47 (copy)
            return u47:GetBoundingBox();
        end);
        if v48 and v49 then
            local v50 = math.max(v49.X, v49.Y, v49.Z) / 3;
            v46 = math.clamp(v50, 1, 4);
        end;
    end;
    local v51 = p37:GetAttribute("DespawnAt") ~= nil;
    local v52;
    if v51 then
        v52 = 1.3;
        local l__NameFrame__16 = v45.NameFrame;
        local l__RarityFrame__17 = v45.RarityFrame;
        l__NameFrame__16.Size = UDim2.new(l__NameFrame__16.Size.X.Scale, l__NameFrame__16.Size.X.Offset, l__NameFrame__16.Size.Y.Scale / v52, l__NameFrame__16.Size.Y.Offset);
        l__RarityFrame__17.Size = UDim2.new(l__RarityFrame__17.Size.X.Scale, l__RarityFrame__17.Size.X.Offset, l__RarityFrame__17.Size.Y.Scale / v52, l__RarityFrame__17.Size.Y.Offset);
    else
        v52 = 1;
    end;
    local l__Size__18 = v45.Size;
    v45.Size = UDim2.new(l__Size__18.X.Scale * v46, l__Size__18.X.Offset * v46, l__Size__18.Y.Scale * v52 * v46, l__Size__18.Y.Offset * v52 * v46);
    if v44 then
        v45.StudsOffsetWorldSpace = Vector3.new(0, v42 + l__Y__15, 0);
    else
        v45.StudsOffsetWorldSpace = Vector3.new(0, l__Y__15, 0);
    end;
    v45.AlwaysOnTop = true;
    v45.MaxDistance = 250;
    v45.Parent = v43;
    local v53 = nil;
    if v41 then
        local l__RarityFrame__19 = v45.RarityFrame;
        l__RarityFrame__19.ItemRarity.Text = v40;
        l__RarityFrame__19.ItemRarity.TextLabel.Text = v40;
        l__RarityFrame__19.ItemRarity.TextLabel.TextColor3 = l__RarityVisuals__7.GetStaticColor(v40);
        v53 = l__RarityVisuals__7.ApplyToLabels({ l__RarityFrame__19.ItemRarity.TextLabel }, v40);
    else
        v45.RarityFrame.Visible = false;
    end;
    local l__NameFrame__20 = v45.NameFrame;
    l__NameFrame__20.ItemName.Text = v39;
    l__NameFrame__20.ItemName.TextLabel.Text = v39;
    local v54;
    if v51 then
        v54 = u36(v45, v52);
    else
        v54 = nil;
    end;
    return v45, v53, v54;
end;
local function u62(p56) --[[ Line: 308 ]]
    local function v58(p57) --[[ Line: 309 ]]
        if p57:IsA("BasePart") then
            p57.LocalTransparencyModifier = 1;
        elseif p57:IsA("Decal") or p57:IsA("Texture") then
            p57.LocalTransparencyModifier = 1;
        else
            if p57:IsA("ProximityPrompt") then
                p57.Enabled = false;
            end;
        end;
    end;
    for _, v59 in p56:GetDescendants() do
        if v59:IsA("BasePart") then
            v59.LocalTransparencyModifier = 1;
        elseif v59:IsA("Decal") or v59:IsA("Texture") then
            v59.LocalTransparencyModifier = 1;
        elseif v59:IsA("ProximityPrompt") then
            v59.Enabled = false;
        end;
    end;
    local u60 = p56.DescendantAdded:Connect(v58);
    p56.AncestryChanged:Connect(function(_, p61) --[[ Line: 324 ]]
        -- upvalues: u60 (copy)
        if not p61 then
            u60:Disconnect();
        end;
    end);
end;
local function u80(u63) --[[ Line: 331 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u62 (copy), u55 (copy), u6 (copy)
    if u63:IsA("Model") then
        task.spawn(function() --[[ Line: 334 ]]
            -- upvalues: u63 (copy), l__LocalPlayer__9 (ref), u62 (ref), u55 (ref), u6 (ref)
            local v64 = u63:GetAttribute("ItemCategory");
            local v65 = v64 == "Pets";
            if u63:GetAttribute("OwnerRestricted") == true and u63:GetAttribute("DroppedBy") ~= l__LocalPlayer__9.UserId then
                u62(u63);
                return;
            end;
            local l__Visual__21 = u63:WaitForChild("Visual", 5);
            if not l__Visual__21 then
                return;
            end;
            local v66;
            if l__Visual__21:IsA("BasePart") then
                v66 = l__Visual__21;
            elseif l__Visual__21:IsA("Model") then
                v66 = l__Visual__21.PrimaryPart;
            else
                v66 = nil;
            end;
            if not v66 then
                local v67 = os.clock() + 5;
                while os.clock() < v67 do
                    if not u63.Parent then
                        return;
                    end;
                    task.wait(0.05);
                    if l__Visual__21:IsA("BasePart") then
                        v66 = l__Visual__21;
                    elseif l__Visual__21:IsA("Model") then
                        v66 = l__Visual__21.PrimaryPart;
                    else
                        v66 = nil;
                    end;
                    if v66 then
                        break;
                    end;
                end;
            end;
            if not v66 then
                return;
            end;
            if not u63.Parent then
                return;
            end;
            local v68 = l__Visual__21:GetAttribute("PartCount");
            if l__Visual__21:IsA("Model") and (type(v68) == "number" and v68 > 1) then
                local v69 = os.clock() + 3;
                while os.clock() < v69 do
                    if not u63.Parent then
                        return;
                    end;
                    local v70 = 0;
                    for _, v71 in l__Visual__21:GetDescendants() do
                        if v71:IsA("BasePart") then
                            v70 = v70 + 1;
                            if v68 <= v70 then
                                break;
                            end;
                        end;
                    end;
                    if v68 <= v70 then
                        break;
                    end;
                    task.wait(0.03);
                end;
            end;
            if u63.Parent then
                local l__Position__22 = v66.Position;
                local v72 = Instance.new("PointLight");
                v72.Name = "DropGlow";
                v72.Brightness = 0.5;
                v72.Range = 8;
                v72.Color = Color3.fromRGB(255, 255, 200);
                v72.Parent = v66;
                local v73, v74, v75 = u55(u63, v66);
                local v76 = u63:GetAttribute("DespawnAt");
                local v77 = u63:GetAttribute("DisplayName");
                local v78 = (v64 == "Raccoons" or v64 == "Pets" and u63:GetAttribute("ItemName") == "Raccoon") and true or v77 == "Raccoon";
                local v79 = {
                    popped = false,
                    basePosition = l__Position__22,
                    visualModel = l__Visual__21:IsA("Model") and l__Visual__21 and l__Visual__21 or nil,
                    primaryPart = v66,
                    spawnTime = os.clock(),
                    glow = v72,
                    label = v73,
                    rarityCleanup = v74,
                    timerLabel = v75
                };
                if type(v76) ~= "number" then
                    v76 = nil;
                end;
                v79.despawnAt = v76;
                v79.isRaccoon = v78;
                v79.isPet = v65;
                u6[u63] = v79;
            end;
        end);
    end;
end;
local function u83(p81) --[[ Line: 421 ]]
    -- upvalues: u6 (copy)
    if p81:IsA("Model") then
        local v82 = u6[p81];
        if v82 and v82.rarityCleanup then
            v82.rarityCleanup();
        end;
        u6[p81] = nil;
    end;
end;
local function u99(p84, p85) --[[ Line: 439 ]]
    -- upvalues: u6 (copy), l__Players__1 (copy), l__TweenService__5 (copy), u9 (copy)
    if not (p84 and p84:IsA("Model")) then
        return;
    end;
    local v86 = u6[p84];
    local _ = p84:GetAttribute("ItemCategory") == "Pets";
    if not v86 then
        return;
    end;
    local v87 = l__Players__1:GetPlayerByUserId(p85);
    if not (v87 and v87.Character) then
        return;
    end;
    local v88 = v87.Character:FindFirstChild("HumanoidRootPart");
    if not v88 then
        return;
    end;
    u6[p84] = nil;
    if v86.rarityCleanup then
        v86.rarityCleanup();
    end;
    if v86.label then
        local l__label__23 = v86.label;
        l__TweenService__5:Create(l__label__23, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play();
        task.delay(0.3, function() --[[ Line: 473 ]]
            -- upvalues: l__label__23 (copy)
            if l__label__23 then
                l__label__23:Destroy();
            end;
        end);
    end;
    local v89 = v86.visualModel or v86.primaryPart;
    if not (v89 and v89.Parent) then
        return;
    end;
    local v90 = workspace:FindFirstChild("DroppedItemFx");
    if not (v90 and v90:IsA("Folder")) then
        v90 = Instance.new("Folder");
        v90.Name = "DroppedItemFx";
        v90.Parent = workspace;
    end;
    local v91 = v89:Clone();
    local v92 = nil;
    local v93 = nil;
    if v91:IsA("Model") then
        v92 = v91.PrimaryPart;
        if v92 then
            v93 = v91;
        else
            v93 = v91;
            for _, v94 in v91:GetDescendants() do
                if v94:IsA("BasePart") then
                    v92 = v94;
                    break;
                end;
            end;
            if v92 then
                v91.PrimaryPart = v92;
            end;
        end;
        for _, v95 in v91:GetDescendants() do
            if v95:IsA("BasePart") then
                v95.Anchored = true;
                v95.CanCollide = false;
                v95.CanQuery = false;
                v95.CanTouch = false;
            end;
        end;
    elseif v91:IsA("BasePart") then
        v91.Anchored = true;
        v91.CanCollide = false;
        v91.CanQuery = false;
        v91.CanTouch = false;
        v92 = v91;
    end;
    if v92 then
        v91.Parent = v90;
        if v86.visualModel and v86.visualModel.Parent then
            for _, v96 in v86.visualModel:GetDescendants() do
                if v96:IsA("BasePart") then
                    v96.Transparency = 1;
                end;
                if v96:IsA("Decal") or v96:IsA("Texture") then
                    v96.Transparency = 1;
                end;
                if v96:IsA("SurfaceGui") or v96:IsA("BillboardGui") then
                    v96.Enabled = false;
                end;
            end;
        end;
        local v97 = u9;
        local v98 = {
            glow = nil,
            visualModel = v93,
            primaryPart = v92,
            spawnTime = v86.spawnTime,
            collectStart = os.clock(),
            collectTarget = v88,
            collectOrigin = v86.basePosition,
            isRaccoon = v86.isRaccoon
        };
        table.insert(v97, v98);
    else
        v91:Destroy();
    end;
end;
local function u127(_) --[[ Line: 548 ]]
    -- upvalues: l__PerfFlags__8 (copy), u6 (copy), u9 (copy)
    local v100 = os.clock();
    local v101 = l__PerfFlags__8.DroppedItemAnimationsDisabled:Get();
    for v102, v103 in u6 do
        if v102.Parent then
            if v103.primaryPart and v103.primaryPart.Parent then
                local v104 = v100 - v103.spawnTime;
                local l__basePosition__24 = v103.basePosition;
                if v101 then
                    if not v103.staticApplied then
                        v103.staticApplied = true;
                        v103.popped = true;
                        local v105 = v103.isRaccoon and 1.5707963267948966 or 0;
                        local v106;
                        if v103.isRaccoon then
                            v106 = CFrame.new(l__basePosition__24) * CFrame.Angles(v105, 1.5707963267948966, 0);
                        else
                            v106 = CFrame.new(l__basePosition__24) * CFrame.Angles(v105, 0, 0);
                        end;
                        if v103.visualModel then
                            v103.visualModel:ScaleTo(1);
                            v103.visualModel:PivotTo(v106);
                        else
                            v103.primaryPart.CFrame = v106;
                        end;
                        if v103.glow then
                            v103.glow.Brightness = 0.5;
                        end;
                    end;
                    if v103.timerLabel and v103.despawnAt then
                        local v107 = v103.despawnAt - workspace:GetServerTimeNow();
                        v103.timerLabel.Text = string.format("%ds", (math.ceil(v107 < 0 and 0 or v107)));
                    end;
                else
                    if v103.staticApplied then
                        v103.staticApplied = nil;
                    end;
                    local v108 = 1;
                    if v104 < 0.4 then
                        local v109 = math.clamp(v104 / 0.4, 0, 1);
                        v108 = (v109 - 1) ^ 3 * 2.70158 + 1 + (v109 - 1) ^ 2 * 1.70158;
                    elseif not v103.popped then
                        v103.popped = true;
                    end;
                    local v110 = math.sin(v104 * 0.8 * 3.141592653589793 * 2) * 0.35;
                    local v111 = math.rad(v104 * 50);
                    local v112 = l__basePosition__24 + Vector3.new(0, v110, 0);
                    local v113 = v103.isRaccoon and 1.5707963267948966 or 0;
                    local v114;
                    if v103.isRaccoon then
                        v114 = CFrame.new(v112) * CFrame.Angles(v113, 1.5707963267948966, 0) * CFrame.Angles(v111, 0, 0);
                    else
                        v114 = CFrame.new(v112) * CFrame.Angles(v113, 0, 0) * CFrame.Angles(0, v111, 0);
                    end;
                    if v104 < 0.4 then
                        local v115 = math.max(v108, 0.01);
                        if v103.visualModel then
                            v103.visualModel:ScaleTo(v115);
                        end;
                    elseif not v103.popped then
                        if v103.visualModel then
                            v103.visualModel:ScaleTo(1);
                        end;
                        v103.popped = true;
                    end;
                    if v103.visualModel then
                        v103.visualModel:PivotTo(v114);
                    else
                        v103.primaryPart.CFrame = v114;
                    end;
                    if v103.glow then
                        local v116 = math.sin(v104 * 2.5) * 0.5 + 0.5;
                        v103.glow.Brightness = (v116 * 0.25 + 0.75) * 0.5;
                    end;
                    if v103.timerLabel and v103.despawnAt then
                        local v117 = v103.despawnAt - workspace:GetServerTimeNow();
                        v103.timerLabel.Text = string.format("%ds", (math.ceil(v117 < 0 and 0 or v117)));
                    end;
                end;
            else
                u6[v102] = nil;
            end;
        else
            u6[v102] = nil;
        end;
    end;
    for v118 = #u9, 1, -1 do
        local v119 = u9[v118];
        local v120 = math.clamp((v100 - v119.collectStart) / 0.2, 0, 1);
        local v121 = v120 * v120;
        local v122 = v119.collectOrigin:Lerp(v119.collectTarget.Position, v121);
        local v123 = math.max(1 - v121, 0.01);
        local v124 = math.rad((v100 - v119.spawnTime) * 50 * 2);
        local v125 = v119.isRaccoon and 1.5707963267948966 or 0;
        local v126;
        if v119.isRaccoon then
            v126 = CFrame.new(v122) * CFrame.Angles(v125, 1.5707963267948966, 0) * CFrame.Angles(v124, 0, 0);
        else
            v126 = CFrame.new(v122) * CFrame.Angles(v125, 0, 0) * CFrame.Angles(0, v124, 0);
        end;
        if v119.visualModel then
            v119.visualModel:ScaleTo(v123);
            v119.visualModel:PivotTo(v126);
        else
            v119.primaryPart.CFrame = v126;
        end;
        if v119.glow then
            v119.glow.Brightness = (1 - v121) * 0.5;
        end;
        if v120 >= 1 then
            if v119.visualModel then
                v119.visualModel:Destroy();
            else
                v119.primaryPart:Destroy();
            end;
            table.remove(u9, v118);
        end;
    end;
end;
function v1.Init(_) --[[ Line: 705 ]]
    -- upvalues: u7 (ref)
    u7 = workspace:FindFirstChild("DroppedItems");
    if not u7 then
        u7 = Instance.new("Folder");
        u7.Name = "DroppedItems";
        u7.Parent = workspace;
    end;
end;
function v1.Start(_) --[[ Line: 714 ]]
    -- upvalues: u7 (ref), u80 (copy), u83 (copy), l__RunService__2 (copy), u127 (copy), l__Networking__6 (copy), u99 (copy), l__UserInputService__3 (copy), l__Backspace__11 (copy), u16 (ref), l__PlayerGui__10 (copy), u8 (ref), u21 (ref), l__LocalPlayer__9 (copy)
    u7.ChildAdded:Connect(u80);
    u7.ChildRemoved:Connect(u83);
    for _, v128 in u7:GetChildren() do
        task.spawn(u80, v128);
    end;
    l__RunService__2.Heartbeat:Connect(u127);
    l__Networking__6.DroppedItem.PickupFx.OnClientEvent:Connect(u99);
    l__UserInputService__3.InputBegan:Connect(function(p129, p130) --[[ Line: 726 ]]
        -- upvalues: l__Backspace__11 (ref), u16 (ref), l__Networking__6 (ref)
        if p130 then
        elseif p129.KeyCode == l__Backspace__11 then
            local v131, v132 = u16();
            if v131 and v132 then
                l__Networking__6.DroppedItem.RequestDrop:Fire(v131, v132);
            end;
        end;
    end);
    u8 = l__PlayerGui__10:WaitForChild("HoldToCollect"):WaitForChild("Remove");
    u8.Visible = false;
    u8.MouseButton1Click:Connect(function() --[[ Line: 741 ]]
        -- upvalues: u16 (ref), l__Networking__6 (ref)
        local v133, v134 = u16();
        if v133 and v134 then
            l__Networking__6.DroppedItem.RequestDrop:Fire(v133, v134);
        end;
    end);
    local function v138(p135) --[[ Line: 749 ]]
        -- upvalues: u21 (ref)
        p135.ChildAdded:Connect(function(p136) --[[ Line: 750 ]]
            -- upvalues: u21 (ref)
            if p136:IsA("Tool") then
                u21();
            end;
        end);
        p135.ChildRemoved:Connect(function(p137) --[[ Line: 755 ]]
            -- upvalues: u21 (ref)
            if p137:IsA("Tool") then
                u21();
            end;
        end);
        u21();
    end;
    if l__LocalPlayer__9.Character then
        v138(l__LocalPlayer__9.Character);
    end;
    l__LocalPlayer__9.CharacterAdded:Connect(v138);
    u21();
end;
return v1;