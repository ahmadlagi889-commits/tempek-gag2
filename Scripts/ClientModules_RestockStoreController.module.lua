-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Players__3 = game:GetService("Players");
local l__LocalPlayer__4 = l__Players__3.LocalPlayer;
local l__PlayerGui__5 = l__LocalPlayer__4:WaitForChild("PlayerGui");
local l__NumberUtils__6 = require(l__ReplicatedStorage__1.SharedModules.NumberUtils);
local l__Networking__7 = require(l__ReplicatedStorage__1.SharedModules.Networking);
local l__PlayerStateClient__8 = require(l__ReplicatedStorage__1.ClientModules.PlayerStateClient);
local l__DevProductController__9 = require(l__LocalPlayer__4.PlayerScripts.Controllers.DevProductController);
local l__SfxController__10 = require(l__LocalPlayer__4.PlayerScripts.Controllers.SfxController);
local l__NotificationController__11 = require(l__LocalPlayer__4.PlayerScripts.Controllers.NotificationController);
local l__Gradients__12 = l__ReplicatedStorage__1.SharedModules.RarityData.Gradients;
local l__GuiController__13 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController);
local l__GreenbeanAvatarController__14 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GreenbeanAvatarController);
local l__GreenbeanCheck__15 = require(l__ReplicatedStorage__1.SharedData.GreenbeanCheck);
local l__WatchButtonHold__16 = require(l__ReplicatedStorage__1.ClientModules.WatchButtonHold);
local l__CrateName__17 = l__PlayerGui__5:WaitForChild("Odds"):WaitForChild("Frame"):WaitForChild("CrateName");
local l__PlayerSelector__18 = l__PlayerGui__5:WaitForChild("PlayerSelector");
local l__FX_UI__19 = l__PlayerGui__5:WaitForChild("FX_UI");
local u1 = l__PlayerStateClient__8:WaitForLocalReplica(30);
local u2 = Color3.new(0.0784314, 0.188235, 0);
local u3 = Color3.new(0.188235, 0, 0);
local u4 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u5 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local u6 = {
    ["1Button"] = 1,
    ["3Button"] = 3,
    ["10Button"] = 10,
    GiftButton1 = 1,
    GiftButton3 = 3,
    GiftButton10 = 10
};
local function u13(p7, p8) --[[ Line: 49 ]]
    -- upvalues: l__Players__3 (copy)
    local v9 = p8:match("^Gamepass:([^:]+)");
    if not v9 then
        return false;
    end;
    local v10 = p7.Player or l__Players__3:GetPlayerByUserId(p7.UserId);
    if not v10 then
        return false;
    end;
    local v11 = v10:GetAttribute("OwnedGamepasses");
    if type(v11) ~= "string" or v11 == "" then
        return false;
    end;
    for v12 in v11:gmatch("[^,]+") do
        if v12 == v9 then
            return true;
        end;
    end;
    return false;
end;
local function u21(u14) --[[ Line: 62 ]]
    -- upvalues: l__PlayerSelector__18 (copy), u13 (copy), l__ReplicatedStorage__1 (copy), l__Networking__7 (copy), l__DevProductController__9 (copy)
    local u15 = nil;
    task.spawn(function() --[[ Line: 64 ]]
        -- upvalues: l__PlayerSelector__18 (ref), u15 (ref)
        local v16 = l__PlayerSelector__18.PlayerSelected.Event:Wait();
        if v16 == nil then
            u15 = "cancelled";
        else
            u15 = v16;
        end;
    end);
    l__PlayerSelector__18.Enabled = true;
    repeat
        task.wait();
    until u15 ~= nil;
    if u15 == "cancelled" then
    elseif u13(u15, u14) then
        l__ReplicatedStorage__1:FindFirstChild("Notify"):Fire((`<font color="#5B9CF5">@{u15.Name}</font> already owns this gamepass!`));
    else
        local v17, v18 = pcall(function() --[[ Line: 87 ]]
            -- upvalues: l__Networking__7 (ref), u15 (ref)
            l__Networking__7.DevProducts.SetGiftTarget:Fire(u15.UserId);
        end);
        if not v17 then
            warn((`[RestockStoreController] SetGiftTarget fire failed ({u14}): {v18}`));
        end;
        local v19, v20 = pcall(function() --[[ Line: 93 ]]
            -- upvalues: l__DevProductController__9 (ref), u14 (copy)
            l__DevProductController__9:PromptPurchase((`{u14}:Gift`));
        end);
        if not v19 then
            warn((`[RestockStoreController] Gift purchase prompt failed ({u14}): {v20}`));
        end;
    end;
end;
local function u26(p22, p23) --[[ Line: 101 ]]
    -- upvalues: u2 (copy), u3 (copy)
    for _, v24 in p22:GetChildren() do
        if v24:IsA("UIGradient") or v24:IsA("UIStroke") then
            if v24.Name == "NoStock" then
                v24.Enabled = not p23;
            elseif v24:IsA("UIStroke") then
                v24.Enabled = true;
                local v25;
                if p23 then
                    v25 = u2;
                else
                    v25 = u3;
                end;
                v24.Color = v25;
            else
                v24.Enabled = p23;
            end;
        end;
    end;
end;
local function u30(p27) --[[ Line: 116 ]]
    -- upvalues: l__FX_UI__19 (copy), l__TweenService__2 (copy), u5 (copy)
    local v28 = Instance.new("Frame");
    v28.Parent = l__FX_UI__19;
    v28.BackgroundColor3 = Color3.new(1, 1, 1);
    v28.AnchorPoint = Vector2.new(0.5, 0.5);
    v28.Size = UDim2.new(0, p27.AbsoluteSize.X, 0, p27.AbsoluteSize.Y * 1.5);
    v28.Position = UDim2.new(0, p27.AbsolutePosition.X + p27.AbsoluteSize.X / 2, 0, p27.AbsolutePosition.Y + p27.AbsoluteSize.Y / 2);
    local v29 = l__TweenService__2:Create(v28, u5, {
        BackgroundTransparency = 1,
        Size = v28.Size + UDim2.new(0.1, 0, 0, 0)
    });
    v29:Play();
    game.Debris:AddItem(v28, u5.Time);
    game.Debris:AddItem(v29, u5.Time);
end;
return {
    Init = function(u31) --[[ Name: Init, Line 131 ]]
        -- upvalues: u1 (copy), u6 (copy), l__DevProductController__9 (copy), l__NumberUtils__6 (copy), u26 (copy), l__GuiController__13 (copy), l__CrateName__17 (copy), l__Gradients__12 (copy), l__LocalPlayer__4 (copy), l__TweenService__2 (copy), u4 (copy), l__NotificationController__11 (copy), l__GreenbeanCheck__15 (copy), l__GreenbeanAvatarController__14 (copy), u30 (copy), l__SfxController__10 (copy), l__WatchButtonHold__16 (copy), u21 (copy)
        local l__scrollingFrame__20 = u31.scrollingFrame;
        local l__ItemTemplate__21 = l__scrollingFrame__20:WaitForChild("ItemTemplate");
        l__ItemTemplate__21.Visible = false;
        local l__Sheckles_Shelf__22 = l__scrollingFrame__20:WaitForChild("Sheckles_Shelf");
        local l__Robux_Shelf__23 = l__scrollingFrame__20:WaitForChild("Robux_Shelf");
        local l__BuyButton__24 = l__Sheckles_Shelf__22.Main_Frame.Buttons.BuyButton;
        local l__ToggleRobux__25 = l__Sheckles_Shelf__22.Main_Frame.Buttons.ToggleRobux;
        local l__ToggleSheckles__26 = l__Robux_Shelf__23.Main_Frame.Buttons.ToggleSheckles;
        local l__Buttons__27 = l__Robux_Shelf__23.Main_Frame.Buttons;
        local u32 = {};
        local u33 = {};
        local v34 = {};
        local u35 = nil;
        local function u40() --[[ Line: 176 ]]
            -- upvalues: l__Sheckles_Shelf__22 (copy), l__Robux_Shelf__23 (copy), u35 (ref), u33 (copy), u6 (ref), l__Buttons__27 (copy), l__DevProductController__9 (ref), u31 (copy), l__NumberUtils__6 (ref)
            l__Sheckles_Shelf__22.Visible = false;
            l__Robux_Shelf__23.Visible = true;
            local v36;
            if u35 then
                v36 = u33[u35.Name];
                if v36 then
                    v36 = v36.isEquippable;
                end;
            else
                v36 = false;
            end;
            for v37, _ in pairs(u6) do
                local v38 = l__Buttons__27:FindFirstChild(v37);
                if v38 then
                    if v37 == "1Button" then
                        v38.Visible = true;
                        if v36 and u35 then
                            local v39 = l__DevProductController__9:WaitForPreloadedProductInfo((`{u31.devProductPrefix}:{u35.Name}:1`));
                            if v39 then
                                v38.TextDisplay.TextLabel.Text = `{l__NumberUtils__6.FormatWithCommas(v39.PriceInRobux)}`;
                                v38.TextDisplay.TextLabel.TextLabel.Text = v38.TextDisplay.TextLabel.Text;
                            end;
                        else
                            v38.TextDisplay.TextLabel.Text = "x1";
                            v38.TextDisplay.TextLabel.TextLabel.Text = "x1";
                        end;
                    else
                        v38.Visible = not v36;
                    end;
                end;
            end;
        end;
        local function u50(p41) --[[ Line: 209 ]]
            -- upvalues: u33 (copy), u31 (copy), l__BuyButton__24 (copy), u1 (ref), u26 (ref), l__ToggleRobux__25 (copy)
            local l__Text__28 = p41.Cost_Text.Text;
            local l__Name__29 = p41.Parent.Name;
            local v42 = u33[l__Name__29];
            if v42 and v42.isEquippable then
                local l__ownsEquippableGear__30 = u31.ownsEquippableGear;
                if l__ownsEquippableGear__30 then
                    l__ownsEquippableGear__30 = u31.ownsEquippableGear(l__Name__29);
                end;
                local l__isGearEquipped__31 = u31.isGearEquipped;
                if l__isGearEquipped__31 then
                    l__isGearEquipped__31 = u31.isGearEquipped(l__Name__29);
                end;
                local v43 = l__BuyButton__24.TextDisplay:FindFirstChild("ImageLabel");
                if l__ownsEquippableGear__30 then
                    local v44 = l__isGearEquipped__31 and "Unequip" or "Equip";
                    l__BuyButton__24.TextDisplay.TextLabel.Text = v44;
                    l__BuyButton__24.TextDisplay.TextLabel.TextLabel.Text = v44;
                    u26(l__BuyButton__24, not l__isGearEquipped__31);
                    u26(l__BuyButton__24.TextDisplay.TextLabel.TextLabel, not l__isGearEquipped__31);
                    if v43 then
                        v43.Visible = false;
                    end;
                    l__ToggleRobux__25.Visible = false;
                else
                    l__BuyButton__24.TextDisplay.TextLabel.Text = v42.costText;
                    l__BuyButton__24.TextDisplay.TextLabel.TextLabel.Text = v42.costText;
                    local v45 = u33[l__Name__29];
                    local v46;
                    if v45 and u1 then
                        v46 = (u1.Data.Sheckles or 0) >= v45.price;
                    else
                        v46 = false;
                    end;
                    u26(l__BuyButton__24, v46);
                    u26(l__BuyButton__24.TextDisplay.TextLabel.TextLabel, v46);
                    if v43 then
                        v43.Visible = true;
                    end;
                    l__ToggleRobux__25.Visible = v42.devProductKey ~= nil;
                end;
            else
                local v47 = l__Text__28 ~= "NO STOCK";
                if v42 then
                    v42 = v42.devProductKey ~= nil;
                end;
                if v47 then
                    local v48 = u33[l__Name__29];
                    if v48 and u1 then
                        v47 = (u1.Data.Sheckles or 0) >= v48.price;
                    else
                        v47 = false;
                    end;
                end;
                l__BuyButton__24.TextDisplay.TextLabel.Text = l__Text__28;
                l__BuyButton__24.TextDisplay.TextLabel.TextLabel.Text = l__Text__28;
                u26(l__BuyButton__24, v47);
                u26(l__BuyButton__24.TextDisplay.TextLabel.TextLabel, v47);
                local v49 = l__BuyButton__24.TextDisplay:FindFirstChild("ImageLabel");
                if v49 then
                    v49.Visible = true;
                end;
                l__ToggleRobux__25.Visible = v42;
            end;
        end;
        local function u62(p51) --[[ Line: 267 ]]
            -- upvalues: u33 (copy), u31 (copy), u26 (ref), u1 (ref), u35 (ref), u50 (copy), u32 (copy)
            local v52 = u33[p51];
            if v52 then
                if v52.isEquippable then
                    local l__ownsEquippableGear__32 = u31.ownsEquippableGear;
                    if l__ownsEquippableGear__32 then
                        l__ownsEquippableGear__32 = u31.ownsEquippableGear(p51);
                    end;
                    local l__isGearEquipped__33 = u31.isGearEquipped;
                    if l__isGearEquipped__33 then
                        l__isGearEquipped__33 = u31.isGearEquipped(p51);
                    end;
                    if l__ownsEquippableGear__32 then
                        v52.mainFrame.Cost_Text.Text = "OWNED";
                        v52.mainFrame.Cost_Text.TextLabel.Text = "OWNED";
                        local v53 = v52.mainFrame.Cost_Text.TextLabel:FindFirstChild("NoStock");
                        local v54 = v52.mainFrame.Cost_Text.TextLabel:FindFirstChildWhichIsA("UIGradient");
                        if v53 then
                            v53.Enabled = not l__isGearEquipped__33;
                        end;
                        if v54 then
                            v54.Enabled = l__isGearEquipped__33;
                        end;
                        v52.mainFrame.Stock_Text.Text = l__isGearEquipped__33 and "Equipped" or "Unequipped";
                        local l__Stock_Text__34 = v52.mainFrame.Stock_Text;
                        local v55;
                        if l__isGearEquipped__33 then
                            v55 = Color3.new(0, 0.7, 0);
                        else
                            v55 = Color3.new(0.7, 0, 0);
                        end;
                        l__Stock_Text__34.TextColor3 = v55;
                    else
                        v52.mainFrame.Cost_Text.Text = v52.costText;
                        v52.mainFrame.Cost_Text.TextLabel.Text = v52.costText;
                        v52.mainFrame.Stock_Text.Text = "Not Owned";
                        local v56 = u26;
                        local l__TextLabel__35 = v52.mainFrame.Cost_Text.TextLabel;
                        local v57 = u33[p51];
                        local v58;
                        if v57 and u1 then
                            v58 = (u1.Data.Sheckles or 0) >= v57.price;
                        else
                            v58 = false;
                        end;
                        v56(l__TextLabel__35, v58);
                    end;
                    if u35 and u35.Name == p51 then
                        u50(v52.mainFrame);
                    end;
                else
                    local v59 = u33[p51];
                    local v60 = not v59 and 0 or math.max((u32[p51] ~= nil and u32[p51] or v59.maxStock) - (u1 and (u1.Data.PurchasedThisRestock and u1.Data.PurchasedThisRestock[u31.purchasedRestockKey]) and (u1.Data.PurchasedThisRestock[u31.purchasedRestockKey][p51] or 0) or 0), 0);
                    local v61 = v60 >= 1;
                    v52.mainFrame.Cost_Text.Text = not v61 and "NO STOCK" or v52.costText;
                    v52.mainFrame.Cost_Text.TextLabel.Text = not v61 and "NO STOCK" or v52.costText;
                    v52.mainFrame.Stock_Text.Text = "x" .. tostring(v60) .. " in Stock";
                    u26(v52.mainFrame.Cost_Text.TextLabel, v61);
                    if u35 and u35.Name == p51 then
                        u50(v52.mainFrame);
                    end;
                end;
            end;
        end;
        local u63 = u35;
        local u64 = {};
        local u65 = false;
        for v66, v67 in ipairs(u31.items) do
            local u68 = u31.getItemName(v67);
            local v69;
            if u31.getDisplayName then
                v69 = u31.getDisplayName(v67);
            else
                v69 = u68;
            end;
            local v70 = u31.getItemImage(v67);
            local v71 = u31.getItemCost(v67);
            local v72;
            if u31.priceOverrides then
                v72 = u31.priceOverrides:Get()[u68];
                if type(v72) ~= "number" or v72 < 0 then
                    v72 = v71;
                end;
            else
                v72 = v71;
            end;
            local v73;
            if u31.getItemRarity then
                v73 = u31.getItemRarity(v67);
            else
                v73 = nil;
            end;
            if not u31.requireRarity or v73 ~= nil then
                local v74 = l__ItemTemplate__21:Clone();
                v74.Name = u68;
                v74.LayoutOrder = v66 * 3;
                v74.Visible = true;
                v74.Parent = l__scrollingFrame__20;
                local v75 = v74.Main_Frame:FindFirstChild("Odds");
                if v75 then
                    v75.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 346 ]]
                        -- upvalues: l__GuiController__13 (ref), l__CrateName__17 (ref), u68 (copy)
                        l__GuiController__13:Open("Odds", nil, { "HUD" });
                        l__CrateName__17.Value = u68;
                    end);
                end;
                local l__Main_Frame__36 = v74.Main_Frame;
                l__Main_Frame__36.Seed_Text.Text = v69;
                l__Main_Frame__36.Seed_Text.TextLabel.Text = v69;
                if v70 then
                    l__Main_Frame__36.ImageDisplay.Vector.Image = v70;
                end;
                local l__Rarity__37 = l__Main_Frame__36.Rarity;
                for _, v76 in l__Rarity__37:GetChildren() do
                    if v76:IsA("UIGradient") then
                        v76:Destroy();
                    end;
                end;
                if v73 then
                    local v77 = l__Gradients__12:FindFirstChild(v73);
                    if v77 then
                        local v78 = v77:Clone();
                        v78.Parent = l__Rarity__37;
                        if v77.Name == "Super" or v77.Name == "Secret" then
                            v78:AddTag("InfiniteGradient");
                        end;
                    end;
                    l__Rarity__37.Rarity_Text.Text = v73;
                    l__Rarity__37.Rarity_Text.TextLabel.Text = v73;
                end;
                local v79 = l__NumberUtils__6.Abbreviate(v72) .. "¢";
                local v80 = u31.stockItems:FindFirstChild(u68);
                local u81;
                if u31.getRequiredGroupId then
                    u81 = u31.getRequiredGroupId(v67);
                else
                    u81 = nil;
                end;
                local v82 = {
                    frame = v74,
                    mainFrame = l__Main_Frame__36,
                    costText = v79,
                    price = v72,
                    baseCost = v71,
                    maxStock = v80 and v80.Value or 0,
                    devProductKey = `{u31.devProductPrefix}:{u68}:1`
                };
                local v83;
                if u31.isEquippableGear then
                    v83 = u31.isEquippableGear(v67);
                else
                    v83 = false;
                end;
                v82.isEquippable = v83;
                v82.requiredGroupId = u81;
                u33[u68] = v82;
                local v84 = l__Main_Frame__36:FindFirstChild("Like_Group");
                if v84 then
                    local v85;
                    if u81 then
                        local v86, v87 = pcall(function() --[[ Line: 401 ]]
                            -- upvalues: l__LocalPlayer__4 (ref), u81 (copy)
                            return l__LocalPlayer__4:IsInGroup(u81);
                        end);
                        v85 = not (v86 and v87);
                    else
                        v85 = false;
                    end;
                    v84.Visible = v85;
                end;
                u62(u68);
                table.insert(v34, v74);
            end;
        end;
        if u31.priceOverrides then
            local function v91() --[[ Line: 417 ]]
                -- upvalues: u33 (copy), u31 (copy), l__NumberUtils__6 (ref), u64 (copy), u62 (copy)
                for u88, v89 in pairs(u33) do
                    local l__baseCost__38 = v89.baseCost;
                    if u31.priceOverrides then
                        local v90 = u31.priceOverrides:Get()[u88];
                        if type(v90) == "number" and v90 >= 0 then
                            l__baseCost__38 = v90;
                        end;
                    end;
                    v89.price = l__baseCost__38;
                    v89.costText = l__NumberUtils__6.Abbreviate(l__baseCost__38) .. "¢";
                    if not u64[u88] then
                        u64[u88] = true;
                        task.defer(function() --[[ Line: 318 ]]
                            -- upvalues: u64 (ref), u88 (copy), u62 (ref)
                            u64[u88] = nil;
                            u62(u88);
                        end);
                    end;
                end;
            end;
            u31.priceOverrides.Changed:Connect(v91);
            u31.priceOverrides.Loaded:Connect(v91);
        end;
        if u1 then
            u1:OnChange(function(_, p92) --[[ Line: 431 ]]
                -- upvalues: u31 (copy), u64 (copy), u62 (copy), u33 (copy), u63 (ref), u50 (copy)
                if p92 and (p92[1] == "PurchasedThisRestock" and p92[2] == u31.purchasedRestockKey) then
                    if p92[3] == nil then
                        for u93 in pairs(u33) do
                            if not u64[u93] then
                                u64[u93] = true;
                                task.defer(function() --[[ Line: 318 ]]
                                    -- upvalues: u64 (ref), u93 (copy), u62 (ref)
                                    u64[u93] = nil;
                                    u62(u93);
                                end);
                            end;
                        end;
                    else
                        local u94 = tostring(p92[3]);
                        if u64[u94] then
                        else
                            u64[u94] = true;
                            task.defer(function() --[[ Line: 318 ]]
                                -- upvalues: u64 (ref), u94 (copy), u62 (ref)
                                u64[u94] = nil;
                                u62(u94);
                            end);
                        end;
                    end;
                else
                    local v95 = p92 and (p92[1] == "Sheckles" and (u63 and u33[u63.Name]));
                    if v95 then
                        u50(v95.mainFrame);
                    end;
                end;
            end);
        end;
        for _, u96 in u31.stockItems:GetChildren() do
            local v97 = u33[u96.Name];
            if v97 then
                v97.maxStock = u96.Value;
                u62(u96.Name);
            end;
            u96:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 456 ]]
                -- upvalues: u33 (copy), u96 (copy), u64 (copy), u62 (copy)
                local v98 = u33[u96.Name];
                if v98 then
                    v98.maxStock = u96.Value;
                    local l__Name__39 = u96.Name;
                    if u64[l__Name__39] then
                        return;
                    end;
                    u64[l__Name__39] = true;
                    task.defer(function() --[[ Line: 318 ]]
                        -- upvalues: u64 (ref), l__Name__39 (copy), u62 (ref)
                        u64[l__Name__39] = nil;
                        u62(l__Name__39);
                    end);
                end;
            end);
        end;
        u31.stockItems.ChildAdded:Connect(function(u99) --[[ Line: 477 ]]
            -- upvalues: u33 (copy), u64 (copy), u62 (copy)
            local v100 = u33[u99.Name];
            if v100 then
                v100.maxStock = u99.Value;
                local l__Name__40 = u99.Name;
                if not u64[l__Name__40] then
                    u64[l__Name__40] = true;
                    task.defer(function() --[[ Line: 318 ]]
                        -- upvalues: u64 (ref), l__Name__40 (copy), u62 (ref)
                        u64[l__Name__40] = nil;
                        u62(l__Name__40);
                    end);
                end;
            end;
            u99:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 456 ]]
                -- upvalues: u33 (ref), u99 (copy), u64 (ref), u62 (ref)
                local v101 = u33[u99.Name];
                if v101 then
                    v101.maxStock = u99.Value;
                    local l__Name__41 = u99.Name;
                    if u64[l__Name__41] then
                        return;
                    end;
                    u64[l__Name__41] = true;
                    task.defer(function() --[[ Line: 318 ]]
                        -- upvalues: u64 (ref), l__Name__41 (copy), u62 (ref)
                        u64[l__Name__41] = nil;
                        u62(l__Name__41);
                    end);
                end;
            end);
        end);
        if u31.personalRestockEvent then
            u31.personalRestockEvent.OnClientEvent:Connect(function(p102) --[[ Line: 488 ]]
                -- upvalues: u32 (copy), u33 (copy), u64 (copy), u62 (copy)
                table.clear(u32);
                for v103, v104 in pairs(p102) do
                    u32[v103] = v104;
                end;
                for u105 in pairs(u33) do
                    if not u64[u105] then
                        u64[u105] = true;
                        task.defer(function() --[[ Line: 318 ]]
                            -- upvalues: u64 (ref), u105 (copy), u62 (ref)
                            u64[u105] = nil;
                            u62(u105);
                        end);
                    end;
                end;
            end);
        end;
        local u106 = {};
        for _, v107 in v34 do
            table.insert(u106, v107);
        end;
        table.sort(u106, function(p108, p109) --[[ Line: 506 ]]
            return p108.LayoutOrder < p109.LayoutOrder;
        end);
        for _, u110 in v34 do
            u110.Main_Frame.TextButton.Activated:Connect(function() --[[ Line: 511 ]]
                -- upvalues: u63 (ref), u110 (copy), l__Sheckles_Shelf__22 (copy), l__Robux_Shelf__23 (copy), u50 (copy), u106 (copy), l__TweenService__2 (ref), l__scrollingFrame__20 (copy), u4 (ref)
                if u63 == u110 then
                    l__Sheckles_Shelf__22.Visible = false;
                    l__Robux_Shelf__23.Visible = false;
                    u63 = nil;
                    return;
                end;
                l__Sheckles_Shelf__22.Visible = true;
                l__Robux_Shelf__23.Visible = false;
                l__Sheckles_Shelf__22.LayoutOrder = u110.LayoutOrder + 1;
                l__Robux_Shelf__23.LayoutOrder = u110.LayoutOrder + 1;
                u63 = u110;
                u50(u110.Main_Frame);
                local v111 = 1;
                for v112, v113 in ipairs(u106) do
                    if v113 == u110 then
                        v111 = v112;
                        break;
                    end;
                end;
                local v114 = l__TweenService__2:Create(l__scrollingFrame__20, u4, {
                    CanvasPosition = Vector2.new(0, u110.AbsoluteSize.Y * (v111 - 1))
                });
                v114:Play();
                game.Debris:AddItem(v114, u4.Time);
            end);
        end;
        l__ToggleRobux__25.MouseButton1Click:Connect(function() --[[ Line: 541 ]]
            -- upvalues: u40 (copy)
            if workspace:GetAttribute("InTutorial") then
            else
                u40();
            end;
        end);
        l__ToggleSheckles__26.MouseButton1Click:Connect(function() --[[ Line: 546 ]]
            -- upvalues: l__Sheckles_Shelf__22 (copy), l__Robux_Shelf__23 (copy)
            l__Sheckles_Shelf__22.Visible = true;
            l__Robux_Shelf__23.Visible = false;
        end);
        local u115 = false;
        local function u133() --[[ Line: 575 ]]
            -- upvalues: u65 (ref), u63 (ref), u33 (copy), l__LocalPlayer__4 (ref), l__NotificationController__11 (ref), l__GreenbeanCheck__15 (ref), l__GreenbeanAvatarController__14 (ref), u31 (copy), u1 (ref), u30 (ref), l__BuyButton__24 (copy), l__SfxController__10 (ref), u32 (copy)
            if u65 then
            elseif u63 then
                local l__Name__42 = u63.Name;
                local v116 = u33[l__Name__42];
                local u117 = u33[l__Name__42];
                local v118;
                if u117 and u117.requiredGroupId then
                    local v119, v120 = pcall(function() --[[ Line: 553 ]]
                        -- upvalues: l__LocalPlayer__4 (ref), u117 (copy)
                        return l__LocalPlayer__4:IsInGroup(u117.requiredGroupId);
                    end);
                    if v119 and v120 then
                        v118 = true;
                    else
                        l__NotificationController__11:CreateNotification("Join Group + Like👍");
                        v118 = false;
                    end;
                else
                    v118 = true;
                end;
                if v118 then
                    local v121;
                    if l__Name__42 == "Green Bean" and not l__GreenbeanCheck__15.IsCharacterGreenbean(l__LocalPlayer__4.Character) then
                        l__NotificationController__11:CreateNotification("Equip the Green Bean avatar to buy this seed!");
                        l__GreenbeanAvatarController__14:Prompt();
                        v121 = false;
                    else
                        v121 = true;
                    end;
                    if v121 then
                        if v116 and v116.isEquippable then
                            local l__ownsEquippableGear__43 = u31.ownsEquippableGear;
                            if l__ownsEquippableGear__43 then
                                l__ownsEquippableGear__43 = u31.ownsEquippableGear(l__Name__42);
                            end;
                            if l__ownsEquippableGear__43 then
                                u30(l__BuyButton__24);
                                u65 = true;
                                local l__isGearEquipped__44 = u31.isGearEquipped;
                                if l__isGearEquipped__44 then
                                    l__isGearEquipped__44 = u31.isGearEquipped(l__Name__42);
                                end;
                                pcall(function() --[[ Line: 607 ]]
                                    -- upvalues: l__isGearEquipped__44 (copy), l__NotificationController__11 (ref), l__Name__42 (copy), l__SfxController__10 (ref)
                                    if l__isGearEquipped__44 then
                                        l__NotificationController__11:CreateNotification(l__Name__42 .. " Unequipped");
                                        l__SfxController__10:PlaySFX("ItemUnequip");
                                    else
                                        l__NotificationController__11:CreateNotification(l__Name__42 .. " Equipped");
                                        l__SfxController__10:PlaySFX("ItemEquip");
                                    end;
                                end);
                                local v122, v123 = pcall(function() --[[ Line: 617 ]]
                                    -- upvalues: l__isGearEquipped__44 (copy), u31 (ref), l__Name__42 (copy)
                                    if l__isGearEquipped__44 then
                                        u31.unequipGearEvent:Fire();
                                    else
                                        u31.equipGearEvent:Fire(l__Name__42);
                                    end;
                                end);
                                if not v122 then
                                    warn((`[RestockStoreController] Gear {l__isGearEquipped__44 and "unequip" or "equip"} fire failed ({l__Name__42}): {v123}`));
                                end;
                                task.wait();
                                u65 = false;
                            else
                                local v124 = u33[l__Name__42];
                                local v125;
                                if v124 and u1 then
                                    v125 = (u1.Data.Sheckles or 0) >= v124.price;
                                else
                                    v125 = false;
                                end;
                                if v125 then
                                    u30(l__BuyButton__24);
                                    u65 = true;
                                    local v126, v127 = pcall(function() --[[ Line: 592 ]]
                                        -- upvalues: u31 (ref), l__Name__42 (copy)
                                        u31.purchaseEvent:Fire(l__Name__42);
                                    end);
                                    if not v126 then
                                        warn((`[RestockStoreController] Purchase fire failed ({l__Name__42}): {v127}`));
                                    end;
                                    task.wait();
                                    u65 = false;
                                end;
                            end;
                        else
                            local v128 = u33[l__Name__42];
                            if (not v128 and 0 or math.max((u32[l__Name__42] ~= nil and u32[l__Name__42] or v128.maxStock) - (u1 and (u1.Data.PurchasedThisRestock and u1.Data.PurchasedThisRestock[u31.purchasedRestockKey]) and (u1.Data.PurchasedThisRestock[u31.purchasedRestockKey][l__Name__42] or 0) or 0), 0)) < 1 then
                            else
                                local v129 = u33[l__Name__42];
                                local v130;
                                if v129 and u1 then
                                    v130 = (u1.Data.Sheckles or 0) >= v129.price;
                                else
                                    v130 = false;
                                end;
                                if v130 then
                                    u30(l__BuyButton__24);
                                    u65 = true;
                                    local v131, v132 = pcall(function() --[[ Line: 640 ]]
                                        -- upvalues: u31 (ref), l__Name__42 (copy)
                                        u31.purchaseEvent:Fire(l__Name__42);
                                    end);
                                    if not v131 then
                                        warn((`[RestockStoreController] Purchase fire failed ({l__Name__42}): {v132}`));
                                    end;
                                    task.wait();
                                    u65 = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        local u134 = false;
        local u135 = 0;
        l__WatchButtonHold__16(l__BuyButton__24, function(p136, p137) --[[ Line: 657 ]]
            -- upvalues: u135 (ref), u134 (ref), u115 (ref), u133 (copy)
            if p137 then
                u135 = 0;
                if u134 then
                    u134 = false;
                end;
            else
                if not u134 then
                    u134 = true;
                end;
                if os.clock() < u135 then
                else
                    local v138 = ((1 - math.exp(p136 * -0.3)) * 24 + 8) // 1;
                    local v139 = math.max(v138, 1);
                    u135 = os.clock() + 0.125;
                    for _ = 1, v139 do
                        u115 = true;
                        u133();
                    end;
                end;
            end;
        end, {
            minimumHoldTime = 1,
            interval = 0.125
        });
        l__BuyButton__24.Activated:Connect(function() --[[ Line: 686 ]]
            -- upvalues: u115 (ref), u133 (copy)
            if u115 then
                u115 = false;
            else
                u133();
            end;
        end);
        for u140, u141 in pairs(u6) do
            local u142 = l__Buttons__27:FindFirstChild(u140);
            if u142 then
                local u143 = string.find(u140, "Gift") ~= nil;
                u142.Activated:Connect(function() --[[ Line: 703 ]]
                    -- upvalues: u65 (ref), u63 (ref), u33 (copy), u31 (copy), l__LocalPlayer__4 (ref), l__NotificationController__11 (ref), l__GreenbeanCheck__15 (ref), l__GreenbeanAvatarController__14 (ref), u141 (copy), u143 (copy), u21 (ref), l__DevProductController__9 (ref)
                    if workspace:GetAttribute("InTutorial") then
                    elseif u65 then
                    elseif u63 then
                        local l__Name__45 = u63.Name;
                        local v144 = u33[l__Name__45];
                        if v144 and v144.isEquippable then
                            local l__ownsEquippableGear__46 = u31.ownsEquippableGear;
                            if l__ownsEquippableGear__46 then
                                l__ownsEquippableGear__46 = u31.ownsEquippableGear(l__Name__45);
                            end;
                            if l__ownsEquippableGear__46 then
                                return;
                            end;
                        end;
                        local u145 = u33[l__Name__45];
                        local v146;
                        if u145 and u145.requiredGroupId then
                            local v147, v148 = pcall(function() --[[ Line: 553 ]]
                                -- upvalues: l__LocalPlayer__4 (ref), u145 (copy)
                                return l__LocalPlayer__4:IsInGroup(u145.requiredGroupId);
                            end);
                            if v147 and v148 then
                                v146 = true;
                            else
                                l__NotificationController__11:CreateNotification("Join Group + Like👍");
                                v146 = false;
                            end;
                        else
                            v146 = true;
                        end;
                        if v146 then
                            local v149;
                            if l__Name__45 == "Green Bean" and not l__GreenbeanCheck__15.IsCharacterGreenbean(l__LocalPlayer__4.Character) then
                                l__NotificationController__11:CreateNotification("Equip the Green Bean avatar to buy this seed!");
                                l__GreenbeanAvatarController__14:Prompt();
                                v149 = false;
                            else
                                v149 = true;
                            end;
                            if v149 then
                                local u150 = `{u31.devProductPrefix}:{l__Name__45}:{u141}`;
                                u65 = true;
                                local v151, v152 = pcall(function() --[[ Line: 723 ]]
                                    -- upvalues: u143 (ref), u21 (ref), u150 (copy), l__DevProductController__9 (ref)
                                    if u143 then
                                        u21(u150);
                                    else
                                        l__DevProductController__9:PromptPurchase(u150);
                                    end;
                                end);
                                if not v151 then
                                    warn((`[RestockStoreController] Robux purchase flow failed ({u150}): {v152}`));
                                end;
                                task.wait();
                                u65 = false;
                            end;
                        end;
                    end;
                end);
                if not u143 then
                    u142.MouseEnter:Connect(function() --[[ Line: 738 ]]
                        -- upvalues: u63 (ref), l__DevProductController__9 (ref), u31 (copy), u141 (copy), u142 (copy), l__NumberUtils__6 (ref)
                        if u63 then
                            local v153 = l__DevProductController__9:WaitForPreloadedProductInfo((`{u31.devProductPrefix}:{u63.Name}:{u141}`));
                            if v153 then
                                u142.TextDisplay.TextLabel.Text = `{l__NumberUtils__6.FormatWithCommas(v153.PriceInRobux)}`;
                                u142.TextDisplay.TextLabel.TextLabel.Text = u142.TextDisplay.TextLabel.Text;
                            end;
                        end;
                    end);
                    u142.MouseLeave:Connect(function() --[[ Line: 746 ]]
                        -- upvalues: u140 (copy), u63 (ref), u33 (copy), u142 (copy), u141 (copy)
                        if u140 == "1Button" and u63 then
                            local v154 = u33[u63.Name];
                            if v154 and v154.isEquippable then
                                return;
                            end;
                        end;
                        u142.TextDisplay.TextLabel.Text = `x{u141}`;
                        u142.TextDisplay.TextLabel.TextLabel.Text = u142.TextDisplay.TextLabel.Text;
                    end);
                end;
            end;
        end;
        if u31.gearEquipStateEvent then
            u31.gearEquipStateEvent.OnClientEvent:Connect(function(u155, p156) --[[ Line: 761 ]]
                -- upvalues: u31 (copy), l__Robux_Shelf__23 (copy), l__Sheckles_Shelf__22 (copy), u64 (copy), u62 (copy), u63 (ref), u33 (copy), u50 (copy)
                if u31.onGearEquipStateChanged then
                    u31.onGearEquipStateChanged(u155, p156);
                end;
                if p156 and l__Robux_Shelf__23.Visible then
                    l__Sheckles_Shelf__22.Visible = true;
                    l__Robux_Shelf__23.Visible = false;
                end;
                if not u64[u155] then
                    u64[u155] = true;
                    task.defer(function() --[[ Line: 318 ]]
                        -- upvalues: u64 (ref), u155 (copy), u62 (ref)
                        u64[u155] = nil;
                        u62(u155);
                    end);
                end;
                local v157 = u63 and (u63.Name == u155 and u33[u155]);
                if v157 then
                    u50(v157.mainFrame);
                end;
            end);
        end;
    end
};