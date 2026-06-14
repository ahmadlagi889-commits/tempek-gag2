-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 11
};
local l__ProximityPromptService__1 = game:GetService("ProximityPromptService");
local l__SharedModules__2 = game:GetService("ReplicatedStorage"):WaitForChild("SharedModules");
local l__SeedData__3 = require(l__SharedModules__2:WaitForChild("SeedData"));
local l__RarityVisuals__4 = require(l__SharedModules__2:WaitForChild("RarityVisuals"));
local l__MutationData__5 = require(l__SharedModules__2:WaitForChild("MutationData"));
local l__WeightFormat__6 = require(l__SharedModules__2:WaitForChild("WeightFormat"));
local u2 = nil;
local u3 = UDim2.fromOffset(220, 64);
local u4 = Vector2.new(0, -1);
local u5 = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
local u6 = Color3.fromRGB(0, 0, 0);
local u7 = Color3.new(1, 1, 1);
local u8 = Color3.new(1, 1, 1);
local u9 = {};
local u10 = {};
local u11 = {};
local function u13(p12) --[[ Line: 94 ]]
    return string.format("#%02X%02X%02X", math.floor(p12.R * 255 + 0.5), math.floor(p12.G * 255 + 0.5), (math.floor(p12.B * 255 + 0.5)));
end;
local function u18(p14) --[[ Line: 124 ]]
    if type(p14) ~= "string" or p14 == "" then
        return {};
    end;
    local v15 = {};
    for v16 in string.gmatch(p14, "[^%+%,]+") do
        local v17 = string.gsub(v16, "^%s*(.-)%s*$", "%1");
        if v17 ~= "" then
            table.insert(v15, v17);
        end;
    end;
    return v15;
end;
local function u26(p19) --[[ Line: 137 ]]
    -- upvalues: u13 (copy), u7 (copy), u10 (copy), l__MutationData__5 (copy)
    local v20 = string.format("<font color=\"%s\"> + </font>", u13(u7));
    local v21 = {};
    for _, v22 in p19 do
        local v23 = u10[v22];
        if not v23 then
            v23 = Color3.new(1, 1, 1);
            local v24 = l__MutationData__5.GetMutation(v22);
            if v24 and v24.Gradient then
                local l__Keypoints__7 = v24.Gradient.Color.Keypoints;
                if l__Keypoints__7[1] then
                    v23 = l__Keypoints__7[1].Value;
                end;
            end;
            u10[v22] = v23;
        end;
        local v25 = string.format("#%02X%02X%02X", math.floor(v23.R * 255 + 0.5), math.floor(v23.G * 255 + 0.5), (math.floor(v23.B * 255 + 0.5)));
        table.insert(v21, string.format("<font color=\"%s\">%s</font>", v25, v22));
    end;
    return table.concat(v21, v20);
end;
local function u28(p27) --[[ Line: 151 ]]
    local l__Parent__8 = p27.Parent;
    if not (l__Parent__8 and l__Parent__8:IsA("BasePart")) then
        return nil, nil;
    end;
    local l__Parent__9 = l__Parent__8.Parent;
    while l__Parent__9 do
        if l__Parent__9:IsA("Model") then
            return l__Parent__9, l__Parent__8;
        end;
        l__Parent__9 = l__Parent__9.Parent;
    end;
    return nil, nil;
end;
local function u42(p29) --[[ Line: 171 ]]
    -- upvalues: u9 (copy), u18 (copy), u2 (ref), u8 (copy), l__WeightFormat__6 (copy), l__MutationData__5 (copy), l__RarityVisuals__4 (copy), u26 (copy)
    local l__fruit__10 = p29.fruit;
    local v30 = l__fruit__10:GetAttribute("CorePartName");
    local v31 = l__fruit__10:GetAttribute("SeedName");
    if type(v30) ~= "string" or v30 == "" then
        v30 = (type(v31) ~= "string" or v31 == "") and "?" or v31;
    end;
    local v32 = u9[v30];
    local v33 = (not v32 or type(v32.Rarity) ~= "string") and "Common" or v32.Rarity;
    local v34 = p29.nameLabel:FindFirstChildOfClass("UIGradient");
    if v34 then
        v34:Destroy();
    end;
    local v35 = u18(l__fruit__10:GetAttribute("Mutation"));
    local v36 = "";
    local v37;
    if u2 then
        v37 = u2:CalculateFruitWeight(l__fruit__10);
        if not v37 and u2.CalculatePlantWeight then
            v37 = u2:CalculatePlantWeight(l__fruit__10);
        end;
    else
        v37 = nil;
    end;
    if v37 then
        local v38 = u8;
        v36 = string.format(" <font color=\"%s\">⚖️ %s</font>", string.format("#%02X%02X%02X", math.floor(v38.R * 255 + 0.5), math.floor(v38.G * 255 + 0.5), (math.floor(v38.B * 255 + 0.5))), l__WeightFormat__6.FormatGrams(v37));
    end;
    if #v35 == 1 then
        local v39 = l__MutationData__5.GetMutation(v35[1]);
        if v39 and v39.Gradient then
            p29.nameLabel.TextColor3 = u8;
            p29.nameLabel.Text = v30 .. v36;
            v39.Gradient:Clone().Parent = p29.nameLabel;
        else
            p29.nameLabel.TextColor3 = u8;
            local l__nameLabel__11 = p29.nameLabel;
            local l__format__12 = string.format;
            local v40 = l__RarityVisuals__4.GetStaticColor(v33);
            l__nameLabel__11.Text = l__format__12("<font color=\"%s\">%s</font>%s", string.format("#%02X%02X%02X", math.floor(v40.R * 255 + 0.5), math.floor(v40.G * 255 + 0.5), (math.floor(v40.B * 255 + 0.5))), v30, v36);
        end;
    else
        p29.nameLabel.TextColor3 = u8;
        local l__nameLabel__13 = p29.nameLabel;
        local l__format__14 = string.format;
        local v41 = l__RarityVisuals__4.GetStaticColor(v33);
        l__nameLabel__13.Text = l__format__14("<font color=\"%s\">%s</font>%s", string.format("#%02X%02X%02X", math.floor(v41.R * 255 + 0.5), math.floor(v41.G * 255 + 0.5), (math.floor(v41.B * 255 + 0.5))), v30, v36);
    end;
    if #v35 == 0 then
        p29.mutationsLabel.Text = "";
        p29.mutationsLabel.Visible = false;
    else
        p29.mutationsLabel.Text = u26(v35);
        p29.mutationsLabel.Visible = true;
    end;
end;
local function u51(p43) --[[ Line: 267 ]]
    -- upvalues: u4 (copy), u3 (copy), u5 (copy), u6 (copy)
    local v44 = Instance.new("BillboardGui");
    v44.Name = "HarvestPromptLabel";
    v44.AlwaysOnTop = true;
    v44.LightInfluence = 0;
    v44.ClipsDescendants = false;
    v44.MaxDistance = 80;
    v44.SizeOffset = u4;
    v44.Adornee = p43;
    v44.Size = u3;
    v44.Parent = p43;
    local v45 = Instance.new("Frame");
    v45.BackgroundTransparency = 1;
    v45.BorderSizePixel = 0;
    v45.AnchorPoint = Vector2.new(0.5, 0.5);
    v45.Position = UDim2.fromScale(0.5, 0.5);
    v45.Size = UDim2.fromScale(1, 1);
    v45.Parent = v44;
    local v46 = Instance.new("UIListLayout");
    v46.FillDirection = Enum.FillDirection.Vertical;
    v46.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v46.VerticalAlignment = Enum.VerticalAlignment.Center;
    v46.Padding = UDim.new(0, 2);
    v46.SortOrder = Enum.SortOrder.LayoutOrder;
    v46.Parent = v45;
    local v47 = Instance.new("TextLabel");
    v47.RichText = true;
    v47.Name = "Name";
    v47.BackgroundTransparency = 1;
    v47.BorderSizePixel = 0;
    v47.FontFace = u5;
    v47.LayoutOrder = 1;
    v47.Size = UDim2.new(1, 0, 0.55, 0);
    v47.Text = "";
    v47.TextColor3 = Color3.new(1, 1, 1);
    v47.TextScaled = true;
    v47.TextSize = 24;
    v47.TextWrapped = true;
    v47.TextXAlignment = Enum.TextXAlignment.Center;
    v47.TextYAlignment = Enum.TextYAlignment.Center;
    v47.Parent = v45;
    local v48 = Instance.new("UIStroke");
    v48.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    v48.Color = u6;
    v48.LineJoinMode = Enum.LineJoinMode.Round;
    v48.Thickness = 2;
    v48.Parent = v47;
    local v49 = Instance.new("TextLabel");
    v49.Name = "Mutations";
    v49.BackgroundTransparency = 1;
    v49.BorderSizePixel = 0;
    v49.FontFace = u5;
    v49.LayoutOrder = 2;
    v49.Size = UDim2.new(1, 0, 0.4, 0);
    v49.RichText = true;
    v49.Text = "";
    v49.TextColor3 = Color3.new(1, 1, 1);
    v49.TextScaled = true;
    v49.TextSize = 20;
    v49.TextWrapped = true;
    v49.TextXAlignment = Enum.TextXAlignment.Center;
    v49.TextYAlignment = Enum.TextYAlignment.Center;
    v49.Visible = false;
    v49.Parent = v45;
    local v50 = Instance.new("UIStroke");
    v50.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    v50.Color = u6;
    v50.LineJoinMode = Enum.LineJoinMode.Round;
    v50.Thickness = 2;
    v50.Parent = v49;
    return v44, v47, v49;
end;
local function u54(p52) --[[ Line: 349 ]]
    -- upvalues: u11 (copy)
    local v53 = u11[p52];
    if v53 then
        u11[p52] = nil;
        if v53.mutationConn then
            v53.mutationConn:Disconnect();
        end;
        if v53.promptAncestryConn then
            v53.promptAncestryConn:Disconnect();
        end;
        if v53.fruitAncestryConn then
            v53.fruitAncestryConn:Disconnect();
        end;
        if v53.billboard then
            v53.billboard:Destroy();
        end;
    end;
end;
local function u64(u55) --[[ Line: 360 ]]
    -- upvalues: u11 (copy), u28 (copy), u51 (copy), u42 (copy), u54 (copy)
    if u11[u55] then
    else
        local v56, v57 = u28(u55);
        if v56 and v57 then
            local v58, v59, v60 = u51(v57);
            local u61 = {
                billboard = v58,
                nameLabel = v59,
                mutationsLabel = v60,
                adornee = v57,
                fruit = v56
            };
            u11[u55] = u61;
            u42(u61);
            u61.mutationConn = v56:GetAttributeChangedSignal("Mutation"):Connect(function() --[[ Line: 381 ]]
                -- upvalues: u11 (ref), u55 (copy), u61 (copy), u42 (ref)
                if u11[u55] == u61 then
                    u42(u61);
                end;
            end);
            u61.promptAncestryConn = u55.AncestryChanged:Connect(function(_, p62) --[[ Line: 389 ]]
                -- upvalues: u54 (ref), u55 (copy)
                if not p62 then
                    u54(u55);
                end;
            end);
            u61.fruitAncestryConn = v56.AncestryChanged:Connect(function(_, p63) --[[ Line: 392 ]]
                -- upvalues: u54 (ref), u55 (copy)
                if not p63 then
                    u54(u55);
                end;
            end);
        end;
    end;
end;
function v1.Init(_) --[[ Line: 403 ]]
    -- upvalues: l__SeedData__3 (copy), u9 (copy)
    for _, v65 in l__SeedData__3 do
        if type(v65) == "table" and type(v65.SeedName) == "string" then
            u9[v65.SeedName] = v65;
        end;
    end;
end;
function v1.Start(_) --[[ Line: 411 ]]
    -- upvalues: u2 (ref), l__ProximityPromptService__1 (copy), u64 (copy), u54 (copy)
    u2 = require(script.Parent.FruitVisualizerController);
    l__ProximityPromptService__1.PromptShown:Connect(function(p66) --[[ Line: 416 ]]
        -- upvalues: u64 (ref)
        if p66:HasTag("HarvestPrompt") then
            u64(p66);
        end;
    end);
    l__ProximityPromptService__1.PromptHidden:Connect(function(p67) --[[ Line: 421 ]]
        -- upvalues: u54 (ref)
        if p67:HasTag("HarvestPrompt") then
            u54(p67);
        end;
    end);
end;
return v1;